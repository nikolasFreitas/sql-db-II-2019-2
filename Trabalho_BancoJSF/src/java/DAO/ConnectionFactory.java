
package DAO;
import java.sql.*;
/**
 *
 * @author Giovani
 */
public class ConnectionFactory {
    
    public static Connection getConnection(){
     try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            return DriverManager.getConnection("jdbc:oracle:thin:@200.132.53.144:1521/XEpdb1", "usr27", "usr27");
        } catch (ClassNotFoundException e) {
            System.out.println("driver não localizado");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("não conseguiu conectar");
        }  
        return null;
    }
}


