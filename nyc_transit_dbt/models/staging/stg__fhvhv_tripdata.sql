with source as (
    select * from {{ source('main', 'fhvhv_tripdata') }}
),

renamed as (
    select
        hvfhs_license_num,
        dispatching_base_num,
        originating_base_num,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropoff_datetime,
        pulocationid,
        dolocationid,
        trip_miles,
        trip_time,
        base_passenger_fare,
        tolls,
        bcf,
        sales_tax,
        congestion_surcharge,
        airport_fee,
        tips,
        driver_pay,
        case when shared_request_flag = 'Y' then true else false end as shared_request_flag,
        case when shared_match_flag = 'Y' then true else false end as shared_match_flag,
        case when access_a_ride_flag = 'Y' then true else false end as access_a_ride_flag,
        case when wav_request_flag = 'Y' then true else false end as wav_request_flag,
        case when wav_match_flag = 'Y' then true else false end as wav_match_flag,

        filename
    from source
)

select * from renamed