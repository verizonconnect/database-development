/* Copyright 2022. Verizon Connect Ireland Limited. All rights reserved. */
CREATE OR ALTER PROCEDURE [privacy_framework].[set_obfuscation_subject_status]
(	@account_id INT,
    @subject_type_id INT,
    @subject_id INT,
	@status_id SMALLINT,
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
        IF EXISTS (SELECT 1 FROM privacy_framework.obfuscation_subject_status WHERE account_id = @account_id AND subject_type_id = @subject_type_id AND subject_id = @subject_id)
            --Update
            BEGIN
            BEGIN TRY
                UPDATE privacy_framework.obfuscation_subject_status
                SET status_id = @status_id,
                    modified_utc_when = SYSUTCDATETIME()
                WHERE account_id = @account_id
                AND   subject_type_id = @subject_type_id 
                AND   subject_id = @subject_id;
            END TRY
            BEGIN CATCH
            	SELECT @Error_Number = ERROR_NUMBER();
		        SELECT @Error_Message = ERROR_MESSAGE();
      			SELECT @THROW_ERROR_MESSAGE = 'Error updating Obfuscation Subject Status: ' + ' ERROR ' + ISNULL(CONVERT(VARCHAR(20), @Error_Number), '') + ': ' + ISNULL(@Error_Message, '');
    			THROW 50000, @THROW_ERROR_MESSAGE, 1;
            END CATCH;
            END;
        ELSE --Insert
            BEGIN
            BEGIN TRY
                INSERT INTO privacy_framework.obfuscation_subject_status (account_id, subject_type_id, subject_id, status_id, created_utc_when, modified_utc_when)
                VALUES (@account_id, @subject_type_id, @subject_id, @status_id, SYSUTCDATETIME(), null);
            END TRY
            BEGIN CATCH
            	SELECT @Error_Number = ERROR_NUMBER();
		        SELECT @Error_Message = ERROR_MESSAGE();
      			SELECT @THROW_ERROR_MESSAGE = 'Error inserting Obfuscation Subject Status: ' + ' ERROR ' + ISNULL(CONVERT(VARCHAR(20), @Error_Number), '') + ': ' + ISNULL(@Error_Message, '');
    			THROW 50000, @THROW_ERROR_MESSAGE, 1;
            END CATCH;
            END;
        END;  	
    ELSE
        BEGIN
        SELECT 'Set subject status - AccountID: ' + cast(@account_id as VARCHAR(10)) + '- SubjectTypeID: ' + cast(@subject_type_id as VARCHAR(10)) + '- SubjectID: ' + cast(@subject_id as VARCHAR(10)) + ' - Status: ' + cast(@status_id as VARCHAR(10)) AS Message;
        END;
END;
GO
