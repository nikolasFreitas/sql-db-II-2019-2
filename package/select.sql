CREATE OR REPLACE PACKAGE vooHandler AUTHID DEFINER AS 
    TYPE voo_record IS RECORD (
        id_voo voo.id_voo%type,
        id_aeronave voo.id_aeronave%type,
        id_companhia_aerea voo.id_companhia_aerea%type,
        id_portao voo.id_portao%type,
        data_chegada voo.data_chegada%type,
        data_saida voo.data_saida%type
    );

    TYPE VOO_TABLE_TEMPLATE IS TABLE OF voo_record;
    FUNCTION getFlightByDate(p_data_voo in voo.data_saida%type) RETURN VOO_TABLE_TEMPLATE pipelined;
END vooHandler;
/

CREATE OR REPLACE PACKAGE BODY vooHandler IS
    FUNCTION getFlightByDate(p_data_voo in voo.data_saida%type) RETURN VOO_TABLE_TEMPLATE pipelined
    is      
        v_voo voo_record;
        cursor cVoo is
            SELECT * FROM VOO where data_saida > p_data_voo;
    begin
        for pVoo in cVoo loop
        v_voo.id_voo := pVoo.id_voo;
        v_voo.id_aeronave := pVoo.id_aeronave;
        v_voo.id_companhia_aerea := pVoo.id_companhia_aerea;
        v_voo.id_portao := pVoo.id_portao;
        v_voo.data_chegada := pVoo.data_chegada;
        v_voo.data_saida := pVoo.data_saida;
        PIPE ROW (v_voo);
        end loop;
        RETURN;
    end getFlightByDate;
END vooHandler;
/

create or replace procedure checkFilghtAvaliable(p_data_voo in voo.data_saida%type, v_rc out sys_refcursor)
    is
    begin
        OPEN v_rc FOR SELECT * FROM TABLE (vooHandler.getFlightByDate(p_data_voo));
    end;
/

var otro refcursor;
EXECUTE checkFilghtAvaliable(SYSDATE, :otro);
-- EXECUTE checkFilghtAvaliable(1, :otro);
print otro;
show errors;