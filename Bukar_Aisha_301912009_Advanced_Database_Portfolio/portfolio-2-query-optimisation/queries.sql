-- ============================================================
-- Portfolio 2: Query Processing and Optimisation
-- Student: Aisha Ali Bukar | ID: 301912009
-- Case Study: ShopEase Online Marketplace
-- ============================================================

-- ============================================================
-- QUERY 1: Top-selling products in the last 60 days
-- Business need: Identify best sellers for inventory & marketing
-- ============================================================
EXPLAIN ANALYZE
SELECT 
    p.product_id,
    p.product_name,
    s.seller_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.line_total) AS total_revenue
FROM order_item oi
JOIN "order" o ON oi.order_id = o.order_id
JOIN product p ON oi.product_id = p.product_id
JOIN seller s ON p.seller_id = s.seller_id
WHERE o.order_date >= CURRENT_DATE - INTERVAL '60 days'
  AND o.status NOT IN ('Cancelled', 'Returned')
GROUP BY p.product_id, p.product_name, s.seller_name
ORDER BY units_sold DESC
LIMIT 10;


-- ============================================================
-- QUERY 2: High-value customers (Customer Lifetime Value)
-- ============================================================
EXPLAIN ANALYZE
SELECT 
    c.customer_id,
    c.full_name,
    c.email,
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS lifetime_value,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customer c
JOIN "order" o ON c.customer_id = o.customer_id
WHERE o.status IN ('Paid', 'Shipped', 'Delivered')
GROUP BY c.customer_id, c.full_name, c.email, c.city
HAVING SUM(o.total_amount) > 100
ORDER BY lifetime_value DESC;


-- ============================================================
-- QUERY 3: Low-stock products that still have pending demand
-- Critical for warehouse / purchasing decisions
-- ============================================================
EXPLAIN ANALYZE
SELECT 
    p.product_id,
    p.product_name,
    p.stock_qty,
    COALESCE(SUM(oi.quantity), 0) AS pending_qty,
    (COALESCE(SUM(oi.quantity), 0) - p.stock_qty) AS shortfall
FROM product p
LEFT JOIN order_item oi ON p.product_id = oi.product_id
LEFT JOIN "order" o ON oi.order_id = o.order_id AND o.status = 'Pending'
WHERE p.stock_qty < 30
GROUP BY p.product_id, p.product_name, p.stock_qty
HAVING COALESCE(SUM(oi.quantity), 0) > 0
ORDER BY shortfall DESC;


-- ============================================================
-- QUERY 4: Monthly sales summary by category
-- ============================================================
EXPLAIN ANALYZE
SELECT 
    cat.category_name,
    DATE_TRUNC('month', o.order_date) AS sales_month,
    COUNT(DISTINCT o.order_id) AS orders_count,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.line_total) AS revenue
FROM category cat
JOIN product_category pc ON cat.category_id = pc.category_id
JOIN product p ON pc.product_id = p.product_id
JOIN order_item oi ON p.product_id = oi.product_id
JOIN "order" o ON oi.order_id = o.order_id
WHERE o.status NOT IN ('Cancelled', 'Returned')
GROUP BY cat.category_name, DATE_TRUNC('month', o.order_date)
ORDER BY sales_month DESC, revenue DESC;


-- ============================================================
-- QUERY 5: Products with average rating >= 4.5 and enough reviews
-- ============================================================
EXPLAIN ANALYZE
SELECT 
    p.product_id,
    p.product_name,
    COUNT(r.review_id) AS review_count,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating
FROM product p
JOIN review r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(r.review_id) >= 1 AND AVG(r.rating) >= 4.0
ORDER BY avg_rating DESC, review_count DESC;


-- ============================================================
-- Recommended Indexes (create these AFTER baseline EXPLAIN)
-- ============================================================
-- Already partially created in schema.sql, but listed here for clarity:

-- CREATE INDEX IF NOT EXISTS idx_order_date ON "order"(order_date);
-- CREATE INDEX IF NOT EXISTS idx_order_status ON "order"(status);
-- CREATE INDEX IF NOT EXISTS idx_order_item_product ON order_item(product_id);
-- CREATE INDEX IF NOT EXISTS idx_order_item_order ON order_item(order_id);
-- CREATE INDEX IF NOT EXISTS idx_product_seller ON product(seller_id);
-- CREATE INDEX IF NOT EXISTS idx_review_product ON review(product_id);

-- Additional useful indexes for the queries above:
CREATE INDEX IF NOT EXISTS idx_order_customer_status 
    ON "order"(customer_id, status);

CREATE INDEX IF NOT EXISTS idx_order_date_status 
    ON "order"(order_date, status);

-- ============================================================
-- End of queries
-- ============================================================
