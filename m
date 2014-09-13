From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [PATCH lttng-tools] sessiond: add --extra-kmod-probes
	option
Date: Fri, 12 Sep 2014 21:37:18 -0400
Message-ID: <1410572238-5924-1-git-send-email-eeppeliteloop__580.849362495606$1410572283$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1XScH8-00018W-SD
 for lttng-dev@lists.lttng.org; Fri, 12 Sep 2014 21:37:20 -0400
Received: by mail-qa0-f44.google.com with SMTP id w8so1575985qac.31
 for <lttng-dev@lists.lttng.org>; Fri, 12 Sep 2014 18:37:13 -0700 (PDT)
Received: from archeepp.internal.efficios.com ([96.127.217.202])
 by mx.google.com with ESMTPSA id w9sm4328470qad.31.2014.09.12.18.37.11
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 12 Sep 2014 18:37:12 -0700 (PDT)
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

This patch adds the --extra-kmod-probes option to
lttng-sessiond. The LTTNG_EXTRA_KMOD_PROBES environment
variable may also be used.

The option specifies a list of extra probe kernel modules
to be loaded (and unloaded) by lttng-sessiond. The list
is appended to either the default list or to the
user-supplied --kmod-probes list.

This option is especially useful for kernel developers who
need the default LTTng kernel probes plus additional probes
in order to instrument their custom kernel or module. This
becomes easy with --extra-kmod-probes:

    lttng-sessiond --extra-kmod-probes=custom_subsys,other

would load all known and available LTTng kernel probes plus
lttng_probe_custom_subsys and lttng_probe_other.

Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
---
 doc/man/lttng-sessiond.8          |   8 ++
 src/bin/lttng-sessiond/main.c     |  10 ++
 src/bin/lttng-sessiond/modprobe.c | 202 +++++++++++++++++++++++++++++---------
 src/bin/lttng-sessiond/modprobe.h |   1 +
 src/common/defaults.h             |   3 +
 src/common/utils.c                |  12 ++-
 src/common/utils.h                |   1 +
 7 files changed, 192 insertions(+), 45 deletions(-)

diff --git a/doc/man/lttng-sessiond.8 b/doc/man/lttng-sessiond.8
index 212b743..9cd148e 100644
--- a/doc/man/lttng-sessiond.8
+++ b/doc/man/lttng-sessiond.8
@@ -86,6 +86,12 @@ Specify the kernel modules containing LTTng probes to load by the session daemon
 Only the component name of the probe needs to be specified, e.g. to load the
 lttng-probe-irq and lttng-probe-sched use: --kmod-probes="irq, sched".
 .TP
+.BR "    --extra-kmod-probes=probe1, probe2, ..."
+Specify extra kernel modules containing LTTng probes to be loaded by the session
+daemon. The list follows the format of the \fB--kmod-probes\fP option.
+This list is appended to the list provided by \fB--kmod-probes\fP or, if
+\fB--kmod-probes\fP is missing, to the default list of probes.
+.TP
 .BR "-c, --client-sock=PATH"
 Specify path for the client unix socket
 .TP
@@ -175,6 +181,8 @@ the timeout of the operating system (this is the default).
 Specify the path that contains the XML session configuration schema (xsd).
 .IP "LTTNG_KMOD_PROBES"
 Specify the kernel modules probes that should be loaded by the session daemon.
+.IP "LTTNG_EXTRA_KMOD_PROBES"
+Specify extra kernel modules probes that should be loaded by the session daemon.
 .SH "SEE ALSO"
 
 .PP
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index c7fc178..2a97c37 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -157,6 +157,7 @@ static const struct option long_options[] = {
 	{ "config", 1, 0, 'f' },
 	{ "load", 1, 0, 'l' },
 	{ "kmod-probes", 1, 0, 'P' },
+	{ "extra-kmod-probes", 1, 0, 'e' },
 	{ NULL, 0, 0, 0 }
 };
 
@@ -4214,6 +4215,7 @@ static void usage(void)
 	fprintf(stderr, "  -f  --config                       Load daemon configuration file\n");
 	fprintf(stderr, "  -l  --load PATH                    Load session configuration\n");
 	fprintf(stderr, "      --kmod-probes                  Specify kernel module probes to load\n");
+	fprintf(stderr, "      --extra-kmod-probes            Specify extra kernel module probes to load\n");
 }
 
 /*
@@ -4400,6 +4402,14 @@ static int set_option(int opt, const char *arg, const char *optname)
 			ret = -ENOMEM;
 		}
 		break;
+	case 'e':
+		free(kmod_extra_probes_list);
+		kmod_extra_probes_list = strdup(arg);
+		if (!kmod_extra_probes_list) {
+			perror("strdup");
+			ret = -ENOMEM;
+		}
+		break;
 	case 'f':
 		/* This is handled in set_options() thus silent break. */
 		break;
diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index adad7bf..2a0b66a 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -95,6 +95,7 @@ struct kern_modules_param kern_modules_probes_default[] = {
 /* dynamic probe modules list */
 static struct kern_modules_param *probes;
 static int nr_probes;
+static int probes_capacity;
 
 void modprobe_remove_lttng(const struct kern_modules_param *modules,
 			   int entries, int required)
@@ -122,8 +123,6 @@ void modprobe_remove_lttng(const struct kern_modules_param *modules,
 			DBG("Modprobe removal successful %s",
 					modules[i].name);
 		}
-		if (probes)
-			free(probes[i].name);
 	}
 }
 
@@ -145,14 +144,18 @@ void modprobe_remove_lttng_control(void)
  */
 void modprobe_remove_lttng_data(void)
 {
+	int i;
+
 	if (probes) {
 		modprobe_remove_lttng(probes, nr_probes, LTTNG_MOD_OPTIONAL);
+
+		for (i = 0; i < nr_probes; ++i) {
+			free(probes[i].name);
+		}
+
 		free(probes);
 		probes = NULL;
-	} else
-		modprobe_remove_lttng(kern_modules_probes_default,
-				      ARRAY_SIZE(kern_modules_probes_default),
-				      LTTNG_MOD_OPTIONAL);
+	}
 }
 
 /*
@@ -280,72 +283,183 @@ int modprobe_lttng_control(void)
 	return ret;
 }
 
-/*
- * Load data kernel module(s).
+/**
+ * Grow global list of probes (double capacity or set it to 1 if
+ * currently 0 and copy existing data).
  */
