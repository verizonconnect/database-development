--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.df_drp_type__created_utc_when', 'D') IS NULL
    ALTER TABLE privacy_framework.drp_type 
    ADD CONSTRAINT df_drp_type__created_utc_when 
    DEFAULT (SYSUTCDATETIME()) FOR created_utc_when;
GO
