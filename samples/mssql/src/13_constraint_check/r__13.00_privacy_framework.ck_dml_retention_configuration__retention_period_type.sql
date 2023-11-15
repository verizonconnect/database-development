--Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.ck_dml_retention_configuration__retention_period_type', 'C') IS NULL
BEGIN
    ALTER TABLE privacy_framework.dml_retention_configuration 
    ADD CONSTRAINT ck_dml_retention_configuration__retention_period_type 
    CHECK (retention_period_type  IN ('HH'
                                     ,'DD'
                                     ,'WW'
                                     ,'MM'));
END;
GO
