--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.df_obfuscation_subject_table_status__created_utc_when', 'D') IS NULL
    ALTER TABLE privacy_framework.obfuscation_subject_table_status 
    ADD CONSTRAINT df_obfuscation_subject_table_status__created_utc_when 
    DEFAULT (SYSUTCDATETIME()) FOR created_utc_when;
GO
