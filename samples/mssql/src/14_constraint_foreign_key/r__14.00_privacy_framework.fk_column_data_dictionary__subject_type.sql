--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.fk_column_data_dictionary__subject_type', 'F') IS NULL
    ALTER TABLE privacy_framework.column_data_dictionary
    ADD CONSTRAINT fk_column_data_dictionary__subject_type 
    FOREIGN KEY (subject_type_id)
    REFERENCES privacy_framework.subject_type (subject_type_id);
GO
--
