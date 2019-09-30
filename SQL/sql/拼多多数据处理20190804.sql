create table bt_pinduoduo_product_china_20190701  as SELECT * from  staging_sy_data.bt_pinduoduo_product_china_20190701



--添加映潮一二级行业及农产品字段
alter table analysis_kind.bt_pinduoduo_product_china_20190701 add first_cat varchar,add second_cat varchar,add agri_firstcat varchar,add shuiguo varchar;


SELECT DISTINCT category_detail  from  analysis_kind.bt_pinduoduo_product_china_20190701



update analysis_kind.bt_pinduoduo_product_china_20190701 a set first_cat=b.first_cat,second_cat=b.second_cat,
agri_firstcat=b.agri_firstcat,shuiguo=b.shuiguo from analysis_kind.pinduoduoyingshe b WHERE a.category_detail=b.category_detail




采集汇总表
SELECT "count"(DISTINCT shop_id) FROM analysis_kind.bt_pinduoduo_product_china_20190701 ;  --店铺数
SELECT "count"(DISTINCT prod_id) FROM analysis_kind.bt_pinduoduo_product_china_20190701 ;  --产品数
SELECT "count"(*) FROM analysis_kind.bt_pinduoduo_product_china_20190701 ;
SELECT "sum"(amount) as 产品销量,"sum"(comment_num) as 产品评论数,"sum"(collage_price*COALESCE(amount,0)) as 产品金额 FROM analysis_kind.bt_pinduoduo_product_china_20190701 ;



行业大数
SELECT  a.first_cat,sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8 
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
GROUP BY a.first_cat




SELECT  sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where a.agri_firstcat='1'


TOP15产品
SELECT  a.prod_name,split_part(a.category_detail,'>',3),COALESCE(a.collage_price,0),(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)
ELSE 0 END)/10^4,(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8
  m ,a.url
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
ORDER BY m desc limit 18

农产品二级

SELECT  split_part(a.category_detail,'>',2) m,
sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where a.agri_firstcat='1'
GROUP BY m


农产品三级

SELECT split_part(split_part(a.category_detail,'>',3),'/',1) m,
sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where a.agri_firstcat='1' and (split_part(a.category_detail,'>',2)='进口水果' or split_part(a.category_detail,'>',2)='新鲜水果' or split_part(a.category_detail,'>',2)='柑桔橙柚'  or split_part(a.category_detail,'>',2)='瓜果桃梨' )
GROUP BY m

select distinct(split_part(category_detail,'>',2))  from  analysis_kind.bt_pinduoduo_product_china_20190701  where  agri_firstcat='1' 




地方农货
SELECT split_part(split_part(a.category_detail,'>',3),'/',1) m,
sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^4
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where  split_part(a.category_detail,'>',2)='地方农货'
GROUP BY m





SELECT * FROM 
(SELECT a.prod_name,split_part(a.category_detail,'>',3),(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^4
,a.url,
"row_number"() OVER(PARTITION BY split_part(split_part(a.category_detail,'地方农货>',2),'/',1) 
ORDER BY (CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)
 DESC) aa
 FROM analysis_kind.bt_pinduoduo_product_china_20190701 a LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where split_part(a.category_detail,'>',3) in ('北京','天津','河北','山西','内蒙古','辽宁','吉林','黑龙','上海','江苏','浙江','安徽','福建','江西','山东','河南','湖北','湖南','广东','广西','海南','重庆','四川','贵州','云南','西藏','陕西','甘肃','青海','宁夏','新疆
') and split_part(a.category_detail,'>',2)='地方农货' 
 
) a WHERE a.aa<=10


TOP1行业
SELECT split_part(a.category_detail,'>',1) n ,split_part(a.category_detail,'>',2) m,
sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where  a.first_cat='3C数码' 
GROUP BY n,m


SELECT split_part(a.category_detail,'>',3) m,split_part(a.category_detail,'>',2) mm ,split_part(a.category_detail,'>',1) nn,
sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8 n
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where  a.first_cat='3C数码' 
GROUP BY m,mm,nn
ORDER BY n  desc limit 15


TOP2行业

SELECT split_part(a.category_detail,'>',1) f ,split_part(a.category_detail,'>',2) m,
sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where  a.first_cat='母婴用品' 
-- and split_part(a.category_detail,'>',1)='男装'
GROUP BY m,f









SELECT split_part(a.category_detail,'>',3) m,split_part(a.category_detail,'>',2) mm ,split_part(a.category_detail,'>',1) nn,
sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8
 n
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where  a.first_cat='母婴用品' 
GROUP BY m,mm,nn
ORDER BY n  desc limit 15


TOP3行业

SELECT split_part(a.category_detail,'>',1) n,split_part(a.category_detail,'>',2) m,
sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where  a.first_cat='家装家饰'
and split_part(a.category_detail,'>',1)='百货'
GROUP BY n,m


SELECT split_part(a.category_detail,'>',3) m,split_part(a.category_detail,'>',2) mm ,split_part(a.category_detail,'>',1) nn,
sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8 n
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where  a.first_cat='家装家饰' 
GROUP BY m,mm,nn
ORDER BY n  desc limit 15


食品保健行业

SELECT split_part(a.category_detail,'>',1) n,split_part(a.category_detail,'>',2) m,
sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where  a.first_cat='食品保健'
GROUP BY n,m


SELECT split_part(a.category_detail,'>',3) m,split_part(a.category_detail,'>',2) mm ,split_part(a.category_detail,'>',1) nn,
sum(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8 n
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
where  a.first_cat='食品保健' 
GROUP BY m,mm,nn
ORDER BY n  desc limit 10






TOP1~3行业一级     食品保健  3C数码  服装鞋包  家装家饰
SELECT  split_part(a.category_detail,'>',1) m,"sum"(CASE WHEN COALESCE(a.amount,0)>COALESCE(b.amount,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.amount,0)-COALESCE(b.amount,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31  
WHEN COALESCE(a.comment_num,0)>COALESCE(b.comment_num,0) AND b.shop_id IS NOT NULL THEN 
(COALESCE(a.comment_num,0)-COALESCE(b.comment_num,0))*a.collage_price/(DATE(a.creatime)-DATE(b.creatime))*31 
WHEN b.shop_id IS NULL THEN 
COALESCE(a.amount,0)*a.collage_price
ELSE 0 END)/10^8 n
FROM    analysis_kind.bt_pinduoduo_product_china_20190701 a  
LEFT JOIN  analysis_kind.bt_pinduoduo_product_china_20190601 b  on a.prod_id=b.prod_id 
WHERE a.first_cat='家居用品'
GROUP BY m
ORDER BY n DESC 





