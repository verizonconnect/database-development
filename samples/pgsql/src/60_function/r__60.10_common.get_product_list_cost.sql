CREATE OR REPLACE FUNCTION common.get_product_list_cost (
    IN v_product_id INT
   ,IN v_order_date TIMESTAMP
   )
RETURNS NUMERIC AS
$$
DECLARE
    v_list_price NUMERIC;
BEGIN
    SELECT  plph.list_price INTO v_list_price
    FROM    production.product AS p
    JOIN    production.product_list_price_history AS plph
        ON  p.product_id = plph.product_id
        AND p.product_id = v_product_id
        AND v_order_date BETWEEN plph.start_date
            AND COALESCE(plph.end_date, '9999-12-31'::TIMESTAMP);

    RETURN v_list_price;
END;
$$ LANGUAGE plpgsql
    STABLE;

COMMENT ON FUNCTION common.get_product_list_cost(INT, TIMESTAMP) IS 'Scalar function returning the list price for a given product on a particular order date.';
