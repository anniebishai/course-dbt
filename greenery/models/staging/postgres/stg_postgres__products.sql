with src_products as ( 
    select * from {{source('postgres', 'products') }}
)

, renamed_recast as (
    select
        product_id as product_guid
        , name as product_name
        , price as price_usd
        , inventory as inventory_qty
    from src_products
)

select * from renamed_recast