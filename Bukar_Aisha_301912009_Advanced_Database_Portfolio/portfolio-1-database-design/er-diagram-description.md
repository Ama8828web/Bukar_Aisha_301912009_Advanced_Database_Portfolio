# Entity-Relationship Diagram Description
**ShopEase Online Marketplace**  
**Student:** Aisha Ali Bukar | ID: 301912009

## Textual Description of Relationships

| Entity A     | Cardinality | Entity B        | Relationship Description                     |
|--------------|-------------|-----------------|----------------------------------------------|
| SELLER       | 1 : M       | PRODUCT         | A seller lists many products                 |
| CUSTOMER     | 1 : M       | ORDER           | A customer places many orders                |
| ORDER        | 1 : M       | ORDER_ITEM      | An order contains many line items            |
| PRODUCT      | 1 : M       | ORDER_ITEM      | A product can appear in many order items     |
| ORDER        | 1 : 1       | PAYMENT         | Each order has one payment record            |
| ORDER        | 1 : 1       | DELIVERY        | Each order has one delivery record           |
| PRODUCT      | M : M       | CATEGORY        | Products belong to multiple categories       |
| CUSTOMER     | 1 : M       | REVIEW          | A customer can write many reviews            |
| PRODUCT      | 1 : M       | REVIEW          | A product can receive many reviews           |

## Mermaid ER Diagram Code
Copy the code below into any Mermaid live editor (mermaid.live) or VS Code Mermaid extension to generate the visual diagram. Export as PNG/SVG for submission.

```mermaid
erDiagram
    SELLER ||--o{ PRODUCT : "lists"
    CUSTOMER ||--o{ ORDER : "places"
    ORDER ||--|{ ORDER_ITEM : "contains"
    PRODUCT ||--o{ ORDER_ITEM : "appears_in"
    ORDER ||--|| PAYMENT : "has"
    ORDER ||--|| DELIVERY : "has"
    PRODUCT }o--o{ CATEGORY : "belongs_to"
    CUSTOMER ||--o{ REVIEW : "writes"
    PRODUCT ||--o{ REVIEW : "receives"

    SELLER {
        int seller_id PK
        string seller_name
        string email UK
        decimal rating
    }
    CUSTOMER {
        int customer_id PK
        string full_name
        string email UK
        string city
    }
    PRODUCT {
        int product_id PK
        int seller_id FK
        string product_name
        decimal price
        int stock_qty
    }
    CATEGORY {
        int category_id PK
        string category_name UK
    }
    ORDER {
        int order_id PK
        int customer_id FK
        timestamp order_date
        string status
        decimal total_amount
    }
    ORDER_ITEM {
        int order_item_id PK
        int order_id FK
        int product_id FK
        int quantity
        decimal unit_price
        decimal line_total
    }
    PAYMENT {
        int payment_id PK
        int order_id FK
        decimal amount
        string payment_status
    }
    DELIVERY {
        int delivery_id PK
        int order_id FK
        string tracking_number
        string status
    }
    REVIEW {
        int review_id PK
        int product_id FK
        int customer_id FK
        int rating
    }
```

## How to produce the final diagram image
1. Go to https://mermaid.live
2. Paste the Mermaid code above
3. Export as PNG or SVG
4. Save the image as `ER_Diagram_ShopEase.png` inside this folder
5. Reference the image in your LMS documentation and GitHub README
