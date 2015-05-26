
if(!require(RJDBC)){
  install.packages("RJDBC",dep=TRUE)
}

library(rJava)
library(RJDBC)
library(DBI)

# Set JAVA_HOME, set max. memory, and load rJava library
# Sys.setenv(JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_75.jdk/Contents/Home')
# options(java.parameters="-Xmx2g")

# for(l in list.files('/usr/lib/hive/lib/')){ .jaddClassPath(paste("/usr/lib/hive/lib/",l,sep=""))}
# for(l in list.files('/usr/lib/hadoop/')){ .jaddClassPath(paste("/usr/lib/hadoop/",l,sep=""))}

# Output Java version
.jinit()
print(.jcall("java/lang/System", "S", "getProperty", "java.version"))

drv <- JDBC("com.cloudera.impala.jdbc4.Driver","/Users/Mitake/Cookie/lib/impala/2.5.22.1040/JDBC4/ImpalaJDBC4.jar",identifier.quote="`")
conn <- dbConnect(drv, "jdbc:impala://VMcdh01:21050")
dbListTables(conn)

myData <- dbGetQuery(conn, 
                     "select t1.pid,t1.cnt as ordercnt,t2.cnt as viewcnt
                     from ( 
                     select pid,count(1) cnt 
                     from orderlog 
                     group by pid 
                     ) t1 
                     left join( 
                     select pid,count(1) cnt 
                     from viewlog 
                     group by pid 
                     ) t2 on 
                     t1.pid = t2.pid 
                     where t2.pid is not null and t1.pid <> 'NA'")

str(myData)

model = lm(myData$ordercnt~myData$viewcnt)
# summary(model)
plot(myData$ordercnt~myData$viewcnt)
abline(model, col="red")

# 繪製 box plot 
# a <- myData$ordercnt
# boxplot(a,col=c("red"), names=c("A"), xlab="Subtype",ylab="Expression")

# dbDisconnect(conn)



