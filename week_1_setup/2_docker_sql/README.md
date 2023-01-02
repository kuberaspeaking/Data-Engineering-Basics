# What did I do today - Day 1

## Explore docker
- docker build and run
- docker with specific environment (python:3.9)
- docker with env and entrypoint (bash)
- run a simple python file when you run docker image with `ENTRYPOINT [ "python" , "pipeline.py" ]`

## Postgres

- Run an image of postgres that we will be using inside Airflow
- command used `docker run -it -e POSTGRES_USER="root" -e POSTGRES_PASSWORD="root" -e POSTGRES_DB="ny_taxi" -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data -p 5432:5432 postgres:13`
- use `pgcli` to interact with postgres `pgcli -h localhost -p 5432 -u root -d ny_taxi`
  
## Dataset

- Download [NY taxi data](https://github.com/DataTalksClub/nyc-tlc-data)
- run Jupyter notebook and use pandas to explore dataset
- `head -n 100 yellow_tripdata_2021-01.csv > yellow_head.csv` will sample your csv file to 100 entries and save the sample as a new file. 
- get schema of this data with the following command `print(pd.io.sql.get_schema(df, name= 'yellow_taxi_data'))`
- A schema will be printed for a table named 'yellow_taxi_data' with the same fields as in the dataframe from the csv in DDL form. 
- create a connection to postgres from within the jupyter notebook using pandas using sqlalchemy
- using pandas, copied data from csv into Postgres refer [jupyter notebook](upload_data_new.ipynb)

>*Problems*: Unable to use jupyter notebook within VSCode <br/>
    'Failed to start the Kernel. <br/>
    Failed to start the Kernel 'Python 3.9.6'. <br/>
    View Jupyter log for further details. e.replace is not a function'

# What did I do today -

## PgAdmin
- After using pgcli in the last example, used PgAdmin to connect and interact with Postgres
- PgAdmin provides a GUI to interact with Postgres
- Run PgAdmin in a docker
- PgAdmin and Postgres are running in different containers, so we need to connect them

## Docker Network
- Created a docker network
- deployed Postgres and PgAdmin in two separate containers within this network 
- PgAdmin can now access Postgres
- As we used mounting for postgres, the data in postgres was persistant. 

## Data Ingestion using Docker and a script
- Converted jupyter notebook to a python script using `jupyter nbconvert --to=script file_name.ipynb`
- Removed unnecessary parts
- Changed `wget` to `curl` as I am using MacOS
- Downloading the `*.csv.gz` file using `curl` somehow corrupts it. 
- Extracting it using `gunzip` gives `gunzip: output.csv.gz: unexpected end of file`
- pre-downloaded file in folder and run rest of the code. 
- Will try a different way with uploading the file with mac compatible compression or downloading with something other than  `curl`. 
  
>*UPDATE*: installed wget on M1 using `arch -arm64 brew install wget` that solved the whole issue. No need to use curl. 

## Docker compose
- running script with docker-compose somehow does not give access to mounted db
- re-ingested using below script with the help of @cloudprograms9612 from the YT comments section.
    ```
    URL=http://192.168.0.103:8000/output.csv

    docker run -it \
    --network=2_docker_sql_default \
    taxi_ingest:v001 \
    --user=root  \
    --password=root  \
    --host=pgdatabase \
    --port=5432  \
    --db=ny_taxi \
    --url=${URL} \
    --table_name=yellow_taxi_trip ```
- notice network was changed to `2_docker_sql_default` network of the current docker instance, name of db changed to match.