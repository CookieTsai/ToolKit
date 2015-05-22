CREATE EXTERNAL TABLE orderlog (
    time STRING,
    uid STRING,
    pid STRING,
    cnt INT,
    price INT,
    erUid STRING,
    ip STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
STORED AS TEXTFILE
LOCATION '/user/cloudera/order';