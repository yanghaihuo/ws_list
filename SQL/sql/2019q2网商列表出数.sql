##2019q2网商列表处理过程  
##生产所有合作地域网商列表  更新analysis_business_list.cooperation_area_list_2019q2   产出表analysis_business_list.bt_ws_list_2019q2
select analysis_business_list.business_list_v2019_v1(2)

SELECT count(*) from analysis_business_list.bt_ws_list_2019q2
##压缩表的大小  创建不对列压缩的表   每次压缩后需重新设置ID 更新ID
CREATE TABLE analysis_business_list.bt_ws_list_2019q2_compress WITH (appendonly=true,compresstype=zlib,compresslevel=5) AS SELECT * FROM   analysis_business_list.bt_ws_list_2019q2 DISTRIBUTED BY (id)

ALTER TABLE  analysis_business_list.bt_ws_list_2019q2_compress  drop COLUMN id
ALTER TABLE  analysis_business_list.bt_ws_list_2019q2_compress  add COLUMN id serial8


##查看可能存在地址解析问题的网商

select * from analysis_business_list.bt_ws_list_2019q2_compress where 
address not like '%'||second_addr||'%' AND 
address not like'%'||substr(third_addr,1,2)||'%' AND
address not like '%'||first_addr||'%' AND 
shop_name not like '%'||first_addr||'%' AND 
shop_name not like '%'||second_addr||'%' AND
shop_name not like '%'||substr(third_addr,1,2)||'%' AND platform !='淘宝' 

##清洗排序
SELECT analysis_business_list.clean_rank_v1('bt_ws_list_2019q2_compress')  

@@这一步很关键
UPDATE   analysis_business_list.bt_ws_list_2019q2_compress SET LEVEL=0 WHERE LEVEL is null



##查看数据体量，对不够的进行填补  归口数据填补指定地方的指定类型的数量  platform
SELECT third_areaid,count(*),shop_type from analysis_business_list.bt_ws_list_2019q2_compress where third_areaid in (SELECT areaid from analysis_business_list.cooperation_area_list_2019q2) group by third_areaid,shop_type 
UNION
SELECT second_areaid,count(*),shop_type from analysis_business_list.bt_ws_list_2019q2_compress where second_areaid in (SELECT areaid from analysis_business_list.cooperation_area_list_2019q2) group by second_areaid,shop_type 
UNION
SELECT first_areaid,count(*),shop_type from analysis_business_list.bt_ws_list_2019q2_compress where first_areaid in (SELECT areaid from analysis_business_list.cooperation_area_list_2019q2) group by first_areaid,shop_type 


--比如猪八戒填补服务型：
insert into  "analysis_business_list"."bt_ws_list_2019q2_compress"(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,third_areaid)
select cast(shop_id as varchar),name,'猪八戒' as platform,ability1,'其他服务','服务型' as shop_type,url,address,first_addr,second_addr,
'伊通县',first_areaid,second_areaid,220399
from gather_service.ir_zbj_shop_china_2018_list where cast(third_areaid as int4) = 220399 and cast(shop_id as varchar) not in(SELECT shop_id from 
 "analysis_business_list"."bt_ws_list_2019q2_compress" where platform = '猪八戒' and third_areaid = 220399) limit 3


-- 比如淘宝补流通型  梅河口市 
insert into  "analysis_business_list"."bt_wangshang_list_220581_mhk_2019q2_compress" 
(shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status)
select shop_id,shop_name,type,main_cat,first_cat,'流通型' as shop_type,url,address,first_addr,second_addr,'梅河口市',
cast(first_areaid as int4),cast(second_areaid as int4),220581,0
from analysis_taobao.bt_taobao_shop_china_all 
where analysis_taobao.bt_taobao_shop_china_all.third_areaid=220599 limit 378 



@@补服务型
insert into  analysis_business_list.bt_ws_list0_2019q1_220821 (shop_id,shop_name,platform,main_cat,first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,third_areaid,trade_level,status,LEVEL)

select cast(shop_id as varchar),name,'猪八戒' as platform,'其他行业' as main_cat,'其他行业' as first_cat,'服务型' as shop_type,url,address,first_addr,second_addr,
'镇赉县' as third_addr ,cast(first_areaid as int4),cast(second_areaid as int4),220821 as third_areaid,near_money_03 as trade_level,0 as status,0 as LEVEL
from gather_service.ir_zbj_shop_china_2019  where gather_service.ir_zbj_shop_china_2019 .third_areaid=220899  limit 12 ;


