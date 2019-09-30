--四川农产品行业结构 
--零售额 
SELECT  agri_firstcat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan GROUP BY 
agri_firstcat

-- 同比
select   a.agri_firstcat, (b.total - a.total)/a.total as weight from 
 (SELECT  agri_firstcat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2017_sichuan GROUP BY 
 agri_firstcat)  as b  JOIN
 (SELECT  agri_firstcat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan GROUP BY 
agri_firstcat)  as a ON  a.agri_firstcat=b.agri_firstcat  


--成都农产品行业结构 
--零售额 
SELECT  agri_firstcat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0) +COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan where second_addr='成都'   GROUP BY 
agri_firstcat ORDER BY total DESC

-- 同比
select   a.agri_firstcat, (b.total - a.total)/a.total as weight from 
 (SELECT  agri_firstcat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2017_sichuan WHERE second_addr='成都' GROUP BY 
 agri_firstcat)  as b  JOIN
 (SELECT  agri_firstcat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan  GROUP BY 
agri_firstcat)  as a ON  a.agri_firstcat=b.agri_firstcat 



-- 四川坚果网络零售热销品类TOP10
--零售额 
SELECT  agri_thirdcat , sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0) +month_money_06+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan where  agri_firstcat
='坚果'    GROUP BY 
agri_thirdcat   ORDER BY total desc LIMIT 500


-- 同比
select   a.agri_thirdcat, CASE when a.total =0  then null else (b.total - a.total)/a.total   end  as weight from 
 (SELECT  agri_thirdcat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2017_sichuan WHERE agri_firstcat
='坚果' GROUP BY 
 agri_thirdcat)  as b  JOIN
 (SELECT  agri_thirdcat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan  GROUP BY 
agri_thirdcat)  as a ON  a.agri_thirdcat=b.agri_thirdcat  ORDER BY  weight desc LIMIT 500 




-- 成都坚果网络零售热销品类TOP10
--零售额 
SELECT  agri_thirdcat , sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan where  agri_firstcat
='坚果' AND second_addr='成都'   GROUP BY 
agri_thirdcat   ORDER BY total desc LIMIT 500


-- 同比
select   a.agri_thirdcat, CASE when a.total =0  then null else (b.total - a.total)/a.total   end  as weight from 
 (SELECT  agri_thirdcat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2017_sichuan WHERE agri_firstcat
='坚果'  and second_addr='成都' GROUP BY 
 agri_thirdcat)  as b  JOIN
 (SELECT  agri_thirdcat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan  GROUP BY 
agri_thirdcat)  as a ON  a.agri_thirdcat=b.agri_thirdcat  ORDER BY  weight desc LIMIT 500 





--四川农产品热销品类
--零售额 
SELECT  agri_seccat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan   GROUP BY 
agri_seccat 

-- 同比
select   a.agri_seccat, (b.total - a.total)/a.total as weight from 
 (SELECT  agri_seccat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2017_sichuan GROUP BY 
 agri_seccat)  as b  JOIN
 (SELECT  agri_seccat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan GROUP BY 
agri_seccat)  as a ON  a.agri_seccat=b.agri_seccat


--成都农产品热销品类 
--零售额 
SELECT  agri_seccat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan where second_addr='成都'   GROUP BY 
agri_seccat

-- 同比
select   a.agri_seccat, (b.total - a.total)/a.total as weight from 
 (SELECT  agri_seccat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2017_sichuan WHERE second_addr='成都' GROUP BY 
 agri_seccat)  as b  JOIN
 (SELECT  agri_seccat,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan  GROUP BY 
agri_seccat)  as a ON  a.agri_seccat=b.agri_seccat 




select s.total/sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) 
 from analysis_test.ir_taobao_product_trade_china_2018_sichuan  d ,
 (SELECT agri_seccat,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan GROUP BY agri_seccat)  as s;








---201812s年“本地销”核桃网商数量
SELECT second_areaid, COUNT(shop_name)  from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' GROUP BY second_areaid

---201712s年“本地销”核桃网商数量
SELECT second_areaid, COUNT(shop_name)  from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' GROUP BY second_areaid

-- 映射表
SELECT DISTINCT second_areaid, second_addr from  analysis_test.ir_taobao_product_trade_china_2018_sichuan

-- “本地销”网商数量同比



---201812s年“本地卖”核桃网络零售额
SELECT second_areaid, sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' GROUP BY second_areaid

SELECT second_areaid, sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) from  analysis_test.ir_taobao_product_trade_china_2017_sichuan
WHERE agri_thirdcat='核桃' GROUP BY second_areaid


