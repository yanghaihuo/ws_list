create table dm_user_quarter_pay_summary as
	select case when ds>='20180101' and ds<='20180331' then '2018_1'
	            when ds>='20181001' and ds<='20181231' then '2018_4'
	            when ds>='20190101' and ds<='20190331' then '2019_1'
	            when ds>='20190401' and ds<='20190520' then '2019_2'
	       end as qtr
           ,case when product_id like 'vip%' then 'vip'
                 when product_id like 'coin%' then 'coin'
                 when product_id like 'gem%' then 'gem'
           end as pay_type
           ,sum(pay_money) as pay_money
           ,user_id
	from chuman_bi.chuman_tlog_pay
	where ((ds>='20180101' and ds<='20180331') or (ds>='20181001' and ds<='20190520')) and (product_id like 'vip%' or product_id like 'coin%' or product_id like 'gem%')
	group by case when ds>='20180101' and ds<='20180331' then '2018_1'
	            when ds>='20181001' and ds<='20181231' then '2018_4'
	            when ds>='20190101' and ds<='20190331' then '2019_1'
	            when ds>='20190401' and ds<='20190520' then '2019_2'
	       end
           ,case when product_id like 'vip%' then 'vip'
                 when product_id like 'coin%' then 'coin'
                 when product_id like 'gem%' then 'gem'
           end
           ,user_id
;

create table dm_user_quarter_level as
select user_id,
       case when pay_money_2018_1>= 100 then 1
            when pay_money_2018_1>= 20 and pay_money_2018_1<100 then 2
            when pay_money_2018_1>0 and pay_money_2018_1<20 then 3
       end as user_level_2018_1,
       case when pay_money_2018_4>= 100 then 1
            when pay_money_2018_4>= 20 and pay_money_2018_4<100 then 2
            when pay_money_2018_4>0 and pay_money_2018_4<20 then 3
       end as user_level_2018_4,
       case when pay_money_2019_1>= 100 then 1
            when pay_money_2019_1>= 20 and pay_money_2019_1<100 then 2
            when pay_money_2019_1>0 and pay_money_2019_1<20 then 3
       end as pay_money_2019_1,
       case when pay_money_2019_2>= 100 then 1
            when pay_money_2019_2>= 20 and pay_money_2019_2<100 then 2
            when pay_money_2019_2>0 and pay_money_2019_2<20 then 3
       end as pay_money_2019_2
from (
	select user_id
	       ,sum(case when qtr='2018_1' then pay_money end) pay_money_2018_1
	       ,sum(case when qtr='2018_4' then pay_money end) pay_money_2018_4
	       ,sum(case when qtr='2019_1' then pay_money end) pay_money_2019_1
	       ,sum(case when qtr='2019_2' then pay_money end) pay_money_2019_2
	 from dm_user_quarter_pay_summary group by user_id
) a
;



---用户类型
with tb1 as
(
select case when substr(created,1,10)>='2018-01-01' and substr(created,1,10)<='2018-03-31' then 4
	        when substr(created,1,10)>='2018-10-01' and substr(created,1,10)<='2018-12-31' then 3
	        when substr(created,1,10)>='2019-01-01' and substr(created,1,10)<='2019-03-31' then 2
	        when substr(created,1,10)>='2019-04-01' and substr(created,1,10)<='2019-05-20' then 1
	        else 0
	   end as reg_qtr
       ,case when to_char(from_unixtime(last_login_time),'yyyy-mm-dd') < '2019-05-01' then 1 else 0 end as is_lost
       ,id as user_id
from chuman_big_data_dev.ods_gugu_user_all
where ds='20190522' and substr(created,1,10)<='2019-05-20'
),

---消费
tb2 as (
select user_id
       ,sum(case when type='钻石' and log_type=3 then num end) as gem_3
       ,sum(case when type='钻石' and log_type=4 then num end) as gem_4
       ,sum(case when type='钻石' and log_type=5 then num end) as gem_5
       ,sum(case when type='钻石' and log_type=10 then num end) as gem_10
       ,sum(case when type='钻石' and log_type=15 then num end) as gem_15
       ,sum(case when type='钻石' and log_type=2 then num end) as gem_2
       ,sum(case when type='钻石' and log_type=21 then num end) as gem_21
       ,sum(case when type='钻石' and log_type=17 then num end) as gem_17
       ,sum(case when type='钻石' and log_type=18 then num end) as gem_18
       ,sum(case when type='钻石' and log_type=19 then num end) as gem_19
       ,sum(case when type='钻石' and log_type=12 then num end) as gem_12
       ,sum(case when type='钻石' and log_type=26 then num end) as gem_26
       ,sum(case when type='金币' and log_type=5 then num end) as coin_5
       ,sum(case when type='金币' and log_type=8 then num end) as coin_8
       ,sum(case when type='金币' and log_type=14 then num end) as coin_14
       ,sum(case when type='金币' and log_type=16 then num end) as coin_16
       ,sum(case when type='金币' and log_type=2 then num end) as coin_2
       ,sum(case when type='金币' and log_type=1 then num end) as coin_1
       ,sum(case when type='金币' and log_type=4 then num end) as coin_4
       ,sum(case when type='钻石' then num end) tot_gem
       ,sum(case when type='金币' then num end) tot_coin
  from chuman_bi.chuman_consume_log
 where ds >='20190401' and ds<='20190520'
   and ((type='钻石' and log_type in (2,3,4,5,10,12,15,17,18,19,21,26)) or (type='金币' and log_type in (1,2,4,5,8,14,16)))
 group by user_id
),

