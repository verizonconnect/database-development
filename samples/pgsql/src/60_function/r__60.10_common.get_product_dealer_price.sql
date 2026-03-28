CREATE OR REPLACE FUNCTION common.get_product_dealer_price (
    IN v_product_id INT
   ,IN v_order_date TIMESTAMP
   )
RETURNS NUMERIC AS
$$
DECLARE
    v_dealer_price    NUMERIC;
    v_dealer_discount NUMERIC := 0.60;
BEGIN
    SELECT  plph.list_price * v_dealer_discount INTO v_dealer_price
    FROM    production.product AS p
    JOIN    production.product_list_price_history AS plph
        ON  p.product_id = plph.product_id
        AND p.product_id = v_product_id
        AND v_order_date BETWEEN plph.start_date
            AND COALESCE(plph.end_date, '9999-12-31'::TIMESTAMP);

    RETURN v_dealer_price;
END;
$$ LANGUAGE plpgsql
    STABLE;

COMMENT ON FUNCTION common.get_product_dealer_price(INT, TIMESTAMP) IS 'Scalar function returning the dealer price for a given product on a particular order date.';
