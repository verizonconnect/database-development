/* Copyright  2022. Verizon Connect Ireland Limited. All rights reserved. */
IF OBJECT_ID('[privacy_framework].[pk_obfuscation_log]') IS NULL
    BEGIN 
        ALTER TABLE [privacy_framework].[obfuscation_log] 
        ADD CONSTRAINT [pk_obfuscation_log] 
        PRIMARY KEY CLUSTERED  ([log_id]) 
        WITH (FILLFACTOR = 90
             ,DATA_COMPRESSION = PAGE) 
        ON [FRAMEWORK_UNPART];
    END;
GO
