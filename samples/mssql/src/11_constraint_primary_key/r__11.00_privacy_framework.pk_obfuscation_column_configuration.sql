-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.pk_obfuscation_column_configuration') IS NULL
    BEGIN
        ALTER TABLE privacy_framework.obfuscation_column_configuration 
        ADD CONSTRAINT pk_obfuscation_column_configuration 
        PRIMARY KEY CLUSTERED  (sch_nm
                               ,tbl_nm
                               ,col_nm) 
        WITH (FILLFACTOR = 90
             ,DATA_COMPRESSION = PAGE) 
        ON FRAMEWORK_UNPART;
    END;
GO
