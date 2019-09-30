-- 商品动销率=（动销品种数 /仓库总品种数）*100% 


-- 2018年四川动销率
select  

temp.prod_firstcat,

sum(temp.a),count(*),round(cast(sum(temp.a) as numeric)/cast(count(*) as numeric ),4)  as  "动销率"

from  

(select prod_firstcat, prod_id,(CASE when sum(COALESCE(month_amount_01,0)+ COALESCE(month_amount_02,0) + COALESCE(month_amount_03,0) +COALESCE(month_amount_04,0)+COALESCE(month_amount_05,0) +COALESCE(month_amount_06,0)+COALESCE(month_amount_07,0)+COALESCE(month_amount_08,0)+COALESCE(month_amount_09,0)+COALESCE(month_amount_10,0)+COALESCE(month_amount_11,0) +COALESCE(month_amount_12,0)) > 0 then 1 else 0   end )  as  a    

from 
  
gather_taobao.ir_taobao_product_trade_china_2018 where   first_addr='四川'  group by prod_firstcat, prod_id ) as temp  

group by  temp.prod_firstcat			


									
													
																									
-- 2018年全国动销率													
select  

temp.prod_firstcat,

sum(temp.a),count(*),round(cast(sum(temp.a) as numeric)/cast(count(*) as numeric ),4)  as  "动销率"

from  

(select prod_firstcat, prod_id,(CASE when sum(COALESCE(month_amount_01,0)+ COALESCE(month_amount_02,0) + COALESCE(month_amount_03,0) +COALESCE(month_amount_04,0)+COALESCE(month_amount_05,0) +COALESCE(month_amount_06,0)+COALESCE(month_amount_07,0)+COALESCE(month_amount_08,0)+COALESCE(month_amount_09,0)+COALESCE(month_amount_10,0)+COALESCE(month_amount_11,0) +COALESCE(month_amount_12,0)) > 0 then 1 else 0   end )  as  a    

from 
  
gather_taobao.ir_taobao_product_trade_china_2018  group by prod_firstcat, prod_id ) as temp  

group by  temp.prod_firstcat														
													
																	
													
													
													
-- 2019年四川动销率

select  

temp.prod_firstcat,

sum(temp.a),count(*),round(cast(sum(temp.a) as numeric)/cast(count(*) as numeric ),4)  as  "动销率"

from  

(select prod_firstcat, prod_id,(CASE when sum(COALESCE(month_amount_01,0)+ COALESCE(month_amount_02,0) + COALESCE(month_amount_03,0) +COALESCE(month_amount_04,0)+COALESCE(month_amount_05,0) +COALESCE(month_amount_06,0)+COALESCE(month_amount_07,0)+COALESCE(month_amount_08,0)+COALESCE(month_amount_09,0)+COALESCE(month_amount_10,0)+COALESCE(month_amount_11,0) +COALESCE(month_amount_12,0)) > 0 then 1 else 0   end )  as  a    

from 
  
gather_taobao.ir_taobao_product_trade_china_2019 where   first_addr='四川'  group by prod_firstcat, prod_id ) as temp  

group by  temp.prod_firstcat	






-- 2019年全国动销率

select  

temp.prod_firstcat,

sum(temp.a),count(*),round(cast(sum(temp.a) as numeric)/cast(count(*) as numeric ),4)  as  "动销率"

from  

(select prod_firstcat, prod_id,(CASE when sum(COALESCE(month_amount_01,0)+ COALESCE(month_amount_02,0) + COALESCE(month_amount_03,0) +COALESCE(month_amount_04,0)+COALESCE(month_amount_05,0) +COALESCE(month_amount_06,0)+COALESCE(month_amount_07,0)+COALESCE(month_amount_08,0)+COALESCE(month_amount_09,0)+COALESCE(month_amount_10,0)+COALESCE(month_amount_11,0) +COALESCE(month_amount_12,0)) > 0 then 1 else 0   end )  as  a    

from 
  
gather_taobao.ir_taobao_product_trade_china_2019   group by prod_firstcat, prod_id ) as temp  

group by  temp.prod_firstcat	













SELECT  

(CASE 
when	c.tem <100 then '0-100g'
when	c.tem  <200 then '100-200g'
when	c.tem  <300 then '200-300g'
when	c.tem  <500 then '300-500g'
when	c.tem  <1000 then '500-1000g'
when	c.tem  <2000 then '1000-2000g'
ELSE 	'2000g以上' end) as 重量区间,

count(DISTINCT a.prod_id) as 单品数量,

sum(COALESCE(month_amount_01,0)+ COALESCE(month_amount_02,0) + COALESCE(month_amount_03,0) +COALESCE(month_amount_04,0)+COALESCE(month_amount_05,0) +COALESCE(month_amount_06,0)+COALESCE(month_amount_07,0)+ COALESCE(month_amount_08,0) + COALESCE(month_amount_09,0) +COALESCE(month_amount_10,0)+COALESCE(month_amount_11,0) + COALESCE(month_amount_12,0)) as 销量

FROM analysis_taobao.bt_taobao_product_china_all_detail_2018  a
JOIN gather_taobao.ir_taobao_product_trade_china_2018 b on a.prod_id = b.prod_id

join (select prod_id,to_number((regexp_matches(prod_detail,'"净含量":"(\d+)g"'))[1],'999999999999999999999999999999999') as tem

from analysis_taobao.bt_taobao_product_china_all_detail_2018) c on a.prod_id = c.prod_id
where b.first_cat in ('食品保健','其他行业') and b.agri_thirdcat='核桃'  and  b.prod_name~'核桃|胡桃'
AND b.prod_name!~'夹|开口器|工具|塑料|刷|钳|摘果器|脱皮机|灸|米粉机|核桃味|盆栽|乳|奶|糖|蛋糕|油|粉|酥|文玩|把玩|手串|饼干|燕麦|芝麻|包子|麦片|刀|酒|酱|钻' 

GROUP BY 重量区间



























