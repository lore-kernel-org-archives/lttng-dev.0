From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 14/30] Drop support for
 kernels < 3.0 from block instrumentation
Date: Thu,  8 Nov 2018 16:45:19 -0500
Message-ID: <20181108214535.12081-14-mjeanson__6697.24195399812$1541713640$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKf6L4bzqDt
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:58 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id D86CE24ADFF
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:58 -0500 (EST)
In-Reply-To: <20181108214535.12081-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/block.h | 89 +--------------------
 1 file changed, 1 insertion(+), 88 deletions(-)

diff --git a/instrumentation/events/lttng-module/block.h b/instrumentation/events/lttng-module/block.h
index e7e9449..9f77526 100644
--- a/instrumentation/events/lttng-module/block.h
+++ b/instrumentation/events/lttng-module/block.h
@@ -81,24 +81,7 @@ enum {
 			| ((rw) & REQ_FLUSH ? RWBS_FLAG_FLUSH : 0)	      \
 			| ((rw) & REQ_FUA ? RWBS_FLAG_FUA : 0))
 
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
-
-#define lttng_req_op(rq)
-#define lttng_req_rw(rq)	((rq)->cmd_flags)
-#define lttng_bio_op(bio)
-#define lttng_bio_rw(bio)	((bio)->bi_rw)
-
-#define blk_rwbs_ctf_integer(type, rwbs, op, rw, bytes)			      \
-		ctf_integer(type, rwbs, ((rw) & WRITE ? RWBS_FLAG_WRITE :     \
-			( (rw) & REQ_DISCARD ? RWBS_FLAG_DISCARD :	      \
-			( (bytes) ? RWBS_FLAG_READ :			      \
-			( 0 ))))					      \
-			| ((rw) & REQ_RAHEAD ? RWBS_FLAG_RAHEAD : 0)	      \
-			| ((rw) & REQ_SYNC ? RWBS_FLAG_SYNC : 0)	      \
-			| ((rw) & REQ_META ? RWBS_FLAG_META : 0)	      \
-			| ((rw) & REQ_SECURE ? RWBS_FLAG_SECURE : 0))
-
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
+#else
 
 #define lttng_req_op(rq)
 #define lttng_req_rw(rq)	((rq)->cmd_flags)
@@ -111,28 +94,10 @@ enum {
 			( (bytes) ? RWBS_FLAG_READ :			      \
 			( 0 ))))					      \
 			| ((rw) & REQ_RAHEAD ? RWBS_FLAG_RAHEAD : 0)	      \
-			| ((rw) & REQ_HARDBARRIER ? RWBS_FLAG_BARRIER : 0)    \
 			| ((rw) & REQ_SYNC ? RWBS_FLAG_SYNC : 0)	      \
 			| ((rw) & REQ_META ? RWBS_FLAG_META : 0)	      \
 			| ((rw) & REQ_SECURE ? RWBS_FLAG_SECURE : 0))
 
