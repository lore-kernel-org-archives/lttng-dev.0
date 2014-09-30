From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [MODULES PATCH 2/2] Sync writeback tracepoints from
	mainline
Date: Tue, 30 Sep 2014 16:49:33 -0400
Message-ID: <1412110173-3343-2-git-send-email-jdesfossez__33599.6084068485$1412110251$gmane$org@efficios.com>
References: <1412110173-3343-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XZ4Mk-0004Zc-DI
 for lttng-dev@lists.lttng.org; Tue, 30 Sep 2014 16:49:50 -0400
In-Reply-To: <1412110173-3343-1-git-send-email-jdesfossez@efficios.com>
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

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 instrumentation/events/lttng-module/writeback.h |  81 ++++++++++++++++
 instrumentation/events/mainline/writeback.h     | 122 +++++++++++++++++++++++-
 2 files changed, 198 insertions(+), 5 deletions(-)

diff --git a/instrumentation/events/lttng-module/writeback.h b/instrumentation/events/lttng-module/writeback.h
index 5525fed..111decf 100644
--- a/instrumentation/events/lttng-module/writeback.h
+++ b/instrumentation/events/lttng-module/writeback.h
@@ -5,6 +5,7 @@
 #define LTTNG_TRACE_WRITEBACK_H
 
 #include "../../../probes/lttng-tracepoint-event.h"
+#include <linux/tracepoint.h>
 #include <linux/backing-dev.h>
 #include <linux/writeback.h>
 #include <linux/version.h>
