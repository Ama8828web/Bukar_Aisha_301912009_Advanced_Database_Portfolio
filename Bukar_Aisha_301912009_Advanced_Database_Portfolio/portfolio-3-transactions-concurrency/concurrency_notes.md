# Concurrency Control & Isolation Notes
**Portfolio 3 – ShopEase**  
**Student:** Aisha Ali Bukar | ID: 301912009

## ACID Properties in the Order Placement Transaction

| Property       | How it is demonstrated in the script                          |
|----------------|---------------------------------------------------------------|
| Atomicity      | Either the whole order (stock + order + payment + delivery) is saved or nothing is (ROLLBACK) |
| Consistency    | Stock never goes negative (CHECK constraint + FOR UPDATE + application check) |
| Isolation      | `SELECT ... FOR UPDATE` acquires a row-level exclusive lock   |
| Durability     | After COMMIT the changes survive a crash (PostgreSQL WAL)     |

## Isolation Levels (PostgreSQL)

| Level              | Dirty Read | Non-repeatable Read | Phantom Read | Used for |
|--------------------|------------|---------------------|--------------|----------|
| READ COMMITTED (default) | No     | Possible            | Possible     | Most OLTP |
| REPEATABLE READ    | No         | No                  | Possible*    | Reports   |
| SERIALIZABLE       | No         | No                  | No           | Critical financial |

*In PostgreSQL, REPEATABLE READ already prevents phantoms for most practical cases via snapshot isolation.

## Why SELECT … FOR UPDATE is critical for stock

Without it, two customers can both read stock_qty = 1, both decide to buy, and both succeed → stock becomes –1 (overselling).

`FOR UPDATE` forces the second transaction to wait until the first one commits or rolls back.

## Deadlock Avoidance Strategy used in ShopEase design
Always acquire locks in a consistent global order (e.g. ascending product_id).  
This eliminates circular wait conditions.

## Evidence you should capture
1. Screenshot of successful COMMIT and the resulting lower stock_qty.
2. Screenshot of ROLLBACK – proving no partial data remains.
3. Screenshot of two sessions showing lock wait (or deadlock error message).
4. Screenshot showing different stock values under concurrent transactions when isolation is lower.
5. Brief personal comment on what you observed.
