CREATE OR REPLACE FUNCTION common.get_stock (
    IN v_product_id INT
   )
RETURNS INT AS
$$
DECLARE
    v_ret INT;
BEGIN
    SELECT  SUM(p.quantity) INTO v_ret
    FROM    production.product_inventory AS p
    WHERE   p.product_id = v_product_id
        AND p.location_id = 6;

    IF v_ret IS NULL THEN
        v_ret := 0;
    END IF;

    RETURN v_ret;
END;
$$ LANGUAGE plpgsql
    STABLE;

COMMENT ON FUNCTION common.get_stock(INT) IS 'Scalar function returning the quantity of inventory in location_id 6 (Miscellaneous Storage) for a specified product_id.';
