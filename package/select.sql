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
    FUNCTION getFlightById(p_data_voo in voo.data_saida%type) RETURN VOO_TABLE_TEMPLATE pipelined;
END vooHandler;
/

CREATE OR REPLACE PACKAGE BODY vooHandler IS
    FUNCTION getFlightById(p_data_voo in voo.data_saida%type) RETURN VOO_TABLE_TEMPLATE pipelined
    is
        rec voo_record;        
            
    begin
        SELECT * INTO rec FROM VOO where data_saida > p_data_voo;
        PIPE ROW (rec);
        RETURN;
    end getFlightById;
END vooHandler;
/

create or replace procedure checkFilghtAvaliable(p_data_voo in voo.data_saida%type, v_rc out sys_refcursor)
    is
    begin
        OPEN v_rc FOR SELECT * FROM TABLE (vooHandler.getFlightById(p_data_voo));
    end;
/

var otro refcursor;
EXECUTE checkFilghtAvaliable(TO_DATE('2019/08/16 8:30:25', 'YYYY/MM/DD HH:MI:SS'), :otro);
-- EXECUTE checkFilghtAvaliable(1, :otro);
print otro;
show errors;