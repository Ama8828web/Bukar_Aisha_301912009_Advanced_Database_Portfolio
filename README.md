# Advanced Database Systems Portfolio
**MIT 8103 – Continuous Assessment (40 Marks)**  
**Student:** Aisha Ali Bukar  
**Student ID:** 301912009  
**Programme:** Master of Information Technology  
**Academic Session:** 2026/2027 – First Semester  

---

## Selected Case Study / Organisation

**Organisation Name:** ShopEase Online Marketplace  

**Nature of the business/system:**  
ShopEase is a mid-sized e-commerce platform that sells consumer electronics, fashion, and home goods. It supports multiple sellers (marketplace model), online ordering, inventory management, payment processing, delivery tracking, and customer reviews.

**Users of the database:**  
- Customers (shoppers)  
- Sellers / Vendors  
- Warehouse / Inventory staff  
- Customer service agents  
- Finance / Accounts team  
- System administrators  

**Major data stored:**  
Customers, Sellers, Products (with variable attributes), Categories, Orders, Order Items, Payments, Deliveries, Reviews, Stock levels.

**Key operations the database supports:**  
- Product listing, search and filtering  
- Place / cancel / update order  
- Real-time stock checking and deduction  
- Payment processing and status updates  
- Delivery tracking  
- Generate sales reports and customer lifetime value  
- Handle product reviews and ratings  

This case study is used **consistently** across all five portfolio activities.

---

## Repository Structure

```
Bukar_Aisha_301912009_Advanced_Database_Portfolio/
├── README.md                          (this file)
├── portfolio-1-database-design/
│   ├── README.md
│   ├── schema.sql
│   ├── sample_data.sql
│   └── er-diagram-description.md
├── portfolio-2-query-optimisation/
│   ├── README.md
│   ├── queries.sql
│   └── performance_analysis.md
├── portfolio-3-transactions-concurrency/
│   ├── README.md
│   ├── transactions.sql
│   └── concurrency_notes.md
├── portfolio-4-nosql/
│   ├── README.md
│   ├── mongodb_examples.js
│   └── suitability_explanation.md
├── portfolio-5-distributed-cloud/
│   ├── README.md
│   └── distributed_cloud_discussion.md
└── final-documentation/
    ├── Portfolio_Summary.md
    └── AI_Use_Declaration.md
```

---

## How to Use This Portfolio

1. **Database Engine Recommended:** PostgreSQL 14+ (or MySQL 8+).  
2. Run `portfolio-1-database-design/schema.sql` then `sample_data.sql`.  
3. Execute the queries in Portfolio 2 and capture `EXPLAIN ANALYZE` output.  
4. Test the transaction scripts in Portfolio 3 in two concurrent sessions.  
5. For Portfolio 4, you can import the MongoDB examples into MongoDB Atlas (free tier) or a local MongoDB instance.  
6. Review the discussion documents and add your own screenshots / personal reflection.  

**Important Academic Integrity Note:**  
All SQL, designs and explanations were prepared with AI assistance. You **must** execute the scripts yourself, take your own screenshots of execution plans and results, write a personal technical reflection, and include the AI Use Declaration. Simply submitting these files without understanding them will not satisfy the assessment criteria.

---

## Progressive Development Recommendation

Commit each portfolio folder as you complete and test it. Do not upload everything on the last day. Progressive commits demonstrate continuous work as required by the brief.
