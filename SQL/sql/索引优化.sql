explain SELECT * from  analysis_business_list.bt_ws_list0_2019q1_430822 where third_areaid = '511132' ORDER BY level desc limit 100
EXPLAIN ANALYZE SELECT * from  analysis_business_list.bt_ws_list0_2019q1_430822 where third_areaid = '511132' ORDER BY level desc limit 100




CREATE INDEX ws_list_2019q1_430822_idx ON  analysis_business_list.bt_ws_list0_2019q1_430822 (id, minor);


CREATE INDEX ws_list_2019q1_430822_idx ON  analysis_business_list.bt_ws_list0_2019q1_430822 (third_areaid);
CREATE INDEX ws_list_2019q1_430822_idx ON  analysis_business_list.bt_ws_list0_2019q1_430822 (level);


DROP INDEX ws_list_2019q1_430822_idx;  
DROP INDEX ws_list_2019q1_430822_idx;  



@@查看索引
select * from pg_indexes where tablename='bt_ws_list0_2019q1_430822'

   


select * from pg_statio_all_indexes where relname='bt_ws_list0_2019q1_430822';

@@修改索引
alter index idx_name rename to idx_name_new;







SELECT
A.SCHEMANAME,
A.TABLENAME,
A.INDEXNAME,
A.TABLESPACE,
A.INDEXDEF,
B.AMNAME,
C.INDEXRELID,
C.INDNATTS,
C.INDISUNIQUE,
C.INDISPRIMARY,
C.INDISCLUSTERED,
D.DESCRIPTION
FROM
PG_AM B
LEFT JOIN PG_CLASS F ON B.OID = F.RELAM
LEFT JOIN PG_STAT_ALL_INDEXES E ON F.OID = E.INDEXRELID
LEFT JOIN PG_INDEX C ON E.INDEXRELID = C.INDEXRELID
LEFT OUTER JOIN PG_DESCRIPTION D ON C.INDEXRELID = D.OBJOID,
PG_INDEXES A
WHERE
A.SCHEMANAME = E.SCHEMANAME AND A.TABLENAME = E.RELNAME AND A.INDEXNAME = E.INDEXRELNAME
AND E.SCHEMANAME = 'analysis_business_list' AND E.RELNAME = 'bt_ws_list0_2019q1_430822'






PostgreSQL既使用自身的缓冲区，也使用内核缓冲IO。
show shared_buffers



PostgreSQL将其WAL（预写日志）记录写入缓冲区，然后将这些缓冲区刷新到磁盘。
show wal_buffers;



show effective_cache_size


show work_mem




show maintenance_work_mem;


show synchronous_commit;



show checkpoint_timeout



SELECT count(*)  from  "gather_taobao"."ir_taobao_product_trade_china_2018" WHERE createtime<='20180701' --67019209