@@ 补流通型
insert into analysis_business_list.bt_ws_list0_2019q1_220821
(shop_id,shop_name,platform,main_cat, first_cat,shop_type,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,
third_areaid,status,LEVEL)

select shop_id,shop_name,  type  as platform , main_cat, first_cat, '流通型' as shop_type, url,address,first_addr,second_addr,'镇赉县' as third_addr,
cast(first_areaid as int4),cast(second_areaid as int4),'220821' as third_areaid,0 as status,0 as LEVEL
from analysis_taobao.bt_taobao_shop_china_all 
where analysis_taobao.bt_taobao_shop_china_all.third_areaid=220899 limit 265




@@刷新店铺状态
--工具刷新（数据太多跑不出来会报错，需保证每个合作区县前80条店铺存活）
--工具刷新地址：http://192.168.1.221:8082/xgj/index
--人工检查 (包括验证死亡和人为调整顺序)
(SELECT * from (SELECT id,shop_name,level,third_areaid as areaid,third_addr as addr,url,platform,row_number() over (PARTITION BY third_areaid order by level desc)as px from 
analysis_business_list.bt_ws_list_2019q2_compress where third_areaid in (SELECT areaid from analysis_business_list.cooperation_area_list_2019q2 where rank =3))t
where px <= 80 order by areaid,px)  UNION all 
(SELECT * from (SELECT id,shop_name,level,second_areaid as areaid,second_addr as addr,url,platform,row_number() over (PARTITION BY second_areaid order by level desc)as px from 
analysis_business_list.bt_ws_list_2019q2_compress where second_areaid in (SELECT areaid from analysis_business_list.cooperation_area_list_2019q2 where rank =2))t
where px <= 80 order by areaid,px ) UNION all
(SELECT * from (SELECT id,shop_name,level,first_areaid as areaid,first_addr as addr,url,platform,row_number() over (PARTITION BY first_areaid order by level desc)as px from 
analysis_business_list.bt_ws_list_2019q2_compress where first_areaid in (SELECT areaid from analysis_business_list.cooperation_area_list_2019q2 where rank =1))t
where px <= 80 order by areaid,px )


@@流程：先补后减

@@ 调平数据
--存储过程调平  先补后减   先是保证出的数比合作地域的多   再用下面的调平
--准备工作，需先导入表analysis_business_list.wangshang_list_diff_2019q2
SELECT tiaoshu_area('bt_ws_list_2019q2_compress'); --只能调平三级地域    --bt_ws_list_2019q2_compress  减去  wangshang_list_diff_2019q2 
SELECT tiaoshu_area_v3('bt_ws_list_2019q2_compress_backups'); --调平所有层级(但是需要优化新增加了合作省)

--人工调平上级：处理含有上下级关系的调平 ,依据每次天机客户实际情况进行,比如：三季度中存在内蒙古和下级区域（巴彦淖尔、科尔沁、新城区）有重叠
--前提：默认下级区域数据已经调平。
select ((select count(*) from bt_ws_list_2018q4_compress where first_areaid = 15 and shop_type = '平台型')-
(SELECT plat from wangshang_tj_2018q3 where id = 15))diff,'平台型' shop_type
UNION
select ((select count(*) from bt_ws_list_2018q4_compress where first_areaid = 15 and shop_type = '流通型')-
(SELECT liutong from wangshang_tj_2018q3 where id = 15))diff,'流通型' shop_type
UNION
select ((select count(*) from bt_ws_list_2018q4_compress where first_areaid = 15 and shop_type = '生产型')-
(SELECT shengchan from wangshang_tj_2018q3 where id = 15))diff,'生产型' shop_type
UNION
select ((select count(*) from bt_ws_list_2018q4_compress where first_areaid = 15 and shop_type = '服务型')-
(SELECT fuwu from wangshang_tj_2018q3 where id = 15))diff,'服务型' shop_type;

--diff>0时需要按类型删减
--举例内蒙古服务型多了2个（注意删减时,不能删减内蒙古中其他合作区县数据）
DELETE from analysis_business_list.bt_ws_list_2018q4_compress where id in (select id from analysis_business_list.bt_ws_list_2018q4_compress 
where first_areaid = 15 and (second_areaid != 1508 and third_areaid  not in(150102,150502)) and shop_type= '服务型' order by level asc limit 2);

