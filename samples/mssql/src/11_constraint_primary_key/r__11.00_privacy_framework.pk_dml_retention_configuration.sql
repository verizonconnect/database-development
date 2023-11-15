-- Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.pk_dml_retention_configuration', 'PK') IS NULL
    BEGIN
        ALTER TABLE privacy_framework.dml_retention_configuration 
        ADD CONSTRAINT pk_dml_retention_configuration 
        PRIMARY KEY CLUSTERED  (sch_nm
                               ,tbl_nm) 
        WITH (FILLFACTOR = 90
             ,DATA_COMPRESSION = PAGE) 
        ON FRAMEWORK_UNPART;
    END;
GO
