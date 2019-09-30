-- insert into "sy_taobao"."bt_taobao_product_china_all_detail_2018_yh_cz1" select * from bt_taobao_product_info_jiexi_20180719 limit 100000
-- --使用覆盖策略 先提取厂名
-- 在mining——testdb下新建一张表，先取1000条数据

mining_testdb.bt_taobao_product_china_all_detail_2019_yh


1.更改表名 
alter table 表名 rename to 新表名

2.更改字段名
alter table 表名 rename 字段名 to 新字段名

alter table cz1 rename id to ids

ALTER TABLE  cz1 add COLUMN id serial

alter table cz1 rename to cz2019
alter table cz rename to cz2018


-- @@将产地造地没有的先筛选出来
create table cz1  as select * from mining_testdb.bt_taobao_product_china_all_detail_2019_yh   


ALTER TABLE   cz1 add COLUMN  produce_address  varchar(255)

alter table cz1  rename  id to ids   

ALTER TABLE  cz1 add COLUMN id serial

SELECT "count"(*) from cz1_20190611160112   38901816
SELECT "count"(id) from cz1

UPDATE  cz1 set product_enterprise_id=NULL,product_enterprise=NULL,produce_address = NULL,
produce_first_addr=NULL,produce_second_addr=NULL,produce_third_addr=NULL,produce_first_areaid=NULL,produce_second_areaid=NULL,produce_third_areaid=NULL,
prod_detail_madeinid=NULL,prod_detail_factory_addrid=NULL,prod_detail_factory_name_addrid=NULL



@@造地  厂名 + 厂址
--生产企业
update cz1 set product_enterprise = nullif(COALESCE(substring(prod_detail from '厂名\":\"(.+?)\"'),''),'')


--更新企业id  analysis_other.bs_ec_business_base_all 企业库
update cz1 a
set product_enterprise_id = b.id
from analysis_other.bs_ec_business_base_all b
where a.product_enterprise = b.name and a.product_enterprise is not null


--将企业库中的企业地址提取到 produce_address 上来
update cz1 a
set produce_address = b.address
from analysis_other.bs_ec_business_base_all b
where a.product_enterprise_id = b.id and a.product_enterprise_id is not null 


--第一次：使用地域解析程序解析 企业地址的地域信息 将解析后的表更名为bt_taobao_product_china_all_detail_2018_yh_cz1 继续后续解析
--将对应字段更新到prod_detail_factory_name_addrid
alter table cz1_20190611160112  rename to cz1

update cz1 set prod_detail_factory_name_addrid = produce_third_areaid where prod_detail_factory_name_addrid is null


update cz1 set prod_detail_factory_name_addrid = produce_second_areaid where prod_detail_factory_name_addrid is null


update cz1 set prod_detail_factory_name_addrid = produce_first_areaid where prod_detail_factory_name_addrid is null



---将厂址提取到produce_address上 并清空这部分的地址解析结果
update cz1 
set produce_address = nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) 
where nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) is not null

ALTER table cz1 alter COLUMN produce_address type  VARCHAR(255)

-- select count(1) from "sy_taobao"."bt_taobao_product_china_all_detail_2018_yh_cz1" where nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) is null
update cz1 
set produce_first_addr = null,produce_first_areaid = null,produce_second_addr=null,produce_second_areaid=null,
produce_third_addr=null,produce_third_areaid = null 
where nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) is not null


--第二次： 使用地址解析程序 解析厂址所对应的地址 将解析后的带时间戳的结果表更名为bt_taobao_product_china_all_detail_2018_yh_cz1 继续后续解析
--将对应字段更新到prod_detail_factory_addrid
alter table cz1_20190613091922  rename to cz1

update cz1 set prod_detail_factory_addrid = produce_third_areaid
 where prod_detail_factory_addrid is null and nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) is not null


update cz1 set prod_detail_factory_addrid = produce_second_areaid 
where prod_detail_factory_addrid is null and nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) is not null


update cz1 set prod_detail_factory_addrid = produce_first_areaid 
where prod_detail_factory_addrid is null and nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) is not null





@@ 产地  省份 +  城市 
--提取产地城市到produce_address 并清空这部分的地址解析结果
-- select nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'') from "sy_taobao"."bt_taobao_product_china_all_detail_2018_yh_cz1" limit 1000

update cz1 
set produce_address = nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255)
where nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255) is not null




update cz1 
set produce_first_addr = null,produce_first_areaid = null,produce_second_addr=null,produce_second_areaid=null,
produce_third_addr=null,produce_third_areaid = null 
where nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255) is not null



--第三次：  使用地址解析程序 解析厂址所对应的地址 将解析后的带时间戳的结果表更名为bt_taobao_product_china_all_detail_2018_yh_cz1 继续后续解析
--将对应字段更新到prod_detail_madeinid
alter table cz1_20190613105547  rename to cz1



update cz1 set prod_detail_madeinid = produce_third_areaid 
where prod_detail_madeinid is null and nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255) is not null


update cz1 set prod_detail_madeinid = produce_second_areaid 
where prod_detail_madeinid is null and nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255) is not null


update cz1 set prod_detail_madeinid = produce_first_areaid 
where prod_detail_madeinid is null and nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255) is not null



---查看效果
select * from cz1 where prod_detail_madeinid is not null and prod_detail_factory_addrid is not null and prod_detail_factory_name_addrid is not null


ALTER table cz1 drop COLUMN id 
alter table cz1 rename ids to id


prod_detail_madeinid  产地
prod_detail_factory_addrid   厂址  造地
prod_detail_factory_name_addrid  厂名  造地






