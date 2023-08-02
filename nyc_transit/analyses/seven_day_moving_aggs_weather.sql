select date,
       min(prcp) over seven_days as min_prcp,
       max(prcp) over seven_days as max_prcp,
       avg(prcp) over seven_days as avg_prcp,
       sum(prcp) over seven_days as sum_prcp,
       min(snow) over seven_days as min_snow,
       max(snow) over seven_days as max_snow,
       avg(snow) over seven_days as avg_snow,
       sum(snow) over seven_days as sum_snow
from {{ ref('stg__central_park_weather')}}
window seven_days as (
    order by date asc
    range between interval 3 days preceding and interval 3 days following)