From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH lttng-modules] Clean up using global_dirty_limit
	wrapper for writeback probe
Date: Mon, 18 Feb 2013 04:17:26 -0600
Message-ID: <1361182646-31794-1-git-send-email-andrew_gabbasov__7603.73506132073$1361182697$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1U7Nmx-0008Lc-Jc
	for lttng-dev@lists.lttng.org; Mon, 18 Feb 2013 05:17:35 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1U7Nms-0005iQ-6b from Andrew_Gabbasov@mentor.com
	for lttng-dev@lists.lttng.org; Mon, 18 Feb 2013 02:17:30 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Move the wrapper around reading of global_dirty_limit to /wrapper/ directory.
Introduce a new kallsyms_lookup_dataptr function for obtaining the address
unchanged and use it in global_dirty_limit wrapper.
Since the data address is available only if CONFIG_KALLSYMS_ALL is set,
omit the whole probe from building if this config is missing.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 probes/Makefile                |    2 ++
 probes/lttng-probe-writeback.c |   19 ++-----------
 wrapper/kallsyms.h             |    6 ++++
 wrapper/writeback.h            |   61 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 17 deletions(-)
 create mode 100644 wrapper/writeback.h

diff --git a/probes/Makefile b/probes/Makefile
index 088cd5f..08adad5 100644
--- a/probes/Makefile
+++ b/probes/Makefile
@@ -189,10 +189,12 @@ endif
 
 obj-m += lttng-probe-workqueue.o
 
+ifneq ($(CONFIG_KALLSYMS_ALL),)
 obj-m +=  $(shell \
 	if [ $(VERSION) -ge 3 \
 		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 36 \) ] ; then \
 		echo "lttng-probe-writeback.o" ; fi;)
+endif
 
 
 ifneq ($(CONFIG_KPROBES),)
diff --git a/probes/lttng-probe-writeback.c b/probes/lttng-probe-writeback.c
index 0a5c022..5e421e5 100644
--- a/probes/lttng-probe-writeback.c
+++ b/probes/lttng-probe-writeback.c
@@ -32,27 +32,12 @@
 #include <trace/events/writeback.h>
 
 #include "../lttng-kernel-version.h"
+#include "../wrapper/writeback.h"
 
 /* #if <check version number if global_dirty_limit will be exported> */
-#ifdef CONFIG_KALLSYMS
-#include "../wrapper/kallsyms.h"
 
-static unsigned long *wrapper_global_dirty_limit_sym = 0;
-static inline
-unsigned long wrapper_global_dirty_limit(void)
-{
-	if (!wrapper_global_dirty_limit_sym)
-		wrapper_global_dirty_limit_sym =
-			(void *)kallsyms_lookup_funcptr("global_dirty_limit");
-	if (wrapper_global_dirty_limit_sym)
-		return *wrapper_global_dirty_limit_sym;
-	else {
-		printk(KERN_WARNING "LTTng: global_dirty_limit symbol lookup failed.\n");
-		return 0;
-	}
-}
 #define global_dirty_limit wrapper_global_dirty_limit()
-#endif
+
 /* #endif <check version number> */
 
 /*
diff --git a/wrapper/kallsyms.h b/wrapper/kallsyms.h
index f07788a..ad9e1f2 100644
--- a/wrapper/kallsyms.h
+++ b/wrapper/kallsyms.h
@@ -42,4 +42,10 @@ unsigned long kallsyms_lookup_funcptr(const char *name)
 #endif
 	return addr;
 }
+
+static inline
+unsigned long kallsyms_lookup_dataptr(const char *name)
+{
+	return kallsyms_lookup_name(name);
+}
 #endif /* _LTTNG_WRAPPER_KALLSYMS_H */
diff --git a/wrapper/writeback.h b/wrapper/writeback.h
new file mode 100644
index 0000000..818ddd6
--- /dev/null
+++ b/wrapper/writeback.h
@@ -0,0 +1,61 @@
+#ifndef _LTTNG_WRAPPER_WRITEBACK_H
+#define _LTTNG_WRAPPER_WRITEBACK_H
+
+/*
+ * wrapper/writeback.h
+ *
+ * wrapper around global_dirty_limit read. Using KALLSYMS with KALLSYMS_ALL
+ * to get its address when available, else we need to have a kernel that
+ * exports this variable to GPL modules.
+ *
+ * Copyright (C) 2013 Mentor Graphics Corp.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; only
+ * version 2.1 of the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifdef CONFIG_KALLSYMS_ALL
+
+#include <linux/kallsyms.h>
+#include "kallsyms.h"
+
+static unsigned long *global_dirty_limit_sym = 0;
+
+static inline
+unsigned long wrapper_global_dirty_limit(void)
+{
+	if (!global_dirty_limit_sym)
+		global_dirty_limit_sym =
+			(void *)kallsyms_lookup_dataptr("global_dirty_limit");
+	if (global_dirty_limit_sym)
+		return *global_dirty_limit_sym;
+	else {
+		printk(KERN_WARNING "LTTng: global_dirty_limit symbol lookup failed.\n");
+		return 0;
+	}
+}
+
+#else
+
+#include <linux/writeback.h>
+
+static inline
+unsigned long wrapper_global_dirty_limit(void)
+{
+	return global_dirty_limit;
+}
+
+#endif
+
+#endif /* _LTTNG_WRAPPER_WRITEBACK_H */
-- 
1.7.10.4
