/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datas;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

/**
 *
 * @author USER
 */
public class Datasource extends DriverManagerDataSource{
    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";  
    static final String DB_URL = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=TutoringApp";

    //  Database credentials
    static final String USER = "sa";
    static final String PASS = "123456";  // Password on the SQL Server Application
    
    public Datasource(){
        this.setDriverClassName(JDBC_DRIVER);
        this.setUrl(DB_URL);
        this.setUsername(USER);
        this.setPassword(PASS);
    }
    
}
