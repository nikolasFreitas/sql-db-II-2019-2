/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;
import Model.*;
import java.sql.*;
import java.util.LinkedList;
import java.util.List;
import oracle.jdbc.OracleType;
import oracle.jdbc.OracleTypes;
/**
 *
 * @author Giovani
 */
public class testeConexao {
    public static void main(String[] args) {
            List<Voo> voos = new LinkedList();
               try(    
            Connection con = ConnectionFactory.getConnection();
            CallableStatement clst = con.prepareCall(SQL_SCRIPTS.PROCEDURE_getAllFligths.getSql());
        ){
            clst.registerOutParameter(1, OracleTypes.CURSOR);
            clst.execute();
            ResultSet rs = (ResultSet)clst.getObject(1);
            
            while(rs.next()){
                voos.add(new Voo(rs.getInt("id_voo"),
                        rs.getInt("id_aeronave"), 
                        rs.getInt("id_companhia_aerea"), 
                        rs.getInt("id_portao"), 
                        rs.getString("data_chegada"), 
                        rs.getString("data_chegada")
                ));
                
            }
                   System.out.println(voos.toString());
            
        } catch (SQLException e) {
            e.printStackTrace();
        } 

       
        
    }
}
