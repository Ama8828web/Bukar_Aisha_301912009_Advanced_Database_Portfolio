# MIT 8103 Advanced Database Systems  
## Continuous Assessment Portfolio – Final Documentation (2–3 pages)

**Student Name:** Aisha Ali Bukar  
**Student ID:** 301912009  
**Programme:** Master of Information Technology  
**Academic Session:** 2026/2027 First Semester  

---

### 1. Selected Case Study / Organisation

**ShopEase Online Marketplace** is a realistic mid-sized e-commerce platform that sells consumer electronics, fashion and home goods. It operates a multi-seller marketplace model.  

**Users:** Customers, sellers, warehouse staff, customer-service agents, finance team and administrators.  

**Major data:** Customers, sellers, products (with variable attributes), categories, orders, order items, payments, deliveries and reviews.  

**Key operations supported:** Product listing & search, place/cancel order, real-time stock management, payment processing, delivery tracking, sales reporting and customer reviews.  

This single case study is used consistently across all five portfolio activities.

---

### 2. Summary of Portfolio Activities

**Portfolio 1 – Database Design and Modelling**  
A fully normalised (3NF) relational schema was designed with nine core tables plus an associative table. Primary keys, foreign keys, CHECK constraints, UNIQUE constraints and a generated column (`line_total`) were defined. An Entity-Relationship description and Mermaid code for the visual diagram are provided. Sample data was loaded for testing.

**Portfolio 2 – Query Processing and Optimisation**  
Five realistic business queries were written (top sellers, customer lifetime value, low-stock alerts, monthly category sales, high-rated products). Indexes (including composite and partial indexes) were recommended. The analysis document explains how to capture before/after `EXPLAIN ANALYZE` plans to demonstrate performance improvement.

**Portfolio 3 – Transactions and Concurrency**  
Complete transaction scripts demonstrate successful order placement with `SELECT … FOR UPDATE` (preventing overselling), explicit ROLLBACK, isolation level behaviour and a deadlock scenario. Concurrency notes explain ACID properties and isolation levels in the context of the e-commerce workload.

**Portfolio 4 – NoSQL and Advanced Data Models**  
A document-oriented model (MongoDB) was designed for the product catalogue (variable attributes) and for orders (embedded items, payment and delivery). Sample documents and queries are provided. A suitability discussion explains when the document model is advantageous and when the relational model remains preferable, recommending a hybrid architecture.

**Portfolio 5 – Distributed and Cloud Database Exercise**  
A practical distributed design is presented covering sharding (by customer or region), replication (Multi-AZ + read replicas), consistency vs availability trade-offs (strong consistency for stock/payment, eventual consistency for catalogue/reviews), and concrete cloud deployment options using managed services.

---

### 3. GitHub Repository

Repository name (recommended):  
`Bukar_Aisha_301912009_Advanced_Database_Portfolio`  

Make the repository private and grant the assessor access before LMS submission.  
All practical files (SQL scripts, MongoDB examples, documentation) are organised exactly as required by the assessment brief.

---

### 4. Individual Technical Reflection

*(Write this section in your own words after you have run the scripts and observed the behaviour. Suggested points you may cover:)*

- Why I chose the e-commerce domain and how the data requirements map to the five portfolio topics.  
- Challenges faced when protecting stock with transactions and how row-level locking solved the overselling problem.  
- Observations from comparing sequential scans versus index scans in Portfolio 2.  
- Trade-offs I discovered between the rigid but consistent relational model and the flexible document model.  
- Lessons learned about distributed systems (CAP theorem applied to a real business).  
- What I would improve if this were a production system (partitioning, materialised views, connection pooling, monitoring).  
- How the progressive GitHub commits helped me organise the work.

---

### 5. References

- PostgreSQL 16 Documentation – Transaction Isolation and Locking  
- MongoDB Manual – Data Modelling and Aggregation  
- Elmasri & Navathe – Fundamentals of Database Systems (normalisation)  
- Cloud provider documentation (AWS RDS, MongoDB Atlas, Neon, Supabase)  
- Course lecture materials and recommended readings for MIT 8103

---

### 6. AI Use Declaration

See the separate file `AI_Use_Declaration.md` in this folder.
