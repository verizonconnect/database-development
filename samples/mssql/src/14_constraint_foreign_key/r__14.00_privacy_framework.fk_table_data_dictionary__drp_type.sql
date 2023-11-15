--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.fk_table_data_dictionary__drp_type', 'F') IS NULL
    ALTER TABLE privacy_framework.table_data_dictionary
    ADD CONSTRAINT fk_table_data_dictionary__drp_type 
    FOREIGN KEY (drp_type_desc)
    REFERENCES privacy_framework.drp_type (drp_type_desc);
GO
--
