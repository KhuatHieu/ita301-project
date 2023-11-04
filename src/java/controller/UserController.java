package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.UserService;

@WebServlet(name = "UserController", urlPatterns = {"/user"})
public class UserController extends HttpServlet {

    private final UserService us = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("userList", us.getUserList());
        request.getRequestDispatcher("UserList.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("action")) {
            case "createUser":
                us.createUserAccount(request, response);
                break;
            case "updateUser":
                us.updateUserAccount(request, response);
                response.sendRedirect("user");
                break;
            case "viewUserProfile":
                request.setAttribute("user", us.getUserById(request, response));
                request.getRequestDispatcher("UserProfile.jsp").forward(request, response);
                break;
        }

    }

}
