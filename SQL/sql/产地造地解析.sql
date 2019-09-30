-- insert into "sy_taobao"."bt_taobao_product_info_jiexi_20180816" select * from bt_taobao_product_info_jiexi_20180719 limit 100000;
-- --使用覆盖策略 先提取厂名
-- 在mining——testdb下新建一张表，先取1000条数据

mining_testdb.bt_taobao_product_china_all_detail_2018_yh
mining_testdb.bt_taobao_product_china_all_detail_2019_yh


-- @@将产地造地没有的先筛选出来
create table mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm 
as select * from staging_tb_data.bt_taobao_product_info_jiexi_20180803 ;

UPDATE  mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm set product_enterprise_id=NULL,product_enterprise=NULL,produce_address = NULL,
produce_first_addr=NULL,produce_second_addr=NULL,produce_third_addr=NULL,produce_first_areaid=NULL,produce_second_areaid=NULL,produce_third_areaid=NULL,
prod_detail_madeinid=NULL,prod_detail_factory_addrid=NULL,prod_detail_factory_name_addrid=NULL;


--生产企业
update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm 
set product_enterprise = nullif(COALESCE(substring(prod_detail from '厂名\":\"(.+?)\"'),''),'');


--更新企业id  analysis_other.bs_ec_business_base_all 企业库
update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm a
set product_enterprise_id = b.id
from analysis_other.bs_ec_business_base_all b
where a.product_enterprise = b.name and a.product_enterprise is not null;


--将企业库中的企业地址提取到 produce_address 上来
update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm a
set produce_address = b.address
from analysis_other.bs_ec_business_base_all b
where a.product_enterprise_id = b.id and a.product_enterprise_id is not null ;


--使用地域解析程序解析 企业地址的地域信息 将解析后的表更名为bt_taobao_product_info_jiexi_20180816 继续后续解析
--将对应字段更新到prod_detail_factory_name_addrid
update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm 
set prod_detail_factory_name_addrid = produce_third_areaid where prod_detail_factory_name_addrid is null;


update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm 
set prod_detail_factory_name_addrid = produce_second_areaid where prod_detail_factory_name_addrid is null;


update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm 
set prod_detail_factory_name_addrid = produce_first_areaid where prod_detail_factory_name_addrid is null;



---将厂址提取到produce_address上 并清空这部分的地址解析结果
update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm 
set produce_address = nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) 
where nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) is not null;



-- select count(1) from "sy_taobao"."bt_taobao_product_info_jiexi_20180816" where nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) is null;
update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm 
set produce_first_addr = null,produce_first_areaid = null,produce_second_addr=null,produce_second_areaid=null,
produce_third_addr=null,produce_third_areaid = null 
where nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) is not null;




--使用地址解析程序 解析厂址所对应的地址 将解析后的带时间戳的结果表更名为bt_taobao_product_info_jiexi_20180816 继续后续解析
--将对应字段更新到prod_detail_factory_addrid
update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm set prod_detail_factory_addrid = produce_third_areaid
 where prod_detail_factory_addrid is null and nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) is not null;


update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm set prod_detail_factory_addrid = produce_second_areaid 
where prod_detail_factory_addrid is null and nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) is not null;


update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm set prod_detail_factory_addrid = produce_first_areaid 
where prod_detail_factory_addrid is null and nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')::varchar(255) is not null;



--提取产地城市到produce_address 并清空这部分的地址解析结果
-- select nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'') from "sy_taobao"."bt_taobao_product_info_jiexi_20180816" limit 1000;

update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm 
set produce_address = nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255)
where nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255) is not null;




update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm 
set produce_first_addr = null,produce_first_areaid = null,produce_second_addr=null,produce_second_areaid=null,
produce_third_addr=null,produce_third_areaid = null 
where nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255) is not null;



--使用地址解析程序 解析厂址所对应的地址 将解析后的带时间戳的结果表更名为bt_taobao_product_info_jiexi_20180816 继续后续解析
--将对应字段更新到prod_detail_madeinid

update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm set prod_detail_madeinid = produce_third_areaid 
where prod_detail_madeinid is null and nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255) is not null;


update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm set prod_detail_madeinid = produce_second_areaid 
where prod_detail_madeinid is null and nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255) is not null;


update mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm set prod_detail_madeinid = produce_first_areaid 
where prod_detail_madeinid is null and nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),'')||COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255) is not null;



---查看效果
select * from mining_testdb.bt_taobao_product_info_jiexi_20180816_wjm 
where prod_detail_madeinid is not null and prod_detail_factory_addrid is not null and prod_detail_factory_name_addrid is not null;
















