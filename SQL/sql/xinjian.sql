create table  ir_taobao_product_trade_china_201807to201906  as SELECT * from  gather_taobao.ir_taobao_product_trade_china_2018  


UPDATE  ir_taobao_product_trade_china_201807to201906   set price_01=null,price_02=null,price_03=null,price_04=null,price_05=null,price_06=null,
month_amount_01=null,month_amount_02=null,month_amount_03=null,month_amount_04=null,month_amount_05=null,month_amount_06=null,
month_money_01=null,month_money_02=null,month_money_03=null,month_money_04=null,month_money_05=null,month_money_06=null 



update ir_taobao_product_trade_china_201807to201906  a set  price_01=b.price_01,price_02=b.price_02,price_03=b.price_03,price_04=b.price_04,price_05=b.price_05,price_06=b.price_06
from  gather_taobao.ir_taobao_product_trade_china_2019 b where a.prod_id=b.prod_id


update analysis_test.ir_taobao_product_trade_china_201807to201906 a set  month_amount_01=b.month_amount_01,month_amount_02=b.month_amount_02,month_amount_03=b.month_amount_03,month_amount_04=b.month_amount_04,month_amount_05=b.month_amount_05,month_amount_06=b.month_amount_06
from  gather_taobao.ir_taobao_product_trade_china_2019 b where a.prod_id=b.prod_id



update analysis_test.ir_taobao_product_trade_china_201807to201906 a set  month_money_01=b.month_money_01,month_money_02=b.month_money_02,month_money_03=b.month_money_03,month_money_04=b.month_money_04,month_money_05=b.month_money_05,month_money_06=b.month_money_06
from  gather_taobao.ir_taobao_product_trade_china_2019 b where a.prod_id=b.prod_id



INSERT INTO  ir_taobao_product_trade_china_201807to201906 (
id,prod_id,prod_name,url,shop_id,shop_name,type,company,first_areaid,second_areaid,third_areaid,address,first_addr,second_addr,third_addr,cid,prod_firstcat,prod_seccat,prod_sort,brand_id,brand_name,agri_keyword,agri_keyid,agri_firstcat,agri_seccat,agri_thirdcat,unit_price,unit,price_01,month_amount_01,month_money_01,price_02,month_amount_02,month_money_02,price_03,month_amount_03,month_money_03,price_04,month_amount_04,month_money_04,price_05,month_amount_05,month_money_05,price_06,month_amount_06,month_money_06
,createtime,creator,modifitime,modifier,yc_brand_id,brand_cname,areabrand_id,areabrand_name,product_enterprise_id,product_enterprise,produce_first_areaid,produce_second_areaid,produce_third_areaid,produce_first_addr,produce_second_addr,produce_third_addr,prod_detail_madeinid,prod_detail_factory_addrid,prod_detail_factory_name_addrid,catid_y,first_cat,second_cat,third_cat,forth_cat
)
SELECT 
a.id,a.prod_id,a.prod_name,a.url,a.shop_id,a.shop_name,a.type,a.company,a.first_areaid,a.second_areaid,a.third_areaid,a.address,a.first_addr,a.second_addr,a.third_addr,a.cid,a.prod_firstcat,a.prod_seccat,a.prod_sort,a.brand_id,a.brand_name,a.agri_keyword,a.agri_keyid,a.agri_firstcat,a.agri_seccat,a.agri_thirdcat,a.unit_price,a.unit,a.price_01,a.month_amount_01,a.month_money_01,a.price_02,a.month_amount_02,a.month_money_02,a.price_03,a.month_amount_03,a.month_money_03,a.price_04,a.month_amount_04,a.month_money_04,a.price_05,a.month_amount_05,a.month_money_05,a.price_06,a.month_amount_06,a.month_money_06
,a.createtime,a.creator,a.modifitime,a.modifier,a.yc_brand_id,a.brand_cname,a.areabrand_id,a.areabrand_name,a.product_enterprise_id,a.product_enterprise,a.produce_first_areaid,a.produce_second_areaid,a.produce_third_areaid,a.produce_first_addr,a.produce_second_addr,a.produce_third_addr,a.prod_detail_madeinid,a.prod_detail_factory_addrid,a.prod_detail_factory_name_addrid,a.catid_y,a.first_cat,a.second_cat,a.third_cat,a.forth_cat
from   gather_taobao.ir_taobao_product_trade_china_2019 a LEFT JOIN   ir_taobao_product_trade_china_201807to201906 b on a.prod_id=b.prod_id where  b.prod_id is null









