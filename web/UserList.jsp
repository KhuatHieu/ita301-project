<%-- 
    Document   : UserList
    Created on : Nov 3, 2023, 12:01:46 PM
    Author     : Quang Huy
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <style>
            /* Style for the navigation bar and button */
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


            /* Style for the modal content */
            .modal-content {
                border: 2px solid #007BFF; /* Add a border around the modal */
                border-radius: 1rem; /* Rounded corners for the modal */
            }

            /* Style for the modal header */
            .modal-header {
                background-color: #007BFF; /* Blue background color for the header */
                color: #fff; /* White text color for the header */
                border-bottom: none; /* Remove the bottom border */
            }

            /* Style for the modal title */
            .modal-title {
                font-size: 1.5rem; /* Increase the font size of the title */
                font-weight: bold; /* Make the title text bold */
            }

            /* Style for the modal body */
            .modal-body {
                padding: 1rem; /* Increase padding inside the modal body */
            }

            /* Style for the modal form inputs and labels */
            table {
                width: 100%; /* Make the table width 100% of the modal */
            }

            tr {
                margin-bottom: 1rem; /* Add spacing between form elements */
            }

            td {
                padding-right: 1rem; /* Add right padding for labels */
            }

            input[type="text"] {
                width: 100%; /* Make the input fields span the full width */
                padding: 0.5rem; /* Increase padding inside input fields */
                border: 1px solid #ccc; /* Add a border to input fields */
                border-radius: 0.5rem; /* Rounded corners for input fields */
            }

            /* Style for modal footer buttons */
            .modal-footer {
                border-top: none; /* Remove the top border in the footer */
            }

            .btn-secondary {
                background-color: #ccc; /* Gray background color for "Close" button */
            }


        </style>



    </head>
    <body>
        <nav class="nav">
            <a class="nav-link active" aria-current="page" href="#">Home</a>
            <a class="nav-link" href="user">User</a>
            <a class="nav-link" href="#">Project</a>
            <a class="nav-link" href="#">Todos</a>
            <a class="nav-link active" href="Login" style="margin-left: 1500px">Logout</a>
        </nav>


        <button type="button" class="btn btn-success ml-auto" style="margin-left: 1400px;margin-top: 20px" data-bs-toggle="modal" data-bs-target="#exampleModal">
            Create User Account
        </button>

        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Create New Account</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <table>                           
                            <tr>
                                <td> First Name:</td>
                                <td> <input type="text" name="firstName" id="firstName">
                                    <span id="firstNameLog" style="color: red; font-size: small"></span>
                                </td>
                            </tr>
                            <tr>
                                <td> Last Name :</td>
                                <td> <input type="text" name="lastName" id="lastName">
                                    <span id="lastNameLog" style="color: red; font-size: small"></span>
                                </td>

                            </tr>
                            <tr>
                                <td>Email:</td>
                                <td> <input type="text" name="email" id="email">
                                    <span id="emailLog" style="color: red; font-size: small"></span>
                                </td>
                            </tr>
                            <tr>
                                <td> User Name:</td>
                                <td><input type="text" name="userName" id="userName">
                                    <span id="userNameLog" style="color: red; font-size: small"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>Password:</td>
                                <td><input type="text" name="password" id="password">
                                    <span id="passwordLog" style="color: red; font-size: small"></span>
                                </td>
                            </tr>
                        </table>
                        <span id="content" style="color: red; font-size: small"></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" id="submit" onclick="doFunc()" class="btn btn-primary">Create</button>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function doFunc() {
                var firstName = $('#firstName').val();
                var lastname = $('#lastName').val();
                var email = $('#email').val();
                var userName = $('#userName').val();
                var password = $('#password').val();

                if (!firstName.trim()) {
                    document.getElementById("firstNameLog").innerHTML = "Must not be empty!";
                    return;
                } else {
                    document.getElementById("firstNameLog").innerHTML = "";
                }
                if (!lastname.trim()) {
                    document.getElementById("lastNameLog").innerHTML = "Must not be empty!";
                    return;
                } else {
                    document.getElementById("lastNameLog").innerHTML = "";
                }
                if (!email.trim()) {
                    document.getElementById("emailLog").innerHTML = "Must not be empty!";
                    return;
                } else {
                    document.getElementById("emailLog").innerHTML = "";
                }
                if (!userName.trim()) {
                    document.getElementById("userNameLog").innerHTML = "Must not be empty!";
                    return;
                } else {
                    document.getElementById("userNameLog").innerHTML = "";
                }
                if (!password.trim()) {
                    document.getElementById("passwordLog").innerHTML = "Must not be empty!";
                    return;
                } else {
                    document.getElementById("passwordLog").innerHTML = "";
                }

                $.ajax({
                    url: "user",
                    type: 'POST',
                    data: {
                        "firstName": firstName,
                        "lastName": lastname,
                        "email": email,
                        "userName": userName,
                        "password": password,
                        "action": "createUser"
                    },
                    success: function (data) {
                        window.location = JSON.parse(data);
                    },
                    error: function (jqXHR) {
                        $('#content').text(jqXHR.responseText);
                    }
                });


            }
        </script>

        <div class="container" style="margin-top: 20px">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body text-center">
                            <h1>User List</h1>
                        </div>
                        <div class="table-responsive">
                            <table class="table">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">First Name</th>
                                        <th scope="col">Last Name</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">User Name</th> 
                                        <th scope="col">Password</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody class="customtable">
                                    <c:forEach items="${userList}" var="u">
                                        <tr>
                                            <td>${u.getId()}</td>
                                            <td>${u.getFirstName()}</td> 
                                            <td>${u.getLastName()}</td> 
                                            <td>${u.getEmail()}</td>
                                            <td>${u.getUsername()}</td>
                                            <td>${u.getPassword()}</td>
                                            <td>
                                                <form action="user" method="post">
                                                    <input type="hidden" name="action" value="viewUserProfile">
                                                    <input type="hidden" name="user_id" value="${u.getId()}">
                                                    <button type="submit" class="btn btn-primary">View Detail</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
    </body>
</html>
