package dto;

import model.*;

public class ProjectTodoDTO {

    private Todo todo;
    private User assigner;
    private User assignee;

    public ProjectTodoDTO() {
    }

    public ProjectTodoDTO(Todo todo, User assigner, User assignee) {
        this.todo = todo;
        this.assigner = assigner;
        this.assignee = assignee;
    }

    public Todo getTodo() {
        return todo;
    }

    public void setTodo(Todo todo) {
        this.todo = todo;
    }

    public User getAssigner() {
        return assigner;
    }

    public void setAssigner(User assigner) {
        this.assigner = assigner;
    }

    public User getAssignee() {
        return assignee;
    }

    public void setAssignee(User assignee) {
        this.assignee = assignee;
    }

}
