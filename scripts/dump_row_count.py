import duckdb
import os

# get all tables' row number of a database
def get_row_count(dir):
    # connect to database with dir
    con = duckdb.connect(dir)
    cur = con.cursor()

    # get all tables' name
    cur.execute("SELECT name FROM sqlite_master WHERE type='table';")

    tables = cur.fetchall()
    with open("answers/row_count.txt", "w") as f:
        for table in tables:
            # get row number of each table
            cur.execute("SELECT COUNT(*) FROM %s;" % table)
            row_count = cur.fetchone()[0]
            f.write("%s: %s\n" % (table[0], row_count))
    
    con.close()


if __name__ == "__main__":
    dir = 'NYC-transit.db'
    get_row_count(dir)


