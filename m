From: Jan Glauber <jan.glauber@gmail.com>
Subject: [PATCH lttng-tools v2] Dynamic probe list support
Date: Thu, 8 May 2014 13:21:12 +0200
Message-ID: <20140508112111.GA23257__5404.63173897496$1399548168$gmane$org@hal>
References: <cover.1396521858.git.jan.glauber@gmail.com>
 <de183aafcb318b7088e7dd0d1780feae58f1e03a.1396521858.git.jan.glauber@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WiMOe-00052X-BI
 for lttng-dev@lists.lttng.org; Thu, 08 May 2014 07:21:54 -0400
Received: by mail-ee0-f49.google.com with SMTP id e53so1582250eek.22
 for <lttng-dev@lists.lttng.org>; Thu, 08 May 2014 04:21:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <de183aafcb318b7088e7dd0d1780feae58f1e03a.1396521858.git.jan.glauber@gmail.com>
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

Hi David,

I did a respin to add the command line option and the man
page description. If you still want the config file support please
answer my previous questions.

V2 Changes:
- add command line option --kmod-probes to lttng-sessiond
  Note: The command line option only works if lttng-sessiond is started
  manually because the lttng tool does currently not pass the option
  to the lttng-sessiond.
- document command line option and env variable in man page
- change the env variable delimeter to "," instead of ":" and allow
  spaces in the list
- rename the env variable to LTTNG_KMOD_PROBES

Create a kernel module probes list and use it to load the specified
probes. The probes are selectable by the --kmod-probes command line option
to lttng-sessiond or the LTTNG_KMOD_PROBES environment variable.
If neither is set all probes are loaded so the current behaviour is not
changed.

Signed-off-by: Jan Glauber <jan.glauber@gmail.com>
---
 doc/man/lttng-sessiond.8              |    7 +++
 src/bin/lttng-sessiond/kern-modules.h |    2 +-
 src/bin/lttng-sessiond/main.c         |    5 ++
 src/bin/lttng-sessiond/modprobe.c     |   87 +++++++++++++++++++++++++++------
 src/bin/lttng-sessiond/modprobe.h     |    2 +
 src/common/defaults.h                 |    3 ++
 src/common/utils.c                    |   10 ++++
 src/common/utils.h                    |    1 +
 8 files changed, 102 insertions(+), 15 deletions(-)

diff --git a/doc/man/lttng-sessiond.8 b/doc/man/lttng-sessiond.8
index 633cf81..133c69f 100644
--- a/doc/man/lttng-sessiond.8
+++ b/doc/man/lttng-sessiond.8
@@ -81,6 +81,11 @@ No kernel tracer support
 .BR "    --jul-tcp-port"
 JUL application registration TCP port (default: 5345)
 .TP
+.BR "    --kmod-probes=probe1, probe2, ..."
+Specify the kernel modules containing LTTng probes to load by the session daemon.
+Only the component name of the probe needs to be specified, e.g. to load the
+lttng-probe-irq and lttng-probe-sched use: --kmod-probes="irq, sched".
+.TP
 .BR "-c, --client-sock=PATH"
 Specify path for the client unix socket
 .TP
@@ -150,6 +155,8 @@ parameter: the timeout value, in milliseconds. A value of 0 or -1 uses
 the timeout of the operating system (this is the default).
 .IP "LTTNG_SESSION_CONFIG_XSD_PATH"
 Specify the path that contains the XML session configuration schema (xsd).
+.IP "LTTNG_KMOD_PROBES"
+Specify the kernel modules probes that should be loaded by the session daemon.
 .SH "SEE ALSO"
 
 .PP
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
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 052e32e..c90cfe1 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -152,6 +152,7 @@ static const struct option long_options[] = {
 	{ "pidfile", 1, 0, 'p' },
 	{ "jul-tcp-port", 1, 0, 'J' },
 	{ "config", 1, 0, 'f' },
+	{ "kmod-probes", 1, 0, 'P' },
 	{ NULL, 0, 0, 0 }
 };
 
@@ -4110,6 +4111,7 @@ static void usage(void)
 	fprintf(stderr, "      --no-kernel                    Disable kernel tracer\n");
 	fprintf(stderr, "      --jul-tcp-port                 JUL application registration TCP port\n");
 	fprintf(stderr, "  -f  --config                       Load daemon configuration file\n");
+	fprintf(stderr, "      --kmod-probes                  Specify kernel module probes to load\n");
 }
 
 /*
@@ -4229,6 +4231,9 @@ static int set_option(int opt, const char *arg, const char *optname)
 		DBG3("JUL TCP port set to non default: %u", jul_tcp_port);
 		break;
 	}
+	case 'P': /* probe modules list */
+		kmod_probes_list = strdup(arg);
+		break;
 	default:
 		/* Unknown option or other error.
 		 * Error is printed by getopt, just return */
diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 4648e8b..7d3c34f 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -21,6 +21,7 @@
 #include <sys/wait.h>
 
 #include <common/common.h>
+#include <common/utils.h>
 
 #include "modprobe.h"
 #include "kern-modules.h"
@@ -49,7 +50,7 @@ const struct kern_modules_param kern_modules_control_opt[] = {
 };
 
 /* LTTng kernel tracer probe modules list */
