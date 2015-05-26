import sys
import csv
import re

index = {"ip":0,"day":1,"time":2,"act":3,"name":4,"erUid":5,"keywords":6,"uid":7,"pid":8,"eturec":9,"cat":10,"plist":11}

reader = csv.reader(sys.stdin)
#writer=csv.writer(sys.stdout)

for row in reader:
    ip = row[index["ip"]]
    day = row[index["day"]]
    time = row[index["time"]]
    uid = row[index["uid"]]
    plist = row[index["plist"]]
    erUid = row[index["erUid"]]
    
    for item in re.findall(r'([0-9]+),([0-9]+),([0-9]+)', plist):
        pid = item[0]
        cnt = item[1]
        price = item[2]
        pay = int(cnt) * int(price)
        print day,time,uid,pid,cnt,price,erUid,ip
        