alter TABLE analysis_business_list.hengshui_ws_list add COLUMN zhuangtai int4

alter TABLE address_analysis alter  COLUMN first_areaid type VARCHAR(50)


ALTER TABLE area_brand_geographical_indication_product1 DROP COLUMN id
ALTER TABLE area_brand_geographical_indication_product1 add COLUMN id serial

delete from mining_testdb.cz2018  where id not in (select max(id) from mining_testdb.cz2018 group by prod_id );

CREATE INDEX id_index ON   bt_taobao_product_china_all_detail_2018_yh (id);

delete from mining_testdb.cz2018  where id not in (select max(id) from mining_testdb.cz2018 group by prod_id );


INSERT INTO "tj_data_business_list" ("name", "area", "plat_name") VALUES ('东北珍特产食材店', '吉林通化梅河口市', '淘宝');

create table tj_data_business_list ( name VARCHAR(255),area VARCHAR(255),plat_name VARCHAR(255),main_areas VARCHAR(255),
url VARCHAR(255),"type" VARCHAR(255),area_id int8,datatime_type VARCHAR(255),datatime VARCHAR(255))

TRUNCATE TABLE mining_testdb.taobao_agri_industry_test4


@@去重 先增加自增id  载根据去重字段
ALTER table  pinduoduo_shop_huizong_unique add COLUMN id serial

delete from pinduoduo_shop_huizong_unique  where id not in (select max(id) from pinduoduo_shop_huizong_unique group by shop_id );


alter table pinduoduo_shop_huizong_unique  rename to bt_pinduoduo_shop_all_unique


create TABLE  pinduoduo_shop_shop_unique as (
select  cast(shop_id  as VARCHAR(100)),shop_name,url from  bt_pinduoduo_shop_china_20180503
UNION
select  cast(shop_id  as VARCHAR(100)),shop_name,url from  bt_pinduoduo_shop_china_20180731
UNION
select  cast(shop_id  as VARCHAR(100)),shop_name,url from  bt_pinduoduo_shop_china_20180925_compress
UNION
select  cast(shop_id  as VARCHAR(100)),shop_name,url from  bt_pinduoduo_shop_china_20181020
UNION
select  cast(shop_id  as VARCHAR(100)),shop_name,url from  bt_pinduoduo_shop_china_20181115
)


to_char(int, text)
to_number（text,text）
substr(字符串字段,1,2)
substring(cast(prod_detail_factory_addrid as VARCHAR) , 1 , 4)
to_number((regexp_matches(prod_detail,'"净含量":"(\d+)g"'))[1],'9999999999999999')


CREATE OR REPLACE FUNCTION add(a NUMERIC, b NUMERIC)
RETURNS NUMERIC
AS $$
    SELECT a+b;
$$ LANGUAGE SQL;


select add(2,3);


create  table analysis_test.address_analysis as  select * from analysis_business_list.address_analysis




-- 区县
SELECT * from (SELECT id,shop_name,level,third_areaid,third_addr,url,platform,row_number() over (PARTITION BY third_areaid order by level desc)as px from 
analysis_test.bt_ws_list_2019q1 where third_areaid in (SELECT areaid from analysis_test.cooperation_area_list_2019q1 where rank =3))t
where px < 21 order by third_areaid,px 



-- 市
SELECT * from (SELECT id,shop_name,level,first_areaid,second_areaid,third_areaid,first_addr,second_addr,third_addr,url,platform,row_number() over (PARTITION BY second_areaid order by level desc)as px from 
analysis_test.bt_ws_list_2019q1 where second_areaid in (SELECT areaid from analysis_test.cooperation_area_list_2019q1 where rank =2))t
where px < 21 order by second_areaid,px 


-- 省
SELECT * from (SELECT id,shop_name,level,first_areaid,second_areaid,third_areaid,first_addr,second_addr,third_addr,url,platform,row_number() over (PARTITION BY first_areaid order by level desc)as px from 
analysis_test.bt_ws_list_2019q1 where first_areaid in (SELECT areaid from analysis_test.cooperation_area_list_2019q1 where rank =1))t
where px < 21 order by first_areaid,px 


根据科目分组，按分数排序
select *,row_number() over(partition by course order by score desc) from student;

select "count"(shop_name)  from  analysis_test.bt_ws_list_2019q1

update analysis_test.bt_ws_list_2019q1 a
SET capital_2 = b.capital_01
from analysis_test.qiyeku_dx b
where a.name=b.name




