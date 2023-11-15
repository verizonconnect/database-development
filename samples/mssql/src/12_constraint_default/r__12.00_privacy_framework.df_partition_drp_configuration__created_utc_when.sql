--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.df_partition_drp_configuration__created_utc_when', 'D') IS NULL
BEGIN
    ALTER TABLE privacy_framework.partition_drp_configuration 
    ADD CONSTRAINT df_partition_drp_configuration__created_utc_when 
    DEFAULT (SYSUTCDATETIME()) FOR created_utc_when;
END;
GO
