﻿
IF OBJECT_ID('[sales].[pk_sales_territory_history_business_entity_id_start_date_territory_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_territory_history]
        ADD CONSTRAINT [pk_sales_territory_history_business_entity_id_start_date_territory_id]
        PRIMARY KEY CLUSTERED (business_entity_id ASC, start_date ASC, territory_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_territory_history'
                                              , N'CONSTRAINT',N'pk_sales_territory_history_business_entity_id_start_date_territory_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_territory_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_sales_territory_history_business_entity_id_start_date_territory_id'
GO
