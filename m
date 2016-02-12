From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-tools 3/5] Add libkmod rmmod support
Date: Fri, 12 Feb 2016 16:31:46 -0500
Message-ID: <1455312708-462-3-git-send-email-mjeanson__29109.259582083$1455312822$gmane$org@efficios.com>
References: <1455312708-462-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aULK4-00041x-Lm
 for lttng-dev@lists.lttng.org; Fri, 12 Feb 2016 16:32:17 -0500
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

We previously had support to load modules with libkmod but we always
unload modules by calling the modprobe binary.

This patch adds the libkmod module unloading which is faster and gives
us better error handling. This implementation also graciously handles
builtin lttng kernel modules.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/bin/lttng-sessiond/modprobe.c | 104 ++++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 9 deletions(-)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 6f9a997..90fec71 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -92,6 +92,7 @@ static int probes_capacity;
 
 #if HAVE_KMOD
 #include <libkmod.h>
+
 static void log_kmod(void *data, int priority, const char *file, int line,
 		const char *fn, const char *format, va_list args)
 {
@@ -104,21 +105,39 @@ static void log_kmod(void *data, int priority, const char *file, int line,
 	DBG("libkmod: %s", str);
 	free(str);
 }
-static int modprobe_lttng(struct kern_modules_param *modules,
-		int entries, int required)
+
+static int setup_kmod_ctx(struct kmod_ctx **ctx)
 {
-	int ret = 0, i;
-	struct kmod_ctx *ctx;
+	int ret = 0;
 
-	ctx = kmod_new(NULL, NULL);
+	*ctx = kmod_new(NULL, NULL);
 	if (!ctx) {
 		PERROR("Unable to create kmod library context");
 		ret = -ENOMEM;
 		goto error;
 	}
 
-	kmod_set_log_fn(ctx, log_kmod, NULL);
-	kmod_load_resources(ctx);
+	kmod_set_log_fn(*ctx, log_kmod, NULL);
+	ret = kmod_load_resources(*ctx);
+	if (ret < 0) {
+		ERR("Failed to load kmod library resources");
+		goto error;
+	}
+
+error:
+	return ret;
+}
+
+static int modprobe_lttng(struct kern_modules_param *modules,
+		int entries, int required)
+{
+	int ret = 0, i;
+	struct kmod_ctx *ctx;
+
+	ret = setup_kmod_ctx(&ctx);
+	if (ret < 0) {
+		goto error;
+	}
 
 	for (i = 0; i < entries; i++) {
 		struct kmod_module *mod = NULL;
@@ -155,6 +174,73 @@ error:
 	return ret;
 }
 
+static int rmmod_recurse(struct kmod_module *mod) {
+	int ret = 0;
+	struct kmod_list *deps, *itr;
+
+	if (kmod_module_get_initstate(mod) == KMOD_MODULE_BUILTIN) {
+		DBG("Module %s is builtin", kmod_module_get_name(mod));
+		return ret;
+	}
+
+	ret = kmod_module_remove_module(mod, 0);
+
+	deps = kmod_module_get_dependencies(mod);
+	if (deps != NULL) {
+		kmod_list_foreach(itr, deps) {
+			struct kmod_module *dep = kmod_module_get_module(itr);
+			if (kmod_module_get_refcnt(dep) == 0) {
+				DBG("Recursive remove module %s",
+						kmod_module_get_name(dep));
+				rmmod_recurse(dep);
+			}
+			kmod_module_unref(dep);
+		}
+		kmod_module_unref_list(deps);
+	}
+
+	return ret;
+}
+
+static void modprobe_remove_lttng(const struct kern_modules_param *modules,
+		int entries, int required)
+{
+	int ret = 0, i;
+	struct kmod_ctx *ctx;
+
+	ret = setup_kmod_ctx(&ctx);
+	if (ret < 0) {
+		goto error;
+	}
+
+	for (i = entries - 1; i >= 0; i--) {
+		struct kmod_module *mod = NULL;
+
+		ret = kmod_module_new_from_name(ctx, modules[i].name, &mod);
+		if (ret < 0) {
+			PERROR("Failed to create kmod module for %s", modules[i].name);
+			goto error;
+		}
+
+		ret = rmmod_recurse(mod);
+		if (ret == -EEXIST) {
+			DBG("Module %s is not in kernel.", modules[i].name);
+		} else if (required && ret < 0) {
+			ERR("Unable to remove module %s", modules[i].name);
+		} else {
+			DBG("Modprobe removal successful %s",
+				modules[i].name);
+		}
+
+		kmod_module_unref(mod);
+	}
+
+error:
+	if (ctx) {
+		kmod_unref(ctx);
+	}
+}
+
 #else /* HAVE_KMOD */
 
 static int modprobe_lttng(struct kern_modules_param *modules,
@@ -203,8 +289,6 @@ error:
 	return ret;
 }
 
-#endif /* HAVE_KMOD */
-
 static void modprobe_remove_lttng(const struct kern_modules_param *modules,
 		int entries, int required)
 {
@@ -234,6 +318,8 @@ static void modprobe_remove_lttng(const struct kern_modules_param *modules,
 	}
 }
 
+#endif /* HAVE_KMOD */
+
 /*
  * Remove control kernel module(s) in reverse load order.
  */
-- 
2.7.0
