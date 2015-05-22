import sys
import csv

writer=csv.writer(sys.stdout)

for line in sys.stdin:
    writer.writerow(line.split())