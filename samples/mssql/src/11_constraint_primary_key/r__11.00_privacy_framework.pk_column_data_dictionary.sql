-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.pk_column_data_dictionary') IS NULL
    BEGIN
        ALTER TABLE privacy_framework.column_data_dictionary 
        ADD CONSTRAINT pk_column_data_dictionary 
        PRIMARY KEY CLUSTERED  (sch_nm
                               ,tbl_nm
                               ,col_nm) 
        WITH (FILLFACTOR = 90
             ,DATA_COMPRESSION = PAGE) 
        ON FRAMEWORK_UNPART;
    END;
GO
--
