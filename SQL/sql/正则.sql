select substring(prod_detail from '"净含量":"(\d+)g"')  from analysis_taobao.bt_taobao_product_china_all_detail_2019  
where  substring(prod_detail from '"净含量":"(\d+)g"') is not null 
limit 10 


4KG干粉灭火器组合套装款家用店面仓库厂房2kg3kg5kg8kg消防包邮
{"groupProps":[{"基本信息":[{"品牌":"宁达"},{"型号":"MFZ/ABC4"},{"颜色分类":"2kg灭火器*2个+灭火箱,3kg灭火器*2个+灭火箱,4kg灭火器*2个+灭火箱,5kg灭火器*2个+灭火箱,8kg灭火器*2个+灭火箱,1KG干粉灭火器,2KG干粉灭火器,3KG干粉灭火器,4KG干粉灭火器,5KG干粉灭火器,35KG干粉灭火器"}]}]}



select prod_name,to_number(substring(prod_detail from '"净含量":"(\d+)g"'),'99999999'),url from analysis_taobao.bt_taobao_product_china_all_detail_2019  
where  prod_name~'香蕉' and  substring(prod_detail from '"净含量":"(\d+)g"') is not null
limit 1000


*


select prod_name,to_number(substring(prod_detail from '"净含量":"(\d+)g"'),'99999999'),
-- to_number(substring(prod_detail from '"净含量":"(\d+)g"'),'99999999'),
substring(prod_name from '(\d+).*\*(\d+)'),url from analysis_taobao.bt_taobao_product_china_all_detail_2019  
where  prod_name~'香蕉' and  substring(prod_detail from '"净含量":"(\d+)g"') is not null  and  prod_name~'(\d+).*\*(\d+)'
limit 100






select prod_name,to_number(substring(prod_detail from '"净含量":"(\d+)g"'),'99999999'),
-- to_number(substring(prod_detail from '"净含量":"(\d+)g"'),'99999999'),
regexp_matches(prod_name,'(\d+).*?\*(\d+)'),url from analysis_taobao.bt_taobao_product_china_all_detail_2019  
where  prod_name~'香蕉' and  substring(prod_detail from '"净含量":"(\d+)g"') is not null  and  prod_name~'(\d+).*\*(\d+)'
limit 100



SELECT   regexp_matches(' 买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g','(\d+).*?[*](\d+)')


SELECT   regexp_matches(' 买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g','(\d+)')

regexp_split_to_table(string, pattern[, flags ])函数使用POSIX正则表达式模式作为分隔符，分隔字符串。返回结果为string。。

regexp_split_to_array (string, pattern[, flags ])函数与regexp_split_to_table行为相同，但，返回结果为text数组


SELECT   regexp_split_to_array (split_part(' 买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g','*',1),'(\d+)')
SELECT   regexp_split_to_table(split_part(' 买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g','*',1),'(\d+)')

SELECT split_part(' 买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g','*',1)    




-- regexp_matches函数外围需要加括号
SELECT (regexp_matches(' 买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '(\d+)[^\d+?][*](\d+)'))[1],
(regexp_matches(' 买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '(\d+)[^\d+?][*](\d+)'))[2]





SELECT  regexp_matches('prod_name', '(\d+)[^\d+?][*](\d+)')  from  analysis_taobao.bt_taobao_product_china_all_detail_2019
where prod_name~'(\d+)[^\d+?][*](\d+)')
limit 1000






SELECT ((regexp_matches(' 买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '(\d+)[^\d+?][*](\d+)'))[1]::INTEGER )*
 ((regexp_matches(' 买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '(\d+)[^\d+?][*](\d+)'))[2])::INTEGER;






select  regexp_matches('aa-aa', '(aa)+', 'g')
select  regexp_matches('aa-aa', '(aa)+')



select  (regexp_matches('买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '\d+', 'g'))[1]
select  regexp_matches('买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '\d+')





select string_agg((regexp_matches('买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '\d+', 'g'))[1],' ') 


select string_agg('99 45 998',',') 





-- string_to_array 将字符串转成数字，通过自定切割符合。
select array_length(string_to_array('1.2.3.4.5','.'), 1); --5
select string_to_array('1.2.3.4.5','.') --5
--array_length(anyarray,int) 返回数组指定维度的长度



-- array_to_string(“数组”,”/”) 即把数组转化为字符串，并用“/”连接(使用提供的分隔符连接数组元素)
SELECT array_to_string(regexp_matches('买3送1 英国 亚曼茶AHMAD茶 儿童香蕉焦糖味红茶 袋泡茶20包*2g', '\d+', 'g'),' ')



select string_to_array('休闲,娱乐,运动,玩耍', ',');


array_agg(expression)  把表达式变成一个数组 一般配合 array_to_string() 函数使用
SELECT array_agg(array[1,2,3,4,5,6])  
SELECT array[1,2,3,4,5,6]



string_agg(expression, delimiter)  直接把一个表达式变成字符串

SELECT array_to_string(array_agg(ename),',')  from  analysis_taobao.bt_taobao_product_china_all_detail_2019 limit 20
SELECT array_agg(ename)  from  analysis_taobao.bt_taobao_product_china_all_detail_2019 limit 20
SELECT string_agg(shop_id)  from  analysis_taobao.bt_taobao_product_china_all_detail_2019 limit 20




