# What did I do today?

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


