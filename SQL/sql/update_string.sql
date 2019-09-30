-- 无返回结果
-- CREATE OR REPLACE FUNCTION bu()
-- RETURNS void as $$  
-- 返回所有记录
-- drop FUNCTION bu();
CREATE OR REPLACE FUNCTION update_string()
RETURNS setof record AS $$ 
DECLARE
mysql text;
r record;
k record;
BEGIN
-- FOR k IN  EXECUTE ' ("Haier/海尔","Midea/美的","Ronshen/容声","Konka/康佳","MeiLing/美菱","TCL","SIEMENS/西门子","Leader/统帅","Kinghome/晶弘","Hisense/海信","Panasonic/松下","AUX/奥克斯","Skyworth/创维","Samsung/三星","Homa/奥马","哈士奇","PANDA/熊猫","韩上","上菱")  ' LOOP
-- FOR r IN  EXECUTE ' select (''Haier/海尔'',''Midea/美的'') a ' LOOP
FOR r IN   select mm from data LOOP
			mysql := 'SELECT   t.price*t.amount as 网络零售额,t.url  from 
			(SELECT 
			(COALESCE(a.month_amount_01,0)+COALESCE(a.month_amount_02,0)+COALESCE(a.month_amount_03,0)+
			COALESCE(a.month_amount_04,0)+COALESCE(a.month_amount_05,0)+COALESCE(a.month_amount_06,0)+COALESCE(a.month_amount_07,0)+COALESCE(a.month_amount_08,0)
			+COALESCE(a.month_amount_09,0)+COALESCE(a.month_amount_10,0)+COALESCE(a.month_amount_11,0)+COALESCE(a.month_amount_12,0)) as amount,
			(CASE WHEN a.price_12 IS NOT NULL AND a.price_12!=0 THEN a.price_12 
			ELSE CASE WHEN a.price_11 IS NOT NULL AND a.price_11!=0 THEN a.price_11 
			ELSE CASE WHEN a.price_10 IS NOT NULL AND a.price_10!=0 THEN a.price_10 
			ELSE CASE WHEN a.price_09 IS NOT NULL AND a.price_09!=0 THEN a.price_09 
			ELSE CASE WHEN a.price_08 IS NOT NULL AND a.price_08!=0 THEN a.price_08 
			ELSE CASE WHEN a.price_07 IS NOT NULL AND a.price_07!=0 THEN a.price_07 
			ELSE CASE WHEN a.price_06 IS NOT NULL AND a.price_06!=0 THEN a.price_06 
			ELSE CASE WHEN a.price_05 IS NOT NULL AND a.price_05!=0 THEN a.price_05 
			ELSE CASE WHEN a.price_04 IS NOT NULL AND a.price_04!=0 THEN a.price_04 
			ELSE CASE WHEN a.price_03 IS NOT NULL AND a.price_03!=0 THEN a.price_03 
			ELSE CASE WHEN a.price_02 IS NOT NULL AND a.price_02!=0 THEN a.price_02 
			ELSE a.price_01 END END END END END END END END END END END ) as price,a.url,b.prod_detail
			FROM 
			gather_taobao.ir_taobao_product_trade_china_2018  a JOIN   analysis_taobao.bt_taobao_product_china_all_detail_2018 b 
			on  a.prod_id=b.prod_id  
			where 
			a.first_cat~''汽车配件|3C数码'' AND a.prod_name~''冰箱''
			AND a.prod_name!~''去冰剂|防霜|配件|零件|温度计|灯泡|变压器|转换器|电源|稳压器|封条|控器|检测仪|滤芯|竿挂|加氟工具|冰箱玻璃|蒸发器|接头|压缩机''
			)t 
			where trim(substring(t.prod_detail from ''{"冰箱冰柜品牌":"(.*?)"}'')) ='||quote_literal(r.mm)||'
			ORDER BY 网络零售额  desc limit 1   ';

			execute mysql into k;
			RETURN next k;
end loop;  
return; 
end;
$$LANGUAGE plpgsql;

-- 如果你把返回结果的数据类型写进out参数,就可以不在调用时指定了

-- select * from update_string() as t (网络零售额 int4,url varchar); 

-- 表
-- quote_ident(table_name)
-- 字段
-- quote_literal(r.mm)




select * from update_string() as t (网络零售额 NUMERIC,url varchar); 

MeiLing/美菱
Konka/康佳
Haier/海尔
Ronshen/容声
Midea/美的

--PostgreSQL不能简单的在存储过程里边select数据返回，只能通过return next的方式返回行集，如下为测试语句:

--创建测试表
create table test1(id int,name varchar);

--插入测试数据
insert into test1 values(1,'abc');
insert into test1 values(2,'def');

--创建返回结果集的存储过程
CREATE OR REPLACE FUNCTION proc_test1()
  RETURNS setof record AS
$BODY$

declare
v_rc	record;
begin

for v_rc in select * from test1
loop
return next v_rc;
end loop;

return;

end;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE;

--调用存储过程
select * from proc_test1() as t(id int,name varchar);



CREATE or Replace FUNCTION func_getnextid(  
    tablename varchar(240),  
    idname varchar(20) default 'id')  
RETURNS integer AS $funcbody$  
Declare  
    sqlstring varchar(240);  
    currentId integer;  
Begin  
    sqlstring:= 'select max("' || idname || '") from "' || tablename || '";';  
    EXECUTE sqlstring into currentId;  
    if currentId is NULL or currentId = 0 then  
        return 1;  
    else  
        return currentId + 1;  
    end if;  
End;  
$funcbody$ LANGUAGE plpgsql; 


