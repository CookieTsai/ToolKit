# 銷售排行榜
select pid, sum(cnt * price) as pay from orderlog group by pid order by pay DESC limit 20;
# 消費排行榜
select uid, sum(cnt * price) as pay from orderlog group by uid order by pay DESC limit 20;
# 使用者 order Count
select uid,count(1) from orderlog group by uid;
# 使用者 view Count
select uid,count(1) from viewlog group by uid;
# 使用者 order Count + view Count
select t1.uid,t1.cnt as ordercnt,t2.cnt as viewcnt
from ( 
	select uid,count(1) cnt 
	from orderlog 
	group by uid 
) t1 
left join( 
	select uid,count(1) cnt 
	from viewlog 
	group by uid 
) t2 on t1.uid = t2.uid 
where t2.uid is not null 
order by t1.cnt DESC
limit 20

# 消費前 1w 名的 ordercnt , viewcnt
select t0.uid,t0.pay,t1.cnt as ordercnt,t2.cnt as viewcnt
from (
	select uid, sum(cnt * price) as pay 
	from orderlog 
	group by uid
	order by pay DESC
	limit 10000
) t0 
left join (
	select uid,count(1) cnt 
	from orderlog 
	group by uid 
) t1 on t0.uid = t1.uid 
left join( 
	select uid,count(1) cnt 
	from viewlog 
	group by uid 
) t2 on t0.uid = t2.uid 
where t2.uid is not null 

# 消費排行榜前 xxxx user 購買的商品排行 20 名
select pid,sum(cnt * price) as pay 
from orderlog as o
where o.uid in (
	select uid 
	from (
		select uid, sum(cnt * price) as pay 
		from orderlog 
		group by uid 
		order by pay DESC 
		limit 10000
	) t1
)
group by pid
order by pay DESC
limit 20

# 計算 Table 有多少行
select count(1) from (
	select pid,sum(cnt * price) as pay 
	from orderlog as o
	group by pid
	order by pay DESC
) t1

select count(1) from (
	select uid from test_viewlog group by uid
) t1

select count(1) from (
	select t0.uid, t0.cnt as cnt, t1.cnt as tcnt
	from (
		select uid,count(1) as cnt
		from viewlog
		group by uid
	) t0
	left join (
		select uid,count(1) as cnt
		from test_viewlog
		group by uid
	) t1 on t0.uid = t1.uid
	where t0.uid <> 'NA' and t1.uid is not null
) t3

# 商品類別
select pid,count(1) from orderlog group by pid limit 1;

# 取得商品分類
select t2.mycat,t2.cnt,t3.cnt
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
) t3 on t2.mycat = t3.mycat


# 上個月有紀錄的類別 / 下個月所有類別 23055/ 26914
select t2.mycat,t2.cnt,t3.cnt
from (
	select t0.mycat,count(1) as cnt
	from ( 
		select cat as mycat
		from viewlog
	) t0 
	group by t0.mycat
) t2 
left join (
	select t1.mycat,count(1) as cnt
	from ( 
		select cat as mycat
		from test_viewlog
	) t1
	group by t1.mycat
) t3 on t2.mycat = t3.mycat
where t3.mycat is not null
order by t2.mycat


select t1.pid,t1.mycat
from (
	select pid,regexp_extract(cat,'^(.)',1) as mycat,count(1) as cnt
	from viewlog 
	group by pid,mycat
) t1
group by t1.pid,t1.mycat

# 下個月已知價格的商品 30841 / 234360
select *
from (
	select t0.pid,avg(t0.price) as av
	from (
		select pid,price
		from orderlog
		union all
		select pid,price
		from cartlog
	) t0
	group by t0.pid
) t1
left join (
	select pid
	from test_viewlog
	group by pid
) t2 on t1.pid = t2.pid
where t2.pid is not null
order by t1.av

# 使用者 兩個月 veiw 的關係
create table f3 (uid string, v1cnt bigint, v2cnt bigint, m0 double, uid2 string, ocnt bigint,m1 double);

select *, (t4.cnt / t3.cnt) as m1
from (
	select t0.uid, t0.cnt as cnt, t1.cnt as tcnt, ((t0.cnt - t1.cnt) / t0.cnt) as m
	from (
		select uid,count(1) as cnt
		from viewlog
		group by uid
	) t0
	left join (
		select uid,count(1) as cnt
		from test_viewlog
		group by uid
	) t1 on t0.uid = t1.uid
	where t0.uid <> 'NA' and t1.uid is not null
) t3
left join (
	select uid,count(1) as ocnt
	from orderlog
	group by uid
) t4 on t3.uid = t4.uid
where t3.m < 0.8 
and t3.m > -0.8
and t3.cnt > 5
and t4.uid is not null
order by m1 DESC
limit 20


# 判斷有多少人有在預期的 table 之中
select count(1)
from f2
where f2.uid in (
	select t1.uid 
	from (
		select uid, sum(cnt * price) as pay 
		from orderlog
		group by uid 
		order by pay DESC 
		limit 3
	) t1
)

# viewlog uid && test_viewlog uid
# count 17245

# viewlog uid && orderlog uid
# count 26929

# orderlog uid && viewlog uid && test_viewlog uid
# count 12633
select count(1)
from (
	select uid
	from viewlog 
	group by uid
) t0 
left join (
	select uid
	from orderlog 
	group by uid
) t1 on t0.uid = t1.uid
left join (
	select uid
	from test_viewlog 
	group by uid
) t2 on t1.uid = t2.uid
where t0.uid <> "NA"
and t1.uid is not null 
and t2.uid is not null
and t1.uid in (
	select t3.uid 
	from (
		select uid, sum(cnt * price) as pay 
		from orderlog 
		group by uid 
		order by pay DESC 
		limit 10000
	) t3
)
========================== 以下是 pid ================================
## 
select t0.pid,count(1)
from (
	select pid
	from orderlog
	union all
	select pid
	from cartlog
) t0
group by t0.pid


select count(1)
from cartlog

## 
select t0.eruid,t0.ip,count(1) as cnt
from (
	select eruid,ip,uid 
	from orderlog 
	group by eruid,ip,uid
) t0
group by t0.eruid,t0.ip
order by cnt






