-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.pk_partition_drp_configuration', 'PK') IS NULL
    BEGIN
        ALTER TABLE privacy_framework.partition_drp_configuration 
        ADD CONSTRAINT pk_partition_drp_configuration 
        PRIMARY KEY CLUSTERED  (partition_object_name) 
        WITH (FILLFACTOR = 90
             ,DATA_COMPRESSION = PAGE) 
        ON [FRAMEWORK_UNPART];
    END;
GO
