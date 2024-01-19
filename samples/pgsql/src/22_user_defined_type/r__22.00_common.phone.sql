DO $$
BEGIN
IF NOT EXISTS (SELECT
               FROM     pg_type 
               WHERE    typname = 'phone'
               AND      typnamespace = 'common'::regnamespace)
    THEN
        CREATE DOMAIN common.phone varchar(25) NULL;
END IF;
END;
$$;
