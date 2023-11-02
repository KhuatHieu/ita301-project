package model;

public class Project {

    private int id;
    private String projectCode;
    private String projectName;
    private String description;
    private int mentorId;
    private byte isActive;

    public Project() {
    }

    public Project(int id, String projectCode, String projectName, String description, int mentorId, byte isActive) {
        this.id = id;
        this.projectCode = projectCode;
        this.projectName = projectName;
        this.description = description;
        this.mentorId = mentorId;
        this.isActive = isActive;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProjectCode() {
        return projectCode;
    }

    public void setProjectCode(String projectCode) {
        this.projectCode = projectCode;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getMentorId() {
        return mentorId;
    }

    public void setMentorId(int mentorId) {
        this.mentorId = mentorId;
    }

    public byte getIsActive() {
        return isActive;
    }

    public void setIsActive(byte isActive) {
        this.isActive = isActive;
    }

    @Override
    public String toString() {
        return "Project{" + "id=" + id + ", projectCode=" + projectCode + ", projectName=" + projectName + ", description=" + description + ", mentorId=" + mentorId + ", isActive=" + isActive + '}';
    }

}
