import sys
import csv
import re

index = {"ip":0,"time":1,"act":2,"name":3,"erUid":4,"keywords":5,"uid":6,"pid":7,"eturec":8,"cat":9,"plist":10}

reader = csv.reader(sys.stdin)
#reader.readline()
for row in reader:
    uid = row[index["uid"]]
    plist = row[index["plist"]]
    
    for item in re.findall(r'([0-9]+),([0-9]+),([0-9]+)', plist):
        pid = item[0]
        cnt = item[1]
        price = item[2]
        pay = int(cnt) * int(price)
        print uid,pay