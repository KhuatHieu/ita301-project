package service;

import dao.*;
import dto.*;
import model.*;

import java.util.ArrayList;

public class ProjectService {

    private final ProjectDAO pdao = new ProjectDAO();
    private final UserDAO udao = new UserDAO();

    public ArrayList<UserProjectDTO> getProjectsOfAnUser(int userId) {
        ArrayList<UserProjectDTO> updto = new ArrayList<>();

        for (Project p : pdao.getProjectsOfAnUser(userId)) {
            User mentor = new UserDAO().getUserById(p.getMentorId());
            updto.add(new UserProjectDTO(p, mentor));
        }

        return updto;
    }

    public ArrayList<UserProjectDTO> searchProjectsOfAnUser(int userId, String queryString) {
        ArrayList<UserProjectDTO> updto = new ArrayList<>();

        for (Project p : pdao.searchProjectsOfAnUser(userId, queryString)) {
            User mentor = new UserDAO().getUserById(p.getMentorId());
            updto.add(new UserProjectDTO(p, mentor));
        }

        return updto;
    }

    public void createProject(String projectCode, String projectName, String description, int mentorId) {
        Project p = new Project();

        p.setProjectCode(projectCode);
        p.setProjectName(projectName);
        p.setDescription(description);
        p.setMentorId(mentorId);

        pdao.createProject(p);
    }

    public void assignUserToProject(int userId, int projectId) {
        pdao.assignUserToProject(userId, projectId);
    }

    public ArrayList<User> getUsersOfProject(int projectId) {
        return udao.getUsersOfProject(projectId);
    }

    // tự hành hạ bản thân
    public ArrayList<User> getUnassignedUsers(int projectId) {
        ArrayList<User> unassignedUsers = new ArrayList<>();
        
        ArrayList<Integer> assignedUsersIds = new ArrayList<>();
        udao.getUsersOfProject(projectId).forEach(u -> 
                assignedUsersIds.add(u.getId())
        );

        udao.getUserList().forEach(u -> {
            if (!assignedUsersIds.contains(u.getId())) {
                unassignedUsers.add(u);
            }
        });

        return unassignedUsers;
    }
}
