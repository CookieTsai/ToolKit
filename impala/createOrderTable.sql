CREATE EXTERNAL TABLE orderlog (
	d STRING,
    t STRING,
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
LOCATION '/user/cloudera/order2';