DELETE from analysis_business_list.bt_ws_list_2018q4_compress where first_areaid = 15 and id in (select id from analysis_business_list.bt_ws_list_2018q4_compress 
where first_areaid = 15 and (second_areaid != 1508 and third_areaid not in(150102,150502)) and platform ~ '淘宝|美团外卖' and id is not NULL order by level asc limit 29896);



四级地域只出网商列表
@@取出武隆和蒲江：     石柱县四级 bt_wangshang_list_500240_sz_2019q2
--1、将调平后的武隆、蒲江网商插入到新建表
create table wangshang_list_xiangzhen_2019q2 as
select id,shop_id,shop_name,platform,shop_type,first_cat,url,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,third_areaid,level
from "analysis_business_list"."bt_ws_list_2019q2_compress" where third_areaid in ('500156','510131','500240');

--2、增加列fourth_addr,fourth_areaid
ALTER table wangshang_list_xiangzhen_2019q2 add fourth_addr varchar(255);
ALTER table wangshang_list_xiangzhen_2019q2 add fourth_areaid int4;

--3、和上期武隆数据匹配 
update wangshang_list_xiangzhen_2019q2 a set fourth_addr = b.fourth_addr,fourth_areaid = b.fourth_areaid
FROM wangshang_list_xiangzhen_2019q1 b where a.shop_id = b.shop_id and a.platform = b.platform; 

update wangshang_list_xiangzhen_2019q2 a set fourth_addr = b.fourth_addr,fourth_areaid = b.fourth_areaid
FROM analysis_business_list.bt_wangshang_list_500240_sz_2019q2  b where a.shop_id = b.shop_id and a.platform = b.platform; 




SELECT count(*) from wangshang_list_xiangzhen_2019q2 where fourth_areaid is not null --8872  这里要新建一个表与101行相对应
SELECT count(*) from wangshang_list_xiangzhen_2019q2 where fourth_areaid is null --6210  

--4、将fourth_areaid为空的提交给研发部进行解析
CREATE TABLE analysis_test.wangshang_list_xiangzhen_2019q2_jiexi as (SELECT id,shop_id,shop_name,platform,address,first_addr,second_addr,third_addr,fourth_addr,first_areaid,second_areaid,third_areaid,fourth_areaid FROM wangshang_list_xiangzhen_2019q2
where fourth_areaid is NULL)



--5、将研发解析的fourth_areaid和fourth_addr匹配到目标表
UPDATE wangshang_list_xiangzhen_2019q2 a set fourth_addr = b.fourth_addr,fourth_areaid = b.fourth_areaid
FROM ws_xz_data_20190706130653   b WHERE a.id  = b.id 



--6、检查四级地域ID和名称是否规范
SELECT third_areaid,third_addr,fourth_areaid,fourth_addr,count(*) from wangshang_list_xiangzhen_2019q2 group by third_areaid,third_addr,fourth_areaid,fourth_addr ORDER BY third_areaid


SELECT *  from  wangshang_list_xiangzhen_2019q2 where third_areaid = 500240  ORDER BY LEVEL desc 

update wangshang_list_xiangzhen_2019q2 SET  first_cat='食品保健'  WHERE id=242471
update wangshang_list_xiangzhen_2019q2 SET  first_cat='食品保健'  WHERE id=242503
update wangshang_list_xiangzhen_2019q2 SET  first_cat='服装鞋包'  WHERE id=232319
update wangshang_list_xiangzhen_2019q2 SET  first_cat='3C数码'  WHERE id=263053
update wangshang_list_xiangzhen_2019q2 SET  first_cat='服装鞋包'  WHERE id=262795


SELECT third_areaid,shop_type,"count"(*) from  wangshang_list_xiangzhen_2019q2 GROUP BY third_areaid,shop_type



--7、处理四级归口 
update wangshang_list_xiangzhen_2019q2 SET fourth_areaid = 510131999,fourth_addr = '' WHERE third_areaid = 510131 and fourth_areaid is NULL;
update wangshang_list_xiangzhen_2019q2 SET fourth_areaid = 500156999,fourth_addr = '' WHERE third_areaid = 500156 and fourth_areaid is NULL;
update wangshang_list_xiangzhen_2019q2 SET fourth_areaid = 500240999,fourth_addr = '' WHERE third_areaid = 500240 and fourth_areaid is NULL;




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
'2' as datatime_type ,'20192' as datatime FROM  analysis_business_list.bt_ws_list_2019q2_compress where second_areaid = 5133
ORDER by LEVEL ASC;







