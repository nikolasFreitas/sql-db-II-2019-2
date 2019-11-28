set serveroutput on;
-- Verifiacar quais portões estão disponíveis
CREATE or replace procedure pegaPortoesDisponiveis(p_data_voo in voo.data_saida%type, 
    p_quantidade in number, 
    p_cos out SYS_REFCURSOR)
    is
    begin
        open p_cos for
        select DISTINCT p.* from portao p
            inner join categoria c on c.ID_CATEGORIA = P.ID_CATEGORIA
            inner join voo v on v.id_portao = p.id_portao
            where p.DISPONIBILIDADE != 0 
                and C.QUANTIDADE >= p_quantidade 
                and V.DATA_SAIDA <> p_data_voo 
                and v.data_chegada <> p_data_voo;
    end;
/

-- Verificar quais companhia aéreas podem fazer o vôo numa data especificae com modelo de avião específico
-- e quais portões estão disponíveis
CREATE OR REPLACE PROCEDURE selecionaPortoesDisponiveis(p_data_voo in voo.data_saida%type, 
    p_modelo_aeronave in AERONAVE.MODELO%type,
    v_rc out sys_refcursor) 
    IS
        
        TYPE portaoTableTemplate IS TABLE OF portao%ROWTYPE;
        TYPE  companhia_aereaTableTemplate IS TABLE OF companhia_aerea%ROWTYPE;
        
        table_portao portaoTableTemplate;
        table_companhia_aerea companhia_aereaTableTemplate;
        
        v_quantidade_aeronave number;
        
        cursor cPortao(c_data_voo date, c_quantidade number) is
        select distinct p.* from portao p
            inner join categoria c on c.ID_CATEGORIA = P.ID_CATEGORIA
            inner join voo v on v.id_portao = p.id_portao
            where p.DISPONIBILIDADE != 0 
                and C.QUANTIDADE >= c_quantidade 
                and V.DATA_SAIDA <> c_data_voo 
                and v.data_chegada <> c_data_voo;
                
    begin
        select c.quantidade into v_quantidade_aeronave from aeronave a
            inner join categoria c on c.id_categoria = A.ID_CATEGORIA
            where A.MODELO = P_MODELO_AERONAVE;

        for lPortao IN cPortao(p_data_voo, v_quantidade_aeronave) loop            
            open v_rc for select distinct ca.*, p.* from companhia_aerea ca 
            inner join frota f on F.ID_COMPANHIA_AEREA = CA.ID_COMPANHIA_AEREA
            inner join AERONAVE A on A.ID_AERONAVE = F.ID_AERONAVE
            inner join categoria c on C.ID_CATEGORIA = A.ID_CATEGORIA
            inner join portao p on P.ID_CATEGORIA = C.ID_CATEGORIA
            where P.ID_PORTAO = lPortao.id_portao;
        end loop;

         --DBMS_SQL.RETURN_RESULT(table_companhia_aerea);
    end;
/

CREATE OR REPLACE PROCEDURE selecionaPortoesDisponiveis(
    p_data_voo in voo.data_saida%type, 
    p_modelo_aeronave in AERONAVE.MODELO%type)      
    is
        v_rc SYS_REFCURSOR;
        cursorzin refcursor;
    begin
        pegaPortoesDisponiveis(p_data_voo, 30, v_rc);        
        
    end;
/

var cursorzin refcursor;
exec pegaPortoesDisponiveis(TO_DATE('2019/08/16 8:30:25', 'YYYY/MM/DD HH:MI:SS'), 30, :cursorzin); 
print cursorzin;

var otro refcursor;
EXECUTE selecionaPortoesDisponiveis(TO_DATE('2019/08/16 8:30:25', 'YYYY/MM/DD HH:MI:SS'), 'airbus a319', :otro);
print otro;

