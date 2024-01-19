DO $$
BEGIN
IF NOT EXISTS (SELECT
               FROM     pg_type 
               WHERE    typname = 'name_style'
               AND      typnamespace = 'common'::regnamespace)
    THEN
        CREATE DOMAIN common.name_style BOOLEAN NOT NULL;
END IF;
END;
$$;
