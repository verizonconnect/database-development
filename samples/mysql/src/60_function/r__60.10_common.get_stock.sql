CREATE FUNCTION common.get_stock (v_product_id INT)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_ret INT;
    SELECT  SUM(p.quantity) INTO v_ret
    FROM    production.product_inventory AS p
    WHERE   p.product_id = v_product_id
        AND p.location_id = 6;
    IF v_ret IS NULL THEN
        SET v_ret = 0;
    END IF;
    RETURN v_ret;
END;
