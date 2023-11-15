--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.df_partition_drp_configuration__drop_staging_table_indicator', 'D') IS NULL
BEGIN
    ALTER TABLE privacy_framework.partition_drp_configuration 
    ADD CONSTRAINT df_partition_drp_configuration__drop_staging_table_indicator 
    DEFAULT (1) FOR drop_staging_table_indicator;
END;
GO
