<%@page contentType="text/html" pageEncoding="UTF-8" %>

<div class="row border-bottom shadow shadow-sm sticky-top" style="background-color: #FFFFFF; height: 4rem;">
    <!-- Home page -->
    <div class="col-2 align-self-center ps-5">
        <a href="./" class="align-left">
            <img src="https://uni.fpt.edu.vn/Data/Sites/1/media/2020logoweb/logo_1.png"
                width="100">
        </a>
    </div>

    <!-- Empty -->
    <c:choose>
        <c:when test="${sessionScope.user == null}">
            <div class="col-6">

            </div>
        </c:when>
        <c:otherwise>
            <div class="col-1 align-self-center d-flex">
                <a href="./project" class="btn">Projects</a>
            </div>
            <div class="col-1 align-self-center d-flex">
                <a href="./user" class="btn">Accounts</a>
            </div>
            <div class="col-4"></div>
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${sessionScope.user == null}">
            <div class="col-2"></div>
            <div class="col-1 justify-content-end align-self-center d-flex">
                <a href="./login" class="btn btn-outline-success" style="width: 6rem;">Log in</a>
            </div>
            <div class="col-1 justify-content-end align-self-center d-flex" style="margin-left: -1rem;">
                <a href="./register" class="btn btn-primary" style="width: 6rem;">Register</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="col-2">

            </div>
            <!-- Dropdowns -->
            <div class="col-2 justify-content-end align-self-center d-flex" style="margin-left: -1rem;">
                <div class="dropdown">
                    <!-- Account dropdowns -->
                    <div class="btn btn-sm bnt-primary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                        aria-expanded="false">
                        <span class="me-3">
                            ${sessionScope.user.firstName} ${sessionScope.user.lastName}
                        </span>
                        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                                alt="Avatar" class="img-fluid" style="width: 35px;" />
                    </div>

                    <ul class='dropdown-menu dropdown-menu-end notification-list'>
                        <!-- User info -->
                        <li>
                            <button class='dropdown-item disabled'>
                                ${sessionScope.user.firstName} ${sessionScope.user.lastName}
                                <br>
                                @${sessionScope.user.username}
                            </button>
                        </li>
                        <!-- Settings -->
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class='dropdown-item' href="./profile">
                                    <div class="row">
                                        <div class="col-2">
                                            <i class="fa-solid fa-user"></i>
                                        </div>
                                        <div class="col-10">
                                            Profile
                                        </div>
                                    </div>
                                </a>
                            </li>

                        <!-- Logout -->
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <a class='dropdown-item' href='./logout'>
                                <div class="row">
                                    <div class="col-2">
                                        <i class="fa-solid fa-arrow-right-from-bracket"></i>
                                    </div>
                                    <div class="col-10">
                                        Log out
                                    </div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>