SELECT   
(case when   m.qj>0 and m.qj<10  then 'x<10'
when    m.qj<20  then '10<=x<20'
when    m.qj<30  then '20<=x<30'
when    m.qj>30 then '30以上'
ELSE '其他' end ) as  价格区间,sum(m.amount) as 销量
from 
(SELECT (case when t.weight=0 then -1  when t.weight<5 then -1  else  t.money/t.weight*500  end) as qj,amount,t.ff as fff
from 
(SELECT to_number((regexp_matches(b.prod_detail,'"净含量":"(\d+)g"'))[1],'999999') as weight,(
COALESCE(a.month_amount_01,0)+COALESCE(a.month_amount_02,0)+COALESCE(a.month_amount_03,0)+COALESCE(a.month_amount_04,0)+COALESCE(a.month_amount_05,0)+COALESCE(a.month_amount_06,0)
+COALESCE(b.month_amount_07,0)+COALESCE(b.month_amount_08,0)+COALESCE(b.month_amount_09,0)+COALESCE(b.month_amount_10,0)+COALESCE(b.month_amount_11,0)+COALESCE(b.month_amount_12,0)
) as amount,
 (case when  (
COALESCE(a.month_amount_01,0)+COALESCE(a.month_amount_02,0)+COALESCE(a.month_amount_03,0)+COALESCE(a.month_amount_04,0)+COALESCE(a.month_amount_05,0)+COALESCE(a.month_amount_06,0)
+COALESCE(b.month_amount_07,0)+COALESCE(b.month_amount_08,0)+COALESCE(b.month_amount_09,0)+COALESCE(b.month_amount_10,0)+COALESCE(b.month_amount_11,0)+COALESCE(b.month_amount_12,0)
)= 0  then -1 ELSE  (
COALESCE(a.month_money_01,0)+COALESCE(a.month_money_02,0)+COALESCE(a.month_money_03,0)+COALESCE(a.month_money_04,0)+COALESCE(a.month_money_05,0)+COALESCE(a.month_money_06,0)
+COALESCE(b.month_money_07,0)+COALESCE(b.month_money_08,0)+COALESCE(b.month_money_09,0)+COALESCE(b.month_money_10,0)+COALESCE(b.month_money_11,0)+COALESCE(b.month_money_12,0)
)/(COALESCE(a.month_amount_01,0)+COALESCE(a.month_amount_02,0)+COALESCE(a.month_amount_03,0)+COALESCE(a.month_amount_04,0)+COALESCE(a.month_amount_05,0)+COALESCE(a.month_amount_06,0)
+COALESCE(b.month_amount_07,0)+COALESCE(b.month_amount_08,0)+COALESCE(b.month_amount_09,0)+COALESCE(b.month_amount_10,0)+COALESCE(b.month_amount_11,0)+COALESCE(b.month_amount_12,0)
) end) as money
FROM 
gather_taobao.ir_taobao_product_trade_china_2018  a JOIN   analysis_taobao.bt_taobao_product_china_all_detail_2018 b 
on  a.prod_id=b.prod_id     where
 a.first_cat~'食品保健' AND a.prod_name~'鸡精'
         )t )  m
GROUP BY  价格区间




SELECT  
(CASE 
when	c.tem>0 and c.tem <500 then 'x<500g'
when	c.tem  <1000 then '500g<=x<1000g'
when	c.tem  <5000 then '1000g<=x<5000g'
when	c.tem  >5000 then '5000g以上'
ELSE 	'其他' end) as 重量区间,
sum(COALESCE(month_amount_01,0)+ COALESCE(month_amount_02,0) + COALESCE(month_amount_03,0) +COALESCE(month_amount_04,0)+COALESCE(month_amount_05,0) +COALESCE(month_amount_06,0)
+COALESCE(b.month_amount_07,0)+COALESCE(b.month_amount_08,0)+COALESCE(b.month_amount_09,0)+COALESCE(b.month_amount_10,0)+COALESCE(b.month_amount_11,0)+COALESCE(b.month_amount_12,0)
) as 销量,sum(COALESCE(month_money_01,0)+COALESCE(month_money_02,0)+COALESCE(month_money_03,0)+COALESCE(month_money_04,0)+COALESCE(month_money_05,0)+COALESCE(month_money_06,0)
+COALESCE(b.month_money_07,0)+COALESCE(b.month_money_08,0)+COALESCE(b.month_money_09,0)+COALESCE(b.month_money_10,0)+COALESCE(b.month_money_11,0)+COALESCE(b.month_money_12,0)
) as 销售额

