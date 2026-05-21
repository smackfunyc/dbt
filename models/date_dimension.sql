with cte as (

    select
        try_to_timestamp(replace(started_at, '"', '')) as started_at,
        date(try_to_timestamp(replace(started_at, '"', ''))) as date_started_at,
        hour(try_to_timestamp(replace(started_at, '"', ''))) as hour_started_at,

        case
            when dayname(try_to_timestamp(replace(started_at, '"', ''))) in ('Sat', 'Sun')
                then 'WEEKEND'
            else 'BUSINESSDAY'
        end as day_type,

        month(try_to_timestamp(replace(started_at, '"', ''))) as month_started_at,

        case
            when month(try_to_timestamp(replace(started_at, '"', ''))) in (12, 1, 2)
                then 'WINTER'
            when month(try_to_timestamp(replace(started_at, '"', ''))) in (3, 4, 5)
                then 'SPRING'
            when month(try_to_timestamp(replace(started_at, '"', ''))) in (6, 7, 8)
                then 'SUMMER'
            else 'AUTUMN'
        end as station_of_year

    from {{ source('demo', 'bike') }}

    where try_to_timestamp(replace(started_at, '"', '')) is not null

)

select *
from cte