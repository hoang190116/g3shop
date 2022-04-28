/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.dao.billDAO;
import com.dao.cartDAO;
import com.dao.productDAO;
import com.model.account;
import com.model.bill;
import com.model.cart;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;
import com.paypal.orderDetail;
import com.paypal.paymentSerices;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.Normalizer;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Admin
 */
@Controller
public class paypalController {
    @Autowired
    private cartDAO cartDao;
    @Autowired
    private billDAO billDao;
    
    @RequestMapping("/paypal")
    public ModelAndView paypal(HttpServletRequest rq) throws UnsupportedEncodingException{
        loginController loginC = new loginController();
        account a = loginC.checkCookie(rq);
        if(a!=null){
            return new ModelAndView("paypal");
        }
        return new ModelAndView("redirect:/index");
    }
    @RequestMapping("/test")
    public ModelAndView test(HttpServletRequest rq){
        return new ModelAndView("test");
    }
    
    @RequestMapping(value = {"/authorize_payment"})
    protected void Authorize(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loginController loginC = new loginController();
        account a = loginC.checkCookie(request);
        if(a!=null){
            List<cart> list = cartDao.list(a.getId());
            if(list != null){
            try{
                paymentSerices payS = new paymentSerices();
                String approveLink = payS.authorizePayment(list);

                response.sendRedirect(approveLink);
            }catch(Exception ex){
                ex.printStackTrace();
                request.setAttribute("errorMess", ex);
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request,response);
            }
            }else{
                response.sendRedirect("index");
            }
        }else{
            response.sendRedirect("index");
        }
    }
    @RequestMapping(value = {"/authorize_payment2"})
    protected void Authorize2(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loginController loginC = new loginController();
        account a = loginC.checkCookie(request);
        if(a!=null){
            try{
                Integer idP = Integer.parseInt(request.getParameter("idP"));
                cart c = cartDao.getProduct(idP);
                c.setQuantity(1);
                if(c != null){
                List<cart> list = new ArrayList<>();
                list.add(c);
                    paymentSerices payS = new paymentSerices();
                    String approveLink = payS.authorizePayment2(list, idP);

                    response.sendRedirect(approveLink);
                }
            }catch(PayPalRESTException ex){
                ex.printStackTrace();
                request.setAttribute("errorMess", ex);
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request,response);
            }
        }else{
            response.sendRedirect("index");
        }
    }
    
    @RequestMapping(value = {"/execute_payment"})
     protected void Execute(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "idP", required=false) Integer idP)
            throws ServletException, IOException, ParseException, PayPalRESTException {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");
        loginController loginC = new loginController();
        account a = loginC.checkCookie(request);
        if(a!=null){
            try{
                    paymentSerices payS = new paymentSerices();
                    Payment pay = payS.executePayment(paymentId, payerId);

                    PayerInfo payI = pay.getPayer().getPayerInfo();
                    Transaction tran = pay.getTransactions().get(0);
                    ShippingAddress shippingAddress = tran.getItemList().getShippingAddress();

                    bill b = new bill();
                    b.setTotal(Math.round(Float.parseFloat(tran.getAmount().getTotal())));
                    b.setPay_type("PayPal");
                    b.setPay_status("Paid");
                    b.setStatus("Waiting");
    //                String temp = Normalizer.normalize(shippingAddress.getRecipientName(), Normalizer.Form.NFD);
    //                Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
    //                b.setFname(pattern.matcher(temp).replaceAll(""));
                    b.setFname(shippingAddress.getRecipientName());
                    b.setEmail(payI.getEmail());
                    b.setCountry(shippingAddress.getCountryCode());

    //                temp = Normalizer.normalize(shippingAddress.getState(), Normalizer.Form.NFD);
    //                pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
    //                String temp2 = Normalizer.normalize(shippingAddress.getCity(), Normalizer.Form.NFD);
    //                String temp3 = Normalizer.normalize(shippingAddress.getLine1(), Normalizer.Form.NFD);
                    b.setAddress(shippingAddress.getState()+", "+shippingAddress.getCity()+", "+shippingAddress.getLine1());
                    b.setPostalCode(shippingAddress.getPostalCode());

                    String date2 = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
                    Date date = new SimpleDateFormat("yyyyMMddHHmmss").parse(date2);

                    b.setDate(date);

    //                request.setAttribute("payer", payI);
    //                request.setAttribute("tran", tran);

    //                request.getRequestDispatcher("WEB-INF/views/receipt.jsp").forward(request, response);
                    
                if(idP != null){
                    if(idP > 0){
                        billDao.save_cashNew(b, a.getId(), idP);
                    }
                }else{
                    billDao.save_cash(b, a.getId());
                }
                
                response.sendRedirect("myBill");
                
            }catch(Exception ex){
                ex.printStackTrace();
                request.setAttribute("errorMess", "Could Not Execute Payment");
                request.getRequestDispatcher("WEB-INF/views/error.jsp").forward(request,response);
            }
        }else{
            response.sendRedirect("index");
        }
    }
     
