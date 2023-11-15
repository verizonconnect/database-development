-- Copyright (c) 2022-2023. Verizon Connect Ireland Limited. All rights reserved. 
DECLARE @source TABLE(
    subject_type_id   SMALLINT      NOT NULL
   ,subject_type_desc VARCHAR(100)  NOT NULL
);

INSERT INTO @source (
    [subject_type_id]
   ,[subject_type_desc])
VALUES (1, 'Customer''s Customer')
      ,(2, 'User (includes Driver/Technician/Admin/User)')
      ,(3, 'Customer Additional Contact')
      ,(4, 'Account')
      ,(5, 'Installer')
      ,(6, 'Vendor')
      ,(7, 'B2B Point of Contact')
      ,(8, 'Verizon Customer')
      ,(9, 'Verizon Employee');

MERGE INTO [privacy_framework].[subject_type] AS tgt
USING @source AS s ON s.[subject_type_id] = tgt.[subject_type_id]
WHEN MATCHED THEN UPDATE SET tgt.[subject_type_desc] = s.[subject_type_desc]
WHEN NOT MATCHED THEN INSERT ([subject_type_id]
                             ,[subject_type_desc])
                      VALUES (s.[subject_type_id]
                             ,s.[subject_type_desc])
WHEN NOT MATCHED BY SOURCE THEN DELETE;

GO