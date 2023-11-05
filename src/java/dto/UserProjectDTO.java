package dto;

import model.User;
import model.Project;

public class UserProjectDTO {

    private Project project;
    private User mentor;

    public UserProjectDTO() {
    }

    public UserProjectDTO(Project project, User mentor) {
        this.project = project;
        this.mentor = mentor;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public User getMentor() {
        return mentor;
    }

    public void setMentor(User mentor) {
        this.mentor = mentor;
    }
}
