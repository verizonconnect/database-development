﻿DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_person_quota_history'
                           AND tc.constraint_name = 'pk_sales_person_quota_history'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.sales_person_quota_history
        ADD CONSTRAINT "pk_sales_person_quota_history"
        PRIMARY KEY (business_entity_id, quota_date);
    END IF;
END$$
