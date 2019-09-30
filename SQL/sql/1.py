SELECT CURRENT_DATE;

SELECT CURRENT_TIME;

SELECT CURRENT_TIMESTAMP;


日期截取函数
EXTRACT(日期元素 FROM 日期)

SELECT 
CURRENT_TIMESTAMP,
EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS year,
EXTRACT(MONTH FROM CURRENT_TIMESTAMP) AS month,
EXTRACT(DAY FROM CURRENT_TIMESTAMP) AS day,
EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AS hour,
EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS minute,
EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second;



EXIST谓词   判断是否存在满足某种条件的记录
如果存在这样的记录就返回真（TRUE），如果不存在就返回假（FALSE）。EXIST（存在）谓词的主语是“记录”，通常指定关联子查询作为EXIST的参数

SELECT  product_name, sale_price  FROM Product AS P 
WHERE 
EXISTS 
(SELECT *  FROM ShopProduct AS SP WHERE SP.shop_id = '000C'AND SP.product_id = P.product_id);

可以把在 EXIST 的子查询中书写 SELECT * 当作 SQL 的一种习惯。




使用CASE表达式进行行列转换
-- 对按照商品种类计算出的销售单价合计值进行行列转换
SELECT 
SUM(CASE WHEN product_type = '衣服'      THEN sale_price ELSE 0 END) AS sum_price_clothes,
SUM(CASE WHEN product_type = '厨房用具'  THEN sale_price ELSE 0 END) AS sum_price_kitchen,
SUM(CASE WHEN product_type = '办公用品'  THEN sale_price ELSE 0 END) AS sum_price_office
FROM Product;


SELECT SUM(CASE WHEN sale_price <= 1000  THEN 1 ELSE 0 END) AS low_price,
SUM(CASE WHEN sale_price BETWEEN 1001 AND 3000THEN 1 ELSE 0 END) AS mid_price,
SUM(CASE WHEN sale_price >= 3001         THEN 1 ELSE 0 END) AS high_price
FROM Product;





NOT IN 的参数中不能包含 NULL。不仅仅是指定 NULL 的情况，使用子查询作为 NOT IN 的参数时，该子查询的返回值也不能是 NULL



联结（JOIN）就是将其他表中的列添加过来，进行“添加列”的集合运算。
UNION是以行（纵向）为单位进行操作，而联结则是以列（横向）为单位进行的。

集合运算的优先级：intersect运算比union和except运算的优先级高，而union和except的优先级相等
UNION（并集）、INTERSECT（交集）、EXCEPT（差集）

-- 两张表相等时返回“相等”，否则返回“不相等”
SELECT CASE WHEN COUNT(*) = 0
 THEN '相等'
 ELSE '不相等' END AS result
 FROM ((SELECT * FROM tbl_A
 UNION
 SELECT * FROM tbl_B)
 EXCEPT
 (SELECT * FROM tbl_A
 INTERSECT
 SELECT * FROM tbl_B)) TMP;



从表 EmpSkills中找出精通表 Skills中所有技术的员工。
-- 用求差集的方法进行关系除法运算（有余数）
SELECT DISTINCT emp
 FROM EmpSkills ES1
 WHERE NOT EXISTS
 (SELECT skill
 FROM Skills
 EXCEPT
 SELECT skill
 FROM EmpSkills ES2
 WHERE ES1.emp = ES2.emp);
  
SELECT DISTINCT emp
 FROM EmpSkills ES1
 WHERE NOT EXISTS
 (SELECT skill
 FROM Skills
 EXCEPT
 SELECT skill
 FROM EmpSkills ES2
 WHERE ES1.emp = ES2.emp)
 AND NOT EXISTS
 (SELECT skill
 FROM EmpSkills ES3
 WHERE ES1.emp = ES3.emp
 EXCEPT
 SELECT skill
 FROM Skills );


SELECT emp
 FROM EmpSkills ES1
 WHERE NOT EXISTS
 (SELECT skill
 FROM Skills
 EXCEPT
 SELECT skill
 FROM EmpSkills ES2
 WHERE ES1.emp = ES2.emp)
 GROUP BY emp