@@ -47,6 +48,86 @@ static inline struct backing_dev_info *inode_to_bdi(struct inode *inode)
 		{WB_REASON_FORKER_THREAD,	"forker_thread"}
 #endif
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0))
+LTTNG_TRACEPOINT_EVENT(writeback_dirty_page,
+	TP_PROTO(struct page *page, struct address_space *mapping),
+	TP_ARGS(page, mapping),
+	TP_STRUCT__entry (
+		__array_text(char, name, 32)
+		__field(unsigned long, ino)
+		__field(pgoff_t, index)
+	),
+	TP_fast_assign(
+		tp_memcpy(name,
+			mapping ? dev_name(mapping->backing_dev_info->dev) : "(unknown)", 32)
+		tp_assign(ino, mapping ? mapping->host->i_ino : 0)
+		tp_assign(index, page->index)
+	),
+	TP_printk("bdi %s: ino=%lu index=%lu",
+		__entry->name,
+		__entry->ino,
+		__entry->index
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT_CLASS(writeback_dirty_inode_template,
+	TP_PROTO(struct inode *inode, int flags),
+	TP_ARGS(inode, flags),
+	TP_STRUCT__entry (
+		__array_text(char, name, 32)
+		__field(unsigned long, ino)
+		__field(unsigned long, flags)
+	),
+	TP_fast_assign(
+		/* may be called for files on pseudo FSes w/ unregistered bdi */
+		tp_memcpy(name,
+			inode->i_mapping->backing_dev_info->dev ?
+				dev_name(inode->i_mapping->backing_dev_info->dev) : "(unknown)", 32)
+		tp_assign(ino, inode->i_ino)
+		tp_assign(flags, flags)
+	),
+	TP_printk("bdi %s: ino=%lu flags=%s",
+		__entry->name,
+		__entry->ino,
+		show_inode_state(__entry->flags)
+	)
+)
+#define LTTNG_TRACEPOINT_EVENT_WRITEBACK_DIRTY_INODE_TEMPLATE(name) \
+LTTNG_TRACEPOINT_EVENT_INSTANCE(writeback_dirty_inode_template, name, \
+	TP_PROTO(struct inode *inode, int flags), \
+	TP_ARGS(inode, flags))
+LTTNG_TRACEPOINT_EVENT_WRITEBACK_DIRTY_INODE_TEMPLATE(writeback_dirty_inode_start)
+LTTNG_TRACEPOINT_EVENT_WRITEBACK_DIRTY_INODE_TEMPLATE(writeback_dirty_inode)
+
+LTTNG_TRACEPOINT_EVENT_CLASS(writeback_write_inode_template,
+	TP_PROTO(struct inode *inode, struct writeback_control *wbc),
+	TP_ARGS(inode, wbc),
+	TP_STRUCT__entry (
+		__array_text(char, name, 32)
+		__field(unsigned long, ino)
+		__field(int, sync_mode)
+	),
+	TP_fast_assign(
+		tp_memcpy(name,
+			dev_name(inode->i_mapping->backing_dev_info->dev), 32)
+		tp_assign(ino, inode->i_ino)
+		tp_assign(sync_mode, wbc->sync_mode)
+	),
+	TP_printk("bdi %s: ino=%lu sync_mode=%d",
+		__entry->name,
+		__entry->ino,
+		__entry->sync_mode
+	)
+)
+
+#define LTTNG_TRACEPOINT_EVENT_WRITEBACK_WRITE_INODE(name) \
+LTTNG_TRACEPOINT_EVENT_INSTANCE(writeback_write_inode_template, name, \
+	TP_PROTO(struct inode *inode, struct writeback_control *wbc), \
+	TP_ARGS(inode, wbc))
+LTTNG_TRACEPOINT_EVENT_WRITEBACK_WRITE_INODE(writeback_write_inode_start)
+LTTNG_TRACEPOINT_EVENT_WRITEBACK_WRITE_INODE(writeback_write_inode)
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0)) */
+
 LTTNG_TRACEPOINT_EVENT_CLASS(writeback_work_class,
 	TP_PROTO(struct backing_dev_info *bdi, struct wb_writeback_work *work),
 	TP_ARGS(bdi, work),
diff --git a/instrumentation/events/mainline/writeback.h b/instrumentation/events/mainline/writeback.h
index b453d92..cee02d6 100644
--- a/instrumentation/events/mainline/writeback.h
+++ b/instrumentation/events/mainline/writeback.h
@@ -4,6 +4,7 @@
 #if !defined(_TRACE_WRITEBACK_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_WRITEBACK_H
 
+#include <linux/tracepoint.h>
 #include <linux/backing-dev.h>
 #include <linux/writeback.h>
 
@@ -32,6 +33,115 @@
 
 struct wb_writeback_work;
 
+TRACE_EVENT(writeback_dirty_page,
+
+	TP_PROTO(struct page *page, struct address_space *mapping),
+
+	TP_ARGS(page, mapping),
+
+	TP_STRUCT__entry (
+		__array(char, name, 32)
+		__field(unsigned long, ino)
+		__field(pgoff_t, index)
+	),
+
+	TP_fast_assign(
+		strncpy(__entry->name,
+			mapping ? dev_name(mapping->backing_dev_info->dev) : "(unknown)", 32);
+		__entry->ino = mapping ? mapping->host->i_ino : 0;
+		__entry->index = page->index;
+	),
+
+	TP_printk("bdi %s: ino=%lu index=%lu",
+		__entry->name,
+		__entry->ino,
+		__entry->index
+	)
+);
+
+DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
+
+	TP_PROTO(struct inode *inode, int flags),
+
+	TP_ARGS(inode, flags),
+
+	TP_STRUCT__entry (
+		__array(char, name, 32)
+		__field(unsigned long, ino)
+		__field(unsigned long, flags)
+	),
+
+	TP_fast_assign(
+		struct backing_dev_info *bdi = inode->i_mapping->backing_dev_info;
+
+		/* may be called for files on pseudo FSes w/ unregistered bdi */
+		strncpy(__entry->name,
+			bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
+		__entry->ino		= inode->i_ino;
+		__entry->flags		= flags;
+	),
+
+	TP_printk("bdi %s: ino=%lu flags=%s",
+		__entry->name,
+		__entry->ino,
+		show_inode_state(__entry->flags)
+	)
+);
+
+DEFINE_EVENT(writeback_dirty_inode_template, writeback_dirty_inode_start,
+
+	TP_PROTO(struct inode *inode, int flags),
+
+	TP_ARGS(inode, flags)
+);
+
+DEFINE_EVENT(writeback_dirty_inode_template, writeback_dirty_inode,
+
+	TP_PROTO(struct inode *inode, int flags),
+
+	TP_ARGS(inode, flags)
+);
+
+DECLARE_EVENT_CLASS(writeback_write_inode_template,
+
+	TP_PROTO(struct inode *inode, struct writeback_control *wbc),
+
+	TP_ARGS(inode, wbc),
+
+	TP_STRUCT__entry (
+		__array(char, name, 32)
+		__field(unsigned long, ino)
+		__field(int, sync_mode)
+	),
+
+	TP_fast_assign(
+		strncpy(__entry->name,
+			dev_name(inode->i_mapping->backing_dev_info->dev), 32);
+		__entry->ino		= inode->i_ino;
+		__entry->sync_mode	= wbc->sync_mode;
+	),
+
+	TP_printk("bdi %s: ino=%lu sync_mode=%d",
+		__entry->name,
+		__entry->ino,
+		__entry->sync_mode
+	)
+);
+
+DEFINE_EVENT(writeback_write_inode_template, writeback_write_inode_start,
+
+	TP_PROTO(struct inode *inode, struct writeback_control *wbc),
+
+	TP_ARGS(inode, wbc)
+);
+
+DEFINE_EVENT(writeback_write_inode_template, writeback_write_inode,
+
+	TP_PROTO(struct inode *inode, struct writeback_control *wbc),
+
+	TP_ARGS(inode, wbc)
+);
+
 DECLARE_EVENT_CLASS(writeback_work_class,
 	TP_PROTO(struct backing_dev_info *bdi, struct wb_writeback_work *work),
 	TP_ARGS(bdi, work),
@@ -74,7 +184,6 @@ DECLARE_EVENT_CLASS(writeback_work_class,
 DEFINE_EVENT(writeback_work_class, name, \
 	TP_PROTO(struct backing_dev_info *bdi, struct wb_writeback_work *work), \
 	TP_ARGS(bdi, work))
-DEFINE_WRITEBACK_WORK_EVENT(writeback_nothread);
 DEFINE_WRITEBACK_WORK_EVENT(writeback_queue);
 DEFINE_WRITEBACK_WORK_EVENT(writeback_exec);
 DEFINE_WRITEBACK_WORK_EVENT(writeback_start);
@@ -113,12 +222,8 @@ DEFINE_EVENT(writeback_class, name, \
 
 DEFINE_WRITEBACK_EVENT(writeback_nowork);
 DEFINE_WRITEBACK_EVENT(writeback_wake_background);
-DEFINE_WRITEBACK_EVENT(writeback_wake_thread);
-DEFINE_WRITEBACK_EVENT(writeback_wake_forker_thread);
 DEFINE_WRITEBACK_EVENT(writeback_bdi_register);
 DEFINE_WRITEBACK_EVENT(writeback_bdi_unregister);
-DEFINE_WRITEBACK_EVENT(writeback_thread_start);
-DEFINE_WRITEBACK_EVENT(writeback_thread_stop);
 
 DECLARE_EVENT_CLASS(wbc_class,
 	TP_PROTO(struct writeback_control *wbc, struct backing_dev_info *bdi),
@@ -479,6 +584,13 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 	)
 );
 
+DEFINE_EVENT(writeback_single_inode_template, writeback_single_inode_start,
+	TP_PROTO(struct inode *inode,
+		 struct writeback_control *wbc,
+		 unsigned long nr_to_write),
+	TP_ARGS(inode, wbc, nr_to_write)
+);
+
 DEFINE_EVENT(writeback_single_inode_template, writeback_single_inode,
 	TP_PROTO(struct inode *inode,
 		 struct writeback_control *wbc,
-- 
1.9.1
