WITH stg_users AS (
    SELECT * FROM {{ ref('_stg_postgres__users') }}
)

, stg_addresses AS (
    SELECT * FROM {{ ref('_stg_postgres__addresses') }}
)
, stg_orders AS (
    SELECT 
        user_guid 
        , COUNT(*) AS n_orders
        , MAX(created_at_utc) AS last_order_created_at_utc
    FROM {{ ref('_stg_postgres__orders') }}
    GROUP BY 1
)


SELECT
    stg_users.*
    , stg_addresses.* EXCEPT(address_guid)
    , stg_orders.* EXCEPT(user_guid)
FROM stg_users
LEFT OUTER JOIN stg_addresses
ON stg_addresses.address_guid = stg_users.address_guid
LEFT OUTER JOIN stg_orders
ON stg_orders.user_guid = stg_users.user_guid