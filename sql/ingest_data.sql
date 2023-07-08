-- Ingest data into the database for tables in raw-tables.txt
-- for convenience, we put duckdb.exe inside the working directory

-- select all files with some patterned names
CREATE TABLE bike_data AS SELECT * FROM read_csv_auto('data\bike\*-citibike-tripdata.csv.gz', all_varchar=1, union_by_name=True, filename=True);

-- ingest files not inside a folder
CREATE TABLE central_park_weather AS SELECT * FROM read_csv_auto('data\central_park_weather.csv', all_varchar=1, filename=True);
CREATE TABLE daily_citi_bike_trip_counts_and_weather AS SELECT * FROM read_csv_auto('data\daily_citi_bike_trip_counts_and_weather.csv', all_varchar=1, filename=True);
CREATE TABLE fhv_bases AS SELECT * FROM read_csv_auto('data\fhv_bases.csv', all_varchar=1, filename=True, header=True);

-- ingest te parqeuet files
CREATE TABLE fhv_tripdata AS SELECT * FROM read_parquet('data\taxi\fhv_tripdata_*.parquet', union_by_name=True, filename=True);
CREATE TABLE fhvhv_tripdata AS SELECT * FROM read_parquet('data\taxi\fhvhv_tripdata_*.parquet', union_by_name=True, filename=True);
CREATE TABLE green_tripdata AS SELECT * FROM read_parquet('data\taxi\green_tripdata_*.parquet', union_by_name=True, filename=True);
CREATE TABLE yellow_tripdata AS SELECT * FROM read_parquet('data\taxi\yellow_tripdata_*.parquet', union_by_name=True, filename=True);



