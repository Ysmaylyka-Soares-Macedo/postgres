-----> Rotina para cria as tabelas particiondas e indices a partir de uma data inicial:
DO $$
DECLARE
    start_date DATE := '2017-10-01'; 
    end_date DATE := CURRENT_DATE;
    partition_date DATE;
BEGIN
    partition_date := start_date;
    WHILE partition_date < end_date LOOP
        EXECUTE format('
            CREATE TABLE rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93.nova_subscription_renewal_history_%s PARTITION OF rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93.nova_subscription_renewal_history
            FOR VALUES FROM (''%s'') TO (''%s'');
            CREATE INDEX nova_renewal_history_cst_sub_idx_%s ON rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93.nova_subscription_renewal_history_%s USING btree (customer_id, subscription_id);
            CREATE INDEX nova_renewal_history_cst_sub_ren_idx_%s ON rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93.nova_subscription_renewal_history_%s USING btree (customer_id, subscription_id, renewal_id);
            CREATE INDEX nova_renewal_history_ren_ext_idx_%s ON rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93.nova_subscription_renewal_history_%s USING btree (renewal_id, external_id);
            CREATE INDEX nova_renewal_history_ren_pay_idx_%s ON rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93.nova_subscription_renewal_history_%s USING btree (renewal_id, payment_id);
        ',
        to_char(partition_date, 'YYYY_MM'),
        partition_date,
        partition_date + INTERVAL '1 month',
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM')
        );
        partition_date := partition_date + INTERVAL '1 month';
    END LOOP;
END $$;

-----> Tabela de controle fazer o calculo dos tempos:
CREATE TABLE controle_particionamento (
    id serial4 NOT NULL,
	nm_owner varchar(500) NULL,
	nm_tabela_part varchar(255) NOT NULL,
	dt_dia timestamptz NULL,
	dt_inicio timestamptz NULL,
	dt_fim timestamptz NULL,
	CONSTRAINT controle_particionamento_pkey PRIMARY KEY (id)
);

-----> Rotina para a cargas dos dados na tabela particionada:
DO $$
DECLARE
    v_data_inicio TIMESTAMP;
    v_data_fim TIMESTAMP;
    v_data_atual TIMESTAMP;
    v_nome_tabela VARCHAR(100) := 'payments';
    v_data_inicio_execucao TIMESTAMP;
    v_data_fim_execucao TIMESTAMP;
    v_nm_owner VARCHAR(100) := 'rw_claro_flex';
BEGIN
    -- Defina o intervalo de datas para a transferência
    v_data_inicio := '2024-03-05';
    v_data_fim := '2024-08-01';

    -- Loop dia a dia
    v_data_atual := v_data_inicio;
    WHILE v_data_atual <= v_data_fim LOOP
        BEGIN 
            -- Marcar o início da execução
            v_data_inicio_execucao := CURRENT_TIMESTAMP;
            RAISE NOTICE 'Iniciando processamento para a data: %', v_data_atual;

            -- Inserir na tabela de controle
            INSERT INTO rw_claro_flex.controle_particionamento (nm_owner,nm_tabela_part, dt_dia, dt_inicio, dt_fim)
            VALUES (v_nm_owner,v_nome_tabela, v_data_atual, v_data_inicio_execucao, null);
            RAISE NOTICE 'Inserido na tabela controle_particionamento para a data: %', v_data_atual;

            -- Transferir dados do dia atual
            INSERT INTO rw_claro_flex.payments_partition
            SELECT * FROM rw_claro_flex.payments
            WHERE event_timestamp BETWEEN v_data_atual AND v_data_atual + INTERVAL '1 day';

        EXCEPTION
            WHEN OTHERS THEN
                -- Tratar o erro aqui (por exemplo, registrar em uma tabela de log)
                RAISE NOTICE 'Erro ao processar a data %: %', v_data_atual, SQLERRM;
        END;
         -- Commit após cada dia de processamento
         COMMIT;

        -- Registrar na tabela de controle
        UPDATE rw_claro_flex.controle_particionamento
        SET dt_fim = CURRENT_TIMESTAMP, nm_owner = v_nm_owner
        WHERE id = (SELECT max(id) FROM rw_claro_flex.controle_particionamento);
        RAISE NOTICE 'Atualizado na tabela controle_particionamento para a data: %', v_data_atual;

        -- Avançar para o próximo dia
        v_data_atual := v_data_atual + INTERVAL '1 day';
       commit;
    END LOOP;
END
$$ LANGUAGE plpgsql;
/


DO $$
DECLARE
    v_data_inicio TIMESTAMP;
    v_data_fim TIMESTAMP;
    v_data_atual TIMESTAMP;
    v_nome_tabela VARCHAR(100) := 'subscription_renewal_history';
    v_data_inicio_execucao TIMESTAMP;
    v_data_fim_execucao TIMESTAMP;
    v_nm_owner VARCHAR(100) := 'rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93';
BEGIN
    -- Defina o intervalo de datas para a transferência
    v_data_inicio := '2021-05-02';
    v_data_fim := CURRENT_TIMESTAMP;

    -- Loop dia a dia
    v_data_atual := v_data_inicio;
    WHILE v_data_atual <= v_data_fim LOOP
        BEGIN
            -- Marcar o início da execução
            v_data_inicio_execucao := CURRENT_TIMESTAMP;
            RAISE NOTICE 'Iniciando processamento para a data: %', v_data_atual;

            -- Inserir na tabela de controle
            INSERT INTO v_nm_owner.controle_particionamento (nm_owner,nm_tabela_part, dt_dia, dt_inicio, dt_fim)
            VALUES (v_nm_owner,v_nome_tabela, v_data_atual, v_data_inicio_execucao, null);
            RAISE NOTICE 'Inserido na tabela controle_particionamento para a data: %', v_data_atual;

            -- Transferir dados do dia atual
            INSERT INTO v_nm_owner.subscription_renewal_history
            SELECT * FROM v_nm_owner."subscription_renewal_history_Old";

        EXCEPTION
            WHEN OTHERS THEN
                -- Tratar o erro aqui (por exemplo, registrar em uma tabela de log)
                RAISE NOTICE 'Erro ao processar a data %: %', v_data_atual, SQLERRM;
        END;
         -- Commit após cada dia de processamento
         COMMIT;

        -- Registrar na tabela de controle
        UPDATE v_nm_owner.controle_particionamento
        SET dt_fim = CURRENT_TIMESTAMP, nm_owner = v_nm_owner
        WHERE id = (SELECT max(id) FROM v_nm_owner.controle_particionamento);
        RAISE NOTICE 'Atualizado na tabela controle_particionamento para a data: %', v_data_atual;

        -- Avançar para o próximo dia
        v_data_atual := v_data_atual + INTERVAL '1 day';
       commit;
    END LOOP;
END
$$ LANGUAGE plpgsql;
/


psql -c "ALTER USER postgres WITH PASSWORD '123456';"

oci-certification

OCI CERTIFICATION ORACLE

/root/automacao/claro_nextel/scripts/postgresql/partition/transfere_dados_subscription_renewal_history.sql
/root/automacao/claro_nextel/scripts/postgresql/transfere_dados_subscription_renewal_history.sh


teste-realwave-claro-subscriptions-database-prd



enquanto isso, se puderem, por favor preencham esses dados?

Nome: Ysmaylyka Soares Macedo
Email zup: ysmaylyka.macedo@zup.com.br
RG: 20200571
CPF: 64591239349
Celular: 34 992097642
Data nas: 16/09/1992


YugabyteDB
CockroachDB


##################################################################################################################

DO $$
DECLARE
    v_data_inicio TIMESTAMP;
    v_data_fim TIMESTAMP;
    v_data_atual TIMESTAMP;
    v_nome_tabela VARCHAR(100) := 'payments';
    v_data_inicio_execucao TIMESTAMP;
    v_data_fim_execucao TIMESTAMP;
    v_nm_owner VARCHAR(100) := 'rw_claro_flex';
