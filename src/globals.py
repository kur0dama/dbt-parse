import pathlib

class PATHS:
    ROOT = pathlib.Path(__file__).parent.parent
    DB = ROOT.joinpath('db')
    ASSETS = ROOT.joinpath('assets')
    DUCKDB_PATH = DB.joinpath('sample.duckdb')