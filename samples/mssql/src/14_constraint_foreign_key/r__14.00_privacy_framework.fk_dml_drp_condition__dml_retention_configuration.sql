--Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.fk_dml_drp_condition__dml_retention_configuration', 'F') IS NULL
    ALTER TABLE privacy_framework.dml_drp_condition
    ADD CONSTRAINT fk_dml_drp_condition__dml_retention_configuration
    FOREIGN KEY (sch_nm, tbl_nm)
    REFERENCES privacy_framework.dml_retention_configuration (sch_nm, tbl_nm)
    ON DELETE CASCADE;
GO
