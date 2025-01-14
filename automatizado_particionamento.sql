-- Função para verificar e criar novas partições em todas as tabelas particionadas
CREATE OR REPLACE FUNCTION manage_all_partitions() RETURNS void AS $$
DECLARE
    schema_name TEXT;
    table_name TEXT;
    partition_name TEXT;
    partition_limit DATE;
    partition_exists BOOLEAN;
    latest_partition TEXT;
    latest_partition_limit DATE;
    has_data BOOLEAN;
BEGIN
    -- Iterar sobre todos os schemas e tabelas particionadas
    FOR schema_name, table_name IN
        SELECT n.nspname AS schema_name, c.relname AS table_name
        FROM pg_class c
        JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE c.relkind = 'p' -- Apenas tabelas particionadas
    LOOP
        -- Encontrar a partição mais recente
        SELECT inhrelid::regclass::text AS latest_partition
        INTO latest_partition
        FROM pg_inherits
        WHERE inhparent = (schema_name || '.' || table_name)::regclass
        ORDER BY inhrelid::regclass::text DESC
        LIMIT 1;

        -- Determinar o limite da partição mais recente
        SELECT to_date(substring(latest_partition FROM '\d+$'), 'YYYYMM')
        INTO latest_partition_limit;

        -- Verificar se a partição mais recente contém dados
        EXECUTE format('SELECT EXISTS (SELECT 1 FROM %I.%I)', schema_name, latest_partition)
        INTO has_data;

        -- Se a partição mais recente contém dados, criar mais 6 partições
        IF has_data THEN
            FOR partition_limit IN
                SELECT generate_series(
                    latest_partition_limit + INTERVAL '1 month',
                    latest_partition_limit + INTERVAL '6 months',
                    INTERVAL '1 month'
                )::DATE
            LOOP
                -- Nome da nova partição
                partition_name := table_name || '_' || to_char(partition_limit, 'YYYYMM');

                -- Verificar se a partição já existe
                SELECT EXISTS (
                    SELECT 1
                    FROM pg_tables
                    WHERE schemaname = schema_name AND tablename = partition_name
                )
                INTO partition_exists;

                -- Criar a partição se ela não existir
                IF NOT partition_exists THEN
                    EXECUTE format(
                        'CREATE TABLE %I.%I PARTITION OF %I.%I FOR VALUES FROM (%L) TO (%L)',
                        schema_name, partition_name, schema_name, table_name,
                        partition_limit, partition_limit + INTERVAL '1 month'
                    );
                    RAISE NOTICE 'Partição % criada para a tabela %.%', partition_name, schema_name, table_name;
                END IF;
            END LOOP;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Agendar a execução semanal do job
-- Usando pg_cron (extensão do PostgreSQL para agendamento de jobs)
-- Certifique-se de que a extensão pg_cron está instalada e configurada
SELECT cron.schedule(
    'verificar_tabelas_particionadas', -- Nome do job
    '0 0 * * 0', -- Agendamento semanal (domingo à meia-noite)
    $$CALL manage_all_partitions();$$ -- Chamada da função
);