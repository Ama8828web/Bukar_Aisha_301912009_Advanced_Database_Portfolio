# Sample Personal Technical Reflection



**Student: Aisha Ali Bukar | ID: 301912009**

**During this portfolio I worked with a realistic e-commerce case study called ShopEase. I chose this domain because it naturally covers all the advanced database topics required: complex relationships, transactional integrity for stock and payments, flexible product data, and the need for scalability.**

**In Portfolio 1 I designed a fully normalised schema. The main challenge was deciding how to handle product categories (many-to-many) and variable product attributes. I settled on a clean relational design with an associative table and kept the more flexible attributes for the NoSQL part later.**

**In Portfolio 2 I wrote several business queries and examined their execution plans. Before adding indexes the plans showed sequential scans. After creating indexes on order\_date, status, and the foreign keys, the plans changed and the cost reduced. This helped me understand why proper indexing is important as data grows.**

**Portfolio 3 was the most practical part for me. I learned how easy it is to oversell products if two customers try to buy the last item at the same time. Using transactions with COMMIT and ROLLBACK helped me understand how to protect data. Testing the stock update and seeing the effect of ROLLBACK made the concept clear.**

**For Portfolio 4 I modelled the same data in MongoDB. The document model felt natural for products with different attributes and for orders that contain nested items, payment and delivery information. However, I also saw that strong transactional guarantees are still better handled by the relational database. This is why a hybrid approach makes sense.**

**In Portfolio 5 I designed a distributed architecture using sharding by customer/region, read replicas, and managed cloud services. The CAP theorem became clearer when I had to decide that stock and payments need strong consistency while product reviews can be eventually consistent.**

**Overall, the biggest lesson is that there is no single perfect database technology. The right choice depends on the specific requirements of consistency, flexibility, and scale. Working through the practical scripts and seeing the results myself gave me much better understanding than only reading theory.**

**If I were to improve this system in future I would add table partitioning for the orders table, introduce a caching layer (Redis), and set up proper monitoring and automated failover tests.**