FROM analysis_taobao.bt_taobao_product_china_all_detail_2018  a
JOIN gather_taobao.ir_taobao_product_trade_china_2018 b on a.prod_id = b.prod_id
join (select prod_id,to_number((regexp_matches(prod_detail,'"净含量":"(\d+)g"'))[1],'999999') as tem
from analysis_taobao.bt_taobao_product_china_all_detail_2018) c on a.prod_id = c.prod_id
where  
 b.first_cat~'食品保健' AND a.prod_name~'鸡精'
GROUP BY 重量区间



-- 注释
/*

注释
*/

-- 创建联合索引  可以对 WHERE 子句指定条件所对应的列创建索引，这样大幅提高处理速度。
ALTER TABLE gather_taobao.ir_taobao_product_trade_china_2018 ADD INDEX index_name (prod_name,first_cat,agri_keyid);

substring( cast(prod_detail_factory_addrid as varchar) from 1 for 2)





-- 2018年12s全国红薯网络零售不同价格区间的单品数量及销量	
SELECT   
(case when   m.qj<3  then '3元以下'
when    m.qj<5  then '3=<X<5元'
when    m.qj<8 then '5=<X<8元'
when    m.qj<10 then '8=<X<10元'
when    m.qj<15 then '12=<X<15元'
when    m.qj<20 then '15=<X<20元'
when    m.qj<30 then '20=<X<30元'
ELSE '30元及以上' end ) as  价格区间,count(DISTINCT m.prod_id),sum(m.amount)
from 
(SELECT (case when t.weight=0 then  0 else   t.money/t.weight*500  end) as qj,amount,t.prod_id
from 

(SELECT to_number((regexp_matches(b.prod_detail,'"净含量":"(\d+)g"'))[1],'999999999999999') as weight,a.prod_id,(COALESCE(a.month_amount_01,0)+COALESCE(a.month_amount_02,0)+COALESCE(a.month_amount_03,0)+COALESCE(a.month_amount_04,0)+COALESCE(a.month_amount_05,0)+COALESCE(a.month_amount_06,0)+COALESCE(a.month_amount_07,0)+COALESCE(a.month_amount_08,0)+COALESCE(a.month_amount_09,0)+COALESCE(a.month_amount_10,0)+COALESCE(a.month_amount_11,0)+COALESCE(a.month_amount_12,0)) as amount,

(CASE WHEN a.price_12 IS NOT NULL AND a.price_12!=0 THEN a.price_12 
ELSE CASE WHEN a.price_11 IS NOT NULL AND a.price_11!=0 THEN a.price_11 
ELSE CASE WHEN a.price_10 IS NOT NULL AND a.price_10!=0 THEN a.price_10 
ELSE CASE WHEN a.price_09 IS NOT NULL AND a.price_09!=0 THEN a.price_09 
ELSE CASE WHEN a.price_08 IS NOT NULL AND a.price_08!=0 THEN a.price_08 
ELSE CASE WHEN a.price_07 IS NOT NULL AND a.price_07!=0 THEN a.price_07 
ELSE CASE WHEN a.price_06 IS NOT NULL AND a.price_06!=0 THEN a.price_06 
ELSE CASE WHEN a.price_05 IS NOT NULL AND a.price_05!=0 THEN a.price_05 
ELSE CASE WHEN a.price_04 IS NOT NULL AND a.price_04!=0 THEN a.price_04 
ELSE CASE WHEN a.price_03 IS NOT NULL AND a.price_03!=0 THEN a.price_03 
ELSE CASE WHEN a.price_02 IS NOT NULL AND a.price_02!=0 THEN a.price_02 
ELSE a.price_01 END END END END END END END END END END END ) as money

FROM 
gather_taobao.ir_taobao_product_trade_china_2018  a JOIN   analysis_taobao.bt_taobao_product_china_all_detail_2018 b 
on  a.prod_id=b.prod_id   

where 
a.prod_name~'甘薯|朱薯|金薯|番茹|玉枕薯|山芋|地瓜|甜薯|红薯|红苕|白薯' AND a.prod_name!~'紫薯|木薯|地瓜干|红薯干|番薯干|淀粉|粉条|粉丝|饼|饼干|苗|种苗|机|发酵剂|定做|订做' AND a.agri_keyid>0


)t )  m
GROUP BY  价格区间
































