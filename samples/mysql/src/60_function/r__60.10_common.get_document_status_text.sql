CREATE FUNCTION common.get_document_status_text (v_status SMALLINT)
RETURNS VARCHAR(16)
DETERMINISTIC
NO SQL
BEGIN
    DECLARE v_ret VARCHAR(16);
    SET v_ret = CASE v_status
        WHEN 1 THEN 'Pending approval'
        WHEN 2 THEN 'Approved'
        WHEN 3 THEN 'Obsolete'
        ELSE '** Invalid **'
    END;
    RETURN v_ret;
END;