-#else
-
-#define lttng_req_op(rq)
-#define lttng_req_rw(rq)	((rq)->cmd_flags)
-#define lttng_bio_op(bio)
-#define lttng_bio_rw(bio)	((bio)->bi_rw)
-
-#define blk_rwbs_ctf_integer(type, rwbs, op, rw, bytes)			      \
-		ctf_integer(type, rwbs, ((rw) & WRITE ? RWBS_FLAG_WRITE :     \
-			( (rw) & (1 << BIO_RW_DISCARD) ? RWBS_FLAG_DISCARD :  \
-			( (bytes) ? RWBS_FLAG_READ :			      \
-			( 0 ))))					      \
-			| ((rw) & (1 << BIO_RW_AHEAD) ? RWBS_FLAG_RAHEAD : 0) \
-			| ((rw) & (1 << BIO_RW_SYNCIO) ? RWBS_FLAG_SYNC : 0)  \
-			| ((rw) & (1 << BIO_RW_META) ? RWBS_FLAG_META : 0)    \
-			| ((rw) & (1 << BIO_RW_BARRIER) ? RWBS_FLAG_BARRIER : 0))
-
 #endif
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0))
@@ -653,15 +618,9 @@ LTTNG_TRACEPOINT_EVENT(block_bio_bounce,
  */
 LTTNG_TRACEPOINT_EVENT(block_bio_complete,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
 	TP_PROTO(struct request_queue *q, struct bio *bio, int error),
 
 	TP_ARGS(q, bio, error),
-#else
-	TP_PROTO(struct request_queue *q, struct bio *bio),
-
-	TP_ARGS(q, bio),
-#endif
 
 	TP_FIELDS(
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0))
@@ -679,11 +638,7 @@ LTTNG_TRACEPOINT_EVENT(block_bio_complete,
 #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
 		ctf_integer(sector_t, sector, bio->bi_sector)
 		ctf_integer(unsigned int, nr_sector, bio->bi_size >> 9)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
 		ctf_integer(int, error, error)
-#else
-		ctf_integer(int, error, 0)
-#endif
 		blk_rwbs_ctf_integer(unsigned int, rwbs,
 			lttng_bio_op(bio), lttng_bio_rw(bio), bio->bi_size)
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0)) */
@@ -938,43 +893,17 @@ LTTNG_TRACEPOINT_EVENT(block_plug,
 
 LTTNG_TRACEPOINT_EVENT_CLASS(block_unplug,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 	TP_PROTO(struct request_queue *q, unsigned int depth, bool explicit),
 
 	TP_ARGS(q, depth, explicit),
-#else
-	TP_PROTO(struct request_queue *q),
-
-	TP_ARGS(q),
-#endif
 
 	TP_FIELDS(
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 		ctf_integer(int, nr_rq, depth)
-#else
-		ctf_integer(int, nr_rq, q->rq.count[READ] + q->rq.count[WRITE])
-#endif
 		ctf_integer(pid_t, tid, current->pid)
 		ctf_array_text(char, comm, current->comm, TASK_COMM_LEN)
 	)
 )
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-/**
- * block_unplug_timer - timed release of operations requests in queue to device driver
- * @q: request queue to unplug
- *
- * Unplug the request queue @q because a timer expired and allow block
- * operation requests to be sent to the device driver.
- */
-LTTNG_TRACEPOINT_EVENT_INSTANCE(block_unplug, block_unplug_timer,
-
-	TP_PROTO(struct request_queue *q),
-
-	TP_ARGS(q)
-)
-#endif
-
 /**
  * block_unplug - release of operations requests in request queue
  * @q: request queue to unplug
@@ -984,21 +913,11 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(block_unplug, block_unplug_timer,
  * Unplug request queue @q because device driver is scheduled to work
  * on elements in the request queue.
  */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 LTTNG_TRACEPOINT_EVENT_INSTANCE(block_unplug, block_unplug,
-#else
-LTTNG_TRACEPOINT_EVENT_INSTANCE(block_unplug, block_unplug_io,
-#endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 	TP_PROTO(struct request_queue *q, unsigned int depth, bool explicit),
 
 	TP_ARGS(q, depth, explicit)
-#else
-	TP_PROTO(struct request_queue *q),
-
-	TP_ARGS(q)
-#endif
 )
 
 /**
@@ -1051,11 +970,7 @@ LTTNG_TRACEPOINT_EVENT(block_split,
  * An operation for a logical device has been mapped to the
  * raw block device.
  */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
 LTTNG_TRACEPOINT_EVENT(block_bio_remap,
-#else
-LTTNG_TRACEPOINT_EVENT(block_remap,
-#endif
 
 	TP_PROTO(struct request_queue *q, struct bio *bio, dev_t dev,
 		 sector_t from),
@@ -1085,7 +1000,6 @@ LTTNG_TRACEPOINT_EVENT(block_remap,
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 /**
  * block_rq_remap - map request for a block operation request
  * @q: queue holding the operation
@@ -1114,7 +1028,6 @@ LTTNG_TRACEPOINT_EVENT(block_rq_remap,
 			lttng_req_op(rq), lttng_req_rw(rq), blk_rq_bytes(rq))
 	)
 )
-#endif
 
 #undef __print_rwbs_flags
 #undef blk_fill_rwbs
-- 
2.17.1
