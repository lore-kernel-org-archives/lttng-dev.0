From: <maxin.john@enea.com>
Subject: [PATCH] lttng-module: block.h : Fix build for 3.9 kernel
Date: Mon, 25 Mar 2013 13:30:57 +0100
Message-ID: <1364214657-35068-1-git-send-email-maxin.john__28713.1250872791$1364214740$gmane$org@enea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <Maxin.John@enea.com>) id 1UK6Yd-0006Q5-9S
	for lttng-dev@lists.lttng.org; Mon, 25 Mar 2013 08:31:23 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, anders.roxell@enea.com, "Maxin B. John" <maxin.john@enea.com>
List-Id: lttng-dev@lists.lttng.org

From: "Maxin B. John" <maxin.john@enea.com>

commit :3a366e614d0837d9fc23f78cdb1a1186ebc3387f
 block: add missing block_bio_complete() tracepoint
added block_bio_complete to 3.9 kernel

commit : 8c1cf6bb02fda79b0a4b9bd121f6be6d4ce7a15a
 block: add @req to bio_{front|back}_merge tracepoints
added block_bio_backmerge and block_bio_frontmerge to 3.9 kernel

Update block.h based on these commits in mainline kernel

Fixes this build failure:
....
include/trace/events/block.h:353:1: note: previous definition of
'trace_block_bio_frontmerge' was here
make[3]: *** [/home/majo/kernel/lttng/lttng-modules/probes/
lttng-probe-block.o] Error 1
make[2]: *** [/home/majo/kernel/lttng/lttng-modules/probes] Error 2
make[1]: *** [_module_/home/majo/kernel/lttng/lttng-modules] Error 2
make: *** [default] Error 2

Signed-off-by: Maxin B. John <maxin.john@enea.com>
---
 instrumentation/events/lttng-module/block.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/instrumentation/events/lttng-module/block.h b/instrumentation/events/lttng-module/block.h
index d42ebd4..59bd2c0 100644
--- a/instrumentation/events/lttng-module/block.h
+++ b/instrumentation/events/lttng-module/block.h
@@ -311,6 +311,13 @@ TRACE_EVENT(block_bio_bounce,
  * This tracepoint indicates there is no further work to do on this
  * block IO operation @bio.
  */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0))
+/**
+ * commit :3a366e614d0837d9fc23f78cdb1a1186ebc3387f
+ * block: add missing block_bio_complete() tracepoint
+ * added block_bio_complete to 3.9.0 kernel
+ */
+#else
 TRACE_EVENT(block_bio_complete,
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
@@ -349,6 +356,7 @@ TRACE_EVENT(block_bio_complete,
 		  (unsigned long long)__entry->sector,
 		  __entry->nr_sector, __entry->error)
 )
+#endif
 
 DECLARE_EVENT_CLASS(block_bio,
 
@@ -387,6 +395,13 @@ DECLARE_EVENT_CLASS(block_bio,
  * Merging block request @bio to the end of an existing block request
  * in queue @q.
  */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0))
+/**
+ * commit : 8c1cf6bb02fda79b0a4b9bd121f6be6d4ce7a15a
+ * block: add @req to bio_{front|back}_merge tracepoints
+ * added block_bio_backmerge and block_bio_frontmerge to 3.9.0 kernel
+ */
+#else
 DEFINE_EVENT(block_bio, block_bio_backmerge,
 
 	TP_PROTO(struct request_queue *q, struct bio *bio),
@@ -408,6 +423,7 @@ DEFINE_EVENT(block_bio, block_bio_frontmerge,
 
 	TP_ARGS(q, bio)
 )
+#endif
 
 /**
  * block_bio_queue - putting new block IO operation in queue
-- 
1.7.5.4
