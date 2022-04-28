/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.paypal;

import com.model.cart;
import com.paypal.api.payments.Address;
import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.Item;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class paymentSerices {
    private static final String CLIENT_ID = "ATgv4hRdRM5_fOpI5-o4FdOTSTNomH5BTBY51PbkM0ln3vkDJBCNgp5qOw0sXKXs5TGdaooVDNx4f34v";
    private static final String CLIENT_SECRET="EFxl3D2SIB21PS1Es3qm189XYBZAuY6siiCKp2fgo2pzqYZDKikfklzWN1uBO1wD3uT5zBUEOyANA2w7";
    private static final String MODE = "sandbox";
    
    public String authorizePayment(List<cart> list) throws PayPalRESTException{
        Payer payer = getPayerInformation();
        
        RedirectUrls redi = getRedirectURLs();
        
        List<Transaction> tL = getTransactionInformation(list);
        
        Payment requestPayment = new Payment();
        requestPayment.setTransactions(tL)
                .setRedirectUrls(redi)
                .setPayer(payer)
                .setIntent("authorize");
        
        APIContext api = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        Payment approve = requestPayment.create(api);
        
        System.out.println(approve);
        
        return getApproveLink(approve);
    }
    public String authorizePayment2(List<cart> list, int idP) throws PayPalRESTException{
        Payer payer = getPayerInformation();
        
        RedirectUrls redi = getRedirectURLs2(idP);
        
        List<Transaction> tL = getTransactionInformation(list);
        
        Payment requestPayment = new Payment();
        requestPayment.setTransactions(tL)
                .setRedirectUrls(redi)
                .setPayer(payer)
                .setIntent("authorize");
        
        APIContext api = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        Payment approve = requestPayment.create(api);
        
        System.out.println(approve);
        
        return getApproveLink(approve);
    }
    
    private String getApproveLink(Payment approve){
        List<Links> links = approve.getLinks();
        String approveLink = null;
        for (Links link : links) {
            if(link.getRel().equalsIgnoreCase("approval_url")){
                approveLink = link.getHref();
            }
        }
        return approveLink;
    }
    
    private List<Transaction> getTransactionInformation(List<cart> list){
        Details detai = new Details();
        detai.setShipping("0");
//        detai.setSubtotal(od.getSubtotal());
        detai.setTax("0");
        
        Amount am = new Amount();
        am.setCurrency("USD");
        long total = 0;
        for (cart object : list) {
            total += (object.getPrice()*object.getQuantity());
        }
        am.setTotal(String.valueOf(total));
        am.setDetails(detai);
        
        Transaction tr = new Transaction();
        tr.setAmount(am);
        tr.setDescription("G3 Shop Order");
        
        ItemList il = new ItemList();
        List<Item> items = new ArrayList<Item>();
        
        for (cart obj : list) {
            Item item = new Item();
            item.setCurrency("USD")
                .setName(obj.getName())
                .setPrice(String.valueOf(obj.getPrice()))
                .setTax("0")
                .setQuantity(String.valueOf(obj.getQuantity()));
                
            items.add(item);
        }
        
        il.setItems(items);
        tr.setItemList(il);
        
        List<Transaction> tL = new ArrayList<Transaction>();
        tL.add(tr);
        
        return tL;
    }
    
    private RedirectUrls getRedirectURLs() {
        RedirectUrls redi = new RedirectUrls();
        redi.setCancelUrl("http://localhost:8080/g3shop/myCart");
        redi.setReturnUrl("http://localhost:8080/g3shop/checkoutReview");
        return redi;
    }
    private RedirectUrls getRedirectURLs2(int idP) {
        RedirectUrls redi = new RedirectUrls();
        redi.setCancelUrl("http://localhost:8080/g3shop/myCart");
        redi.setReturnUrl("http://localhost:8080/g3shop/checkReview2?idP="+idP);
        return redi;
    }
    
    public Payment getPaymentDetails(String payID) throws PayPalRESTException{
        APIContext api = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return Payment.get(api, payID);
    }
    
    public Payment executePayment(String paymentID, String payerID) throws PayPalRESTException{
        PaymentExecution payE = new PaymentExecution();
        payE.setPayerId(payerID);
        
        Payment pay = new Payment().setId(paymentID);
        APIContext api = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return pay.execute(api, payE);
    }

    private Payer getPayerInformation() {
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");
        
        PayerInfo payInf = new PayerInfo();
        Address ad = new Address();
//        ad.setCountryCode("VN");
        
//        payInf
//                .setFirstName("Huy Hoang")
//                .setLastName("Nguyen Ba")
//                .setEmail("kenwiths999@gmail.com")
//                .setBillingAddress(ad)
//                .setSalutation("333333")
//                .setSuffix("4444444");
        
        payer.setPayerInfo(payInf);
        return payer;
    }
}
