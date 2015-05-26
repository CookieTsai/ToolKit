import sys
import csv
import re

index = {"ip":0,"day":1,"time":2,"act":3,"name":4,"erUid":5,"keywords":6,"uid":7,"pid":8,"eturec":9,"cat":10,"plist":11}

reader = csv.reader(sys.stdin)

for row in reader:
    uid = row[index["uid"]]
    plist = row[index["plist"]]
    
    for item in re.findall(r'([0-9]+),([0-9]+),([0-9]+)', plist):
        pid = item[0]
        cnt = item[1]
        price = item[2]
        pay = int(cnt) * int(price)
        print pid,pay