CREATE OR REPLACE FUNCTION common.get_sales_order_status_text (
    IN v_status SMALLINT
   )
RETURNS VARCHAR(15) AS
$$
DECLARE
    v_ret VARCHAR(15);
BEGIN
    v_ret := CASE v_status
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
$$ LANGUAGE plpgsql
    IMMUTABLE;

COMMENT ON FUNCTION common.get_sales_order_status_text(SMALLINT) IS 'Scalar function returning the text representation of the status column in the sales_order_header table.';
