--Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('privacy_framework.fk_obfuscation_column_configuration__obfuscation_method', 'F') IS NULL
    ALTER TABLE privacy_framework.obfuscation_column_configuration
    ADD CONSTRAINT fk_obfuscation_column_configuration__obfuscation_method 
    FOREIGN KEY (obfuscation_method_id)
    REFERENCES privacy_framework.obfuscation_method (obfuscation_method_id);
GO
--