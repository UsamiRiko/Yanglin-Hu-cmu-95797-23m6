select date,
       prcp,
       avg(prcp) over (order by date rows between 3 preceding and 3 following) as moving_avg_prcp
from {{ ref('stg__central_park_weather') }}
order by date