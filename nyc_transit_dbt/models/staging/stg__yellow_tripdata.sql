-- Create a list of staging commands to translate SQL commandes that modifies data type and column name 

with source as (
    select * from {{ source('main','yellow_tripdata') }}

),
renamed as (
    select 
        VendorID,
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        passenger_count,
        trip_distance,
        case when store_and_fwd_flag = 'Y' then TRUE else FALSE end as store_and_fwd_flag,
        RatecodeID::double as rate_code_id,
        PUlocationID,
        DOlocationID,
        passenger_count,
        trip_distance,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        total_amount,
        payment_type::integer as payment_type,
        airport_fee,
        congestion_surcharge,
        improvement_surcharge
        filename
    from source
)

select * from renamed