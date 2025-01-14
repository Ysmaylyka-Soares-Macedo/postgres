DO $$
DECLARE
    dblink_record RECORD;
    conn_status TEXT;
BEGIN
    FOR dblink_record IN
        SELECT srvname AS dblink_name
        FROM pg_foreign_server
    LOOP
        BEGIN
            -- Tenta conectar ao dblink
            PERFORM dblink_connect(dblink_record.dblink_name);
            -- Se a conexão for bem-sucedida, desconecta
            PERFORM dblink_disconnect(dblink_record.dblink_name);
            conn_status := 'Conexão bem-sucedida';
        EXCEPTION
            WHEN others THEN
                conn_status := 'Falha na conexão';
        END;

        -- Exibe o status da conexão
        RAISE NOTICE 'dblink: %, status: %', dblink_record.dblink_name, conn_status;
    END LOOP;
END $$;