-- Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.pk_dml_processing_order', 'PK') IS NULL
    BEGIN
        ALTER TABLE privacy_framework.dml_processing_order 
        ADD CONSTRAINT pk_dml_processing_order 
        PRIMARY KEY CLUSTERED  (sch_nm
                               ,tbl_nm) 
        WITH (FILLFACTOR = 90
             ,DATA_COMPRESSION = PAGE) 
        ON FRAMEWORK_UNPART;
    END;
GO

