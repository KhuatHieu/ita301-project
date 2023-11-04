package dao;

import java.lang.reflect.Array;
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
    public User getUser(String username, String password) {
        return get(selects()
                .where("username", username)
                .andWhere("password", password)
        );
    } 
}
