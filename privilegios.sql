------> Copiando privilegios de um usuário para outro
DO $$
DECLARE
    r RECORD;
    target_user TEXT := 'bia'; -- Defina o usuário alvo aqui
    table_privileges TEXT;
    sequence_privileges TEXT;
    function_privileges TEXT;
BEGIN
    -- Capturar privilégios padrão de TABLES
    SELECT string_agg(privilege_type, ', ') INTO table_privileges
    FROM (
        SELECT DISTINCT privilege_type
        FROM information_schema.role_table_grants
        WHERE grantee = 'maria'
    ) AS privileges;

    -- Capturar privilégios padrão de SEQUENCES
    SELECT string_agg(privilege_type, ', ') INTO sequence_privileges
    FROM (
        SELECT DISTINCT 'USAGE' AS privilege_type
        FROM pg_sequences
        WHERE sequenceowner = 'maria'
    ) AS privileges;

    -- Capturar privilégios padrão de FUNCTIONS
    SELECT string_agg(privilege_type, ', ') INTO function_privileges
    FROM (
        SELECT DISTINCT privilege_type
        FROM information_schema.role_routine_grants
        WHERE grantee = 'maria'
    ) AS privileges;

    -- Copiar privilégios de SCHEMAS
    FOR r IN
        SELECT n.nspname AS schema_name, p.privilege_type
        FROM pg_catalog.pg_namespace n
        JOIN pg_catalog.pg_roles ro ON ro.oid = n.nspowner
        JOIN (SELECT 'USAGE' AS privilege_type UNION ALL SELECT 'CREATE' AS privilege_type) p ON true
        WHERE ro.rolname = 'maria'
    LOOP
        IF r.schema_name IS NOT NULL THEN
            EXECUTE format('GRANT %I ON SCHEMA %I TO %I', r.privilege_type, r.schema_name, target_user);
        END IF;
    END LOOP;

    -- Copiar privilégios de TABLES
    FOR r IN
        SELECT table_schema, table_name, privilege_type
        FROM information_schema.role_table_grants
        WHERE grantee = 'maria'
    LOOP
        IF r.table_schema IS NOT NULL AND r.table_name IS NOT NULL THEN
            EXECUTE format('GRANT %s ON TABLE %I.%I TO %I', r.privilege_type, r.table_schema, r.table_name, target_user);
        END IF;
    END LOOP;

    -- Copiar privilégios de SEQUENCES
    FOR r IN
        SELECT schemaname AS sequence_schema, sequencename AS sequence_name, 'USAGE' AS privilege_type
        FROM pg_sequences
        WHERE sequenceowner = 'maria'
    LOOP
        IF r.sequence_schema IS NOT NULL AND r.sequence_name IS NOT NULL THEN
            EXECUTE format('GRANT %s ON SEQUENCE %I.%I TO %I', r.privilege_type, r.sequence_schema, r.sequence_name, target_user);
        END IF;
    END LOOP;

    -- Copiar privilégios de FUNCTIONS
    FOR r IN
        SELECT routine_schema AS schema_name, routine_name, privilege_type
        FROM information_schema.role_routine_grants
        WHERE grantee = 'maria'
    LOOP
        IF r.schema_name IS NOT NULL AND r.routine_name IS NOT NULL THEN
            EXECUTE format('GRANT %s ON FUNCTION %I.%I TO %I', r.privilege_type, r.schema_name, r.routine_name, target_user);
        END IF;
    END LOOP;

    -- Copiar privilégios de DATABASES
    FOR r IN
        SELECT datname AS database_name, 'CONNECT' AS privilege_type
        FROM pg_database
        WHERE datdba = (SELECT oid FROM pg_roles WHERE rolname = 'maria')
    LOOP
        IF r.database_name IS NOT NULL THEN
            EXECUTE format('GRANT %s ON DATABASE %I TO %I', r.privilege_type, r.database_name, target_user);
        END IF;
    END LOOP;

    -- Copiar ALTER DEFAULT PRIVILEGES IN SCHEMA
    FOR r IN
        SELECT nspname
        FROM pg_namespace
        WHERE nspname NOT LIKE 'pg_%' AND nspname NOT LIKE 'information_schema'
    LOOP
        IF r.nspname IS NOT NULL THEN
            EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT %s ON TABLES TO %I', r.nspname, table_privileges, target_user);
            EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL ON SEQUENCES TO %I', r.nspname,  target_user);
            EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL ON FUNCTIONS TO %I', r.nspname,  target_user);
        END IF;
    END LOOP;
END $$;

