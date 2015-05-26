
if(!require(RJDBC)){
  install.packages("RJDBC")
}
drv <- JDBC("com.cloudera.impala.jdbc3.Driver",
            "/Users/Mitake/Cookie/lib/impala/jars/ImpalaJDBC3.jar",
            identifier.quote="`")
conn <- dbConnect(drv, "jdbc:impala://VMcdh01:21050", "", "")
dbDisconnect(con)