BEGIN
    -- Defina o intervalo de datas para a transferência
    v_data_inicio := '2024-03-05';
    v_data_fim := '2024-08-01';

    -- Loop dia a dia
    v_data_atual := v_data_inicio;
    WHILE v_data_atual <= v_data_fim LOOP
        BEGIN
            -- Marcar o início da execução
            v_data_inicio_execucao := CURRENT_TIMESTAMP;
            RAISE NOTICE 'Iniciando processamento para a data: %', v_data_atual;

            -- Inserir na tabela de controle
            INSERT INTO rw_claro_flex.controle_particionamento (nm_owner,nm_tabela_part, dt_dia, dt_inicio, dt_fim)
            VALUES (v_nm_owner,v_nome_tabela, v_data_atual, v_data_inicio_execucao, null);
            RAISE NOTICE 'Inserido na tabela controle_particionamento para a data: %', v_data_atual;

            -- Transferir dados do dia atual
            INSERT INTO rw_claro_flex.payments_partition
            SELECT * FROM rw_claro_flex.payments
            WHERE event_timestamp BETWEEN v_data_atual AND v_data_atual + INTERVAL '1 day';

        EXCEPTION
            WHEN OTHERS THEN
                -- Tratar o erro aqui (por exemplo, registrar em uma tabela de log)
                RAISE NOTICE 'Erro ao processar a data %: %', v_data_atual, SQLERRM;
        END;
         -- Commit após cada dia de processamento
         COMMIT;

        -- Registrar na tabela de controle
        UPDATE rw_claro_flex.controle_particionamento
        SET dt_fim = CURRENT_TIMESTAMP, nm_owner = v_nm_owner
        WHERE id = (SELECT max(id) FROM rw_claro_flex.controle_particionamento);
        RAISE NOTICE 'Atualizado na tabela controle_particionamento para a data: %', v_data_atual;

        -- Avançar para o próximo dia
        v_data_atual := v_data_atual + INTERVAL '1 day';
       commit;
    END LOOP;
END
$$ LANGUAGE plpgsql;



CREATE INDEX idx_renewal_history_timestamp ON rw_claro_flex.subscription_renewal_history USING btree (timestamp) include (event_id);


-- Privilegios:

GRANT select,insert,update, delete ON ALL TABLES IN SCHEMA "rw_extensions_chipflex_batch" TO "felipe.abreu";
ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_extensions_chipflex_batch" GRANT select,insert,update,delete ON TABLES TO "felipe.abreu";






Acesso ao webmail http://office.com
Login: ysmaylyka.macedo.3
Email: ysmaylyka.macedo.3@globalhitss.com.br
Kl3jP>8N2nua

6521495Ysl@


-- Verificar a quantidade de linhas (tabela de controle)
SELECT 
    EXTRACT(YEAR FROM "timestamp") AS ano, 
    EXTRACT(MONTH FROM "timestamp") AS mes, 
    COUNT(*) AS quantidade_linhas 
FROM 
    rw_claro_flex.subscription_renewal_history 
 WHERE 
     "timestamp" >= '2022-04-01' AND "timestamp" < '2018-03-01'
GROUP BY 
    EXTRACT(YEAR FROM "timestamp"), 
    EXTRACT(MONTH FROM "timestamp") 
ORDER BY 
    ano, 
    mes;
    /

-- Verificar linhas duplicadas
SELECT event_id, "timestamp", COUNT(*)
FROM rw_claro_flex.subscription_renewal_history
WHERE "timestamp" BETWEEN '2024-07-01 00:00:00' AND '2024-07-31 23:59:59'
GROUP BY event_id,"timestamp"
HAVING COUNT(*) > 1;  
/

-- Deletar linhas dentro de um intervalo de datas
DELETE FROM rw_claro_flex.nova_subscription_renewal_history WHERE DATE("timestamp") = '2022-04-19';
COMMIT;

-- Inserir dados dentro de um intervalo de datas
INSERT INTO rw_claro_flex.nova_subscription_renewal_history 
SELECT *
FROM rw_claro_flex.subscription_renewal_history
WHERE DATE("timestamp") = '2022-04-19';
/
2022-04-19


-- Verificar a quantidade de sessões
SELECT COUNT(*)
FROM pg_stat_activity
	WHERE datname = 'rw_extensions'
	AND state = 'idle';
	
-- Quantidade de locks
tb_get_locks 
SELECT 
    COUNT(*) 
FROM 
    pg_locks l
JOIN 
    pg_database d ON l.database = d.oid
WHERE 
    d.datname = 'rw_extensions';
    
    
-- Locks mais antigos   
SELECT 
    pg_stat_activity.datname, 
    pg_stat_activity.pid, 
    pg_stat_activity.usename, 
    pg_stat_activity.application_name, 
    pg_stat_activity.client_addr, 
    pg_stat_activity.client_port, 
    pg_stat_activity.query, 
    pg_locks.locktype, 
    pg_locks.mode, 
    pg_locks.granted, 
    pg_stat_activity.query_start, 
    NOW() - pg_stat_activity.query_start AS lock_duration 
FROM 
    pg_stat_activity 
JOIN 
    pg_locks 
ON 
    pg_stat_activity.pid = pg_locks.pid 
WHERE 
    pg_stat_activity.datname = 'rw_extensions' 
ORDER BY 
    lock_duration DESC;
  /
  
  -- locks atuais
  SELECT 
    pg_stat_activity.datname, 
    pg_stat_activity.pid, 
    pg_stat_activity.usename, 
    pg_stat_activity.application_name, 
    pg_stat_activity.client_addr, 
    pg_stat_activity.client_port, 
    pg_stat_activity.query, 
    pg_locks.locktype, 
    pg_locks.mode, 
    pg_locks.granted, 
    pg_stat_activity.query_start, 
    NOW() - pg_stat_activity.query_start AS lock_duration 
FROM 
    pg_stat_activity 
JOIN 
    pg_locks 
ON 
    pg_stat_activity.pid = pg_locks.pid 
WHERE 
    pg_stat_activity.datname = 'rw_extensions' 
ORDER BY 
    lock_duration ASC;
   
   
   /
   
-- Locks mais antigos com o comando terminator 
SELECT 
    pg_stat_activity.datname, 
    pg_stat_activity.pid, 
    pg_stat_activity.usename, 
    pg_stat_activity.application_name, 
    pg_stat_activity.client_addr, 
    pg_stat_activity.client_port, 
    pg_stat_activity.query, 
    pg_locks.locktype, 
    pg_locks.mode, 
    pg_locks.granted, 
    pg_stat_activity.query_start, 
    NOW() - pg_stat_activity.query_start AS lock_duration,
    'SELECT pg_terminate_backend(' || pg_stat_activity.pid || ');' AS terminate_command
FROM 
    pg_stat_activity 
JOIN 
    pg_locks 
ON 
    pg_stat_activity.pid = pg_locks.pid 
WHERE 
    pg_stat_activity.datname = 'rw_extensions'
   -- and pg_stat_activity.query like '%select camundav%'
ORDER BY 
    lock_duration DESC;
   
   /

-- bloco anonimo que mata sessões com locks de maior tempo de duração e apenas que começão com "select "
DO $$
DECLARE
    blocking_pid INT;
    terminate_command TEXT;
BEGIN
    FOR blocking_pid IN
        SELECT DISTINCT blocking_locks.pid AS blocking_pid, blocking_activity.query_start
        FROM pg_locks blocked_locks
        JOIN pg_stat_activity blocked_activity ON blocked_activity.pid = blocked_locks.pid
        JOIN pg_locks blocking_locks ON blocking_locks.locktype = blocked_locks.locktype
            AND blocking_locks.database = blocked_locks.database
            AND blocking_locks.relation = blocked_locks.relation
            AND blocking_locks.page = blocked_locks.page
            AND blocking_locks.tuple = blocked_locks.tuple
            AND blocking_locks.virtualxid = blocked_locks.virtualxid
            AND blocking_locks.transactionid = blocked_locks.transactionid
            AND blocking_locks.classid = blocked_locks.classid
            AND blocking_locks.objid = blocked_locks.objid
            AND blocking_locks.objsubid = blocked_locks.objsubid
            AND blocking_locks.pid != blocked_locks.pid
        JOIN pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
        WHERE NOT blocked_locks.granted
            AND blocked_activity.datname = 'rw_extensions'
            AND blocked_activity.query LIKE 'select %'
        ORDER BY blocking_activity.query_start
    LOOP
        terminate_command := 'SELECT pg_terminate_backend(' || blocking_pid || ');';
        EXECUTE terminate_command;
        RAISE NOTICE 'Terminated blocking session with PID: %', blocking_pid;
    END LOOP;
