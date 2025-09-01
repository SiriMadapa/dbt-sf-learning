-- Fail if orders reference non-existing customers
select o.customer_id
from {{ ref('stg_orders_ephemeral') }} o
left join {{ ref('stg_customers') }} c
  on o.customer_id = c.customer_id
where c.customer_id is null
