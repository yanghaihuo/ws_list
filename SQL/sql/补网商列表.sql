--猪八戒填补服务型：
-- 巴彦淖尔
insert into  analysis_business_list.bt_ws_list_2019q2_compress (shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,third_areaid,status,level)
select cast(shop_id as varchar),name,'猪八戒' as platform,ability1,'其他服务' as first_cat ,'服务型' as shop_type,url,address,first_addr,second_addr,
third_addr,first_areaid,second_areaid,third_areaid,0 as status,0 as LEVEL
from gather_service.ir_zbj_shop_china_2018_list
where cast(third_areaid as int4) = 150899  and 
cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '猪八戒' ) 
limit 2


-- 衡水
insert into  analysis_business_list.bt_ws_list_2019q2_compress (shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,third_areaid,status,level)
select cast(shop_id as varchar),name,'猪八戒' as platform,ability1,'其他服务' as first_cat ,'服务型' as shop_type,url,address,first_addr,second_addr,
third_addr,first_areaid,second_areaid,third_areaid,0 as status,0 as LEVEL
from gather_service.ir_zbj_shop_china_2018_list
where cast(third_areaid as int4) = 131199  and 
cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '猪八戒' ) 
limit 13


-- 宁夏
insert into  analysis_business_list.bt_ws_list_2019q2_compress (shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,third_areaid,status,level)
select cast(shop_id as varchar),name,'猪八戒' as platform,ability1,'其他服务' as first_cat ,'服务型' as shop_type,url,address,first_addr,second_addr,
third_addr,first_areaid,second_areaid,third_areaid,0 as status,0 as LEVEL
from gather_service.ir_zbj_shop_china_2018_list 
where cast(second_areaid as int4) = 6401  and 
cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '猪八戒' ) 
limit 23


-- 内蒙古

15
1508
150102
150502


insert into  analysis_business_list.bt_ws_list_2019q2_compress (shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,third_areaid,status,level)
select cast(shop_id as varchar),name,'猪八戒' as platform,ability1,'其他服务' as first_cat ,'服务型' as shop_type,url,address,first_addr,second_addr,
third_addr,first_areaid,second_areaid,third_areaid,0 as status,0 as LEVEL
from gather_service.ir_zbj_shop_china_2018_list 
where cast(first_areaid as int4) = 15  and cast(second_areaid as int4)!=1508 and  cast(third_areaid as int4) not in (150102,150502) and
cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '猪八戒' ) 
limit 113


insert into  analysis_business_list.bt_ws_list_2019q2_compress (shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,third_areaid,status,level)
select cast(shop_id as varchar),name,'猪八戒' as platform,ability1,'其他服务' as first_cat ,'服务型' as shop_type,url,address,first_addr,second_addr,
third_addr,cast(first_areaid as int4),cast(second_areaid as int4),cast(third_areaid as int4),0 as status,0 as LEVEL
from gather_service.ir_epwk_shop_china_2016_list 
where cast(first_areaid as int4) = 15  and cast(second_areaid as int4)!=1508 and  cast(third_areaid as int4) not in (150102,150502) and
cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '猪八戒' ) 
limit 300


gather_service.ir_zbj_shop_china_2018_list
gather_service.ir_zbj_shop_china_2017
gather_service.ir_zbj_shop_china_2018_list
gather_service.ir_zbj_shop_china_2018 
gather_service.ir_zbj_shop_china_2019
gather_service.ir_sjcf_shop_china_2019_list
gather_service.ir_epwk_shop_china_2019_list


-- 淘宝补流通型   
insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,third_addr,
cast(first_areaid as int4),cast(second_areaid as int4),third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where analysis_taobao.bt_taobao_shop_china_all.third_areaid=653201 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 7




insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,third_addr,
cast(first_areaid as int4),cast(second_areaid as int4),third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=640521 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 43


insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)

select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,'宁夏' as first_addr,'中卫' as  second_addr,'中宁县' as third_addr,
64 as first_areaid ,6405 as second_areaid ,640521 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where first_areaid is null and  first_cat is not null
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 571
 



SELECT third_areaid,count(*),shop_type from analysis_business_list.bt_ws_list_2019q2_compress where third_areaid=610124 group by third_areaid,shop_type 



insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,'周至县' as third_addr,
cast(first_areaid as int4),cast(second_areaid as int4),610124 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=610199 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 894




insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)


select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr, third_addr,
cast(first_areaid as int4),cast(second_areaid as int4), third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=532801 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 



insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,'景洪市' as third_addr,
cast(first_areaid as int4),cast(second_areaid as int4),532801 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=532899 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 563


insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)

select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,'云南' as first_addr,'西双版纳' as  second_addr,'景洪市' as third_addr,
53 as first_areaid ,5328 as second_areaid ,532801 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where first_areaid is null and  first_cat is not null
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 739




insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,'临翔区' as third_addr,
cast(first_areaid as int4),cast(second_areaid as int4),530902 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=530999 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 258


insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,'岳池县' as third_addr,
cast(first_areaid as int4),cast(second_areaid as int4),511621 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=511699
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 881







insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,'沐川县' as third_addr,
cast(first_areaid as int4),cast(second_areaid as int4),511129 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=511199
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 240




insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,'资中县' as third_addr,
cast(first_areaid as int4),cast(second_areaid as int4),511025 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=511099
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 577




insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,'浦江县' as third_addr,
cast(first_areaid as int4),cast(second_areaid as int4),510131 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=510199
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 784


500240

insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,'县' as second_addr,'石柱县' as third_addr,
cast(first_areaid as int4),5002 as second_areaid ,500240 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=509999
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 2





insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,'市辖区' as second_addr,'武隆区' as third_addr,
50 as first_areaid , 5001 as second_areaid ,500156 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=509999 and address~'重庆'  
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 3079







insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,'新晃县' as third_addr,
cast(first_areaid as int4),second_areaid ,431227 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=431299
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 24




insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,'宜阳县' as third_addr,
cast(first_areaid as int4),second_areaid ,410327 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=410399
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 63






insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,'安图县' as third_addr,
cast(first_areaid as int4),second_areaid ,222426 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=222499
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 1311


60

insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,'延边' as second_addr,'安图县' as third_addr,
cast(first_areaid as int4),2224 as second_areaid ,222426 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=229999 and address~'延边' 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 60





insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,'和龙市' as third_addr,
cast(first_areaid as int4),second_areaid ,222406 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=222499
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 26



21
insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,'延边' as second_addr,'和龙市' as third_addr,
cast(first_areaid as int4),2224 as second_areaid ,222406 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=229999 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 21


222405


insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,'延边' as second_addr,'龙井市' as third_addr,
cast(first_areaid as int4),2224 as second_areaid ,222405 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=229999 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 119




insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr, '白城' as second_addr,'通榆县' as third_addr,
cast(first_areaid as int4),2208 as second_areaid ,220822 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=229999  
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 94


220821

insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr, '白城' as second_addr,'镇赉县' as third_addr,
cast(first_areaid as int4),2208 as second_areaid ,220821 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=229999  
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 266


220622

insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr, '白山' as second_addr,'靖宇县' as third_addr,
cast(first_areaid as int4),2206 as second_areaid ,220622 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=220699  
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 699

220581

insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr, '通化' as second_addr,'梅河口市' as third_addr,
cast(first_areaid as int4),2205 as second_areaid ,220581 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=220599 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 259


220323
insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr, '四平' as second_addr,'伊通县' as third_addr,
cast(first_areaid as int4),2203 as second_areaid ,220323 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=229999
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 283


150502

insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,'内蒙古' as first_addr, '通辽' as second_addr,'科尔沁区' as third_addr,
15 as first_areaid ,1505 as second_areaid ,150502 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where address~'内蒙古' 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 1169







insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,'内蒙古' as first_addr, '呼和浩特' as second_addr,'新城区' as third_addr,
15 as first_areaid ,1501 as second_areaid ,150102 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where first_areaid is null 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 59







141123

insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr, '吕梁' as second_addr,'兴县' as third_addr,
cast(first_areaid as int4),1411 as second_areaid ,141123 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=141199 and address~'吕梁'
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 239



140121

insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,  second_addr,'清徐县' as third_addr,
cast(first_areaid as int4),1401 as second_areaid ,140121 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=140199 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 45




insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,  second_addr,'饶阳县' as third_addr,
cast(first_areaid as int4),1311 as second_areaid ,131124 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=131199
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 18

131122


insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,  second_addr,'武邑县' as third_addr,
cast(first_areaid as int4),1311 as second_areaid ,131122 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=131199
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 43

130630

insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,  second_addr,'涞源县' as third_addr,
cast(first_areaid as int4),1306 as second_areaid ,130630 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=130699
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 869



5133


insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr, '甘孜' as  second_addr, '归口甘孜' as third_addr,
cast(first_areaid as int4),5133 as second_areaid ,513399 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where third_areaid=519999 and address='四川'
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 305



1508

insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,'内蒙古' as first_addr, '巴彦淖尔' as  second_addr, '归口巴彦淖尔' as third_addr,
15 as first_areaid ,1508 as second_areaid ,150899 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where  first_areaid is null 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 1619

640521
64   2730



insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,'宁夏' as first_addr,'归口宁夏' as second_addr,'归口宁夏' as third_addr,
64 as first_areaid ,6499 as second_areaid ,649999 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where  first_areaid is null 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 2730



insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,'内蒙古' as first_addr,'归口内蒙古' as second_addr,'归口内蒙古' as third_addr,
15 as first_areaid ,1599 as second_areaid ,159999 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where  first_areaid is null 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 15810



--慧聪填补生产型：
insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,'慧聪' as platform,main_prod,first_cat,shop_type2,url,address,'内蒙古' as first_addr,'归口内蒙古' as second_addr,'归口内蒙古' as third_addr,
15 as first_areaid ,1599 as second_areaid ,159999 as third_areaid,0 as status,0 as level
from gather_b2b_bulk.ir_hc360_shop_trade_china_2019
where  first_areaid is null  and  shop_type2='生产型' 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '慧聪' ) 
limit 769




