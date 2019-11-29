CREATE OR REPLACE PACKAGE vooHandler AUTHID DEFINER AS
    TYPE portaoTableTemplate is record (
        id_portao portao.id_portao%type,
        id_categoria portao.id_categoria%type,
        disponibilidade portao.disponibilidade%type,
        id_companhia_aerea companhia_aerea.id_companhia_aerea%type,
        nome companhia_aerea.nome%type
    );
    
    TYPE  companhia_aereaTableTemplate IS TABLE OF portaoTableTemplate;
    
    FUNCTION pipeCompanhiaEportao(p_data_voo in voo.data_saida%type, 
    p_modelo_aeronave in AERONAVE.MODELO%type) RETURN companhia_aereaTableTemplate PIPELINED;
END vooHandler;
/

-- Quais companhias podem operar 
CREATE OR REPLACE PACKAGE BODY vooHandler IS
    FUNCTION pipeCompanhiaEportao(p_data_voo in voo.data_saida%type, 
    p_modelo_aeronave in AERONAVE.MODELO%type)
    RETURN companhia_aereaTableTemplate PIPELINED
    IS
        cursor cPortao(c_data_voo date, c_quantidade number) is
        select distinct p.* from portao p
            inner join categoria c on c.ID_CATEGORIA = P.ID_CATEGORIA
            inner join voo v on v.id_portao = p.id_portao
            where p.DISPONIBILIDADE != 0 
                and C.QUANTIDADE >= c_quantidade 
                and V.DATA_SAIDA <> c_data_voo 
                and v.data_chegada <> c_data_voo;

        cursor cAvailable(c_Portao portao.id_portao%type) is
            select distinct ca.id_companhia_aerea, ca.nome, p.id_portao, p.id_categoria, p.disponibilidade from companhia_aerea ca 
                inner join frota f on F.ID_COMPANHIA_AEREA = CA.ID_COMPANHIA_AEREA
                inner join AERONAVE A on A.ID_AERONAVE = F.ID_AERONAVE
                inner join categoria c on C.ID_CATEGORIA = A.ID_CATEGORIA
                inner join portao p on P.ID_CATEGORIA = C.ID_CATEGORIA
                where P.ID_PORTAO = c_Portao;

        v_quantidade_aeronave number;
        v_template_row portaoTableTemplate;

    BEGIN
        select c.QUANTIDADE into v_quantidade_aeronave from categoria c
            inner join AERONAVE a on a.id_categoria = c.id_categoria
            where a.MODELO = p_modelo_aeronave;

        for lPortao IN cPortao(p_data_voo, v_quantidade_aeronave) loop            
            for lAvailable in cAvailable(lPortao.id_portao) LOOP
            v_template_row.id_portao := lAvailable.id_portao;
            v_template_row.id_categoria := lAvailable.id_categoria;
            v_template_row.disponibilidade := lAvailable.disponibilidade;
            v_template_row.id_companhia_aerea := lAvailable.id_companhia_aerea;
            v_template_row.nome := lAvailable.nome;
            pipe ROW(v_template_row);
            END loop;
        end loop;
        return;
    END pipeCompanhiaEportao;

END vooHandler;
/

create or replace procedure pipeCompanhiaEportao(p_data_voo in voo.data_saida%type, 
    p_modelo_aeronave in AERONAVE.MODELO%type, v_rc out sys_refcursor)
    is
    begin
        OPEN v_rc FOR select * from table(vooHandler.pipeCompanhiaEportao(p_data_voo, p_modelo_aeronave));
    end;
/

var otro refcursor;
    EXECUTE pipeCompanhiaEportao(TO_DATE('2019/08/16 8:30:25', 'YYYY/MM/DD HH:MI:SS'), 'airbus a319', :otro);
print otro;
 