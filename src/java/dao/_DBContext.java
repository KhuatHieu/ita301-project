package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class _DBContext {

    protected Connection connection;
	
    private String hostname, port, name, username, password;

    public _DBContext() {
        hostname = "localhost";
        port = "1433";
        name = "ita301-main-db";
        username = "sa";
        password = "sa";

        try {
            String url = "jdbc:sqlserver://" + hostname + ":" + port + ";database=" + name;
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(_DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Connection getConnection() {
        return connection;
    }
}
