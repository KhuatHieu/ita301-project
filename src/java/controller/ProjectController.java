package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import service.ProjectService;

@WebServlet(name = "ProjectController", urlPatterns = {"/project"})
public class ProjectController extends HttpServlet {

    private final ProjectService ps = new ProjectService();

    private int userId;

    private void showAllProjects(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("projects", ps.getProjectsOfAnUser(userId));
        req.getRequestDispatcher("projects.jsp").forward(req, resp);
    }

    private void searchProjects(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String queryString = req.getParameter("queryString");
        req.setAttribute("projects", ps.searchProjectsOfAnUser(userId, queryString));

        req.getRequestDispatcher("projects.jsp").forward(req, resp);
    }

    private void createProject(HttpServletRequest req) {
        String projectCode = req.getParameter("projectCode");
        String projectName = req.getParameter("projectName");
        String description = req.getParameter("description");
        int mentorId = userId;

        ps.createProject(projectCode, projectName, description, mentorId);
    }

    private void assignUser(HttpServletRequest req) {
        int assignUserId = Integer.parseInt(req.getParameter("userId"));
        int projectId = Integer.parseInt(req.getParameter("projectId"));
        ps.assignUserToProject(assignUserId, projectId);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = (User) req.getSession().getAttribute("user");
        userId = u.getId();

        if (req.getParameter("queryString") == null) {
            this.showAllProjects(req, resp);
        } else {
            this.searchProjects(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        switch (req.getParameter("action")) {
            case "createProject":
                this.createProject(req);
                resp.sendRedirect("./project");
                break;
            case "assignUser":
                this.assignUser(req);
                resp.sendRedirect("./todo?projectId=" + req.getParameter("projectId"));
                break;
        }
    }

}
