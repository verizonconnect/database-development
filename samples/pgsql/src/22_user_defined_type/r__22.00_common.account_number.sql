DO $$
BEGIN
IF NOT EXISTS (SELECT
               FROM     pg_type 
               WHERE    typname = 'account_number'
               AND      typnamespace = 'common'::regnamespace)
    THEN
        CREATE DOMAIN common.account_number VARCHAR(15) NULL;
END IF;
END;
$$;
