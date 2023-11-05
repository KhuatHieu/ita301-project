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

    public void deleteUserAccount(User u) {

    }

    public User getUser(String username, String password) {
        return get(selects()
                .where("username", username)
                .andWhere("password", password)
        );
    }

    public ArrayList<User> getUsersOfProject(int projectId) {
        return getAll(selects()
                .innerJoin("project_users")
                .on("id", "user_id")
                .where("[project_users].project_id", projectId)
        );
    }

    public User getAssignerOfTodo(int todoId) {
        return get(selects()
                .innerJoin("todos")
                .on("id", "assigner_id")
                .where("[todos].id", todoId)
        );
    }

    public User getAssigneeOfTodo(int todoId) {
        return get(selects()
                .innerJoin("todos")
                .on("id", "assignee_id")
                .where("[todos].id", todoId)
        );
    }
}