---201812s年核桃“本地产”网络零售额
SELECT  prod_detail_madeinid, sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' and produce_first_addr='四川' 
GROUP BY prod_detail_madeinid

-- 映射表
SELECT  prod_detail_madeinid,produce_second_addr from  analysis_test.ir_taobao_product_trade_china_2018_sichuan WHERE produce_first_addr='四川'  

-- “本地产”网络零售额同比
SELECT  prod_detail_madeinid, sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) from  analysis_test.ir_taobao_product_trade_china_2017_sichuan
WHERE agri_thirdcat='核桃' and produce_first_addr='四川' 
GROUP BY prod_detail_madeinid

-- 映射表
SELECT  prod_detail_madeinid,produce_second_addr from  analysis_test.ir_taobao_product_trade_china_2018_sichuan WHERE produce_first_addr='四川' 


---201812s年核桃“本地产”品牌数量
SELECT prod_detail_madeinid,COUNT(brand_name)
from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'
GROUP BY prod_detail_madeinid


---201812s年核桃“本地造”网络零售额
SELECT   prod_detail_factory_addrid, sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' GROUP BY  prod_detail_factory_addrid


-- 映射表
SELECT   prod_detail_factory_addrid,produce_second_addr from  analysis_test.ir_taobao_product_trade_china_2018_sichuan WHERE produce_first_addr='四川' 

SELECT   prod_detail_factory_addrid, sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) from  analysis_test.ir_taobao_product_trade_china_2017_sichuan
WHERE agri_thirdcat='核桃' GROUP BY  prod_detail_factory_addrid







--四川核桃分市州级区县
-- 2018年12s四川核桃“本地造”网络零售额top10区县
SELECT   prod_detail_factory_addrid, produce_third_areaid,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))  as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' GROUP BY  prod_detail_factory_addrid ,produce_third_areaid  ORDER BY total desc 
-- 2018年12s成都核桃“本地造”网络零售额top10区县  没有结果
SELECT   prod_detail_factory_addrid,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))  as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'   GROUP BY prod_detail_factory_addrid  ORDER BY total desc 
 





-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2018年12s四川核桃“本地销”网络零售额top20区县
SELECT second_areaid, third_areaid,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))  as total   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' GROUP BY second_areaid , third_areaid ORDER BY total desc limit 20

-- 2018年12s成都核桃“本地造”网络零售额top10区县
SELECT second_areaid, third_areaid,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))  as total   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' AND second_areaid=5101 GROUP BY second_areaid , third_areaid ORDER BY total desc limit 10


-- 2018年12四川核桃“本地产”网络零售额top20区县
SELECT  prod_detail_madeinid,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))  as total   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  GROUP BY prod_detail_madeinid ORDER BY total desc 




-- 2018年12s成都核桃“本地产”网络零售额top10区县

SELECT prod_detail_madeinid,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))  as total   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' GROUP BY prod_detail_madeinid ORDER BY total desc 







-- 四川核桃地域公共品牌
-- 网络零售额
SELECT  brand_cname,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))  as total   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  GROUP BY brand_cname ORDER BY total desc limit 30
-- 同比
select   a.brand_cname, CASE when a.total =0  then null else (b.total - a.total)/a.total   end  as weight from 
 (SELECT  brand_cname,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2017_sichuan GROUP BY 
 brand_cname)  as b  JOIN
 (SELECT  brand_cname,  sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0)) as total from  analysis_test.ir_taobao_product_trade_china_2018_sichuan GROUP BY 
brand_cname)  as a ON  a.brand_cname=b.brand_cname

-- 网商数
SELECT  brand_cname,count(shop_name)  as total   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  GROUP BY brand_cname ORDER BY total desc limit 30
-- 单品数
SELECT  brand_cname,count(prod_name)  as total   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  GROUP BY brand_cname ORDER BY total desc 


-- 企业网商数
SELECT  brand_cname,count(company)  as total   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  GROUP BY brand_cname ORDER BY total desc limit 30

-- 单价
SELECT  brand_cname,avg(unit_price)  as total   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  GROUP BY brand_cname 





-- 四川核桃区域公共品牌数量
SELECT distinct  brand_cname   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  GROUP BY brand_cname 
-- 成都核桃区域公共品牌数量
SELECT distinct  brand_cname   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' and second_areaid=5101 GROUP BY brand_cname 

-- 四川核桃区域公共品牌网络零售额
SELECT  brand_cname,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))  as total   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  GROUP BY brand_cname 

-- 成都核桃区域公共品牌网络零售额
SELECT  brand_cname,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+ COALESCE(month_money_08,0) + COALESCE(month_money_09,0) +COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))  as total   from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' AND second_areaid=5101  GROUP BY brand_cname 




