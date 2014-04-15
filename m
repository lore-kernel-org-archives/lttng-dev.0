From: Houssem Daoud <houssemmh@gmail.com>
Subject: [Patch][Lttng Modules] Statedump event for block devices
Date: Tue, 15 Apr 2014 12:06:50 -0400
Message-ID: <1397578010-8459-1-git-send-email-houssemmh__6634.46444455094$1397580089$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <houssemmh@gmail.com>) id 1Wa5t2-0002Lp-Nr
 for lttng-dev@lists.lttng.org; Tue, 15 Apr 2014 12:07:10 -0400
Received: by mail-oa0-f42.google.com with SMTP id i4so11121133oah.29
 for <lttng-dev@lists.lttng.org>; Tue, 15 Apr 2014 09:06:59 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Houssem Daoud <houssemmh@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Houssem Daoud <houssemmh@gmail.com>
---
 .../events/lttng-module/lttng-statedump.h          | 15 ++++++
 lttng-statedump-impl.c                             | 60 ++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/instrumentation/events/lttng-module/lttng-statedump.h b/instrumentation/events/lttng-module/lttng-statedump.h
index e4c86d6..07afdd0 100644
--- a/instrumentation/events/lttng-module/lttng-statedump.h
+++ b/instrumentation/events/lttng-module/lttng-statedump.h
@@ -141,6 +141,21 @@ TRACE_EVENT(lttng_statedump_network_interface,
 	TP_printk("")
 )
 
+TRACE_EVENT(lttng_statedump_block_device,
+	TP_PROTO(struct lttng_session *session,
+		int dev, const char *diskname),
+	TP_ARGS(session, dev, diskname),
+	TP_STRUCT__entry(
+		__field(int, dev)
+		__string(diskname, diskname)
+	),
+	TP_fast_assign(
+		tp_assign(dev, dev)
+		tp_strcpy(diskname, diskname)
+	),
+	TP_printk("")
+)
+
 /* Called with desc->lock held */
 TRACE_EVENT(lttng_statedump_interrupt,
 	TP_PROTO(struct lttng_session *session,
diff --git a/lttng-statedump-impl.c b/lttng-statedump-impl.c
index 40eab8e..fd0063e 100644
--- a/lttng-statedump-impl.c
+++ b/lttng-statedump-impl.c
@@ -26,6 +26,10 @@
  *	                                Various updates
  */
 
+#include <linux/ctype.h>
+#include <linux/string.h>
+#include <linux/genhd.h>
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
@@ -54,6 +58,7 @@
 #include "wrapper/nsproxy.h"
 #include "wrapper/irq.h"
 #include "wrapper/tracepoint.h"
+#include "wrapper/kallsyms.h"
 
 #ifdef CONFIG_LTTNG_HAS_LIST_IRQ
 #include <linux/irq.h>
@@ -108,7 +113,61 @@ enum lttng_process_status {
 	LTTNG_DEAD = 7,
 };
 
+
+char *disk_name(struct gendisk *hd, int partno, char *buf)
+{
+	if (!partno)
+		snprintf(buf, BDEVNAME_SIZE, "%s", hd->disk_name);
+	else if (isdigit(hd->disk_name[strlen(hd->disk_name) - 1]))
+		snprintf(buf, BDEVNAME_SIZE, "%sp%d", hd->disk_name, partno);
+	else
+		snprintf(buf, BDEVNAME_SIZE, "%s%d", hd->disk_name, partno);
+
+	return buf;
+}
+
+static
+int lttng_enumerate_block_devices(struct lttng_session *session) {
+	struct class *ptr_block_class;
+	struct device_type *ptr_disk_type;
+	struct class_dev_iter iter;
+	struct device *dev;
+	struct gendisk *disk;
+	struct disk_part_iter piter;
+	struct hd_struct *part;
+	char name_buf[BDEVNAME_SIZE];
+	int device_devt;
+
+	ptr_block_class = (struct class *) kallsyms_lookup_dataptr("block_class");
+	if (!ptr_block_class){
+		printk( KERN_WARNING "Lttng: block_class symbol lookup failed.\n");
+		return 0;
+	}
+
+	ptr_disk_type = (struct device_type*) kallsyms_lookup_dataptr("disk_type");
+	if (!ptr_disk_type){
+		printk( KERN_WARNING "Lttng: disk_type symbol lookup failed.\n");
+		return 0;
+	}
+
+	class_dev_iter_init(&iter, ptr_block_class, NULL, ptr_disk_type);
+	while ((dev = class_dev_iter_next(&iter))) {
+		disk = dev_to_disk(dev);
+		disk_part_iter_init(&piter, disk, DISK_PITER_INCL_PART0);
+		while ((part = disk_part_iter_next(&piter))) {
+			disk_name(disk, part->partno, name_buf);
+			device_devt = (int) part_devt(part);
+			trace_lttng_statedump_block_device(session, device_devt, name_buf);
+		}
+		disk_part_iter_exit(&piter);
+	}
+	class_dev_iter_exit(&iter);
+
+	return 0;
+}
+
 #ifdef CONFIG_INET
+
 static
 void lttng_enumerate_device(struct lttng_session *session,
 		struct net_device *dev)
@@ -390,6 +449,7 @@ int do_lttng_statedump(struct lttng_session *session)
 	/* FIXME lttng_enumerate_vm_maps(session); */
 	lttng_list_interrupts(session);
 	lttng_enumerate_network_ip_interface(session);
+	lttng_enumerate_block_devices(session);
 
 	/* TODO lttng_dump_idt_table(session); */
 	/* TODO lttng_dump_softirq_vec(session); */
-- 
1.8.3.2
