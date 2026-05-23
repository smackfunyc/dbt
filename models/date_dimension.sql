with cte as (

    select
        try_to_timestamp(replace(started_at, '"', '')) as started_at,
        date(try_to_timestamp(replace(started_at, '"', ''))) as date_started_at,
        hour(try_to_timestamp(replace(started_at, '"', ''))) as hour_started_at,

        {{ get_day_type("try_to_timestamp(replace(started_at, '\"', ''))") }} as day_type,

        month(try_to_timestamp(replace(started_at, '"', ''))) as month_started_at,

        {{ get_season("try_to_timestamp(replace(started_at, '\"', ''))") }} as season_of_year

    from {{ source('demo', 'bike') }}

    where try_to_timestamp(replace(started_at, '"', '')) is not null

)

select *
from cte