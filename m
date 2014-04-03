From: Jan Glauber <jan.glauber@gmail.com>
Subject: [RFC Patch Tools 4/4] Dynamic probe list support
Date: Thu,  3 Apr 2014 12:57:47 +0200
Message-ID: <de183aafcb318b7088e7dd0d1780feae58f1e03a.1396521858.git.jan.glauber__9990.65490109405$1396530013$gmane$org@gmail.com>
References: <cover.1396521858.git.jan.glauber@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WVfMq-0007vK-30
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 06:59:33 -0400
Received: by mail-wi0-f180.google.com with SMTP id q5so2243943wiv.7
 for <lttng-dev@lists.lttng.org>; Thu, 03 Apr 2014 03:59:26 -0700 (PDT)
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

Create a dynamic probe list if the LTTNG_PROBE_LIST environment variable
is set and use it to load these probes. If the environment variable is
not set all probes are loaded so the default behaviour is not changed.

Signed-off-by: Jan Glauber <jan.glauber@gmail.com>
---
 src/bin/lttng-sessiond/kern-modules.h |    2 +-
 src/bin/lttng-sessiond/modprobe.c     |   78 ++++++++++++++++++++++++++-------
 src/common/defaults.h                 |    3 ++
 src/common/utils.c                    |   10 +++++
 src/common/utils.h                    |    1 +
 5 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/src/bin/lttng-sessiond/kern-modules.h b/src/bin/lttng-sessiond/kern-modules.h
index ca09fc3..26f4457 100644
--- a/src/bin/lttng-sessiond/kern-modules.h
+++ b/src/bin/lttng-sessiond/kern-modules.h
@@ -28,7 +28,7 @@
 #define KERN_MODULES_MINOR         0
 
 struct kern_modules_param {
-	const char *name;
+	char *name;
 };
 
 #endif /* _KERN_MODULES_H */
diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 79a01ea..75e33e4 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -21,6 +21,7 @@
 #include <sys/wait.h>
 
 #include <common/common.h>
+#include <common/utils.h>
 
 #include "modprobe.h"
 #include "kern-modules.h"
@@ -29,7 +30,7 @@
 #define LTTNG_MOD_OPTIONAL	0
 
 /* LTTng kernel tracer mandatory core modules list */
