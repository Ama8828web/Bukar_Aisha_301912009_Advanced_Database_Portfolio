-- ============================================================
-- Portfolio 1: Database Design and Modelling
-- Student: Aisha Ali Bukar | ID: 301912009
-- Case Study: ShopEase Online Marketplace
-- Database: PostgreSQL (recommended)
-- ============================================================

-- Drop existing objects if re-running (safe for development)
DROP TABLE IF EXISTS review CASCADE;
DROP TABLE IF EXISTS delivery CASCADE;
DROP TABLE IF EXISTS payment CASCADE;
DROP TABLE IF EXISTS order_item CASCADE;
DROP TABLE IF EXISTS "order" CASCADE;
DROP TABLE IF EXISTS product_category CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS seller CASCADE;

-- ------------------------------------------------------------
-- SELLER
-- ------------------------------------------------------------
CREATE TABLE seller (
    seller_id       SERIAL PRIMARY KEY,
    seller_name     VARCHAR(150) NOT NULL,
    email           VARCHAR(120) UNIQUE NOT NULL,
    phone           VARCHAR(20),
    rating          DECIMAL(3,2) DEFAULT 0.00 CHECK (rating BETWEEN 0 AND 5),
    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ------------------------------------------------------------
-- CUSTOMER
-- ------------------------------------------------------------
CREATE TABLE customer (
    customer_id     SERIAL PRIMARY KEY,
    full_name       VARCHAR(120) NOT NULL,
    email           VARCHAR(120) UNIQUE NOT NULL,
    phone           VARCHAR(20),
    address_line1   VARCHAR(200),
    city            VARCHAR(80),
    state           VARCHAR(80),
    postal_code     VARCHAR(15),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ------------------------------------------------------------
-- CATEGORY
-- ------------------------------------------------------------
CREATE TABLE category (
    category_id     SERIAL PRIMARY KEY,
    category_name   VARCHAR(80) UNIQUE NOT NULL
);

-- ------------------------------------------------------------
-- PRODUCT
-- ------------------------------------------------------------
CREATE TABLE product (
    product_id      SERIAL PRIMARY KEY,
    seller_id       INT NOT NULL REFERENCES seller(seller_id),
    product_name    VARCHAR(200) NOT NULL,
    description     TEXT,
    price           DECIMAL(12,2) NOT NULL CHECK (price > 0),
    stock_qty       INT NOT NULL DEFAULT 0 CHECK (stock_qty >= 0),
    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_product_seller ON product(seller_id);
CREATE INDEX idx_product_stock  ON product(stock_qty) WHERE stock_qty < 20;  -- partial index for low-stock alerts

-- ------------------------------------------------------------
-- PRODUCT_CATEGORY (Many-to-Many)
-- ------------------------------------------------------------
CREATE TABLE product_category (
    product_id      INT NOT NULL REFERENCES product(product_id) ON DELETE CASCADE,
    category_id     INT NOT NULL REFERENCES category(category_id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, category_id)
);

-- ------------------------------------------------------------
-- ORDER  (quoted because ORDER is a reserved word)
-- ------------------------------------------------------------
CREATE TABLE "order" (
    order_id        SERIAL PRIMARY KEY,
    customer_id     INT NOT NULL REFERENCES customer(customer_id),
    order_date      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status          VARCHAR(30) NOT NULL DEFAULT 'Pending'
                    CHECK (status IN ('Pending','Paid','Shipped','Delivered','Cancelled','Returned')),
    total_amount    DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (total_amount >= 0)
);

CREATE INDEX idx_order_customer ON "order"(customer_id);
CREATE INDEX idx_order_date     ON "order"(order_date);
CREATE INDEX idx_order_status   ON "order"(status);

-- ------------------------------------------------------------
-- ORDER_ITEM
-- ------------------------------------------------------------
CREATE TABLE order_item (
    order_item_id   SERIAL PRIMARY KEY,
    order_id        INT NOT NULL REFERENCES "order"(order_id) ON DELETE CASCADE,
    product_id      INT NOT NULL REFERENCES product(product_id),
    quantity        INT NOT NULL CHECK (quantity > 0),
    unit_price      DECIMAL(12,2) NOT NULL CHECK (unit_price > 0),
    -- Generated column avoids update anomalies
    line_total      DECIMAL(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED
);

CREATE INDEX idx_order_item_order   ON order_item(order_id);
CREATE INDEX idx_order_item_product ON order_item(product_id);

-- ------------------------------------------------------------
-- PAYMENT
-- ------------------------------------------------------------
CREATE TABLE payment (
    payment_id      SERIAL PRIMARY KEY,
    order_id        INT UNIQUE NOT NULL REFERENCES "order"(order_id),
    amount          DECIMAL(12,2) NOT NULL CHECK (amount > 0),
    payment_method  VARCHAR(30) NOT NULL,
    payment_status  VARCHAR(20) DEFAULT 'Pending'
                    CHECK (payment_status IN ('Pending','Completed','Failed','Refunded')),
    paid_at         TIMESTAMP
);

-- ------------------------------------------------------------
-- DELIVERY
-- ------------------------------------------------------------
CREATE TABLE delivery (
    delivery_id     SERIAL PRIMARY KEY,
    order_id        INT UNIQUE NOT NULL REFERENCES "order"(order_id),
    courier_name    VARCHAR(80),
    tracking_number VARCHAR(50),
    status          VARCHAR(30) DEFAULT 'Preparing'
                    CHECK (status IN ('Preparing','In Transit','Out for Delivery','Delivered','Failed')),
    estimated_date  DATE,
    delivered_at    TIMESTAMP
);

-- ------------------------------------------------------------
-- REVIEW
-- ------------------------------------------------------------
CREATE TABLE review (
    review_id       SERIAL PRIMARY KEY,
    product_id      INT NOT NULL REFERENCES product(product_id),
    customer_id     INT NOT NULL REFERENCES customer(customer_id),
    rating          SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment         TEXT,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (product_id, customer_id)   -- one review per customer per product
);

CREATE INDEX idx_review_product ON review(product_id);

-- ============================================================
-- End of schema
-- ============================================================
