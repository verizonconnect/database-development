CREATE FUNCTION common.get_sales_order_status_text (
    v_status SMALLINT
)
RETURNS VARCHAR(15)
DETERMINISTIC
NO SQL
BEGIN
    DECLARE v_ret VARCHAR(15);
    SET v_ret = CASE v_status
        WHEN 1 THEN 'In process'
        WHEN 2 THEN 'Approved'
        WHEN 3 THEN 'Backordered'
        WHEN 4 THEN 'Rejected'
        WHEN 5 THEN 'Shipped'
        WHEN 6 THEN 'Cancelled'
        ELSE '** Invalid **'
    END;
    RETURN v_ret;
END;
