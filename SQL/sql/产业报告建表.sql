--淘宝建表语句
CREATE TABLE gather_industry.ir_industry_lizi_taobao_2018 AS 
SELECT 
p1.prod_id,p1.prod_name,p1.url,p1.agri_firstcat,p1.agri_seccat,p1.agri_thirdcat,p1.first_cat,p1.second_cat,p1.third_cat,p1.forth_cat,
p1.shop_id,p3.shop_name,p3.first_areaid,p3.first_addr,p3.second_areaid,p3.second_addr,p3.third_areaid,p3.third_addr,p1.brand_name,p1.areabrand_name,
p1.produce_first_areaid,p1.produce_first_addr,p1.produce_second_areaid,p1.produce_second_addr,p1.produce_third_areaid,p1.produce_third_addr,
COALESCE(p1.month_money_01,0)+COALESCE(p1.month_money_02,0)+COALESCE(p1.month_money_03,0)+COALESCE(p1.month_money_04,0)+COALESCE(p1.month_money_05,0)+COALESCE(p1.month_money_06,0)+
COALESCE(p1.month_money_07,0)+COALESCE(p1.month_money_08,0)+COALESCE(p1.month_money_09,0)+COALESCE(p1.month_money_10,0)+COALESCE(p1.month_money_11,0)+COALESCE(p1.month_money_12,0) as money,
COALESCE(p1.month_amount_01,0)+COALESCE(p1.month_amount_02,0)+COALESCE(p1.month_amount_03,0)+COALESCE(p1.month_amount_04,0)+COALESCE(p1.month_amount_05,0)+COALESCE(p1.month_amount_06,0)+
COALESCE(p1.month_amount_07,0)+COALESCE(p1.month_amount_08,0)+COALESCE(p1.month_amount_09,0)+COALESCE(p1.month_amount_10,0)+COALESCE(p1.month_amount_11,0)+COALESCE(p1.month_amount_12,0) AS amount,
p1.month_money_01,p1.month_money_02,p1.month_money_03,p1.month_money_04,p1.month_money_05,p1.month_money_06,p1.month_money_07,p1.month_money_08,p1.month_money_09,p1.month_money_10,p1.month_money_11,p1.month_money_12,
p1.month_amount_01,p1.month_amount_02,p1.month_amount_03,p1.month_amount_04,p1.month_amount_05,p1.month_amount_06,p1.month_amount_07,p1.month_amount_08,p1.month_amount_09,p1.month_amount_10,p1.month_amount_11,p1.month_amount_12,
p2.prod_detail
FROM gather_taobao.ir_taobao_product_trade_china_2018 p1,analysis_taobao.bt_taobao_product_china_all_detail_2018 p2,analysis_taobao.bt_taobao_shop_china_all p3
WHERE p1.prod_id=p2.prod_id AND p1.shop_id=p3.shop_id 
AND (p1.agri_thirdcat='李子' OR (p1.prod_name~'李子' AND p1.prod_name~'新鲜|现摘')) AND p1.prod_name!~'零食|果干|树苗|中药材|李子仁|李子苗|果脯|蜜饯|非李子|西梅|李子干|乳饮料|牛奶'  
ORDER BY money DESC ;
--淘宝插入字段
ALTER TABLE gather_industry.ir_industry_lizi_taobao_2018 ADD price NUMERIC(16,4),ADD weight NUMERIC(16,4),
ADD key_word VARCHAR(50),ADD company VARCHAR(255),ADD address VARCHAR(255),add shipping_addr VARCHAR(255),add commentnum INT8;
--淘宝插入新抓数据
INSERT INTO gather_industry.ir_industry_lizi_taobao_2018(
prod_id,prod_name,url,shop_id,shop_name,brand_name,shipping_addr,commentnum,price,weight,amount,money)
SELECT prod_id,prod_name,url,shop_id,shop_name,brand_name,shipping_addr,commentnum,price,"Net_weight",month_amount*5 amount,price*month_amount*5 money
FROM staging_sy_data.bt_taobao_product_chanye_20190902 WHERE prod_id NOT in (SELECT prod_id FROM gather_industry.ir_industry_lizi_taobao_2018);
--淘宝更新非新增部分
UPDATE gather_industry.ir_industry_lizi_taobao_2018 a SET 
money=b.price*month_amount*5,amount=b.month_amount*5
FROM staging_sy_data.bt_taobao_product_chanye_20190902 b WHERE a.prod_id=b.prod_id AND (a.money<b.price*month_amount*5 OR a.money IS NULL);
--淘宝更新地域
UPDATE gather_industry.ir_industry_lizi_taobao_2018 a SET 
first_addr=b.first_addr,second_addr=b.second_addr,third_addr=b.third_addr,
first_areaid=b.first_areaid,second_areaid=b.second_areaid,third_areaid=b.third_areaid
FROM  analysis_taobao.bt_taobao_shop_china_all b WHERE a.shop_id=b.shop_id;

