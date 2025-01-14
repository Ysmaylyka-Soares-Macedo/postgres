-- Active: 1721973187966@@192.168.1.9@5432
-----------------------------------------------------------------------------------------------------------------------------------------------
	-- CRIAR O USUÁRIO 
	-- CONNECTAR NA INSÂNCIA
	
	CREATE USER "gabriel.cardoso" WITH PASSWORD 'xxxxxxxxxxxxx';
	CREATE USER "gabriela.jardim" WITH PASSWORD 'yyyyyyyyyyyyyy';
	CREATE USER "eder.moraes" WITH PASSWORD 'zzzzzzzzzzzzzzz';

	-- CONECTAR NO DATABASE POSTGRES
	
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriel.cardoso";'
	from pg_catalog.pg_database pd 
	where pd.datname not in ('postgres','rdsadmin','template0','template1') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriela.jardim";'
	from pg_catalog.pg_database pd 
	where pd.datname not in ('postgres','rdsadmin','template0','template1') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "eder.moraes";'
	from pg_catalog.pg_database pd 
	where pd.datname not in ('postgres','rdsadmin','template0','template1') 
	order by 1;
	
	
	-- CONECTAR EM CADA DATABASE
	
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVI LEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriel.cardoso";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriela.jardim";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "eder.moraes";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     order by 1 desc;
 
