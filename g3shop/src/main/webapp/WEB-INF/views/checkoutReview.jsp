<%@include file="include/navbar.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
    }

    @media (min-width: 768px) {
        .bd-placeholder-img-lg {
            font-size: 3.5rem;
        }
    }
</style>

<body class="bg-light">
    <div class="container">
        <div class="py-5 text-center">
            <h2>Review Before Paying</h2>
        </div>

        <div class="row">
            <div class="col-md-4 order-md-2 mb-4">
                <h4 class="d-flex justify-content-between align-items-center mb-3">
                    <span class="text-muted">Your cart</span>
                </h4>
                <ul class="list-group mb-3">
                    <span id="show-cart">
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Product name</h6>
                                <small class="text-muted">Brief description</small>
                            </div>
                            <span class="text-muted">$</span>
                        </li>
                    </span>
                    <li class="list-group-item d-flex justify-content-between ">
                        <span class="text-success">Total (USD)</span>
                        <strong class="text-success" id="total-price">$</strong>
                        <span id="totalHidden"></span>
                    </li>
                </ul>
                <script>
                    var cart = [];
                    var Item = function (name, price, quantity) {
                        this.name = name;
                        this.price = price;
                        this.quantity = quantity;
                    };
                    <c:forEach items="${cartList}" var="p">
                    var item = new Item("${p.name}", ${p.price}, ${p.quantity});
                    cart.push(item);
                    </c:forEach>

                    displayCart();
                    function displayCart() {
                        var cartArray = cart;
                        var total = 0;
                        var output = "";
                        for (var i in cartArray) {
                            output += "<li class='list-group-item d-flex justify-content-between lh-condensed'>"
                                    + "<div>"
                                    + "<h6 class='my-0'>" + cartArray[i].name + "</h6>"
                                    + "<small class='text-muted'>Quantity: " + cartArray[i].quantity + "</small>"
                                    + "</div>"
                                    + "<span class='text-muted'>" + cartArray[i].price * cartArray[i].quantity + "$</span>"
                                    + "</li>";
                            total = total + cartArray[i].price * cartArray[i].quantity;
                        }
                        $("#show-cart").html(output);
                        $("#total-price").html(total + "$");
                        $("#totalHidden").html("<input type='hidden' value='" + total + "' id='totalInputHidden'>");
                    };
                </script>

            </div>
            <div class="col-md-8 order-md-1">
                <form action="execute_payment" onSubmit="return alert('Thanks for using our Services')" method="post">
                    <h4 class="mb-3">Payment</h4>
                    <input type="hidden" name="paymentId" value="${param.paymentId}"/>
                    <input type="hidden" name="PayerID" value="${param.PayerID}"/>
                    <ul class="list-group mb-3">
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Description</h6>
                            </div>
                            <span class="text-muted">${tran.description}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Subtotal</h6>
                            </div>
                            <span class="text-muted"><c:if test="${tran.amount.details.subtotal != null}">$${tran.amount.details.subtotal}</c:if><c:if test="${tran.amount.details.subtotal == null}">$${tran.amount.total}</c:if></span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between lh-condensed">
                                <div>
                                    <h6 class="my-0">Shipping</h6>

                                </div>
                                    <span class="text-muted">$${tran.amount.details.shipping}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Tax</h6>

                            </div>
                            <span class="text-muted">$${tran.amount.details.tax}</span>
                        </li>

                        <li class="list-group-item d-flex justify-content-between">
                            <span>Total (USD)</span>
                            <strong>$${tran.amount.total}</strong>
                        </li>
                    </ul>
                    <h6 class="mb-3">Payer Information</h6>
                    <ul class="list-group mb-3">
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">First name</h6>
                            </div>
                            <span class="text-muted">${payer.firstName}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Last name</h6>

                            </div>
                            <span class="text-muted">${payer.lastName}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Email</h6>

                            </div>
                            <span class="text-muted">${payer.email}</span>
                        </li>
                    </ul>
                    <h6 class="mb-3">Shipping address</h6>
                    <ul class="list-group mb-3">
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Recipiment name</h6>
                            </div>
                            <span class="text-muted">${ship.recipientName}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Line 1</h6>

                            </div>
                            <span class="text-muted">${ship.line1}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">City</h6>

                            </div>
                            <span class="text-muted">${ship.city}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">State</h6>

                            </div>
                            <span class="text-muted">${ship.state}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Country code</h6>

                            </div>
                            <span class="text-muted">${ship.countryCode}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">Postal code</h6>

                            </div>
                            <span class="text-muted">${ship.postalCode}</span>
                        </li>
                    </ul>
                    <input type="hidden" value="${idP}" name="idP" />
                    <h4 class="justify-content-between align-items-center mb-3">
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-rounded">Pay now</button>
                        </div>

                    </h4>

                </form>
            </div>

        </div>
    </div>


    <%@include file="include/footer.jsp" %>