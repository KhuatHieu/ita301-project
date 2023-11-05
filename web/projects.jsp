<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style>
        td {
            vertical-align: middle;
        }
    </style>
    <%@include file="common/header.jsp" %>
</head>

<body style="background-color: #F0F2F5;">
    <%@include file="common/navbar.jsp" %>

    <div class="m-3">
        <div class="d-flex flex-row">
            <div class="input-group mb-2" style="width: 30rem;">
                <input type="text" class="form-control" id="query-input" placeholder="Search by Project code or Project name"
                    value="${param['queryString']}">
                <button class="btn btn-light border" id="search-btn">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
            </div>
            <div>
                <button class="btn btn-outline-success ms-3"
                    data-bs-toggle="modal" data-bs-target="#createProjectModal">
                    Create new Project
                </button>
            </div>
        </div>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Project Code</th>
                    <th>Project Name</th>
                    <th>Description</th>
                    <th>Mentor</th>
                    <th>Is Active</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${projects}" var="p" varStatus="index">
                    <tr>
                        <td>${index.count}</td>
                        <td>${p.getProject().getProjectCode()}</td>
                        <td>${p.getProject().getProjectName()}</td>
                        <td>${p.getProject().getDescription()}</td>
                        <td>
                            <c:choose>
                                <c:when test="${sessionScope.user.getId() ne p.getMentor().getId()}">
                                    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                                        alt="Avatar" class="img-fluid me-2" style="width: 35px;" />
                                    <a href="./user?id=${p.getMentor().getId()}">
                                        ${p.getMentor().getFullName()}
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <b>You</b>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${p.getProject().getIsActive() == 0 ? 'No' : 'Yes'}</td>
                        <td>
                            <a href="./todo?projectId=${p.getProject().getId()}" class="btn btn-outline-primary">Details</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Create project modal -->
    <div class="modal fade" tabindex="-1" id="createProjectModal">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Create new Project</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="project" method="post" onsubmit="return validateCreate()">
                <div class="modal-body">
                    <input type="hidden" name="action" value="createProject">
                    <div class="form-floating">
                        <input type="text" class="form-control" name="projectCode" id="project-code-input" placeholder="code"
                            oninput="validateCreate()">
                        <label for="floatingInput">Project code</label>
                    </div>
                    <div class="invalid-feedback" id="project-code-feedback">
                    </div>
                    <div class="form-floating mt-3">
                        <input type="text" class="form-control" name="projectName" id="project-name-input" placeholder="name"
                            oninput="validateCreate()">
                        <label for="floatingInput">Project name</label>
                    </div>
                    <div class="invalid-feedback" id="project-name-feedback">
                    </div>
                    <div class="form-floating mt-3">
                        <input type="text" class="form-control" name="description" id="descriptionInput" placeholder="name">
                        <label for="floatingInput">Description</label>
                    </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                  <button class="btn btn-primary">Create</button>
                </div>
            </form>
          </div>
        </div>
    </div>

    <script>
        function search() {
            var queryString = $("#query-input").val();
            if (queryString) {
                window.location = './project?queryString=' + queryString;   
            } else {
                window.location = './project';
            }
        }

        $("#query-input").on("keydown", function(e) {
            if (e.keyCode === 13) {
                search();
            }
        });

        $("#search-btn").on("click", search);

        function validateCreate() {
            var codeInput = $('#project-code-input');
            var codeFeedback = $('#project-code-feedback')

            var nameInput = $('#project-name-input');
            var nameFeedback = $('#project-name-feedback')

            var check1 = validate(codeInput, codeFeedback, isNotEmpty, 
                isStartsWithChar, isNotContainSpace, isNotContainSpecials, isLengthEnough, isLengthPastEnough);
            var check2 = validate(nameInput, nameFeedback, isNotEmpty, isLengthEnough);
                
            return check1 && check2;
        }
    </script>

    <%@include file="common/footer.jsp" %>
</body>

</html>