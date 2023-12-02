CREATE OR ALTER PROCEDURE [test_static_data].[test_person__address_type__data]
AS
BEGIN

    SELECT  TOP (0)
            [address_type_id] 
           ,[name]
           ,[rowguid] 
    INTO    #expected
    FROM    [person].[address_type];

    ALTER TABLE #expected ADD PRIMARY KEY (address_type_id);

    SET IDENTITY_INSERT #expected ON;
    INSERT INTO #expected (
        [address_type_id] 
       ,[name]
       ,[rowguid]
    ) 
    VALUES  (1,'Billing','{B84F78B1-4EFE-4A0E-8CB7-70E9F112F886}')
           ,(2,'Home','{41BC2FF6-F0FC-475F-8EB9-CEC0805AA0F2}')
           ,(3,'Main Office','{8EEEC28C-07A2-4FB9-AD0A-42D4A0BBC575}')
           ,(4,'Primary','{24CB3088-4345-47C4-86C5-17B535133D1E}')
           ,(5,'Shipping','{B29DA3F8-19A3-47DA-9DAA-15C84F4A83A5}')
           ,(6,'Archive','{A67F238A-5BA2-444B-966C-0467ED9C427F}');
    SET IDENTITY_INSERT #expected OFF;

    SELECT  tc.[address_type_id] 
           ,tc.[name]
           ,tc.[rowguid]
    INTO    #actual
    FROM    [person].[address_type] AS tc;

    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'person.address_type data not as expected';
END;
GO
