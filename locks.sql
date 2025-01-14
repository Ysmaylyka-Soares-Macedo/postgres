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

