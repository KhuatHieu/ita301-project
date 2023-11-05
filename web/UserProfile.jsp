<%-- 
    Document   : UserProfile
    Created on : Nov 3, 2023, 12:13:06 PM
    Author     : Quang Huy
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <style>
            .gradient-custom {
                /* fallback for old browsers */
                background: #f6d365;

                /* Chrome 10-25, Safari 5.1-6 */
                background: -webkit-linear-gradient(to right bottom, rgba(246, 211, 101, 1), rgba(253, 160, 133, 1));

                /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
                background: linear-gradient(to right bottom, rgba(246, 211, 101, 1), rgba(253, 160, 133, 1))
            }
            .card {
                border-radius: 1rem; /* Increase border radius */
            }

            .img-fluid {
                width: 150px; /* Increase image width */
            }

            .text-white {
                font-size: 20px; /* Increase text size */
            }

            .h6, h6 {
                font-size: 20px; /* Increase heading size */
            }

            .text-muted {
                font-size: 18px; /* Increase text size for details */
            }

            .fa-lg {
                font-size: 24px; /* Increase icon size */
            }
            .col-lg-6{
                width:  80%;
            }
            input[type="text"],
            input[type="email"] {
                border-radius: 0.5rem; /* Adjust the value to control the level of rounding */
                padding: 0.5rem; /* Optional: Add padding for a better appearance */
            }

            .nav {
                background-color: #000; /* Black background color */
                padding: 10px 0; /* Vertical and horizontal padding */
            }

            /* Style for active links */
            .nav .nav-link.active {
                color: #fff; /* White text color for active link */
                background-color: #0056b3; /* Background color for active link */
                border-radius: 5px; /* Rounded corners for active link */
                padding: 10px 15px; /* Padding for active link */
            }

            /* Style for non-active links */
            .nav .nav-link {
                color: #fff; /* White text color for non-active links */
                margin-right: 10px; /* Spacing between links */
                padding: 10px 15px; /* Padding for non-active links */
                border-radius: 5px; /* Rounded corners for non-active links */
            }

            /* Style for disabled links */
            .nav .nav-link.disabled {
                color: #777; /* Text color for disabled link */
            }
        </style>
    </head>
    <body style="background-color: #F0F2F5;">
        <%@include file="common/navbar.jsp" %>

        <section class="vh-100" style="background-color: #f4f5f7;">
            <form action="user" method="post" onsubmit="return checkValidate()">
                <div class="container py-5 h-100">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col col-lg-6 mb-4 mb-lg-0">
                            <div class="card mb-3" style="border-radius: .5rem;">
                                <div class="row g-0">                           
                                    <div class="col-md-4 gradient-custom text-center text-white"
                                         style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
                                        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                                             alt="Avatar" class="img-fluid my-5" style="width: 80px;" />
                                        <h5> <input type="text" name="firstName" id="firstName" value="${user.getFirstName()}"></h5>
                                        <span id="firstNameLog" style="color: red; font-size: small"></span>

                                        <h5> <input type="text" name="lastName" id="lastName" value="${user.getLastName()}"></h5>  
                                        <span id="lastNameLog" style="color: red; font-size: small"></span>

                                        <h5>${user.getFirstName()} ${user.getLastName()}</h5>
                                        <i class="far fa-edit mb-5"></i>
                                    </div>
                                    <div class="col-md-8">

                                        <div class="card-body p-4">
                                            <h6>Information</h6>
                                            <hr class="mt-0 mb-4">
                                            <div class="row pt-1">
                                                <div class="col-6 mb-3">
                                                    <h6>Email</h6>
                                                    <p class="text-muted"><input type="email" name="email" id="email" value="${user.getEmail()}"></p>
                                                    <span id="emailLog" style="color: red; font-size: small"></span>
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <h6>Student ID</h6>
                                                    <p class="text-muted"><input type="text" name="userId" value="${user.getId()}" readonly></p>
                                                </div>
                                            </div>                                      
                                            <div class="row pt-1">
                                                <div class="col-6 mb-3">
                                                    <h6>User Name</h6>
                                                    <p class="text-muted"> <input type="text" name="userName" id="userName" value="${user.getUsername()}"></p>
                                                    <span id="userNameLog" style="color: red; font-size: small"></span>
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <h6>Password</h6>
                                                    <p class="text-muted"><input type="text" name="password" id="password" value="${user.getPassword()}"></p>
                                                    <span id="passwordLog" style="color: red; font-size: small"></span>
                                                </div>
                                            </div>                               
                                        </div>
                                        <input type="hidden" name="action" value="updateUser">
                                        <button type="submit" class="btn btn-success" style="margin-bottom: 10px; margin-left: 100px">Update Account</button>  
                                    </div>

                                </div>
                            </div>
                            <a href="user" class="btn btn-secondary" style="text-decoration: none; padding: 10px 20px; border-radius: 0.5rem;">Back</a>
                        </div>                                                                         
                    </div>                                                                                      
                </div>
            </form>
        </section>

        <script>
            function checkValidate() {
                let pass = true;
                const MUST_NOT_BE_EMPTY = "Must not be empty";
                const ONLY_LETTERS_ALLOWED = "Only letters are allowed";
                const INVALID_EMAIL = "Invalid email format";

                if (document.getElementById("firstName").value === "") {
                    document.getElementById("firstNameLog").innerHTML = MUST_NOT_BE_EMPTY;
                    pass = false;
                } else if (!/^[a-zA-Z]+$/.test(document.getElementById("firstName").value)) {
                    document.getElementById("firstNameLog").innerHTML = ONLY_LETTERS_ALLOWED;
                    pass = false;
                } else {
                    document.getElementById("firstNameLog").innerHTML === "";
                }


                if (document.getElementById("lastName").value === "") {
                    document.getElementById("lastNameLog").innerHTML = MUST_NOT_BE_EMPTY;
                    pass = false;
                } else if (!/^[a-zA-Z]+$/.test(document.getElementById("lastName").value)) {
                    document.getElementById("lastNameLog").innerHTML = ONLY_LETTERS_ALLOWED;
                    pass = false;
                } else {
                    document.getElementById("lastNameLog").innerHTML === "";
                }


                if (document.getElementById("email").value === "") {
                    document.getElementById("emailLog").innerHTML = MUST_NOT_BE_EMPTY;
                    pass = false;
                } else if (!/^(.+)@(gmail\.com|fpt\.edu\.vn)$/.test(document.getElementById("email").value)) {
                    document.getElementById("emailLog").innerHTML = INVALID_EMAIL;
                    pass = false;
                } else {
                    document.getElementById("emailLog").innerHTML = "";
                }

                if (document.getElementById("userName").value === "") {
                    document.getElementById("userNameLog").innerHTML = MUST_NOT_BE_EMPTY;
                    pass = false;
                } else {
                    document.getElementById("userNameLog").innerHTML = "";
                }

                if (document.getElementById("password").value === "") {
                    document.getElementById("passwordLog").innerHTML = MUST_NOT_BE_EMPTY;
                    pass = false;
                } else {
                    document.getElementById("passwordLog").innerHTML = "";
                }
                return pass;
            }


        </script>                                                   
    </body>
</html>
