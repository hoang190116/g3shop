<%@include file="include/navbar.jsp" %>


<section style="background-color: #eee;">
    <div class="container py-4">
        <div class="row">
            <h4>Hot product
                <a href="view2/1" type="button" class="pull-right text-muted"> More ...</a>
            </h4>
            <c:forEach items="${hotList}" var="p">
                <div class="col-md-12 col-lg-3 mb-2 mb-lg-0">
                    <div class="card">
                        <!--          <div class="d-flex justify-content-between p-2">
                                    <p class="lead mb-0">Today's Combo Offer</p>
                                    <div class="bg-info rounded-circle d-flex align-items-center justify-content-center shadow-1-strong" style="width: 35px; height: 35px;">
                                      <p class="text-white mb-0 small">x4</p>
                                    </div>
                                  </div>-->

                        <div height="140" with="200">
                            <img style="height: 140px; width: 200px; object-fit: contain" src="${pageContext.request.contextPath }/img/1/${p.photos[0]}" class="card-img-top" alt="" />
                        </div>

                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 >
                                    <p class="small"> <a type= "submit" href="productView?id=${p.product_id}"class="text-dark overflow-ellipsis" data-title="${p.name}">${p.name}</a>

                                </h5>

                            </div>

                            <div class="d-flex justify-content-between ">
                                <p class="small"><a href="#!" class="text-muted">Price: </a></p>
                                
                                <p class="text-dark">$${p.price}</p>
                            </div>
                            <div class="d-flex justify-content-between ">
                                <div class="d-grid gap-2 mx-auto">
                                      <a type= "submit" href="productView?id=${p.product_id}" class="btn btn-warning btn-rounded"><i class="fa-solid fa-eye"> </i>View</a>
                                  
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="container py-4">
        <div class="row">
            <div>
                <h4>Product  <a href="view2/1" type="button" class="pull-right text-muted"> More ...</a></h4>
               
            </div>
            
            <c:forEach items="${listProduct}" var="p">
                <div class="col-md-12 col-lg-3 mb-2 mb-lg-0">
                    <div class="card">
                        <!--          <div class="d-flex justify-content-between p-2">
                                    <p class="lead mb-0">Today's Combo Offer</p>
                                    <div class="bg-info rounded-circle d-flex align-items-center justify-content-center shadow-1-strong" style="width: 35px; height: 35px;">
                                      <p class="text-white mb-0 small">x4</p>
                                    </div>
                                  </div>-->

                        <div height="140" with="200">
                            <img style="height: 140px; width: 200px; object-fit: contain" src="${pageContext.request.contextPath }/img/1/${p.photos[0]}" class="card-img-top" alt="" />
                        </div>

                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 >
                                    <p class="small"> <a type= "submit" href="productView?id=${p.product_id}" class="text-dark overflow-ellipsis" data-title="${p.name}">${p.name}</a>

                                </h5>

                            </div>

                            <div class="d-flex justify-content-between ">
                                <p class="small"><a href="#!" class="text-muted">Price: </a></p>
                                
                                <p class="text-dark ">$${p.price}</p>
                            </div>
                            <div class="d-flex justify-content-between ">
                                <div class="d-grid gap-2 mx-auto">
                                      <a type= "submit" href="productView?id=${p.product_id}" class="btn btn-warning btn-rounded"><i class="fa-solid fa-eye"> </i>View</a>
                                  
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>


        <%@include file="include/footer.jsp" %>