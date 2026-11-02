-- ============================================================
-- Sample Data for ShopEase Online Marketplace
-- Student: Aisha Ali Bukar | ID: 301912009
-- Run AFTER schema.sql
-- ============================================================

-- Sellers
INSERT INTO seller (seller_name, email, phone, rating) VALUES
('TechNova Electronics', 'sales@technova.com', '+2348011110001', 4.7),
('FashionHub NG', 'contact@fashionhub.ng', '+2348022220002', 4.3),
('HomeComfort Ltd', 'info@homecomfort.com', '+2348033330003', 4.5),
('GadgetWorld', 'hello@gadgetworld.ng', '+2348044440004', 4.1);

-- Customers
INSERT INTO customer (full_name, email, phone, address_line1, city, state, postal_code) VALUES
('Chinedu Okafor', 'chinedu.okafor@email.com', '+2347011111111', '12 Admiralty Way', 'Lekki', 'Lagos', '105102'),
('Amina Yusuf', 'amina.yusuf@email.com', '+2347022222222', '45 Ahmadu Bello Way', 'Kaduna', 'Kaduna', '800001'),
('Tunde Bakare', 'tunde.bakare@email.com', '+2347033333333', '8 Ring Road', 'Ibadan', 'Oyo', '200212'),
('Fatima Bello', 'fatima.bello@email.com', '+2347044444444', '22 Garki Area 11', 'Abuja', 'FCT', '900211'),
('Emeka Nwosu', 'emeka.nwosu@email.com', '+2347055555555', '3 Trans Amadi', 'Port Harcourt', 'Rivers', '500001'),
('Zainab Ibrahim', 'zainab.ibrahim@email.com', '+2347066666666', '17 Kano Road', 'Kano', 'Kano', '700001'),
('David Okoro', 'david.okoro@email.com', '+2347077777777', '9 Independence Layout', 'Enugu', 'Enugu', '400001');

-- Categories
INSERT INTO category (category_name) VALUES
('Electronics'),
('Fashion'),
('Home & Kitchen'),
('Mobile Accessories'),
('Audio'),
('Computers');

-- Products
INSERT INTO product (seller_id, product_name, description, price, stock_qty) VALUES
(1, 'Wireless Noise-Cancelling Headphones', 'Bluetooth 5.2, 30hr battery, ANC', 129.99, 45),
(1, 'USB-C Fast Charger 65W', 'GaN technology, multi-port', 34.99, 120),
(1, 'Smart Watch Pro Series', 'Heart rate, SpO2, GPS, 7-day battery', 199.99, 28),
(2, 'Men''s Casual Sneakers', 'Breathable mesh, sizes 40-46', 59.99, 80),
(2, 'Women''s Ankara Print Dress', '100% cotton, free size', 45.50, 35),
(3, 'Non-Stick Cookware Set (5pcs)', 'Ceramic coating, induction compatible', 89.99, 22),
(3, 'Memory Foam Pillow', 'Orthopedic, hypoallergenic', 29.99, 60),
(4, 'Portable Bluetooth Speaker', 'IPX7 waterproof, 20W output', 49.99, 55),
(4, 'Laptop Stand Aluminium', 'Adjustable height, ventilation', 39.99, 40),
(1, 'Wireless Mouse Ergonomic', 'Silent clicks, 2.4GHz + Bluetooth', 24.99, 95);

-- Product Categories (many-to-many)
INSERT INTO product_category (product_id, category_id) VALUES
(1, 1), (1, 5),          -- Headphones -> Electronics, Audio
(2, 1), (2, 4),          -- Charger -> Electronics, Mobile Accessories
(3, 1),                  -- Smart Watch -> Electronics
(4, 2),                  -- Sneakers -> Fashion
(5, 2),                  -- Dress -> Fashion
(6, 3),                  -- Cookware -> Home & Kitchen
(7, 3),                  -- Pillow -> Home & Kitchen
(8, 1), (8, 5),          -- Speaker -> Electronics, Audio
(9, 1), (9, 6),          -- Laptop Stand -> Electronics, Computers
(10,1), (10,6);          -- Mouse -> Electronics, Computers

