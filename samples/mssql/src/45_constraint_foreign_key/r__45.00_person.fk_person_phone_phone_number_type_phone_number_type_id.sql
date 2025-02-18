﻿
IF OBJECT_ID('[person].[fk_person_phone_phone_number_type_phone_number_type_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [person].[person_phone]  
    ADD CONSTRAINT [fk_person_phone_phone_number_type_phone_number_type_id] 
    FOREIGN KEY (phone_number_type_id)
    REFERENCES [person].[phone_number_type] (phone_number_type_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [person].[person_phone] 
CHECK CONSTRAINT [fk_person_phone_phone_number_type_phone_number_type_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'person_phone'
                                              , N'CONSTRAINT',N'fk_person_phone_phone_number_type_phone_number_type_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing phone_number_type.phone_number_type_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'person_phone'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_person_phone_phone_number_type_phone_number_type_id'
GO
