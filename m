From: Jan Glauber <jan.glauber@gmail.com>
Subject: [PATCH lttng-tools v3 1/4] Use common functions for
	module loading and unloading
Date: Wed, 14 May 2014 16:26:29 +0200
Message-ID: <7069d95da9b33edd492668b37470168d1fb23c13.1400077421.git.jan.glauber__20459.8494492986$1400077820$gmane$org@gmail.com>
References: <cover.1400077421.git.jan.glauber@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1Wka9o-0001cC-Lj
 for lttng-dev@lists.lttng.org; Wed, 14 May 2014 10:27:50 -0400
Received: by mail-ee0-f42.google.com with SMTP id d49so1460456eek.29
 for <lttng-dev@lists.lttng.org>; Wed, 14 May 2014 07:27:38 -0700 (PDT)
In-Reply-To: <cover.1400077421.git.jan.glauber@gmail.com>
In-Reply-To: <cover.1400077421.git.jan.glauber@gmail.com>
References: <cover.1400077421.git.jan.glauber@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Module loading (and unloading) is identical for control and data modules
so use common funtions to avoid code duplication.

Signed-off-by: Jan Glauber <jan.glauber@gmail.com>
---
 src/bin/lttng-sessiond/modprobe.c |  109 ++++++++++++-------------------------
 1 file changed, 34 insertions(+), 75 deletions(-)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 4ef4d4c..c362954 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -83,18 +83,16 @@ const struct kern_modules_param kern_modules_list[] = {
 	{ "lttng-probe-writeback", 0 },
 };
 
-/*
- * Remove control kernel module(s) in reverse load order.
- */
-void modprobe_remove_lttng_control(void)
+void modprobe_remove_lttng(const struct kern_modules_param *modules,
+			   int entries)
 {
 	int ret = 0, i;
 	char modprobe[256];
 
-	for (i = ARRAY_SIZE(kern_modules_control) - 1; i >= 0; i--) {
+	for (i = entries - 1; i >= 0; i--) {
 		ret = snprintf(modprobe, sizeof(modprobe),
 				"/sbin/modprobe -r -q %s",
-				kern_modules_control[i].name);
+				modules[i].name);
 		if (ret < 0) {
 			PERROR("snprintf modprobe -r");
 			goto error;
@@ -116,6 +114,16 @@ void modprobe_remove_lttng_control(void)
 
 error:
 	return;
+
+}
+
+/*
+ * Remove control kernel module(s) in reverse load order.
+ */
+void modprobe_remove_lttng_control(void)
+{
+	return modprobe_remove_lttng(kern_modules_control,
+				     ARRAY_SIZE(kern_modules_control));
 }
 
 /*
@@ -123,34 +131,8 @@ error:
  */
 void modprobe_remove_lttng_data(void)
 {
-	int ret = 0, i;
-	char modprobe[256];
-
-	for (i = ARRAY_SIZE(kern_modules_list) - 1; i >= 0; i--) {
-		ret = snprintf(modprobe, sizeof(modprobe),
-				"/sbin/modprobe -r -q %s",
-				kern_modules_list[i].name);
-		if (ret < 0) {
-			PERROR("snprintf modprobe -r");
-			goto error;
-		}
-		modprobe[sizeof(modprobe) - 1] = '\0';
-		ret = system(modprobe);
-		if (ret == -1) {
-			ERR("Unable to launch modprobe -r for module %s",
-					kern_modules_list[i].name);
-		} else if (kern_modules_list[i].required
-				&& WEXITSTATUS(ret) != 0) {
-			ERR("Unable to remove module %s",
-					kern_modules_list[i].name);
-		} else {
-			DBG("Modprobe removal successful %s",
-					kern_modules_list[i].name);
-		}
-	}
-
-error:
-	return;
+	return modprobe_remove_lttng(kern_modules_list,
+				     ARRAY_SIZE(kern_modules_list));
 }
 
 /*
@@ -162,19 +144,16 @@ void modprobe_remove_lttng_all(void)
 	modprobe_remove_lttng_control();
 }
 
-/*
- * Load control kernel module(s).
- */
-int modprobe_lttng_control(void)
+static int modprobe_lttng(const struct kern_modules_param *modules, int entries)
 {
 	int ret = 0, i;
 	char modprobe[256];
 
-	for (i = 0; i < ARRAY_SIZE(kern_modules_control); i++) {
+	for (i = 0; i < entries; i++) {
 		ret = snprintf(modprobe, sizeof(modprobe),
 				"/sbin/modprobe %s%s",
-				kern_modules_control[i].required ? "" : "-q ",
-				kern_modules_control[i].name);
+				modules[i].required ? "" : "-q ",
+				modules[i].name);
 		if (ret < 0) {
 			PERROR("snprintf modprobe");
 			goto error;
@@ -183,14 +162,13 @@ int modprobe_lttng_control(void)
 		ret = system(modprobe);
 		if (ret == -1) {
 			ERR("Unable to launch modprobe for module %s",
-					kern_modules_control[i].name);
-		} else if (kern_modules_control[i].required
-				&& WEXITSTATUS(ret) != 0) {
+					modules[i].name);
+		} else if (modules[i].required && WEXITSTATUS(ret) != 0) {
 			ERR("Unable to load module %s",
-					kern_modules_control[i].name);
+					modules[i].name);
 		} else {
 			DBG("Modprobe successfully %s",
-					kern_modules_control[i].name);
+					modules[i].name);
 		}
 	}
 
@@ -199,37 +177,18 @@ error:
 }
 
 /*
+ * Load control kernel module(s).
+ */
+int modprobe_lttng_control(void)
+{
+	return modprobe_lttng(kern_modules_control,
+			      ARRAY_SIZE(kern_modules_control));
+}
+/*
  * Load data kernel module(s).
  */
 int modprobe_lttng_data(void)
 {
-	int ret = 0, i;
-	char modprobe[256];
-
-	for (i = 0; i < ARRAY_SIZE(kern_modules_list); i++) {
-		ret = snprintf(modprobe, sizeof(modprobe),
-				"/sbin/modprobe %s%s",
-				kern_modules_list[i].required ? "" : "-q ",
-				kern_modules_list[i].name);
-		if (ret < 0) {
-			PERROR("snprintf modprobe");
-			goto error;
-		}
-		modprobe[sizeof(modprobe) - 1] = '\0';
-		ret = system(modprobe);
-		if (ret == -1) {
-			ERR("Unable to launch modprobe for module %s",
-					kern_modules_list[i].name);
-		} else if (kern_modules_list[i].required
-				&& WEXITSTATUS(ret) != 0) {
-			ERR("Unable to load module %s",
-					kern_modules_list[i].name);
-		} else {
-			DBG("Modprobe successfully %s",
-					kern_modules_list[i].name);
-		}
-	}
-
-error:
-	return ret;
+	return modprobe_lttng(kern_modules_list,
+			      ARRAY_SIZE(kern_modules_list));
 }
-- 
1.7.9.5
