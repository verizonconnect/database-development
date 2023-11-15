-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('[privacy_framework].[business_justification]') IS NULL
    CREATE TABLE [privacy_framework].[business_justification] (
        business_justification_id   TINYINT      NOT NULL 
       ,business_justification_desc VARCHAR(50)  NOT NULL
       ,created_utc_when            DATETIME2(3) NOT NULL
    ) ON [FRAMEWORK_UNPART]
    WITH (DATA_COMPRESSION = PAGE);
GO