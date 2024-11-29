package org.aguzman.apiservlet.webapp.headers.Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBaseDatos {
    private static String url= "jdbc:mysql://localhost:3306/java_curso?serverTimezone=Europe/Madrid";
    private static String username= "root";
    private static String pass= "Adm1n";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url,username,pass);
    }

}
