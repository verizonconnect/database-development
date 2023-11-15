-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('[privacy_framework].[drp_type]') IS NULL
    CREATE TABLE [privacy_framework].[drp_type] (
        drp_type_desc    VARCHAR(20)  NOT NULL
       ,created_utc_when DATETIME2(3) NOT NULL
    ) ON [FRAMEWORK_UNPART]
    WITH (DATA_COMPRESSION = PAGE);
GO

IF COLUMNPROPERTY(OBJECT_ID('privacy_framework.drp_type', 'U'), 'requires_drp_indicator', 'ColumnId') IS NULL
    ALTER TABLE privacy_framework.drp_type
    ADD requires_drp_indicator BIT NULL;
GO
