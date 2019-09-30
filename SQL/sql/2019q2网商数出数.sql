@@第一部分，把所有平台网商数量汇总到一个表

CREATE table analysis_business_list.business_count_2019q2(
first_areaid int8,
second_areaid int8,
third_areaid int8,
count int8,
shop_type varchar(100),
platform varchar(100));

---------------实物网商---------------------------
--京东

INSERT into analysis_business_list.business_count_2019q2(first_areaid,second_areaid,third_areaid,count,shop_type,platform)
select first_areaid,
	   case when second_areaid is null then  first_areaid*100+99
		      else second_areaid end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then first_areaid*10000+9999
		    	when third_areaid is null and second_areaid is not null then second_areaid*100+99
          else third_areaid end                                                               as third_areaid,
     count(shop_id),'流通型','京东'
from gather_kind.ir_jd_shop_trade_china_2019 where first_areaid is not null and status = 1 
GROUP BY first_areaid,second_areaid,third_areaid

UNION ALL
--国美
select first_areaid,
	   case when second_areaid is null then  first_areaid*100+99
		      else second_areaid end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then first_areaid*10000+9999
		    	when third_areaid is null and second_areaid is not null then second_areaid*100+99
          else third_areaid end                                                               as third_areaid,
     count(shop_id),'流通型','国美'
from gather_kind.ir_guomei_shop_trade_china_2019 where first_areaid is not null and status = 1 
GROUP BY first_areaid,second_areaid,third_areaid
UNION ALL 
--一号店

select first_areaid,
	   case when second_areaid is null then  first_areaid*100+99
		      else second_areaid end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then first_areaid*10000+9999
		    	when third_areaid is null and second_areaid is not null then second_areaid*100+99
          else third_areaid end                                                               as third_areaid,
     count(shop_id),'流通型','一号店'
from gather_kind.ir_yhd_shop_trade_china_2019 where first_areaid is not null and status = 1 
GROUP BY first_areaid,second_areaid,third_areaid

--微店
UNION ALL
select first_areaid,
	   case when second_areaid is null then  first_areaid*100+99
		      else second_areaid end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then first_areaid*10000+9999
		    	when third_areaid is null and second_areaid is not null then second_areaid*100+99
          else third_areaid end                                                               as third_areaid,
     count(shop_id),'流通型','微店'
from gather_kind.ir_weidian_shop_trade_china_2019 where first_areaid is not null and status = 1 
GROUP BY first_areaid,second_areaid,third_areaid

--苏宁
UNION ALL
select first_areaid,
	   case when second_areaid is null then  first_areaid*100+99
		      else second_areaid end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then first_areaid*10000+9999
		    	when third_areaid is null and second_areaid is not null then second_areaid*100+99
          else third_areaid end                                                               as third_areaid,
     count(shop_id),'流通型','苏宁'
from gather_kind.ir_suning_shop_trade_china_2019 where first_areaid is not null and status = 1 
GROUP BY first_areaid,second_areaid,third_areaid	 

--天虎云商
UNION ALL
select first_areaid,
	   case when second_areaid is null then  first_areaid*100+99
		      else second_areaid end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then first_areaid*10000+9999
		    	when third_areaid is null and second_areaid is not null then second_areaid*100+99
          else third_areaid end                                                               as third_areaid,
     count(shop_id),'流通型','天虎云商'
from gather_kind.ir_tyfo_shop_trade_china_2019  where first_areaid is not null and status = '1'
GROUP BY first_areaid,second_areaid,third_areaid	 

--淘宝
UNION ALL
select first_areaid,
	   case when second_areaid is null then  first_areaid*100+99
		      else second_areaid end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then first_areaid*10000+9999
		    	when third_areaid is null and second_areaid is not null then second_areaid*100+99
          else third_areaid end                                                               as third_areaid,
     count(shop_id),'流通型',
     case when type in ('企业卖家','企业店铺') then '企业店铺'
          when type in ('淘宝','淘宝生态农业') then '淘宝'
          when type in ('天猫','天猫国际') then '天猫'
          else type end                                                                       as platform
from analysis_taobao.bt_taobao_shop_china_all where first_areaid is not null 
GROUP BY first_areaid,second_areaid,third_areaid,type

