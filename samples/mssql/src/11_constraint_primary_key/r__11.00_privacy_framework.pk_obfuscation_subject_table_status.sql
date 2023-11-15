-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('[privacy_framework].[pk_obfuscation_subject_table_status]') IS NULL
    BEGIN 
        ALTER TABLE [privacy_framework].[obfuscation_subject_table_status] 
        ADD CONSTRAINT [pk_obfuscation_subject_table_status] 
        PRIMARY KEY CLUSTERED  (account_id, subject_type_id, subject_id, sch_nm, tbl_nm) 
        WITH (DATA_COMPRESSION = PAGE) 
        ON [FRAMEWORK_UNPART];
    END;
GO


