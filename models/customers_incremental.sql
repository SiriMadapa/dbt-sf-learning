{{ config(
    materialized='incremental',
    unique_key='customer_id'
) }}

with source as (
    select
        c2 as customer_id,
        c3 as first_name,
        c4 as last_name,
        concat(c3, ' ', c4) as customer_name,
        c5 as email,
        c6 as birthdate,
        c7 as billing_address,
        c8 as cc,
    from INTERNAL_TRAINING.PRACTICE_TEST.customers
    {% if is_incremental() %}
        where c2 not in (select customer_id from {{ this }})
    {% endif %}
)

select *
from source

