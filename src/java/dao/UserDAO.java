package dao;

import java.util.ArrayList;
import model.User;

public class UserDAO extends _BaseDAO<User> {

    public UserDAO() {
        super(User.class, "users");
    }

    public User getUserById(int id) {
        return get(id);
    }

    public ArrayList<User> getUserList() {
        return getAll();
    }

    public void createUserAccount(User u) {
        save(u);
    }

    public void updateUserAccount(User u) {
        save(u);
    }
    
    public void deleteUserAccount(User u){
        
    }

    public static void main(String[] args) {
        UserDAO udao = new UserDAO();
        System.out.println(udao.getUserById(1));
    }
}
