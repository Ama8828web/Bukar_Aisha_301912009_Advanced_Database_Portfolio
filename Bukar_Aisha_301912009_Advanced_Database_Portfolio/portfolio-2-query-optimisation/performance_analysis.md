# Performance Analysis & Optimisation Notes
**Portfolio 2 – ShopEase Online Marketplace**  
**Student:** Aisha Ali Bukar | ID: 301912009

## Methodology
1. Load schema + sample data.
2. Run each query with `EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)`.
3. Record the plan (look for Seq Scan, cost, actual time, rows).
4. Create the recommended indexes.
5. Re-run `EXPLAIN ANALYZE` and compare.
6. Capture screenshots of both plans and the result set.

## Expected Observations (typical on PostgreSQL)

### Query 1 (Top sellers)
- **Before indexes:** Sequential scans on `order`, `order_item`, `product`. High cost when data grows.
- **After indexes on order_date + status and order_item(product_id):** Index Scan or Bitmap Index Scan. Significant reduction in cost and execution time once the tables contain thousands of rows.

### Query 2 (Customer Lifetime Value)
- Benefits strongly from the composite index `(customer_id, status)`.
- Aggregation becomes faster because fewer rows are examined.

### Query 3 (Low stock + pending demand)
- Partial index on `stock_qty WHERE stock_qty < 20` (already in schema) helps filter low-stock products quickly.
- LEFT JOIN + HAVING still requires care; make sure statistics are up to date (`ANALYZE`).

### Query 4 (Monthly sales by category)
- Involves several joins. Indexes on the foreign keys and `order_date` reduce join cost.
- `DATE_TRUNC` prevents a simple index-only scan on order_date; a functional index could be considered in production:
  ```sql
  CREATE INDEX idx_order_month ON "order" (DATE_TRUNC('month', order_date));
  ```

### Query 5 (High-rated products)
- Index on `review(product_id)` is essential for the JOIN + GROUP BY.

## General Optimisation Principles Applied
- **Selective indexes** on columns used in WHERE, JOIN and ORDER BY.
- **Composite indexes** matching the most common filter combinations (`customer_id + status`, `order_date + status`).
- **Partial indexes** for common low-selectivity predicates (low stock).
- Avoid over-indexing – every index adds write overhead.
- Keep table statistics current with regular `ANALYZE`.

## What to include in your submission evidence
- Screenshot of `EXPLAIN ANALYZE` **before** indexes for at least two queries.
- Screenshot of `EXPLAIN ANALYZE` **after** indexes showing improved plan (Index Scan / lower cost).
- Final result set of each query.
- Short comment under each screenshot explaining the change (e.g. “Seq Scan → Index Scan on idx_order_date_status, cost reduced from 185 to 12”).

## Production Considerations
For a real ShopEase system with millions of rows:
- Consider partitioning the `order` table by month or year.
- Materialised views for the monthly sales report.
- Covering indexes if certain queries are extremely frequent.
