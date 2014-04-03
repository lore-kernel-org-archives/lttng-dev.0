From: Jan Glauber <jan.glauber@gmail.com>
Subject: [RFC Patch Tools 3/4] Remove required parameter from
	module parameters
Date: Thu,  3 Apr 2014 12:57:46 +0200
Message-ID: <5a25b2f118fe3069a12e292b380031364f3e9a68.1396521858.git.jan.glauber__45437.8737988465$1396528929$gmane$org@gmail.com>
References: <cover.1396521858.git.jan.glauber@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WVfMn-0007v6-6V
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 06:59:30 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so1630354wgg.33
 for <lttng-dev@lists.lttng.org>; Thu, 03 Apr 2014 03:59:23 -0700 (PDT)
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

Remove the per module required parameter by adding another list
for optional core modules, so we have:

- required core modules
- optional core modules
- optional probe modules

Signed-off-by: Jan Glauber <jan.glauber@gmail.com>
---
 src/bin/lttng-sessiond/kern-modules.h |    1 -
 src/bin/lttng-sessiond/modprobe.c     |  167 ++++++++++++++++++---------------
 2 files changed, 92 insertions(+), 76 deletions(-)

diff --git a/src/bin/lttng-sessiond/kern-modules.h b/src/bin/lttng-sessiond/kern-modules.h
index 7ce8b0b..ca09fc3 100644
--- a/src/bin/lttng-sessiond/kern-modules.h
+++ b/src/bin/lttng-sessiond/kern-modules.h
@@ -29,7 +29,6 @@
 
 struct kern_modules_param {
 	const char *name;
-	int required;
 };
 
 #endif /* _KERN_MODULES_H */
diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index ea3fb39..79a01ea 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -25,65 +25,72 @@
 #include "modprobe.h"
 #include "kern-modules.h"
 
