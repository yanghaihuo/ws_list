--8、导出武隆的数据 （需更新字段：20183）
SELECT shop_name as name,replace(first_addr||third_addr||fourth_addr,'0','') as area,
platform as plat_name,first_cat as main_areas, url,shop_type as type ,fourth_areaid as area_id,
'2' as datatime_type ,'20192' as datatime FROM "analysis_business_list".wangshang_list_xiangzhen_2019q2 where third_areaid = 500156
ORDER by LEVEL ASC;

--9、导出蒲江的数据 （需更新字段：20183）
SELECT shop_name as name,replace(first_addr||third_addr||fourth_addr,'0','') as area,
platform as plat_name,first_cat as main_areas, url,shop_type as type ,fourth_areaid as area_id,
'2' as datatime_type ,'20192' as datatime FROM "analysis_business_list".wangshang_list_xiangzhen_2019q2 where third_areaid = 510131
ORDER by LEVEL ASC;


--10、导出石柱的数据 （需更新字段：20183）
SELECT shop_name as name,replace(first_addr||third_addr||fourth_addr,'0','') as area,
platform as plat_name,first_cat as main_areas, url,shop_type as type ,fourth_areaid as area_id,
'2' as datatime_type ,'20192' as datatime FROM "analysis_business_list".wangshang_list_xiangzhen_2019q2 where third_areaid = 500240
ORDER by LEVEL ASC;




@@导出合作区县网商列表
--具体需导出区域参考合作地域表
--需要提交的字段有：`name`, `area`, `plat_name`, `main_areas`, `url`, `type`, `area_id`, `datatime_type`, `datatime`
--datatime_type说明: 日期类型 1年   2季度  3月  4累计年  5累计季  6累计月    datatime说明:日期     举例：2018年2季度则,datatime_type=2,datatime=20182
--武邑县


SELECT shop_name as name,replace(first_addr||second_addr||third_addr,'0','') as area,
platform as plat_name,first_cat as main_areas, url,shop_type as type ,third_areaid as area_id,
'2' as datatime_type ,'20192' as datatime FROM   analysis_business_list.bt_ws_list_2019q2_compress where second_areaid =1508
ORDER by LEVEL ASC;


清徐县2019Q2网商列表_140121





SELECT *  FROM   analysis_business_list.bt_ws_list_2019q2_compress where third_areaid = 150102  ORDER BY level  desc limit 200

服装鞋包
其他行业
其他行业

update bt_ws_list_2019q2_compress set first_cat='服装鞋包' where id=265646;
update bt_ws_list_2019q2_compress set first_cat='其他行业' where id=334676;
update bt_ws_list_2019q2_compress set first_cat='家装家饰' where id=268683;
update bt_ws_list_2019q2_compress set first_cat='食品保健' where id=268683;






SELECT shop_type,"count"(*)   FROM   analysis_business_list.bt_ws_list_2019q2_compress where third_areaid = 150502 GROUP BY shop_type
SELECT shop_type,"count"(*)   FROM   analysis_business_list.bt_ws_list_2019q2_compress where second_areaid=1508 GROUP BY shop_type
SELECT shop_type,"count"(*)   FROM   analysis_business_list.bt_ws_list_2019q2_compress where first_areaid=15  GROUP BY shop_type


SELECT *  FROM   analysis_business_list.bt_ws_list_2019q2_compress where second_areaid = 1311  and  shop_name~'虎牌保险柜坤生专卖店'



delete from bt_ws_list_2019q2_compress where shop_id in
(SELECT shop_id   FROM   analysis_business_list.bt_ws_list_2019q2_compress where third_areaid =159999 and shop_type='流通型' and first_cat is null limit 108)




SELECT * from bt_ws_list_2019q2_compress where third_areaid=159999 and shop_type='流通型'



update bt_ws_list_2019q2_compress set second_addr='巴彦淖尔',second_areaid=1508,third_areaid=150899,third_addr='归口巴彦淖尔' where id=732801 and  third_areaid=159999 and shop_type='流通型'


insert into   analysis_business_list.bt_ws_list_2019q2_compress 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,level)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,'内蒙古' as first_addr,'归口内蒙古' as second_addr,'归口内蒙古' as third_addr,
15 as first_areaid ,1599 as second_areaid ,159999 as third_areaid,0 as status,0 as level
from analysis_taobao.bt_taobao_shop_china_all 
where  first_areaid is null 
and  cast(shop_id as varchar) not in(SELECT shop_id from analysis_business_list.bt_ws_list_2019q2_compress where platform = '淘宝' ) 
limit 1



SELECT shop_name as name,replace(first_addr||second_addr||third_addr,'0','') as area,
platform as plat_name,first_cat as main_areas, url,shop_type as type ,third_areaid as area_id,
'2' as datatime_type ,'20192' as datatime FROM  analysis_business_list.bt_ws_list0_2019q2_5133_new where second_areaid = 5133
ORDER by LEVEL ASC;