@@ 后面数据调整
UPDATE   analysis_business_list.bt_wangshang_list_500240_sz_2019q2  a   SET  fourth_areaid=b.fourth_areaid,fourth_addr=b.fourth_addr 
FROM     analysis_business_list.shizhu_wangshang b WHERE a.id=b.id2 and a.fourth_areaid is null


UPDATE   analysis_business_list.bt_wangshang_list_500240_sz_2019q2  set fourth_areaid=500240999 ,fourth_addr='归口石柱县' 
WHERE  fourth_areaid is null

UPDATE   analysis_business_list.bt_wangshang_list_500240_sz_2019q2  set   fourth_areaid=500240001 ,fourth_addr='南宾街道' 
WHERE  id=2951


select * from  analysis_business_list.bt_wangshang_list_500240_sz_2019q2 ORDER BY "level" desc limit  100


SELECT * FROM data_analysis_base.bs_area_2017_abbr_2 WHERE NAME='黄水镇'

SELECT  id,shop_id,shop_name as name,replace(first_addr||third_addr||fourth_addr,'0','') as area,
platform as plat_name,first_cat as main_areas, url,shop_type as type ,fourth_areaid as area_id,
'2' as datatime_type ,'20191' as datatime FROM analysis_business_list.bt_wangshang_list_500240_sz_2019q2  where third_areaid = 500240
ORDER by LEVEL ASC;



select * from  analysis_business_list.bt_wangshang_list_500240_sz_djx2_20190514112939  where shop_id='chongqing_city/dt-9966'


update analysis_business_list.bt_wangshang_list_500240_sz_djx2_20190514112939 set fourth_areaid = 500240001,fourth_addr= '南宾街道' where old_addr like '%南宾%';
update analysis_business_list.bt_wangshang_list_500240_sz_djx2_20190514112939 set fourth_areaid = 500240002,fourth_addr= '万安街道' where old_addr like '%万安%';
update analysis_business_list.bt_wangshang_list_500240_sz_djx2_20190514112939 set fourth_areaid = 500240003,fourth_addr= '下路街道' where old_addr like '%下路%';
update analysis_business_list.bt_wangshang_list_500240_sz_djx2_20190514112939 set fourth_areaid = 500240101,fourth_addr= '西沱镇' where old_addr like '%西沱%';



--diff>0时需要按类型删减
--举例内蒙古服务型多了2个（注意删减时,不能删减内蒙古中其他合作区县数据）
DELETE from analysis_business_list.bt_ws_list_2018q4_compress where id in (select id from analysis_business_list.bt_ws_list_2018q4_compress 
where first_areaid = 15 and (second_areaid != 1508 and third_areaid  not in(150102,150502)) and shop_type= '服务型' order by level asc limit 2);

DELETE from analysis_business_list.bt_ws_list_2018q4_compress where first_areaid = 15 and id in (select id from analysis_business_list.bt_ws_list_2018q4_compress 
where first_areaid = 15 and (second_areaid != 1508 and third_areaid not in(150102,150502)) and platform ~ '淘宝|美团外卖' and id is not NULL order by level asc limit 29896);



DELETE from analysis_business_list.bt_ws_list_2019q2_compress where  id in (select id from analysis_business_list.bt_ws_list_2019q2_compress 
where  third_areaid=511132 and platform ~ '淘宝|美团外卖|慧聪' and shop_type='流通型' order by level asc limit 212)



DELETE from analysis_business_list.bt_ws_list_2019q2_compress where  id in (select id from analysis_business_list.bt_ws_list_2019q2_compress 
where  third_areaid=469025 and platform ~ '淘宝|美团外卖|慧聪|饿了么星选' and shop_type='流通型' order by level asc limit 472)


DELETE from analysis_business_list.bt_ws_list_2019q2_compress where  id in 
(
select id from analysis_business_list.bt_ws_list_2019q2_compress 
where  second_areaid=1311 and  third_areaid not in(131122,131124) and platform ~ '淘宝|美团外卖' and shop_type='流通型' order by level asc limit 221
)


DELETE from analysis_business_list.bt_ws_list_2019q2_compress where  id in (select id  from analysis_business_list.bt_ws_list_2019q2_compress 
where  third_areaid=150102 and  shop_type='平台型' order by level asc limit 1)



DELETE from analysis_business_list.bt_ws_list_2019q2_compress where  id in 
(
select id from analysis_business_list.bt_ws_list_2019q2_compress 
where  first_areaid=15 and second_areaid!=1508 and  third_areaid not in(150102,150502) and shop_type='服务型' order by level asc limit 2
)

