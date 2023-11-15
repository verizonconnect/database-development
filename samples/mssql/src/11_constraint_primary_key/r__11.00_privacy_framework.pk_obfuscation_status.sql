-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('[privacy_framework].[pk_obfuscation_status]') IS NULL
    BEGIN 
        ALTER TABLE [privacy_framework].[obfuscation_status] 
        ADD CONSTRAINT [pk_obfuscation_status] 
        PRIMARY KEY CLUSTERED  (status_id) 
        WITH (DATA_COMPRESSION = PAGE) 
        ON [FRAMEWORK_UNPART];
    END;
GO