-const struct kern_modules_param kern_modules_probes[] = {
+struct kern_modules_param kern_modules_probes_default[] = {
 	{ "lttng-probe-asoc" },
 	{ "lttng-probe-block" },
 	{ "lttng-probe-btrfs" },
@@ -90,6 +91,10 @@ const struct kern_modules_param kern_modules_probes[] = {
 	{ "lttng-probe-writeback" },
 };
 
+/* dynamic probe modules list */
+static struct kern_modules_param *probes;
+static int nr_probes;
+
 void modprobe_remove_lttng(const struct kern_modules_param *modules,
 			   int entries, int required)
 {
@@ -116,6 +121,8 @@ void modprobe_remove_lttng(const struct kern_modules_param *modules,
 			DBG("Modprobe removal successful %s",
 					modules[i].name);
 		}
+		if (probes)
+			free(probes[i].name);
 	}
 }
 
@@ -125,11 +132,11 @@ void modprobe_remove_lttng(const struct kern_modules_param *modules,
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
@@ -137,9 +144,14 @@ void modprobe_remove_lttng_control(void)
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
@@ -151,7 +163,7 @@ void modprobe_remove_lttng_all(void)
 	modprobe_remove_lttng_control();
 }
 
-static int modprobe_lttng(const struct kern_modules_param *modules,
+static int modprobe_lttng(struct kern_modules_param *modules,
 			  int entries, int required)
 {
 	int ret = 0, i;
@@ -195,8 +207,8 @@ int modprobe_lttng_control(void)
 	if (ret != 0)
 		return ret;
 	ret = modprobe_lttng(kern_modules_control_opt,
-			      ARRAY_SIZE(kern_modules_control_opt),
-			      LTTNG_MOD_OPTIONAL);
+			     ARRAY_SIZE(kern_modules_control_opt),
+			     LTTNG_MOD_OPTIONAL);
 	return ret;
 }
 
@@ -205,7 +217,54 @@ int modprobe_lttng_control(void)
  */
 int modprobe_lttng_data(void)
 {
-	return modprobe_lttng(kern_modules_probes,
-			      ARRAY_SIZE(kern_modules_probes),
-			      LTTNG_MOD_OPTIONAL);
+	int entries = ARRAY_SIZE(kern_modules_probes_default);
+	char *list, *next;
+	int i;
+
+	/*
+	 * First take command line option,
+	 * if not available take environment variable.
+	 * No idea how the config file option could be provided.
+	 */
+	if (kmod_probes_list)
+		list= kmod_probes_list;
+	else
+		list = utils_get_kmod_probes_list();
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
+		next = strtok(list, ",");
+		if (!next)
+			goto out;
+		list = NULL;
+
+		/* filter leading spaces */
+		while (*next == ' ')
+			next++;
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
diff --git a/src/bin/lttng-sessiond/modprobe.h b/src/bin/lttng-sessiond/modprobe.h
index 0c6f5f1..42e1912 100644
--- a/src/bin/lttng-sessiond/modprobe.h
+++ b/src/bin/lttng-sessiond/modprobe.h
@@ -24,4 +24,6 @@ void modprobe_remove_lttng_data(void);
 int modprobe_lttng_control(void);
 int modprobe_lttng_data(void);
 
+char *kmod_probes_list;
+
 #endif /* _MODPROBE_H */
diff --git a/src/common/defaults.h b/src/common/defaults.h
index de61064..b49bf4b 100644
--- a/src/common/defaults.h
+++ b/src/common/defaults.h
@@ -90,6 +90,9 @@
 #define DEFAULT_LTTNG_SESSIOND_PIDFILE          "lttng-sessiond.pid"
 #define DEFAULT_LTTNG_SESSIOND_JULPORT_FILE     "jul.port"
 
+/* Default probes list */
+#define DEFAULT_LTTNG_KMOD_PROBES		"LTTNG_KMOD_PROBES"
+
 /* Default unix socket path */
 #define DEFAULT_GLOBAL_CLIENT_UNIX_SOCK         DEFAULT_LTTNG_RUNDIR "/client-lttng-sessiond"
 #define DEFAULT_HOME_CLIENT_UNIX_SOCK           DEFAULT_LTTNG_HOME_RUNDIR "/client-lttng-sessiond"
diff --git a/src/common/utils.c b/src/common/utils.c
index 815965b..78f858c 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -870,6 +870,16 @@ end:
 }
 
 /*
+ * Obtain the value of LTTNG_KMOD_PROBES environment variable, if exists.
+ * Otherwise returns an empty string.
+ */
+LTTNG_HIDDEN
+char *utils_get_kmod_probes_list(void)
+{
+	return getenv(DEFAULT_LTTNG_KMOD_PROBES);
+}
+
+/*
  * With the given format, fill dst with the time of len maximum siz.
  *
  * Return amount of bytes set in the buffer or else 0 on error.
diff --git a/src/common/utils.h b/src/common/utils.h
index b872b53..cc80a53 100644
--- a/src/common/utils.h
+++ b/src/common/utils.h
@@ -47,6 +47,7 @@ int utils_parse_size_suffix(char const * const str, uint64_t * const size);
 int utils_get_count_order_u32(uint32_t x);
 char *utils_get_home_dir(void);
 char *utils_get_user_home_dir(uid_t uid);
+char *utils_get_kmod_probes_list(void);
 size_t utils_get_current_time_str(const char *format, char *dst, size_t len);
 gid_t utils_get_group_id(const char *name);
 char *utils_generate_optstring(const struct option *long_options,
-- 
1.7.9.5
