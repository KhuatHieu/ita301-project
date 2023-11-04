package service;

import com.google.gson.Gson;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.User;

public class UserService {

    private final UserDAO udao = new UserDAO();

    public ArrayList<User> getUserList() {
        ArrayList<User> userList = udao.getUserList();
        return userList;
    }
    public void login (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User u = udao.getUser(username, password);
        if(u == null){
            String mess = "Login Failed! ";
            request.setAttribute("mess", mess);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }else{
            response.sendRedirect("user");
        }
    }

    public void createUserAccount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User u = new User();
        ArrayList<User> userList = udao.getUserList();
        String email = request.getParameter("email");
        String data = null;
        boolean flag = true;
        for (User user : userList) {
            if (user.getEmail().equals(email)) {
                flag = false;
                break;
            }
        }
        if (flag == false) {
            data = "This email is existed!";
            response.setStatus(406);
        } else {
            u.setFirstName(request.getParameter("firstName"));
            u.setLastName(request.getParameter("lastName"));
            u.setEmail(request.getParameter("email"));
            u.setUsername(request.getParameter("userName"));
            u.setPassword(request.getParameter("password"));
            udao.createUserAccount(u);
            data = "user";
            response.setStatus(200);
        }

        String json = new Gson().toJson(data);
        response.setContentType("text/plain");
        response.getWriter().write(json);
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
