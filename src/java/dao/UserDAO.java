package dao;

import model.User;

public class UserDAO extends _BaseDAO<User> {

    public UserDAO() {
        super(User.class, "users");
    }

    public User getUserByFirstName(String firstName) {
        return get("first_name", firstName);
    }
    
    public static void main(String[] args) {
        UserDAO udao = new UserDAO();
        
        System.out.println(udao.getUserByFirstName("hieu"));
    }
}
