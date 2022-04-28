<%@include file="include/navbar.jsp" %>

<section style="background-color: #eee;">
    <div class="container py-4">
        <div class="row">
            <c:if test="${productList.isEmpty()}"><h3 align="center">No Product</h3></c:if>
            <c:if test="${!productList.isEmpty()}">
            <c:forEach items="${productList}" var="p">
                <div class="col-md-12 col-lg-3 mb-2 mb-lg-0">
                    <div class="card">
                        <!--          <div class="d-flex justify-content-between p-2">
                                    <p class="lead mb-0">Today's Combo Offer</p>
                                    <div class="bg-info rounded-circle d-flex align-items-center justify-content-center shadow-1-strong" style="width: 35px; height: 35px;">
                                      <p class="text-white mb-0 small">x4</p>
                                    </div>
                                  </div>-->

                        <div height="140" with="200">
                            <img style="height: 140px; width: 220px; object-fit: contain" src="${pageContext.request.contextPath }/img/1/${p.photos[0]}" class="card-img-top" alt="" />
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
        <div class="col-lg-12">
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                    <li class="page-item ">
                        <a class="page-link" href="#" >Previous</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${countP}">
                        <li class="page-item <c:if test="${currentP == i}">active</c:if>"><a class="page-link" href="${i}">${i}</a></li>
                        </c:forEach>
                    <li class="page-item">
                        <a class="page-link" href="#">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
                </c:if>
    </div>

</section>


<%@include file="include/footer.jsp" %>