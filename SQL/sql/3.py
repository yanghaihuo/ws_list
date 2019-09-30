/**gp中的基本sql语法**/
--删除表
drop table testtb;
--创建表
CREATE TABLE testtb
(
  id integer,
  "name" character varying(2)
)
WITH (
  OIDS=FALSE
)
DISTRIBUTED BY (id);
ALTER TABLE testtb OWNER TO gpadmin;
--WITH 用来说明表的存储属性，比如表的压缩
--DISTRIBUTED BY 定义表的分布键，这个键最好唯一，如果表中没有唯一键字段，可以定义DISTRIBUTED RANDOMLY作为分布建。

--表的创建
create table testTBbak (like testTB)                                  -- like 复制表结构
create table testtbbak1 as select * from testtb distributed by (name) -- 数据保留，可以指定分布键。
select * into testtbbak2 from testTB                                  -- into 保留数据，不能指定分布键
select * from testtbbak2


--创建视图
create view v_testtb as select * from testtb

-- 删除数据
delete from testtb -- 速度慢，会写日志。
truncate testtb    -- 速度快，但不会写日期。

/**序列的使用**/
--删除序列
drop sequence myseq
--创建序列（1是开始值，可以根据实际情况改变）
create sequence myseq start 1
--序列的使用
insert into testTB values(nextval('myseq'),'小明')
--重新设置序列值
select setval('myseq',1)
--查询
select id,name from testTB order by 1

-- explain 用于查看sql执行计划
explain select * from testtb 

/**字符串函数**/
-- || 字符串连接
select '胡' || '黄' || '腾'
-- length 字符长度
select length('89998')
-- substring 字符串截取,从那位开始，截几位
select substring('123456' from 2 for 3)
-- trim去字符前后空格
select trim(' 234 fds   ')
-- lower 字符转小写
select lower('RER')
-- upper 字符转大写
select upper('rer')
-- replace 替换字符
select replace('aabbddee','aa','mm')
-- position 查找指定字符位置
select position('de' in 'abdeaf')
-- split_part 根据指定字符查找给定字符的位置
select split_part('aaa|bbb|ccc|eee','|',2)

/**时间的函数**/
-- age求俩日期之差
select age(timestamp '1987-12-03',timestamp '2015-06-17')
-- age如果一个日期则和当前日期求差
select age(timestamp '1987-12-03')
-- current_date 当前日期
select current_date
-- current_time 当前时间
select current_time
-- current_timestamp 当前时间戳
select current_timestamp
-- now 当前时间
select now()
-- extract 获取指定时间的具体某个参数
select extract(day from date '2015-06-18')
select extract(day from now())
-- 时间相加
select '2015-04-2 10:00:52'::timestamp + interval '10 days 2 hours 10 seconds' 
-- 时间相减
select current_date - interval '10 days'



/**gp中其他函数**/
-- greatest 取两值中的最大值
select greatest(3,9)
-- 列转行
insert into testtb(id,name)values (1,'ha');
insert into testtb(id,name)values (1,'he');
insert into testtb(id,name)values (1,'hi');
insert into testtb(id,name)values (2,'xb');
insert into testtb(id,name)values (2,'xh');
insert into testtb(id,name)values (2,'xm');
select id,string_agg(name,'|' order by name) from testtb group by id;
-- 行转列
select id,regexp_split_to_table(string_agg,E'\\|') str from texttb_m

/**开窗函数**/
--建表
create table empsalary
(
  depname varchar(20),
  empno integer,
  salary integer
) 
distributed by (empno)

insert into empsalary values ('develop',9,4500);
insert into empsalary values ('develop',1,3200);
insert into empsalary values ('develop',4,1000);
insert into empsalary values ('develop',2,9100);
insert into empsalary values ('develop',6,1000);
insert into empsalary values ('person1',5,3100);
insert into empsalary values ('person1',7,4100);
insert into empsalary values ('sales',3,2400);
insert into empsalary values ('sales',8,1200);
insert into empsalary values ('sales',10,5100);

-- rank 及 row_number 函数的应用
select depname
       ,empno
       ,salary
       ,rank() over (partition by depname order by salary desc)
       ,row_number() over (partition by depname order by salary desc)
from empsalary
-- rank 识别重复记录
-- row_number 不识别重复记录

select *
       ,sum(salary) over () sum1
       ,sum(salary) over (order by salary) sum2
       ,sum(salary) over (partition by depname) sum3
       ,sum(salary) over (partition by depname order by salary) sum4
 from empsalary

-- grouping by 的使用（其实就是简化了union）
select depname ,sum(empno)
from empsalary
group by depname
union all
select depname ,sum(salary)
from empsalary
group by depname

--等效于
select depname,sum(empno),sum(salary)
from empsalary 
group by grouping sets(depname)


GROUPING SETS 列出所有你设置的分组集
CUBE          列出所有可能的分组集
ROOLUP        以层级的方式列出分组集




alter TABLE address_analysis add COLUMN id serial
alter TABLE address_analysis alter  COLUMN forth_addr type VARCHAR(50)
ALTER TABLE analysis_business_list.address_analysis RENAME forth_addr TO fourth_addr