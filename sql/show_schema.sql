-- save info of all tables into a txt file
.echo on 
.output answers/show_schema.txt

--Show all tables
SHOW TABLES;

--Show all info of each table
DESCRIBE bike_data;
DESCRIBE central_park_weather;
DESCRIBE daily_citi_bike_trip_counts_and_weather;
DESCRIBE fhv_bases;
DESCRIBE fhvhv_tripdata;
DESCRIBE green_tripdata;
DESCRIBE yellow_tripdata;