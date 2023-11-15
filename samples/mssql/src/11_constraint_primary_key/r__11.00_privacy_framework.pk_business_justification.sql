-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.pk_business_justification') IS NULL
    BEGIN
        ALTER TABLE privacy_framework.business_justification 
        ADD CONSTRAINT pk_business_justification 
        PRIMARY KEY CLUSTERED  (business_justification_id) 
        WITH (DATA_COMPRESSION = PAGE) 
        ON FRAMEWORK_UNPART;
    END;
GO
