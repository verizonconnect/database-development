CREATE FUNCTION common.get_product_list_cost (
    v_product_id INT
   ,v_order_date DATETIME
)
RETURNS DECIMAL(19, 4)
READS SQL DATA
BEGIN
    DECLARE v_list_price DECIMAL(19, 4);
    SELECT plph.list_price INTO v_list_price
    FROM   production.product AS p
    JOIN   production.product_list_price_history AS plph
       ON  p.product_id = plph.product_id
       AND p.product_id = v_product_id
       AND v_order_date BETWEEN plph.start_date
           AND COALESCE(plph.end_date, CAST('9999-12-31' AS DATETIME));
    RETURN v_list_price;
END;