--------------B2B------------------------------------
--阿里巴巴
UNION ALL
select first_areaid,
	   case when second_areaid is null then  first_areaid*100+99
		      else second_areaid end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then first_areaid*10000+9999
		    	when third_areaid is null and second_areaid is not null then second_areaid*100+99
          else third_areaid end                                                               as third_areaid,
     count(shop_id),shop_type2,'阿里巴巴'
from gather_b2b_bulk.ir_1688_shop_trade_china_2019 where first_areaid is not null and status=1 
GROUP BY first_areaid,second_areaid,third_areaid,shop_type2 


--慧聪
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(shop_id),shop_type2,'慧聪'
from gather_b2b_bulk.ir_hc360_shop_trade_china_2019 where first_areaid is not null and status=1 and shop_type2!='生产型' 
GROUP BY first_areaid,second_areaid,third_areaid,shop_type2
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                              as third_areaid,
     count(shop_id),shop_type2,'慧聪'
from gather_b2b_bulk.ir_hc360_shop_trade_china_2019 where first_areaid is not null and shop_type2='生产型'
GROUP BY first_areaid,second_areaid,third_areaid,shop_type2 


--服务型平台
--猪八戒
UNION ALL
select first_areaid,
	   case when second_areaid is null then  first_areaid*100+99
		      else second_areaid end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then first_areaid*10000+9999
		    	when third_areaid is null and second_areaid is not null then second_areaid*100+99
          else third_areaid end                                                               as third_areaid,
     count(shop_id),'服务型','猪八戒'
from gather_service.ir_zbj_shop_china_2019 where first_areaid is not null
GROUP BY first_areaid,second_areaid,third_areaid

UNION ALL
--时间财富
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(shop_id),'服务型','时间财富'
from gather_service.ir_sjcf_shop_china_2016_list where first_areaid is not null
GROUP BY first_areaid,second_areaid,third_areaid	 


--一品威客
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(shop_id),'服务型','一品威客'
from gather_service.ir_epwk_shop_china_2016_list where first_areaid is not null AND state= '1'
GROUP BY first_areaid,second_areaid,third_areaid	 
---------团购平台---------
--美团网    
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(shop_id),'流通型','美团网'
from gather_service.ir_meituan_shop_china_2019 where first_areaid is not null AND status_06=1
GROUP BY first_areaid,second_areaid,third_areaid	 
UNION ALL
--大众点评
select first_areaid,
	   case when second_areaid is null then  first_areaid*100+99
		      else second_areaid end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then first_areaid*10000+9999
		    	when third_areaid is null and second_areaid is not null then second_areaid*100+99
          else third_areaid end                                                               as third_areaid,
     count(shop_id),'流通型','大众点评'
from gather_service.ir_dianping_shop_china_2019 where first_areaid is not null AND status_06=1 and (COALESCE(month_money_04,0)+COALESCE(month_money_05,0)+COALESCE(month_money_06,0))>0
GROUP BY first_areaid,second_areaid,third_areaid 


--百度糯米
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(shop_id),'流通型','百度糯米'
from gather_service.ir_nuomi_shop_china_2019 where first_areaid is not null AND first_areaid!='' AND status_06=1
GROUP BY first_areaid,second_areaid,third_areaid

---------外卖平台---------
--百度外卖    
UNION ALL
select first_areaid,
	   case when second_areaid is null then  first_areaid*100+99
		      else second_areaid end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then first_areaid*10000+9999
		    	when third_areaid is null and second_areaid is not null then second_areaid*100+99
          else third_areaid end                                                               as third_areaid,
     count(shop_id),'流通型','百度外卖'
from gather_service.ir_baidu_waimai_shop_china_2019 where first_areaid is not null
GROUP BY first_areaid,second_areaid,third_areaid 

--美团外卖    有bug
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(name),'流通型','美团外卖'
from analysis_business_list.meituan_waimai_unique where first_areaid is not null 
GROUP BY first_areaid,second_areaid,third_areaid 


--饿了么
UNION ALL
select first_areaid,
	   case when second_areaid is null then  first_areaid*100+99
		      else second_areaid end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then first_areaid*10000+9999
		    	when third_areaid is null and second_areaid is not null then second_areaid*100+99
          else third_areaid end                                                               as third_areaid,
     count(shop_id),'流通型','饿了么'
