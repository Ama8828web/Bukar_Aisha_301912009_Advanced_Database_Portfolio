# Portfolio 3: Transactions and Concurrency (7 Marks)

**Student:** Aisha Ali Bukar | **ID:** 301912009  
**Case Study:** ShopEase Online Marketplace

## Goal
Demonstrate understanding of ACID properties, transaction control (COMMIT / ROLLBACK), isolation levels, and concurrency control mechanisms (locking) in a realistic e-commerce scenario — especially **preventing overselling** of stock.

## Files
- `transactions.sql` – Complete scripts for successful order placement, forced rollback, and concurrency demonstration.
- `concurrency_notes.md` – Explanation of isolation levels and how to demonstrate problems/solutions.

## How to Test
1. Open **two** separate database sessions (two terminals or two Query Tool windows).
2. Follow the instructions inside `transactions.sql` and `concurrency_notes.md`.
3. Capture screenshots of:
   - Successful COMMIT
   - Explicit ROLLBACK
   - Lock waiting / deadlock error
   - Different behaviour under READ COMMITTED vs REPEATABLE READ
