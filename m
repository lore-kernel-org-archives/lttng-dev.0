From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH 3/3] urcu: declare test_urcu_multiflavor
	functions
Date: Fri, 7 Dec 2012 17:24:55 +0800
Message-ID: <1354872295-32371-3-git-send-email-laijs__7972.10290697894$1354872356$gmane$org@cn.fujitsu.com>
References: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TguBJ-0007oh-My
	for lttng-dev@lists.lttng.org; Fri, 07 Dec 2012 04:25:18 -0500
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id qB79PaMI016399
	for <lttng-dev@lists.lttng.org>; Fri, 7 Dec 2012 17:25:36 +0800
In-Reply-To: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
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

Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
 tests/test_urcu_multiflavor-bp.c     |    1 +
 tests/test_urcu_multiflavor-mb.c     |    1 +
 tests/test_urcu_multiflavor-memb.c   |    1 +
 tests/test_urcu_multiflavor-qsbr.c   |    1 +
 tests/test_urcu_multiflavor-signal.c |    1 +
 tests/test_urcu_multiflavor.c        |    1 +
 tests/test_urcu_multiflavor.h        |   29 +++++++++++++++++++++++++++++
 7 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100644 tests/test_urcu_multiflavor.h

diff --git a/tests/test_urcu_multiflavor-bp.c b/tests/test_urcu_multiflavor-bp.c
index c9f00a3..199818b 100644
--- a/tests/test_urcu_multiflavor-bp.c
+++ b/tests/test_urcu_multiflavor-bp.c
@@ -26,6 +26,7 @@
 
 #define RCU_SIGNAL
 #include <urcu-bp.h>
+#include "test_urcu_multiflavor.h"
 
 int test_mf_bp(void)
 {
diff --git a/tests/test_urcu_multiflavor-mb.c b/tests/test_urcu_multiflavor-mb.c
index 5b5d7e4..e4ba6a4 100644
--- a/tests/test_urcu_multiflavor-mb.c
+++ b/tests/test_urcu_multiflavor-mb.c
@@ -26,6 +26,7 @@
 
 #define RCU_MB
 #include <urcu.h>
+#include "test_urcu_multiflavor.h"
 
 int test_mf_mb(void)
 {
diff --git a/tests/test_urcu_multiflavor-memb.c b/tests/test_urcu_multiflavor-memb.c
index c3a0128..583f2e1 100644
--- a/tests/test_urcu_multiflavor-memb.c
+++ b/tests/test_urcu_multiflavor-memb.c
@@ -25,6 +25,7 @@
 #endif
 
 #include <urcu.h>
+#include "test_urcu_multiflavor.h"
 
 int test_mf_memb(void)
 {
diff --git a/tests/test_urcu_multiflavor-qsbr.c b/tests/test_urcu_multiflavor-qsbr.c
index f4fb145..64f32f4 100644
--- a/tests/test_urcu_multiflavor-qsbr.c
+++ b/tests/test_urcu_multiflavor-qsbr.c
@@ -25,6 +25,7 @@
 #endif
 
 #include <urcu-qsbr.h>
+#include "test_urcu_multiflavor.h"
 
 int test_mf_qsbr(void)
 {
diff --git a/tests/test_urcu_multiflavor-signal.c b/tests/test_urcu_multiflavor-signal.c
index 5519d36..816c615 100644
--- a/tests/test_urcu_multiflavor-signal.c
+++ b/tests/test_urcu_multiflavor-signal.c
@@ -26,6 +26,7 @@
 
 #define RCU_SIGNAL
 #include <urcu.h>
+#include "test_urcu_multiflavor.h"
 
 int test_mf_signal(void)
 {
diff --git a/tests/test_urcu_multiflavor.c b/tests/test_urcu_multiflavor.c
index 825333e..cd573ca 100644
--- a/tests/test_urcu_multiflavor.c
+++ b/tests/test_urcu_multiflavor.c
@@ -21,6 +21,7 @@
  */
 
 #include <stdlib.h>
+#include "test_urcu_multiflavor.h"
 
 int main(int argc, char **argv)
 {
diff --git a/tests/test_urcu_multiflavor.h b/tests/test_urcu_multiflavor.h
new file mode 100644
index 0000000..419ad5d
--- /dev/null
+++ b/tests/test_urcu_multiflavor.h
@@ -0,0 +1,29 @@
+/*
+ * test_urcu_multiflavor.h
+ *
+ * Userspace RCU library - test multiple RCU flavors into one program
+ *
+ * Copyright February 2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright February 2012 - Lai Jiangshan <laijs@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+extern int test_mf_memb(void);
+extern int test_mf_mb(void);
+extern int test_mf_signal(void);
+extern int test_mf_qsbr(void);
+extern int test_mf_bp(void);
+
-- 
1.7.4.4
