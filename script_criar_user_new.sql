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