END $$;
####################################################################################################################

-- Criar o indice pelo timestamp
# Cria indice
#psql -q -A -t -c "Create index idx_payments_event_timestamp on rw_claro_flex.payments(event_timestamp) include(event_id);" > $OUTPUTFILE 2>&1 &
# psql -f $QUERYFILE > $OUTPUTFILE 2>&1 &

# Criar indice da subscription
export PGHOST=teste-realwave-claro-subscriptions-database-prd.flexprd.aws.clarobrasil.mobi
export PGUSER=usr_manutencao
export PGPASSWORD=##*!M_nUT3nCa0*2021**!#
export PGDATABASE=rw_subscriptions_manager
dataexec=`date +"%Y%m%d%H%M%S"`
export OUTPUTFILE="/root/automacao/claro_nextel/logs/postgresql/indices/indices-subscription-$dataexec.log"
export QUERYFILE="/root/automacao/claro_nextel/scripts/postgresql/criar_indice.sql"

# Cria indice
psql -q -A -t -c "CREATE INDEX idx_renewal_history_timestamp ON rw_claro_flex.subscription_renewal_history USING btree (timestamp) include (event_id);" > $OUTPUTFILE 2>&1 &
psql -f $QUERYFILE > $OUTPUTFILE 2>&1 &


- Criar nova tabela particionada 
CREATE TABLE rw_claro_flex.nova_subscription_renewal_history (
	event_id varchar(40) NOT NULL,
	renewal_id varchar(40) NOT NULL,
	customer_id varchar(40) NOT NULL,
	subscription_id varchar(40) NOT NULL,
	scheduled_to timestamp NOT NULL,
	due_at date NOT NULL,
	"timestamp" timestamp NOT NULL,
	status varchar(50) NOT NULL,
	"data" text NULL,
	attempt int4 DEFAULT 0 NOT NULL,
	payment_id varchar(100) NULL,
	external_id varchar(100) NULL,
	CONSTRAINT nova_subscription_renewal_history_pkey PRIMARY KEY (event_id,"timestamp")
)
PARTITION BY RANGE ("timestamp");
/

-- Cria partições e indices da nova tabela particionada
DO $$
DECLARE
    start_date DATE := '2017-12-01';
    end_date DATE := CURRENT_DATE;
    partition_date DATE;
BEGIN
    partition_date := start_date;
    WHILE partition_date < end_date LOOP
        EXECUTE format('
            CREATE TABLE rw_claro_flex.nova_subscription_renewal_history_%s PARTITION OF rw_claro_flex.nova_subscription_renewal_history
            FOR VALUES FROM (''%s'') TO (''%s'');
            CREATE INDEX nova_renewal_history_cst_sub_idx_%s ON rw_claro_flex.nova_subscription_renewal_history_%s USING btree (customer_id, subscription_id);
            CREATE INDEX nova_renewal_history_cst_sub_ren_idx_%s ON rw_claro_flex.nova_subscription_renewal_history_%s USING btree (customer_id, subscription_id, renewal_id);
            CREATE INDEX nova_renewal_history_ren_ext_idx_%s ON rw_claro_flex.nova_subscription_renewal_history_%s USING btree (renewal_id, external_id);
            CREATE INDEX nova_renewal_history_ren_pay_idx_%s ON rw_claro_flex.nova_subscription_renewal_history_%s USING btree (renewal_id, payment_id);
        ',
        to_char(partition_date, 'YYYY_MM'),
        partition_date,
        partition_date + INTERVAL '1 month',
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM'),
        to_char(partition_date, 'YYYY_MM')
        );
        partition_date := partition_date + INTERVAL '1 month';
    END LOOP;
END $$



-- Privilegios em todas as tabelas do schema
GRANT select,insert,update, delete ON ALL TABLES IN SCHEMA "rw_extensions_chipflex_batch" TO "felipe.abreu";
-- Privilegios para os objetos novos
ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_extensions_chipflex_batch" GRANT select,insert,update,delete ON TABLES TO "felipe.abreu";
/


DO $$
DECLARE
    v_data_inicio TIMESTAMP;
    v_data_fim TIMESTAMP;
    v_data_atual TIMESTAMP;
    v_nome_tabela VARCHAR(100) := 'subscription_renewal_history';
    v_data_inicio_execucao TIMESTAMP;
    v_data_fim_execucao TIMESTAMP;
    v_nm_owner VARCHAR(100) := 'rw_claro_flex';
BEGIN
    -- Defina o intervalo de datas para a transferência
    v_data_inicio := '2017-12-01';
    v_data_fim := CURRENT_TIMESTAMP;

    -- Loop dia a dia
    v_data_atual := v_data_inicio;
    WHILE v_data_atual <= v_data_fim LOOP
        BEGIN
            -- Marcar o início da execução
            v_data_inicio_execucao := CURRENT_TIMESTAMP;
            RAISE NOTICE 'Iniciando processamento para a data: %', v_data_atual;

            -- Inserir na tabela de controle
            INSERT INTO rw_claro_flex.controle_particionamento (nm_owner,nm_tabela_part, dt_dia, dt_inicio, dt_fi                                                                                                                                                                                                            m)
            VALUES (v_nm_owner,v_nome_tabela, v_data_atual, v_data_inicio_execucao, null);
            RAISE NOTICE 'Inserido na tabela controle_particionamento para a data: %', v_data_atual;

            -- Transferir dados do dia atual
            INSERT INTO rw_claro_flex.nova_subscription_renewal_history
            SELECT * FROM rw_claro_flex.subscription_renewal_history
            WHERE "timestamp" BETWEEN v_data_atual AND v_data_atual + INTERVAL '1 day';

        EXCEPTION
            WHEN OTHERS THEN
                -- Tratar o erro aqui (por exemplo, registrar em uma tabela de log)
                RAISE NOTICE 'Erro ao processar a data %: %', v_data_atual, SQLERRM;
        END;
         -- Commit após cada dia de processamento
         COMMIT;

        -- Registrar na tabela de controle
        UPDATE rw_claro_flex.controle_particionamento
        SET dt_fim = CURRENT_TIMESTAMP, nm_owner = v_nm_owner
        WHERE id = (SELECT max(id) FROM rw_claro_flex.controle_particionamento);
        RAISE NOTICE 'Atualizado na tabela controle_particionamento para a data: %', v_data_atual;

        -- Avançar para o próximo dia
        v_data_atual := v_data_atual + INTERVAL '1 day';
       commit;
    END LOOP;
END
$$ LANGUAGE plpgsql;






posto mineirão -  afonso pena

cloud partition AWS


---
layout: default
published: true
title: QA
parent: Onboarding
permalink: onboarding/qa
---

# Onboarding de QA
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

Bem-vindo à equipe de Garantia de Qualidade (QA)! Este guia o ajudará a entender nossas práticas e processos de QA. Estamos animados para ter você conosco!

## Conteúdo em construção...


SELECT 
EXTRACT(YEAR FROM dt_dia) AS ano, 
EXTRACT(MONTH FROM dt_dia) AS mes, 
ROUND(SUM(EXTRACT(EPOCH FROM (dt_fim - dt_inicio)) / 3600)) || ' horas ' || 
ROUND(SUM((EXTRACT(EPOCH FROM (dt_fim - dt_inicio)) % 3600) / 60)) || ' minutos' AS tempo_execucao
FROM 
rw_claro_flex.controle_particionamento
GROUP BY 
EXTRACT(YEAR FROM dt_dia), 
EXTRACT(MONTH FROM dt_dia)
ORDER BY 
ano, 
mes;


