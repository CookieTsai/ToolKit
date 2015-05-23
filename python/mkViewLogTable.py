import sys
import csv
import re

index = {"ip":0,"time":1,"act":2,"name":3,"erUid":4,"keywords":5,"uid":6,"pid":7,"eturec":8,"cat":9,"plist":10}

reader = csv.reader(sys.stdin)
#writer=csv.writer(sys.stdout)

for row in reader:
    ip = row[index["ip"]]
    time = row[index["time"]]
    uid = row[index["uid"]]
    #plist = row[index["plist"]]
    pid = row[index["pid"]]
    cat = row[index["cat"]]
    erUid = row[index["erUid"]]
    
    print time,uid,pid,cat,erUid,ip
    
    #for item in re.findall(r'([0-9]+),([0-9]+),([0-9]+)', plist):
        #pid = item[0]
        #cnt = item[1]
        #price = item[2]
        #pay = int(cnt) * int(price)
        #print time,uid,pid,cnt,price,erUid,ip
        