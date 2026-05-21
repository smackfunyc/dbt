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