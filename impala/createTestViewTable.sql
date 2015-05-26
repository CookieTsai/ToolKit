CREATE EXTERNAL TABLE test_viewlog (
	d STRING,
    t STRING,
    uid STRING,
    pid STRING,
    cat STRING,
    erUid STRING,
    ip STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
STORED AS TEXTFILE
LOCATION '/user/cloudera/test_view2';
