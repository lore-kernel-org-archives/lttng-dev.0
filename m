From: Umut Tezduyar Lindskog <umut.tezduyar@axis.com>
Subject: [PATCH lttng-tools] Load modules through kmod
Date: Tue, 26 Aug 2014 16:27:46 +0200
Message-ID: <1409063266-28706-1-git-send-email-umut.tezduyar__12363.3569259711$1409063339$gmane$org@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bastet.se.axis.com ([195.60.68.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <umut.tezduyar@axis.com>) id 1XMHj2-0000aJ-Ou
 for lttng-dev@lists.lttng.org; Tue, 26 Aug 2014 10:28:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 3F540180AD
 for <lttng-dev@lists.lttng.org>; Tue, 26 Aug 2014 16:27:51 +0200 (CEST)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 8u+Kk3M7Ue6v for <lttng-dev@lists.lttng.org>;
 Tue, 26 Aug 2014 16:27:51 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id 225D11807D
 for <lttng-dev@lists.lttng.org>; Tue, 26 Aug 2014 16:27:51 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 0B905CEC
 for <lttng-dev@lists.lttng.org>; Tue, 26 Aug 2014 16:27:51 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id 0046A3EB
 for <lttng-dev@lists.lttng.org>; Tue, 26 Aug 2014 16:27:51 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by thoth.se.axis.com (Postfix) with ESMTP id F204E34005
 for <lttng-dev@lists.lttng.org>; Tue, 26 Aug 2014 16:27:50 +0200 (CEST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Umut Tezduyar Lindskog <umuttl@axis.com>
List-Id: lttng-dev@lists.lttng.org

Instead of forking processes, load modules through libkmod.

This adds a package dependency to kmod but can be disabled
by --disable-kmod option in ./configure.

The startup time has decreased by %36 on our embedded mips
product. The measurement is done by cgroup cpu shares.
---
 configure.ac                      |   34 ++++++++++++++++++++++++
 src/bin/lttng-sessiond/modprobe.c |   53 +++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/configure.ac b/configure.ac
index a8e04f5..b36a95d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -200,6 +200,32 @@ AC_CHECK_DECL([cmm_smp_mb__before_uatomic_or], [],
         [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]]
 )
 
+# Check kmod library
+AC_ARG_WITH(kmod-prefix,
+  AS_HELP_STRING([--with-kmod-prefix=PATH],
+                 [Specify the installation prefix of the kmod library.
+	          Headers must be in PATH/include; libraries in PATH/lib.]),
+		  [
+		    CPPFLAGS="$CPPFLAGS -I${withval}/include"
+		    LDFLAGS="$LDFLAGS -L${withval}/lib64 -L${withval}/lib"
+		  ])
+
+AC_ARG_ENABLE(kmod,
+	AS_HELP_STRING([--disable-kmod],[build without kmod support]),
+	kmod_support=$enableval, kmod_support=yes)
+
+AS_IF([test "x$kmod_support" = "xyes"], [
+	AC_CHECK_LIB([kmod], [kmod_module_probe_insert_module],
+		[
+			AC_DEFINE([HAVE_KMOD], [1], [has kmod support])
+			LIBS="$LIBS -lkmod"
+			kmod_found=yes
+		],
+		[AC_MSG_ERROR([Cannot find kmod >= 5. Use --with-kmod-prefix=PREFIX to specify its location, or specify --disable-kmod to build lttng-tools without kmod support.])]
+	)
+])
+AM_CONDITIONAL([HAVE_KMOD], [test "x$kmod_found" = xyes])
+
 AC_ARG_WITH(lttng-ust-prefix,
   AS_HELP_STRING([--with-lttng-ust-prefix=PATH],
                  [Specify the installation prefix of the lttng-ust library.
@@ -483,6 +509,14 @@ done
 AS_ECHO_N("Target architecture: ")
 AS_ECHO($target_arch)
 
+# kmod enabled/disabled
+AS_ECHO_N("kmod support: ")
+AS_IF([test "x$kmod_support" = "xyes"],[
+	AS_ECHO("Enabled")
+],[
+	AS_ECHO("Disabled")
+])
+
 # LTTng-UST enabled/disabled
 AS_ECHO_N("Lttng-UST support: ")
 AS_IF([test "x$lttng_ust_support" = "xyes"],[
diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 3cc67f0..40a2ee0 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -164,6 +164,58 @@ void modprobe_remove_lttng_all(void)
 	modprobe_remove_lttng_control();
 }
 
+#if HAVE_KMOD
+#include <libkmod.h>
+static void log_kmod(void *data, int priority, const char *file, int line,
+		     const char *fn, const char *format, va_list args)
+{
+	char *str;
+	if (vasprintf(&str, format, args) < 0)
+		return;
+	DBG("libkmod: %s", str);
+	free(str);
+}
+static int modprobe_lttng(struct kern_modules_param *modules,
+			  int entries, int required)
+{
+	int ret = 0, i;
+	struct kmod_ctx *ctx;
+
+	ctx = kmod_new(NULL, NULL);
+	if (!ctx) {
+		PERROR("Unable to create kmod library context");
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	kmod_set_log_fn(ctx, log_kmod, NULL);
+	kmod_load_resources(ctx);
+
+	for (i = 0; i < entries; i++) {
+		struct kmod_module *mod = NULL;
+
+		ret = kmod_module_new_from_name(ctx, modules[i].name, &mod);
+		if (ret < 0) {
+			PERROR("Failed to create kmod module for %s", modules[i].name);
+			goto error;
+		}
+
+		ret = kmod_module_probe_insert_module(mod, KMOD_PROBE_IGNORE_LOADED, NULL, NULL, NULL, NULL);
+		if (required && ret < 0) {
+			ERR("Unable to load module %s", modules[i].name);
+		} else {
+			DBG("Modprobe successfully %s", modules[i].name);
+		}
+
+		kmod_module_unref(mod);
+	}
+
+error:
+	if (ctx)
+		kmod_unref(ctx);
+	return ret;
+}
+#else
 static int modprobe_lttng(struct kern_modules_param *modules,
 			  int entries, int required)
 {
@@ -194,6 +246,7 @@ static int modprobe_lttng(struct kern_modules_param *modules,
 error:
 	return ret;
 }
+#endif
 
 /*
  * Load control kernel module(s).
-- 
1.7.10.4
