CREATE OR REPLACE FUNCTION update_string1()
RETURNS setof record AS $$ 
DECLARE
mysql text;
r record;
k record;
BEGIN
FOR r IN   select mm from data LOOP
			mysql := 'SELECT  
			sum(a.collage_price*COALESCE(a.amount,0))   as 网络零售额,sum(COALESCE(a.amount,0))  as 销量
			from analysis_kind.bt_pinduoduo_product_china_20180925_compress  a  
			where 
			a.prod_name~''冰箱'' 
			AND a.prod_name!~''去冰剂|防霜|配件|零件|温度计|灯泡|变压器|转换器|电源|稳压器|封条|控器|检测仪|滤芯|竿挂|加氟工具|冰箱玻璃|蒸发器|接头|压缩机''
			and  a.collage_price > 300 and  a.prod_name='||quote_literal(r.mm);
			execute mysql into k;
			RETURN next k;
end loop;  
return; 
end;
$$ LANGUAGE plpgsql;


select * from update_string1() as t (网络零售额 NUMERIC,销量 int8); 




