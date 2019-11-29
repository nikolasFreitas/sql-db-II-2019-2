set serveroutput on;
-- Verifiacar quais port�es est�o dispon�veis
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


-- Verificar quais companhia a�reas podem fazer o v�o numa data especificae com modelo de avi�o espec�fico
-- e quais port�es est�o dispon�veis
CREATE OR REPLACE PROCEDURE getComapnhiasEPortoesDisponiveisParaVoo(p_data_voo in voo.data_saida%type, 
    p_modelo_aeronave in AERONAVE.MODELO%type,
    v_rc out sys_refcursor) 
    IS  
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

    end;
/

create or replace procedure get_all_fligths(c_cursor out sys_refcursor)
    is
    begin
        open c_cursor for
            SELECT distinct * FROM VOO;       
    end;
/


CREATE or replace function get_company_id_by_frota_id(p_id_frota in frota.id_callsign%type ) return companhia_aerea.id_companhia_aerea%type
    is
        v_id_companhia_aerea companhia_aerea.id_companhia_aerea%type;

        cursor c_company(c_id_frota frota.id_callsign%type) is
            select ca.id_companhia_aerea from companhia_aerea ca
                inner join frota f on f.id_companhia_aerea = ca.id_companhia_aerea
                where f.id_companhia_aerea = c_id_frota;
    begin
        for c_company in c_company(p_id_frota) loop
            v_id_companhia_aerea := c_company.id_companhia_aerea;
        end loop;
        return v_id_companhia_aerea;
    end;
/

CREATE OR REPLACE PROCEDURE get_company_by_voo(p_id_voo in voo.id_voo%type, c_cursor out sys_refcursor)
    is
        v_id_companhia_aerea companhia_aerea.id_companhia_aerea%type;
    begin
        open c_cursor for 
            select ca.nome, V.DATA_CHEGADA, V.DATA_SAIDA, v.ID_COMPANHIA_AEREA from companhia_aerea ca
                inner join voo v on v.id_companhia_aerea = ca.id_companhia_aerea
                where v.id_voo = p_id_voo;
    end;
/

var cursorzin refcursor;
exec pegaPortoesDisponiveis(TO_DATE('2019/08/16 8:30:25', 'YYYY/MM/DD HH:MI:SS'), 30, :cursorzin); 
print cursorzin;

var otro refcursor;
EXECUTE get_company_by_voo(2, :otro);
print otro;

