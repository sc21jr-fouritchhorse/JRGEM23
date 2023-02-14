# written by chatGPT based on code by me

import glob
import re
import os
import sqlite3
import sqlparse

sql_dir = '../SQL/'
table_dir = 'DDL/'
data_dir = 'DML/'


def load_queries_from_file(filename):
    with open(filename, 'r') as f:
        queries = sqlparse.split(f.read())
    return [q for q in queries if q.strip()]


def get_priority(filename):
    with open(filename, 'r') as f:
        first_line = f.readline()
        match = re.search(r'\d+$', first_line)
        if match:
            return int(match.group())
        else:
            return 0


table_files = sorted(glob.glob(sql_dir + table_dir + '*.sql'), key=get_priority)
data_files = sorted(glob.glob(sql_dir + data_dir + '*.sql'))

all_queries = []

for table_file in table_files:
    all_queries.extend(load_queries_from_file(table_file))

for data_file in data_files:
    all_queries.extend(load_queries_from_file(data_file))


database_name = '../draft23.db'

connection = sqlite3.connect(database_name)

cursor = connection.cursor()

for query in all_queries:
    try:
        cursor.execute(query)
    except sqlite3.Error as er:
        print(query + '\n')
        print(er)

connection.commit()
connection.close()
