WITH stg_orders AS (
    SELECT * FROM {{ ref('stg_postgres__orders') }} 
),

stg_order_items AS (
    SELECT 
        order_guid,
        SUM(quantity) AS total_items,
        COUNT(DISTINCT product_guid) AS unique_items
    FROM {{ ref('stg_postgres__order_items') }}
    GROUP BY 1
),

stg_users AS (
    SELECT * FROM {{ ref('stg_postgres__users') }}
)

SELECT
    stg_orders.*,
    total_items,
    unique_items,
    CONCAT(first_name, ' ', last_name) AS user_name
FROM stg_orders
JOIN stg_order_items 
ON stg_orders.order_guid = stg_order_items.order_guid
JOIN stg_users
ON stg_orders.user_guid = stg_users.user_guid

