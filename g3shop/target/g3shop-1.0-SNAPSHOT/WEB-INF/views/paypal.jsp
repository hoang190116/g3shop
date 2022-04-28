<!DOCTYPE html>
<html>
    <head>
        <title>Check Out</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <div align="center">
            <h1>Check out</h1>
            <form action="authorize_payment" method="post">
                <table>
                    <tr>
                        <td>Product Service:</td>
                        <td><input type="text" name="product" value="iphone" /></td>
                    </tr>
                    <tr>
                        <td>Sub total:</td>
                        <td><input type="text" name="subtotal" value="100" /></td>
                    </tr>
                    <tr>
                        <td>Shipping:</td>
                        <td><input type="text" name="shipping" value="10" /></td>
                    </tr>
                    <tr>
                        <td>Tax:</td>
                        <td><input type="text" name="tax" value="10" /></td>
                    </tr>
                    <tr>
                        <td>Total:</td>
                        <td><input type="text" name="total" value="120" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="checkout" /></td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>
