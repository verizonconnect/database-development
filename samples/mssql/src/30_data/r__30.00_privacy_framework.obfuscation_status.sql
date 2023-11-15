-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
DECLARE @source TABLE(
        status_id        SMALLINT NOT NULL,
        status_desc      VARCHAR(20)  NOT NULL
);

INSERT INTO @source (
    [status_id]
   ,[status_desc]) 
VALUES (1, 'In Progress')
      ,(2, 'Complete')
      ,(3, 'Error');

MERGE INTO [privacy_framework].[obfuscation_status] AS tgt
USING @source AS s ON s.[status_id] = tgt.[status_id]
WHEN MATCHED THEN UPDATE SET tgt.[status_desc] = s.[status_desc]
WHEN NOT MATCHED THEN INSERT ([status_id]
                             ,[status_desc])
                      VALUES (s.[status_id]
                             ,s.[status_desc])
WHEN NOT MATCHED BY SOURCE THEN DELETE;