//    @RequestMapping(value = {"/review_payment"})
//    protected void Review(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String payID = request.getParameter("paymentId");
//        String payerID = request.getParameter("PayerID");
//        loginController loginC = new loginController();
//        account a = loginC.checkCookie(request);
//        if(a!=null){
//            try{
//                paymentSerices payS = new paymentSerices();
//                Payment pay = payS.getPaymentDetails(payID);
//
//                PayerInfo payI = pay.getPayer().getPayerInfo();
//                Transaction tran = pay.getTransactions().get(0);
//                ShippingAddress shippingAddress = tran.getItemList().getShippingAddress();
//
//                request.setAttribute("payer", payI);
//                request.setAttribute("tran", tran);
//                request.setAttribute("ship", shippingAddress);
//
//                String url = "review.jsp?paymentId="+payID+"&PayerID="+payerID;
//                request.getRequestDispatcher("WEB-INF/views/"+url).forward(request, response);
//
//            }catch(PayPalRESTException ex){
//                ex.printStackTrace();
//                request.setAttribute("errorMess", "Could Not get Payment");
//                request.getRequestDispatcher("WEB-INF/views/error.jsp").forward(request,response);
//            }
//        }else{
//            response.sendRedirect("index");
//        }
//    }
    
    @RequestMapping(value = {"/checkoutReview"})
    protected void CheckoutReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String payID = request.getParameter("paymentId");
        String payerID = request.getParameter("PayerID");
        loginController loginC = new loginController();
        account a = loginC.checkCookie(request);
        if(a!=null){
            try{
                request.setAttribute("numberCart", cartDao.getCountCart(a.getId()));
                List<cart> list = cartDao.list(a.getId());
                if(list != null){
                    request.setAttribute("cartList", list);
                }
                boolean login = true;
                request.setAttribute("login", login);
                login = false;
                
                paymentSerices payS = new paymentSerices();
                Payment pay = payS.getPaymentDetails(payID);

                PayerInfo payI = pay.getPayer().getPayerInfo();
                Transaction tran = pay.getTransactions().get(0);
                ShippingAddress shippingAddress = tran.getItemList().getShippingAddress();
                
                
                request.setAttribute("payer", payI);
                request.setAttribute("tran", tran);
                request.setAttribute("ship", shippingAddress);

                String url = "checkoutReview.jsp?paymentId="+payID+"&PayerID="+payerID;
                request.getRequestDispatcher("WEB-INF/views/"+url).forward(request, response);

            }catch(Exception ex){
                ex.printStackTrace();
                request.setAttribute("errorMess", "Could Not get Payment");
                request.getRequestDispatcher("WEB-INF/views/error.jsp").forward(request,response);
            }
        }else{
            response.sendRedirect("index");
        }
    }
    @RequestMapping(value = {"/checkReview2"})
    protected void CheckoutReview2(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String payID = request.getParameter("paymentId");
        String payerID = request.getParameter("PayerID");
        loginController loginC = new loginController();
        account a = loginC.checkCookie(request);
        if(a!=null){
            try{
                Integer idP = Integer.parseInt(request.getParameter("idP"));
                request.setAttribute("numberCart", cartDao.getCountCart(a.getId()));
                cart c = cartDao.getProduct(idP);
                List<cart> list = new ArrayList<>();
                list.add(c);
                if(!c.getName().isEmpty()){
                    request.setAttribute("cartList", list);
                }else{
                    response.sendRedirect("index");
                }
                boolean login = true;
                request.setAttribute("login", login);
                login = false;
                
                paymentSerices payS = new paymentSerices();
                Payment pay = payS.getPaymentDetails(payID);

                PayerInfo payI = pay.getPayer().getPayerInfo();
                Transaction tran = pay.getTransactions().get(0);
                ShippingAddress shippingAddress = tran.getItemList().getShippingAddress();
                
                
                request.setAttribute("payer", payI);
                request.setAttribute("tran", tran);
                request.setAttribute("ship", shippingAddress);
                request.setAttribute("idP", idP);

                String url = "checkoutReview.jsp?paymentId="+payID+"&PayerID="+payerID;
                request.getRequestDispatcher("WEB-INF/views/"+url).forward(request, response);

            }catch(Exception ex){
                ex.printStackTrace();
                request.setAttribute("errorMess", "Could Not get Payment");
                request.getRequestDispatcher("WEB-INF/views/error.jsp").forward(request,response);
            }
        }else{
            response.sendRedirect("index");
        }
    }
}