-----------------------------------------------------------------------------------------------------------------------------------------------	

	--
	-- bi-etl-claro-prd.ccvkkkqwkw2e.sa-east-1.rds.amazonaws.com	bi_claro_report
	--
	
	
	CREATE USER "gabriel.cardoso" WITH PASSWORD 'xxxxxxxxxxxxx';
	CREATE USER "gabriela.jardim" WITH PASSWORD 'yyyyyyyyyyyyyy';
	CREATE USER "eder.moraes" WITH PASSWORD 'zzzzzzzzzzzzzzz';

	Queries	3
	Updated Rows	0
	Execute time (ms)	807
	Fetch time (ms)	0
	Total time (ms)	807
	Start time	2024-05-21 14:35:03.523
	Finish time	2024-05-21 14:35:04.332 

	-- CONECTAR NO DATABASE POSTGRES

	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriel.cardoso";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('bi_claro_report') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriela.jardim";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('bi_claro_report') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "eder.moraes";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('bi_claro_report'); 
	-- order by 1;
	
	GRANT CONNECT ON DATABASE bi_claro_report TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE bi_claro_report TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE bi_claro_report TO "eder.moraes";
	
	Queries	3
	Updated Rows	0
	Execute time (ms)	814
	Fetch time (ms)	0
	Total time (ms)	814
	Start time	2024-05-21 14:38:42.319
	Finish time	2024-05-21 14:38:43.136

	-- CONECTAR EM CADA DATABASE
	

	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriel.cardoso";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriela.jardim";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "eder.moraes";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     order by 1 desc;
 	
    GRANT USAGE ON SCHEMA "teste_pentaho_banco_raw" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "teste_pentaho_banco_raw" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "teste_pentaho_banco_raw" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "teste_pentaho_banco_dimension" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "teste_pentaho_banco_dimension" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "teste_pentaho_banco_dimension" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "suporte_n2" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "suporte_n2" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "suporte_n2" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "stage" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "stage" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "stage" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "sincronizaocao" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "sincronizaocao" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "sincronizaocao" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "simdelivery" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "simdelivery" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "simdelivery" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_catalog_manager_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_catalog_manager_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_catalog_manager_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "repack" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "repack" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "repack" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "raw_parts" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "raw_parts" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "raw_parts" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "raw" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "raw" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "raw" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "ps8_atualizacao_endereco" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "ps8_atualizacao_endereco" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "ps8_atualizacao_endereco" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "pre_ativacao" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "pre_ativacao" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "pre_ativacao" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "payments" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "payments" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "payments" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "mesa_performance" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "mesa_performance" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "mesa_performance" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "kpi_claroflex_semanal" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "kpi_claroflex_semanal" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "kpi_claroflex_semanal" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "ind_oficiais" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "ind_oficiais" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "ind_oficiais" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "extracoes_online" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "extracoes_online" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "extracoes_online" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "estudos" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "estudos" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "estudos" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "dw_claro_flex_logs" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "dw_claro_flex_logs" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "dw_claro_flex_logs" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "dw_claro_flex-facts_test" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "dw_claro_flex-facts_test" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "dw_claro_flex-facts_test" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "dw_claro_flex-dimensions_test" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "dw_claro_flex-dimensions_test" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "dw_claro_flex-dimensions_test" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "dim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "dim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "dim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "dev" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "dev" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "dev" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "dbm_campanhas" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "dbm_campanhas" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "dbm_campanhas" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "dash_claro_flex-teste" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "dash_claro_flex-teste" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "dash_claro_flex-teste" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "dash_claro_flex-subscriptions_manager" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "dash_claro_flex-subscriptions_manager" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "dash_claro_flex-subscriptions_manager" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "dash_claro_flex-rw_customer_manager" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "dash_claro_flex-rw_customer_manager" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "dash_claro_flex-rw_customer_manager" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "dash_claro_flex-rw_customer_inventory" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "dash_claro_flex-rw_customer_inventory" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "dash_claro_flex-rw_customer_inventory" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "dash_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "dash_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "dash_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "claro_flex_ajuste_base" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "claro_flex_ajuste_base" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "claro_flex_ajuste_base" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "chip_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "chip_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "chip_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "campanha_cadastrocartao" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "campanha_cadastrocartao" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "campanha_cadastrocartao" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "book_operacional" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "book_operacional" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "book_operacional" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "bi_stage_renovacoes" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "bi_stage_renovacoes" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "bi_stage_renovacoes" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "bi_stage" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "bi_stage" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "bi_stage" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "bi_raw_renovacoes" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "bi_raw_renovacoes" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "bi_raw_renovacoes" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "bi_raw_data_parts" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "bi_raw_data_parts" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "bi_raw_data_parts" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "bi_raw_data_diff" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "bi_raw_data_diff" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "bi_raw_data_diff" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "bi_raw_data" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "bi_raw_data" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "bi_raw_data" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "bi_dev" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "bi_dev" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "bi_dev" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "bi_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "bi_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "bi_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "appsflyer" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "appsflyer" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "appsflyer" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "afraw" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "afraw" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "afraw" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "teste_pentaho_banco_raw" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "teste_pentaho_banco_raw" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "teste_pentaho_banco_raw" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "teste_pentaho_banco_dimension" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "teste_pentaho_banco_dimension" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "teste_pentaho_banco_dimension" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "suporte_n2" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "suporte_n2" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "suporte_n2" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "stage" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "stage" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "stage" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "sincronizaocao" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "sincronizaocao" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "sincronizaocao" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "simdelivery" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "simdelivery" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "simdelivery" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_catalog_manager_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_catalog_manager_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_catalog_manager_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "repack" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "repack" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "repack" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "raw_parts" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "raw_parts" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "raw_parts" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "raw" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "raw" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "raw" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "ps8_atualizacao_endereco" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "ps8_atualizacao_endereco" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "ps8_atualizacao_endereco" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "pre_ativacao" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "pre_ativacao" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "pre_ativacao" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "payments" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "payments" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "payments" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "mesa_performance" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "mesa_performance" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "mesa_performance" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "kpi_claroflex_semanal" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "kpi_claroflex_semanal" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "kpi_claroflex_semanal" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "ind_oficiais" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "ind_oficiais" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "ind_oficiais" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "extracoes_online" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "extracoes_online" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "extracoes_online" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "estudos" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "estudos" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "estudos" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dw_claro_flex_logs" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dw_claro_flex_logs" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dw_claro_flex_logs" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dw_claro_flex-facts_test" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dw_claro_flex-facts_test" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dw_claro_flex-facts_test" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dw_claro_flex-dimensions_test" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dw_claro_flex-dimensions_test" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dw_claro_flex-dimensions_test" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dev" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dev" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dev" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dbm_campanhas" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dbm_campanhas" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dbm_campanhas" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex-teste" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex-teste" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex-teste" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex-subscriptions_manager" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex-subscriptions_manager" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex-subscriptions_manager" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex-rw_customer_manager" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex-rw_customer_manager" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex-rw_customer_manager" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex-rw_customer_inventory" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex-rw_customer_inventory" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex-rw_customer_inventory" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "dash_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "claro_flex_ajuste_base" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "claro_flex_ajuste_base" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "claro_flex_ajuste_base" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "chip_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "chip_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "chip_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "campanha_cadastrocartao" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "campanha_cadastrocartao" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "campanha_cadastrocartao" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "book_operacional" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "book_operacional" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "book_operacional" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_stage_renovacoes" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_stage_renovacoes" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_stage_renovacoes" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_stage" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_stage" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_stage" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_raw_renovacoes" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_raw_renovacoes" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_raw_renovacoes" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_raw_data_parts" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_raw_data_parts" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_raw_data_parts" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_raw_data_diff" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_raw_data_diff" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_raw_data_diff" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_raw_data" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_raw_data" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_raw_data" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_dev" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_dev" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_dev" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "bi_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "appsflyer" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "appsflyer" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "appsflyer" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "afraw" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "afraw" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "afraw" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "teste_pentaho_banco_raw" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "teste_pentaho_banco_raw" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "teste_pentaho_banco_raw" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "teste_pentaho_banco_dimension" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "teste_pentaho_banco_dimension" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "teste_pentaho_banco_dimension" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "suporte_n2" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "suporte_n2" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "suporte_n2" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "stage" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "stage" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "stage" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "sincronizaocao" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "sincronizaocao" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "sincronizaocao" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "simdelivery" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "simdelivery" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "simdelivery" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_catalog_manager_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_catalog_manager_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_catalog_manager_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "repack" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "repack" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "repack" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "raw_parts" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "raw_parts" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "raw_parts" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "raw" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "raw" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "raw" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "ps8_atualizacao_endereco" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "ps8_atualizacao_endereco" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "ps8_atualizacao_endereco" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "pre_ativacao" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "pre_ativacao" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "pre_ativacao" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "payments" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "payments" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "payments" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "mesa_performance" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "mesa_performance" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "mesa_performance" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "kpi_claroflex_semanal" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "kpi_claroflex_semanal" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "kpi_claroflex_semanal" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "ind_oficiais" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "ind_oficiais" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "ind_oficiais" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "extracoes_online" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "extracoes_online" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "extracoes_online" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "estudos" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "estudos" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "estudos" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dw_claro_flex_logs" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dw_claro_flex_logs" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dw_claro_flex_logs" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dw_claro_flex-facts_test" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dw_claro_flex-facts_test" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dw_claro_flex-facts_test" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dw_claro_flex-dimensions_test" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dw_claro_flex-dimensions_test" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dw_claro_flex-dimensions_test" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dev" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dev" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dev" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dbm_campanhas" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dbm_campanhas" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dbm_campanhas" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex-teste" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex-teste" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex-teste" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex-subscriptions_manager" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex-subscriptions_manager" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex-subscriptions_manager" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex-rw_customer_manager" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex-rw_customer_manager" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex-rw_customer_manager" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex-rw_customer_inventory" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex-rw_customer_inventory" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex-rw_customer_inventory" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "dash_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "claro_flex_ajuste_base" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "claro_flex_ajuste_base" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "claro_flex_ajuste_base" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "chip_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "chip_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "chip_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "campanha_cadastrocartao" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "campanha_cadastrocartao" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "campanha_cadastrocartao" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "book_operacional" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "book_operacional" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "book_operacional" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_stage_renovacoes" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_stage_renovacoes" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_stage_renovacoes" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_stage" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_stage" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_stage" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_raw_renovacoes" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_raw_renovacoes" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_raw_renovacoes" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_raw_data_parts" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_raw_data_parts" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_raw_data_parts" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_raw_data_diff" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_raw_data_diff" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_raw_data_diff" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_raw_data" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_raw_data" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_raw_data" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_dev" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_dev" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_dev" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "bi_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "appsflyer" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "appsflyer" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "appsflyer" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "afraw" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "afraw" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "afraw" GRANT SELECT ON TABLES TO "eder.moraes";

	Queries	413
	Updated Rows	0
	Execute time (ms)	174791
	Fetch time (ms)	0
	Total time (ms)	174791
	Start time	2024-05-21 15:03:13.765
	Finish time	2024-05-21 15:07:40.389
 
	--
	-- realwave-claro-billing-database-prd.ccvkkkqwkw2e.sa-east-1.rds.amazonaws.com
	--		rw_m4u_connector
	--		rw_payments_manager
	--		rw_wallet
	--
	
	-- CRIAR O USUÁRIO - CONNECTAR NA INSÂNCIA
	
	CREATE USER "gabriel.cardoso" WITH PASSWORD 'xxxxxxxxxxxxx';
	CREATE USER "gabriela.jardim" WITH PASSWORD 'yyyyyyyyyyyyyy';
	CREATE USER "eder.moraes" WITH PASSWORD 'zzzzzzzzzzzzzzz';

	Queries	3
	Updated Rows	0
	Execute time (ms)	796
	Fetch time (ms)	0
	Total time (ms)	796
	Start time	2024-05-21 15:14:28.177
	Finish time	2024-05-21 15:14:28.974

	-- CONECTAR NO DATABASE POSTGRES

	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriel.cardoso";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_m4u_connector','rw_payments_manager','rw_wallet') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriela.jardim";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_m4u_connector','rw_payments_manager','rw_wallet') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "eder.moraes";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_m4u_connector','rw_payments_manager','rw_wallet') 
	order by 1;

	GRANT CONNECT ON DATABASE rw_m4u_connector TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_m4u_connector TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_m4u_connector TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_payments_manager TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_payments_manager TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_payments_manager TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_wallet TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_wallet TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_wallet TO "gabriela.jardim";

	Queries	9
	Updated Rows	0
	Execute time (ms)	2394
	Fetch time (ms)	0
	Total time (ms)	2394
	Start time	2024-05-21 15:15:14.732
	Finish time	2024-05-21 15:15:17.132
	
	-- CONECTAR EM CADA DATABASE
	
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriel.cardoso";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriela.jardim";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "eder.moraes";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     order by 1 desc;
     
    GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "repack" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "repack" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "repack" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "repack" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "repack" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "repack" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "repack" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "repack" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "repack" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	36
	Updated Rows	0
	Execute time (ms)	9569
	Fetch time (ms)	0
	Total time (ms)	9569
	Start time	2024-05-21 15:16:43.476
	Finish time	2024-05-21 15:16:53.063
	*/

	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_happy" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_happy" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_happy" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_happy" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_happy" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_happy" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_happy" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_happy" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_happy" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	45
	Updated Rows	0
	Execute time (ms)	11967
	Fetch time (ms)	0
	Total time (ms)	11967
	Start time	2024-05-21 15:19:09.546
	Finish time	2024-05-21 15:19:21.533
	*/

	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_happy" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_happy" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_happy" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_happy" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_happy" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_happy" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_happy" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_happy" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_happy" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	36
	Updated Rows	0
	Execute time (ms)	9612
	Fetch time (ms)	0
	Total time (ms)	9612
	Start time	2024-05-21 15:21:24.990
	Finish time	2024-05-21 15:21:34.621
	*/

 	
	--
	-- realwave-claro-billing-query-database-prd.ccvkkkqwkw2e.sa-east-1.rds.amazonaws.com
	--		rw_account_cash
	--		rw_payments_manager
	--		rw_wallet
	--		
	
	-- CRIAR O USUÁRIO - CONNECTAR NA INSÂNCIA
	
	CREATE USER "gabriel.cardoso" WITH PASSWORD 'xxxxxxxxxxxxx';
	CREATE USER "gabriela.jardim" WITH PASSWORD 'yyyyyyyyyyyyyy';
	CREATE USER "eder.moraes" WITH PASSWORD 'zzzzzzzzzzzzzzz';

	/*
	 Queries	3
	Updated Rows	0
	Execute time (ms)	798
	Fetch time (ms)	0
	Total time (ms)	798
	Start time	2024-05-21 15:24:20.513
	Finish time	2024-05-21 15:24:21.312
	 */

	-- CONECTAR NO DATABASE POSTGRES

	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriel.cardoso";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_account_cash','rw_payments_manager','rw_wallet') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriela.jardim";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_account_cash','rw_payments_manager','rw_wallet') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "eder.moraes";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_account_cash','rw_payments_manager','rw_wallet') 
	order by 1;
	
	GRANT CONNECT ON DATABASE rw_account_cash TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_account_cash TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_account_cash TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_payments_manager TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_payments_manager TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_payments_manager TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_wallet TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_wallet TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_wallet TO "gabriela.jardim";

	/*
	 Queries	9
	Updated Rows	0
	Execute time (ms)	2398
	Fetch time (ms)	0
	Total time (ms)	2398
	Start time	2024-05-21 15:25:06.862
	Finish time	2024-05-21 15:25:09.268
	 */
	-- CONECTAR EM CADA DATABASE
	
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriel.cardoso";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriela.jardim";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "eder.moraes";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     order by 1 desc;
 
    GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	27
	Updated Rows	0
	Execute time (ms)	7211
	Fetch time (ms)	0
	Total time (ms)	7211
	Start time	2024-05-21 15:26:06.025
	Finish time	2024-05-21 15:26:13.250
	*/

	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_happy" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_happy" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_happy" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_happy" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_happy" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_happy" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_happy" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_happy" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_happy" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	45
	Updated Rows	0
	Execute time (ms)	12014
	Fetch time (ms)	0
	Total time (ms)	12014
	Start time	2024-05-21 15:27:35.448
	Finish time	2024-05-21 15:27:47.484
	*/

	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	9
	Updated Rows	0
	Execute time (ms)	2412
	Fetch time (ms)	0
	Total time (ms)	2412
	Start time	2024-05-21 15:28:51.868
	Finish time	2024-05-21 15:28:54.283
	*/

	--
	-- realwave-claro-extensions-database-prd.ccvkkkqwkw2e.sa-east-1.rds.amazonaws.com
	-- 		rw_claro_flex_account_cash
	-- 		rw_extensions
	-- 		rw_extensions_chipflex
	--
	
	-- CRIAR O USUÁRIO - CONNECTAR NA INSÂNCIA
	
	CREATE USER "gabriel.cardoso" WITH PASSWORD 'xxxxxxxxxxxxx';
	CREATE USER "gabriela.jardim" WITH PASSWORD 'yyyyyyyyyyyyyy';
	CREATE USER "eder.moraes" WITH PASSWORD 'zzzzzzzzzzzzzzz';

	/*
	Queries	3
	Updated Rows	0
	Execute time (ms)	807
	Fetch time (ms)	0
	Total time (ms)	807
	Start time	2024-05-21 15:30:48.923
	Finish time	2024-05-21 15:30:49.731
	 */

	-- CONECTAR NO DATABASE POSTGRES

	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriel.cardoso";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_claro_flex_account_cash','rw_extensions','rw_extensions_chipflex') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriela.jardim";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_claro_flex_account_cash','rw_extensions','rw_extensions_chipflex') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "eder.moraes";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_claro_flex_account_cash','rw_extensions','rw_extensions_chipflex')  
	order by 1;
	

	GRANT CONNECT ON DATABASE rw_claro_flex_account_cash TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_claro_flex_account_cash TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_claro_flex_account_cash TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_extensions TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_extensions TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_extensions TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_extensions_chipflex TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_extensions_chipflex TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_extensions_chipflex TO "gabriela.jardim";

	/*
	Queries	9
	Updated Rows	0
	Execute time (ms)	2375
	Fetch time (ms)	0
	Total time (ms)	2375
	Start time	2024-05-21 15:31:44.554
	Finish time	2024-05-21 15:31:46.936
	 */

	-- CONECTAR EM CADA DATABASE
	
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriel.cardoso";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriela.jardim";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "eder.moraes";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     order by 1 desc;
     
    GRANT USAGE ON SCHEMA "rw_claro_flex_account_cash" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_flex_account_cash" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_flex_account_cash" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex_account_cash" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex_account_cash" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex_account_cash" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex_account_cash" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex_account_cash" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex_account_cash" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	18
	Updated Rows	0
	Execute time (ms)	4754
	Fetch time (ms)	0
	Total time (ms)	4754
	Start time	2024-05-21 15:33:14.131
	Finish time	2024-05-21 15:33:18.895
	*/

	GRANT USAGE ON SCHEMA "rw_claro_extensions" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_extensions" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_extensions" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_custom" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_custom" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_custom" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "graphile_worker" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "graphile_worker" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "graphile_worker" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_extensions" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_extensions" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_extensions" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_custom" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_custom" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_custom" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "graphile_worker" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "graphile_worker" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "graphile_worker" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_extensions" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_extensions" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_extensions" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_custom" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_custom" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_custom" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "graphile_worker" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "graphile_worker" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "graphile_worker" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	36
	Updated Rows	0
	Execute time (ms)	9661
	Fetch time (ms)	0
	Total time (ms)	9661
	Start time	2024-05-21 15:34:34.707
	Finish time	2024-05-21 15:34:44.392
	*/

	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_defaults" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_defaults" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_defaults" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_defaults" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_defaults" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_defaults" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_defaults" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_defaults" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_defaults" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	36
	Updated Rows	0
	Execute time (ms)	9505
	Fetch time (ms)	0
	Total time (ms)	9505
	Start time	2024-05-21 15:35:58.850
	Finish time	2024-05-21 15:36:08.375
	*/

 	
	--
	-- realwave-claro-shared-database-prd.ccvkkkqwkw2e.sa-east-1.rds.amazonaws.com
	--		rw_catalog_manager
	--		rw_com
	--		rw_com_query
	--		rw_coupon
	--		rw_customer_inventory
	--		rw_customer_manager
	--		rw_mgm
	--		rw_product_manager
	--		rw_som
	--		rw_user_manager
	--

	-- CRIAR O USUÁRIO - CONNECTAR NA INSÂNCIA
	
	CREATE USER "gabriel.cardoso" WITH PASSWORD 'xxxxxxxxxxxxx';
	CREATE USER "gabriela.jardim" WITH PASSWORD 'yyyyyyyyyyyyyy';
	CREATE USER "eder.moraes" WITH PASSWORD 'zzzzzzzzzzzzzzz';

	/*
	Queries	3
	Updated Rows	0
	Execute time (ms)	800
	Fetch time (ms)	0
	Total time (ms)	800
	Start time	2024-05-21 15:42:28.736
	Finish time	2024-05-21 15:42:29.539
	 */

	-- CONECTAR NO DATABASE POSTGRES

	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriel.cardoso";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_catalog_manager','rw_com','rw_com_query','rw_coupon','rw_customer_inventory','rw_customer_manager','rw_mgm','rw_product_manager','rw_som','rw_user_manager') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriela.jardim";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_catalog_manager','rw_com','rw_com_query','rw_coupon','rw_customer_inventory','rw_customer_manager','rw_mgm','rw_product_manager','rw_som','rw_user_manager') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "eder.moraes";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_catalog_manager','rw_com','rw_com_query','rw_coupon','rw_customer_inventory','rw_customer_manager','rw_mgm','rw_product_manager','rw_som','rw_user_manager')   
	order by 1;

	GRANT CONNECT ON DATABASE rw_catalog_manager TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_catalog_manager TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_catalog_manager TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_com TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_com TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_com TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_com_query TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_com_query TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_com_query TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_coupon TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_coupon TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_coupon TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_customer_inventory TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_customer_inventory TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_customer_inventory TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_customer_manager TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_customer_manager TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_customer_manager TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_mgm TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_mgm TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_mgm TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_product_manager TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_product_manager TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_product_manager TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_som TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_som TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_som TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE rw_user_manager TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_user_manager TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_user_manager TO "gabriela.jardim";

	/*
	Queries	30
	Updated Rows	0
	Execute time (ms)	7928
	Fetch time (ms)	0
	Total time (ms)	7928
	Start time	2024-05-21 15:43:41.577
	Finish time	2024-05-21 15:43:49.516
	 */

	-- CONECTAR EM CADA DATABASE
	
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriel.cardoso";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriela.jardim";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "eder.moraes";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     order by 1 desc;

	GRANT USAGE ON SCHEMA "rw_cm_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_cm_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_cm_claro_net_digital_bsim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_cm_claro_net_digital" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_cm_claro_net_digital" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_cm_claro_net_digital" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_cm_claro_happy" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_cm_claro_happy" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_cm_claro_happy" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_cm_claro_flex_regressivo" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_cm_claro_flex_regressivo" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_cm_claro_flex_regressivo" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_cm_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_cm_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_cm_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_cm_claro_claro_now" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_cm_claro_claro_now" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_cm_claro_claro_now" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_net_digital_bsim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_net_digital" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_net_digital" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_net_digital" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_happy" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_happy" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_happy" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_flex_regressivo" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_flex_regressivo" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_flex_regressivo" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_claro_now" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_claro_now" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_cm_claro_claro_now" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_net_digital" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_net_digital" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_net_digital" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_happy" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_happy" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_happy" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_flex_regressivo" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_flex_regressivo" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_flex_regressivo" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_claro_now" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_claro_now" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_cm_claro_claro_now" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	63
	Updated Rows	0
	Execute time (ms)	16711
	Fetch time (ms)	0
	Total time (ms)	16711
	Start time	2024-05-21 15:45:21.751
	Finish time	2024-05-21 15:45:38.483
	*/

	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "graphile_worker" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "graphile_worker" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "graphile_worker" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "graphile_worker" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "graphile_worker" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "graphile_worker" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "graphile_worker" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "graphile_worker" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "graphile_worker" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	18
	Updated Rows	0
	Execute time (ms)	4803
	Fetch time (ms)	0
	Total time (ms)	4803
	Start time	2024-05-21 15:46:50.522
	Finish time	2024-05-21 15:46:55.334
	*/

	GRANT USAGE ON SCHEMA "rw_com_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_com_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_com_claro_net_digital_bsim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_com_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_com_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_com_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_com_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_com_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_com_claro_net_digital_bsim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_com_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_com_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_com_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_com_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_com_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_com_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_com_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_com_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_com_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	27
	Updated Rows	0
	Execute time (ms)	7211
	Fetch time (ms)	0
	Total time (ms)	7211
	Start time	2024-05-21 15:48:27.474
	Finish time	2024-05-21 15:48:34.695
	 */

	GRANT USAGE ON SCHEMA "rw_coupon_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_coupon_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_coupon_claro_net_digital_bsim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_coupon_claro_net_digital" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_coupon_claro_net_digital" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_coupon_claro_net_digital" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_coupon_claro_happy" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_coupon_claro_happy" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_coupon_claro_happy" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_coupon_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_coupon_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_coupon_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_coupon_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_coupon_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_coupon_claro_net_digital_bsim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_coupon_claro_net_digital" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_coupon_claro_net_digital" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_coupon_claro_net_digital" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_coupon_claro_happy" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_coupon_claro_happy" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_coupon_claro_happy" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_coupon_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_coupon_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_coupon_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_coupon_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_coupon_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_coupon_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_coupon_claro_net_digital" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_coupon_claro_net_digital" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_coupon_claro_net_digital" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_coupon_claro_happy" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_coupon_claro_happy" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_coupon_claro_happy" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_coupon_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_coupon_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_coupon_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	45
	Updated Rows	0
	Execute time (ms)	12008
	Fetch time (ms)	0
	Total time (ms)	12008
	Start time	2024-05-21 15:49:53.195
	Finish time	2024-05-21 15:50:05.223
	*/

	GRANT USAGE ON SCHEMA "rw_customer_inventory_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_customer_inventory_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_customer_inventory_claro_net_digital_bsim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_customer_inventory_claro_happy" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_customer_inventory_claro_happy" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_customer_inventory_claro_happy" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_customer_inventory_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_customer_inventory_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_customer_inventory_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_inventory_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_inventory_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_inventory_claro_net_digital_bsim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_inventory_claro_happy" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_inventory_claro_happy" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_inventory_claro_happy" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_inventory_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_inventory_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_inventory_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_inventory_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_inventory_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_inventory_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_inventory_claro_happy" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_inventory_claro_happy" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_inventory_claro_happy" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_inventory_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_inventory_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_inventory_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	36
	Updated Rows	0
	Execute time (ms)	9580
	Fetch time (ms)	0
	Total time (ms)	9580
	Start time	2024-05-21 15:51:27.442
	Finish time	2024-05-21 15:51:37.043
	*/

	GRANT USAGE ON SCHEMA "rw_customer_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_customer_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_customer_claro_net_digital_bsim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_customer_claro_net_digital" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_customer_claro_net_digital" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_customer_claro_net_digital" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_customer_claro_happy" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_customer_claro_happy" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_customer_claro_happy" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_customer_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_customer_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_customer_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_customer_claro_claro_now" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_customer_claro_claro_now" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_customer_claro_claro_now" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_net_digital_bsim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_net_digital" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_net_digital" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_net_digital" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_happy" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_happy" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_happy" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_claro_now" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_claro_now" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_customer_claro_claro_now" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_net_digital" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_net_digital" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_net_digital" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_happy" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_happy" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_happy" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_claro_now" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_claro_now" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_customer_claro_claro_now" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	54
	Updated Rows	0
	Execute time (ms)	14492
	Fetch time (ms)	0
	Total time (ms)	14492
	Start time	2024-05-21 15:52:54.631
	Finish time	2024-05-21 15:53:09.155
	*/

	GRANT USAGE ON SCHEMA "rw_mgm_claro_net_digital" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_mgm_claro_net_digital" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_mgm_claro_net_digital" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_mgm_claro_happy" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_mgm_claro_happy" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_mgm_claro_happy" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_mgm_claro_flex_regressivo" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_mgm_claro_flex_regressivo" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_mgm_claro_flex_regressivo" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_mgm_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_mgm_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_mgm_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_mgm_claro_net_digital" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_mgm_claro_net_digital" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_mgm_claro_net_digital" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_mgm_claro_happy" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_mgm_claro_happy" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_mgm_claro_happy" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_mgm_claro_flex_regressivo" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_mgm_claro_flex_regressivo" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_mgm_claro_flex_regressivo" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_mgm_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_mgm_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_mgm_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_mgm_claro_net_digital" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_mgm_claro_net_digital" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_mgm_claro_net_digital" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_mgm_claro_happy" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_mgm_claro_happy" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_mgm_claro_happy" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_mgm_claro_flex_regressivo" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_mgm_claro_flex_regressivo" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_mgm_claro_flex_regressivo" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_mgm_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_mgm_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_mgm_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	45
	Updated Rows	0
	Execute time (ms)	12103
	Fetch time (ms)	0
	Total time (ms)	12103
	Start time	2024-05-21 16:04:11.636
	Finish time	2024-05-21 16:04:23.761
	*/

	GRANT USAGE ON SCHEMA "rw_pcm_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_net_digital_bsim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_net_digital" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_net_digital" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_net_digital" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_happy" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_happy" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_happy" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_flex_regressivo" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_flex_regressivo" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_flex_regressivo" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_pcm_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_net_digital_bsim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_net_digital" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_net_digital" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_net_digital" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_happy" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_happy" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_happy" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_flex_regressivo" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_flex_regressivo" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_flex_regressivo" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_pcm_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_net_digital" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_net_digital" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_net_digital" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_happy" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_happy" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_happy" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_flex_regressivo" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_flex_regressivo" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_flex_regressivo" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_pcm_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	63
	Updated Rows	0
	Execute time (ms)	16900
	Fetch time (ms)	0
	Total time (ms)	16900
	Start time	2024-05-21 15:56:33.043
	Finish time	2024-05-21 15:56:49.973
	*/

	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	9
	Updated Rows	0
	Execute time (ms)	2428
	Fetch time (ms)	0
	Total time (ms)	2428
	Start time	2024-05-21 15:57:58.348
	Finish time	2024-05-21 15:58:00.782
	*/

	GRANT USAGE ON SCHEMA "rw_user_manager_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro_net_digital_bsim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro_net_digital" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro_net_digital" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro_net_digital" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_user_manager_claro" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro_net_digital_bsim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro_net_digital" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro_net_digital" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro_net_digital" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_user_manager_claro" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro_net_digital" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro_net_digital" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro_net_digital" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro_ac76a7739985cdacad94eecd7f04ff64a97e0e93" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_user_manager_claro" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";

	/*
	Queries	54
	Updated Rows	0
	Execute time (ms)	14464
	Fetch time (ms)	0
	Total time (ms)	14464
	Start time	2024-05-21 16:00:10.266
	Finish time	2024-05-21 16:00:24.748
	*/


	--
	-- realwave-claro-subscriptions-database-prd.ccvkkkqwkw2e.sa-east-1.rds.amazonaws.com
	--		rw_subscriptions_manager
	-- 

	-- CRIAR O USUÁRIO - CONNECTAR NA INSÂNCIA
	
	CREATE USER "gabriel.cardoso" WITH PASSWORD 'xxxxxxxxxxxxx';
	CREATE USER "gabriela.jardim" WITH PASSWORD 'yyyyyyyyyyyyyy';
	CREATE USER "eder.moraes" WITH PASSWORD 'zzzzzzzzzzzzzzz';

	/*
	Queries	3
	Updated Rows	0
	Execute time (ms)	817
	Fetch time (ms)	0
	Total time (ms)	817
	Start time	2024-05-21 16:07:13.764
	Finish time	2024-05-21 16:07:14.584
	 */

	-- CONECTAR NO DATABASE POSTGRES

	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriel.cardoso";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_subscriptions_manager') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriela.jardim";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_subscriptions_manager') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "eder.moraes";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rw_subscriptions_manager') 
	order by 1;
	
	GRANT CONNECT ON DATABASE rw_subscriptions_manager TO "eder.moraes";
	GRANT CONNECT ON DATABASE rw_subscriptions_manager TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE rw_subscriptions_manager TO "gabriela.jardim";

	/*
	Queries	3
	Updated Rows	0
	Execute time (ms)	810
	Fetch time (ms)	0
	Total time (ms)	810
	Start time	2024-05-21 16:07:52.943
	Finish time	2024-05-21 16:07:53.756
	 */

	-- CONECTAR EM CADA DATABASE
	
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriel.cardoso";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriela.jardim";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriela.jardim";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
	 union
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "eder.moraes";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "eder.moraes";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     order by 1 desc;
	
    
    GRANT USAGE ON SCHEMA "tmp_restore_table" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "tmp_restore_table" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "tmp_restore_table" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital_bsim" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_net_digital" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_happy" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_happy" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_happy" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT USAGE ON SCHEMA "public" TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "public" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "tmp_restore_table" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "tmp_restore_table" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "tmp_restore_table" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital_bsim" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_net_digital" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_happy" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_happy" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_happy" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "rw_claro_flex" TO "eder.moraes";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriela.jardim";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "tmp_restore_table" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "tmp_restore_table" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "tmp_restore_table" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital_bsim" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_net_digital" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_happy" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_happy" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_happy" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "rw_claro_flex" GRANT SELECT ON TABLES TO "eder.moraes";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriela.jardim";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "eder.moraes";
	
	/*
	Queries	54
	Updated Rows	0
	Execute time (ms)	14509
	Fetch time (ms)	0
	Total time (ms)	14509
	Start time	2024-05-21 16:09:20.459
	Finish time	2024-05-21 16:09:34.990
	*/

	
	--
	-- robo-log-api-claro-prd.ccvkkkqwkw2e.sa-east-1.rds.amazonaws.com
	-- 		rpa
	-- 
	
	-- CRIAR O USUÁRIO - CONNECTAR NA INSÂNCIA
	
	CREATE USER "gabriel.cardoso" WITH PASSWORD 'xxxxxxxxxxxxx';

	-- CONECTAR NO DATABASE POSTGRES

	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriel.cardoso";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('rpa') 
	order by 1;

	GRANT CONNECT ON DATABASE rpa TO "gabriel.cardoso";
	
	-- CONECTAR EM CADA DATABASE
	
	 select 'GRANT USAGE ON SCHEMA "'||a.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace a
     where a.nspname not like 'pg_toast%' and a.nspname not like 'pg_temp%' and a.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     union 
     select 'GRANT SELECT ON ALL TABLES IN SCHEMA "'||b.nspname|| '" TO "gabriel.cardoso";' from pg_catalog.pg_namespace b 
     where b.nspname not like 'pg_toast%' and b.nspname not like 'pg_temp%' and b.nspname not in ('repack', 'pg_catalog', 'information_schema')
     union
     select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriel.cardoso";'
     from pg_catalog.pg_namespace c 
     where c.nspname not like 'pg_toast%' and c.nspname not like 'pg_temp%' and c.nspname not in ('repack', 'pg_catalog', 'information_schema') 
     order by 1 desc;
     
	GRANT USAGE ON SCHEMA "public" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "aws_s3" TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA "aws_commons" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "aws_s3" TO "gabriel.cardoso";
	GRANT SELECT ON ALL TABLES IN SCHEMA "aws_commons" TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "aws_s3" GRANT SELECT ON TABLES TO "gabriel.cardoso";
	ALTER DEFAULT PRIVILEGES IN SCHEMA "aws_commons" GRANT SELECT ON TABLES TO "gabriel.cardoso";

	/*
	Queries	9
	Updated Rows	0
	Execute time (ms)	2406
	Fetch time (ms)	0
	Total time (ms)	2406
	Start time	2024-05-21 16:14:06.598
	Finish time	2024-05-21 16:14:09.008
	*/


