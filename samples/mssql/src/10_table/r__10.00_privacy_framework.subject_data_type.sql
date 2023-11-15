-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('[privacy_framework].[subject_data_type]') IS NULL
    CREATE TABLE [privacy_framework].[subject_data_type] (
        subject_data_type_id                SMALLINT      NOT NULL
       ,subject_data_type_desc              VARCHAR(100)  NOT NULL
       ,subject_data_type_translation_key   VARCHAR(100)  NOT NULL
       ,created_utc_when                    DATETIME2(3)  NOT NULL
    ) ON [FRAMEWORK_UNPART]
    WITH (DATA_COMPRESSION = PAGE);
GO