from gather_service.ir_ele_waimai_shop_china_2018_list where first_areaid is not null AND status_06=1
GROUP BY first_areaid,second_areaid,third_areaid	 


---------停抓酒店-------------
--欣欣
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(prod_id),'流通型','欣欣酒店'
from gather_service.ir_cncn_hotel_china_2019 where first_areaid is not null AND status_03=1
GROUP BY first_areaid,second_areaid,third_areaid 

--携程
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(prod_id),'流通型','携程酒店'
from gather_service.ir_xiecheng_hotel_china_2019 where first_areaid is not null AND status_03=1
GROUP BY first_areaid,second_areaid,third_areaid	 

--同程
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(prod_id),'流通型','同程酒店'
from gather_service.ir_ly_hotel_china_2019 where first_areaid is not null AND status_03=1
GROUP BY first_areaid,second_areaid,third_areaid 

--途家
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(prod_id),'流通型','途家酒店'
from gather_service.ir_tujia_hotel_china_2019 where first_areaid is not null AND status_03=1
GROUP BY first_areaid,second_areaid,third_areaid	 

--去哪儿
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(prod_id),'流通型','去哪儿酒店'
from gather_service.ir_qunaer_hotel_china_2019 where first_areaid is not null AND status_03=1
GROUP BY first_areaid,second_areaid,third_areaid	 

-----------停抓平台-------------
--艺龙
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(shop_id),'流通型','艺龙酒店'
from gather_service.ir_elong_hotel_2016_list where first_areaid is not null AND first_areaid !='' AND state = '1'
GROUP BY first_areaid,second_areaid,third_areaid

--马蜂窝
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(shop_id),'流通型','马蜂窝酒店'
from gather_service.ir_mafengwo_product_china_2016_list where first_areaid is not null AND state='1' AND first_areaid != '0'
GROUP BY first_areaid,second_areaid,third_areaid

--途牛
UNION ALL
select cast(first_areaid as int4),
	   case when (second_areaid is null or second_areaid = 'null') then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and (second_areaid is null OR second_areaid = 'null') then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(shop_id),'流通型','途牛酒店'
from "gather_service"."ir_tuniuticket_product_2016_list" where first_areaid is not null AND state='1' AND first_areaid != '0'
GROUP BY first_areaid,second_areaid,third_areaid


--阿里酒店
UNION ALL
select cast(first_areaid as int4),
	   case when second_areaid is null then  cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
	   case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                               as third_areaid,
     count(shop_id),'流通型','阿里酒店'
from "gather_service"."ir_ali_hotel_2016_list" where first_areaid is not null AND state = '1' AND first_areaid != '0'
GROUP BY first_areaid,second_areaid,third_areaid 
UNION ALL

--自建平台  
SELECT cast(first_areaid as int4),
	   case when second_areaid is null then cast(first_areaid as int4)*100+99
		      else cast(second_areaid as int4) end                                                              as second_areaid,
     case when third_areaid is null and second_areaid is null then cast(first_areaid as int4)*10000+9999
		    	when third_areaid is null and second_areaid is not null then cast(second_areaid as int4)*100+99
          else cast(third_areaid as int4) end                                                              as third_areaid,
     count(id),'平台型','自建平台' FROM gather_kind.ir_platform_2019 where status = '1' AND first_areaid is not null and first_areaid != '' 
     and category='电商' GROUP BY first_areaid,second_areaid,third_areaid 
--自建平台店铺
UNION ALL
SELECT 0,0,cast(areaid as int4),num,'流通型','自建平台店铺' FROM analysis_business_list.zijian_platform;



-------------------------------------------------------------------------------------------------------------------------------

@@第二部份：查看该季度网商数大概体量，是否遗漏了平台

--查看数据行数
SELECT count(*) from analysis_business_list.business_count_2019q2;  --92635  92601  92615
--查看网商数和
SELECT sum(count) from analysis_business_list.business_count_2019q2;  --34309131    33934595  34317968
--查看目标平台是否完整
SELECT DISTINCT platform from analysis_business_list.business_count_2019q2;  --31   
--------------------------------------------------------------------------------------------------------------------------------


@@第三部分：验证是否存在问题（14版本地域ID和重复数据）

