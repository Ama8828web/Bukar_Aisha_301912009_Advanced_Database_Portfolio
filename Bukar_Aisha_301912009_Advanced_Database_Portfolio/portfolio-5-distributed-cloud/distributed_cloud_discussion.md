# Distributed and Cloud Database Design for ShopEase
**Portfolio 5**  
**Student:** Aisha Ali Bukar | ID: 301912009  
**Case Study:** ShopEase Online Marketplace

## 1. Business Drivers for Distribution & Cloud

- Customers and sellers are located across Nigeria and potentially West Africa → latency matters.
- Traffic spikes during sales events (Black Friday, Christmas, etc.).
- Need high availability – downtime means lost sales.
- Rapid growth expected → must scale horizontally.
- Prefer managed services to reduce operational burden on a student / small team.

## 2. Recommended High-Level Architecture

```
                    ┌─────────────────────┐
                    │   Application Layer │
                    │  (Web / Mobile API) │
                    └─────────┬───────────┘
                              │
              ┌───────────────┼───────────────┐
              │               │               │
              ▼               ▼               ▼
     ┌────────────────┐ ┌──────────┐ ┌────────────────┐
     │  PostgreSQL    │ │  Redis   │ │  MongoDB Atlas │
     │  (Primary +    │ │  (Cache  │ │  (Catalogue &  │
     │   Read Replicas│ │   / Cart)│ │   Order views) │
     │   Multi-AZ)    │ └──────────┘ └────────────────┘
     └────────────────┘
              │
              ▼
     ┌────────────────┐
     │  Object Storage│
     │  (Product images)
     └────────────────┘
```

## 3. Sharding Strategy

**Orders & Customers**  
- Shard key: `customer_id` (hash) or geographic region (Lagos, Abuja, North, South, etc.).  
- Benefit: A customer’s entire order history stays on one shard → fast retrieval.  
- Alternative: time-based partitioning (monthly partitions) for the orders table if the volume becomes very large.

**Products**  
- Can remain on a single primary for a medium-sized catalogue, or shard by `seller_id` / category if the number of products grows into the millions.

## 4. Replication & High Availability

| Component          | Strategy                              | Purpose                              |
|--------------------|---------------------------------------|--------------------------------------|
| PostgreSQL         | Multi-AZ deployment + read replicas   | Automatic failover, offload reporting|
| MongoDB Atlas      | Replica set (3 nodes minimum)         | High availability for catalogue      |
| Redis              | Redis Cluster or managed Redis        | Session & cart durability            |

Synchronous replication is preferred for the payment and stock-critical path.  
Asynchronous replication is acceptable for read replicas used by analytics and product browsing.

## 5. Consistency vs Availability Trade-offs (CAP)

- **Stock deduction & Payment** → Strong consistency (CP system). We prefer consistency over availability; better to reject an order than to oversell.
- **Product catalogue browsing & Reviews** → Eventual consistency is acceptable (AP). A few seconds delay in seeing a new review or updated product description is fine.
- **Shopping cart** → Session-level consistency; Redis with persistence is sufficient.

## 6. Practical Cloud Deployment Options (Free / Low-cost tiers)

1. **PostgreSQL**  
   - Neon.tech, Supabase, Railway, or AWS RDS free tier / Azure Database for PostgreSQL flexible server (burstable).  
   - Enable automated backups and point-in-time recovery.

2. **MongoDB**  
   - MongoDB Atlas free tier (M0) – perfect for the document examples in Portfolio 4.

3. **Redis**  
   - Redis Cloud free tier or Upstash.

4. **Object Storage for images**  
   - Cloudflare R2, AWS S3 free tier, or Supabase Storage.

## 7. Monitoring & Operational Concerns

- Enable slow-query logging and `pg_stat_statements`.
- Set up alerts for high CPU, storage, and replication lag.
- Regularly test failover (especially before peak sales periods).
- Keep connection pooling (PgBouncer / PgCat) in front of the database to handle many application connections.

## 8. Summary of Design Choices

| Requirement              | Solution chosen                          |
|--------------------------|------------------------------------------|
| Strong transactional integrity | PostgreSQL primary with row-level locking |
| Flexible product data    | MongoDB documents                        |
| Low latency reads        | Read replicas + Redis cache              |
| Geographic distribution  | Sharding by region / customer_id         |
| High availability        | Multi-AZ / Replica sets                  |
| Manageable operations    | Managed cloud services                   |

This design demonstrates practical understanding of distributed database concepts (replication, sharding, consistency models) applied to a realistic e-commerce workload.
