DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'person'
                           AND ccu.table_name = 'person'
                           AND ccu.column_name = 'email_promotion'
                           AND ccu.constraint_name = 'ck_person_email_promotion')
    THEN
        ALTER TABLE person.person
        ADD CONSTRAINT ck_person_email_promotion
        CHECK (email_promotion BETWEEN 0 AND 2);
    END IF;
END$$
