import sys
import re
import csv

index = {"ip":0,"time":1,"act":2,"name":3,"erUid":4,"keywords":5,"uid":6,"pid":7,"eturec":8,"cat":9,"plist":10}

writer=csv.writer(sys.stdout)
#writer.writerow(["ip","time","act","name","erUid","keywords","uid","pid","eturec","cat","plist"])

for line in sys.stdin:
    
    row=["NA","NA","NA","NA","NA","NA","NA","NA","NA","NA","NA"]
    
    line = re.sub(r'"\s.*$', '', line)

    m = re.search(r'^([0-9.]+).*\[(\S+).*\?;(\S+)', line)    
    row[index["ip"]] = m.group(1)
    row[index["time"]] = m.group(2)
    
    for item in re.findall(r'(\w+)=([^;]+)', m.group(3)):
        key = item[0].strip()
        val = item[1].strip()
        if key in index:
            row[index[key]] = val
            
    writer.writerow(row)