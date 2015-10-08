import sys
import csv

reader = csv.reader(sys.stdin)

for row in reader:
   print row