######################################################

	-- 
	-- REDSHIFT
	--
	
	-- https://repost.aws/questions/QUNhjLuFi0SfiY1AMNscIz7g/how-to-create-a-redshift-user-with-selective-schema-permissions
	
	Usuários:
	gabriel.cardoso@globalhitss.com.br ("gabriel.cardoso") 
	gabriela.jardim@globalhitss.com.br ("gabriela.jardim")
	eder.moraes.3@globalhitss.com.br ("eder.moraes")
	mayara.esther@globalhitss.com.br ("mayara.esther")
	christian.moreira@globalhitss.com.br ("christian.moreira")

	Host/BD:
	redshift-cluster-prd-mvno.cghwhth2ktzq.sa-east-1.redshift.amazonaws.com:5439/mvno

	Permissão de USO nos Schemas:
	app_extensions
	bi_dev
	bi_public
	bi_raw
	bi_stage
	bi_utils
	rw_camunda_com_extension
	rw_camunda_som_extension
	rw_catalog_manager_claro_dry
	rw_catalog_manager_claro_magalu
	rw_com_extension_mvno_claro_dry
	rw_com_extension_mvno_claro_magalu
	rw_customer_claro_dry
	rw_customer_claro_magalu
	rw_customer_inventory_claro_dry
	rw_customer_inventory_claro_magalu
	rw_pcm_claro_dry
	rw_pcm_claro_magalu
	rw_som_extension_mvno_claro_dry
	rw_som_extension_mvno_claro_magalu

	E permissão de LEITURA em todas as tabelas dos Schemas acima.

	PS.: Até onde eu me lembre, o Redshift precisa de permissão de USO (GRANT USAGED) explícito.


	-- CRIAR O USUÁRIO - CONNECTAR NA INSÂNCIA
	
	CREATE USER "gabriel.cardoso" WITH PASSWORD 'xxxxxxxxxxxxx';
	CREATE USER "gabriela.jardim" WITH PASSWORD 'yyyyyyyyyyyyyy';
	CREATE USER "eder.moraes" WITH PASSWORD 'zzzzzzzzzzzzzzz';
	CREATE USER "mayara.esther" WITH PASSWORD 'tttttttttttttttttttttt';
	CREATE USER "christian.moreira" WITH PASSWORD 'rrrrrrrrrrrrrrrrrrrrrrrr';
	
	Queries	4
	Updated Rows	0
	Execute time (ms)	1364
	Fetch time (ms)	0
	Total time (ms)	1364
	Start time	2024-05-21 13:35:41.629
	Finish time	2024-05-21 13:36:08.295
	SQL Error [42710]: ERROR: user "christian.moreira" already exists
	ERROR: user "christian.moreira" already exists
	ERROR: user "christian.moreira" already exists


	-- CONECTAR NO DATABASE POSTGRES

	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriel.cardoso";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('mvno') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "gabriela.jardim";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('mvno') 
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "eder.moraes";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('mvno')   
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "mayara.esther";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('mvno')   
	UNION ALL 
	select 'GRANT CONNECT ON DATABASE ' || pd.datname || ' TO "christian.moreira";'
	from pg_catalog.pg_database pd 
	where pd.datname in ('mvno')   
	order by 1;
	
	SQL Error [42P01]: ERROR: relation "pd" does not exist
	
	GRANT CONNECT ON DATABASE mvno TO "gabriel.cardoso";
	GRANT CONNECT ON DATABASE mvno TO "gabriela.jardim";
	GRANT CONNECT ON DATABASE mvno TO "eder.moraes";
	GRANT CONNECT ON DATABASE mvno TO "mayara.esther";
	GRANT CONNECT ON DATABASE mvno TO "christian.moreira";
	
	-- NÃO TEM GRANT CONNECT ON DATABASE PARA O REDSHIFT - CONFIRMAR ISSO DEPOIS
	
	
	-- CONECTAR EM CADA DATABASE
	
	SELECT 'GRANT USAGE ON SCHEMA "'||s.schema_name|| ' TO "gabriel.cardoso";' 
	FROM svv_all_schemas s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	UNION 
	SELECT 'GRANT USAGE ON SCHEMA "'||s.schema_name|| ' TO "gabriela.jardim";' 
	FROM svv_all_schemas s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	UNION 
	SELECT 'GRANT USAGE ON SCHEMA "'||s.schema_name|| ' TO "eder.moraes";' 
	FROM svv_all_schemas s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	UNION 
	SELECT 'GRANT USAGE ON SCHEMA "'||s.schema_name|| ' TO "mayara.esther";' 
	FROM svv_all_schemas s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	UNION 
	SELECT 'GRANT USAGE ON SCHEMA "'||s.schema_name|| ' TO "christian.moreira";' 
	FROM svv_all_schemas s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	ORDER BY s.database_name,s.schema_name;


	GRANT USAGE ON SCHEMA app_extensions TO "christian.moreira";
	GRANT USAGE ON SCHEMA app_extensions TO "eder.moraes";
	GRANT USAGE ON SCHEMA app_extensions TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA app_extensions TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA app_extensions TO "mayara.esther";
	GRANT USAGE ON SCHEMA bi_dev TO "christian.moreira";
	GRANT USAGE ON SCHEMA bi_dev TO "eder.moraes";
	GRANT USAGE ON SCHEMA bi_dev TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA bi_dev TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA bi_dev TO "mayara.esther";
	GRANT USAGE ON SCHEMA bi_public TO "christian.moreira";
	GRANT USAGE ON SCHEMA bi_public TO "eder.moraes";
	GRANT USAGE ON SCHEMA bi_public TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA bi_public TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA bi_public TO "mayara.esther";
	GRANT USAGE ON SCHEMA bi_raw TO "christian.moreira";
	GRANT USAGE ON SCHEMA bi_raw TO "eder.moraes";
	GRANT USAGE ON SCHEMA bi_raw TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA bi_raw TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA bi_raw TO "mayara.esther";
	GRANT USAGE ON SCHEMA bi_stage TO "christian.moreira";
	GRANT USAGE ON SCHEMA bi_stage TO "eder.moraes";
	GRANT USAGE ON SCHEMA bi_stage TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA bi_stage TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA bi_stage TO "mayara.esther";
	GRANT USAGE ON SCHEMA bi_utils TO "christian.moreira";
	GRANT USAGE ON SCHEMA bi_utils TO "eder.moraes";
	GRANT USAGE ON SCHEMA bi_utils TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA bi_utils TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA bi_utils TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_camunda_com_extension TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_camunda_com_extension TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_camunda_com_extension TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_camunda_com_extension TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_camunda_com_extension TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_camunda_som_extension TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_camunda_som_extension TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_camunda_som_extension TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_camunda_som_extension TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_camunda_som_extension TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_catalog_manager_claro_dry TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_catalog_manager_claro_dry TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_catalog_manager_claro_dry TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_catalog_manager_claro_dry TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_catalog_manager_claro_dry TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_catalog_manager_claro_magalu TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_catalog_manager_claro_magalu TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_catalog_manager_claro_magalu TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_catalog_manager_claro_magalu TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_catalog_manager_claro_magalu TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_com_extension_mvno_claro_dry TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_com_extension_mvno_claro_dry TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_com_extension_mvno_claro_dry TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_com_extension_mvno_claro_dry TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_com_extension_mvno_claro_dry TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_com_extension_mvno_claro_magalu TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_com_extension_mvno_claro_magalu TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_com_extension_mvno_claro_magalu TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_com_extension_mvno_claro_magalu TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_com_extension_mvno_claro_magalu TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_customer_claro_dry TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_customer_claro_dry TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_customer_claro_dry TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_customer_claro_dry TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_customer_claro_dry TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_customer_claro_magalu TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_customer_claro_magalu TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_customer_claro_magalu TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_customer_claro_magalu TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_customer_claro_magalu TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_customer_inventory_claro_dry TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_customer_inventory_claro_dry TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_customer_inventory_claro_dry TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_customer_inventory_claro_dry TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_customer_inventory_claro_dry TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_customer_inventory_claro_magalu TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_customer_inventory_claro_magalu TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_customer_inventory_claro_magalu TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_customer_inventory_claro_magalu TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_customer_inventory_claro_magalu TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_pcm_claro_dry TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_pcm_claro_dry TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_pcm_claro_dry TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_pcm_claro_dry TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_pcm_claro_dry TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_pcm_claro_magalu TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_pcm_claro_magalu TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_pcm_claro_magalu TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_pcm_claro_magalu TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_pcm_claro_magalu TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_som_extension_mvno_claro_dry TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_som_extension_mvno_claro_dry TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_som_extension_mvno_claro_dry TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_som_extension_mvno_claro_dry TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_som_extension_mvno_claro_dry TO "mayara.esther";
	GRANT USAGE ON SCHEMA rw_som_extension_mvno_claro_magalu TO "christian.moreira";
	GRANT USAGE ON SCHEMA rw_som_extension_mvno_claro_magalu TO "eder.moraes";
	GRANT USAGE ON SCHEMA rw_som_extension_mvno_claro_magalu TO "gabriel.cardoso";
	GRANT USAGE ON SCHEMA rw_som_extension_mvno_claro_magalu TO "gabriela.jardim";
	GRANT USAGE ON SCHEMA rw_som_extension_mvno_claro_magalu TO "mayara.esther";

	Queries	100
	Updated Rows	0
	Execute time (ms)	41611
	Fetch time (ms)	0
	Total time (ms)	41611
	Start time	2024-05-21 14:03:37.137
	Finish time	2024-05-21 14:04:44.996
	
	SELECT 'grant select on all tables in schema ' || s.schema_name || ' TO "gabriel.cardoso";' 
	FROM svv_all_schemas as s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	UNION 
	SELECT 'grant select on all tables in schema ' || s.schema_name || ' TO "gabriela.jardim";' 
	FROM svv_all_schemas as s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	UNION 
	SELECT 'grant select on all tables in schema ' || s.schema_name || ' TO "eder.moraes";' 
	FROM svv_all_schemas as s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	UNION 
	SELECT 'grant select on all tables in schema ' || s.schema_name || ' TO "mayara.esther";' 
	FROM svv_all_schemas as s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	UNION 
	SELECT 'grant select on all tables in schema ' || s.schema_name || ' TO "christian.moreira";' 
	FROM svv_all_schemas as s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	-- ORDER BY s.database_name,s.schema_name;

	grant select on all tables in schema app_extensions TO "christian.moreira";
	grant select on all tables in schema app_extensions TO "eder.moraes";
	grant select on all tables in schema app_extensions TO "gabriel.cardoso";
	grant select on all tables in schema app_extensions TO "gabriela.jardim";
	grant select on all tables in schema app_extensions TO "mayara.esther";
	grant select on all tables in schema bi_dev TO "christian.moreira";
	grant select on all tables in schema bi_dev TO "eder.moraes";
	grant select on all tables in schema bi_dev TO "gabriel.cardoso";
	grant select on all tables in schema bi_dev TO "gabriela.jardim";
	grant select on all tables in schema bi_dev TO "mayara.esther";
	grant select on all tables in schema bi_public TO "christian.moreira";
	grant select on all tables in schema bi_public TO "eder.moraes";
	grant select on all tables in schema bi_public TO "gabriel.cardoso";
	grant select on all tables in schema bi_public TO "gabriela.jardim";
	grant select on all tables in schema bi_public TO "mayara.esther";
	grant select on all tables in schema bi_raw TO "christian.moreira";
	grant select on all tables in schema bi_raw TO "eder.moraes";
	grant select on all tables in schema bi_raw TO "gabriel.cardoso";
	grant select on all tables in schema bi_raw TO "gabriela.jardim";
	grant select on all tables in schema bi_raw TO "mayara.esther";
	grant select on all tables in schema bi_stage TO "christian.moreira";
	grant select on all tables in schema bi_stage TO "eder.moraes";
	grant select on all tables in schema bi_stage TO "gabriel.cardoso";
	grant select on all tables in schema bi_stage TO "gabriela.jardim";
	grant select on all tables in schema bi_stage TO "mayara.esther";
	grant select on all tables in schema bi_utils TO "christian.moreira";
	grant select on all tables in schema bi_utils TO "eder.moraes";
	grant select on all tables in schema bi_utils TO "gabriel.cardoso";
	grant select on all tables in schema bi_utils TO "gabriela.jardim";
	grant select on all tables in schema bi_utils TO "mayara.esther";
	grant select on all tables in schema rw_camunda_com_extension TO "christian.moreira";
	grant select on all tables in schema rw_camunda_com_extension TO "eder.moraes";
	grant select on all tables in schema rw_camunda_com_extension TO "gabriel.cardoso";
	grant select on all tables in schema rw_camunda_com_extension TO "gabriela.jardim";
	grant select on all tables in schema rw_camunda_com_extension TO "mayara.esther";
	grant select on all tables in schema rw_camunda_som_extension TO "christian.moreira";
	grant select on all tables in schema rw_camunda_som_extension TO "eder.moraes";
	grant select on all tables in schema rw_camunda_som_extension TO "gabriel.cardoso";
	grant select on all tables in schema rw_camunda_som_extension TO "gabriela.jardim";
	grant select on all tables in schema rw_camunda_som_extension TO "mayara.esther";
	grant select on all tables in schema rw_catalog_manager_claro_dry TO "christian.moreira";
	grant select on all tables in schema rw_catalog_manager_claro_dry TO "eder.moraes";
	grant select on all tables in schema rw_catalog_manager_claro_dry TO "gabriel.cardoso";
	grant select on all tables in schema rw_catalog_manager_claro_dry TO "gabriela.jardim";
	grant select on all tables in schema rw_catalog_manager_claro_dry TO "mayara.esther";
	grant select on all tables in schema rw_catalog_manager_claro_magalu TO "christian.moreira";
	grant select on all tables in schema rw_catalog_manager_claro_magalu TO "eder.moraes";
	grant select on all tables in schema rw_catalog_manager_claro_magalu TO "gabriel.cardoso";
	grant select on all tables in schema rw_catalog_manager_claro_magalu TO "gabriela.jardim";
	grant select on all tables in schema rw_catalog_manager_claro_magalu TO "mayara.esther";
	grant select on all tables in schema rw_com_extension_mvno_claro_dry TO "christian.moreira";
	grant select on all tables in schema rw_com_extension_mvno_claro_dry TO "eder.moraes";
	grant select on all tables in schema rw_com_extension_mvno_claro_dry TO "gabriel.cardoso";
	grant select on all tables in schema rw_com_extension_mvno_claro_dry TO "gabriela.jardim";
	grant select on all tables in schema rw_com_extension_mvno_claro_dry TO "mayara.esther";
	grant select on all tables in schema rw_com_extension_mvno_claro_magalu TO "christian.moreira";
	grant select on all tables in schema rw_com_extension_mvno_claro_magalu TO "eder.moraes";
	grant select on all tables in schema rw_com_extension_mvno_claro_magalu TO "gabriel.cardoso";
	grant select on all tables in schema rw_com_extension_mvno_claro_magalu TO "gabriela.jardim";
	grant select on all tables in schema rw_com_extension_mvno_claro_magalu TO "mayara.esther";
	grant select on all tables in schema rw_customer_claro_dry TO "christian.moreira";
	grant select on all tables in schema rw_customer_claro_dry TO "eder.moraes";
	grant select on all tables in schema rw_customer_claro_dry TO "gabriel.cardoso";
	grant select on all tables in schema rw_customer_claro_dry TO "gabriela.jardim";
	grant select on all tables in schema rw_customer_claro_dry TO "mayara.esther";
	grant select on all tables in schema rw_customer_claro_magalu TO "christian.moreira";
	grant select on all tables in schema rw_customer_claro_magalu TO "eder.moraes";
	grant select on all tables in schema rw_customer_claro_magalu TO "gabriel.cardoso";
	grant select on all tables in schema rw_customer_claro_magalu TO "gabriela.jardim";
	grant select on all tables in schema rw_customer_claro_magalu TO "mayara.esther";
	grant select on all tables in schema rw_customer_inventory_claro_dry TO "christian.moreira";
	grant select on all tables in schema rw_customer_inventory_claro_dry TO "eder.moraes";
	grant select on all tables in schema rw_customer_inventory_claro_dry TO "gabriel.cardoso";
	grant select on all tables in schema rw_customer_inventory_claro_dry TO "gabriela.jardim";
	grant select on all tables in schema rw_customer_inventory_claro_dry TO "mayara.esther";
	grant select on all tables in schema rw_customer_inventory_claro_magalu TO "christian.moreira";
	grant select on all tables in schema rw_customer_inventory_claro_magalu TO "eder.moraes";
	grant select on all tables in schema rw_customer_inventory_claro_magalu TO "gabriel.cardoso";
	grant select on all tables in schema rw_customer_inventory_claro_magalu TO "gabriela.jardim";
	grant select on all tables in schema rw_customer_inventory_claro_magalu TO "mayara.esther";
	grant select on all tables in schema rw_pcm_claro_dry TO "christian.moreira";
	grant select on all tables in schema rw_pcm_claro_dry TO "eder.moraes";
	grant select on all tables in schema rw_pcm_claro_dry TO "gabriel.cardoso";
	grant select on all tables in schema rw_pcm_claro_dry TO "gabriela.jardim";
	grant select on all tables in schema rw_pcm_claro_dry TO "mayara.esther";
	grant select on all tables in schema rw_pcm_claro_magalu TO "christian.moreira";
	grant select on all tables in schema rw_pcm_claro_magalu TO "eder.moraes";
	grant select on all tables in schema rw_pcm_claro_magalu TO "gabriel.cardoso";
	grant select on all tables in schema rw_pcm_claro_magalu TO "gabriela.jardim";
	grant select on all tables in schema rw_pcm_claro_magalu TO "mayara.esther";
	grant select on all tables in schema rw_som_extension_mvno_claro_dry TO "christian.moreira";
	grant select on all tables in schema rw_som_extension_mvno_claro_dry TO "eder.moraes";
	grant select on all tables in schema rw_som_extension_mvno_claro_dry TO "gabriel.cardoso";
	grant select on all tables in schema rw_som_extension_mvno_claro_dry TO "gabriela.jardim";
	grant select on all tables in schema rw_som_extension_mvno_claro_dry TO "mayara.esther";
	grant select on all tables in schema rw_som_extension_mvno_claro_magalu TO "christian.moreira";
	grant select on all tables in schema rw_som_extension_mvno_claro_magalu TO "eder.moraes";
	grant select on all tables in schema rw_som_extension_mvno_claro_magalu TO "gabriel.cardoso";
	grant select on all tables in schema rw_som_extension_mvno_claro_magalu TO "gabriela.jardim";
	grant select on all tables in schema rw_som_extension_mvno_claro_magalu TO "mayara.esther";

	Queries	100
	Updated Rows	0
	Execute time (ms)	34416
	Fetch time (ms)	0
	Total time (ms)	34416
	Start time	2024-05-21 14:11:41.905
	Finish time	2024-05-21 14:12:42.537

	-- alter default privileges in schema sales grant insert on tables to group sales_admin; 
	select 'ALTER DEFAULT PRIVILEGES IN SCHEMA "'||c.nspname||'" GRANT SELECT ON TABLES TO "gabriel.cardoso";'
	
	SELECT 'ALTER DEFAULT PRIVILEGES IN SCHEMA "' || s.schema_name || '" GRANT SELECT ON TABLES TO "christian.moreira";' 
	FROM svv_all_schemas as s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	UNION 
	SELECT 'ALTER DEFAULT PRIVILEGES IN SCHEMA "' || s.schema_name || '" GRANT SELECT ON TABLES TO "eder.moraes";' 
	FROM svv_all_schemas as s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	UNION 
	SELECT 'ALTER DEFAULT PRIVILEGES IN SCHEMA "' || s.schema_name || '" GRANT SELECT ON TABLES TO "gabriel.cardoso";' 
	FROM svv_all_schemas as s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	UNION 
	SELECT 'ALTER DEFAULT PRIVILEGES IN SCHEMA "' || s.schema_name || '" GRANT SELECT ON TABLES TO "gabriela.jardim";' 
	FROM svv_all_schemas as s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') 
	UNION 
	SELECT 'ALTER DEFAULT PRIVILEGES IN SCHEMA "' || s.schema_name || '" GRANT SELECT ON TABLES TO "mayara.esther";' 
	FROM svv_all_schemas as s WHERE s.database_name = 'mvno' and s.schema_name in ('app_extensions','bi_dev','bi_public','bi_raw','bi_stage','bi_utils','rw_camunda_com_extension','rw_camunda_som_extension','rw_catalog_manager_claro_dry','rw_catalog_manager_claro_magalu','rw_com_extension_mvno_claro_dry','rw_com_extension_mvno_claro_magalu','rw_customer_claro_dry','rw_customer_claro_magalu','rw_customer_inventory_claro_dry','rw_customer_inventory_claro_magalu','rw_pcm_claro_dry','rw_pcm_claro_magalu','rw_som_extension_mvno_claro_dry','rw_som_extension_mvno_claro_magalu') ;
	
	/*
	Queries	100
	Updated Rows	0
	Execute time (ms)	36128
	Fetch time (ms)	0
	Total time (ms)	36128
	Start time	2024-05-22 16:35:54.913
	Finish time	2024-05-22 16:36:56.874
	*/
	
	

