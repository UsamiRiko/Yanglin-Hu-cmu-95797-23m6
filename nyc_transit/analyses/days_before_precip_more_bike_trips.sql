-- Write a query to determine if days immediately preceding precipitation or snow 
-- had more bike trips on average than the days with precipitation or snow.
WITH daily_trips AS (
    SELECT 
        date,
        trips,
        precipitation,
        snowfall,
        LAG(trips) OVER (ORDER BY date) AS previous_day_trips,
        LAG(precipitation) OVER (ORDER BY date) AS previous_day_precipitation,
        LAG(snowfall) OVER (ORDER BY date) AS previous_day_snowfall
    FROM {{ ref('stg__daily_citi_bike_trip_counts_and_weather')}}
),

trips_comparison AS (
    SELECT
        date,
        CASE 
            WHEN (precipitation > 0 OR snowfall > 0) AND previous_day_trips IS NOT NULL THEN 'current_day'
            WHEN (previous_day_precipitation > 0 OR previous_day_snowfall > 0) AND trips IS NOT NULL THEN 'previous_day'
            ELSE NULL
        END AS comparison_group,
        CASE
            WHEN (precipitation > 0 OR snowfall > 0) AND previous_day_trips IS NOT NULL THEN trips
            WHEN (previous_day_precipitation > 0 OR previous_day_snowfall > 0) AND trips IS NOT NULL THEN previous_day_trips
            ELSE NULL
        END AS trips
    FROM daily_trips
)

SELECT
    comparison_group,
    AVG(trips) AS average_trips
FROM trips_comparison
WHERE comparison_group IS NOT NULL
GROUP BY comparison_group;
