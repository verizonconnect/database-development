-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.obfuscation_log') IS NULL
    CREATE TABLE privacy_framework.obfuscation_log (
        log_id               INT                                                NOT NULL IDENTITY(1, 1)
       ,created_utc_when     DATETIME2(3)                                       NOT NULL
       ,message              VARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL
    ) ON FRAMEWORK_UNPART TEXTIMAGE_ON FRAMEWORK_UNPART
    WITH (DATA_COMPRESSION = PAGE);
GO


