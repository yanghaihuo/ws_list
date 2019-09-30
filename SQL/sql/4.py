SELECT sale_date, MAX(quantity)  FROM SalesHistory
GROUP BY sale_date
HAVING MAX(quantity) >= 10;


1.更改表名 
alter table 表名 rename to 新表名
alter table cz1_20190606081432  rename to cz1

2.更改字段名
alter table 表名 rename 字段名 to 新字段名
ALTER TABLE  cz1 add COLUMN id serial


alter table cz1 rename id to ids


Select * from 
(select 成绩，姓名，学号，等信息，row_number () over (partition by 课程 order by 成绩 desc)rank from table)t 
where t.rank=1



正则
SELECT  substring(company from '（(.*?)）')  
from bt_maigoo_product_20190524_new_1 where first_addr is null


@@去重 先增加自增id  载根据去重字段
ALTER table  pinduoduo_shop_huizong_unique add COLUMN id serial

delete from pinduoduo_shop_huizong_unique  where id not in (select max(id) from pinduoduo_shop_huizong_unique group by shop_id );



-- 创建联合索引  可以对 WHERE 子句指定条件所对应的列创建索引，这样大幅提高处理速度。
ALTER TABLE gather_taobao.ir_taobao_product_trade_china_2018 ADD INDEX index_name (prod_name,first_cat,agri_keyid);

substring( cast(prod_detail_factory_addrid as varchar) from 1 for 2)
to_number((regexp_matches(b.prod_detail,'"净含量":"(\d+)g"'))[1],'999999999999999') as weight

SELECT (regexp_matches(' 买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '(\d+)[^\d+?][*](\d+)'))[1],
(regexp_matches(' 买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '(\d+)[^\d+?][*](\d+)'))[2]


select  regexp_matches('买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '\d+', 'g')
select  regexp_matches('买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '\d+')


select string_to_array('休闲,娱乐,运动,玩耍', ',');
SELECT array_to_string(regexp_matches('买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '\d+', 'g'),' ')



1.查询同一个部门下的员工且合并起来
select deptno, string_agg(ename, ',') from jinbo.employee group by deptno;
select deptno, array_to_string(array_agg(ename),',') from jinbo.employee group by deptno;



2、在1条件的基础上，按ename 倒叙合并
select deptno, string_agg(ename, ',' order by ename desc) from jinbo.employee group by deptno;


3、按数组格式输出使用 array_agg
select deptno, array_agg(ename) from jinbo.employee group by deptno;

4、array_agg 去重元素，例如查询所有的部门
select array_agg(distinct deptno) from jinbo.employee;
select array_agg(distinct deptno order by deptno desc) from jinbo.employee;


array_agg(distinct(字段名)) 拼接唯一的字段




























