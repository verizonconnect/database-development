DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'purchasing'
                           AND tc.table_name = 'ship_method'
                           AND tc.constraint_name = 'pk_ship_method'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE purchasing.ship_method
        ADD CONSTRAINT "pk_ship_method" 
        PRIMARY KEY (ship_method_id);
    END IF;
END$$
