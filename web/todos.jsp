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
                <input type="text" class="form-control" id="query-input" placeholder="Search for Todo (not implemented :))"
                    value="${param['queryString']}">
                <button class="btn btn-light border" id="search-btn">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
            </div>
            <div>
                <button class="btn btn-outline-success ms-3"
                    data-bs-toggle="modal" data-bs-target="#createTodoModal">
                    Create new Todo
                </button>
            </div>
            <div>
                <button class="btn btn-outline-success ms-3"
                    data-bs-toggle="modal" data-bs-target="#assignUserModal">
                    Assign User to Project
                </button>
            </div>
        </div>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Title</th>
                    <th>Assigner</th>
                    <th>Assignee</th>
                    <th>Description</th>
                    <th>Is done</th>
                    <th>Target date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${todos}" var="t" varStatus="index">
                    <tr>
                        <td>${index.count}</td>
                        <td>${t.getTodo().getTitle()}</td>
                        <td>
                            <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                                alt="Avatar" class="img-fluid" style="width: 35px;" />
                            ${t.getAssigner().getId() eq sessionScope.user.getId() ? '<b>You</b>' : t.getAssigner().getFullName()}
                        </td>
                        <td>
                            <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                                alt="Avatar" class="img-fluid" style="width: 35px;" />
                            ${t.getAssignee().getId() eq sessionScope.user.getId() ? '<b>You</b>' : t.getAssignee().getFullName()}
                        </td>
                        <td>${t.getTodo().getDescription()}</td>
                        <td>
                            <form action="todo" method="post">
                                <input type="hidden" name="action" value="updateTodo">
                                <input type="hidden" name="todoId" value="${t.getTodo().getId()}">
                                <input type="hidden" name="projectId" value="${param['projectId']}">
                                <select class="selectpicker" name="isDone" id="" style="width: 5rem;" onchange="this.form.submit();">
                                    <option value="0" ${t.getTodo().getIsDone() == 0 ? 'selected' : ''}>No</option>
                                    <option value="1" ${t.getTodo().getIsDone() == 1 ? 'selected' : ''}>Yes</option>
                                </select>
                            </form>
                        </td>
                        <td>${t.getTodo().getTargetDate()}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Create todo modal -->
    <div class="modal fade" tabindex="-1" id="createTodoModal">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Create new Todo</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="todo" method="post" onsubmit="return validateCreate()">
                <input type="hidden" name="projectId" value="${param['projectId']}">
                <div class="modal-body">
                    <input type="hidden" name="action" value="createTodo">
                    <div class="form-floating">
                        <input type="text" class="form-control" name="title" id="title-input" placeholder="title"
                            oninput="validateCreate()">
                        <label for="floatingInput">Title</label>
                    </div>
                    <div class="invalid-feedback" id="title-feedback">
                    </div>
                    <input type="hidden" name="assignerId" value="${sessionScope.user.getId()}" id="">
                    <span class="form-text mt-3">Assignee</span>
                    <select name="assigneeId" id="" class="selectpicker border rounded form-control" data-live-search="true">
                        <c:forEach items="${assignedUsers}" var="u" varStatus="index">
                            <option value="${u.getId()}">${u.getFullName()} ${u.getId() == sessionScope.user.getId() ? '(you)' : ''}</option>
                        </c:forEach>
                    </select>
                    <div class="form-floating mt-3">
                        <input type="text" class="form-control" name="description" id="description" placeholder="description"
                            oninput="validateCreate()">
                        <label for="floatingInput">Description</label>
                    </div>
                    <div class="invalid-feedback" id="description-feedback"></div>
                    <span class="form-text mt-3">Is done</span>
                    <select name="isDone" id="" class="selectpicker border rounded form-control" data-live-search="true">
                        <option value="0">No</option>
                        <option value="1">Yes</option>
                    </select>
                    <div class="form-floating mt-3">
                        <input type="date" class="form-control" name="targetDate" id="targetDate" placeholder="targetDate"
                            oninput="validateCreate()">
                        <label for="floatingInput">Target date</label>
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

    <!-- Assign user modal -->
    <div class="modal fade" tabindex="-1" id="assignUserModal">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Assign user to Project</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="project" method="post">
                <input type="hidden" name="projectId" value="${param['projectId']}">
                <input type="hidden" name="action" value="assignUser">
                <div class="modal-body">
                    <div>
                        <span class="form-text mt-3">Select an User to assign</span>
                        <select name="userId" id="" class="selectpicker border rounded form-control" data-live-search="true">
                            <c:forEach items="${unassignedUsers}" var="u" varStatus="index">
                                <option value="${u.getId()}">${u.getFullName()}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button class="btn btn-primary">Assign</button>
                </div>
            </form>
          </div>
        </div>
    </div>

    <script>
        function validateCreate() {
            var titleInput = $('#title-input');
            var titleFeedback = $('#title-feedback')

            var check2 = validate(titleInput, titleFeedback, isNotEmpty);
                
            return check1;
        }
    </script>

    <%@include file="common/footer.jsp" %>
</body>

</html>