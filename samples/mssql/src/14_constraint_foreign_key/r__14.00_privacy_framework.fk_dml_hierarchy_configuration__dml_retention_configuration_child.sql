--Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.fk_dml_hierarchy_configuration__dml_retention_configuration_child', 'F') IS NULL
    ALTER TABLE privacy_framework.dml_hierarchy_configuration
    ADD CONSTRAINT fk_dml_hierarchy_configuration__dml_retention_configuration_child
    FOREIGN KEY (child_sch_nm, child_tbl_nm)
    REFERENCES privacy_framework.dml_retention_configuration (sch_nm, tbl_nm)
    ON DELETE NO ACTION;
GO
