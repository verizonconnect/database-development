-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('[privacy_framework].[pk_obfuscation_account_table_status]') IS NULL
    BEGIN 
        ALTER TABLE [privacy_framework].[obfuscation_account_table_status] 
        ADD CONSTRAINT [pk_obfuscation_account_table_status] 
        PRIMARY KEY CLUSTERED  ([account_id], [sch_nm], [tbl_nm]) 
        WITH (FILLFACTOR = 90
             ,DATA_COMPRESSION = PAGE) 
        ON [FRAMEWORK_UNPART];
    END;
GO


