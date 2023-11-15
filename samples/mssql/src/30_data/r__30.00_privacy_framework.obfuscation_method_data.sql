-- Copyright (c) 2020-2022. Verizon Connect Ireland Limited. All rights reserved. 
DECLARE @source TABLE(
    [obfuscation_method_id]       [INT]                                                 NOT NULL
   ,[obfuscation_method_desc]    [NVARCHAR] (MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
);

INSERT INTO @source (
    [obfuscation_method_id]
   ,[obfuscation_method_desc]) 
VALUES (13, N'SELECT RIGHT(''0000000000''+CONVERT(VARCHAR(10), ABS(CHECKSUM(NEWID()))), 10) + ''-'' + REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(30), SYSUTCDATETIME(), 121),''-'', ''''), '':'', ''''), ''.'',''''), '' '', '''')')
      ,(1, N'SELECT ''Obfuscated''')
      ,(2, N'SELECT ''REMOVED''')
      ,(3, N'SELECT ''REMOVED'' + REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(30), SYSUTCDATETIME(), 121),''-'', ''''), '':'', ''''), ''.'',''''), '' '', '''')')
      ,(4, N'SELECT REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(30), SYSUTCDATETIME(), 121),''-'', ''''), '':'', ''''), ''.'',''''), '' '', '''')')
      ,(5, N'SELECT newID()')
      ,(6, N'SELECT LEFT(REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(30), SYSUTCDATETIME(), 121),''-'', ''''), '':'', ''''), ''.'',''''), '' '', ''''),16)')
      ,(7, N'DELETE')
      ,(8, N'SELECT CAST(((CAST(DATEDIFF(DAY, ''2000-01-01'', CONVERT(DATE, GETDATE())) AS BIGINT) * 24 * 60 * 60 * 1000) + DATEDIFF(MILLISECOND,CONVERT(DATE, GETDATE()), CURRENT_TIMESTAMP)) % 2147483647 AS INT)')
      ,(9, N'SELECT left(newID(),20)')
      ,(10, N'SELECT convert(nvarchar(36), newID())')
      ,(11, N'SELECT left(convert(nvarchar(36), newID()),20)')
      ,(12, N'SELECT NULL');

MERGE INTO [privacy_framework].[obfuscation_method] AS tgt
USING @source AS s ON s.[obfuscation_method_id] = tgt.[obfuscation_method_id]
WHEN MATCHED THEN UPDATE SET tgt.[obfuscation_method_desc] = s.[obfuscation_method_desc]
WHEN NOT MATCHED THEN INSERT ([obfuscation_method_id]
                             ,[obfuscation_method_desc])
                      VALUES (s.[obfuscation_method_id]
                             ,s.[obfuscation_method_desc])
WHEN NOT MATCHED BY SOURCE THEN DELETE;