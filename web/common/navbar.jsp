<%@page contentType="text/html" pageEncoding="UTF-8" %>

<div class="row border-bottom shadow shadow-sm sticky-top" style="background-color: #FFFFFF; height: 4rem;">
    <!-- Home page -->
    <div class="col-2 align-self-center ps-5">
        <a href="" class="align-left">
            <img src="https://uni.fpt.edu.vn/Data/Sites/1/media/2020logoweb/logo_1.png"
                width="100">
        </a>
    </div>

    <!-- Empty -->
    <div class="col-6">

    </div>

    <c:choose>
        <c:when test="${sessionScope.user == null}">
            <div class="col-2">
            </div>
            <div class="col-2 justify-content-end align-self-center d-flex" style="margin-left: -1rem;">
                <a href="./login" class="btn btn-success" style="width: 6rem;">Log in</a>
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
                            ${sessionScope.user.firstName}
                        </span>
                        <img src="" style="width: 2rem; height: 2rem; border-radius: 50%">
                    </div>

                    <ul class='dropdown-menu dropdown-menu-end notification-list'>
                        <!-- User info -->
                        <li>
                            <button class='dropdown-item disabled'>
                                ${sessionScope.user.firstName}
                                <br>
                                @${sessionScope.user.username}
                            </button>
                        </li>
                        <!-- Settings -->
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <a class='dropdown-item' href="./settings">
                                <div class="row">
                                    <div class="col-2">
                                        <i class="fa-regular fa-gear"></i>
                                    </div>
                                    <div class="col-10">
                                        Settings
                                    </div>
                                </div>
                            </a>
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