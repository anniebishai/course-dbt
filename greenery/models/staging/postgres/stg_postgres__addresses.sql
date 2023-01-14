with src_addresses as (
    select * from {{ source('postgres', 'addresses') }}
)

, renamed_recast as ( 
    select 
        ADDRESS_ID as address_guid
      ,  ADDRESS
      ,  ZIPCODE
      ,  STATE
      ,  COUNTRY
    from src_addresses
)

select * from renamed_recast