package model;

import java.sql.Timestamp;

public class Todo {

    private int id;
    private String title;
    private int projectId;
    private int assignerId;
    private int assigneeId;
    private String description;
    private byte isDone;
    private Timestamp targetDate;

    public Todo() {
    }

    public Todo(int id, String title, int projectId, int assignerId, int assigneeId, String description, byte isDone, Timestamp targetDate) {
        this.id = id;
        this.title = title;
        this.projectId = projectId;
        this.assignerId = assignerId;
        this.assigneeId = assigneeId;
        this.description = description;
        this.isDone = isDone;
        this.targetDate = targetDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public int getAssignerId() {
        return assignerId;
    }

    public void setAssignerId(int assignerId) {
        this.assignerId = assignerId;
    }

    public int getAssigneeId() {
        return assigneeId;
    }

    public void setAssigneeId(int assigneeId) {
        this.assigneeId = assigneeId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public byte getIsDone() {
        return isDone;
    }

    public void setIsDone(byte isDone) {
        this.isDone = isDone;
    }

    public Timestamp getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(Timestamp targetDate) {
        this.targetDate = targetDate;
    }

    @Override
    public String toString() {
        return "Todo{" + "id=" + id + ", title=" + title + ", projectId=" + projectId + ", assignerId=" + assignerId + ", assigneeId=" + assigneeId + ", description=" + description + ", isDone=" + isDone + ", targetDate=" + targetDate + '}';
    }

}
