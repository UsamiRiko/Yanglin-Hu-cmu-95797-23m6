-- "number of trips grouped by borough"

select count(*) as trips_num, borough
from {{ ref('mart__dim_locations') }} t
join {{ ref('mart__fact_all_taxi_trips') }}  as a
on a.pulocationID = t.locationID
group by borough