with src_order_items as (
    select * from {{ source('postgres', 'order_items') }}
)

, renamed_recast as ( 
    select
        ORDER_ID as order_guid
        , PRODUCT_ID as product_guid
        , QUANTITY
    from src_order_items
)

select * from renamed_recast