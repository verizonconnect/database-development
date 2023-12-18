
IF OBJECT_ID('[person].[fk_address_state_province_state_province_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [person].[address]  
    ADD CONSTRAINT [fk_address_state_province_state_province_id] 
    FOREIGN KEY (state_province_id)
    REFERENCES [person].[state_province] (state_province_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [person].[address] 
CHECK CONSTRAINT [fk_address_state_province_state_province_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'address'
                                              , N'CONSTRAINT',N'fk_address_state_province_state_province_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing state_province.state_province_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'address'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_address_state_province_state_province_id'
GO
