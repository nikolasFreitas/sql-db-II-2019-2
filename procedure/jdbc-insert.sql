set serveroutput on;
CREATE OR REPLACE PROCEDURE insertAeronaveNaFrota (p_modelo_aeronave in varchar2, p_nome_companhia_aerea in varchar2)
    is
    v_aeronave_id AERONAVE.ID_AERONAVE%type;
    v_companhia_aerea COMPANHIA_AEREA.ID_COMPANHIA_AEREA%type;
    begin
        select id_aeronave into v_aeronave_id 
            from aeronave where modelo = p_modelo_aeronave;
            
        select id_companhia_aerea into v_companhia_aerea 
            from companhia_aerea where nome = p_nome_companhia_aerea;
            
        IF v_aeronave_id = null then
            raise_application_error(-20001,'Aeronave não enconrtada SQLCODE='||
                SQLCODE||' SQLERRM= ' ||SQLERRM );
            IF v_companhia_aerea = null then
                raise_application_error(-20001,'Companhia aerea não enconrtada SQLCODE='||
                    SQLCODE||' SQLERRM= ' ||SQLERRM );
                --INSERT INTO frota (id_callsign, id_aeronave, id_companhia_aerea) 
                  --  VALUES (sFrota.nextval, v_aeronave_id, v_companhia_aerea);
            end if;
        end if;
            INSERT INTO frota (id_callsign, id_aeronave, id_companhia_aerea) 
                VALUES (sFrota.nextval, v_aeronave_id, v_companhia_aerea);
    end;
/