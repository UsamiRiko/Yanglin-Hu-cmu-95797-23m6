-- Write a query to compare an individual fare to the zone, borough and overall 
-- average fare using the fare_amount in yellow taxi trip data
select 
    y.fare_amount,
    avg(y.fare_amount) over (partition by t.zone) as zone_avg_fare,
    avg(y.fare_amount) over (partition by t.borough) as borough_avg_fare,
    avg(y.fare_amount) over () as overall_avg_fare
from  {{ ref('stg__yellow_tripdata') }} as y
join {{ ref('mart__dim_locations') }} as t
on y.pulocationID = t.locationID