
IF OBJECT_ID('[person].[fk_state_province_sales_territory_territory_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [person].[state_province]  
    ADD CONSTRAINT [fk_state_province_sales_territory_territory_id] 
    FOREIGN KEY (territory_id)
    REFERENCES [sales].[sales_territory] (territory_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [person].[state_province] 
CHECK CONSTRAINT [fk_state_province_sales_territory_territory_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'state_province'
                                              , N'CONSTRAINT',N'fk_state_province_sales_territory_territory_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing sales_territory.territory_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'state_province'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_state_province_sales_territory_territory_id'
GO
