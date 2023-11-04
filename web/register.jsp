<%-- 
    Document   : register.jsp
    Created on : Mar 9, 2023, 4:37:52 PM
    Author     : toden
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="Component/header.jsp" %>
        <link rel="stylesheet" href="css/register.css">
    </head>
    <body>
        <%@include file="Component/navbar.jsp" %>
        <section class="h-100 h-custom gradient-custom-2">
            <form action="Register" method="post">
                <div class="container py-5 h-100">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col-12">
                            <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                                <div class="card-body p-0">
                                    <div class="row g-0">
                                        <div class="col-lg-6">
                                            <div class="p-5">
                                                <h3 class="fw-normal mb-5" style="color: #4835d4;">General Infomation</h3>
                                                <div class="mb-4 pb-2">
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6 mb-4 pb-2">
                                                        <div class="form-outline">
                                                            <label class="form-label" for="form3Examplev2">User Name</label>
                                                            <input name="users" required style="border: solid #ebebeb 3px; width: 400px; border-radius: 30px" type="text" id="form3Examplev2" class="form-control form-control-lg" />

                                                        </div>
                                                </div>

                                                <div class="mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="" for="form3Examplev3">First Name</label>
                                                        <input name="firstname" required style="border: solid #ebebeb 3px; width: 400px; border-radius: 30px" type="text" id="form3Examplev3" class="form-control form-control-lg" />
                                                    </div>
                                                </div>
                                                <div class="mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="" for="form3Examplev3">Last Name</label>
                                                        <input name="lastname" required style="border: solid #ebebeb 3px; width: 400px; border-radius: 30px" type="text" id="form3Examplev3" class="form-control form-control-lg" />
                                                    </div>
                                                </div>
                                                <div class="mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="" for="form3Examplev4">Password</label>
                                                        <input name="password" minlength="6" required style="border: solid #ebebeb 3px; width: 400px; border-radius: 30px" type="password" id="form3Examplev4" class="form-control form-control-lg" />
                                                    </div>
                                                </div>
                                                    <div class="mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="" for="form3Examplev4">Your Email</label>
                                                        <input name="email" minlength="6" required style="border: solid #ebebeb 3px; width: 400px; border-radius: 30px" type="email" id="form3Examplev4" class="form-control form-control-lg" />
                                                    </div>
                                                        <h3 style="color: red">${mess}</h3>
                                                </div>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-light btn-lg"
                                                data-mdb-ripple-color="dark">Register</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
            </form>
        </section>
    </body>
</html>
