// ============================================================
// Portfolio 4: NoSQL (MongoDB) Examples
// Student: Aisha Ali Bukar | ID: 301912009
// Case Study: ShopEase Online Marketplace
// ============================================================

// Use database
// use shopease

// ------------------------------------------------------------
// 1. PRODUCT DOCUMENT (flexible schema for variable attributes)
// ------------------------------------------------------------
db.products.insertOne({
  _id: ObjectId("670a1b2c3d4e5f6789012345"),
  seller_id: 1,
  seller_name: "TechNova Electronics",
  name: "Wireless Noise-Cancelling Headphones",
  price: 129.99,
  stock: 45,
  is_active: true,
  categories: ["Electronics", "Audio"],
  attributes: {
    brand: "SoundMax",
    color: "Black",
    battery_life_hours: 30,
    connectivity: ["Bluetooth 5.2", "USB-C"],
    noise_cancellation: true,
    weight_grams: 250
  },
  reviews: [
    {
      customer_id: 1,
      customer_name: "Chinedu Okafor",
      rating: 5,
      comment: "Excellent noise cancellation and battery life.",
      date: ISODate("2026-09-20T10:00:00Z")
    }
  ],
  created_at: ISODate("2026-08-01T09:00:00Z")
});

db.products.insertOne({
  _id: ObjectId("670a1b2c3d4e5f6789012346"),
  seller_id: 2,
  seller_name: "FashionHub NG",
  name: "Women's Ankara Print Dress",
  price: 45.50,
  stock: 35,
  is_active: true,
  categories: ["Fashion"],
  attributes: {
    material: "100% Cotton",
    size: "Free Size",
    print: "Ankara",
    care: "Hand wash"
  },
  reviews: [],
  created_at: ISODate("2026-08-05T11:30:00Z")
});

// ------------------------------------------------------------
// 2. ORDER DOCUMENT (embedded items + payment + delivery)
// ------------------------------------------------------------
db.orders.insertOne({
  _id: ObjectId("670a1b2c3d4e5f6789013001"),
  customer_id: 1,
  customer_name: "Chinedu Okafor",
  customer_email: "chinedu.okafor@email.com",
  order_date: ISODate("2026-09-15T10:23:00Z"),
  status: "Delivered",
  total_amount: 164.98,
  items: [
    {
      product_id: ObjectId("670a1b2c3d4e5f6789012345"),
      name: "Wireless Noise-Cancelling Headphones",
      quantity: 1,
      unit_price: 129.99,
      line_total: 129.99
    },
    {
      product_id: ObjectId("670a1b2c3d4e5f6789012347"),
      name: "USB-C Fast Charger 65W",
      quantity: 1,
      unit_price: 34.99,
      line_total: 34.99
    }
  ],
  payment: {
    method: "Card",
    status: "Completed",
    transaction_id: "TXN-998877",
    paid_at: ISODate("2026-09-15T10:25:00Z")
  },
  delivery: {
    courier: "GIG Logistics",
    tracking_number: "GIG998877",
    status: "Delivered",
    estimated_date: ISODate("2026-09-18T00:00:00Z"),
    delivered_at: ISODate("2026-09-17T14:20:00Z")
  }
});

// ------------------------------------------------------------
// Useful Queries
// ------------------------------------------------------------

// Find products in Electronics category with stock > 20
db.products.find({
  categories: "Electronics",
  stock: { $gt: 20 }
}).pretty();

// Find high-rated products (average rating calculation would use aggregation)
db.products.find({
  "reviews.rating": { $gte: 4 }
}).pretty();

// Get a full order with all embedded details (single document read)
db.orders.findOne({ _id: ObjectId("670a1b2c3d4e5f6789013001") });

// Update stock after an order (simple example)
db.products.updateOne(
  { _id: ObjectId("670a1b2c3d4e5f6789012345") },
  { $inc: { stock: -1 } }
);

// Aggregation: total revenue by status
db.orders.aggregate([
  { $group: {
      _id: "$status",
      total_revenue: { $sum: "$total_amount" },
      order_count: { $sum: 1 }
  }},
  { $sort: { total_revenue: -1 } }
]);

// ============================================================
// End of MongoDB examples
// ============================================================