--计算14版本ID的网商数总量
select sum(count) from analysis_business_list.business_count_2019q2 WHERE third_areaid NOT in (SELECT third_areaid FROM analysis_business_list.areaid_2017) AND first_areaid not in(81,71,82);
--查看存在14地域ID的平台和地域
SELECT DISTINCT third_areaid,platform FROM analysis_business_list.business_count_2019q2 WHERE third_areaid NOT in (SELECT third_areaid FROM analysis_business_list.areaid_2017) AND first_areaid not in(81,71,82);

--修正14版本ID为17版本（需先上传修正对应表）  
update analysis_business_list.business_count_2019q2 a 
set  third_areaid = b.id_17
from analysis_business_list.areaid_14to17v b where a.third_areaid=b.id_14 

-- 邯郸县(130421)撤销分解,划归为邯山区(130402)和丛台区(130403) 
SELECT  *  from analysis_business_list.business_count_2019q2 where  third_areaid=130421




--------------------------------------------------------------------------------------------------------------------------------
@@第四部分：各平台网商数变化

--插入上期网商数到平台增长表(把上季度的数据传上去)  count_q4

-- update analysis_business_list.platform_growth_2018 set count_q4 = NULL  
-- update analysis_business_list.business_count_2019q2 set count_q4 = NULL,rate_q4 = NULL  
-- --添加字段
-- ALTER table  analysis_business_list.platform_growth_2018 add count_q4  int4 
-- ALTER table  analysis_business_list.platform_growth_2018 add rate_q4  int4

create TABLE  analysis_business_list.platform_growth_2018v1 as SELECT * from  analysis_business_list.platform_growth_2018
 ALTER table  analysis_business_list.platform_growth_2018v1 add count_2019q2  int4
 ALTER table  analysis_business_list.platform_growth_2018v1 add rate_2019q2  float4

-- alter TABLE analysis_business_list.platform_growth_2018v1 alter COLUMN  rate_2019q2 type  float4

--插入本期网商数量到增长表
update analysis_business_list.platform_growth_2018v1 a
SET count_2019q2=b.sum
FROM (SELECT shop_type,platform,sum(count) from analysis_business_list.business_count_2019q2 group BY shop_type,platform) b 
where a.platform = b.platform AND a.shop_type = b.shop_type;

--计算本期各平台网商数增长率
update analysis_business_list.platform_growth_2018v1 SET rate_2019q2 = CAST(count_2019q2/count_2019q1-1 as numeric(10,2));

--查看增长率表
select * from analysis_business_list.platform_growth_2018v1 order BY rate_2019q2 desc;

--------------------------------------------------------------------------------------------------------------------------------

@@第五部分：调整平台网商数量
--变化较大的平台乘相应系数（全部平台网商数总和应大于上季度）
update analysis_business_list.business_count_2019q2  SET count = round(1.2*count) WHERE platform ~ '大众点评';
update analysis_business_list.business_count_2019q2  SET count = round(1.3*count) WHERE platform ~ '饿了么';
update analysis_business_list.business_count_2019q2  SET count = round(1.5*count) WHERE platform ~ '企业店铺';
update analysis_business_list.business_count_2019q2  SET count = round(2*count) WHERE platform ~ '百度糯米';



--------------------------------------------------------------------------------------------------------------------------------
@@第六部分：出数

select * from  analysis_business_list.business_count_2019q2



-- 单个网商数验证
select  count(*) from   analysis_business_list.meituan_waimai_unique  WHERE second_areaid='5132'




--查看Q1及Q2数据量
select count(*) from staging_sy_data.bt_meituan_shop_china_20190320;  --3114209
select count(*) from staging_sy_data.bt_meituan_shop_china_20190620;  --2770787

--查看shop_id不在0620中的店铺
select count(*)from staging_sy_data.bt_meituan_shop_china_20190320 where shop_id not in(select shop_id from  staging_sy_data.bt_meituan_shop_china_20190620)--438668

--验证Q1与Q2中url一致的店铺数量 
select count(*)from gather_service.ir_meituan_shop_china_2019 a,staging_sy_data.bt_meituan_shop_china_20190620 b --2623652
where a.shop_id=cast(b.shop_id as int)and a.url=b.url

SELECT shop_id,shop_name,url,status_06 FROM "gather_service"."ir_meituan_shop_china_2019"
where status_06 is null 
limit 100



