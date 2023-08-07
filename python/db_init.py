# written by chatGPT based on code by me

import glob
import re
import os
import sqlite3



def load_queries_from_file(filename):
    with open(filename, 'r') as f:
        queries = f.read().split(';')
    return queries


def get_priority(filename):
    with open(filename, 'r') as f:
        first_line = f.readline()
        match = re.search(r'\d+$', first_line)
        if match:
            return int(match.group())
        else:
            return -1


def get_every_query(sql_dir, table_dir, data_dir):
    table_files = sorted(glob.glob(sql_dir + table_dir + '*.sql'), key=get_priority)
    data_files = glob.glob(sql_dir + data_dir + '*.sql')

    all_queries = []

    for table_file in table_files:
        print(table_file + '\n')
        table_queries = load_queries_from_file(table_file);
        all_queries.extend(table_queries)
        for data_file in data_files:
            file_title = data_file.replace('_populate.sql', '').replace(data_dir, '')
            print('\t' + file_title)
            if table_file.replace('_init.sql', '').replace(table_dir, '') == file_title:
                data_queries = load_queries_from_file(data_file)
                all_queries.extend(data_queries)
                data_files.remove(data_file)

    return all_queries

def query_db(queries, database_name):
    connection = sqlite3.connect(database_name)

    cursor = connection.cursor()

    for query in queries:
        try:
            cursor.execute(query)
        except sqlite3.Error as er:
            print(query + '\n')
            print(er)

    connection.commit()
    connection.close()


def insert_everything(sql_dir='../SQL', table_dir='/DDL/', data_dir='/DML/', database_name='../default.db'):
    all_queries = get_every_query(sql_dir, table_dir, data_dir)
    query_db(all_queries, database_name)


if __name__ == "__main__":
    insert_everything()

