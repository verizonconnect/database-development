--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.fk_obfuscation_subject_status__status_id', 'F') IS NULL
    ALTER TABLE privacy_framework.obfuscation_subject_status
    ADD CONSTRAINT fk_obfuscation_subject_status__status_id 
    FOREIGN KEY (status_id)
    REFERENCES privacy_framework.obfuscation_status (status_id);
GO
