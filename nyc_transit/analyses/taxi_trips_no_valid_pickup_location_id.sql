-- Make a query which finds taxi trips which don’t have a pick up location_id in the locations table
select a.*
from {{ ref('mart__fact_all_taxi_trips') }}  as a
left join {{ ref('mart__dim_locations') }}  as b
on b.locationID = a.pulocationID
where b.locationID is null