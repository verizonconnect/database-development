USE tap;
BEGIN;
SELECT tap.plan(12);

-- get_stock: NULL path returns 0
SELECT tap.ok(
    common.get_stock(-1) = 0
   ,'get_stock should return 0 for non-existent product'
);

-- get_document_status_text: all CASE paths
SELECT tap.ok(
    common.get_document_status_text(1) = 'Pending approval'
   ,'get_document_status_text(1) should return Pending approval'
);
SELECT tap.ok(
    common.get_document_status_text(2) = 'Approved'
   ,'get_document_status_text(2) should return Approved'
);
SELECT tap.ok(
    common.get_document_status_text(99) = '** Invalid **'
   ,'get_document_status_text(99) should return ** Invalid **'
);

-- get_purchase_order_status_text
SELECT tap.ok(
    common.get_purchase_order_status_text(1) = 'Pending'
   ,'get_purchase_order_status_text(1) should return Pending'
);
SELECT tap.ok(
    common.get_purchase_order_status_text(4) = 'Complete'
   ,'get_purchase_order_status_text(4) should return Complete'
);

-- get_sales_order_status_text
SELECT tap.ok(
    common.get_sales_order_status_text(5) = 'Shipped'
   ,'get_sales_order_status_text(5) should return Shipped'
);
SELECT tap.ok(
    common.get_sales_order_status_text(6) = 'Cancelled'
   ,'get_sales_order_status_text(6) should return Cancelled'
);

-- get_accounting dates
SELECT tap.ok(
    common.get_accounting_start_date() = CAST('2003-07-01' AS DATETIME)
   ,'get_accounting_start_date should return 2003-07-01'
);
SELECT tap.ok(
    common.get_accounting_end_date() IS NOT NULL
   ,'get_accounting_end_date should return a value'
);

-- get_product_standard_cost: NULL for non-existent product
SELECT tap.ok(
    common.get_product_standard_cost(-1, NOW()) IS NULL
   ,'get_product_standard_cost should return NULL for non-existent product'
);

-- get_contact_information: NULL for non-existent person
SELECT tap.ok(
    common.get_contact_information(-1) IS NULL
   ,'get_contact_information should return NULL for non-existent person'
);

CALL tap.finish();
ROLLBACK;
