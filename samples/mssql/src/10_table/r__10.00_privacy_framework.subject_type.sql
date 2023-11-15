-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('[privacy_framework].[subject_type]') IS NULL
    CREATE TABLE [privacy_framework].[subject_type] (
        subject_type_id                SMALLINT      NOT NULL
       ,subject_type_desc              VARCHAR(100)  NOT NULL
       ,created_utc_when               DATETIME2(3)  NOT NULL
    ) ON [FRAMEWORK_UNPART]
    WITH (DATA_COMPRESSION = PAGE);
GO