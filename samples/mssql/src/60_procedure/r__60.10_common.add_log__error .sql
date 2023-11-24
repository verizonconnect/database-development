SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- add_log__error logs error information in the error_log table about the 
-- error that caused execution to jump to the CATCH block of a 
-- TRY...CATCH construct. This should be executed from within the scope 
-- of a CATCH block otherwise it will return without inserting error 
-- information. 
CREATE OR ALTER PROCEDURE [common].[add_log__error] 
    @error_log_id [int] = 0 OUTPUT -- contains the error_log_id of the row inserted
AS                               -- by add_log__error in the error_log table
BEGIN
    SET NOCOUNT ON;

    -- Output parameter value of 0 indicates that error 
    -- information was not logged
    SET @error_log_id = 0;

    BEGIN TRY
        -- Return if there is no error information to log
        IF ERROR_NUMBER() IS NULL
            RETURN;

        -- Return if inside an uncommittable transaction.
        -- Data insertion/modification is not allowed when 
        -- a transaction is in an uncommittable state.
        IF XACT_STATE() = -1
        BEGIN
            PRINT 'Cannot log error since the current transaction is in an uncommittable state. ' 
                + 'Rollback the transaction before executing add_log__error in order to successfully log error information.';
            RETURN;
        END

        INSERT [common].[error_log] 
            (
            [user_name], 
            [error_number], 
            [error_severity], 
            [error_state], 
            [error_procedure], 
            [error_line], 
            [error_message]
            ) 
        VALUES 
            (
            CONVERT(sysname, CURRENT_USER), 
            ERROR_NUMBER(),
            ERROR_SEVERITY(),
            ERROR_STATE(),
            ERROR_PROCEDURE(),
            ERROR_LINE(),
            ERROR_MESSAGE()
            );

        -- Pass back the error_log_id of the row inserted
        SET @error_log_id = @@IDENTITY;
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred in stored procedure add_log__error: ';
        EXECUTE [common].[print_error];
        RETURN -1;
    END CATCH
END;
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'PROCEDURE',N'add_log__error', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Logs error information in the error_log table about the error that caused execution to jump to the CATCH block of a TRY...CATCH construct. Should be executed from within the scope of a CATCH block otherwise it will return without inserting error information.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'PROCEDURE',@level1name=N'add_log__error'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'PROCEDURE',N'add_log__error', N'PARAMETER',N'@error_log_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Output parameter for the stored procedure add_log__error. Contains the error_log_id value corresponding to the row inserted by add_log__error in the error_log table.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'PROCEDURE',@level1name=N'add_log__error', @level2type=N'PARAMETER',@level2name=N'@error_log_id'
GO
