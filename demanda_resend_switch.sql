
CREATE TABLE extensions.resend_switch (
    id serial4 NOT NULL,
    customer_id varchar(50) NULL,
    product_id int8 NULL,
    msisdn varchar(50) NOT NULL,
    origen varchar(10) NULL,
    status varchar(25) NULL,
    created_at timestamp NULL,
    updated_at timestamp NULL,
    CONSTRAINT pk_resend_switch PRIMARY KEY (id)
);
/

CREATE INDEX idx_created_at ON extensions.resend_switch (created_at);
/

CREATE OR REPLACE FUNCTION rw_claro_extensions.purge_old_resend_switch_data()
RETURNS void AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    lines_deleted INTEGER;
    total_lines_deleted INTEGER := 0;
BEGIN
    -- Registrar o tempo de início
    start_time := NOW();
    
    -- Imprimir os dados no log antes de deletar
    RAISE NOTICE 'Start time: %', start_time;

    -- Deletar as linhas e obter o número de linhas deletadas
    DELETE FROM rw_claro_extensions.bkp_resend_switch WHERE created_at < NOW() - INTERVAL '35 days';
    GET DIAGNOSTICS lines_deleted = ROW_COUNT;
    total_lines_deleted := total_lines_deleted + lines_deleted;

    -- Registrar o tempo final
    end_time := NOW();

    -- Imprimir os dados no log após deletar
    RAISE NOTICE 'Lines deleted: %, End time: %', lines_deleted, end_time;
    RAISE NOTICE 'Total lines deleted: %', total_lines_deleted;
END;
$$ LANGUAGE plpgsql;
/

/*
#!/bin/bash
PGPASSWORD="your_password" psql -h your_host -U your_user -d your_database -c "SELECT purge_old_resend_switch_data();
*/

INSERT INTO extensions.resend_switch (customer_id, product_id, msisdn, origen, status, created_at, updated_at)
VALUES
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
	(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now()),
    (md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now(), now());

/

INSERT INTO extensions.resend_switch (customer_id, product_id, msisdn, origen, status, created_at, updated_at)
VALUES 
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now()),
(md5(random()::text), (random() * 1000)::int, md5(random()::text), substring(md5(random()::text) from 1 for 10), substring(md5(random()::text) from 1 for 25), now() - interval '1 day', now());
/

	commit;
/


-- script para controle de linhas:
CREATE TABLE extensions.rows_table_lines (
    id serial PRIMARY KEY,
    data_atual timestamp NOT NULL DEFAULT now(),
    nm_esquema varchar(50) NOT NULL,
    nm_tabela varchar(50) NOT NULL,
    qtd_linhas int NOT NULL,
	dt_create timestamp
);


CREATE OR REPLACE FUNCTION archive_daily_inserts() RETURNS void LANGUAGE plpgsql AS $$
DECLARE
    v_qtd_linhas int;
    v_dt_create timestamp;
BEGIN
    -- Contar o número de linhas inseridas na tabela resend_switch no dia anterior
    SELECT COUNT(*), MAX(created_at) INTO v_qtd_linhas, v_dt_create
    FROM extensions.resend_switch
    WHERE created_at >= current_date - interval '1 day'
      AND created_at < current_date;

    -- Inserir a contagem na tabela rows_table_lines
    INSERT INTO rows_table_lines (data_atual, nm_esquema, nm_tabela, qtd_linhas, dt_create)
    VALUES (now(), 'extensions', 'resend_switch', v_qtd_linhas, v_dt_create);
END;
$$;
/