HAVING COUNT(*) = (SELECT COUNT(*) FROM Skills);  
  




SELECT product_id, product_name
FROM Product
UNION
SELECT product_id, product_name
FROM Product2;

UNION
1.列数必须相同
2.列的类型必须一致
3.可以使用任何SELECT语句，但ORDER BY子句只能在最后使用一次


SELECT product_id, product_name
FROM Product
INTERSECT
SELECT product_id, product_name
FROM Product2
ORDER BY product_id;





SELECT COALESCE(SP.shop_id, '不确定') AS shop_id,
 COALESCE(SP.shop_name, '不确定') AS shop_name,
 P.product_id,
 P.product_name,
 P.sale_price
 FROM ShopProduct SP RIGHT OUTER JOIN Product P
 ON SP.product_id = P.product_id
ORDER BY shop_id;


SELECT 1+2


累加
SELECT product_id, product_name, sale_price,
SUM (sale_price) OVER (ORDER BY product_id) AS current_sum
FROM Product;


移动平均 
1.框架指定为“截止到之前 ~ 行”，因此“ROWS 2 PRECEDING”
KEYWORD 就是将框架指定为“截止到之前 2 行”，也就是将作为汇总对象的记录限定为如下的“最靠近的 3 行”。
● 自身（当前记录）
● 之前 1行的记录
● 之前 2行的记录
SELECT product_id, product_name, sale_price,
AVG (sale_price) OVER (ORDER BY product_id ROWS 2 PRECEDING) AS moving_avg
FROM Product;

2.截止到之后 ~ 行
SELECT product_id, product_name, sale_price,
AVG (sale_price) OVER (ORDER BY product_id ROWS 2 FOLLOWING) AS moving_avg
FROM Product;


