CREATE FUNCTION common.get_purchase_order_status_text (
    v_status SMALLINT
)
RETURNS VARCHAR(15)
DETERMINISTIC
NO SQL
BEGIN
    DECLARE v_ret VARCHAR(15);
    SET v_ret = CASE v_status
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Approved'
        WHEN 3 THEN 'Rejected'
        WHEN 4 THEN 'Complete'
        ELSE '** Invalid **'
    END;
    RETURN v_ret;
END;
