-- ============================================================
-- Portfolio 3: Transactions and Concurrency
-- Student: Aisha Ali Bukar | ID: 301912009
-- Case Study: ShopEase Online Marketplace
-- ============================================================

-- ============================================================
-- SCENARIO 1: Successful Order Placement (COMMIT)
-- Protects against overselling using SELECT ... FOR UPDATE
-- ============================================================

BEGIN;

-- 1. Lock the product row so no other transaction can change stock
SELECT product_id, product_name, stock_qty 
FROM product 
WHERE product_id = 1 
FOR UPDATE;

-- 2. Check stock is sufficient (application would do this logic)
-- Assume we want to buy quantity = 2
-- (In real code you would raise an exception if stock_qty < 2)

-- 3. Deduct stock
UPDATE product 
SET stock_qty = stock_qty - 2 
WHERE product_id = 1 AND stock_qty >= 2;

-- 4. Create the order
INSERT INTO "order" (customer_id, status, total_amount)
VALUES (1, 'Pending', 259.98)
RETURNING order_id;
-- Note the returned order_id (example: 9)

-- 5. Insert order items (replace 9 with the actual returned order_id)
INSERT INTO order_item (order_id, product_id, quantity, unit_price)
VALUES 
(9, 1, 2, 129.99);   -- change 9 to the real order_id

-- 6. Record payment
INSERT INTO payment (order_id, amount, payment_method, payment_status, paid_at)
VALUES (9, 259.98, 'Card', 'Completed', CURRENT_TIMESTAMP);

-- 7. Update order status
UPDATE "order" SET status = 'Paid' WHERE order_id = 9;

-- 8. Create delivery record
INSERT INTO delivery (order_id, courier_name, status, estimated_date)
VALUES (9, 'GIG Logistics', 'Preparing', CURRENT_DATE + 3);

COMMIT;

-- Verify
SELECT * FROM product WHERE product_id = 1;
SELECT * FROM "order" WHERE order_id = 9;
SELECT * FROM order_item WHERE order_id = 9;


-- ============================================================
-- SCENARIO 2: Forced ROLLBACK (payment fails or stock insufficient)
-- ============================================================

BEGIN;

SELECT stock_qty FROM product WHERE product_id = 3 FOR UPDATE;

-- Simulate insufficient stock or payment failure
-- We intentionally do not update stock and roll back everything

INSERT INTO "order" (customer_id, status, total_amount)
VALUES (2, 'Pending', 199.99)
RETURNING order_id;

-- Suppose payment gateway returns failure...
ROLLBACK;

-- Nothing is saved – order, items, payment all disappear.


-- ============================================================
-- SCENARIO 3: Demonstrating Isolation – Dirty Read prevention
-- Open TWO sessions
-- ============================================================

-- SESSION A
BEGIN;
UPDATE product SET stock_qty = stock_qty - 5 WHERE product_id = 2;
-- Do NOT commit yet

-- SESSION B (in another window)
-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED;  (default)
SELECT stock_qty FROM product WHERE product_id = 2;
-- You will still see the OLD value (no dirty read)

-- SESSION A
ROLLBACK;   -- or COMMIT


-- ============================================================
-- SCENARIO 4: Non-repeatable Read demonstration
-- ============================================================

-- SESSION A
BEGIN;
SELECT stock_qty FROM product WHERE product_id = 4;   -- note the value

-- SESSION B
BEGIN;
UPDATE product SET stock_qty = stock_qty - 10 WHERE product_id = 4;
COMMIT;

-- SESSION A (still in same transaction)
SELECT stock_qty FROM product WHERE product_id = 4;   -- value has changed → non-repeatable read
COMMIT;


-- ============================================================
-- SCENARIO 5: Deadlock example (run carefully)
-- SESSION A and SESSION B must run the statements in interleaved order
-- ============================================================

-- SESSION A
BEGIN;
UPDATE product SET stock_qty = stock_qty - 1 WHERE product_id = 5;
-- wait...

-- SESSION B
BEGIN;
UPDATE product SET stock_qty = stock_qty - 1 WHERE product_id = 6;
-- wait...

-- SESSION A continues
UPDATE product SET stock_qty = stock_qty - 1 WHERE product_id = 6;  -- will wait

-- SESSION B continues
UPDATE product SET stock_qty = stock_qty - 1 WHERE product_id = 5;  -- deadlock detected

-- PostgreSQL will abort one of the transactions with a deadlock error.
-- Solution: always lock resources in the same order (e.g. lower product_id first).

-- ============================================================
-- End of transaction scripts
-- ============================================================
