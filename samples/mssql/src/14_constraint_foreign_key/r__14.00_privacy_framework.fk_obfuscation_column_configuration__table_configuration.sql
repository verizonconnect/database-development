--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.fk_obfuscation_column_configuration__table_configuration', 'F') IS NULL
    ALTER TABLE privacy_framework.obfuscation_column_configuration
    ADD CONSTRAINT fk_obfuscation_column_configuration__table_configuration
    FOREIGN KEY (sch_nm, tbl_nm)
    REFERENCES privacy_framework.table_configuration (sch_nm, tbl_nm)
    ON DELETE CASCADE;
GO