GRANT SELECT ON TABLE rw_claro_extensions.to_renew_bonus TO usr_metabase_leitura;



SELECT 
    EXTRACT(YEAR FROM "timestamp") AS ano, 
    EXTRACT(MONTH FROM "timestamp") AS mes, 
    COUNT(*) AS quantidade_linhas 
FROM 
    rw_claro_flex.nova_subscription_renewal_history 
WHERE 
    "timestamp" >= '2018-01-01' AND "timestamp" < '2018-02-01'
GROUP BY 
    EXTRACT(YEAR FROM "timestamp"), 
    EXTRACT(MONTH FROM "timestamp") 
ORDER BY 
    ano, 
    mes;
/

SELECT 
    EXTRACT(YEAR FROM "timestamp") AS ano, 
    EXTRACT(MONTH FROM "timestamp") AS mes, 
    COUNT(*) AS quantidade_linhas 
FROM 
    rw_claro_flex.subscription_renewal_history 
WHERE 
    "timestamp" >= '2018-01-01' AND "timestamp" < '2018-02-01'
GROUP BY 
    EXTRACT(YEAR FROM "timestamp"), 
    EXTRACT(MONTH FROM "timestamp") 
ORDER BY 
    ano, 
    mes;
########################################################################################################################

-- ************ COMANDOS PSQL

--Listar bancos de dados:
\l
--Conectar a um banco de dados específico:
\c <database_name>
--Listar tabelas no banco de dados atual:
\dt
--Executar uma consulta SQL:
SELECT * FROM <table_name>;
--Sair do psql:
\q
-- *************** FIM DOS COMANDOS




-----> Copia de usuário espelho para novo:
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT table_name, ARRAY_AGG(privilege_type) AS privileges
        FROM information_schema.role_table_grants
        WHERE grantee = 'user1'
        GROUP BY table_name
    LOOP
        RAISE NOTICE 'GRANT % ON TABLE % TO user2;', array_to_string(r.privileges, ', '), r.table_name;
    END LOOP;
END
$$;

#######################################################################################################################

CREATE SCHEMA subscription;

CREATE TABLE subscription.tb_subscription1 (
    id SERIAL PRIMARY KEY,
    texto VARCHAR(255),
    numero INTEGER
);

CREATE TABLE subscription.tb_subscription2 (
    id SERIAL PRIMARY KEY,
    texto VARCHAR(255),
    numero INTEGER
);

CREATE TABLE subscription.tb_subscription3 (
    id SERIAL PRIMARY KEY,
    texto VARCHAR(255),
    numero INTEGER
);



CREATE TABLE payments.tb_payments1 (
    id SERIAL PRIMARY KEY,
    texto VARCHAR(255),
    numero INTEGER
);

CREATE TABLE payments.tb_payments2 (
    id SERIAL PRIMARY KEY,
    texto VARCHAR(255),
    numero INTEGER
);

CREATE TABLE payments.tb_payments3 (
    id SERIAL PRIMARY KEY,
    texto VARCHAR(255),
    numero INTEGER
);


CREATE USER maria WITH PASSWORD '123';
CREATE USER alex WITH PASSWORD '123';
CREATE USER bia WITH PASSWORD '123';
CREATE USER marcos WITH PASSWORD '123';
CREATE USER lara WITH PASSWORD '123';


GRANT INSERT, UPDATE, DELETE ON TABLE subscription.tb_subscription3 TO maria;

SELECT table_schema, table_name, privilege_type
        FROM information_schema.role_table_grants
        WHERE grantee = 'alex';

/
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT table_schema, table_name, privilege_type
        FROM information_schema.role_table_grants
        WHERE grantee = 'maria'
    LOOP
        EXECUTE format('GRANT %s ON TABLE %I.%I TO "%s";', r.privilege_type, r.table_schema, r.table_name, 'alex');
    END LOOP;
END
$$;

----

DO $$
DECLARE
    r RECORD;
    t RECORD;
    seq RECORD;
    s RECORD;
    priv RECORD;
BEGIN
    -- Loop through all schemas
    FOR r IN (SELECT schema_name FROM information_schema.schemata) LOOP
        -- Loop through all tables in the current schema
        FOR t IN (SELECT table_name FROM information_schema.tables WHERE table_schema = r.schema_name) LOOP
            -- Grant all table privileges that maria has to alex
            FOR priv IN (SELECT privilege_type FROM information_schema.role_table_grants WHERE grantee = 'maria' AND table_schema = r.schema_name AND table_name = t.table_name) LOOP
                EXECUTE format('GRANT %I ON TABLE %I.%I TO alex', priv.privilege_type, r.schema_name, t.table_name);
            END LOOP;
        END LOOP;

        -- Loop through all sequences in the current schema
        FOR seq IN (SELECT sequence_name FROM information_schema.sequences WHERE sequence_schema = r.schema_name) LOOP
            -- Grant all sequence privileges that maria has to alex
            FOR priv IN (SELECT privilege_type FROM information_schema.role_usage_grants WHERE grantee = 'maria' AND object_schema = r.schema_name AND object_name = seq.sequence_name) LOOP
                EXECUTE format('GRANT %I ON SEQUENCE %I.%I TO alex', priv.privilege_type, r.schema_name, seq.sequence_name);
            END LOOP;
        END LOOP;

        -- Grant USAGE on the schema if maria has it
        IF EXISTS (SELECT 1 FROM information_schema.role_usage_grants WHERE grantee = 'maria' AND object_schema = r.schema_name) THEN
            EXECUTE format('GRANT USAGE ON SCHEMA %I TO alex', r.schema_name);
        END IF;

        -- Grant EXECUTE on all functions in the schema
        FOR s IN (SELECT routine_name FROM information_schema.routines WHERE routine_schema = r.schema_name) LOOP
            -- Grant all function privileges that maria has to alex
            FOR priv IN (SELECT privilege_type FROM information_schema.role_routine_grants WHERE grantee = 'maria' AND routine_schema = r.schema_name AND routine_name = s.routine_name) LOOP
                EXECUTE format('GRANT %I ON FUNCTION %I.%I TO alex', priv.privilege_type, r.schema_name, s.routine_name);
            END LOOP;
        END LOOP;
    END LOOP;
END $$;

-- Script de conexão

DO $$
DECLARE
    r RECORD;
    t RECORD;
    seq RECORD;
    s RECORD;
    priv RECORD;
BEGIN
    -- Loop through all schemas
    FOR r IN (SELECT schema_name FROM information_schema.schemata) LOOP
        -- Loop through all tables in the current schema
        FOR t IN (SELECT table_name FROM information_schema.tables WHERE table_schema = r.schema_name) LOOP
            -- Grant all table privileges that maria has to alex
            FOR priv IN (SELECT privilege_type FROM information_schema.role_table_grants WHERE grantee = 'maria' AND table_schema = r.schema_name AND table_name = t.table_name) LOOP
                EXECUTE format('GRANT %I ON TABLE %I.%I TO alex', priv.privilege_type, r.schema_name, t.table_name);
            END LOOP;
        END LOOP;

        -- Loop through all sequences in the current schema
        FOR seq IN (SELECT sequence_name FROM information_schema.sequences WHERE sequence_schema = r.schema_name) LOOP
            -- Grant all sequence privileges that maria has to alex
            FOR priv IN (SELECT privilege_type FROM information_schema.role_usage_grants WHERE grantee = 'maria' AND object_schema = r.schema_name AND object_name = seq.sequence_name) LOOP
                EXECUTE format('GRANT %I ON SEQUENCE %I.%I TO alex', priv.privilege_type, r.schema_name, seq.sequence_name);
            END LOOP;
        END LOOP;

        -- Grant USAGE on the schema if maria has it
        IF EXISTS (SELECT 1 FROM information_schema.role_usage_grants WHERE grantee = 'maria' AND object_schema = r.schema_name) THEN
            EXECUTE format('GRANT USAGE ON SCHEMA %I TO alex', r.schema_name);
        END IF;

        -- Grant EXECUTE on all functions in the schema
        FOR s IN (SELECT routine_name FROM information_schema.routines WHERE routine_schema = r.schema_name) LOOP
            -- Grant all function privileges that maria has to alex
            FOR priv IN (SELECT privilege_type FROM information_schema.role_routine_grants WHERE grantee = 'maria' AND routine_schema = r.schema_name AND routine_name = s.routine_name) LOOP
                EXECUTE format('GRANT %I ON FUNCTION %I.%I TO alex', priv.privilege_type, r.schema_name, s.routine_name);
            END LOOP;
        END LOOP;
    END LOOP;
