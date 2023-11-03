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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <style>
            /* Style for the navigation bar */
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
    <body>
        <nav class="nav">
            <a class="nav-link active" aria-current="page" href="#">Home</a>
            <a class="nav-link" href="#">User</a>
            <a class="nav-link" href="#">Project</a>
            <a class="nav-link" href="#">Todos</a>
        </nav>

        <button type="button" class="btn btn-success ml-auto" style="margin-left: 1400px;margin-top: 20px">Create User Account</button>


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
