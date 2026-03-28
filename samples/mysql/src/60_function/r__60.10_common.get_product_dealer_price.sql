CREATE FUNCTION common.get_product_dealer_price (
    v_product_id INT
   ,v_order_date DATETIME
)
RETURNS DECIMAL(19, 4)
READS SQL DATA
BEGIN
    DECLARE v_dealer_price DECIMAL(19, 4);
    DECLARE v_dealer_discount DECIMAL(19, 4) DEFAULT 0.60;
    SELECT plph.list_price * v_dealer_discount INTO v_dealer_price
    FROM   production.product AS p
    JOIN   production.product_list_price_history AS plph
       ON  p.product_id = plph.product_id
       AND p.product_id = v_product_id
       AND v_order_date BETWEEN plph.start_date
           AND COALESCE(plph.end_date, CAST('9999-12-31' AS DATETIME));
    RETURN v_dealer_price;
END;