--京东建表语句
CREATE TABLE gather_industry.ir_industry_lizi_jd_2018 AS
SELECT 
p1.prod_id,p1.prod_name,p1.url,p1.agri_firstcat,p1.agri_seccat,p1.agri_thirdcat,p1.prod_firstcat first_cat,p1.prod_seccat second_cat,
p1.shop_id,p2.shop_name,p2.first_areaid,p2.first_addr,p2.second_areaid,p2.second_addr,p2.third_areaid,p2.third_addr,p1.brand_name,p1.areabrand_name,
COALESCE(p1.month_money_01,0)+COALESCE(p1.month_money_02,0)+COALESCE(p1.month_money_03,0)+COALESCE(p1.month_money_04,0)+COALESCE(p1.month_money_05,0)+COALESCE(p1.month_money_06,0)+
COALESCE(p1.month_money_07,0)+COALESCE(p1.month_money_08,0)+COALESCE(p1.month_money_09,0)+COALESCE(p1.month_money_10,0)+COALESCE(p1.month_money_11,0)+COALESCE(p1.month_money_12,0) as money,
COALESCE(p1.month_commentnum_01,0)+COALESCE(p1.month_commentnum_02,0)+COALESCE(p1.month_commentnum_03,0)+COALESCE(p1.month_commentnum_04,0)+COALESCE(p1.month_commentnum_05,0)+COALESCE(p1.month_commentnum_06,0)+
COALESCE(p1.month_commentnum_07,0)+COALESCE(p1.month_commentnum_08,0)+COALESCE(p1.month_commentnum_09,0)+COALESCE(p1.month_commentnum_10,0)+COALESCE(p1.month_commentnum_11,0)+COALESCE(p1.month_commentnum_12,0) AS commentnum,
p1.month_money_01,p1.month_money_02,p1.month_money_03,p1.month_money_04,p1.month_money_05,p1.month_money_06,p1.month_money_07,p1.month_money_08,p1.month_money_09,p1.month_money_10,p1.month_money_11,p1.month_money_12,
p1.month_commentnum_01,p1.month_commentnum_02,p1.month_commentnum_03,p1.month_commentnum_04,p1.month_commentnum_05,p1.month_commentnum_06,p1.month_commentnum_07,p1.month_commentnum_08,p1.month_commentnum_09,p1.month_commentnum_10,p1.month_commentnum_11,p1.month_commentnum_12,
p1.prod_detail
FROM gather_kind.ir_jd_product_trade_china_2018 p1,gather_kind.ir_jd_shop_trade_china_2018 p2
WHERE p1.shop_id=p2.shop_id 
AND (p1.agri_thirdcat='李子' OR (p1.prod_name~'李子' AND p1.prod_name~'新鲜|现摘')) AND p1.prod_name!~'零食|果干|树苗|中药材|李子仁|李子苗|果脯|蜜饯|非李子|西梅|李子干|乳饮料|牛奶'  
ORDER BY money DESC ;
--京东查询新抓部分
ALTER TABLE gather_industry.ir_industry_lizi_jd_2018 ADD price NUMERIC(16,4),ADD weight NUMERIC(16,4),ADD key_word VARCHAR(255),ADD company VARCHAR(255),ADD address VARCHAR(255)
--京东插入新抓数据
INSERT INTO gather_industry.ir_industry_lizi_jd_2018
(prod_id,prod_name,url,shop_id,shop_name,brand_name,commentnum,price,weight,money,company)
SELECT CAST(prod_id AS INT8),prod_name,url,shop_id,shop_name,brand_name,commentnum,price,weight,price*commentnum money,company
FROM staging_sy_data.bt_jd_chanye_20190902 WHERE CAST(prod_id AS VARCHAR) NOT in (SELECT CAST(prod_id AS VARCHAR) FROM gather_industry.ir_industry_lizi_jd_2018);
--京东更新非新增部分
UPDATE gather_industry.ir_industry_lizi_jd_2018 a SET 
money=b.price*b.commentnum,commentnum=b.commentnum
FROM staging_sy_data.bt_jd_chanye_20190902 b WHERE a.prod_id=CAST(b.prod_id AS INT8) AND (a.money<b.price*b.commentnum OR a.money IS NULL);
--京东更新地域
UPDATE gather_industry.ir_industry_lizi_jd_2018 a SET 
first_addr=b.first_addr,second_addr=b.second_addr,third_addr=b.third_addr,
first_areaid=b.first_areaid,second_areaid=b.second_areaid,third_areaid=b.third_areaid
FROM  gather_kind.ir_jd_shop_trade_china_2018 b WHERE a.shop_id=b.shop_id;

UPDATE gather_industry.ir_industry_lizi_jd_2018 a SET 
first_addr=b.first_addr,second_addr=b.second_addr,third_addr=b.third_addr,
first_areaid=CAST(b.first_areaid AS INT4),second_areaid=CAST(b.second_areaid AS INT4),third_areaid=CAST(b.third_areaid AS INT4)
FROM analysis_other.bs_ec_business_base_all b WHERE a.company=b.name	