----->  Gerando o comando DDL da copia do usuário MARIA para o user BIA
DO $$
DECLARE
    r RECORD;
    target_user TEXT := 'bia'; -- Defina o usuário alvo aqui
    table_privileges TEXT;
    sequence_privileges TEXT;
    function_privileges TEXT;
    ddl_command TEXT;
BEGIN
    -- Capturar privilégios padrão de TABLES
    SELECT string_agg(privilege_type, ', ') INTO table_privileges
    FROM (
        SELECT DISTINCT privilege_type
        FROM information_schema.role_table_grants
        WHERE grantee = 'maria'
    ) AS privileges;

    -- Capturar privilégios padrão de SEQUENCES
    SELECT string_agg(privilege_type, ', ') INTO sequence_privileges
    FROM (
        SELECT DISTINCT 'USAGE' AS privilege_type
        FROM pg_sequences
        WHERE sequenceowner = 'maria'
    ) AS privileges;

    -- Capturar privilégios padrão de FUNCTIONS
    SELECT string_agg(privilege_type, ', ') INTO function_privileges
    FROM (
        SELECT DISTINCT privilege_type
        FROM information_schema.role_routine_grants
        WHERE grantee = 'maria'
    ) AS privileges;

    -- Copiar privilégios de SCHEMAS
    FOR r IN
        SELECT n.nspname AS schema_name, p.privilege_type
        FROM pg_catalog.pg_namespace n
        JOIN pg_catalog.pg_roles ro ON ro.oid = n.nspowner
        JOIN (SELECT 'USAGE' AS privilege_type UNION ALL SELECT 'CREATE' AS privilege_type) p ON true
        WHERE ro.rolname = 'maria'
    LOOP
        IF r.schema_name IS NOT NULL THEN
            ddl_command := format('GRANT %I ON SCHEMA %I TO %I', r.privilege_type, r.schema_name, target_user);
            RAISE NOTICE '%', ddl_command;
            EXECUTE ddl_command;
        END IF;
    END LOOP;

    -- Copiar privilégios de TABLES
    FOR r IN
        SELECT table_schema, table_name, privilege_type
        FROM information_schema.role_table_grants
        WHERE grantee = 'maria'
    LOOP
        IF r.table_schema IS NOT NULL AND r.table_name IS NOT NULL THEN
            ddl_command := format('GRANT %s ON TABLE %I.%I TO %I', r.privilege_type, r.table_schema, r.table_name, target_user);
            RAISE NOTICE '%', ddl_command;
            EXECUTE ddl_command;
        END IF;
    END LOOP;

    -- Copiar privilégios de SEQUENCES
    FOR r IN
        SELECT schemaname AS sequence_schema, sequencename AS sequence_name, 'USAGE' AS privilege_type
        FROM pg_sequences
        WHERE sequenceowner = 'maria'
    LOOP
        IF r.sequence_schema IS NOT NULL AND r.sequence_name IS NOT NULL THEN
            ddl_command := format('GRANT %s ON SEQUENCE %I.%I TO %I', r.privilege_type, r.sequence_schema, r.sequence_name, target_user);
            RAISE NOTICE '%', ddl_command;
            EXECUTE ddl_command;
        END IF;
    END LOOP;

    -- Copiar privilégios de FUNCTIONS
    FOR r IN
        SELECT routine_schema AS schema_name, routine_name, privilege_type
        FROM information_schema.role_routine_grants
        WHERE grantee = 'maria'
    LOOP
        IF r.schema_name IS NOT NULL AND r.routine_name IS NOT NULL THEN
            ddl_command := format('GRANT %s ON FUNCTION %I.%I TO %I', r.privilege_type, r.schema_name, r.routine_name, target_user);
            RAISE NOTICE '%', ddl_command;
            EXECUTE ddl_command;
        END IF;
    END LOOP;

    -- Copiar privilégios de DATABASES
    FOR r IN
        SELECT datname AS database_name, 'CONNECT' AS privilege_type
        FROM pg_database
        WHERE datdba = (SELECT oid FROM pg_roles WHERE rolname = 'maria')
    LOOP
        IF r.database_name IS NOT NULL THEN
            ddl_command := format('GRANT %s ON DATABASE %I TO %I', r.privilege_type, r.database_name, target_user);
            RAISE NOTICE '%', ddl_command;
            EXECUTE ddl_command;
        END IF;
    END LOOP;

    -- Copiar ALTER DEFAULT PRIVILEGES IN SCHEMA
    FOR r IN
        SELECT nspname
        FROM pg_namespace
        WHERE nspname NOT LIKE 'pg_%' AND nspname NOT LIKE 'information_schema'
    LOOP
        IF r.nspname IS NOT NULL THEN
            ddl_command := format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT %s ON TABLES TO %I', r.nspname, table_privileges, target_user);
            RAISE NOTICE '%', ddl_command;
            EXECUTE ddl_command;

            ddl_command := format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL ON SEQUENCES TO %I', r.nspname, target_user);
            RAISE NOTICE '%', ddl_command;
            EXECUTE ddl_command;

            ddl_command := format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL ON FUNCTIONS TO %I', r.nspname, target_user);
            RAISE NOTICE '%', ddl_command;
            EXECUTE ddl_command;
        END IF;
    END LOOP;
