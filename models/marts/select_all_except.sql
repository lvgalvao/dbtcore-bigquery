-- models/select_all_except.sql

select
    {{ dbt_utils.star(from=ref('stg_orders'), except=["created_at", "updated_at"]) }}
from
    {{ ref('stg_orders') }}
