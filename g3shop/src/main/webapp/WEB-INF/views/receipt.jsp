<%-- 
    Document   : review
    Created on : Apr 17, 2022, 4:43:38 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Payment Receipt</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <div align="center">
            <h1>Payment Done</h1>
                <table>
                    <tr>
                        <td>Merchant:</td>
                        <td>Company: G3SHOP</td>
                    </tr>
                    <tr>
                        <td>Payer:</td>
                        <td>${payer.firstName} ${payer.lastName}</td>
                    </tr>
                    <tr>
                        <td>Subtotal:</td>
                        <td>${tran.amount.details.subtotal}</td>
                    </tr>
                    <tr>
                        <td>Shipping:</td>
                        <td>${tran.amount.details.shipping}</td>
                    </tr>
                    <tr>
                        <td>Tax:</td>
                        <td>${tran.amount.details.tax}</td>
                    </tr>
                    <tr>
                        <td>Total:</td>
                        <td>${tran.amount.total}</td>
                    </tr>
                    <!-- ******************************************************************** -->
                    
                </table>
        </div>
    </body>
</html>
