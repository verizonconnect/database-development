DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'person'
                           AND ccu.table_name = 'person'
                           AND ccu.column_name = 'person_type'
                           AND ccu.constraint_name = 'ck_person_person_type')
    THEN
        ALTER TABLE person.person
        ADD CONSTRAINT ck_person_person_type
        CHECK (person_type IS NULL OR UPPER(person_type) IN ('SC','VC','IN','EM','SP','GC'));
    END IF;
END$$
