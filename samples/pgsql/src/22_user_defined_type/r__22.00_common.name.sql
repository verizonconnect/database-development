DO $$
BEGIN
IF NOT EXISTS (SELECT
               FROM     pg_type 
               WHERE    typname = 'name'
               AND      typnamespace = 'common'::regnamespace)
    THEN
        CREATE DOMAIN common.name VARCHAR(50) NULL;
END IF;
END;
$$;
