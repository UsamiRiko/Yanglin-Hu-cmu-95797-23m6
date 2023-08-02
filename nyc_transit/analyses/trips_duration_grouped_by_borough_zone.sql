-- Calculate the number of trips and average duration by borough and zone
select b.borough, b.zone, count(*) as trip_num, round(avg(a.duration_min), 2) as avg_duration_min
from {{ ref('mart__fact_all_taxi_trips') }}  as a
join {{ ref('mart__dim_locations') }}  as b
on b.locationID = a.pulocationID
group by b.borough, b.zone