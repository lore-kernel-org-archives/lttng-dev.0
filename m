From: Rabin Vincent <rabin.vincent@axis.com>
Subject: [PATCH lttng-modules 2.6 2/2] Fix: make writeback
	instrumentation build for 4.3 kernel
Date: Mon, 26 Oct 2015 12:40:32 +0100
Message-ID: <1445859632-20147-2-git-send-email-rabinv__26075.1781789169$1445859721$gmane$org@axis.com>
References: <1445859632-20147-1-git-send-email-rabinv@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bes.se.axis.com ([195.60.68.10])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <rabin.vincent@axis.com>) id 1Zqg8r-0007dq-7W
 for lttng-dev@lists.lttng.org; Mon, 26 Oct 2015 07:40:46 -0400
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id B3B4C2E45E
 for <lttng-dev@lists.lttng.org>; Mon, 26 Oct 2015 12:40:39 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id Od1KLnmBjwTi for <lttng-dev@lists.lttng.org>;
 Mon, 26 Oct 2015 12:40:38 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id 655072E429
 for <lttng-dev@lists.lttng.org>; Mon, 26 Oct 2015 12:40:38 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 57ED31342
 for <lttng-dev@lists.lttng.org>; Mon, 26 Oct 2015 12:40:38 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id 4C81A1351
 for <lttng-dev@lists.lttng.org>; Mon, 26 Oct 2015 12:40:38 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by thoth.se.axis.com (Postfix) with ESMTP id 4A6FE134030
 for <lttng-dev@lists.lttng.org>; Mon, 26 Oct 2015 12:40:38 +0100 (CET)
In-Reply-To: <1445859632-20147-1-git-send-email-rabinv@axis.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Rabin Vincent <rabinv@axis.com>
List-Id: lttng-dev@lists.lttng.org

The backported patch "Fix: writeback instrumentation update for 4.3
Linux kernel" (ee33121c8ff05b44ab) used a newer definition of
LTTNG_TRACEPOINT_EVENT_CLASS which is not available in v2.6.

Note that, while this fixes the build, the global_dirty_limit symbol
used by some writeback events is no longer present since the 4.2 kernel,
and will result in runtime "lookup failed" warnings if those events are
used.  This is also the case on current master.

Signed-off-by: Rabin Vincent <rabinv@axis.com>
---
 instrumentation/events/lttng-module/writeback.h |  153 +++++++++++++++++------
 1 file changed, 113 insertions(+), 40 deletions(-)