-- 2018年12s四川核桃网络零售不同价格区间的单品数量及销量
SELECT (CASE WHEN unit_price <=20 THEN '20元及以下'
		 WHEN unit_price >20 AND unit_price <=30 THEN  '20<X<=30'
		 WHEN unit_price >30 AND unit_price <=40 THEN  '30<X<=40'
		 WHEN unit_price >40  AND unit_price <=50 THEN  '40<X<=50'
		 WHEN unit_price >50 AND unit_price <=60 THEN  '50<X<=60'
		 WHEN unit_price >60  AND unit_price <=70 THEN  '60<X<=70'
		 WHEN unit_price >70  AND unit_price <=80 THEN  '70<X<=80'
		 WHEN unit_price >80  THEN  '80以上' end) as a , count(prod_name) 
	FROM analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  GROUP BY a



SELECT (CASE WHEN unit_price <=20 THEN '20元及以下'
		 WHEN unit_price >20 AND unit_price <=30 THEN  '20<X<=30'
		 WHEN unit_price >30 AND unit_price <=40 THEN  '30<X<=40'
		 WHEN unit_price >40  AND unit_price <=50 THEN  '40<X<=50'
		 WHEN unit_price >50 AND unit_price <=60 THEN  '50<X<=60'
		 WHEN unit_price >60  AND unit_price <=70 THEN  '60<X<=70'
		 WHEN unit_price >70  AND unit_price <=80 THEN  '70<X<=80'
		 WHEN unit_price >80  THEN  '80以上' end) as a , sum(COALESCE(month_amount_01,0)+ COALESCE(month_amount_02,0) + COALESCE(month_amount_03,0) +COALESCE(month_amount_04,0)+COALESCE(month_amount_05,0) +COALESCE(month_amount_06,0)+COALESCE(month_amount_07,0)+ COALESCE(month_amount_08,0) + COALESCE(month_amount_09,0) +COALESCE(month_amount_10,0)+COALESCE(month_amount_11,0) +COALESCE(month_amount_12,0))  
	FROM analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  GROUP BY a

-- 2018年12s成都核桃核桃网络零售不同价格区间的单品数量及销量
SELECT (CASE WHEN unit_price <=20 THEN '20元及以下'
		 WHEN unit_price >20 AND unit_price <=30 THEN  '20<X<=30'
		 WHEN unit_price >30 AND unit_price <=40 THEN  '30<X<=40'
		 WHEN unit_price >40  AND unit_price <=50 THEN  '40<X<=50'
		 WHEN unit_price >50 AND unit_price <=60 THEN  '50<X<=60'
		 WHEN unit_price >60  AND unit_price <=70 THEN  '60<X<=70'
		 WHEN unit_price >70  AND unit_price <=80 THEN  '70<X<=80'
		 WHEN unit_price >80  THEN  '80以上' end) as a , count(prod_name) 
	FROM analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  AND second_areaid=5101 GROUP BY a




SELECT (CASE WHEN unit_price <=20 THEN '20元及以下'
		 WHEN unit_price >20 AND unit_price <=30 THEN  '20<X<=30'
		 WHEN unit_price >30 AND unit_price <=40 THEN  '30<X<=40'
		 WHEN unit_price >40  AND unit_price <=50 THEN  '40<X<=50'
		 WHEN unit_price >50 AND unit_price <=60 THEN  '50<X<=60'
		 WHEN unit_price >60  AND unit_price <=70 THEN  '60<X<=70'
		 WHEN unit_price >70  AND unit_price <=80 THEN  '70<X<=80'
		 WHEN unit_price >80  THEN  '80以上' end) as a , sum(COALESCE(month_amount_01,0)+ COALESCE(month_amount_02,0) + COALESCE(month_amount_03,0) +COALESCE(month_amount_04,0)+COALESCE(month_amount_05,0) +COALESCE(month_amount_06,0)+COALESCE(month_amount_07,0)+ COALESCE(month_amount_08,0) + COALESCE(month_amount_09,0) +COALESCE(month_amount_10,0)+COALESCE(month_amount_11,0) +COALESCE(month_amount_12,0))  
	FROM analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' AND second_areaid=5101 GROUP BY a



-- 2018年12s四川核桃不同规格区间的数量级销量

