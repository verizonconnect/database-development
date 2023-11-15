-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('[privacy_framework].[obfuscation_status]') IS NULL
    CREATE TABLE [privacy_framework].[obfuscation_status] (
        status_id        SMALLINT NOT NULL,
        status_desc      VARCHAR(20)  NOT NULL
    ) ON [FRAMEWORK_UNPART]
    WITH (DATA_COMPRESSION = PAGE);
GO