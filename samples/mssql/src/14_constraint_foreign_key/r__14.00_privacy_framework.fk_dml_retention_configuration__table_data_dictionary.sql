--Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.fk_dml_retention_configuration__table_data_dictionary', 'F') IS NULL
    ALTER TABLE privacy_framework.dml_retention_configuration
    ADD CONSTRAINT fk_dml_retention_configuration__table_data_dictionary
    FOREIGN KEY (sch_nm, tbl_nm)
    REFERENCES privacy_framework.table_data_dictionary (sch_nm, tbl_nm)
    ON DELETE CASCADE;
GO
