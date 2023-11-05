
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="Component/header.jsp" %>
    </head>
    <body>
        <%@include file="Component/navbar.jsp" %>
        <div class="container" style="margin-top:200px ">
            <form method="post" action="login">
                
                <div class="text-center">
                    <h1>Login</h1>
                </div>
                
                <!-- Email input -->
                <div class="form-floating mb-3">
                    <input type="username" class="form-control" id="floatingInput" name="username">
                    <label for="floatingInput">Username</label>
                </div>

                <!-- Password input -->
                <div class="form-floating mb-4">
                    <input type="password" class="form-control" id="floatingPassword" name="password">
                    <label for="floatingPassword">Password</label>
                </div>
                <!-- 2 column grid layout for inline styling -->
                <div class="row mb-4">
                    <div class="col d-flex justify-content-center">
                        <!-- Checkbox -->
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="form2Example31" checked />
                            <label class="form-check-label" for="form2Example31"> Remember me </label>
                        </div>
                    </div>
                </div>
                <h3 style="color:red ">${mess}</h3>

                <!-- Submit button -->
                <button type="submit" class="btn btn-primary btn-block mb-4">Login</button>

                <!-- Register buttons -->
                <div class="text-center">
                    <p>Not a member? <a href="./register">Register</a></p>
                    <p>or sign up with:</p>
                    <button type="button" class="btn btn-link btn-floating mx-1">
                        <i class="fab fa-facebook-f"></i>
                    </button>

                    <button type="button" class="btn btn-link btn-floating mx-1">
                        <i class="fab fa-google"></i>
                    </button>

                    <button type="button" class="btn btn-link btn-floating mx-1">
                        <i class="fab fa-twitter"></i>
                    </button>

                    <button type="button" class="btn btn-link btn-floating mx-1">
                        <i class="fab fa-github"></i>
                    </button>
                </div>
            </form>
            Login - register
        </div>
    </body>
</html>
