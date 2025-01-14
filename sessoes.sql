-------> Frenquencia do SQL pelo script  (execute no DBADMIN):

SELECT dt_log, time_running, state, usr, db, ip, query, query_start, pid
FROM public.tb_get_activity 
where dt_log between '2024-07-18 10:00:00.000' and '2024-07-18 11:00:00.000' 
and state <> 'idle' 
and query like 'SELECT DISTINCT pay.payment_id%'
order by time_running desc limit 10000;



-----> Verificar a quantidade de sessões
SELECT COUNT(*)
FROM pg_stat_activity
	WHERE datname = 'rw_extensions'
	AND state = 'idle';
	