import argparse
import os
import sqlite3

def write_to_db(db_name, command_list):
    os.remove(db_name)
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    for query in command_list:
        try:
            cursor.executescript(query)
        except sqlite3.Error as er:
            print(query + '\n')
            print(er)
    conn.commit()
    conn.close()

def read_dirs(dir_names):
    query_list = []
    for file in dir_names:
            if file.endswith(".sql"):
                with open(file, "r") as sql_file:
                    for query in sql_file.read().split(";"):
                        query_list.append(query)
    return query_list

def main(args):
    dirs = []
    the_database = "fallback.db"
    for arg in args:
        if arg.endswith(".db") == False and arg.endswith("/*") == False:
            dirs.append(arg)
        if arg.startswith("-"): 
            dirs.remove(arg.strip("-"))
        elif arg.endswith(".db") and not arg.endswith("/*"):
            the_database = arg
        elif arg.endswith("/*"):
            for directory in os.listdir(arg.strip("/*")):
                dirs.append(directory)

    write_to_db(the_database, read_dirs(dirs))

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("my_args", nargs="+")
    args = parser.parse_args()
    main(args.my_args)