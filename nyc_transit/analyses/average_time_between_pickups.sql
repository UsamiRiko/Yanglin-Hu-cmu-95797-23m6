-- Use lead or lag to find the next trip per zone for each record
-- then find the time difference between the pick up time for the current record and the next
-- then use this result to calculate the average time between pick ups per zone
with next_trip_per_zone as (
    select 
        pulocationID,
        pickup_datetime,
        lead(pickup_datetime) over (order by pickup_datetime) as next_pickup_datetime
    from {{ ref('mart__fact_all_taxi_trips') }} as y
    
),

diff_between_pickups as (
    select 
        *,
        datediff('second', pickup_datetime, next_pickup_datetime) as time_between_pickups
    from next_trip_per_zone
)

select 
    t.zone,
    avg(y.time_between_pickups) as avg_time_between_pickups
from diff_between_pickups as y
join {{ ref('mart__dim_locations') }} as t
on y.pulocationID = t.locationID
group by t.zone
order by avg_time_between_pickups desc

