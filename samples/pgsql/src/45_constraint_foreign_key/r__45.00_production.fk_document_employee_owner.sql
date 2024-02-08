DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'document'
                           AND tc.constraint_name = 'fk_document_employee_owner'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.document
        ADD CONSTRAINT "fk_document_employee_owner"
        FOREIGN KEY (owner)
        REFERENCES human_resources.employee(business_entity_id);
    END IF;
END$$