SELECT (CASE WHEN unit <=35 THEN '35及以下'
		 WHEN unit >35 AND unit <=100 THEN  '35<X<=100'
		 WHEN unit >100 AND unit <=150 THEN  '100<X<=150'
		 WHEN unit >150 AND unit <=200 THEN  '150<X<=200'
		 WHEN unit >200  AND unit <=250 THEN  '200<X<=250'
		 WHEN unit >275 AND unit <=450 THEN  '275<X<=450'
		 WHEN unit >450 AND unit <=500 THEN  '450<X<=500'
		 WHEN unit >500  AND unit <=750 THEN  '500<X<=750'
		 WHEN unit >750  AND unit <=1000 THEN  '750<X<=1000'
		 WHEN unit >1000  AND unit <=1500 THEN  '1000<X<=1500'
		 WHEN unit >1500  THEN  '1500以上' end) as a , count(prod_name) 
	FROM analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  GROUP BY a

SELECT unit
	FROM analysis_test.ir_taobao_product_trade_china_2018_sichuan 






-- 2018年12s成都核桃不同规格区间的单品数量及销量





-- 2018年12s四川不同网络零售额区间的核桃网商数量
SELECT (CASE WHEN unit <=10000 THEN '1及以下'
		 WHEN unit >10000 AND unit <=100000 THEN  '1<X<=10'
		 WHEN unit >100000 AND unit <=500000 THEN  '10<X<=50'
		 WHEN unit >500000 AND unit <=1000000 THEN  '50<X<=100'
		 WHEN unit >1000000  AND unit <=2000000 THEN  '100<X<=200'
		 WHEN unit >2000000 AND unit <=5000000 THEN  '200<X<=500'
		 WHEN unit >5000000 AND unit <=10000000 THEN  '500<X<=1000'
		 WHEN unit >10000000  THEN  '1000以上' end) as a ,COUNT(shop_name)
	FROM analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃'  GROUP BY a






select  sum(COALESCE(month_amount_01,0)+ COALESCE(month_amount_02,0) + COALESCE(month_amount_03,0) +COALESCE(month_amount_04,0)+COALESCE(month_amount_05,0) +COALESCE(month_amount_06,0)+COALESCE(month_amount_07,0)+ COALESCE(month_amount_08,0) + COALESCE(month_amount_09,0) +COALESCE(month_amount_10,0)+COALESCE(month_amount_11,0) +COALESCE(month_amount_12,0)) from  analysis_test.ir_taobao_product_trade_china_2018_sichuan



select b.a,count(distinct shop_name),count(distinct shop_name)/m from 
(SELECT  (CASE WHEN unit_price <=20 THEN '20元及以下'
   WHEN unit_price >20 AND unit_price <=30 THEN  '20<X<=30'
   WHEN unit_price >30 AND unit_price <=40 THEN  '30<X<=40'
   WHEN unit_price >40  AND unit_price <=50 THEN  '40<X<=50'
   WHEN unit_price >50 AND unit_price <=60 THEN  '50<X<=60'
   WHEN unit_price >60  AND unit_price <=70 THEN  '60<X<=70'
   WHEN unit_price >70  AND unit_price <=80 THEN  '70<X<=80'
   WHEN unit_price >80  THEN  '80以上' end) as a,prod_name
 FROM analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' )as  b

 GROUP BY 1



shop_name

-- 2018年12s成都不同网络零售额区间的核桃网商数量

select b.a,count(*) from 
(SELECT  (CASE WHEN unit_price <=20 THEN '20元及以下'
   WHEN unit_price >20 AND unit_price <=30 THEN  '20<X<=30'
   WHEN unit_price >30 AND unit_price <=40 THEN  '30<X<=40'
   WHEN unit_price >40  AND unit_price <=50 THEN  '40<X<=50'
   WHEN unit_price >50 AND unit_price <=60 THEN  '50<X<=60'
   WHEN unit_price >60  AND unit_price <=70 THEN  '60<X<=70'
   WHEN unit_price >70  AND unit_price <=80 THEN  '70<X<=80'
   WHEN unit_price >80  THEN  '80以上' end) as a,prod_name
 FROM analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' )  b
 GROUP BY 1





case when unit_price<=20 then '20元以下' 
	when unit_price<=30 then '20-30'
WHEN   ....
ELSE '80+'
END


SELECT 
if null(avg(case month(createTime) when '1' then price else 0 end), 0) as 一月份,
if null(avg(case month(createTime) when '2' then price else 0 end), 0) as 二月份,
if null(avg(case month(createTime) when '3' then price else 0 end), 0) as 三月份,
if null(avg(case month(createTime) when '4' then price else 0 end), 0) as 四月份,
if null(avg(case month(createTime) when '5' then price else 0 end), 0) as 五月份,
if null(avg(case month(createTime) when '6' then price else 0 end), 0) as 六月份,
if null(avg(case month(createTime) when '7' then price else 0 end), 0) as 七月份,
if null(avg(case month(createTime) when '8' then price else 0 end), 0) as 八月份,
if null(avg(case month(createTime) when '9' then price else 0 end), 0) as 九月
if null(avg(case month(createTime) when '10' then price else 0 end), 0) as 十月份,
if null(avg(case month(createTime) when '11' then price else 0 end), 0) as 十一月份,
if null(avg(case month(createTime) when '12' then price else 0 end), 0) as 十二月份
from  analysis_test.ir_taobao_product_trade_china_2017_sichuan
where year(createTime)=#{2017};









---网商与单品----

--“本地产”的核桃 分别在本地销和外地销的比例--参考表2取值
本地销占比=地域为51开头的零售额/100%
本地销占比=1-	本地销占比

--2018年12s四川核桃网络零售额top20网商,显示市州，区县，“本地销网商”，评分
SELECT second_areaid,second_addr,third_addr,shop_name,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+COALESCE(month_money_08,0)+COALESCE(month_money_09,0)+COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))as total
from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' 
GROUP BY second_areaid,second_addr,third_addr,shop_name
ORDER BY  total desc
limit 20