-- Orders
INSERT INTO "order" (customer_id, order_date, status, total_amount) VALUES
(1, '2026-09-15 10:23:00', 'Delivered', 164.98),
(2, '2026-09-18 14:05:00', 'Shipped', 199.99),
(3, '2026-09-20 09:12:00', 'Paid', 89.99),
(1, '2026-09-22 16:40:00', 'Pending', 94.98),
(4, '2026-09-25 11:30:00', 'Delivered', 45.50),
(5, '2026-09-28 13:15:00', 'Cancelled', 129.99),
(6, '2026-10-01 08:50:00', 'Paid', 74.98),
(7, '2026-10-03 17:22:00', 'Shipped', 239.98);

-- Order Items
INSERT INTO order_item (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 129.99), (1, 2, 1, 34.99),
(2, 3, 1, 199.99),
(3, 6, 1, 89.99),
(4, 4, 1, 59.99), (4, 10, 1, 24.99) + (4, 2, 1, 9.99), -- wait, fix later if needed
(5, 5, 1, 45.50),
(6, 1, 1, 129.99),
(7, 8, 1, 49.99), (7, 10, 1, 24.99),
(8, 3, 1, 199.99), (8, 9, 1, 39.99);

-- Fix the accidental syntax in previous insert - clean version below
DELETE FROM order_item;
INSERT INTO order_item (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 129.99),
(1, 2, 1, 34.99),
(2, 3, 1, 199.99),
(3, 6, 1, 89.99),
(4, 4, 1, 59.99),
(4, 10, 1, 24.99),
(4, 2, 1, 9.99),   -- note: price adjusted for demo
(5, 5, 1, 45.50),
(6, 1, 1, 129.99),
(7, 8, 1, 49.99),
(7, 10, 1, 24.99),
(8, 3, 1, 199.99),
(8, 9, 1, 39.99);

-- Payments
INSERT INTO payment (order_id, amount, payment_method, payment_status, paid_at) VALUES
(1, 164.98, 'Card', 'Completed', '2026-09-15 10:25:00'),
(2, 199.99, 'Bank Transfer', 'Completed', '2026-09-18 14:10:00'),
(3, 89.99, 'Card', 'Completed', '2026-09-20 09:15:00'),
(4, 94.98, 'Card', 'Pending', NULL),
(5, 45.50, 'USSD', 'Completed', '2026-09-25 11:32:00'),
(6, 129.99, 'Card', 'Refunded', '2026-09-28 15:00:00'),
(7, 74.98, 'Card', 'Completed', '2026-10-01 08:55:00'),
(8, 239.98, 'Bank Transfer', 'Completed', '2026-10-03 17:25:00');

-- Deliveries
INSERT INTO delivery (order_id, courier_name, tracking_number, status, estimated_date, delivered_at) VALUES
(1, 'GIG Logistics', 'GIG998877', 'Delivered', '2026-09-18', '2026-09-17 14:20:00'),
(2, 'DHL Express', 'DHL554433', 'In Transit', '2026-09-25', NULL),
(3, 'Kwik Delivery', 'KWIK112233', 'Preparing', '2026-09-24', NULL),
(5, 'GIG Logistics', 'GIG887766', 'Delivered', '2026-09-28', '2026-09-27 11:00:00'),
(7, 'GIG Logistics', 'GIG445566', 'In Transit', '2026-10-05', NULL),
(8, 'DHL Express', 'DHL998877', 'Out for Delivery', '2026-10-07', NULL);

-- Reviews
INSERT INTO review (product_id, customer_id, rating, comment) VALUES
(1, 1, 5, 'Excellent noise cancellation and battery life.'),
(3, 2, 4, 'Good features but a bit heavy on the wrist.'),
(6, 3, 5, 'Very durable and heats evenly.'),
(5, 4, 4, 'Beautiful print, fits well.'),
(8, 6, 5, 'Loud and clear sound, highly recommended.'),
(10,1, 4, 'Comfortable and responsive.');

-- Update order totals to match items (for consistency)
UPDATE "order" o
SET total_amount = (
    SELECT COALESCE(SUM(line_total), 0)
    FROM order_item oi
    WHERE oi.order_id = o.order_id
);

-- ============================================================
-- End of sample data
-- ============================================================
