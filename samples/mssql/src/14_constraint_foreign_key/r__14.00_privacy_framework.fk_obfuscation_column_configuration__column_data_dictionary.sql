--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.fk_obfuscation_column_configuration__column_data_dictionary', 'F') IS NULL
    ALTER TABLE privacy_framework.obfuscation_column_configuration
    ADD CONSTRAINT fk_obfuscation_column_configuration__column_data_dictionary
    FOREIGN KEY (sch_nm, tbl_nm, col_nm)
    REFERENCES privacy_framework.column_data_dictionary (sch_nm, tbl_nm, col_nm);
GO
