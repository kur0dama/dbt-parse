import duckdb

from globals import PATHS

con = duckdb.connect(database=PATHS.DUCKDB_PATH.as_posix(), read_only=True)
print(
    con.execute('SELECT * FROM dbt_test').fetchdf()
)