# Portfolio 1: Database Design and Modelling (7 Marks)

**Student:** Aisha Ali Bukar | **ID:** 301912009  
**Case Study:** ShopEase Online Marketplace (used consistently across all portfolios)

## Deliverables in this folder

- `schema.sql` – Complete relational schema with keys, constraints and comments  
- `sample_data.sql` – Realistic sample data for testing  
- `er-diagram-description.md` – Entity-Relationship description + Mermaid code (copy into any Mermaid viewer or draw.io)

## Design Summary

The relational model is fully normalised to **Third Normal Form (3NF)**.

### Main Entities
- SELLER
- CUSTOMER
- PRODUCT
- CATEGORY
- ORDER
- ORDER_ITEM
- PAYMENT
- DELIVERY
- REVIEW
- PRODUCT_CATEGORY (associative / bridge table)

### Key Design Decisions
1. **Stock quantity** is stored on PRODUCT and protected by CHECK constraint and transactional updates (see Portfolio 3).
2. **Order status** and **Payment status** use constrained ENUM-like CHECK values for data integrity.
3. **line_total** on ORDER_ITEM is a generated column to avoid update anomalies.
4. Address fields are kept atomic (no multi-valued attributes).
5. Product categories are many-to-many via PRODUCT_CATEGORY.
6. A customer can review a product only once (UNIQUE constraint on product_id + customer_id).

### Normalisation Justification
- 1NF: All attributes atomic, no repeating groups.
- 2NF: No partial dependency on composite keys (the only composite PK is the associative table).
- 3NF: No transitive dependencies. Non-key attributes depend only on the primary key.

Foreign keys use appropriate ON DELETE behaviour (CASCADE for order items, RESTRICT for critical references).
