-- total number of trips ending in service_zones 'Airports' or 'EWR'

select count(*) as trips_num_to_airports
from {{ ref('mart__fact_all_taxi_trips') }} as trips
join {{ ref('mart__dim_locations') }} as locations
on cast(trips.dolocationid as int) = locations.locationid
where service_zone in ('EWR','Airports');
