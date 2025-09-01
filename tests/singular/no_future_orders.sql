-- Fail if any orders have future dates
select *
from {{ ref('stg_orders_ephemeral') }}
where order_date > current_date
