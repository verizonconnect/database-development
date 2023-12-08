﻿SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[human_resources].[employee_department_history]') 
                      AND i.name = N'idx__human_resources__employee_department_history_2_shift_id')
CREATE NONCLUSTERED INDEX [idx__human_resources__employee_department_history_2_shift_id]
ON [human_resources].[employee_department_history] (
 [shift_id] ASC
);
