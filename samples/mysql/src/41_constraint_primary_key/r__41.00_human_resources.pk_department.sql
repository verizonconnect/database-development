DELIMITER $$

DROP PROCEDURE IF EXISTS ${flyway:database}.safe_alter_table_pk $$
CREATE PROCEDURE thingmgmt.safe_alter_table_pk ( _table_schema TEXT, _table_name TEXT, _column TEXT, _column_definition TEXT )
BEGIN
    IF NOT EXISTS (
            SELECT  1 
            FROM    information_schema.table_constraints 
            WHERE   table_schema = _table_schema 
                    AND table_name = _table_name 
                    AND constraint_type = 'PRIMARY KEY') THEN 
        SET @query = CONCAT('ALTER TABLE `', _table_schema, '`.`', _table_name, '` MODIFY COLUMN `', _column, '` ', _column_definition, ';');
        PREPARE stmt1 FROM @query;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;
    END IF;
END $$

DELIMITER ;

CALL ${flyway:database}.safe_alter_table_pk ('${flyway:database}', 'department' ,'department_id', 'INT NOT NULL AUTO_INCREMENT PRIMARY KEY');

/*ALTER TABLE ${flyway:database}.department MODIFY COLUMN department_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;*/