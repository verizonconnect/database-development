CREATE OR REPLACE FUNCTION common.get_accounting_end_date ()
RETURNS TIMESTAMP AS
$$
BEGIN
    RETURN '2004-06-30 23:59:59.998'::TIMESTAMP;
END;
$$ LANGUAGE plpgsql
    IMMUTABLE;

COMMENT ON FUNCTION common.get_accounting_end_date() IS 'Scalar function used in the sales_order_header trigger to set the ending account date.';
