set serveroutput on;
-- Insert categoria
declare
    v_count number(2);
    v_nome categoria.nome%type := 'pequeno';
    v_quantidade CATEGORIA.QUANTIDADE%type := 30;
    begin
        FOR v_count in 1..3 loop
            if v_count = 2 then
                v_nome := 'Médio';
                v_quantidade := 90;
            elsif v_count = 3 then
                v_nome := 'granade';
                v_quantidade := 180;
            end if;            
            insert into categoria (id_categoria, nome, quantidade) 
                values (sCategoria.nextval, v_nome, v_quantidade );
        end LOOP;
    end;
    /

-- Insert portao
declare
    v_count number(2);
    v_id_categoria PORTAO.ID_CATEGORIA%type;
    v_disponibilidade PORTAO.DISPONIBILIDADE%type;
    begin
        for v_count IN 1..9 loop
            if MOD(v_count,2) = 0 then
                v_id_categoria := 2;                
                if v_count = 4 then                
                    v_disponibilidade := 0;
                else
                    v_disponibilidade := 1;
                end if;
            elsif MOD(v_count,3) = 0 then
                v_id_categoria := 3;
                v_disponibilidade := 1;
            else
                v_id_categoria := 1;
                v_disponibilidade := 1;
            end if;
            insert into portao (id_portao, id_categoria, disponibilidade)
                values (sPortao.nextval, v_id_categoria, v_disponibilidade);
        end loop;
    end;
/

-- Insert AERONAVE
declare
    v_count number(2);
    v_id_categoria AERONAVE.ID_AERONAVE%type;
    v_modelo AERONAVE.MODELO%type := 'CESNA';
    begin
        for v_count IN 1..4 loop
            if MOD(v_count,2) = 0 then
                v_id_categoria := 2;                
                if v_count = 4 then                
                    v_modelo := 'boing 727';
                else
                    v_modelo := 'boeing 737';
                end if;
            elsif MOD(v_count,3) = 0 then
                v_id_categoria := 3;
                v_modelo := 'airbus a319';
            else
                v_id_categoria := 1;
                v_modelo := 'King air';
            end if;
            insert into aeronave (id_aeronave, id_categoria, modelo)
                values (sAeronave.nextval, v_id_categoria, v_modelo);
        end loop;
    end;
/

-- Insert COMPANHIA AEREA
declare
    v_count number(2);
    v_nome COMPANHIA_AEREA.NOME%type := 'TAM';
    begin
        FOR v_count in 1..3 loop
            if v_count = 2 then
                v_nome := 'GOL';
            elsif v_count = 3 then
                v_nome := 'AZUL';
            end if;            
            insert into companhia_aerea (id_companhia_aerea, nome) 
                values (sCompAerea.nextval, v_nome );
        end LOOP;
    end;
    /
    
-- Insert FROTA
declare
    var_id_aeronave FROTA.ID_AERONAVE%type;
    var_id_companhia_aerea FROTA.ID_COMPANHIA_AEREA%type;
    CURSOR cAirComp is
        select id_aeronave from aeronave;
        
    CURSOR cCompanhia is 
        select id_companhia_aerea from companhia_aerea;
        
    begin
        for iAir IN cAirComp loop
            for iCompanhia IN cCompanhia LOOP
            var_id_aeronave := iAir.ID_AERONAVE;
            var_id_companhia_aerea := iCompanhia.ID_COMPANHIA_AEREA;
                IF var_id_companhia_aerea = 3 and iAir.ID_AERONAVE = 2 then
                    var_id_aeronave := 3;
                end if;
                IF var_id_companhia_aerea = 1 then
                    var_id_aeronave := 2;
                end if;
                insert into frota (id_callsign, id_aeronave, id_companhia_aerea)
                    values (sFrota.nextval, var_id_aeronave, var_id_companhia_aerea);
                
            END LOOP;
        end loop;
    end;
/

CREATE OR REPLACE FUNCTION isPortaoValid( p_id_aeronave in number, p_id_portao in number)
    return BOOLEAN
    is
        v_portao_qtd number(6);
        v_aeronave_qtd number(6);
    begin
        select C.quantidade into v_portao_qtd
            from portao p
            inner join categoria c on C.ID_CATEGORIA = P.ID_CATEGORIA
            where p_id_portao = P.ID_PORTAO;
            
        select C.quantidade into v_aeronave_qtd
            from aeronave A
            inner join categoria c on C.ID_CATEGORIA = A.ID_CATEGORIA
            where p_id_aeronave = A.ID_AERONAVE;
            
        return v_aeronave_qtd <= v_portao_qtd;
    end;
    /

declare
    v_portao PORTAO.ID_PORTAO%type;
    v_id_aeronave number(2);
    v_id_companhia_aerea number(2);
    v_last_id_aeronave number(2);
    v_last_id_companhia_aerea number(2);
    
    CURSOR cFrota is
        select id_aeronave, id_companhia_aerea from frota;
        
    CURSOR cPortao is
        select id_portao from portao;
    begin
        FOR fFrota in cFrota LOOP
            FOR fPortao in cPortao LOOP
                IF isPortaoValid(fFrota.id_aeronave, fPortao.id_portao) then
                    INSERT INTO VOO (id_voo, id_aeronave, id_companhia_aerea, data_chegada, date_saida)
                        values (sVoo.nextval, fFrota.id_aeronave, fFrota.id_companhia_aerea, TO_DATE('2019/08/15 8:30:25', 'YYYY/MM/DD HH:MI:SS'), TO_DATE('2019/08/21 8:30:25', 'YYYY/MM/DD HH:MI:SS'));
                else 
                    DBMS_OUTPUT.PUT_LINE('Deu FALSE');
                end if;
            END LOOP;
        END LOOP;
    end;
/
    