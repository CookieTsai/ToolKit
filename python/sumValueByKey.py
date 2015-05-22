import sys

key = None
val = 0
for line in sys.stdin:
    part = line.split(' ')
    
    if key == None:
        key = part[0]
    
    if key == part[0]:
        val += int(part[1])
    else:
        print "%s %d" % (key,val)
        key = part[0]
        val = int(part[1])
        
print "%s %d" % (key,val)