END $$;


DO $$
DECLARE
    dbname RECORD;
    username text := 'lara'; -- Defina o nome do usuário aqui
BEGIN
    FOR dbname IN SELECT datname FROM pg_catalog.pg_database WHERE datname NOT IN ('postgres', 'rdsadmin', 'template0', 'template1') LOOP
        EXECUTE 'GRANT CONNECT ON DATABASE ' || quote_ident(dbname.datname) || ' TO ' || quote_ident(username) || ';';
    END LOOP;
END;
$$ LANGUAGE plpgsql;


ALTER USER postgres WITH PASSWORD '123456';

ALTER USER lara WITH SUPERUSER;


GRANT ALL PRIVILEGES ON SCHEMA public TO zup;
GRANT ALL PRIVILEGES ON DATABASE redundancia TO lara;
/


CREATE ROLE zup WITH 
	NOSUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	LOGIN
	NOREPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1
	VALID UNTIL 'infinity';

GRANT rds_superuser TO zup;


CREATE ROLE rds_superuser WITH 
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOLOGIN
	NOREPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1;

GRANT pg_monitor TO rds_superuser;
GRANT pg_signal_backend TO rds_superuser;
GRANT rds_password TO rds_superuser;
GRANT rds_replication TO rds_superuser;


CREATE ROLE "patricia.abreu" WITH 
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	LOGIN
	NOREPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1;
	
	CREATE ROLE "gabriel.cardoso" WITH 
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	LOGIN
	NOREPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1;

GRANT usr_claro TO "gabriel.cardoso";

-- DROP SCHEMA bi_claro_flex;

CREATE SCHEMA bi_claro_flex AUTHORIZATION zup;


-- Permissions

ALTER DEFAULT PRIVILEGES IN SCHEMA bi_claro_flex GRANT DELETE, SELECT, UPDATE, INSERT ON TABLES TO "diego.ramos";
ALTER DEFAULT PRIVILEGES IN SCHEMA bi_claro_flex GRANT DELETE, REFERENCES, TRIGGER, SELECT, TRUNCATE, UPDATE, INSERT ON TABLES TO zup_claro;
ALTER DEFAULT PRIVILEGES IN SCHEMA bi_claro_flex GRANT DELETE, SELECT, UPDATE, INSERT ON TABLES TO "sheiline.arcelino";
ALTER DEFAULT PRIVILEGES IN SCHEMA bi_claro_flex GRANT DELETE, SELECT, UPDATE, INSERT ON TABLES TO "guilherme.pimenta";
ALTER DEFAULT PRIVILEGES IN SCHEMA bi_claro_flex GRANT SELECT ON TABLES TO "rafael.sesso";
ALTER DEFAULT PRIVILEGES IN SCHEMA bi_claro_flex GRANT DELETE, SELECT, UPDATE, INSERT ON TABLES TO "eduardo.delfino";
ALTER DEFAULT PRIVILEGES IN SCHEMA bi_claro_flex GRANT SELECT ON TABLES TO db_datareader;
ALTER DEFAULT PRIVILEGES IN SCHEMA bi_claro_flex GRANT DELETE, UPDATE, INSERT ON TABLES TO db_datawriter;
ALTER DEFAULT PRIVILEGES IN SCHEMA bi_claro_flex GRANT SELECT ON TABLES TO "gabriel.cardoso";
ALTER DEFAULT PRIVILEGES IN SCHEMA bi_claro_flex GRANT SELECT ON TABLES TO "gabriela.jardim";
ALTER DEFAULT PRIVILEGES IN SCHEMA bi_claro_flex GRANT SELECT ON TABLES TO "eder.moraes";



psql -h bi-etl-claro-prd.flexprd.aws.clarobrasil.mobi -p 5432 -U usr_manutencao -d bi_claro_report


criptografia em transito
pq_repack
pgaudit



DO $$
DECLARE
    source_table text := 'tb_subscription1'; -- Substitua pelo nome da tabela de origem
    source_owner text := 'subscription'; -- Substitua pelo nome do owner da tabela de origem
    target_table text := 'tb_extensions1'; -- Substitua pelo nome da tabela de destino
    target_owner text := 'extensions'; -- Substitua pelo nome do owner da tabela de destino
    privilege_record record;
BEGIN
    FOR privilege_record IN
        SELECT grantee, privilege_type
        FROM information_schema.role_table_grants
        WHERE table_name = source_table AND table_schema = source_owner
    LOOP
        EXECUTE format('GRANT %s ON TABLE %I.%I TO %I', privilege_record.privilege_type, target_owner, target_table, privilege_record.grantee);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

###################################################################################################################

-- Conexão EXTENSION-SIT
host: rds-extensions-sit.flexdev.aws.clarobrasil.mobi
user: usr-extensions-sit
password: 33i*HgPW^foP

