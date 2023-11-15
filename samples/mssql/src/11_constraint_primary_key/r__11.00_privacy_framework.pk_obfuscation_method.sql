/* Copyright  2020. Verizon Connect Ireland Limited. All rights reserved. */
IF OBJECT_ID('[privacy_framework].[pk_obfuscation_method]') IS NULL
    BEGIN 
        ALTER TABLE [privacy_framework].[obfuscation_method] 
        ADD CONSTRAINT [pk_obfuscation_method] 
        PRIMARY KEY CLUSTERED  ([obfuscation_method_id]) 
        WITH (FILLFACTOR = 90
             ,DATA_COMPRESSION = PAGE) 
        ON [FRAMEWORK_UNPART];
    END;
GO
--

