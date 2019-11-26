-- Verificar quais companhia aéreas podem fazer o vôo numa data especificae com modelo de avião específico
-- e quais portões estão disponíveis
CREATE OR REPLACE PROCEDURE selecionaPortoesDisponiveis(p_data_voo in voo.data_saida%type, 
    p_modelo_aeronave in AERONAVE.MODELO%type)
    --p_recordset OUT SYS_REFCURSOR) 
    IS
        v_quantidade_aeronave number;
        
        cursor cPortao(c_quantidade number,c_data_saida date) is
            select p.* from portao p
            inner join categoria c on c.ID_CATEGORIA = P.ID_CATEGORIA
            inner join voo v on v.id_portao = p.id_portao
            where p.DISPONIBILIDADE != 0 
                and C.QUANTIDADE >= c_quantidade 
                and V.DATA_SAIDA <> c_data_saida 
                and v.data_chegada <> C_DATA_SAIDA;
            
        cursor cFrota (c_modelo varchar2) is
            select f.* from frota f 
            inner join aeronave a on a.id_aeronave = f.id_aeronave
            where a.modelo = c_modelo;
    begin
        select c.quantidade into v_quantidade_aeronave from aeronave a
            inner join categoria c on c.id_categoria = A.ID_CATEGORIA
            where A.MODELO = P_MODELO_AERONAVE;
            
        for rPortao IN cPortao(v_quantidade_aeronave, P_DATA_VOO) loop
            for rFrota in cFrota(p_modelo_aeronave) loop
                DBMS_OUTPUT.PUT_LINE(rFrota.id_companhia_aerea);
            end loop;
        end loop;
        
        --OPEN p_recordset FOR
           -- SELECT * FROM PORTAO
               -- WHERE DISPONIBILIDADE != 0;
    end;
/

call selecionaPortoesDisponiveis(TO_DATE('2019/08/16 8:30:25', 'YYYY/MM/DD HH:MI:SS'), 'boeing 737');

