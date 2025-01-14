-- Criação da tabela particionada
CREATE TABLE rw_claro_flex.payments_partition (
	event_id varchar(100) NOT NULL,
	event_name varchar(255) NOT NULL,
	event_version int4 NOT NULL,
	event_timestamp timestamptz NOT NULL,
	customer_id varchar(100) NOT NULL,
	external_id varchar(100) NULL,
	payment_id varchar(100) NOT NULL,
	payment_type varchar(50) NOT NULL,
	event_data text NULL,
	async bool DEFAULT false NOT NULL,
	boleto_id varchar(100) null,
	CONSTRAINT payments_pkey_part PRIMARY KEY (event_id,event_timestamp)
)partition by range (event_timestamp);
/

-- Criação dos indices
CREATE INDEX idx_payments_partition_event_timestamp ON rw_claro_flex.payments_partition USING btree (event_timestamp) INCLUDE (event_id);
CREATE INDEX payments_partition_cst_bol_idx ON rw_claro_flex.payments_partition USING btree (customer_id, boleto_id);
CREATE INDEX payments_partition_cst_ext_idx ON rw_claro_flex.payments_partition USING btree (customer_id, external_id);
CREATE INDEX payments_partition_cst_idx ON rw_claro_flex.payments_partition USING btree (customer_id);
CREATE INDEX payments_partition_cst_pay_idx ON rw_claro_flex.payments_partition USING btree (customer_id, payment_id);
CREATE INDEX payments_partition_id_idx ON rw_claro_flex.payments_partition USING btree (payment_id);
/


-- Criação das partições
DO $$
DECLARE 
    month INT;
    start_date DATE;
    end_date DATE;
    partition_name TEXT;
BEGIN
    FOR month IN 1..12 LOOP
        -- Gerar o nome da partição dinamicamente
        partition_name := FORMAT('payments_partition_2025_%s', LPAD(month::TEXT, 2, '0'));

        -- Calcular as datas de início e fim para cada mês
        start_date := TO_DATE(FORMAT('2025-%s-01', LPAD(month::TEXT, 2, '0')), 'YYYY-MM-DD');
        end_date := start_date + INTERVAL '1 month';

        -- Criar a partição(mudar a tabela)
        EXECUTE FORMAT(
            'CREATE TABLE %I PARTITION OF payments_partition FOR VALUES FROM (%L) TO (%L);',
            partition_name, start_date, end_date
        );

        -- Adicionar a constraint UNIQUE na partição
        EXECUTE FORMAT(
            'ALTER TABLE %I ADD CONSTRAINT payments_cst_pay_eve_key_2025_%s UNIQUE (customer_id, payment_id, event_version);',
            partition_name, LPAD(month::TEXT, 2, '0')
        );
    END LOOP;
END $$;
/


-- Criação da partição DEFAULT
CREATE TABLE rw_claro_flex.payments_partition_default PARTITION OF rw_claro_flex.payments_partition DEFAULT;

-- Adicionar a constraint UNIQUE na partição DEFAULT
ALTER TABLE rw_claro_flex.payments_partition_default ADD CONSTRAINT payments_cst_pay_eve_key_default UNIQUE (customer_id, payment_id, event_version);
/

-- Conceder privilegios
DO $$
DECLARE
    perm RECORD;
BEGIN
    FOR perm IN
        SELECT grantee, privilege_type
        FROM information_schema.role_table_grants
        WHERE table_name = 'payments'
    LOOP
        -- Ignorar a role OPS$HOT
        IF perm.grantee = 'OPS$HOT' THEN
            RAISE NOTICE 'Skipping role OPS$HOT for GRANT %.', perm.privilege_type;
            CONTINUE;
        END IF;

        -- Conceder permissão para outras roles
        EXECUTE format('GRANT %s ON payments_partition TO %I', perm.privilege_type, perm.grantee);
    END LOOP;
END;
$$;

