package controller;

import service.*;
import model.*;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;

@WebServlet(name = "TodoController", urlPatterns = {"/todo"})
public class TodoController extends HttpServlet {

    private final ProjectService ps = new ProjectService();
    private final TodoService ts = new TodoService();
    private final UserService us = new UserService();

    private void createTodo(HttpServletRequest req, HttpServletResponse resp) {
        Todo t = new Todo();

        t.setTitle(req.getParameter("title"));
        t.setProjectId(Integer.parseInt(req.getParameter("projectId")));
        t.setAssignerId(Integer.parseInt(req.getParameter("assignerId")));
        t.setAssigneeId(Integer.parseInt(req.getParameter("assigneeId")));
        t.setDescription(req.getParameter("description"));
        t.setIsDone(Byte.parseByte(req.getParameter("isDone")));
        t.setTargetDate(Timestamp.valueOf(req.getParameter("targetDate") + " 00:00:00"));

        ts.createTodo(t);
    }

    private void updateTodoStatus(HttpServletRequest req, HttpServletResponse resp) {
        Todo t = ts.getTodoById(Integer.parseInt(req.getParameter("todoId")));
        
        t.setIsDone(Byte.parseByte(req.getParameter("isDone")));

        ts.updateTodo(t);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int projectId = Integer.parseInt(req.getParameter("projectId"));
        req.setAttribute("todos", ts.getProjectTodoDTOs(projectId));

        req.setAttribute("assignedUsers", us.getUsersOfProject(projectId));
        req.setAttribute("unassignedUsers", ps.getUnassignedUsers(projectId));
        req.getRequestDispatcher("todos.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        switch (req.getParameter("action")) {
            case "createTodo":
                this.createTodo(req, resp);
                break;
            case "updateTodo":
                this.updateTodoStatus(req, resp);
                break;
        }

        resp.sendRedirect("./todo?projectId=" + req.getParameter("projectId"));
    }

}
