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

declare
    v_count number(2);
    v_id_categoria AERONAVE.ID_AERONAVE%type;
    v_modelo AERONAVE.MODELO%type;
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