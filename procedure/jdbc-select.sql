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


create or replace procedure get_all_fligths(c_cursor out sys_refcursor)
    is
    begin
        open c_cursor for
            SELECT distinct * FROM VOO;       
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