3.将当前记录的前后行作为汇总对象
SELECT product_id, product_name, sale_price,
AVG (sale_price) OVER (ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg
FROM Product;


OVER 子句中的 ORDER BY 只是用来决定窗口函数按照什么样的顺序进行计算的，对结果的排列顺序并没有影响。
无法保证如下SELECT语句的结果的排列顺序
SELECT product_name, product_type, sale_price,
RANK () OVER (ORDER BY sale_price) AS ranking
FROM Product;


在语句末尾使用ORDER BY子句对结果进行排序
SELECT product_name, product_type, sale_price,
RANK () OVER (ORDER BY sale_price) AS ranking
FROM Product
ORDER BY ranking;



分组后合计
SELECT product_type, regist_date, SUM(sale_price) AS sum_price FROM Product
GROUP BY ROLLUP(product_type, regist_date);


按照商品编号（product_id）的升序进行排序，计算出截至当前行的最高销售单价
SELECT product_id, product_name, sale_price,
MAX (sale_price) OVER (ORDER BY product_id) AS current_max_price
FROM Product;

计算出按照登记日期（regist_date）升序进行排列的各日期的销售单价（sale_price）的总额
SELECT regist_date, product_name, sale_price,
SUM (sale_price) OVER (ORDER BY regist_date NULLS FIRST) AS current_sum_price
FROM Product;



<窗口函数> OVER ([PARTITION BY <列清单>]
 ORDER BY <排序用列清单>)

① 能够作为窗口函数的聚合函数（SUM、AVG、COUNT、MAX、MIN）
② RANK、DENSE_RANK、ROW_NUMBER 等专用窗口函数



substr(to_char(a.transdate,'yyyy/mm/dd'),1,7)


TRUNCATE <表名>;只能删除表中全部数据，不能通过 WHERE 子句指定条件来删除部分数据。


select extract(year from charttime)-extract(year from dob) as 周岁 from  "脑脊液糖表查询出量"



创建表，携带数据   create table employees1 as select * from employees1 
创建表，携带表结构 create table employees2 like employees



SELECT pref_name,
-- 男性人口
SUM( CASE WHEN sex = '1' THEN population ELSE 0 END) AS cnt_m,
-- 女性人口
SUM( CASE WHEN sex = '2' THEN population ELSE 0 END) AS cnt_f
FROM PopTbl2
GROUP BY pref_name;



SELECT product_type, regist_date, SUM(sale_price) AS sum_price FROM Product GROUP BY ROLLUP(product_type, regist_date);




UPDATE Salaries
SET salary = 
CASE WHEN salary >= 300000 THEN salary * 0.9
WHEN salary >= 250000 AND salary < 280000  THEN salary * 1.2
ELSE salary END;



SELECT std_id,
CASE WHEN COUNT(*) = 1 THEN MAX(club_id)
ELSE 
MAX(CASE WHEN main_club_flg = 'Y' THEN club_id ELSE NULL END)
END AS main_club
FROM StudentClub GROUP BY std_id;

SELECT sex,
 SUM(population) AS total,
 SUM(CASE WHEN pref_name = '德岛' THEN population ELSE 0 END) AS col_1,
 SUM(CASE WHEN pref_name = '香川' THEN population ELSE 0 END) AS col_2,
 SUM(CASE WHEN pref_name = '爱媛' THEN population ELSE 0 END) AS col_3,
 SUM(CASE WHEN pref_name = '高知' THEN population ELSE 0 END) AS col_4,
 SUM(CASE WHEN pref_name IN ('德岛', '香川', '爱媛', '高知')
 THEN population ELSE 0 END) AS zaijie
 FROM PopTbl2
 GROUP BY sex;

Oracle和mysql中 使用 GREATEST和LEAST函数来查找多列中最大和最小的值，
如果任何参数为NULL，则GREATEST和LEAST函数都返回NULL，可以使用IFNULL函数将NULL视为零来执行数字比较。

SELECT key, GREATEST(GREATEST(x,y), z) AS greatest FROM Greatests;

SELECT 
    company_id,
    LEAST(IFNULL(q1, 0),
            IFNULL(q2, 0),
            IFNULL(q3, 0),
            IFNULL(q4, 0)) low,
    GREATEST(IFNULL(q1, 0),
            IFNULL(q2, 0),
            IFNULL(q3, 0),
            IFNULL(q4, 0)) high
FROM
    revenues;



可重排列、排列、组合
-- 用于获取可重排列的 SQL 语句
SELECT P1.name AS name_1, P2.name AS name_2
FROM Products P1, Products P2;

-- 用于获取排列的 SQL 语句
SELECT P1.name AS name_1, P2.name AS name_2
FROM Products P1, Products P2
WHERE P1.name <> P2.name;

--可重组合
SELECT P1.name AS name_1, P2.name AS name_2
 FROM Products P1, Products P2
 WHERE P1.name >= P2.name;
 

-- 用于获取组合的 SQL 语句
SELECT P1.name AS name_1, P2.name AS name_2
FROM Products P1, Products P2
WHERE P1.name > P2.name;

-- 用于获取组合的 SQL 语句 ：扩展成 3 列
SELECT P1.name AS name_1, P2.name AS name_2, P3.name AS name_3
FROM Products P1, Products P2, Products P3
WHERE P1.name > P2.name
AND P2.name > P3.name;



ctid表示数据行在它所处的表内的物理位置，ctid字段的类型是tid。
尽管ctid可以快速定位数据行，每次vacuum full之后，数据行在块内的物理位置就会移动，即ctid会发生变化，所以ctid不能作为长期的行标识符，应该使用主键来标识一个逻辑行。
select  ctid  from analysis_taobao.bt_taobao_product_china_all_detail_2018 limit 30

select ctid,id from t1 where ctid='(0,11)';



利用ctid删除重复数据
delete from t1 a where a.ctid <>(select min(b.ctid) from t1 b where a.id=b.id);





-- 求中位数的 SQL 语句 ：在 HAVING 子句中使用非等值自连接
SELECT AVG(DISTINCT income)
 FROM (SELECT T1.income
 FROM Graduates T1, Graduates T2
 GROUP BY T1.income
 --S1 的条件
 HAVING SUM(CASE WHEN T2.income >= T1.income THEN 1 ELSE 0 END)
 >= COUNT(*) / 2
 --S2 的条件
 AND SUM(CASE WHEN T2.income <= T1.income THEN 1 ELSE 0 END)
 >= COUNT(*) / 2 ) TMP;



-- 带余除法,查询啤酒、纸尿裤和自行车同时在库的店铺  
SELECT SI.shop
 FROM ShopItems SI, Items I
 WHERE SI.item = I.item
 GROUP BY SI.shop
HAVING COUNT(SI.item) = (SELECT COUNT(item) FROM Items);



-- 精确关系除法运算 ：使用外连接和 COUNT 函数
SELECT SI.shop
 FROM ShopItems SI LEFT OUTER JOIN Items I
 ON SI.item=I.item
 GROUP BY SI.shop
HAVING COUNT(SI.item) = (SELECT COUNT(item) FROM Items)　　-- 条件 1
 AND COUNT(I.item) = (SELECT COUNT(item) FROM Items); -- 条件 2


SELECT CASE WHEN COUNT(*) <> MAX(seq)
 THEN '存在缺失的编号'
 ELSE '不存在缺失的编号' END AS gap
 FROM SeqTbl;




-- 查找所有学生都在 9 月份提交完成的学院 (1)：使用 BETWEEN 谓词
SELECT dpt
 FROM Students
 GROUP BY dpt
HAVING COUNT(*) = SUM(CASE WHEN sbmt_date BETWEEN '2005-09-01' AND '2005-09-30'
 THEN 1 ELSE 0 END);


-- 查找所有学生都在 9 月份提交完成的学院 (1)：使用 EXTRACT 谓词
SELECT dpt
 FROM Students
 GROUP BY dpt
HAVING COUNT(*) = SUM(CASE WHEN EXTRACT (YEAR FROM sbmt_date) = 2005
 AND EXTRACT (MONTH FROM sbmt_date) = 09
 THEN 1 ELSE 0 END);

             
                 
SELECT name,
 CASE WHEN SUM(CASE WHEN course = 'SQL 入门' THEN 1 ELSE NULL END) = 1
 THEN '○' ELSE NULL END AS "SQL 入门",
 CASE WHEN SUM(CASE WHEN course = 'UNIX 基础' THEN 1 ELSE NULL END) = 1
 THEN '○' ELSE NULL END AS "UNIX 基础",
 CASE WHEN SUM(CASE WHEN course = 'Java 中级' THEN 1 ELSE NULL END) = 1
 THEN '○' ELSE NULL END AS "Java 中级 "
 FROM Courses
 GROUP BY name;             
             
             
             
用外连接求差集 ：A － B             
SELECT A.id AS id, A.name AS A_name
 FROM Class_A A LEFT OUTER JOIN Class_B B
 ON A.id = B.id
 WHERE B.name IS NULL;             
             
用外连接求差集 ：B － A             
SELECT B.id AS id, B.name AS B_name
 FROM Class_A A RIGHT OUTER JOIN Class_B B
 ON A.id = B.id
 WHERE A.name IS NULL;             
             
             
用全外连接求异或集
SELECT COALESCE(A.id, B.id) AS id,
 COALESCE(A.name , B.name ) AS name
 FROM Class_A A FULL OUTER JOIN Class_B B
 ON A.id = B.id
 WHERE A.name IS NULL
 OR B.name IS NULL;             
             
             
             
用列表展示与上一年的比较结果             
-- 求出是增长了还是减少了，抑或是维持现状 (1)：使用关联子查询
SELECT S1.year, S1.sale,
 CASE WHEN sale =
 (SELECT sale
 FROM Sales S2
 WHERE S2.year = S1.year - 1) THEN '→' -- 持平
 WHEN sale >
 (SELECT sale
 FROM Sales S2
 WHERE S2.year = S1.year - 1) THEN '↑' -- 增长
 WHEN sale <
 (SELECT sale
 FROM Sales S2
 WHERE S2.year = S1.year - 1) THEN '↓' -- 减少
 ELSE '—' END AS var
 FROM Sales S1
 ORDER BY year;



-- 求出是增长了还是减少了，抑或是维持现状 (2)：使用自连接查询（最早的年份不会出现在结果里）
SELECT S1.year, S1.sale,
 CASE WHEN S1.sale = S2.sale THEN '→'
 WHEN S1.sale > S2.sale THEN '↑'
 WHEN S1.sale < S2.sale THEN '↓'
 ELSE '—' END AS var
 FROM Sales S1, Sales S2
 WHERE S2.year = S1.year - 1
 ORDER BY year;

符号函数sign
当x>0，sign(x)=1;
当x=0，sign(x)=0;
当x<0， sign(x)=-1；

-- 一次性求出增长、减退、维持现状的状态 (3)：使用 SIGN 函数
SELECT S1.year, S1.sale,
 CASE SIGN(sale -
 (SELECT sale
 FROM Sales S2
 WHERE S2.year = S1.year - 1) )
 WHEN 0 THEN '→' -- 持平
 WHEN 1 THEN '↑' -- 增长
 WHEN -1 THEN '↓' -- 减少
 ELSE ' - ' END AS var
 FROM Sales S1
 ORDER BY year;



时间轴有间断时 ：和过去最临近的时间进行比较
1. 与该年份相比是过去的年份。
2. 在满足条件 1 的年份中，年份最早的一个。

-- 查询与过去最临近的年份营业额相同的年份
SELECT year, sale
 FROM Sales2 S1
 WHERE sale =
 (SELECT sale
 FROM Sales2 S2
 WHERE S2.year =
 (SELECT MAX(year) -- 条件 2 ：在满足条件 1 的年份中，年份最早的一个
 FROM Sales2 S3
 WHERE S1.year > S3.year)) -- 条件１ ：与该年份相比是过去的年份
 ORDER BY year;


查询与过去最临近的年份营业额相同的年份  
SELECT S1.year AS year,
 S1.year AS year
 FROM Sales2 S1, Sales2 S2
 WHERE S1.sale = S2.sale
 AND S2.year = (SELECT MAX(year)
 FROM Sales2 S3
 WHERE S1.year > S3.year)
 ORDER BY year;





-- 求每一年与过去最临近的年份之间的营业额之差 (1)：结果里不包含最早的年份
SELECT S2.year AS pre_year,
 S1.year AS now_year,
 S2.sale AS pre_sale,
 S1.sale AS now_sale,
 S1.sale - S2.sale AS diff
 FROM Sales2 S1, Sales2 S2
 WHERE S2.year = (SELECT MAX(year)
 FROM Sales2 S3
 WHERE S1.year > S3.year)
 ORDER BY now_year;

-- 求每一年与过去最临近的年份之间的营业额之差 (2)：使用自外连接。结果里包含最早的年份
SELECT S2.year AS pre_year, S1.year AS now_year,
 S2.sale AS pre_sale, S1.sale AS now_sale,
 S1.sale - S2.sale AS diff
 FROM Sales2 S1 LEFT OUTER JOIN Sales2 S2
 ON S2.year = (SELECT MAX(year)
 FROM Sales2 S3
 WHERE S1.year > S3.year)
 ORDER BY now_year;




alter TABLE analysis_business_list.hengshui_ws_list add COLUMN zhuangtai    int4
alter TABLE analysis_business_list.hengshui_ws_list add COLUMN  shop_name_   VARCHAR

alter table analysis_business_list.hengshui_ws_list alter COLUMN shop_name_ type VARCHAR(150)



查询学生姓名，如果学生名字为null或''则显示“姓名为空”
select case when coalesce(name,'') = '' then '姓名为空' else name end from student;





-- 求重叠的住宿期间
SELECT reserver, start_date, end_date
 FROM Reservations R1
 WHERE EXISTS
 (SELECT *
 FROM Reservations R2
 WHERE R1.reserver <> R2.reserver -- 与自己以外的客人进行比较
 AND ( R1.start_date BETWEEN R2.start_date AND R2.end_date
 -- 条件 (1)：自己的入住日期在他人的住宿期间内
 OR R1.end_date BETWEEN R2.start_date AND R2.end_date));
 -- 条件 (2)：自己的离店日期在他人的住宿期间内


-- 升级版 ：把完全包含别人的住宿期间的情况也输出
SELECT reserver, start_date, end_date
 FROM Reservations R1
WHERE EXISTS
 (SELECT *
 FROM Reservations R2
 WHERE R1.reserver <> R2.reserver
 AND ( ( R1.start_date BETWEEN R2.start_date
 AND R2.end_date
 OR R1.end_date BETWEEN R2.start_date
 AND R2.end_date)
 OR ( R2.start_date BETWEEN R1.start_date
 AND R1.end_date
 AND R2.end_date BETWEEN R1.start_date
 AND R1.end_date)));




-- 生成供应商的全部组合
SELECT SP1.sup AS s1, SP2.sup AS s2
 FROM SupParts SP1, SupParts SP2
 WHERE SP1.sup < SP2.sup
 GROUP BY SP1.sup, SP2.sup;



SELECT SP1.sup AS s1, SP2.sup AS s2
 FROM SupParts SP1, SupParts SP2
 WHERE SP1.sup < SP2.sup -- 生成供应商的全部组合
 AND SP1.part = SP2.part -- 条件 1 ：经营同种类型的零件
 GROUP BY SP1.sup, SP2.sup
HAVING COUNT(*) = (SELECT COUNT(*) -- 条件 2 ：经营的零件种类数相同
 FROM SupParts SP3
 WHERE SP3.sup = SP1.sup)
 AND COUNT(*) = (SELECT COUNT(*)
 FROM SupParts SP4
 WHERE SP4.sup = SP2.sup);




用于删除重复行的高效 SQL
-- 删除重复行 ：使用关联子查询
DELETE FROM Products
 WHERE rowid < ( SELECT MAX(P2.rowid)
 FROM Products P2
 WHERE Products.name = P2. name
 AND Products.price = P2.price ) ;

-- 用于删除重复行的高效 SQL 语句 (1)：通过 EXCEPT 求补集
DELETE FROM Products
 WHERE rowid IN ( SELECT rowid -- 全部 rowid
 FROM Products
 EXCEPT -- 减去
 SELECT MAX(rowid) -- 要留下的 rowid
 FROM Products
 GROUP BY name, price) ;


-- 删除重复行的高效 SQL 语句 (2)：通过 NOT IN 求补集
DELETE FROM Products
 WHERE rowid NOT IN ( SELECT MAX(rowid)
 FROM Products
 GROUP BY name, price);


判断两张表 UNION 之后的结果与原来的两张表行数是否相等
SELECT CASE WHEN COUNT(*) = (SELECT COUNT(*) FROM tbl_A )
 AND COUNT(*) = (SELECT COUNT(*) FROM tbl_B )
 THEN '相等'
 ELSE '不相等' END AS result
 FROM ( SELECT *
 FROM tbl_A
 UNION
 SELECT *
 FROM tbl_B ) TMP;



EXISTS参数是行数据的集合
           
             
 CREATE TABLE test4 (  
     id BIGINT UNSIGNED  PRIMARY KEY AUTO_INCREMENT,  
     brand VARCHAR(255) NOT NULL,  
     color ENUM('RED','GREEN','BLUE')
  ) ENGINE = InnoDB; 



SELECT student_id
 FROM TestScores TS1
 WHERE subject IN ('数学', '语文')
 AND NOT EXISTS
 (SELECT *
 FROM TestScores TS2
 WHERE TS2.student_id = TS1.student_id
 AND 1 = CASE WHEN subject = '数学' AND score < 80 THEN 1
 WHEN subject = '语文' AND score < 50 THEN 1
 ELSE 0 END)
 GROUP BY student_id
HAVING COUNT(*) = 2; -- 必须两门科目都有分数






-- 查询完成到了工程 1 的项目 ：面向集合的解法
SELECT project_id
 FROM Projects
 GROUP BY project_id
HAVING COUNT(*) = SUM(CASE WHEN step_nbr <= 1 AND status = '完成' THEN 1
 WHEN step_nbr > 1 AND status = '等待' THEN 1
 ELSE 0 END);

            
            
 -- 查询完成到了工程 1 的项目 ：谓词逻辑的解法
SELECT *
 FROM Projects P1
 WHERE NOT EXISTS
 (SELECT status
 FROM Projects P2
 WHERE P1.project_id = P2. project_id -- 以项目为单位进行条件判断
 AND status <> CASE WHEN step_nbr <= 1 -- 使用双重否定来表达全称量化命题
 THEN '完成'
 ELSE '等待' END);           
            
            
            
            
            
1. 查询“都是 1”的行

SELECT *
 FROM ArrayTbl
 WHERE 1 = ALL (col1, col2, col3, col4, col5, col6, col7, col8, col9, col10);
 
2. 查询“至少有一个 9”的行
            
SELECT *
 FROM ArrayTbl
 WHERE 9 = ANY (col1, col2, col3, col4, col5, col6, col7, col8, col9, col10);            
            
            
-- 查询全是 NULL 的行 ：正确的解法
SELECT *
 FROM ArrayTbl
 WHERE COALESCE(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10) IS NULL;            
            
求所有的缺失编号           
SELECT seq
 FROM Sequence N
 WHERE seq BETWEEN 1 AND 12
 AND NOT EXISTS
 (SELECT *
 FROM SeqTbl S
 WHERE N.seq = S.seq );            
    
SELECT N.seq
 FROM Sequence N LEFT OUTER JOIN SeqTbl S
 ON N.seq = S.seq
 WHERE N.seq BETWEEN 1 AND 12
 AND S.seq IS NULL;

1. 首选方法：EXCEPT
2. 不支持 EXCEPT 的数据库也能使用，而且易于理解的方法：NOT IN
3. NOT IN 的相似方法：NOT EXISTS
4. 麻烦的方法：外连接






SELECT S1.seat AS start_seat,
 S2.seat AS end_seat,
 S2.seat - S1.seat + 1 AS seat_cnt
 FROM Seats3 S1, Seats3 S2, Seats3 S3
 WHERE S1.seat <= S2.seat -- 第一步 ：生成起点和终点的组合
 AND S3.seat BETWEEN S1.seat - 1 AND S2.seat + 1
GROUP BY S1.seat, S2.seat
HAVING COUNT(*) = SUM(CASE WHEN S3.seat BETWEEN S1.seat AND S2.seat
 AND S3.status = '空' THEN 1 -- 条件 1
 WHEN S3.seat = S2.seat + 1 AND S3.status = '占' THEN 1 -- 条件 2
 WHEN S3.seat = S1.seat - 1 AND S3.status = '占' THEN 1 -- 条件 3
 ELSE 0 END);


所有队员都处于‘待命’状态      “所有队员都处于待命状态”＝“不存在不处于待命状态的队员”
-- 用谓词表达全称量化命题
SELECT team_id, member
 FROM Teams T1
 WHERE NOT EXISTS
 (SELECT *
 FROM Teams T2
 WHERE T1.team_id = T2.team_id
 AND status <> '待命' );

-- 用集合表达全称量化命题 (1)
SELECT team_id
 FROM Teams
 GROUP BY team_id
HAVING COUNT(*) = SUM(CASE WHEN status = '待命'
 THEN 1
 ELSE 0 END);


-- 用集合表达全称量化命题 (2)
SELECT team_id
 FROM Teams
 GROUP BY team_id
HAVING MAX(status) = '待命'
 AND MIN(status) = '待命';



-- 选中材料存在重复的生产地
SELECT center
 FROM Materials
 GROUP BY center
HAVING COUNT(material) <> COUNT(DISTINCT material);

SELECT center,
 CASE WHEN COUNT(material) <> COUNT(DISTINCT material) THEN '存在重复'
 ELSE '不存在重复' END AS status
 FROM Materials
 GROUP BY center;

-- 存在重复的集合 ：使用 EXISTS
SELECT center, material
 FROM Materials M1
 WHERE EXISTS
 (SELECT *
 FROM Materials M2
 WHERE M1.center = M2.center
 AND M1.receive_date <> M2.receive_date
 AND M1.material = M2.material);


-- 如果有查询结果，说明存在缺失的编号
SELECT '存在缺失的编号' AS gap
 FROM SeqTbl
HAVING COUNT(*) <> MAX(seq);


-- 如果有查询结果，说明存在缺失的编号 ：只调查数列的连续性
SELECT '存在缺失的编号' AS gap
 FROM SeqTbl
HAVING COUNT(*) <> MAX(seq) - MIN(seq) + 1 ;


-- 不论是否存在缺失的编号都返回一行结果
SELECT CASE WHEN COUNT(*) = 0
 THEN '表为空'
 WHEN COUNT(*) <> MAX(seq) - MIN(seq) + 1
 THEN '存在缺失的编号'
 ELSE '连续' END AS gap
 FROM SeqTbl;



-- 查找最小的缺失编号 ：表中没有 1 时返回 1
SELECT CASE WHEN COUNT(*) = 0 OR MIN(seq) > 1 -- 最小值不是 1 时→返回 1
 THEN 1
 ELSE (SELECT MIN(seq +1) -- 最小值是1时→返回最小的缺失编号
 FROM SeqTbl S1
 WHERE NOT EXISTS
 (SELECT *
 FROM SeqTbl S2
 WHERE S2.seq = S1.seq + 1)) END
 FROM SeqTbl;



查询出 75% 以上的学生分数都在 80 分以上的班级
 SELECT class
 FROM TestResults
GROUP BY class
 HAVING COUNT(*) * 0.75
 <= SUM(CASE WHEN score >= 80
 THEN 1
 ELSE 0 END) ;
        
查询出分数在 50 分以上的男生的人数比分数在 50 分以上的女生的人数多的班级       
SELECT class
 FROM TestResults
GROUP BY class
 HAVING SUM(CASE WHEN score >= 50 AND sex = '男'
 THEN 1
 ELSE 0 END)
 > SUM(CASE WHEN score >= 50 AND sex = '女'
 THEN 1
 ELSE 0 END) ;       
        
 查询出女生平均分比男生平均分高的班级            
-- 比较男生和女生平均分的 SQL 语句 (1)：对空集使用 AVG 后返回 0
 SELECT class
 FROM TestResults
GROUP BY class
 HAVING AVG(CASE WHEN sex = '男'
 THEN score
 ELSE 0 END)
 < AVG(CASE WHEN sex = '女'
 THEN score
 ELSE 0 END) ;        
        
        
-- 比较男生和女生平均分的 SQL 语句 (2)：对空集求平均值后返回 NULL
 SELECT class
 FROM TestResults
GROUP BY class
 HAVING AVG(CASE WHEN sex = '男'
 THEN score
 ELSE NULL END)
 < AVG(CASE WHEN sex = '女'
 THEN score
 ELSE NULL END) ;        
        
        
        
■ 用于调查集合性质的常用条件及其用途
No 条件表达式 用途
1 COUNT (DISTINCT col) = COUNT (col) col 列没有重复的值
2 COUNT(*) = COUNT(col) col 列不存在 NULL
3 COUNT(*) = MAX(col) col 列是连续的编号（起始值是 1）
4 COUNT(*) = MAX(col) - MIN(col) + 1 col 列是连续的编号（起始值是任意整数）
5 MIN(col) = MAX(col) col 列都是相同值，或者是 NULL
6 MIN(col) * MAX(col) > 0 col 列全是正数或全是负数
7 MIN(col) * MAX(col) < 0 col 列的最大值是正数，最小值是负数
8 MIN(ABS(col)) = 0 col 列最少有一个是 0
9 MIN(col - 常量 ) = - MAX(col - 常量 ) col 列的最大值和最小值与指定常量等距
        
        
        
-- 选择（材料，原产国）组合有重复的生产地
SELECT center
 FROM Materials2
 GROUP BY center
HAVING COUNT(material || orgland) <> COUNT(DISTINCT material || orgland);       
        
        
 SELECT student_id
 FROM TestScores
 WHERE subject IN ('数学', '语文')
 GROUP BY student_id
HAVING SUM(CASE WHEN subject = '数学' AND score >= 80 THEN 1
 WHEN subject = '语文' AND score >= 50 THEN 1
 ELSE 0 END) = 2;       
        
        
        
        
        
        
        
        












