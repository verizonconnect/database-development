-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('[privacy_framework].[pk_drp_type]') IS NULL
    BEGIN 
        ALTER TABLE [privacy_framework].[drp_type] 
        ADD CONSTRAINT [pk_drp_type] 
        PRIMARY KEY CLUSTERED  (drp_type_desc) 
        WITH (DATA_COMPRESSION = PAGE) 
        ON [FRAMEWORK_UNPART];
    END;
GO


