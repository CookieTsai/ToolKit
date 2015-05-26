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
    pid = row[index["pid"]]
    cat = row[index["cat"]]
    erUid = row[index["erUid"]]
    
    print day,time,uid,pid,cat,erUid,ip