-/* LTTng kernel tracer base modules list */
-const struct kern_modules_param kern_modules_control[] = {
-	{ "lttng-tracer", 1 },	/* MUST be loaded first so keep at top */
-	{ "lttng-lib-ring-buffer", 1 },
-	{ "lttng-ring-buffer-client-discard", 1 },
-	{ "lttng-ring-buffer-client-overwrite", 1 },
-	{ "lttng-ring-buffer-metadata-client", 1 },
-	{ "lttng-ring-buffer-client-mmap-discard", 1 },
-	{ "lttng-ring-buffer-client-mmap-overwrite", 1 },
-	{ "lttng-ring-buffer-metadata-mmap-client", 1 },
-	{ "lttng-types", 0 },
-	{ "lttng-ftrace", 0 },
-	{ "lttng-kprobes", 0 },
-	{ "lttng-kretprobes", 0 },
+#define LTTNG_MOD_REQUIRED	1
+#define LTTNG_MOD_OPTIONAL	0
+
+/* LTTng kernel tracer mandatory core modules list */
+const struct kern_modules_param kern_modules_control_core[] = {
+	{ "lttng-tracer" },	/* MUST be loaded first so keep at top */
+	{ "lttng-lib-ring-buffer" },
+	{ "lttng-ring-buffer-client-discard" },
+	{ "lttng-ring-buffer-client-overwrite" },
+	{ "lttng-ring-buffer-metadata-client" },
+	{ "lttng-ring-buffer-client-mmap-discard" },
+	{ "lttng-ring-buffer-client-mmap-overwrite" },
+	{ "lttng-ring-buffer-metadata-mmap-client" },
+};
+
+/* LTTng kernel tracer optional base modules list */
+const struct kern_modules_param kern_modules_control_opt[] = {
+	{ "lttng-types" },
+	{ "lttng-ftrace" },
+	{ "lttng-kprobes" },
+	{ "lttng-kretprobes" },
 };
 
 /* LTTng kernel tracer probe modules list */
 const struct kern_modules_param kern_modules_probes[] = {
-	{ "lttng-probe-asoc", 0 },
-	{ "lttng-probe-block", 0 },
-	{ "lttng-probe-btrfs", 0 },
-	{ "lttng-probe-compaction", 0 },
-	{ "lttng-probe-ext3", 0 },
-	{ "lttng-probe-ext4", 0 },
-	{ "lttng-probe-gpio", 0 },
-	{ "lttng-probe-irq", 0 },
-	{ "lttng-probe-jbd", 0 },
-	{ "lttng-probe-jbd2", 0 },
-	{ "lttng-probe-kmem", 0 },
-	{ "lttng-probe-kvm", 0 },
-	{ "lttng-probe-kvm-x86", 0 },
-	{ "lttng-probe-kvm-x86-mmu", 0 },
-	{ "lttng-probe-lock", 0 },
-	{ "lttng-probe-module", 0 },
-	{ "lttng-probe-napi", 0 },
-	{ "lttng-probe-net", 0 },
-	{ "lttng-probe-power", 0 },
-	{ "lttng-probe-printk", 0 },
-	{ "lttng-probe-random", 0 },
-	{ "lttng-probe-rcu", 0 },
-	{ "lttng-probe-regmap", 0 },
-	{ "lttng-probe-regulator", 0 },
-	{ "lttng-probe-rpm", 0 },
-	{ "lttng-probe-sched", 0 },
-	{ "lttng-probe-scsi", 0 },
-	{ "lttng-probe-signal", 0 },
-	{ "lttng-probe-skb", 0 },
-	{ "lttng-probe-sock", 0 },
-	{ "lttng-probe-statedump", 0 },
-	{ "lttng-probe-sunrpc", 0 },
-	{ "lttng-probe-timer", 0 },
-	{ "lttng-probe-udp", 0 },
-	{ "lttng-probe-vmscan", 0 },
-	{ "lttng-probe-workqueue", 0 },
-	{ "lttng-probe-writeback", 0 },
+	{ "lttng-probe-asoc" },
+	{ "lttng-probe-block" },
+	{ "lttng-probe-btrfs" },
+	{ "lttng-probe-compaction" },
+	{ "lttng-probe-ext3" },
+	{ "lttng-probe-ext4" },
+	{ "lttng-probe-gpio" },
+	{ "lttng-probe-irq" },
+	{ "lttng-probe-jbd" },
+	{ "lttng-probe-jbd2" },
+	{ "lttng-probe-kmem" },
+	{ "lttng-probe-kvm" },
+	{ "lttng-probe-kvm-x86" },
+	{ "lttng-probe-kvm-x86-mmu" },
+	{ "lttng-probe-lock" },
+	{ "lttng-probe-module" },
+	{ "lttng-probe-napi" },
+	{ "lttng-probe-net" },
+	{ "lttng-probe-power" },
+	{ "lttng-probe-printk" },
+	{ "lttng-probe-random" },
+	{ "lttng-probe-rcu" },
+	{ "lttng-probe-regmap" },
+	{ "lttng-probe-regulator" },
+	{ "lttng-probe-rpm" },
+	{ "lttng-probe-sched" },
+	{ "lttng-probe-scsi" },
+	{ "lttng-probe-signal" },
+	{ "lttng-probe-skb" },
+	{ "lttng-probe-sock" },
+	{ "lttng-probe-statedump" },
+	{ "lttng-probe-sunrpc" },
+	{ "lttng-probe-timer" },
+	{ "lttng-probe-udp" },
+	{ "lttng-probe-vmscan" },
+	{ "lttng-probe-workqueue" },
+	{ "lttng-probe-writeback" },
 };
 
 void modprobe_remove_lttng(const struct kern_modules_param *modules,
-			   int entries)
+			   int entries, int required)
 {
 	int ret = 0, i;
 	char modprobe[256];
@@ -94,26 +101,21 @@ void modprobe_remove_lttng(const struct kern_modules_param *modules,
 				modules[i].name);
 		if (ret < 0) {
 			PERROR("snprintf modprobe -r");
-			goto error;
+			return;
 		}
 		modprobe[sizeof(modprobe) - 1] = '\0';
 		ret = system(modprobe);
 		if (ret == -1) {
 			ERR("Unable to launch modprobe -r for module %s",
-					kern_modules_control[i].name);
-		} else if (kern_modules_control[i].required
-				&& WEXITSTATUS(ret) != 0) {
+					modules[i].name);
+		} else if (required && WEXITSTATUS(ret) != 0) {
 			ERR("Unable to remove module %s",
-					kern_modules_control[i].name);
+					modules[i].name);
 		} else {
 			DBG("Modprobe removal successful %s",
-					kern_modules_control[i].name);
+					modules[i].name);
 		}
 	}
