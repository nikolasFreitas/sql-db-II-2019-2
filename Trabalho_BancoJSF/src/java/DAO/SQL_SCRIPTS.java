/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

/**
 *
 * @author Giovani
 */
public enum SQL_SCRIPTS {
    PROCEDURE_insertAeronaveNaFrota("{call insertAeronaveNaFrota(?,?)}"),
    //PROCEDURE_totalFrotaComp("begin TOTALFROTACOMP(?,?); end;"),
    FUNCTION_isPortaoValid("begin ? := ISPORTAOVALID(?,?); end;"),
    //PROCEDURE_pegaPortoesDisponiveis("declare begin PEGAPORTOESDISPONIVEIS(TO_DATE(?,'YYYY/MM/DD'),?,?); end;"),
    PROCEDURE_selecionaPortoesDisponiveis("begin SELECIONAPORTOESDISPONIVEIS(TO_DATE(?,'YYYY/MM/DD'),?,?); end;"),
    PROCEDURE_getAllFligths("begin GET_ALL_FLIGTHS(?); end;"),
    PROCEDURE_checkFilghtAvaliable("begin checkFilghtAvaliable(TO_DATE(?,'YYYY/MM/DD HH:MI:SS'), ?); end;"),
    
    
    
    SELECT_PORTAO("select * from portao"),
    SELECT_VOO("select * from voo"),
    SELECT_FROTA("select * from frota"),
    SELECT_COMPAEREA("select * from companhia_aerea"),
    SELECT_CATEGORIA("select * from categoria"),
    SELECT_AERONAVE("select * from aeronave where modelo = ''");
    
    
    
    private final String sql;
    SQL_SCRIPTS(String sql){
        this.sql = sql; 
    }
    
    public String getSql() {
        return sql;
    }    
}
