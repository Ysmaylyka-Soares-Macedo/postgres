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