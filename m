From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-tools 1/5] Drop optionnal control
	modules load and unload
Date: Fri, 12 Feb 2016 16:31:44 -0500
Message-ID: <1455312708-462-1-git-send-email-mjeanson__9777.45438362963$1455312780$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aULJs-00041G-1F
 for lttng-dev@lists.lttng.org; Fri, 12 Feb 2016 16:32:04 -0500
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

The optionnal control modules are loaded and unloaded trought modules
dependencies by modprobe or libkmod. Trying to load them manually leads
to spurious log messages and slows down the sessiond startup.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/bin/lttng-sessiond/modprobe.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 2c527dc..81ce810 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -33,8 +33,6 @@
 
 /* LTTng kernel tracer mandatory core modules list */
 struct kern_modules_param kern_modules_control_core[] = {
-	{ "lttng-tracer" },	/* MUST be loaded first so keep at top */
-	{ "lttng-lib-ring-buffer" },
 	{ "lttng-ring-buffer-client-discard" },
 	{ "lttng-ring-buffer-client-overwrite" },
 	{ "lttng-ring-buffer-metadata-client" },
@@ -43,14 +41,6 @@ struct kern_modules_param kern_modules_control_core[] = {
 	{ "lttng-ring-buffer-metadata-mmap-client" },
 };
 
-/* LTTng kernel tracer optional base modules list */
-struct kern_modules_param kern_modules_control_opt[] = {
-	{ "lttng-types" },
-	{ "lttng-ftrace" },
-	{ "lttng-kprobes" },
-	{ "lttng-kretprobes" },
-};
-
 /* LTTng kernel tracer probe modules list */
 struct kern_modules_param kern_modules_probes_default[] = {
 	{ "lttng-probe-asoc" },
@@ -134,9 +124,6 @@ static void modprobe_remove_lttng(const struct kern_modules_param *modules,
  */
 void modprobe_remove_lttng_control(void)
 {
-	modprobe_remove_lttng(kern_modules_control_opt,
-			      ARRAY_SIZE(kern_modules_control_opt),
-			      LTTNG_MOD_OPTIONAL);
 	modprobe_remove_lttng(kern_modules_control_core,
 			      ARRAY_SIZE(kern_modules_control_core),
 			      LTTNG_MOD_REQUIRED);
@@ -303,11 +290,6 @@ int modprobe_lttng_control(void)
 	ret = modprobe_lttng(kern_modules_control_core,
 			     ARRAY_SIZE(kern_modules_control_core),
 			     LTTNG_MOD_REQUIRED);
-	if (ret != 0)
-		return ret;
-	ret = modprobe_lttng(kern_modules_control_opt,
-			     ARRAY_SIZE(kern_modules_control_opt),
-			     LTTNG_MOD_OPTIONAL);
 	return ret;
 }
 
-- 
2.7.0
