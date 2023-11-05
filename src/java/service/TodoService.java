package service;

import java.util.ArrayList;
import model.*;
import dao.*;
import dto.*;

public class TodoService {

    private final TodoDAO tdao = new TodoDAO();
    private final UserDAO udao = new UserDAO();

    public Todo getTodoById(int todoId) {
        return tdao.getTodoById(todoId);
    }
    
    public ArrayList<Todo> getTodosOfProject(int projectId) {
        return tdao.getTodosOfProject(projectId);
    }

    public ArrayList<ProjectTodoDTO> getProjectTodoDTOs(int projectId) {
        ArrayList<ProjectTodoDTO> ptdto = new ArrayList<>();
        
        for (Todo t : this.getTodosOfProject(projectId)) {
            ProjectTodoDTO dto = new ProjectTodoDTO();

            dto.setTodo(t);
            dto.setAssigner(this.getAssignerOfTodo(t.getId()));
            dto.setAssignee(this.getAssigneeOfTodo(t.getId()));

            ptdto.add(dto);
        }
        
        return ptdto;
    }

    public User getAssignerOfTodo(int todoId) {
        return udao.getAssignerOfTodo(todoId);
    }

    public User getAssigneeOfTodo(int todoId) {
        return udao.getAssigneeOfTodo(todoId);
    }

    public void createTodo(Todo t) {
        tdao.createTodo(t);
    }
    
    public void updateTodo(Todo t) {
        tdao.updateTodo(t);
    }
}
