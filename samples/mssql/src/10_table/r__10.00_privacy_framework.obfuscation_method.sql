-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.obfuscation_method') IS NULL
    CREATE TABLE privacy_framework.obfuscation_method (
        obfuscation_method_id    INT                                                NOT NULL
       ,obfuscation_method_value NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
    ) ON FRAMEWORK_UNPART TEXTIMAGE_ON FRAMEWORK_UNPART
    WITH (DATA_COMPRESSION = PAGE);
GO

IF COLUMNPROPERTY(OBJECT_ID('privacy_framework.obfuscation_method'), 'obfuscation_method_value', 'ColumnId') IS NOT NULL
    EXEC sp_rename 'privacy_framework.obfuscation_method.obfuscation_method_value', 'obfuscation_method_desc', 'COLUMN';
    
GO