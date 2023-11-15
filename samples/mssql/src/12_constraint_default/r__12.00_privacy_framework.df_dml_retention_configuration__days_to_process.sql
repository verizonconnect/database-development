--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.df_dml_retention_configuration__days_to_process', 'D') IS NULL
BEGIN
    ALTER TABLE privacy_framework.dml_retention_configuration 
    ADD CONSTRAINT df_dml_retention_configuration__days_to_process 
    DEFAULT (9) FOR days_to_process;
END;
GO
