--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.ck_partition_drp_configuration__cycle_period_type', 'C') IS NULL
BEGIN
    ALTER TABLE privacy_framework.partition_drp_configuration 
    ADD CONSTRAINT ck_partition_drp_configuration__cycle_period_type 
    CHECK (cycle_period_type  IN ('HH'
                                 ,'DD'
                                 ,'WW'
                                 ,'MM'));
END;
GO
