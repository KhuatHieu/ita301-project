package dao;

import model.Project;

public class ProjectDAO extends _BaseDAO<Project> {

    public ProjectDAO() {
        super(Project.class, "projects");
    }

    public Project getProjectById(int id) {
        return get(id);
    }
    
    public static void main(String[] args) {
        ProjectDAO pdao = new ProjectDAO();

        pdao.selects()
                .innerJoin("users")
                .on("mentor_id", "id")
                .printStatement();
    }
}
