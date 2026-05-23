WITH cleaned_trips AS (
  select 
    -- 1. Grab the actual trip duration directly (stored in RIDE_ID)
    TRY_TO_NUMBER(REPLACE(RIDE_ID, '"', '')) as RAW_DURATION_SECONDS,
    
    -- 2. Clean and parse the true START timestamp from RIDEABLE_TYPE
    TRY_TO_TIMESTAMP(REPLACE(RIDEABLE_TYPE, '"', ''), 'YYYY-MM-DD HH24:MI:SS.FF') AS start_timestamp,
    
    -- 3. Clean and parse the true END timestamp from STARTED_AT
    TRY_TO_TIMESTAMP(REPLACE(STARTED_AT, '"', ''), 'YYYY-MM-DD HH24:MI:SS.FF') AS end_timestamp,
    
    -- Correcting the rest of your shifted station columns
    ENDED_AT AS START_STATION_ID,
    END_STATION_ID,
    MEMBER_CSUAL AS MEMBER_CASUAL

  from {{ source('demo', 'bike') }}

  -- Filter out the text header rows mixed into the data
  WHERE RIDE_ID != 'ride_id'
    AND RIDEABLE_TYPE NOT LIKE '%starttime%'
    AND STARTED_AT NOT LIKE '%stoptime%'
),

final AS (
  select
    -- FIXED: Create TRIP_DATE here using your cleaned start_timestamp
    DATE(start_timestamp) AS TRIP_DATE,
    
    START_STATION_ID,
    END_STATION_ID,
    MEMBER_CASUAL,
    start_timestamp,
    end_timestamp,
    
    -- Calculate the exact duration in seconds
    TIMESTAMPDIFF(SECOND, start_timestamp, end_timestamp) AS TRIP_DURATION_SECONDS
  from cleaned_trips
)

select * from final