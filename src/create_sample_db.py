import duckdb
import pathlib
import os
import pandas as pd

from globals import PATHS

def importSampleData() -> pd.DataFrame:
    filepath = PATHS.ASSETS.joinpath('sample_data.csv')
    return pd.read_csv(filepath)

if __name__ == '__main__':
    if PATHS.DUCKDB_PATH.is_file():
        os.remove(PATHS.DUCKDB_PATH)
    con = duckdb.connect(database=PATHS.DUCKDB_PATH.as_posix(), read_only=False)
    df_sample = importSampleData()
    con.execute('DROP TABLE IF EXISTS main.df_sample; CREATE TABLE main.sample_data AS SELECT * FROM df_sample;')
    # test results
    con.execute('SELECT * FROM information_schema.tables;')
    df_info_schema = con.fetchdf().loc[:,['table_schema', 'table_name']]
    print('SCHEMA/TABLE RESULTS')
    print('-'*80)
    print(df_info_schema)