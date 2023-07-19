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
        CASE WHEN shared_request_flag = 'Y' THEN TRUE ELSE FALSE END AS shared_request_flag,
        CASE WHEN shared_match_flag = 'Y' THEN TRUE ELSE FALSE END AS shared_match_flag,
        CASE WHEN access_a_ride_flag = ' ' THEN TRUE ELSE FALSE END AS access_a_ride_flag,
        CASE WHEN wav_request_flag = 'Y' THEN TRUE ELSE FALSE END AS wav_request_flag,
        CASE WHEN wav_match_flag = 'Y' THEN TRUE ELSE FALSE END AS wav_match_flag,
        filename

    from source

)

select * from renamed