--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.fk_table_data_dictionary__business_justification', 'F') IS NULL
    ALTER TABLE privacy_framework.table_data_dictionary
    ADD CONSTRAINT fk_table_data_dictionary__business_justification 
    FOREIGN KEY (business_justification_id)
    REFERENCES privacy_framework.business_justification (business_justification_id);
GO
--
