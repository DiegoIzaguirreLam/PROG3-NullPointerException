package pe.edu.pucp.steam.dbmanager.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBManager {
    private Connection con;
<<<<<<< HEAD
    private String url = "jdbc:mysql://db-prog3-nullpointerexception.crrbqj2ohnvo.us-east-1.rds.amazonaws.com:3306/prog3nullpointerexception";
=======
    private String url = "jdbc:mysql://"+
 "db-prog3-nullpointerexception.crrbqj2ohnvo.us-east-1.rds.amazonaws.com"+
            ":3306/prog3nullpointerexception";
>>>>>>> 17454bc88d4a63c5a4c5ef37fa40b8992b216e25
    private String user = "admin";
    private String password = "prog3nullpointerexception";
    private static DBManager dbManager;
    
    public static DBManager getInstance(){
        if(dbManager == null) createInstance();
        return dbManager;
    }
    
    public Connection getConnection(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url,user,password);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        
        return con;
    }
    
    private static void createInstance(){
        if(dbManager == null) dbManager = new DBManager();    
    }
}
