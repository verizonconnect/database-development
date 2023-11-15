--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.df_table_data_dictionary__created_utc_when', 'D') IS NULL
    ALTER TABLE privacy_framework.table_data_dictionary 
    ADD CONSTRAINT df_table_data_dictionary__created_utc_when 
    DEFAULT (SYSUTCDATETIME()) FOR created_utc_when;
GO
--
