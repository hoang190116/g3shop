<%@include file="include/navbar.jsp" %>
<style>
    input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
input[type=number] {
  -moz-appearance: textfield;
}
</style>
<div class="container-xl px-4 mt-4">
    <div class="row">
        <div class="col-xl-4">
            <!-- Profile picture card-->
            <div class="card mb-4 mb-xl-0">
                <div class="card-header">Profile Infomation</div>
                <div class="card-body text-center">
                    <div class="row mb-4">
                        <a href="${pageContext.request.contextPath }/myProfile" class="btn btn-lg btn-info  btn-block p-4 mb-4" type="button"><i class="fas fa-user" aria-hidden="true"></i> Profile</a>
                        <a href="${pageContext.request.contextPath }/myBill" class="btn btn-lg btn-info  btn-block p-4 mb-4" type="button"><i class="fa fa-shopping-cart" aria-hidden="true"></i> My bill</a>
                        <a href="${pageContext.request.contextPath }/myPayment" class="btn btn-lg btn-info  btn-block p-4 mb-4" type="button"><i class="fa fa-credit-card" aria-hidden="true"></i> Payment</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-8">
            <!-- Account details card-->
            <div class="card mb-4">
                <div class="card-header">Account Details</div>
                <div class="card-body">
                    <form:form action="saveInfor" method="post" modelAttribute="user">
                        <!-- Form Group (username)-->
                        <div class="mb-3">
                            <label class="small mb-1" for="inputUsername">Full Name</label>
                            <form:input class="form-control" id="inputUsername" type="text" placeholder="Enter your full name" path="fname" required="a"/>
                        </div>
                        <!-- Form Row-->
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (first name)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="userName">User Name</label>
                                <form:input class="form-control" id="writeName" type="text" placeholder="Account user name" path="uname" required="a" onkeypress="return event.charCode != 32"/>
                            </div>
                            <!-- Form Group (last name)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="userPass">Password</label>
                                <form:input type="password" class="form-control" id="writePass" placeholder="**************" path="pass" onkeypress="return event.charCode != 32"/>
                            </div>
                        </div>
                        <!-- Form Row        -->
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (organization name)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="dateOfBird">Date of bird</label>
                                <form:input class="form-control" id="dateOfBird" type="date" path="date_of_bird" required="a"/>
                            </div>
                            <!-- Form Group (location)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="phoneInput">Phone</label>
                                <form:input class="form-control" id="phoneInput" type="number" maxlength="20" path="phone" required="a"/>
                            </div>
                        </div>
                        <!-- Form Group (email address)-->
                        <div class="mb-3">
                            <label class="small mb-1" for="inputEmailAddress">Email address</label>
                            <form:input class="form-control" id="inputEmailAddress" type="email" placeholder="Enter your email address" path="email" required="a"/>
                        </div>
                        <span id="result2" style="color: green;" class=""></span>
                        <span id="result" style="color: red" class=""></span>
                        <span id="result3" style="color: red" class=""></span>
                        <span id="result4" style="color: green;" class=""></span>
                        <!-- Save changes button-->
                        <div id="button-submit">
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
        <script>
                            $(document).ready(function(){
                                var pass = true;
                                var username = true;
                                $('#writePass').change(function(){
                                   var name = $('#writePass').val();
                                   if(name){
                                        $.ajax({
                                            type:'POST',
                                            data:{writePass:name},
                                            url:'${pageContext.request.contextPath }/passwordCheck',
                                            success:function(result){
                                                if(result == 1){
                                                    $('#result4').html("");
                                                    $('#result3').html("<span class='d-flex flex-row align-items-center mb-4'>Password must be atleast 8 character, and should contain special character, upercase and lowercase chacter, and number </span>");
                                                    deniButton();
                                                    pass = false;
                                                }else{
                                                    $('#result3').html("");
                                                    $('#result4').html("<span class='d-flex flex-row align-items-center mb-4'>Available Password!</span>");
                                                    pass = true;
                                                    allowButton(pass, username);
                                                }
                                            }
                                        });
                                    }else{
                                        pass = true;
                                        $('#result3').html("");
                                        $('#result4').html("");
                                        allowButton(pass, username);
                                    }
                                });
                                $('#writeName').change(function(){
                                   var name = $('#writeName').val();
                                   if(name){
                                       if(name === "${username}"){
                                           $('#result2').html("");
                                           $('#result').html("");
                                           username = true;
                                           allowButton(pass, username);
                                        }else{
                                            $.ajax({
                                            type:'POST',
                                            data:{writeName:name},
                                            url:'${pageContext.request.contextPath }/usernameCheck',
                                            success:function(result){
                                                if(result == 1){
                                                    $('#result2').html("");
                                                    $('#result').html("<span class='d-flex flex-row align-items-center mb-4'>This User Name Already Existed!!!</span>");
                                                    deniButton();
                                                    username = false;
                                                }else{
                                                    $('#result').html("");
                                                    $('#result2').html("<span class='d-flex flex-row align-items-center mb-4'>Available User Name!</span>");
                                                    username = true;
                                                        allowButton(pass, username);
                                                }
                                            }
                                            });
                                        }
                                    }else{
                                        $('#result2').html("");
                                        $('#result').html("<span class='d-flex flex-row align-items-center mb-4'>Empty Username!!</span>");
                                        username = false;
                                        deniButton();
                                    }
                                }); 
                            });
                            
                allowButton(true,true);
                function deniButton(){
                
                //            var cartArray = listCart();
                   var output="";
                //            for(var i in cartArray){
                    output += "<p id='deniButton' class='btn btn-info'> Save </p>";
                //            }
                    $("#button-submit").html(output);
                };
                function allowButton(pass, username){
                //            var cartArray = listCart();
                if(pass === true && username === true){
                    var output="";
                //            for(var i in cartArray){
                    output += "<button type = 'submit' class='btn btn-info'> Save </button>";
                //            }
                    $("#button-submit").html(output);
                }else{
                    deniButton();
                }
                };
                $("#button-submit").on("click", "#deniButton",function(event){
                    alert(`There are error or empty at the Blank!!!`);
                });
    </script>
    </div>
</div>


<%@include file="include/footer.jsp" %>