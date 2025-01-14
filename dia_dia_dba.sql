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



-------> Frenquencia do SQL pelo script  (execute no DBADMIN):

SELECT dt_log, time_running, state, usr, db, ip, query, query_start, pid
FROM public.tb_get_activity 
where dt_log between '2024-07-18 10:00:00.000' and '2024-07-18 11:00:00.000' 
and state <> 'idle' 
and query like 'SELECT DISTINCT pay.payment_id%'
order by time_running desc limit 10000;

------> Verificar o intervalo de datas:
select * from rw_claro_flex.payments_Partition
where event_timestamp between '2024-03-05 00:00:00.000' and '2024-03-06 23:59:59.999';

------> Criar particionamento da tabela nova_subscription_renewal_history:
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

------> Copiar privilegios de uma tabela para outra:
DO $$
DECLARE
    r RECORD;
BEGIN
    -- Loop através de todos os usuários com permissões na tabela original
    FOR r IN
        SELECT grantee, ARRAY_AGG(privilege_type) AS privileges
        FROM information_schema.role_table_grants
        WHERE table_name = 'original_table'
        GROUP BY grantee
    LOOP
        -- Imprimir o comando GRANT necessário com todas as permissões agrupadas
        RAISE NOTICE 'GRANT % ON TABLE new_table TO %;', array_to_string(r.privileges, ', '), r.grantee;
    END LOOP;
END
$$;

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

------> Horas e minutos na tabela de controle sobre tabelas particionadas:
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

-----> Verificar a quantidade de linhas (tabela de controle)
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

-----> Verificar linhas duplicadas
SELECT event_id, "timestamp", COUNT(*)
FROM rw_claro_flex.subscription_renewal_history
WHERE "timestamp" BETWEEN '2024-07-01 00:00:00' AND '2024-07-31 23:59:59'
GROUP BY event_id,"timestamp"
HAVING COUNT(*) > 1;  

-----> Deletar linhas dentro de um intervalo de datas
DELETE FROM rw_claro_flex.nova_subscription_renewal_history WHERE DATE("timestamp") = '2022-04-19';
COMMIT;

-----> Inserir dados dentro de um intervalo de datas
INSERT INTO rw_claro_flex.nova_subscription_renewal_history 
SELECT *
FROM rw_claro_flex.subscription_renewal_history
WHERE DATE("timestamp") = '2022-04-19';

-----> Verificar a quantidade de sessões
SELECT COUNT(*)
FROM pg_stat_activity
	WHERE datname = 'rw_extensions'
	AND state = 'idle';
	
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

