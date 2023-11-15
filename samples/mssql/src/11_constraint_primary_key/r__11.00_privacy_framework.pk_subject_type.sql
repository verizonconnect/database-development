-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('[privacy_framework].[pk_subject_type]') IS NULL
    BEGIN 
        ALTER TABLE [privacy_framework].[subject_type] 
        ADD CONSTRAINT [pk_subject_type] 
        PRIMARY KEY CLUSTERED  (subject_type_id) 
        WITH (DATA_COMPRESSION = PAGE) 
        ON [FRAMEWORK_UNPART];
    END;
GO
