CREATE table   bt_taobao_product_china_all_detail_2019_agri  as SELECT * from  analysis_taobao.bt_taobao_product_china_all_detail_2018   
where   agri_keyid is not null and agri_keyid > 0 






alter TABLE   bt_taobao_product_china_all_detail_2019_agri  add COLUMN   factory_name   VARCHAR(255)
alter TABLE   bt_taobao_product_china_all_detail_2019_agri  add COLUMN   factory_address   VARCHAR(255)
alter TABLE   bt_taobao_product_china_all_detail_2019_agri  add COLUMN   agri_produce_first_addr   VARCHAR(255)
alter TABLE   bt_taobao_product_china_all_detail_2019_agri  add COLUMN   agri_produce_second_addr   VARCHAR(255)


update bt_taobao_product_china_all_detail_2019_agri  set factory_name = nullif(COALESCE(substring(prod_detail from '厂名\":\"(.+?)\"'),''),'')


update bt_taobao_product_china_all_detail_2019_agri 
set factory_address = nullif(COALESCE(substring(prod_detail from '厂址\":\"(.+?)\"'),''),'')


update bt_taobao_product_china_all_detail_2019_agri 
set agri_produce_first_addr = nullif(COALESCE(substring(prod_detail from '省份\":\"(.+?)\"'),''),'')





update bt_taobao_product_china_all_detail_2019_agri 
set agri_produce_second_addr = nullif(COALESCE(substring(prod_detail from '城市\":\"(.+?)\"'),''),'')::varchar(255)





SELECT * from  bt_taobao_product_china_all_detail_2019_agri where  agri_produce_first_addr is not null limit  200

analysis_test.bt_taobao_product_china_all_detail_2018_agri




ALTER TABLE bt_taobao_product_china_all_detail_2019_agri 
ADD address1 VARCHAR(255),
ADD area_brand1 VARCHAR(255),
ADD first_addr VARCHAR(50),
ADD second_add VARCHAR(50),
ADD third_addr VARCHAR(50),
ADD first_areaid VARCHAR(50),
ADD second_areaid VARCHAR(50),
ADD third_areaid VARCHAR(50);


ALTER TABLE bt_taobao_product_china_all_detail_2018_agri 
ADD address1 VARCHAR(255),
ADD area_brand1 VARCHAR(255),
ADD first_addr VARCHAR(50),
ADD second_addr VARCHAR(50),
ADD third_addr VARCHAR(50),
ADD first_areaid VARCHAR(50),
ADD second_areaid VARCHAR(50),
ADD third_areaid VARCHAR(50);


UPDATE bt_taobao_product_china_all_detail_2018_agri a SET address1=b.first_addr||b.second_addr||b.third_addr
FROM analysis_other.bs_ec_business_base_all b WHERE a.factory_name=b.name ;

UPDATE bt_taobao_product_china_all_detail_2019_agri a SET address1=b.first_addr||b.second_addr||b.third_addr
FROM analysis_other.bs_ec_business_base_all b WHERE a.factory_name=b.name ;


UPDATE bt_taobao_product_china_all_detail_2018_agri a SET area_brand1=b.areabrand_name
FROM gather_taobao.ir_taobao_product_trade_china_2018 b WHERE a.prod_id=b.prod_id ;

UPDATE bt_taobao_product_china_all_detail_2019_agri a SET area_brand1=b.areabrand_name
FROM gather_taobao.ir_taobao_product_trade_china_2019 b WHERE a.prod_id=b.prod_id ;



SELECT * FROM bt_taobao_product_china_all_detail_2019_agri WHERE address1 IS NOT NULL LIMIT 100
