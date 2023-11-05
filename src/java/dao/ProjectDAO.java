package dao;

import java.util.ArrayList;
import model.Project;

public class ProjectDAO extends _BaseDAO<Project> {

    public ProjectDAO() {
        super(Project.class, "projects");
    }

    public Project getProjectById(int id) {
        return get(id);
    }

    public ArrayList<Project> getProjectsOfAnUser(int userId) {
        return getAll(selects()
                .innerJoin("project_users")
                .on("id", "project_id")
                .where("[project_users].user_id", userId)
        );
    }
    
    public ArrayList<Project> searchProjectsOfAnUser(int userId, String queryString) {
        return raw("SELECT *\n"
                + "FROM projects\n"
                + "WHERE mentor_id = ?\n"
                + "AND (LOWER(project_code) LIKE '%' + LOWER(?) + '%'\n"
                + "OR LOWER(project_name) LIKE '%' + LOWER(?) + '%');")
                .setRawValues(userId, queryString, queryString)
                .exec();
    }
    
    public void createProject(Project p) {
        save(p);

        int projectId = getGeneratedKeys();
        insertInto("project_users", "project_id", "user_id")
                .values(projectId, p.getMentorId())
                .exec();
    }

    public void assignUserToProject(int userId, int projectId) {
        insertInto("project_users", "project_id", "user_id")
                .values(projectId, userId)
                .exec();
    }
}
