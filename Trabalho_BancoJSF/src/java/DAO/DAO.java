/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;
import Model.*;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.LinkedList;
import java.util.List;
import oracle.jdbc.OracleTypes;
/**
 *
 * @author Giovani
 */
public class DAO {
    
    //Function isPortaoValid - veirifica se portao esta disponivel 
    public boolean verificaPortao(Aeronave aeronave,Portao portao ){
         try(    
            Connection con = ConnectionFactory.getConnection();
            CallableStatement clst = con.prepareCall(SQL_SCRIPTS.FUNCTION_isPortaoValid.getSql());
            //PreparedStatement stmt = con.prepareStatement("select * from aeronave");
        ){
            clst.registerOutParameter(1,OracleTypes.PLSQL_BOOLEAN);
            clst.setInt(2,aeronave.getIdAeronave());
            clst.setInt(3,portao.getIdPortao());
            clst.execute();
      
            return clst.getBoolean(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    //Insere frotas de avioes e companhia aereas
    public void adcionaFrota(Aeronave aeronave,CompanhiaAerea compAerea){
        try(    
            Connection con = ConnectionFactory.getConnection();
            CallableStatement clst = con.prepareCall(SQL_SCRIPTS.PROCEDURE_insertAeronaveNaFrota.getSql());
            //PreparedStatement stmt = con.prepareStatement("select * from aeronave");
        ){
            clst.setString(1,aeronave.getModelo());
            clst.setString(2,compAerea.getNome());
            clst.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }    
    } 
    
    public List<Voo> listAllVoos(){
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
            System.out.println("Recebido os voos " + voos.toString());
            return voos;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }    
        
        return null;    
    }
    
        public List<Voo> listAllAvailableFlights(){
        List<Voo> voos = new LinkedList();
        try(    
            Connection con = ConnectionFactory.getConnection();
            CallableStatement clst = con.prepareCall(SQL_SCRIPTS.PROCEDURE_checkFilghtAvaliable.getSql());
        ){
            
            LocalDate localDate = LocalDate.now();//For reference
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("YYYY/MM/DD HH:MI:SS");
            String formattedString = localDate.format(formatter);
            
            System.out.println("\n\n Data formatada " + formattedString + "\n\n");
            
            clst.setString(1, formattedString);
            clst.registerOutParameter(2, OracleTypes.CURSOR);
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
            System.out.println("Recebido os voos FILTRADOS " + voos.toString());
            return voos;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }    
        
        return null;    
    }
}
