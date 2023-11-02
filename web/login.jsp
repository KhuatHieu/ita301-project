<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <%@include file="common/header.jsp" %>
</head>

<body>
    <div class="position-absolute top-50 start-50 translate-middle">
        <h2 class="text-center">IMS Login</h2>
        <div class="m-3" style="width: 17rem;">
            <form action="login" method="post">
                <div class="form-floating mb-3">
                    <input type="text" name="username" class="form-control" id="floatingInput" placeholder="username">
                    <label for="floatingInput">Username</label>
                </div>
                <div class="form-floating">
                    <input type="password" name="password" class="form-control" id="floatingPassword"
                        placeholder="Password">
                    <label for="floatingPassword">Password</label>
                </div>
                <button class="btn btn-outline-success mt-3 w-100">Login</button>
                <c:if test="${not empty msg}">
                    <span>${msg}</span>
                </c:if>
            </form>
        </div>
    </div>

    <%@include file="common/footer.jsp" %>
</body>

</html>