-- Conexão REALWAVE-SIT
host: rds-realwave-sit.flexdev.aws.clarobrasil.mobi
user: usr-realwave-sit
password: y=ad1GWQ^[{s

###################################################################################################################


------> Quantidade de locks
tb_get_locks 
SELECT 
    COUNT(*) 
FROM 
    pg_locks l
JOIN 
    pg_database d ON l.database = d.oid
WHERE 
    d.datname = 'rw_extensions';
	
------> Locks mais antigos   
SELECT 
    pg_stat_activity.datname, 
    pg_stat_activity.pid, 
    pg_stat_activity.usename, 
    pg_stat_activity.application_name, 
    pg_stat_activity.client_addr, 
    pg_stat_activity.client_port, 
    pg_stat_activity.query, 
    pg_locks.locktype, 
    pg_locks.mode, 
    pg_locks.granted, 
    pg_stat_activity.query_start, 
    NOW() - pg_stat_activity.query_start AS lock_duration 
FROM 
    pg_stat_activity 
JOIN 
    pg_locks 
ON 
    pg_stat_activity.pid = pg_locks.pid 
WHERE 
    pg_stat_activity.datname = 'rw_extensions' 
ORDER BY 
    lock_duration DESC;
  
------> locks atuais
  SELECT 
    pg_stat_activity.datname, 
    pg_stat_activity.pid, 
    pg_stat_activity.usename, 
    pg_stat_activity.application_name, 
    pg_stat_activity.client_addr, 
    pg_stat_activity.client_port, 
    pg_stat_activity.query, 
    pg_locks.locktype, 
    pg_locks.mode, 
    pg_locks.granted, 
    pg_stat_activity.query_start, 
    NOW() - pg_stat_activity.query_start AS lock_duration 
FROM 
    pg_stat_activity 
JOIN 
    pg_locks 
ON 
    pg_stat_activity.pid = pg_locks.pid 
WHERE 
    pg_stat_activity.datname = 'rw_extensions' 
ORDER BY 
    lock_duration ASC;
	
------> Locks mais antigos com o comando terminator 
SELECT 
    pg_stat_activity.datname, 
    pg_stat_activity.pid, 
    pg_stat_activity.usename, 
    pg_stat_activity.application_name, 
    pg_stat_activity.client_addr, 
    pg_stat_activity.client_port, 
    pg_stat_activity.query, 
    pg_locks.locktype, 
    pg_locks.mode, 
    pg_locks.granted, 
    pg_stat_activity.query_start, 
    NOW() - pg_stat_activity.query_start AS lock_duration,
    'SELECT pg_terminate_backend(' || pg_stat_activity.pid || ');' AS terminate_command
FROM 
    pg_stat_activity 
JOIN 
    pg_locks 
ON 
    pg_stat_activity.pid = pg_locks.pid 
WHERE 
    pg_stat_activity.datname = 'rw_extensions'
   -- and pg_stat_activity.query like '%select camundav%'
ORDER BY 
    lock_duration DESC;

------> bloco anonimo que mata sessões com locks de maior tempo de duração e apenas que começão com "select "
DO $$
DECLARE
    blocking_pid INT;
    terminate_command TEXT;
BEGIN
    FOR blocking_pid IN
        SELECT DISTINCT blocking_locks.pid AS blocking_pid, blocking_activity.query_start
        FROM pg_locks blocked_locks
        JOIN pg_stat_activity blocked_activity ON blocked_activity.pid = blocked_locks.pid
        JOIN pg_locks blocking_locks ON blocking_locks.locktype = blocked_locks.locktype
            AND blocking_locks.database = blocked_locks.database
            AND blocking_locks.relation = blocked_locks.relation
            AND blocking_locks.page = blocked_locks.page
            AND blocking_locks.tuple = blocked_locks.tuple
            AND blocking_locks.virtualxid = blocked_locks.virtualxid
            AND blocking_locks.transactionid = blocked_locks.transactionid
            AND blocking_locks.classid = blocked_locks.classid
            AND blocking_locks.objid = blocked_locks.objid
            AND blocking_locks.objsubid = blocked_locks.objsubid
            AND blocking_locks.pid != blocked_locks.pid
        JOIN pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
        WHERE NOT blocked_locks.granted
            AND blocked_activity.datname = 'rw_extensions'
            AND blocked_activity.query LIKE 'select %'
        ORDER BY blocking_activity.query_start
    LOOP
        terminate_command := 'SELECT pg_terminate_backend(' || blocking_pid || ');';
        EXECUTE terminate_command;
        RAISE NOTICE 'Terminated blocking session with PID: %', blocking_pid;
    END LOOP;
END $$;

#######################################################################################################

VPC
vpc_flex_sit_us_east (vpc-0fa026db9ea0ff51d)

Grupo de sub-redes
flex-realwave-sit-subnet-group

Grupos de segurança da VPC
rds-flex-realwave-sit (sg-0cde7746f4a14fe00)


Autoridade de certificação
Informações
rds-ca-rsa2048-g1

flex-sonarqube-sit



rds-sonarqube-sit.flexdev.aws.clarobrasil.mobi
QKR.Gaq#Dj&Gw7#mMX


SONARQUBE
LUz)QFtN,9@kXt%wyZ


Acessos : 
Instancia: rds-tools-sit
endpoint: rds-tools-sit.flexdev.aws.clarobrasil.mobi
porta: 5432
user: sonarqube
senha: LUz)QFtN,9@kXt%wyZ


https://github.com/ZupIT/claro-flex-iac

git github julio arruda youtube


Euler Florentino
16:44
https://github.com/ZupIT/claro-flex-iac
Euler Florentino
16:46
https://zup.service-now.com/sp?id=sc_cat_item&sys_id=df3d8e471b643c10cd8bda8fe54bcb7d
Euler Florentino
16:47
github/ZupIT ao time iupp-infra-rw
sre-claro-flex-adm

Não exite um versiculo preciso que fala sobre Bispa. Contudo, existe um uma passagem que 
fala: Estando ele ainda falando com eles, veio Raquel com as ovelhas de seu pai; porque ela era pastora”.(Gênesis 29:9) Com isso, relativamente quando 
vamos para a reveção do que Deus que nos falar com isso, é alinhado um paralelo onde ovelhas e peixe, são considerado as pessoas que devemos cuida e evangelizar nessa terra. Nesse caso, o pai de Raquel
é o nosso Pai do Ceu, e as ovelhas, são as pessoas que ela está cuidando. Perceba que Raquel está cuidando da herança de seu pai, como a palavra diz: "Agora, eu os entrego a Deus e à palavra da sua graça, que pode edificá-los e 
dar-lhes herança entre todos os que são santificados.(Atos dos Apóstolos 20:32). 

Um outro ponto que devemos observar, é a doutrina de cada igreja. 
Exitem denominações, que tem visão celular e outras não, umas que tem regente e outras não, Outras que tem levitas e outras não. 
Se escolhemos está naquela comunidade/congregação, é buscar obedecer as lideranças que contituem aquela congregação, como diz a palavra: 
"Obedeçam aos seus líderes e sejam submissos a eles, pois zelam pela alma de vocês, como quem deve prestar contas. Que eles possam fazer isto com alegria e não gemendo; 
do contrário, isso não trará proveito nenhum para vocês (Hebreus 13:17). 

Espero ter esclarecido um pouco, que Deus abençoe! 
###########################################################################################################



SELECT *
FROM
  (
  SELECT 10 AS Position, 'Deployments' AS Metric, COUNT(*) AS Count FROM ACT_RE_DEPLOYMENT
  UNION SELECT 11, 'Process Definitions', COUNT(*) FROM (SELECT DISTINCT KEY_ FROM ACT_RE_PROCDEF) AS PROCDEF
  UNION SELECT 12, 'Process Definition Versions', COUNT(*) FROM ACT_RE_PROCDEF
  UNION SELECT 20, 'Activity Instances', COUNT(*) FROM ACT_HI_ACTINST
  UNION SELECT 21, 'Process Instances', COUNT(*) FROM ACT_HI_PROCINST
  UNION SELECT 22, 'Process Instances (finished)', COUNT(*) FROM ACT_HI_PROCINST WHERE END_TIME_ IS NOT NULL
  UNION SELECT 30, 'Process Instances (running)', COUNT(*) FROM ACT_RU_EXECUTION WHERE PARENT_ID_ IS NULL
  UNION SELECT 30.1, 'Executions (running)', COUNT(*) FROM ACT_RU_EXECUTION
  UNION SELECT 31, 'User Tasks', COUNT(*) FROM ACT_RU_TASK
  UNION SELECT 32, 'User Tasks (unassigned)', COUNT(*) FROM ACT_RU_TASK WHERE ASSIGNEE_ IS NULL
  UNION SELECT 40, 'Event Subscriptions', COUNT(*) FROM ACT_RU_EVENT_SUBSCR
  UNION SELECT 41, 'Event Subscriptions (type: ' ||
    EVENT_TYPE_ ||
    CASE WHEN PROC_INST_ID_ IS NULL THEN ' start' ELSE 'intermediate' END || ')' AS Metric,
    COUNT(*) FROM ACT_RU_EVENT_SUBSCR
    GROUP BY Metric
  UNION SELECT 50, 'Jobs', COUNT(*) FROM ACT_RU_JOB
  UNION SELECT 51, 'Jobs (running)', COUNT(*) FROM ACT_RU_JOB
    WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ >= NOW())
  UNION SELECT 51.0, 'Jobs (running, node=' || LOCK_OWNER_ || ')', COUNT(*) FROM ACT_RU_JOB
    WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ >= NOW())
    GROUP BY LOCK_OWNER_
  UNION SELECT 51.1, 'Jobs (running at prio: ' || PRIORITY_ || ')',
    COUNT(*)  FROM ACT_RU_JOB
    WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ >= NOW())
    GROUP BY PRIORITY_
  UNION SELECT 52, 'Jobs (due)', COUNT(*) FROM ACT_RU_JOB
    WHERE (RETRIES_ > 0)
    AND (DUEDATE_ IS NULL OR DUEDATE_ < NOW())
    AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW())
    AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
  UNION SELECT 52.1, 'Jobs (due at prio: ' || PRIORITY_ || ')',
    COUNT(*) FROM ACT_RU_JOB
    WHERE (RETRIES_ > 0)
    AND (DUEDATE_ IS NULL OR DUEDATE_ < NOW())
    AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW())
    AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
    GROUP BY PRIORITY_
  UNION SELECT 53, 'Jobs (waiting for timer)', COUNT(*) FROM ACT_RU_JOB
    WHERE (RETRIES_ > 0)
    AND (DUEDATE_ IS NOT NULL AND DUEDATE_ >= NOW())
    AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW())
    AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
  UNION SELECT 54, 'Jobs (suspended)', COUNT(*) FROM ACT_RU_JOB WHERE SUSPENSION_STATE_ = 2
  UNION SELECT 55, 'Jobs (failed)', COUNT(*) FROM ACT_RU_JOB WHERE RETRIES_ = 0
  UNION SELECT 56, 'Jobs (timeout)', COUNT(*) FROM ACT_RU_JOB
    WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ < NOW())
  UNION SELECT 59, 'Jobs (type: ' || TYPE_ || ')', COUNT(*) FROM ACT_RU_JOB GROUP BY TYPE_
  UNION SELECT 60, 'Process Variables', COUNT(*) FROM ACT_RU_VARIABLE
  ) AS Metrics