---充值
tb3 as (
select user_id,sum(case when pay_type='coin' then pay_money end) coin_pay ,sum(case when pay_type='vip' then pay_money end) vip_pay ,sum(case when pay_type='gem' then pay_money end) gem_pay 
  from chuman_big_data_dev.dm_user_quarter_pay_summary
  where qtr='2019_2'
  group by user_id
)

select reg_qtr
       ,is_lost
       ,user_level_2018_1
       ,user_level_2018_4
       ,user_level_2019_1
       ,user_level_2019_2
       ,is_gem_pay
       ,is_coin_pay
       ,is_vip_pay
       ,count(distinct user_id) user_num
       ,sum(total_pay) total_pay
       ,sum(gem_pay) gem_pay
       ,sum(coin_pay) coin_pay
       ,sum(vip_pay) vip_pay
       ,sum(gem_3) gem_3
       ,sum(gem_4) gem_4
       ,sum(gem_5) gem_5
       ,sum(gem_10) gem_10
       ,sum(gem_15) gem_15
       ,sum(gem_2) gem_2
       ,sum(gem_21) gem_21
       ,sum(gem_17) gem_17
       ,sum(gem_18) gem_18
       ,sum(gem_19) gem_19
       ,sum(gem_12) gem_12
       ,sum(gem_26) gem_26
       ,sum(coin_5) coin_5
       ,sum(coin_8) coin_8
       ,sum(coin_14) coin_14
       ,sum(coin_16) coin_16
       ,sum(coin_2) coin_2
       ,sum(coin_1) coin_1
       ,sum(coin_4) coin_4
       ,sum(tot_gem) tot_gem
       ,sum(tot_coin) tot_coin
from 
(
	select ta.user_id
	       ,ta.reg_qtr
	       ,ta.is_lost
	       ,coalesce(td.user_level_2018_1,0) user_level_2018_1
	       ,coalesce(td.user_level_2018_4,0) user_level_2018_4
	       ,coalesce(td.pay_money_2019_1,0) user_level_2019_1
	       ,coalesce(td.pay_money_2019_2,0) user_level_2019_2
	       ,case when tc.gem_pay>0 then 1 else 0 end as is_gem_pay
	       ,case when tc.coin_pay>0 then 1 else 0 end as is_coin_pay
	       ,case when tc.vip_pay>0 then 1 else 0 end as is_vip_pay
	       ,(coalesce(tc.gem_pay,0)+coalesce(tc.coin_pay,0)+coalesce(tc.vip_pay,0)) total_pay
	       ,tc.gem_pay
	       ,tc.coin_pay
	       ,tc.vip_pay
	       ,tb.gem_3
	       ,tb.gem_4
	       ,tb.gem_5
	       ,tb.gem_10
		   ,tb.gem_15
		   ,tb.gem_2
		   ,tb.gem_21
		   ,tb.gem_17
		   ,tb.gem_18
		   ,tb.gem_19
		   ,tb.gem_12
		   ,tb.gem_26
		   ,tb.coin_5
		   ,tb.coin_8
		   ,tb.coin_14
		   ,tb.coin_16
		   ,tb.coin_2
		   ,tb.coin_1
		   ,tb.coin_4
		   ,tb.tot_gem
		   ,tb.tot_coin
	  from tb1 ta
	  left join tb2 tb
	  on ta.user_id=tb.user_id
	  left join tb3 tc
	  on ta.user_id=tc.user_id
	  left join chuman_big_data_dev.dm_user_quarter_level td
	  on ta.user_id=td.user_id
) a
group by reg_qtr,is_lost,user_level_2018_1,user_level_2018_4,user_level_2019_1,user_level_2019_2,is_gem_pay,is_coin_pay,is_vip_pay