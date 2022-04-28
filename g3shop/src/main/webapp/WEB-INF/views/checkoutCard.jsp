<%@include file="include/navbar.jsp" %>
<link href="https://fonts.googleapis.com/css?family=Josefin+Sans|Poppins" rel="stylesheet">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <body class="bg-light">
    <div class="container">
  <div class="py-3 text-center">
  </div>
        <h4 align="center" style="margin-bottom: 30px">Choose Your Bank</h4>
        <hr />
        <form>
        <div class="row2">
            <input type="hidden" name="idP" value="${idP}" />
                <div class="col-1-of-3">
                    <div class="card2">
                        <div class="card__side card__side--front">
                            <div class="card__picture card__picture--1">
                                 
                            </div>
                            <h4 class="card__heading" style="font-size: 150%;">
                                <span class="card__heading-span card__heading-span--1">Master Card</span>

                            </h4>
                            <div class="card__details">
                                <ul>
                                    <li style="font-size: 120%;">No Tax</li>
                                    <li style="font-size: 120%;">Free Ship</li>
                                    <li style="font-size: 120%;">Easy To Pay</li>
                                </ul>
                            </div>
                        </div>
                        <div class="card__side card__side--back card__side--back-1">
                            <div class="card__cta">
                                <div class="card__price-box">
                                    <p class="card__price-only">Choose This</p>
                                    <h2 class="">Master Card  </h2>
                                </div>
                                <a href="#0" class="btn btn2 btn--white ">Pay Now <i class='fa fa-ban'></i><br /><p class="text-danger"> Comming Soon! </p></a>
                                
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-1-of-3">
                    <div class="card2">
                        <div class="card__side card__side--front">
                            <div class="card__picture card__picture--2">
                                 
                            </div>
                            <h4 class="card__heading" style="font-size: 150%;">
                                <span class="card__heading-span card__heading-span--2">Paypal</span>

                            </h4>
                            <div class="card__details">
                                <ul>
                                    <li style="font-size: 120%;">No Tax</li>
                                    <li style="font-size: 120%;">Free Ship</li>
                                    <li style="font-size: 120%;">Safty and Security</li>
                                    <li style="font-size: 120%;">Easy to pay</li>
                                    <li style="font-size: 120%;">Fast trading</li>
                                </ul>
                            </div>
                        </div>
                        <div class="card__side card__side--back card__side--back-2">
                            <div class="card__cta">
                                <div class="card__price-box">
                                    <p class="card__price-only">Choose This</p>
                                    <h2 class="">Paypal</h2>
                                </div>
                                <a href="<c:if test="${idP == null}">${pageContext.request.contextPath }/authorize_payment</c:if>
                                   <c:if test="${idP != null}">${pageContext.request.contextPath }/authorize_payment2?idP=${idP}</c:if>" class="btn btn2 btn--white">Pay Now</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-1-of-3">
                    <div class="card2">
                        <div class="card__side card__side--front">
                            <div class="card__picture card__picture--3">
                                 
                            </div>
                            <h4 class="card__heading" style="font-size: 150%;">
                                <span class="card__heading-span card__heading-span--3">Visa</span>

                            </h4>
                            <div class="card__details">
                                <ul>
                                    <li style="font-size: 120%;">No Tax</li>
                                    <li style="font-size: 120%;">Free Ship</li>
                                    <li style="font-size: 120%;">Safe Paying</li>
                                    <li style="font-size: 120%;">Do Quickly</li>
                                </ul>
                            </div>
                        </div>
                        <div class="card__side card__side--back card__side--back-3">
                            <div class="card__cta">
                                <div class="card__price-box">
                                    <p class="card__price-only">Choose This</p>
                                    <h2 class="">Visa</h2>
                                </div>
                                <a href="#" class="btn btn2 btn--white">Pay Now <i class='fa fa-ban'></i><br /><p class="text-danger"> Comming Soon! </p></a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </form>



     
            
</div>
<%@include file="include/footer.jsp" %>