-int modprobe_lttng_data(void)
+static int grow_probes(void)
 {
-	int i, ret;
-	int entries = ARRAY_SIZE(kern_modules_probes_default);
-	char *list, *next;
+	int i;
 
-	/*
-	 * First take command line option, if not available take environment
-	 * variable.
-	 */
-	if (kmod_probes_list) {
-		list = kmod_probes_list;
-	} else {
-		list = utils_get_kmod_probes_list();
-	}
-	/* The default is to load ALL probes */
-	if (!list) {
-		return modprobe_lttng(kern_modules_probes_default, entries,
-				LTTNG_MOD_OPTIONAL);
+	/* Initialize capacity to 1 if 0. */
+	if (probes_capacity == 0) {
+		probes = zmalloc(sizeof(*probes));
+
+		if (!probes) {
+			PERROR("malloc probe list");
+			return -ENOMEM;
+		}
+
+		probes_capacity = 1;
+
+		return 0;
 	}
 
-	/*
-	 * A probe list is available, so use it.
-	 * The number of probes is limited by the number of probes in the
-	 * default list.
-	 */
-	probes = zmalloc(sizeof(struct kern_modules_param *) * entries);
-	if (!probes) {
+	/* Double size. */
+	probes_capacity *= 2;
+
+	struct kern_modules_param *tmp_probes =
+		zmalloc(sizeof(*tmp_probes) * probes_capacity);
+
+	if (!tmp_probes) {
 		PERROR("malloc probe list");
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < entries; i++) {
-		size_t name_len;
+	for (i = 0; i < nr_probes; ++i) {
+		/* Move name pointer. */
+		tmp_probes[i].name = probes[i].name;
+	}
+
+	/* Replace probes with larger copy. */
+	free(probes);
+	probes = tmp_probes;
 
-		next = strtok(list, ",");
+	return 0;
+}
+
+/*
+ * Appends a comma-separated list of probes to the global list
+ * of probes.
+ */
+static int append_list_to_probes(const char* list)
+{
+	char *next;
+	int ret;
+	int at = nr_probes;
+
+	char* tmp_list = strdup(list);
+
+	if (!tmp_list) {
+		PERROR("strdup temp list");
+		return -ENOMEM;
+	}
+
+	for (;;) {
+		next = strtok(tmp_list, ",");
 		if (!next) {
-			goto out;
+			break;
 		}
-		list = NULL;
+		tmp_list = NULL;
 
 		/* filter leading spaces */
 		while (*next == ' ') {
 			next++;
 		}
 
+		if (probes_capacity <= nr_probes) {
+			ret = grow_probes();
+
+			if (ret) {
+				return ret;
+			}
+		}
+
 		/* Length 13 is "lttng-probe-" + \0 */
-		name_len = strlen(next) + 13;
+		size_t name_len = strlen(next) + 13;
+
+		struct kern_modules_param *cur = &probes[at];
 
-		probes[i].name = zmalloc(name_len);
-		if (!probes[i].name) {
+		cur->name = zmalloc(name_len);
+		if (!cur->name) {
 			PERROR("malloc probe list");
 			return -ENOMEM;
 		}
 
-		ret = snprintf(probes[i].name, name_len, "lttng-probe-%s", next);
+		ret = snprintf(cur->name, name_len, "lttng-probe-%s", next);
+
 		if (ret < 0) {
 			PERROR("snprintf modprobe name");
-			goto out;
+			return -ENOMEM;
+		}
+
+		at++;
+		nr_probes++;
+	}
+
+	free(tmp_list);
+
+	return 0;
+}
+
+/*
+ * Load data kernel module(s).
+ */
+int modprobe_lttng_data(void)
+{
+	int ret, i;
+	char *list;
+
+	/*
+	 * Base probes: either from command line option, environment
+	 * variable or default list.
+	 */
+	if (kmod_probes_list) {
+		list = kmod_probes_list;
+	} else {
+		list = utils_get_kmod_probes_list();
+	}
+
+	if (list) {
+		/* User-specified probes. */
+		ret = append_list_to_probes(list);
+
+		if (ret) {
+			return ret;
+		}
+	} else {
+		/* Default probes. */
+		int def_len = ARRAY_SIZE(kern_modules_probes_default);
+		probes = zmalloc(sizeof(*probes) * def_len);
+
+		if (!probes) {
+			PERROR("malloc probe list");
+			return -ENOMEM;
+		}
+
+		nr_probes = probes_capacity = def_len;
+
+		for (i = 0; i < def_len; ++i) {
+			char* name = strdup(kern_modules_probes_default[i].name);
+
+			if (!name) {
+				PERROR("strdup probe item");
+				return -ENOMEM;
+			}
+
+			probes[i].name = name;
 		}
 	}
 
-out:
-	nr_probes = i;
+	/*
+	 * Extra modules? Append them to current probes list.
+	 */
+	if (kmod_extra_probes_list) {
+		list = kmod_extra_probes_list;
+	} else {
+		list = utils_get_extra_kmod_probes_list();
+	}
+
+	if (list) {
+		ret = append_list_to_probes(list);
+
+		if (ret) {
+			return ret;
+		}
+	}
+
+	/*
+	 * Load probes modules now.
+	 */
 	return modprobe_lttng(probes, nr_probes, LTTNG_MOD_OPTIONAL);
 }
diff --git a/src/bin/lttng-sessiond/modprobe.h b/src/bin/lttng-sessiond/modprobe.h
index 42e1912..cc44160 100644
--- a/src/bin/lttng-sessiond/modprobe.h
+++ b/src/bin/lttng-sessiond/modprobe.h
@@ -25,5 +25,6 @@ int modprobe_lttng_control(void);
 int modprobe_lttng_data(void);
 
 char *kmod_probes_list;
+char *kmod_extra_probes_list;
 
 #endif /* _MODPROBE_H */
diff --git a/src/common/defaults.h b/src/common/defaults.h
index 88f7fe8..25d7b32 100644
--- a/src/common/defaults.h
+++ b/src/common/defaults.h
@@ -94,6 +94,9 @@
 /* Default probes list */
 #define DEFAULT_LTTNG_KMOD_PROBES		"LTTNG_KMOD_PROBES"
 
+/* Default extra probes list */
+#define DEFAULT_LTTNG_EXTRA_KMOD_PROBES		"LTTNG_EXTRA_KMOD_PROBES"
+
 /* Default unix socket path */
 #define DEFAULT_GLOBAL_CLIENT_UNIX_SOCK         DEFAULT_LTTNG_RUNDIR "/client-lttng-sessiond"
 #define DEFAULT_HOME_CLIENT_UNIX_SOCK           DEFAULT_LTTNG_HOME_RUNDIR "/client-lttng-sessiond"
diff --git a/src/common/utils.c b/src/common/utils.c
index ff6d1c2..1d07cb3 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -927,7 +927,7 @@ end:
 
 /*
  * Obtain the value of LTTNG_KMOD_PROBES environment variable, if exists.
- * Otherwise returns an empty string.
+ * Otherwise returns NULL.
  */
 LTTNG_HIDDEN
 char *utils_get_kmod_probes_list(void)
@@ -936,6 +936,16 @@ char *utils_get_kmod_probes_list(void)
 }
 
 /*
+ * Obtain the value of LTTNG_EXTRA_KMOD_PROBES environment variable, if
+ * exists. Otherwise returns NULL.
+ */
+LTTNG_HIDDEN
+char *utils_get_extra_kmod_probes_list(void)
+{
+	return getenv(DEFAULT_LTTNG_EXTRA_KMOD_PROBES);
+}
+
+/*
  * With the given format, fill dst with the time of len maximum siz.
  *
  * Return amount of bytes set in the buffer or else 0 on error.
diff --git a/src/common/utils.h b/src/common/utils.h
index bdc0e14..537fe0f 100644
--- a/src/common/utils.h
+++ b/src/common/utils.h
@@ -48,6 +48,7 @@ int utils_get_count_order_u32(uint32_t x);
 char *utils_get_home_dir(void);
 char *utils_get_user_home_dir(uid_t uid);
 char *utils_get_kmod_probes_list(void);
+char *utils_get_extra_kmod_probes_list(void);
 size_t utils_get_current_time_str(const char *format, char *dst, size_t len);
 gid_t utils_get_group_id(const char *name);
 char *utils_generate_optstring(const struct option *long_options,
-- 
2.1.0
