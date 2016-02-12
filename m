From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-tools 2/5] Move libkmod ifdef to
	beginning of file
Date: Fri, 12 Feb 2016 16:31:45 -0500
Message-ID: <1455312708-462-2-git-send-email-mjeanson__4508.12313142723$1455312802$gmane$org@efficios.com>
References: <1455312708-462-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aULK1-00041n-Tn
 for lttng-dev@lists.lttng.org; Fri, 12 Feb 2016 16:32:16 -0500
In-Reply-To: <1455312708-462-1-git-send-email-mjeanson@efficios.com>
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

This will be useful to add the libkmod implementation of the
modprobe_remove_lttng() function in a single ifdef.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/bin/lttng-sessiond/modprobe.c | 150 +++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 75 deletions(-)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 81ce810..6f9a997 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -90,81 +90,6 @@ static struct kern_modules_param *probes;
 static int nr_probes;
 static int probes_capacity;
 
-static void modprobe_remove_lttng(const struct kern_modules_param *modules,
-		int entries, int required)
-{
-	int ret = 0, i;
-	char modprobe[256];
-
-	for (i = entries - 1; i >= 0; i--) {
-		ret = snprintf(modprobe, sizeof(modprobe),
-				"/sbin/modprobe -r -q %s",
-				modules[i].name);
-		if (ret < 0) {
-			PERROR("snprintf modprobe -r");
-			return;
-		}
-		modprobe[sizeof(modprobe) - 1] = '\0';
-		ret = system(modprobe);
-		if (ret == -1) {
-			ERR("Unable to launch modprobe -r for module %s",
-					modules[i].name);
-		} else if (required && WEXITSTATUS(ret) != 0) {
-			ERR("Unable to remove module %s",
-					modules[i].name);
-		} else {
-			DBG("Modprobe removal successful %s",
-					modules[i].name);
-		}
-	}
-}
-
-/*
- * Remove control kernel module(s) in reverse load order.
- */
-void modprobe_remove_lttng_control(void)
-{
-	modprobe_remove_lttng(kern_modules_control_core,
-			      ARRAY_SIZE(kern_modules_control_core),
-			      LTTNG_MOD_REQUIRED);
-}
-
-static void free_probes(void)
-{
-	int i;
-
-	if (!probes) {
-		return;
-	}
-	for (i = 0; i < nr_probes; ++i) {
-		free(probes[i].name);
-	}
-	free(probes);
-	probes = NULL;
-	nr_probes = 0;
-}
-
-/*
- * Remove data kernel modules in reverse load order.
- */
-void modprobe_remove_lttng_data(void)
-{
-	if (!probes) {
-		return;
-	}
-	modprobe_remove_lttng(probes, nr_probes, LTTNG_MOD_OPTIONAL);
-	free_probes();
-}
-
-/*
- * Remove all kernel modules in reverse order.
- */
-void modprobe_remove_lttng_all(void)
-{
-	modprobe_remove_lttng_data();
-	modprobe_remove_lttng_control();
-}
-
 #if HAVE_KMOD
 #include <libkmod.h>
 static void log_kmod(void *data, int priority, const char *file, int line,
@@ -280,6 +205,81 @@ error:
 
 #endif /* HAVE_KMOD */
 
+static void modprobe_remove_lttng(const struct kern_modules_param *modules,
+		int entries, int required)
+{
+	int ret = 0, i;
+	char modprobe[256];
+
+	for (i = entries - 1; i >= 0; i--) {
+		ret = snprintf(modprobe, sizeof(modprobe),
+				"/sbin/modprobe -r -q %s",
+				modules[i].name);
+		if (ret < 0) {
+			PERROR("snprintf modprobe -r");
+			return;
+		}
+		modprobe[sizeof(modprobe) - 1] = '\0';
+		ret = system(modprobe);
+		if (ret == -1) {
+			ERR("Unable to launch modprobe -r for module %s",
+					modules[i].name);
+		} else if (required && WEXITSTATUS(ret) != 0) {
+			ERR("Unable to remove module %s",
+					modules[i].name);
+		} else {
+			DBG("Modprobe removal successful %s",
+					modules[i].name);
+		}
+	}
+}
+
+/*
+ * Remove control kernel module(s) in reverse load order.
+ */
+void modprobe_remove_lttng_control(void)
+{
+	modprobe_remove_lttng(kern_modules_control_core,
+			      ARRAY_SIZE(kern_modules_control_core),
+			      LTTNG_MOD_REQUIRED);
+}
+
+static void free_probes(void)
+{
+	int i;
+
+	if (!probes) {
+		return;
+	}
+	for (i = 0; i < nr_probes; ++i) {
+		free(probes[i].name);
+	}
+	free(probes);
+	probes = NULL;
+	nr_probes = 0;
+}
+
+/*
+ * Remove data kernel modules in reverse load order.
+ */
+void modprobe_remove_lttng_data(void)
+{
+	if (!probes) {
+		return;
+	}
+	modprobe_remove_lttng(probes, nr_probes, LTTNG_MOD_OPTIONAL);
+	free_probes();
+}
+
+/*
+ * Remove all kernel modules in reverse order.
+ */
+void modprobe_remove_lttng_all(void)
+{
+	modprobe_remove_lttng_data();
+	modprobe_remove_lttng_control();
+}
+
 /*
  * Load control kernel module(s).
  */
-- 
2.7.0
