with cte as (

    select *
    from {{ source('demo', 'bike') }}

)

select *
from cte
limit 5