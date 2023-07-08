import duckdb
import os

def get_row_counts(dir):
    conn = duckdb.connect(dir)
    counts = conn.execute("SELECT name, count(*) FROM sqlite_master WHERE type='table' GROUP BY name").fetchall()

    # write to txt
    # create directory if it doesn't exist
    if not os.path.exists('row_counts.txt'):
        os.makedirs('row_counts.txt')

    with open('row_counts.txt', 'w') as f:
        for name, count in counts:
            f.write(f'{name}: {count}\n')

    return counts


if __name__ == "__main__":
    dir = 'C:/Users/Hu/NYC-Traffic-Analysis/data/traffic_data.db'
    get_row_counts(dir)


