with source as (
    select * from {{ source('main', 'bike_data') }}
),

renamed as (
    select
        (case when starttime is null then started_at else starttime end)::int as started_at,
        (case when stoptime is null then ended_at else stoptime end)::int as ended_at,
        case when "start station id" is null then start_station_id else "start station id" end as start_station_id,
        case when "start station name" is null then start_station_name else "start station name" end as start_station_name,
        case when "end station id" is null then end_station_id else "end station id" end as end_station_id,
        case when "end station name" is null then end_station_name else "end station name" end as end_station_name,
        (case when "start station latitude" is null then start_lat else "start station latitude" end)::double as start_lat,
        (case when "start station longitude" is null then start_lng else "start station longitude" end)::double as start_lng,
        (case when "end station latitude" is null then end_lat else "end station latitude" end)::double as end_lat,
        (case when "end station longitude" is null then end_lng else "end station longitude" end)::double as end_lng,
        tripduration::double as tripduration,
        bikeid::int as bikeid,
        usertype,
        "birth year"::int as "birth year",
        gender::int as gender,
        ride_id,
        rideable_type,
        member_casual,
        filename
    from source
)

select * from renamed