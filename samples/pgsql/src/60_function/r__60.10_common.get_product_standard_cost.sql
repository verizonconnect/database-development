CREATE OR REPLACE FUNCTION common.get_product_standard_cost (
    IN v_product_id INT
   ,IN v_order_date TIMESTAMP
   )
RETURNS NUMERIC AS
$$
DECLARE
    v_standard_cost NUMERIC;
BEGIN
    SELECT  pch.standard_cost INTO v_standard_cost
    FROM    production.product AS p
    JOIN    production.product_cost_history AS pch
        ON  p.product_id = pch.product_id
        AND p.product_id = v_product_id
        AND v_order_date BETWEEN pch.start_date
            AND COALESCE(pch.end_date, '9999-12-31'::TIMESTAMP);

    RETURN v_standard_cost;
END;
$$ LANGUAGE plpgsql
    STABLE;

COMMENT ON FUNCTION common.get_product_standard_cost(INT, TIMESTAMP) IS 'Scalar function returning the standard cost for a given product on a particular order date.';
