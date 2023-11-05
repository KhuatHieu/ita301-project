package dao;

import java.util.ArrayList;
import model.Todo;

public class TodoDAO extends _BaseDAO<Todo> {

    public TodoDAO() {
        super(Todo.class, "todos");
    }

    public Todo getTodoById(int todoId) {
        return get(todoId);
    }
    
    public ArrayList<Todo> getTodosOfProject(int projectId) {
        return getAll(selects().where("project_id", projectId));
    }
    
    public void createTodo(Todo t) {
        save(t);
    }
    
    public void updateTodo(Todo t) {
        save(t);
    }
}
