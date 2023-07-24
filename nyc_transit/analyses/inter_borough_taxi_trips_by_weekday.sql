-- by weekday, 
-- count of total trips, trips starting and ending in a different borough, and 
-- percentage w/ different start/end

with trips_by_weekday as (
    select 
        date_part('dow', pickup_datetime) as weekday,
        count(*) as trips_num
    from {{ ref('mart__fact_all_taxi_trips') }}
    group by 1
),

trips_by_weekday_and_borough as (
    select 
        date_part('dow', pickup_datetime) as weekday,
        count(*) as trips_num
    from {{ ref('mart__fact_all_taxi_trips') }}
    join {{ ref('mart__dim_locations') }} on locationid = dolocationid
    join {{ ref('mart__dim_locations') }} as pl on pulocationid = pl.locationid
    join {{ ref('mart__dim_locations') }} as dl on dolocationid = dl.locationid
    where pickup_loc.borough <> dropoff_loc.borough
    group by weekday
)

select 
    trips_by_weekday.weekday,
    trips_by_weekday.trips_num,
    trips_by_weekday_and_borough.trips_num_diff_boroughs,
    trips_by_weekday_and_borough.trips_num_diff_boroughs / trips_by_weekday.trips_num * 100 as trips_pct_diff_boroughs
from trips_by_weekday
join trips_by_weekday_and_borough
on trips_by_weekday.weekday = trips_by_weekday_and_borough.weekday;