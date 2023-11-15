/* Copyright 2022. Verizon Connect Ireland Limited. All rights reserved. */
CREATE OR ALTER PROCEDURE [privacy_framework].[add_obfuscation_log]
(	@message VARCHAR(MAX) = NULL,
	@debug_ind BIT = 0
)
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @Error_Message NVARCHAR(4000);
    DECLARE @Error_Number INT;
   	DECLARE @THROW_ERROR_MESSAGE NVARCHAR(2048);

    IF (@debug_ind = 0)
        BEGIN
        BEGIN TRY
            INSERT INTO privacy_framework.obfuscation_log (created_utc_when, message)
            values (SYSUTCDATETIME(), @message);
        END TRY
        BEGIN CATCH
            SELECT @Error_Number = ERROR_NUMBER();
            SELECT @Error_Message = ERROR_MESSAGE();
            SELECT @THROW_ERROR_MESSAGE = 'Error adding to the obfuscation log: ' + ' ERROR ' + ISNULL(CONVERT(VARCHAR(20), @Error_Number), '') + ': ' + ISNULL(@Error_Message, '');
            THROW 50000, @THROW_ERROR_MESSAGE, 1;
        END CATCH;
        END;  	
    ELSE
        BEGIN
        SELECT @message AS Message;
        END;
END;
GO
