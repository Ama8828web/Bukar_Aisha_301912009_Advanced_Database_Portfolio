# Portfolio 4: NoSQL and Advanced Data Models (7 Marks)

**Student:** Aisha Ali Bukar | **ID:** 301912009  
**Case Study:** ShopEase Online Marketplace

## Why NoSQL for this case study?
The product catalogue has highly variable attributes (electronics need battery life, fashion needs size/colour, home goods need material).  
Orders are naturally hierarchical (order → items → payment → delivery).  
A document store (MongoDB) fits these flexible and nested structures very well, while the relational model remains ideal for strong transactional integrity on stock and payments.

## Files
- `mongodb_examples.js` – Sample documents and common operations
- `suitability_explanation.md` – Detailed comparison and justification

## How to demonstrate implementation
1. Create a free MongoDB Atlas cluster (or use local MongoDB).
2. Create database `shopease` and collections `products` and `orders`.
3. Insert the sample documents.
4. Run the example queries.
5. Take screenshots of the documents and query results.
