CREATE OR REPLACE FUNCTION common.get_where_used__product_id (
    IN v_start_product_id INT
   ,IN v_check_date TIMESTAMP
   )
RETURNS TABLE (
    product_assembly_id INT
   ,component_id INT
   ,component_desc VARCHAR(50)
   ,total_quantity NUMERIC(8, 2)
   ,standard_cost NUMERIC
   ,list_price NUMERIC
   ,bom_level SMALLINT
   ,recursion_level INT
   ) AS
$$
BEGIN
    RETURN QUERY
        WITH RECURSIVE bom_cte AS (
            SELECT  b.product_assembly_id
                   ,b.component_id
                   ,p.name::VARCHAR(50)        AS component_desc
                   ,b.per_assembly_qty
                   ,p.standard_cost
                   ,p.list_price
                   ,b.bom_level
                   ,0                          AS recursion_level
            FROM    production.bill_of_materials AS b
            JOIN    production.product AS p
                ON  b.product_assembly_id = p.product_id
            WHERE   b.component_id = v_start_product_id
                AND v_check_date >= b.start_date
                AND v_check_date <= COALESCE(b.end_date, v_check_date)

            UNION ALL

            SELECT  b.product_assembly_id
                   ,b.component_id
                   ,p.name::VARCHAR(50)
                   ,b.per_assembly_qty
                   ,p.standard_cost
                   ,p.list_price
                   ,b.bom_level
                   ,cte.recursion_level + 1
            FROM    bom_cte AS cte
            JOIN    production.bill_of_materials AS b
                ON  cte.product_assembly_id = b.component_id
            JOIN    production.product AS p
                ON  b.product_assembly_id = p.product_id
            WHERE   v_check_date >= b.start_date
                AND v_check_date <= COALESCE(b.end_date, v_check_date)
        )
        SELECT  c.product_assembly_id
               ,c.component_id
               ,c.component_desc
               ,SUM(c.per_assembly_qty)::NUMERIC(8, 2)
               ,c.standard_cost
               ,c.list_price
               ,c.bom_level
               ,c.recursion_level
        FROM    bom_cte AS c
        GROUP BY c.component_id
                ,c.component_desc
                ,c.product_assembly_id
                ,c.bom_level
                ,c.recursion_level
                ,c.standard_cost
                ,c.list_price
        ORDER BY c.bom_level
                ,c.product_assembly_id
                ,c.component_id;
END;
$$ LANGUAGE plpgsql
    STABLE;

COMMENT ON FUNCTION common.get_where_used__product_id(INT, TIMESTAMP) IS 'Returns all components or assemblies that directly or indirectly use the specified product_id.';
