
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

myData <- dbGetQuery(conn,"select t2.mycat,t2.cnt as cnt1,t3.cnt as cnt2
                     from (
                     select t0.mycat,count(1) as cnt
                     from ( 
                     select regexp_extract(cat,'^(.)',1) as mycat
                     from viewlog
                     ) t0 
                     group by t0.mycat
                     ) t2 
                     left join (
                     select t1.mycat,count(1) as cnt
                     from ( 
                     select regexp_extract(cat,'^(.)',1) as mycat
                     from test_viewlog
                     ) t1
                     group by t1.mycat
                     ) t3 on t2.mycat = t3.mycat")

str(myData)

model = lm(myData$cnt1~myData$cnt2)
# summary(model)
plot(myData$cnt1~myData$cnt2)
abline(model, col="red")

# 繪製 box plot 
# a <- myData$ordercnt
# boxplot(a,col=c("red"), names=c("A"), xlab="Subtype",ylab="Expression")

# dbDisconnect(conn)



