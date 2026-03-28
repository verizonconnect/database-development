USE tap;
BEGIN;
SELECT tap.plan(12);

-- act: call all functions into variables
SET @stock_null = common.get_stock(-1);
SELECT common.get_document_status_text(1) INTO @doc_1;
SELECT common.get_document_status_text(2) INTO @doc_2;
SELECT common.get_document_status_text(99) INTO @doc_99;
SELECT common.get_purchase_order_status_text(1) INTO @po_1;
SELECT common.get_purchase_order_status_text(4) INTO @po_4;
SELECT common.get_sales_order_status_text(5) INTO @so_5;
SELECT common.get_sales_order_status_text(6) INTO @so_6;
SET @acc_start = common.get_accounting_start_date();
SET @acc_end = common.get_accounting_end_date();
SET @cost_null = common.get_product_standard_cost(-1, NOW());
SET @contact_null = common.get_contact_information(-1);

-- assert
SELECT tap.ok(@stock_null = 0, 'get_stock should return 0 for non-existent product');
SELECT tap.ok(@doc_1 = 'Pending approval', 'get_document_status_text(1) should return Pending approval');
SELECT tap.ok(@doc_2 = 'Approved', 'get_document_status_text(2) should return Approved');
SELECT tap.ok(@doc_99 = '** Invalid **', 'get_document_status_text(99) should return ** Invalid **');
SELECT tap.ok(@po_1 = 'Pending', 'get_purchase_order_status_text(1) should return Pending');
SELECT tap.ok(@po_4 = 'Complete', 'get_purchase_order_status_text(4) should return Complete');
SELECT tap.ok(@so_5 = 'Shipped', 'get_sales_order_status_text(5) should return Shipped');
SELECT tap.ok(@so_6 = 'Cancelled', 'get_sales_order_status_text(6) should return Cancelled');
SELECT tap.ok(@acc_start = CAST('2003-07-01' AS DATETIME), 'get_accounting_start_date should return 2003-07-01');
SELECT tap.ok(@acc_end IS NOT NULL, 'get_accounting_end_date should return a value');
SELECT tap.ok(@cost_null IS NULL, 'get_product_standard_cost should return NULL for non-existent product');
SELECT tap.ok(@contact_null IS NULL, 'get_contact_information should return NULL for non-existent person');

CALL tap.finish();
ROLLBACK;
