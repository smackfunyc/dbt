WITH BIKE as (

select 
distinct
START_STATIO_ID AS station_id,
start_station_name as station_name,
start_lat as station_lat,
start_lng as station_long


from {{ source('demo', 'bike') }}

WHERE RIDE_ID != 'ride_id'


)

select
*
from BIKE