-const struct kern_modules_param kern_modules_control_core[] = {
+struct kern_modules_param kern_modules_control_core[] = {
 	{ "lttng-tracer" },	/* MUST be loaded first so keep at top */
 	{ "lttng-lib-ring-buffer" },
 	{ "lttng-ring-buffer-client-discard" },
@@ -41,7 +42,7 @@ const struct kern_modules_param kern_modules_control_core[] = {
 };
 
 /* LTTng kernel tracer optional base modules list */
-const struct kern_modules_param kern_modules_control_opt[] = {
+struct kern_modules_param kern_modules_control_opt[] = {
 	{ "lttng-types" },
 	{ "lttng-ftrace" },
 	{ "lttng-kprobes" },
@@ -49,7 +50,7 @@ const struct kern_modules_param kern_modules_control_opt[] = {
 };
 
 /* LTTng kernel tracer probe modules list */
-const struct kern_modules_param kern_modules_probes[] = {
+struct kern_modules_param kern_modules_probes_default[] = {
 	{ "lttng-probe-asoc" },
 	{ "lttng-probe-block" },
 	{ "lttng-probe-btrfs" },
@@ -89,6 +90,10 @@ const struct kern_modules_param kern_modules_probes[] = {
 	{ "lttng-probe-writeback" },
 };
 
+/* dynamic probe modules list */
+static struct kern_modules_param *probes;
+static int nr_probes;
+
 void modprobe_remove_lttng(const struct kern_modules_param *modules,
 			   int entries, int required)
 {
@@ -115,6 +120,8 @@ void modprobe_remove_lttng(const struct kern_modules_param *modules,
 			DBG("Modprobe removal successful %s",
 					modules[i].name);
 		}
+		if (probes)
+			free(probes[i].name);
 	}
 }
 
@@ -124,11 +131,11 @@ void modprobe_remove_lttng(const struct kern_modules_param *modules,
 void modprobe_remove_lttng_control(void)
 {
 	modprobe_remove_lttng(kern_modules_control_opt,
-				    ARRAY_SIZE(kern_modules_control_opt),
-				    LTTNG_MOD_OPTIONAL);
+			      ARRAY_SIZE(kern_modules_control_opt),
+			      LTTNG_MOD_OPTIONAL);
 	modprobe_remove_lttng(kern_modules_control_core,
-				     ARRAY_SIZE(kern_modules_control_core),
-				     LTTNG_MOD_REQUIRED);
+			      ARRAY_SIZE(kern_modules_control_core),
+			      LTTNG_MOD_REQUIRED);
 }
 
 /*
@@ -136,9 +143,14 @@ void modprobe_remove_lttng_control(void)
  */
 void modprobe_remove_lttng_data(void)
 {
-	return modprobe_remove_lttng(kern_modules_probes,
-				     ARRAY_SIZE(kern_modules_probes),
-				     LTTNG_MOD_OPTIONAL);
+	if (probes) {
+		modprobe_remove_lttng(probes, nr_probes, LTTNG_MOD_OPTIONAL);
+		free(probes);
+		probes = NULL;
+	} else
+		modprobe_remove_lttng(kern_modules_probes_default,
+				      ARRAY_SIZE(kern_modules_probes_default),
+				      LTTNG_MOD_OPTIONAL);
 }
 
 /*
@@ -150,7 +162,7 @@ void modprobe_remove_lttng_all(void)
 	modprobe_remove_lttng_control();
 }
 
-static int modprobe_lttng(const struct kern_modules_param *modules,
+static int modprobe_lttng(struct kern_modules_param *modules,
 			  int entries, int required)
 {
 	int ret = 0, i;
@@ -194,8 +206,8 @@ int modprobe_lttng_control(void)
 	if (ret != 0)
 		return ret;
 	ret = modprobe_lttng(kern_modules_control_opt,
-			      ARRAY_SIZE(kern_modules_control_opt),
-			      LTTNG_MOD_OPTIONAL);
+			     ARRAY_SIZE(kern_modules_control_opt),
+			     LTTNG_MOD_OPTIONAL);
 	return ret;
 }
 
@@ -204,7 +216,41 @@ int modprobe_lttng_control(void)
  */
 int modprobe_lttng_data(void)
 {
-	return modprobe_lttng(kern_modules_probes,
-			      ARRAY_SIZE(kern_modules_probes),
-			      LTTNG_MOD_OPTIONAL);
+	int entries = ARRAY_SIZE(kern_modules_probes_default);
+	char *list = utils_get_probe_list();
+	char *next;
+	int i;
+
+	/* the default is to load ALL probes */
+	if (!list)
+		return modprobe_lttng(kern_modules_probes_default, entries,
+				      LTTNG_MOD_OPTIONAL);
+
+	/*
+	 * A probe list is available, so use it.
+	 * The number of probes is limited by the number of probes in the
+	 * default list.
+	 */
+	probes = malloc(sizeof(struct kern_modules_param *) * entries);
+	if (!probes) {
+		PERROR("malloc probe list");
+		return -ENOMEM;
+	}
+	for (i = 0; i < entries; i++) {
+		next = strtok(list, ":");
+		if (!next)
+			goto out;
+		list = NULL;
+
+		/* length 13 is "lttng-probe-" + \0 */
+		probes[i].name = malloc(strlen(next) + 13);
+		if (!probes[i].name) {
+			PERROR("malloc probe list");
+			return -ENOMEM;
+		}
+		sprintf(probes[i].name, "lttng-probe-%s", next);
+	}
+out:
+	nr_probes = i;
+	return modprobe_lttng(probes, nr_probes, LTTNG_MOD_OPTIONAL);
 }
diff --git a/src/common/defaults.h b/src/common/defaults.h
index 7acabf1..6892efd 100644
--- a/src/common/defaults.h
+++ b/src/common/defaults.h
@@ -90,6 +90,9 @@
 #define DEFAULT_LTTNG_SESSIOND_PIDFILE          "lttng-sessiond.pid"
 #define DEFAULT_LTTNG_SESSIOND_JULPORT_FILE     "jul.port"
 
+/* Default probe list */
+#define DEFAULT_LTTNG_PROBE_LIST		"LTTNG_PROBE_LIST"
+
 /* Default unix socket path */
 #define DEFAULT_GLOBAL_CLIENT_UNIX_SOCK         DEFAULT_LTTNG_RUNDIR "/client-lttng-sessiond"
 #define DEFAULT_HOME_CLIENT_UNIX_SOCK           DEFAULT_LTTNG_HOME_RUNDIR "/client-lttng-sessiond"
diff --git a/src/common/utils.c b/src/common/utils.c
index 31596dd..12edd2c 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -896,6 +896,16 @@ end:
 }
 
 /*
+ * Obtain the value of LTTNG_PROBE_LIST environment variable, if exists.
+ * Otherwise returns an empty string.
+ */
+LTTNG_HIDDEN
+char *utils_get_probe_list(void)
+{
+	return getenv(DEFAULT_LTTNG_PROBE_LIST);
+}
+
+/*
  * With the given format, fill dst with the time of len maximum siz.
  *
  * Return amount of bytes set in the buffer or else 0 on error.
diff --git a/src/common/utils.h b/src/common/utils.h
index 63290a7..4f61575 100644
--- a/src/common/utils.h
+++ b/src/common/utils.h
@@ -47,6 +47,7 @@ int utils_parse_size_suffix(char *str, uint64_t *size);
 int utils_get_count_order_u32(uint32_t x);
 char *utils_get_home_dir(void);
 char *utils_get_user_home_dir(uid_t uid);
+char *utils_get_probe_list(void);
 size_t utils_get_current_time_str(const char *format, char *dst, size_t len);
 gid_t utils_get_group_id(const char *name);
 char *utils_generate_optstring(const struct option *long_options,
-- 
1.7.9.5