WHERE Metric = 'Jobs (running)' -- Filtro para a coluna Metric
ORDER BY Position, Metric;


/



CREATE TABLE metrics_table (
   Position INT,
   Metric VARCHAR(255),
   Count INT,
   Horario TIMESTAMP
);
/







CREATE OR REPLACE FUNCTION insert_metrics() 
RETURNS void AS $$
BEGIN
    -- Insere os dados na tabela metrics_table
    INSERT INTO metrics_table (Position, Metric, Count, Horario)
    SELECT Position, Metric, Count, NOW() AT TIME ZONE 'UTC+3' AT TIME ZONE 'America/Sao_Paulo' -- Converte para o fuso horário de São Paulo
    FROM (
        SELECT 10 AS Position, 'Deployments' AS Metric, COUNT(*) AS Count FROM ACT_RE_DEPLOYMENT
        UNION
        SELECT 11, 'Process Definitions', COUNT(*) FROM (SELECT DISTINCT KEY_ FROM ACT_RE_PROCDEF) AS PROCDEF
        UNION
        SELECT 12, 'Process Definition Versions', COUNT(*) FROM ACT_RE_PROCDEF
        UNION
        SELECT 20, 'Activity Instances', COUNT(*) FROM ACT_HI_ACTINST
        UNION
        SELECT 21, 'Process Instances', COUNT(*) FROM ACT_HI_PROCINST
        UNION
        SELECT 22, 'Process Instances (finished)', COUNT(*) FROM ACT_HI_PROCINST WHERE END_TIME_ IS NOT NULL
        UNION
        SELECT 30, 'Process Instances (running)', COUNT(*) FROM ACT_RU_EXECUTION WHERE PARENT_ID_ IS NULL
        UNION
        SELECT 30.1, 'Executions (running)', COUNT(*) FROM ACT_RU_EXECUTION
        UNION
        SELECT 31, 'User Tasks', COUNT(*) FROM ACT_RU_TASK
        UNION
        SELECT 32, 'User Tasks (unassigned)', COUNT(*) FROM ACT_RU_TASK WHERE ASSIGNEE_ IS NULL
        UNION
        SELECT 40, 'Event Subscriptions', COUNT(*) FROM ACT_RU_EVENT_SUBSCR
        UNION
        SELECT 41, 'Event Subscriptions (type: ' || EVENT_TYPE_ || CASE WHEN PROC_INST_ID_ IS NULL THEN ' start' ELSE 'intermediate' END || ')' AS Metric, COUNT(*) FROM ACT_RU_EVENT_SUBSCR GROUP BY Metric
        UNION
        SELECT 50, 'Jobs', COUNT(*) FROM ACT_RU_JOB
        UNION
        SELECT 51, 'Jobs (running)', COUNT(*) FROM ACT_RU_JOB WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ >= NOW())
        UNION
        SELECT 51.0, 'Jobs (running, node=' || LOCK_OWNER_ || ')', COUNT(*) FROM ACT_RU_JOB WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ >= NOW()) GROUP BY LOCK_OWNER_
        UNION
        SELECT 51.1, 'Jobs (running at prio: ' || PRIORITY_ || ')', COUNT(*) FROM ACT_RU_JOB WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ >= NOW()) GROUP BY PRIORITY_
        UNION
        SELECT 52, 'Jobs (due)', COUNT(*) FROM ACT_RU_JOB WHERE (RETRIES_ > 0) AND (DUEDATE_ IS NULL OR DUEDATE_ < NOW()) AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW()) AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
        UNION
        SELECT 52.1, 'Jobs (due at prio: ' || PRIORITY_ || ')', COUNT(*) FROM ACT_RU_JOB WHERE (RETRIES_ > 0) AND (DUEDATE_ IS NULL OR DUEDATE_ < NOW()) AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW()) AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL) GROUP BY PRIORITY_
        UNION
        SELECT 53, 'Jobs (waiting for timer)', COUNT(*) FROM ACT_RU_JOB WHERE (RETRIES_ > 0) AND (DUEDATE_ IS NOT NULL AND DUEDATE_ >= NOW()) AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW()) AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
        UNION
        SELECT 54, 'Jobs (suspended)', COUNT(*) FROM ACT_RU_JOB WHERE SUSPENSION_STATE_ = 2
        UNION
        SELECT 55, 'Jobs (failed)', COUNT(*) FROM ACT_RU_JOB WHERE RETRIES_ = 0
        UNION
        SELECT 56, 'Jobs (timeout)', COUNT(*) FROM ACT_RU_JOB WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ < NOW())
        UNION
        SELECT 59, 'Jobs (type: ' || TYPE_ || ')', COUNT(*) FROM ACT_RU_JOB GROUP BY TYPE_
        UNION
        SELECT 60, 'Process Variables', COUNT(*) FROM ACT_RU_VARIABLE
    ) AS Metrics
    WHERE Metric = 'Jobs (running)' -- Filtro para a coluna Metric
    ORDER BY Position, Metric;
END;
$$ LANGUAGE plpgsql;
/



SELECT insert_metrics();
/

select * from  metrics_table;

/

CREATE INDEX idx_metrics_horario ON metrics_table (horario);


SELECT cron.schedule('*/5 * * * *', 'SELECT insert_metrics();');

SELECT * FROM cron.job_run_details where jobid=34;
/

UPDATE cron.job
SET database = 'rw_com'
WHERE jobid = 34;

UPDATE cron.job 
SET jobname = 'execucao job solicitada por Fabiano Cipriano - Historico Jobs running' 
WHERE jobid = 34;
/

