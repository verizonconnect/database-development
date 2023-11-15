--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.df_dml_drp_condition__created_utc_when', 'D') IS NULL
BEGIN
    ALTER TABLE privacy_framework.dml_drp_condition 
    ADD CONSTRAINT df_dml_drp_condition__created_utc_when 
    DEFAULT (SYSUTCDATETIME()) FOR created_utc_when;
END;
GO
