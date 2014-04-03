From: Jan Glauber <jan.glauber@gmail.com>
Subject: [RFC Patch Tools 2/4] Seperate probe modules from
	control modules
Date: Thu,  3 Apr 2014 12:57:45 +0200
Message-ID: <d292e2654493cbff0addbe9c4fab99dd05a4ea1c.1396521858.git.jan.glauber__41045.7941274673$1396527666$gmane$org@gmail.com>
References: <cover.1396521858.git.jan.glauber@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WVfMg-0007uQ-5J
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 06:59:22 -0400
Received: by mail-wg0-f41.google.com with SMTP id n12so1668339wgh.12
 for <lttng-dev@lists.lttng.org>; Thu, 03 Apr 2014 03:59:16 -0700 (PDT)
In-Reply-To: <cover.1396521858.git.jan.glauber@gmail.com>
In-Reply-To: <cover.1396521858.git.jan.glauber@gmail.com>
References: <cover.1396521858.git.jan.glauber@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Move all control modules to the control list and make a seperate
probes list.

Signed-off-by: Jan Glauber <jan.glauber@gmail.com>
---
 src/bin/lttng-sessiond/modprobe.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index b84c07e..ea3fb39 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -25,16 +25,9 @@
 #include "modprobe.h"
 #include "kern-modules.h"
 
-/* MUST be loaded first */
+/* LTTng kernel tracer base modules list */
 const struct kern_modules_param kern_modules_control[] = {
-	{ "lttng-tracer", 1 },
-};
-
-/* LTTng kernel tracer modules list */
-const struct kern_modules_param kern_modules_list[] = {
-	{ "lttng-ftrace", 0 },
-	{ "lttng-kprobes", 0 },
-	{ "lttng-kretprobes", 0 },
+	{ "lttng-tracer", 1 },	/* MUST be loaded first so keep at top */
 	{ "lttng-lib-ring-buffer", 1 },
 	{ "lttng-ring-buffer-client-discard", 1 },
 	{ "lttng-ring-buffer-client-overwrite", 1 },
@@ -43,6 +36,13 @@ const struct kern_modules_param kern_modules_list[] = {
 	{ "lttng-ring-buffer-client-mmap-overwrite", 1 },
 	{ "lttng-ring-buffer-metadata-mmap-client", 1 },
 	{ "lttng-types", 0 },
+	{ "lttng-ftrace", 0 },
+	{ "lttng-kprobes", 0 },
+	{ "lttng-kretprobes", 0 },
+};
+
+/* LTTng kernel tracer probe modules list */
+const struct kern_modules_param kern_modules_probes[] = {
 	{ "lttng-probe-asoc", 0 },
 	{ "lttng-probe-block", 0 },
 	{ "lttng-probe-btrfs", 0 },
@@ -130,7 +130,7 @@ void modprobe_remove_lttng_control(void)
  */
 void modprobe_remove_lttng_data(void)
 {
-	return modprobe_remove_lttng(kern_modules_list,
+	return modprobe_remove_lttng(kern_modules_probes,
 				     ARRAY_SIZE(kern_modules_list));
 }
 
@@ -188,6 +188,6 @@ int modprobe_lttng_control(void)
  */
 int modprobe_lttng_data(void)
 {
-	return modprobe_lttng(kern_modules_list,
-			      ARRAY_SIZE(kern_modules_list));
+	return modprobe_lttng(kern_modules_probes,
+			      ARRAY_SIZE(kern_modules_probes));
 }
-- 
1.7.9.5
