import pathlib

class PATHS:
    ROOT = pathlib.Path(__file__).parent.parent
    DB = ROOT.joinpath('db')
    SRC = ROOT.joinpath('src')
    ASSETS = ROOT.joinpath('assets')
    DUCKDB_PATH = DB.joinpath('sample.duckdb')