-
-error:
-	return;
-
 }
 
 /*
@@ -121,8 +123,12 @@ error:
  */
 void modprobe_remove_lttng_control(void)
 {
-	return modprobe_remove_lttng(kern_modules_control,
-				     ARRAY_SIZE(kern_modules_control));
+	modprobe_remove_lttng(kern_modules_control_opt,
+				    ARRAY_SIZE(kern_modules_control_opt),
+				    LTTNG_MOD_OPTIONAL);
+	modprobe_remove_lttng(kern_modules_control_core,
+				     ARRAY_SIZE(kern_modules_control_core),
+				     LTTNG_MOD_REQUIRED);
 }
 
 /*
@@ -131,7 +137,8 @@ void modprobe_remove_lttng_control(void)
 void modprobe_remove_lttng_data(void)
 {
 	return modprobe_remove_lttng(kern_modules_probes,
-				     ARRAY_SIZE(kern_modules_list));
+				     ARRAY_SIZE(kern_modules_probes),
+				     LTTNG_MOD_OPTIONAL);
 }
 
 /*
@@ -143,7 +150,8 @@ void modprobe_remove_lttng_all(void)
 	modprobe_remove_lttng_control();
 }
 
-static int modprobe_lttng(const struct kern_modules_param *modules, int entries)
+static int modprobe_lttng(const struct kern_modules_param *modules,
+			  int entries, int required)
 {
 	int ret = 0, i;
 	char modprobe[256];
@@ -151,7 +159,7 @@ static int modprobe_lttng(const struct kern_modules_param *modules, int entries)
 	for (i = 0; i < entries; i++) {
 		ret = snprintf(modprobe, sizeof(modprobe),
 				"/sbin/modprobe %s%s",
-				modules[i].required ? "" : "-q ",
+				required ? "" : "-q ",
 				modules[i].name);
 		if (ret < 0) {
 			PERROR("snprintf modprobe");
@@ -162,12 +170,10 @@ static int modprobe_lttng(const struct kern_modules_param *modules, int entries)
 		if (ret == -1) {
 			ERR("Unable to launch modprobe for module %s",
 					modules[i].name);
-		} else if (modules[i].required && WEXITSTATUS(ret) != 0) {
-			ERR("Unable to load module %s",
-					modules[i].name);
+		} else if (required && WEXITSTATUS(ret) != 0) {
+			ERR("Unable to load module %s", modules[i].name);
 		} else {
-			DBG("Modprobe successfully %s",
-					modules[i].name);
+			DBG("Modprobe successfully %s", modules[i].name);
 		}
 	}
 
@@ -180,14 +186,25 @@ error:
  */
 int modprobe_lttng_control(void)
 {
-	return modprobe_lttng(kern_modules_control,
-			      ARRAY_SIZE(kern_modules_control));
+	int ret;
+
+	ret = modprobe_lttng(kern_modules_control_core,
+			     ARRAY_SIZE(kern_modules_control_core),
+			     LTTNG_MOD_REQUIRED);
+	if (ret != 0)
+		return ret;
+	ret = modprobe_lttng(kern_modules_control_opt,
+			      ARRAY_SIZE(kern_modules_control_opt),
+			      LTTNG_MOD_OPTIONAL);
+	return ret;
 }
+
 /*
  * Load data kernel module(s).
  */
 int modprobe_lttng_data(void)
 {
 	return modprobe_lttng(kern_modules_probes,
-			      ARRAY_SIZE(kern_modules_probes));
+			      ARRAY_SIZE(kern_modules_probes),
+			      LTTNG_MOD_OPTIONAL);
 }
-- 
1.7.9.5
