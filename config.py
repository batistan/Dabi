from os import path

basedir = path.abspath(path.dirname(__file__))

SECRET_KEY = "ThisIsASuperSecretKey123"

# LOCATION OF THE DATABASE
DATABASE = basedir + 'database.db'
