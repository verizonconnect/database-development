DO $$
BEGIN
IF NOT EXISTS (SELECT
               FROM     pg_type 
               WHERE    typname = 'order_number'
               AND      typnamespace = 'common'::regnamespace)
    THEN
        CREATE DOMAIN common.order_number VARCHAR(25) NULL;
END IF;
END;
$$;
