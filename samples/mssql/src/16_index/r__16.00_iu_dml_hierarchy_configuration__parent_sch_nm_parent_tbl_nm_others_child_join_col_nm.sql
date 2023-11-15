-- Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved.
IF NOT EXISTS(SELECT    * 
              FROM      sys.indexes 
              WHERE     name = 'iu_dml_hierarchy_configuration__parent_sch_nm_parent_tbl_nm_others_child_join_col_nm' 
                        AND object_id = OBJECT_ID('privacy_framework.dml_hierarchy_configuration', 'U'))
    BEGIN
        CREATE UNIQUE NONCLUSTERED INDEX [iu_dml_hierarchy_configuration__parent_sch_nm_parent_tbl_nm_others_child_join_col_nm]
        ON [privacy_framework].[dml_hierarchy_configuration](
            [parent_sch_nm] ASC
           ,[parent_tbl_nm] ASC
           ,[parent_join_col_nm] ASC
           ,[child_sch_nm] ASC
           ,[child_tbl_nm] ASC
           ,[child_join_col_nm] ASC
        ) WITH (FILLFACTOR = 90)
		ON [FRAMEWORK_UNPART];
    END;
GO

