From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace 2/3] Port: Add OSX mman.h compat
Date: Thu,  5 Nov 2015 12:51:54 -0500
Message-ID: <1446745915-1651-2-git-send-email-mjeanson__23365.7427867458$1446746050$gmane$org@efficios.com>
References: <1446745915-1651-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZuOhu-0004Uc-OO
 for lttng-dev@lists.lttng.org; Thu, 05 Nov 2015 12:52:24 -0500
In-Reply-To: <1446745915-1651-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 formats/lttng-live/lttng-live-comm.c |  2 +-
 include/babeltrace/compat/mman.h     | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 include/babeltrace/compat/mman.h

diff --git a/formats/lttng-live/lttng-live-comm.c b/formats/lttng-live/lttng-live-comm.c
index 0efae2d..c0a1868 100644
--- a/formats/lttng-live/lttng-live-comm.c
+++ b/formats/lttng-live/lttng-live-comm.c
@@ -31,7 +31,6 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <fcntl.h>
-#include <sys/mman.h>
 #include <poll.h>
 
 #include <babeltrace/ctf/ctf-index.h>
@@ -53,6 +52,7 @@
 #include <babeltrace/compat/memstream.h>
 #include <babeltrace/compat/send.h>
 #include <babeltrace/compat/string.h>
+#include <babeltrace/compat/mman.h>
 
 #include "lttng-live.h"
 #include "lttng-viewer-abi.h"
diff --git a/include/babeltrace/compat/mman.h b/include/babeltrace/compat/mman.h
new file mode 100644
index 0000000..061e244
--- /dev/null
+++ b/include/babeltrace/compat/mman.h
@@ -0,0 +1,36 @@
+#ifndef _BABELTRACE_COMPAT_MMAN_H
+#define _BABELTRACE_COMPAT_MMAN_H
+
+/*
+ * babeltrace/compat/mman.h
+ *
+ * Copyright (C) 2015  Michael Jeanson <mjeanson@efficios.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <sys/mman.h>
+
+#ifndef MAP_ANONYMOUS
+# ifdef MAP_ANON
+#   define MAP_ANONYMOUS MAP_ANON
+# endif
+#endif
+
+#endif /* _BABELTRACE_COMPAT_MMAN_H */
-- 
1.9.1
