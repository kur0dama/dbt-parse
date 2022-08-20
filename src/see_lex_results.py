import duckdb

from globals import PATHS

query = '''
SELECT * 
FROM 
    dbt_test 
WHERE 
    token_string <> ''
    and token_type <> 'T_IGNORE'
ORDER BY
    orig_string, token_seq
'''

con = duckdb.connect(database=PATHS.DUCKDB_PATH.as_posix(), read_only=True)
df = (con
    .execute(query)
    .fetchdf())

print('-'*80, 'LEX RESULTS', '-'*80, sep='\n')
print(df)