CREATE OR REPLACE FUNCTION common.get_accounting_start_date ()
RETURNS TIMESTAMP AS
$$
BEGIN
    RETURN '2003-07-01'::TIMESTAMP;
END;
$$ LANGUAGE plpgsql
    IMMUTABLE;

COMMENT ON FUNCTION common.get_accounting_start_date() IS 'Scalar function used in the sales_order_header trigger to set the starting account date.';
