-- Write a query which finds all the Zones where there are less than 100000 trips

select t.zone, count(*) as trips_num
from {{ ref('mart__fact_all_taxi_trips') }} a
join {{ ref('mart__dim_locations') }} t
on a.pulocationID = t.locationID
group by t.zone
having trips_num < 100000