diff --git a/instrumentation/events/lttng-module/writeback.h b/instrumentation/events/lttng-module/writeback.h
index 36b6c5e..8e72125 100644
--- a/instrumentation/events/lttng-module/writeback.h
+++ b/instrumentation/events/lttng-module/writeback.h
@@ -227,9 +227,15 @@ LTTNG_TRACEPOINT_EVENT_WRITEBACK_WRITE_INODE(writeback_write_inode)
 LTTNG_TRACEPOINT_EVENT_CLASS(writeback_work_class,
 	TP_PROTO(struct bdi_writeback *wb, struct wb_writeback_work *work),
 	TP_ARGS(wb, work),
-	TP_FIELDS(
-		ctf_array_text(char, name, wb->bdi->dev ? dev_name(wb->bdi->dev) :
+	TP_STRUCT__entry(
+		__array_text(char, name, 32)
+	),
+	TP_fast_assign(
+		tp_memcpy(name, wb->bdi->dev ? dev_name(wb->bdi->dev) :
 				"(unknown)", 32)
+	),
+	TP_printk("bdi %s",
+		  __entry->name
 	)
 )
 
@@ -311,9 +317,14 @@ LTTNG_TRACEPOINT_EVENT(writeback_pages_written,
 LTTNG_TRACEPOINT_EVENT_CLASS(writeback_class,
 	TP_PROTO(struct bdi_writeback *wb),
 	TP_ARGS(wb),
-	TP_FIELDS(
-		ctf_array_text(char, name,
-			dev_name(wb->bdi->dev), 32)
+	TP_STRUCT__entry(
+		__array_text(char, name, 32)
+	),
+	TP_fast_assign(
+		tp_memcpy(name, dev_name(wb->bdi->dev), 32)
+	),
+	TP_printk("bdi %s",
+		  __entry->name
 	)
 )
 
@@ -331,9 +342,14 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(writeback_class, name, map, \
 LTTNG_TRACEPOINT_EVENT(writeback_bdi_register,
 	TP_PROTO(struct backing_dev_info *bdi),
 	TP_ARGS(bdi),
-	TP_FIELDS(
-		ctf_array_text(char, name,
-			dev_name(bdi->dev), 32)
+	TP_STRUCT__entry(
+		__array_text(char, name, 32)
+	),
+	TP_fast_assign(
+		tp_memcpy(name, dev_name(bdi->dev), 32)
+	),
+	TP_printk("bdi %s",
+		  __entry->name
 	)
 )
 
@@ -595,15 +611,38 @@ LTTNG_TRACEPOINT_EVENT_MAP(bdi_dirty_ratelimit,
 
 	TP_ARGS(wb, dirty_rate, task_ratelimit),
 
-	TP_FIELDS(
-		ctf_array_text(char, bdi, dev_name(wb->bdi->dev), 32)
-		ctf_integer(unsigned long, write_bw, KBps(wb->bdi->wb.write_bandwidth))
-		ctf_integer(unsigned long, avg_write_bw, KBps(wb->bdi->wb.avg_write_bandwidth))
-		ctf_integer(unsigned long, dirty_rate, KBps(dirty_rate))
-		ctf_integer(unsigned long, dirty_ratelimit, KBps(wb->bdi->wb.dirty_ratelimit))
-		ctf_integer(unsigned long, task_ratelimit, KBps(task_ratelimit))
-		ctf_integer(unsigned long, balanced_dirty_ratelimit,
+	TP_STRUCT__entry(
+		__array(char,		bdi, 32)
+		__field(unsigned long,	write_bw)
+		__field(unsigned long,	avg_write_bw)
+		__field(unsigned long,	dirty_rate)
+		__field(unsigned long,	dirty_ratelimit)
+		__field(unsigned long,	task_ratelimit)
+		__field(unsigned long,	balanced_dirty_ratelimit)
+	),
+
+	TP_fast_assign(
+		tp_memcpy(bdi, dev_name(wb->bdi->dev), 32)
+		tp_assign(write_bw, KBps(wb->bdi->wb.write_bandwidth))
+		tp_assign(avg_write_bw, KBps(wb->bdi->wb.avg_write_bandwidth))
+		tp_assign(dirty_rate, KBps(dirty_rate))
+		tp_assign(dirty_ratelimit, KBps(wb->bdi->wb.dirty_ratelimit))
+		tp_assign(task_ratelimit, KBps(task_ratelimit))
+		tp_assign(balanced_dirty_ratelimit,
 					KBps(wb->bdi->wb.balanced_dirty_ratelimit))
+	),
+
+	TP_printk("bdi %s: "
+		  "write_bw=%lu awrite_bw=%lu dirty_rate=%lu "
+		  "dirty_ratelimit=%lu task_ratelimit=%lu "
+		  "balanced_dirty_ratelimit=%lu",
+		  __entry->bdi,
+		  __entry->write_bw,		/* write bandwidth */
+		  __entry->avg_write_bw,	/* avg write bandwidth */
+		  __entry->dirty_rate,		/* bdi dirty rate */
+		  __entry->dirty_ratelimit,	/* base ratelimit */
+		  __entry->task_ratelimit, /* ratelimit with position control */
+		  __entry->balanced_dirty_ratelimit /* the balanced ratelimit */
 	)
 )
 
@@ -727,32 +766,66 @@ LTTNG_TRACEPOINT_EVENT_MAP(balance_dirty_pages,
 		dirtied, period, pause, start_time
 	),
 
-	TP_FIELDS(
-		ctf_array_text(char, bdi, dev_name(wb->bdi->dev), 32)
-		ctf_integer(unsigned long, limit, global_dirty_limit)
-		ctf_integer(unsigned long, setpoint,
+	TP_STRUCT__entry(
+		__array(	 char,	bdi, 32)
+		__field(unsigned long,	limit)
+		__field(unsigned long,	setpoint)
+		__field(unsigned long,	dirty)
+		__field(unsigned long,	bdi_setpoint)
+		__field(unsigned long,	bdi_dirty)
+		__field(unsigned long,	dirty_ratelimit)
+		__field(unsigned long,	task_ratelimit)
+		__field(unsigned int,	dirtied)
+		__field(unsigned int,	dirtied_pause)
+		__field(unsigned long,	paused)
+		__field(	 long,	pause)
+		__field(unsigned long,	period)
+		__field(	 long,	think)
+	),
+
+	TP_fast_assign(
+		tp_memcpy(bdi, dev_name(wb->bdi->dev), 32)
+		tp_assign(limit, global_dirty_limit)
+		tp_assign(setpoint,
 			(global_dirty_limit + (thresh + bg_thresh) / 2) / 2)
-		ctf_integer(unsigned long, dirty, dirty)
-		ctf_integer(unsigned long, bdi_setpoint,
+		tp_assign(dirty, dirty)
+		tp_assign(bdi_setpoint,
 			((global_dirty_limit + (thresh + bg_thresh) / 2) / 2) *
-				bdi_thresh / (thresh + 1))
-		ctf_integer(unsigned long, bdi_dirty, bdi_dirty)
-		ctf_integer(unsigned long, dirty_ratelimit,
-			KBps(dirty_ratelimit))
-		ctf_integer(unsigned long, task_ratelimit,
-			KBps(task_ratelimit))
-		ctf_integer(unsigned int, dirtied, dirtied)
-		ctf_integer(unsigned int, dirtied_pause,
-			current->nr_dirtied_pause)
-		ctf_integer(unsigned long, paused,
-			(jiffies - start_time) * 1000 / HZ)
-		ctf_integer(long, pause, pause * 1000 / HZ)
-		ctf_integer(unsigned long, period,
-			period * 1000 / HZ)
-		ctf_integer(long, think,
-			current->dirty_paused_when == 0 ? 0 :
-				(long)(jiffies - current->dirty_paused_when) * 1000/HZ)
-	)
+			bdi_thresh / (thresh + 1))
+		tp_assign(bdi_dirty, bdi_dirty)
+		tp_assign(dirty_ratelimit, KBps(dirty_ratelimit))
+		tp_assign(task_ratelimit, KBps(task_ratelimit))
+		tp_assign(dirtied, dirtied)
+		tp_assign(dirtied_pause, current->nr_dirtied_pause)
+		tp_assign(think, current->dirty_paused_when == 0 ? 0 :
+			(long)(jiffies - current->dirty_paused_when) * 1000/HZ)
+		tp_assign(period, period * 1000 / HZ)
+		tp_assign(pause, pause * 1000 / HZ)
+		tp_assign(paused, (jiffies - start_time) * 1000 / HZ)
+	),
+
+
+	TP_printk("bdi %s: "
+		  "limit=%lu setpoint=%lu dirty=%lu "
+		  "bdi_setpoint=%lu bdi_dirty=%lu "
+		  "dirty_ratelimit=%lu task_ratelimit=%lu "
+		  "dirtied=%u dirtied_pause=%u "
+		  "paused=%lu pause=%ld period=%lu think=%ld",
+		  __entry->bdi,
+		  __entry->limit,
+		  __entry->setpoint,
+		  __entry->dirty,
+		  __entry->bdi_setpoint,
+		  __entry->bdi_dirty,
+		  __entry->dirty_ratelimit,
+		  __entry->task_ratelimit,
+		  __entry->dirtied,
+		  __entry->dirtied_pause,
+		  __entry->paused,	/* ms */
+		  __entry->pause,	/* ms */
+		  __entry->period,	/* ms */
+		  __entry->think	/* ms */
+	  )
 )
 
 #else /* #if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)) */
-- 
1.7.10.4
