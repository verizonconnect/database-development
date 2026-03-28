CREATE FUNCTION common.get_product_standard_cost (v_product_id INT, v_order_date DATETIME)
RETURNS DECIMAL(19,4)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_standard_cost DECIMAL(19,4);
    SELECT  pch.standard_cost INTO v_standard_cost
    FROM    production.product AS p
    JOIN    production.product_cost_history AS pch
        ON  p.product_id = pch.product_id
        AND p.product_id = v_product_id
        AND v_order_date BETWEEN pch.start_date
            AND COALESCE(pch.end_date, '9999-12-31');
    RETURN v_standard_cost;
END;