-- Inserindo um crontab na mão:
INSERT INTO cron.job
( schedule, command, nodename, nodeport, "database", username, active, jobname)
VALUES( '*/1 * * * *', 'CREATE TEMP TABLE temp_event_ids AS
SELECT event_id
FROM rw_claro_flex.payments
WHERE event_timestamp <= ''2020-12-31 23:59:59.999''
LIMIT 5000;

DELETE FROM rw_claro_flex.payments
WHERE event_id IN (SELECT event_id FROM temp_event_ids);

DROP TABLE temp_event_ids;', 'localhost', 5432, 'rw_payments_manager', 'zup_claro', false, 'delete_old_payments_job');


SOM v1
https://tinyurl.com/5e3arzza
SOM v2
https://tinyurl.com/2trkpf4m


delete from cron.job where jobid=33;


CREATE OR REPLACE FUNCTION insert_metrics()
RETURNS void AS
$$
BEGIN
  -- Insere os dados na tabela metrics_table
  INSERT INTO metrics_table (Position, Metric, Count, Horario)
  SELECT Position, Metric, Count, 
         NOW() AT TIME ZONE 'UTC+3' AT TIME ZONE 'America/Sao_Paulo' -- Converte para o fuso horário de São Paulo
  FROM (
    SELECT 10 AS Position, 'Deployments' AS Metric, COUNT(*) AS Count FROM ACT_RE_DEPLOYMENT
    UNION SELECT 11, 'Process Definitions', COUNT(*) FROM (SELECT DISTINCT KEY_ FROM ACT_RE_PROCDEF) AS PROCDEF
    UNION SELECT 12, 'Process Definition Versions', COUNT(*) FROM ACT_RE_PROCDEF
    UNION SELECT 20, 'Activity Instances', COUNT(*) FROM ACT_HI_ACTINST
    UNION SELECT 21, 'Process Instances', COUNT(*) FROM ACT_HI_PROCINST
    UNION SELECT 22, 'Process Instances (finished)', COUNT(*) FROM ACT_HI_PROCINST WHERE END_TIME_ IS NOT NULL
    UNION SELECT 30, 'Process Instances (running)', COUNT(*) FROM ACT_RU_EXECUTION WHERE PARENT_ID_ IS NULL
    UNION SELECT 30.1, 'Executions (running)', COUNT(*) FROM ACT_RU_EXECUTION
    UNION SELECT 31, 'User Tasks', COUNT(*) FROM ACT_RU_TASK
    UNION SELECT 32, 'User Tasks (unassigned)', COUNT(*) FROM ACT_RU_TASK WHERE ASSIGNEE_ IS NULL
    UNION SELECT 40, 'Event Subscriptions', COUNT(*) FROM ACT_RU_EVENT_SUBSCR
    UNION SELECT 41, 'Event Subscriptions (type: ' ||
      EVENT_TYPE_ ||
      CASE WHEN PROC_INST_ID_ IS NULL THEN ' start' ELSE 'intermediate' END || ')' AS Metric,
      COUNT(*) FROM ACT_RU_EVENT_SUBSCR
      GROUP BY Metric
    UNION SELECT 50, 'Jobs', COUNT(*) FROM ACT_RU_JOB
    UNION SELECT 51, 'Jobs (running)', COUNT(*) FROM ACT_RU_JOB
      WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ >= NOW())
    UNION SELECT 51.0, 'Jobs (running, node=' || LOCK_OWNER_ || ')', COUNT(*) FROM ACT_RU_JOB
      WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ >= NOW())
      GROUP BY LOCK_OWNER_
    UNION SELECT 51.1, 'Jobs (running at prio: ' || PRIORITY_ || ')',
      COUNT(*)  FROM ACT_RU_JOB
      WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ >= NOW())
      GROUP BY PRIORITY_
    UNION SELECT 52, 'Jobs (due)', COUNT(*) FROM ACT_RU_JOB
      WHERE (RETRIES_ > 0)
      AND (DUEDATE_ IS NULL OR DUEDATE_ < NOW())
      AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW())
      AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
    UNION SELECT 52.1, 'Jobs (due at prio: ' || PRIORITY_ || ')',
      COUNT(*) FROM ACT_RU_JOB
      WHERE (RETRIES_ > 0)
      AND (DUEDATE_ IS NULL OR DUEDATE_ < NOW())
      AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW())
      AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
      GROUP BY PRIORITY_
    UNION SELECT 53, 'Jobs (waiting for timer)', COUNT(*) FROM ACT_RU_JOB
      WHERE (RETRIES_ > 0)
      AND (DUEDATE_ IS NOT NULL AND DUEDATE_ >= NOW())
      AND (LOCK_OWNER_ IS NULL OR LOCK_EXP_TIME_ < NOW())
      AND (SUSPENSION_STATE_ = 1 OR SUSPENSION_STATE_ IS NULL)
    UNION SELECT 54, 'Jobs (suspended)', COUNT(*) FROM ACT_RU_JOB WHERE SUSPENSION_STATE_ = 2
    UNION SELECT 55, 'Jobs (failed)', COUNT(*) FROM ACT_RU_JOB WHERE RETRIES_ = 0
    UNION SELECT 56, 'Jobs (timeout)', COUNT(*) FROM ACT_RU_JOB
      WHERE (LOCK_OWNER_ IS NOT NULL AND LOCK_EXP_TIME_ < NOW())
    UNION SELECT 59, 'Jobs (type: ' || TYPE_ || ')', COUNT(*) FROM ACT_RU_JOB GROUP BY TYPE_
    UNION SELECT 60, 'Process Variables', COUNT(*) FROM ACT_RU_VARIABLE
  ) AS Metrics
  WHERE Metric = 'Jobs (running)' -- Filtro para a coluna Metric
  ORDER BY Position, Metric;
END;
$$ LANGUAGE plpgsql;
/



SELECT cron.schedule('*/5 * * * *', 
$$SET TIMEZONE = 'America/Sao_Paulo'; 
SELECT insert_metrics();
$$);


evento IO: xartSync está alto no banco aurora
##############################################################################################################

-- Criacao do user
CREATE USER "sergio.tamura" WITH PASSWORD 'tWI1NnRbAiyM';
GRANT CONNECT ON DATABASE rw_extensions TO "sergio.tamura";

-- Privilegios de usage
DO $$
DECLARE
    schema_name TEXT;
BEGIN
    -- Itera sobre todos os esquemas do banco de dados
    FOR schema_name IN
        SELECT s.schema_name -- Usa um alias para evitar ambiguidade
        FROM information_schema.schemata s
        WHERE s.schema_name NOT IN ('pg_catalog', 'information_schema') -- Exclui esquemas padrão do PostgreSQL
    LOOP
        -- Concede o privilégio de USAGE para cada esquema
        EXECUTE format('GRANT USAGE ON SCHEMA %I TO "sergio.tamura";', schema_name);
    END LOOP;
END $$;
/

-- Privilegio para tabelas novas
DO $$
DECLARE
    schema_name TEXT;
BEGIN
    -- Itera sobre todos os esquemas do banco de dados
    FOR schema_name IN
        SELECT s.schema_name -- Usa um alias para evitar ambiguidade
        FROM information_schema.schemata s
        WHERE s.schema_name NOT IN ('pg_catalog', 'information_schema') -- Exclui esquemas padrão do PostgreSQL
    LOOP
        -- Aplica o comando ALTER DEFAULT PRIVILEGES para cada esquema
        EXECUTE format(
            'ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT SELECT, INSERT ON TABLES TO "sergio.tamura";',
            schema_name
        );
    END LOOP;
END $$;
/


-- Em todas as tabelas de todos os schemas
DO $$
DECLARE
    schema_name TEXT;
BEGIN
    -- Itera sobre todos os esquemas do banco de dados
    FOR schema_name IN
        SELECT s.schema_name
        FROM information_schema.schemata s
        WHERE s.schema_name NOT IN ('pg_catalog', 'information_schema') -- Exclui esquemas padrão do PostgreSQL
    LOOP
        -- Concede privilégios de leitura e escrita em todas as tabelas existentes no esquema
        EXECUTE format(
            'GRANT SELECT, INSERT ON ALL TABLES IN SCHEMA %I TO "sergio.tamura";',
            schema_name
        );

        -- Garante que o usuário receba privilégios automaticamente em tabelas futuras no esquema
        EXECUTE format(
            'ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT SELECT, INSERT ON TABLES TO "sergio.tamura";',
            schema_name
        );
    END LOOP;
END $$;

-- Privilegios nas sequence
DO $$
DECLARE
seq RECORD;
BEGIN
-- Loop through all sequences in the current database
FOR seq IN SELECT schemaname, sequencename FROM pg_sequences LOOP
-- Construct and execute the GRANT ALL command for each sequence
EXECUTE format('GRANT ALL ON SEQUENCE %I.%I TO "%s"', seq.schemaname, seq.sequencename, 'sergio.tamura');
END LOOP;
END $$;
##############################################################################################################


--> ROTINAS DE PERFORMANCE


tb_db_size
tb_get_activity
tb_get_activity_pid
tb_get_activity_pid_read
tb_get_activity_read
tb_get_lag
tb_get_locks
tb_tables_size
tb_top_cpu