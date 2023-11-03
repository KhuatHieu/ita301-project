package service;

import dao.UserDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.User;

public class UserService {

    private final UserDAO udao = new UserDAO();

    public ArrayList<User> getUserList() {
        ArrayList<User> userList = udao.getUserList();
        return userList;
    }

    public void createUserAccount(HttpServletRequest request, HttpServletResponse response) {
        User u = new User();
        u.setEmail(request.getParameter("email"));
        udao.createUserAccount(u);
    }

    public void updateUserAccount(HttpServletRequest request, HttpServletResponse response) {
        int userId = Integer.parseInt(request.getParameter("userId"));

        User u = udao.getUserById(userId);
        u.setId(userId);
        u.setFirstName(request.getParameter("firstName"));
        u.setLastName(request.getParameter("lastName"));
        u.setEmail(request.getParameter("email"));
        u.setUsername(request.getParameter("userName"));
        u.setPassword(request.getParameter("password"));
        udao.updateUserAccount(u);
    }

    public User getUserById(HttpServletRequest request, HttpServletResponse response) {
        int user_id = Integer.parseInt(request.getParameter("user_id"));
        return udao.getUserById(user_id);
    }

}
