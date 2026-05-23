WITH CTE AS (

    select
        TRY_TO_TIMESTAMP(STARTED_AT) AS STARTED_AT,
        TO_DATE(TRY_TO_TIMESTAMP(STARTED_AT)) AS DATE_STARTED_AT,
        HOUR(TRY_TO_TIMESTAMP(STARTED_AT)) AS HOUR_STARTED_AT,

        CASE
            WHEN DAYNAME(TRY_TO_TIMESTAMP(STARTED_AT)) in ('Sat', 'Sun')
                THEN 'WEEKEND'
            ELSE 'BUSINESSDAY'
        END AS DAY_TYPE,

        CASE
            WHEN MONTH(TRY_TO_TIMESTAMP(STARTED_AT)) in (12, 1, 2)
                THEN 'WINTER'
            WHEN MONTH(TRY_TO_TIMESTAMP(STARTED_AT)) in (3, 4, 5)
                THEN 'SPRING'
            WHEN MONTH(TRY_TO_TIMESTAMP(STARTED_AT)) in (6, 7, 8)
                THEN 'SUMMER'
            ELSE 'AUTUMN'
        END AS SEASON_OF_YEAR

    from {{ ref('stg_bike') }}

    where TRY_TO_TIMESTAMP(STARTED_AT) is not null
)

select *
from CTE



///3datedimensions

WITH CTE AS (

select

STARTED_AT,
TO_TIMESTAMP(STARTED_AT)
from 
{{ source('demo', 'bike') }}
where STARTED_AT != 'started_at'
)

select 

*

from CTE

//date_dimesnioon
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
        end as station_of_year,

        {{get_season(date_column))}}

    from {{ source('demo', 'bike') }}

    where try_to_timestamp(replace(started_at, '"', '')) is not null

)

select *
from cte