END $$;


-------> Executar a copia dos privilegios de tabela para outra

DO $$
DECLARE
    source_table text := 'tb_subscription1'; -- Substitua pelo nome da tabela de origem
    source_owner text := 'subscription'; -- Substitua pelo nome do owner da tabela de origem
    target_table text := 'tb_extensions1'; -- Substitua pelo nome da tabela de destino
    target_owner text := 'extensions'; -- Substitua pelo nome do owner da tabela de destino
    privilege_record record;
    sequence_record record;
    ddl_command text;
BEGIN
    -- Executar comandos DDL para privilégios na tabela
    FOR privilege_record IN
        SELECT grantee, privilege_type
        FROM information_schema.role_table_grants
        WHERE table_name = source_table
          AND table_schema = source_owner
    LOOP
        ddl_command := format('GRANT %s ON TABLE %I.%I TO %I', privilege_record.privilege_type, target_owner, target_table, privilege_record.grantee);
        EXECUTE ddl_command;
    END LOOP;

    -- Executar comandos DDL para privilégios nas sequences da tabela de destino
    FOR sequence_record IN
        SELECT sequence_name
        FROM information_schema.sequences
        WHERE sequence_schema = target_owner
    LOOP
        FOR privilege_record IN
            SELECT grantee
            FROM information_schema.role_table_grants
            WHERE table_name = source_table
              AND table_schema = source_owner
        LOOP
            ddl_command := format('GRANT USAGE, SELECT, UPDATE ON SEQUENCE %I.%I TO %I', target_owner, sequence_record.sequence_name, privilege_record.grantee);
            EXECUTE ddl_command;
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;



---------> Gerar o comando DDL que copia os privilegios de uma tabela para outra
DO $$
DECLARE
    source_table text := 'tb_subscription1'; -- Substitua pelo nome da tabela de origem
    source_owner text := 'subscription'; -- Substitua pelo nome do owner da tabela de origem
    target_table text := 'tb_extensions1'; -- Substitua pelo nome da tabela de destino
    target_owner text := 'extensions'; -- Substitua pelo nome do owner da tabela de destino
    privilege_record record;
    sequence_record record;
    ddl_command text;
BEGIN
    -- Gerar comandos DDL para privilégios na tabela
    FOR privilege_record IN
        SELECT grantee, privilege_type
        FROM information_schema.role_table_grants
        WHERE table_name = source_table
          AND table_schema = source_owner
    LOOP
        ddl_command := format('GRANT %s ON TABLE %I.%I TO %I;', privilege_record.privilege_type, target_owner, target_table, privilege_record.grantee);
        RAISE NOTICE '%', ddl_command;
    END LOOP;

    -- Gerar comandos DDL para privilégios nas sequences da tabela de destino
    FOR sequence_record IN
        SELECT sequence_name
        FROM information_schema.sequences
        WHERE sequence_schema = target_owner
    LOOP
        FOR privilege_record IN
            SELECT grantee
            FROM information_schema.role_table_grants
            WHERE table_name = source_table
              AND table_schema = source_owner
        LOOP
            ddl_command := format('GRANT USAGE, SELECT, UPDATE ON SEQUENCE %I.%I TO %I;', target_owner, sequence_record.sequence_name, privilege_record.grantee);
            RAISE NOTICE '%', ddl_command;
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


------> Conceder privilegios para todas as sequences de um schema:
DO $$
DECLARE
seq RECORD;
BEGIN
-- Loop through all sequences in the current database
FOR seq IN SELECT schemaname, sequencename FROM pg_sequences LOOP
-- Construct and execute the GRANT ALL command for each sequence
EXECUTE format('GRANT ALL ON SEQUENCE %I.%I TO "%s"', seq.schemaname, seq.sequencename, 'gabriel.cardoso');
END LOOP;
END $$;