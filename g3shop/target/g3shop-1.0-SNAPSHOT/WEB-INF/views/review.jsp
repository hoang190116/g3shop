<%-- 
    Document   : review
    Created on : Apr 17, 2022, 4:43:38 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Review</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <div align="center">
            <h1>Review before paying</h1>
            <form action="execute_payment" onSubmit="return alert('Thanks for using our Services')" method="post">
                <table>
                    <tr>
                        <td><b>Transaction Detail</b></td>
                        <td><input type="hidden" name="paymentId" value="${param.paymentId}"/></td>
                        <td><input type="hidden" name="PayerID" value="${param.PayerID}"/></td>
                    </tr>
                    <tr>
                        <td>Decripsion:</td>
                        <td>${tran.description}</td>
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
                    <tr><td><br /></td></tr>
                    <tr>
                        <td><b>Payer Information</b></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>First Name:</td>
                        <td>${payer.firstName}</td>
                    </tr>
                    <tr>
                        <td>Last Name:</td>
                        <td>${payer.lastName}</td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td>${payer.email}</td>
                    </tr>
                    <!-- ******************************************************************** -->
                    <tr>
                        <td><b>Shipping address</b></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Recipinent Name:</td>
                        <td>${ship.recipientName}</td>
                    </tr>
                    <tr>
                        <td>Line 1:</td>
                        <td>${ship.line1}</td>
                    </tr>
                    <tr>
                        <td>City:</td>
                        <td>${ship.city}</td>
                    </tr>
                    <tr>
                        <td>State:</td>
                        <td>${ship.state}</td>
                    </tr>
                    <tr>
                        <td>Country Code:</td>
                        <td>${ship.countryCode}</td>
                    </tr>
                    <tr>
                        <td>Postal Code:</td>
                        <td>${ship.postalCode}</td>
                    </tr>
                    <!-- ******************************************************************** -->
                    <tr>
                        <td><input type="submit" value="Pay Now" id="submitBtn" /></td>
                    </tr>
                    <script src="http://code.jquery.com/jquery-1.11.3.min.js">
                        $("#submitBtn").click(function(){
                            alert('Thank for using our services!!');
                        })
                    </script>
                </table>
            </form>
        </div>
    </body>
</html>
