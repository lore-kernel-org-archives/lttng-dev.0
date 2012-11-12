From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH v3 1/2] Add default subbuf sizes getter functions
Date: Mon, 12 Nov 2012 14:23:36 -0500
Message-ID: <1352748217-21473-1-git-send-email-simon.marchi__18832.696384243$1352748262$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1TXzbl-0006mq-QC
	for lttng-dev@lists.lttng.org; Mon, 12 Nov 2012 14:23:45 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

This patch adds functions to retrieve defaults subbuf sizes. It uses the
DEFAULT_*_SUBBUF_SIZE defines from defaults.h but also make sure that the
values are at least as big as the page size.

The functions are defined as static inline in defaults.h.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 src/common/Makefile.am |    2 +-
 src/common/defaults.c  |   48 ++++++++++++++++++++++++++++++++++++++++
 src/common/defaults.h  |   57 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 1 deletions(-)
 create mode 100644 src/common/defaults.c

diff --git a/src/common/Makefile.am b/src/common/Makefile.am
index b43b376..f91259c 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -12,7 +12,7 @@ noinst_HEADERS = lttng-kernel.h defaults.h macros.h error.h futex.h \
 noinst_LTLIBRARIES = libcommon.la
 
 libcommon_la_SOURCES = error.h error.c utils.c utils.h runas.c runas.h \
-                       common.h futex.c futex.h uri.c uri.h
+                       common.h futex.c futex.h uri.c uri.h defaults.c
 
 # Consumer library
 noinst_LTLIBRARIES += libconsumer.la
diff --git a/src/common/defaults.c b/src/common/defaults.c
new file mode 100644
index 0000000..27eae90
--- /dev/null
+++ b/src/common/defaults.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2012 - Simon Marchi <simon.marchi@polymtl.ca>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <stddef.h>
+#include <unistd.h>
+
+#include "defaults.h"
+
+#ifndef max
+#define max(a, b) ((a) > (b) ? (a) : (b))
+#endif
+
+size_t default_channel_subbuf_size;
+size_t default_metadata_subbuf_size;
+size_t default_kernel_channel_subbuf_size;
+size_t default_ust_channel_subbuf_size;
+
+static void __attribute__((constructor)) init_defaults(void)
+{
+	/* libringbuffer won't accept subbuf sizes smaller than the page size,
+	 * so. If the default subbuf size is smaller, replace it by the page
+	 * size. */
+	long page_size = sysconf(_SC_PAGESIZE);
+	
+	if (page_size < 0) {
+		page_size = 0;
+	}
+
+	default_channel_subbuf_size = max(DEFAULT_CHANNEL_SUBBUF_SIZE, page_size);
+	default_metadata_subbuf_size = max(DEFAULT_METADATA_SUBBUF_SIZE, page_size);
+	default_kernel_channel_subbuf_size = max(DEFAULT_KERNEL_CHANNEL_SUBBUF_SIZE, page_size);
+	default_ust_channel_subbuf_size = max(DEFAULT_UST_CHANNEL_SUBBUF_SIZE, page_size);
+}
+
diff --git a/src/common/defaults.h b/src/common/defaults.h
index 0c0b6ac..c1dc204 100644
--- a/src/common/defaults.h
+++ b/src/common/defaults.h
@@ -109,6 +109,34 @@
 #define DEFAULT_METADATA_SUBBUF_SIZE    4096
 #define DEFAULT_METADATA_SUBBUF_NUM     2
 
+extern size_t default_channel_subbuf_size;
+extern size_t default_metadata_subbuf_size;
+
+/*
+ * Returns the default subbuf size.
+ *
+ * This function depends on a value that is set at constructor time, so it is
+ * unsafe to call it from another constructor.
+ */
+static inline
+size_t default_get_channel_subbuf_size(void)
+{
+	return default_channel_subbuf_size;
+}
+
+/*
+ * Returns the default metadata subbuf size.
+ *
+ * This function depends on a value that is set at constructor time, so it is
+ * unsafe to call it from another constructor.
+ */
+static inline
+size_t default_get_metadata_subbuf_size(void)
+{
+	return default_metadata_subbuf_size;
+}
+
+
 /* Kernel has different defaults */
 
 /* DEFAULT_KERNEL_CHANNEL_SUBBUF_SIZE must always be a power of 2 */
@@ -121,6 +149,21 @@
 /* See lttng-kernel.h enum lttng_kernel_output for channel output */
 #define DEFAULT_KERNEL_CHANNEL_OUTPUT       LTTNG_EVENT_SPLICE
 
+extern size_t default_kernel_channel_subbuf_size;
+
+/*
+ * Returns the default subbuf size for the kernel domain.
+ *
+ * This function depends on a value that is set at constructor time, so it is
+ * unsafe to call it from another constructor.
+ */
+static inline
+size_t default_get_kernel_channel_subbuf_size(void)
+{
+	return default_kernel_channel_subbuf_size;
+}
+
+
 /* User space defaults */
 
 /* Must be a power of 2 */
@@ -130,6 +173,20 @@
 /* See lttng-ust.h enum lttng_ust_output */
 #define DEFAULT_UST_CHANNEL_OUTPUT          LTTNG_EVENT_MMAP
 
+extern size_t default_ust_channel_subbuf_size;
+
+/*
+ * Returns the default subbuf size for the UST domain.
+ *
+ * This function depends on a value that is set at constructor time, so it is
+ * unsafe to call it from another constructor.
+ */
+static inline
+size_t default_get_ust_channel_subbuf_size(void)
+{
+	return default_ust_channel_subbuf_size;
+}
+
 /*
  * Default timeout value for the sem_timedwait() call. Blocking forever is not
  * wanted so a timeout is used to control the data flow and not freeze the
-- 
1.7.1
