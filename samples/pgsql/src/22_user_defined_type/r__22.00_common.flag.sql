DO $$
BEGIN
IF NOT EXISTS (SELECT
               FROM     pg_type 
               WHERE    typname = 'flag'
               AND      typnamespace = 'common'::regnamespace)
    THEN
        CREATE DOMAIN common.flag BOOLEAN NOT NULL;
END IF;
END;
$$;