--2018年12s四川核桃网络零售额top20单品,显示url，网商，单品名称，成交额，商品单价，品牌名称
SELECT shop_name,prod_name,url,avg(unit_price),brand_name,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+COALESCE(month_money_08,0)+COALESCE(month_money_09,0)+COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))as total
from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' 
GROUP BY prod_name,shop_name,url,brand_name
ORDER BY  total desc
limit 20

--2018年12s成都全网核桃网络零售额top20网商,显示市州，区县，“本地销网商”，评分
SELECT second_areaid,third_addr,shop_name,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+COALESCE(month_money_08,0)+COALESCE(month_money_09,0)+COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))as total
from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' AND second_addr='成都'
GROUP BY second_areaid,third_addr,shop_name
ORDER BY  total desc
limit 20

--2018年12s成都核桃网络零售额top20单品,显示url，网商，单品名称，成交额，商品单价，品牌名称
SELECT shop_name,prod_name,url,avg(unit_price),brand_name,sum(COALESCE(month_money_01,0)+ COALESCE(month_money_02,0) + COALESCE(month_money_03,0) +COALESCE(month_money_04,0)+COALESCE(month_money_05,0) +COALESCE(month_money_06,0)+COALESCE(month_money_07,0)+COALESCE(month_money_08,0)+COALESCE(month_money_09,0)+COALESCE(month_money_10,0)+COALESCE(month_money_11,0) +COALESCE(month_money_12,0))as total
from  analysis_test.ir_taobao_product_trade_china_2018_sichuan
WHERE agri_thirdcat='核桃' AND second_addr='成都'
GROUP BY prod_name,shop_name,url,brand_name
ORDER BY  total desc
limit 20


-- 动销率
-- select    prod_firstcat,count(*) from   analysis_test.ir_taobao_product_trade_china_2018_sichuan  where   first_addr='四川'    group by  prod_firstcat

 round( cast (sum(temp.a) as numeric)/ cast(count(*),2) as numeric),2) * 100

select  

temp.prod_firstcat,

sum(temp.a),count(*),round(cast(sum(temp.a) as numeric)/cast(count(*) as numeric ),4) as "动销率"

from  

(select prod_firstcat, prod_id,(CASE when sum(COALESCE(month_amount_01,0)+ COALESCE(month_amount_02,0) + COALESCE(month_amount_03,0) +COALESCE(month_amount_04,0)+COALESCE(month_amount_05,0) +COALESCE(month_amount_06,0)+COALESCE(month_amount_07,0)+COALESCE(month_amount_08,0)+COALESCE(month_amount_09,0)+COALESCE(month_amount_10,0)+COALESCE(month_amount_11,0) +COALESCE(month_amount_12,0)) > 0 then 1 else 0   end ) as a    

from 
  
analysis_test.ir_taobao_product_trade_china_2018_sichuan  where   first_addr='四川'  group by prod_firstcat, prod_id ) as temp  

group by  temp.prod_firstcat






select 
 * 
from  
 (SELECT url,name,main_cat,address,first_addr,second_addr,third_addr,first_areaid,second_areaid,third_areaid,COALESCE(month_amount,0),
row_number() over(PARTITION by third_areaid ORDER BY COALESCE(month_amount,0) DESC NULLS LAST) as rank
from
 analysis_service.bt_meituan_shop_china_20190120 
where third_areaid='433124' or third_areaid='511132' or third_areaid='433123' and rank<22)
ORDER BY third_addr 








































