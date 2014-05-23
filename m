From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [MODULES PATCH] Add TID field to some block_* events
Date: Fri, 23 May 2014 09:06:07 -0400
Message-ID: <1400850367-5679-1-git-send-email-jdesfossez__21667.9008947269$1400850432$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1WnpB1-0001jE-Fv
 for lttng-dev@lists.lttng.org; Fri, 23 May 2014 09:06:25 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Most of the block events have the "comm" field, but we have no way to
match a block event to a certain thread which makes performing
accurate per-thread analyses difficult. Add the TID field to the events
that already export current->comm.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 instrumentation/events/lttng-module/block.h | 56 ++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/instrumentation/events/lttng-module/block.h b/instrumentation/events/lttng-module/block.h
index e3e6b4c..83e4fec 100644
--- a/instrumentation/events/lttng-module/block.h
+++ b/instrumentation/events/lttng-module/block.h
@@ -305,6 +305,7 @@ DECLARE_EVENT_CLASS(block_rq,
 		__field(  unsigned int,	nr_sector		)
 		__field(  unsigned int,	bytes			)
 		__field(  unsigned int,	rwbs			)
+		__field(  pid_t,	tid			)
 		__array_text(  char,         comm,   TASK_COMM_LEN   )
 		__dynamic_array_hex( unsigned char,	cmd,
 			(rq->cmd_type == REQ_TYPE_BLOCK_PC) ?
@@ -323,16 +324,17 @@ DECLARE_EVENT_CLASS(block_rq,
 		tp_memcpy_dyn(cmd, (rq->cmd_type == REQ_TYPE_BLOCK_PC) ?
 					rq->cmd : NULL)
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 	),
 
-	TP_printk("%d,%d %s %u (%s) %llu + %u [%s]",
+	TP_printk("%d,%d %s %u (%s) %llu + %u [%s] %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __print_rwbs_flags(__entry->rwbs),
 		  __entry->bytes,
 		  __blk_dump_cmd(__get_dynamic_array(cmd),
 				 __get_dynamic_array_len(cmd)),
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  __entry->nr_sector, __entry->comm, __entry->pid)
 )
 
 /**
@@ -389,6 +391,7 @@ TRACE_EVENT(block_bio_bounce,
 		__field( sector_t,	sector			)
 		__field( unsigned int,	nr_sector		)
 		__field( unsigned int,	rwbs			)
+		__field( pid_t,		tid			)
 		__array_text( char,		comm,	TASK_COMM_LEN	)
 	),
 
@@ -400,6 +403,7 @@ TRACE_EVENT(block_bio_bounce,
 		tp_assign(nr_sector, bio_sectors(bio))
 		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
 		tp_assign(dev, bio->bi_bdev ?
 					  bio->bi_bdev->bd_dev : 0)
@@ -407,14 +411,15 @@ TRACE_EVENT(block_bio_bounce,
 		tp_assign(nr_sector, bio->bi_size >> 9)
 		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
 	),
 
-	TP_printk("%d,%d %s %llu + %u [%s]",
+	TP_printk("%d,%d %s %llu + %u [%s] %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __print_rwbs_flags(__entry->rwbs),
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  __entry->nr_sector, __entry->comm, __entry->pid)
 )
 
 /**
@@ -485,6 +490,7 @@ DECLARE_EVENT_CLASS(block_bio_merge,
 		__field( sector_t,	sector			)
 		__field( unsigned int,	nr_sector		)
 		__field( unsigned int,	rwbs			)
+		__field( pid_t,		tid			)
 		__array_text( char,		comm,	TASK_COMM_LEN	)
 	),
 
@@ -495,20 +501,22 @@ DECLARE_EVENT_CLASS(block_bio_merge,
 		tp_assign(nr_sector, bio_sectors(bio))
 		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
 		tp_assign(dev, bio->bi_bdev->bd_dev)
 		tp_assign(sector, bio->bi_sector)
 		tp_assign(nr_sector, bio->bi_size >> 9)
 		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
 	),
 
-	TP_printk("%d,%d %s %llu + %u [%s]",
+	TP_printk("%d,%d %s %llu + %u [%s] %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __print_rwbs_flags(__entry->rwbs),
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  __entry->nr_sector, __entry->comm, __entry->pid)
 )
 
 /**
@@ -559,6 +567,7 @@ TRACE_EVENT(block_bio_queue,
 		__field( sector_t,	sector			)
 		__field( unsigned int,	nr_sector		)
 		__field( unsigned int,	rwbs			)
+		__field( pid_t,		tid			)
 		__array_text( char,		comm,	TASK_COMM_LEN	)
 	),
 
@@ -569,19 +578,21 @@ TRACE_EVENT(block_bio_queue,
 		tp_assign(nr_sector, bio_sectors(bio))
 		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
 		tp_assign(dev, bio->bi_bdev->bd_dev)
 		tp_assign(sector, bio->bi_sector)
 		tp_assign(nr_sector, bio->bi_size >> 9)
 		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
 	),
 
-	TP_printk("%d,%d %s %llu + %u [%s]",
+	TP_printk("%d,%d %s %llu + %u [%s] %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  __entry->nr_sector, __entry->comm, __entry->pid)
 )
 #else
 DECLARE_EVENT_CLASS(block_bio,
@@ -595,6 +606,7 @@ DECLARE_EVENT_CLASS(block_bio,
 		__field( sector_t,	sector			)
 		__field( unsigned int,	nr_sector		)
 		__field( unsigned int,	rwbs			)
+		__field( pid_t,		tid			)
 		__array_text( char,		comm,	TASK_COMM_LEN	)
 	),
 
@@ -604,13 +616,14 @@ DECLARE_EVENT_CLASS(block_bio,
 		tp_assign(nr_sector, bio->bi_size >> 9)
 		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 	),
 
-	TP_printk("%d,%d %s %llu + %u [%s]",
+	TP_printk("%d,%d %s %llu + %u [%s] %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __print_rwbs_flags(__entry->rwbs),
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  __entry->nr_sector, __entry->comm, __entry->pid)
 )
 
 /**
@@ -669,6 +682,7 @@ DECLARE_EVENT_CLASS(block_get_rq,
 		__field( sector_t,	sector			)
 		__field( unsigned int,	nr_sector		)
 		__field( unsigned int,	rwbs			)
+		__field( pid_t,		tid			)
 		__array_text( char,		comm,	TASK_COMM_LEN	)
         ),
 
@@ -680,6 +694,7 @@ DECLARE_EVENT_CLASS(block_get_rq,
 		blk_fill_rwbs(rwbs, bio ? bio->bi_rw : 0,
 			      bio ? bio_sectors(bio) : 0)
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
 		tp_assign(dev, bio ? bio->bi_bdev->bd_dev : 0)
 		tp_assign(sector, bio ? bio->bi_sector : 0)
@@ -687,14 +702,15 @@ DECLARE_EVENT_CLASS(block_get_rq,
 		blk_fill_rwbs(rwbs, bio ? bio->bi_rw : 0,
 			      bio ? bio->bi_size >> 9 : 0)
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
         ),
 
-	TP_printk("%d,%d %s %llu + %u [%s]",
+	TP_printk("%d,%d %s %llu + %u [%s] %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __print_rwbs_flags(__entry->rwbs),
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  __entry->nr_sector, __entry->comm, __entry->pid)
 )
 
 /**
@@ -746,14 +762,16 @@ TRACE_EVENT(block_plug,
 	TP_ARGS(q),
 
 	TP_STRUCT__entry(
+		__field( pid_t,		tid			)
 		__array_text( char,		comm,	TASK_COMM_LEN	)
 	),
 
 	TP_fast_assign(
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 	),
 
-	TP_printk("[%s]", __entry->comm)
+	TP_printk("[%s] %d", __entry->comm, __entry->pid)
 )
 
 DECLARE_EVENT_CLASS(block_unplug,
@@ -770,6 +788,7 @@ DECLARE_EVENT_CLASS(block_unplug,
 
 	TP_STRUCT__entry(
 		__field( int,		nr_rq			)
+		__field( pid_t,		tid			)
 		__array_text( char,		comm,	TASK_COMM_LEN	)
 	),
 
@@ -780,9 +799,11 @@ DECLARE_EVENT_CLASS(block_unplug,
 		tp_assign(nr_rq, q->rq.count[READ] + q->rq.count[WRITE])
 #endif
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 	),
 
-	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
+	TP_printk("[%s] %d %d", __entry->comm, , __entry->pid,
+			__entry->nr_rq)
 )
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
@@ -850,6 +871,7 @@ TRACE_EVENT(block_split,
 		__field( sector_t,	sector				)
 		__field( sector_t,	new_sector			)
 		__field( unsigned int,	rwbs		)
+		__field( pid_t,		tid			)
 		__array_text( char,		comm,		TASK_COMM_LEN	)
 	),
 
@@ -860,21 +882,23 @@ TRACE_EVENT(block_split,
 		tp_assign(new_sector, new_sector)
 		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
 		tp_assign(dev, bio->bi_bdev->bd_dev)
 		tp_assign(sector, bio->bi_sector)
 		tp_assign(new_sector, new_sector)
 		blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
 		tp_memcpy(comm, current->comm, TASK_COMM_LEN)
+		tp_assign(tid, current->pid)
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
 	),
 
-	TP_printk("%d,%d %s %llu / %llu [%s]",
+	TP_printk("%d,%d %s %llu / %llu [%s] %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __print_rwbs_flags(__entry->rwbs),
 		  (unsigned long long)__entry->sector,
 		  (unsigned long long)__entry->new_sector,
-		  __entry->comm)
+		  __entry->comm, __entry->pid)
 )
 
 /**
-- 
1.9.1
