# Suitability of NoSQL (Document Model) for ShopEase
**Portfolio 4**  
**Student:** Aisha Ali Bukar | ID: 301912009

## Why a Document Model fits parts of the system

1. **Variable product attributes**  
   Electronics, fashion and home products have completely different attribute sets. In a relational model this leads to sparse tables or an EAV (Entity-Attribute-Value) design that is hard to query. A document store stores only the attributes that exist for that product.

2. **Hierarchical order data**  
   An order naturally contains items, payment details and delivery information. Embedding them in a single document allows a single read to retrieve the entire order history — ideal for customer service screens and mobile apps.

3. **Rapid development & schema evolution**  
   New product types or new delivery fields can be added without ALTER TABLE migrations.

4. **Horizontal scaling**  
   MongoDB (or similar) can shard the products collection by category or seller_id and the orders collection by customer_id or region, supporting growth.

## Where the Relational Model remains superior

| Concern                        | Relational Advantage                              |
|--------------------------------|---------------------------------------------------|
| Strong ACID on stock & payment | Critical to prevent overselling and double-charging |
| Complex multi-table joins & reports | SQL is more expressive for analytics            |
| Referential integrity          | Foreign keys enforce consistency automatically    |
| Mature tooling & reporting     | BI tools work better with normalised tables       |

## Recommended Hybrid Architecture for ShopEase

- **PostgreSQL (or similar RDBMS)**  
  – Core transactional data: customers, products (core fields + stock), orders, order_items, payments.  
  – Guarantees consistency for inventory and financial operations.

- **MongoDB (or DocumentDB)**  
  – Product catalogue with rich, variable attributes and embedded reviews.  
  – Order history / customer 360 views (eventually consistent copies).  
  – Session / shopping-cart data (or use Redis).

- **Search engine (Elasticsearch / OpenSearch)**  
  – Full-text and faceted product search.

This polyglot approach uses the right tool for each workload while keeping the system maintainable.

## Implementation Evidence Required
- Screenshots of inserted product and order documents.
- Screenshots of the example queries running successfully.
- Short personal comment on the advantages and disadvantages you observed when working with the document model.
