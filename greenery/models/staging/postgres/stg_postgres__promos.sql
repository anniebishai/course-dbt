with src_promos as (
    select * from {{ source('postgres', 'promos') }}
)

, renamed_recast as (
    SELECT
        promo_id as promo_description
        , discount
        , status
    FROM src_promos
)

select * from renamed_recast