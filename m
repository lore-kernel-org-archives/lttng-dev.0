From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: setuid/setgid daemons should
	not get sensitive env. var./args
Date: Fri, 16 Jan 2015 12:48:20 -0500
Message-ID: <1421430500-7118-1-git-send-email-mathieu.desnoyers__22110.6055345901$1421430564$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1YCB0a-0000CZ-Vi
 for lttng-dev@lists.lttng.org; Fri, 16 Jan 2015 12:48:35 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Also, don't allow lttng command line interface to run as setuid/setgid
binary.

Fixes #780

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-consumerd/lttng-consumerd.c |  22 ++-
 src/bin/lttng-relayd/health-relayd.c      |   3 +-
 src/bin/lttng-relayd/main.c               | 101 +++++++----
 src/bin/lttng-sessiond/main.c             | 284 ++++++++++++++++++++----------
 src/bin/lttng/lttng.c                     |   6 +
 src/common/compat/Makefile.am             |   3 +-
 src/common/compat/getenv.h                |  43 +++++
 src/common/config/config.c                |   3 +-
 src/common/runas.c                        |   3 +-
 src/common/utils.c                        |   9 +-
 10 files changed, 337 insertions(+), 140 deletions(-)
 create mode 100644 src/common/compat/getenv.h

diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index 7122d06..626fbb7 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -47,6 +47,7 @@
 #include <common/consumer.h>
 #include <common/consumer-timer.h>
 #include <common/compat/poll.h>
+#include <common/compat/getenv.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/utils.h>
 
@@ -223,16 +224,31 @@ static int parse_args(int argc, char **argv)
 			}
 			break;
 		case 'c':
-			snprintf(command_sock_path, PATH_MAX, "%s", optarg);
+			if (lttng_is_setuid_setgid()) {
+				WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+					"-c, --consumerd-cmd-sock");
+			} else {
+				snprintf(command_sock_path, PATH_MAX, "%s", optarg);
+			}
 			break;
 		case 'e':
-			snprintf(error_sock_path, PATH_MAX, "%s", optarg);
+			if (lttng_is_setuid_setgid()) {
+				WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+					"-e, --consumerd-err-sock");
+			} else {
+				snprintf(error_sock_path, PATH_MAX, "%s", optarg);
+			}
 			break;
 		case 'd':
 			opt_daemon = 1;
 			break;
 		case 'g':
-			tracing_group_name = optarg;
+			if (lttng_is_setuid_setgid()) {
+				WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+					"-g, --group");
+			} else {
+				tracing_group_name = optarg;
+			}
 			break;
 		case 'h':
 			usage(stdout);
diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/health-relayd.c
index 75149ba..e3e48c9 100644
--- a/src/bin/lttng-relayd/health-relayd.c
+++ b/src/bin/lttng-relayd/health-relayd.c
@@ -49,6 +49,7 @@
 #include <common/compat/poll.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/utils.h>
+#include <common/compat/getenv.h>
 
 #include "lttng-relayd.h"
 #include "health-relayd.h"
@@ -136,7 +137,7 @@ int parse_health_env(void)
 {
 	const char *health_path;
 
-	health_path = getenv(LTTNG_RELAYD_HEALTH_ENV);
+	health_path = lttng_secure_getenv(LTTNG_RELAYD_HEALTH_ENV);
 	if (health_path) {
 		strncpy(health_unix_sock_path, health_path,
 			PATH_MAX);
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index fb290ba..c843aa5 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -46,6 +46,7 @@
 #include <common/compat/poll.h>
 #include <common/compat/socket.h>
 #include <common/compat/endian.h>
+#include <common/compat/getenv.h>
 #include <common/defaults.h>
 #include <common/daemonize.h>
 #include <common/futex.h>
@@ -197,33 +198,48 @@ int set_option(int opt, const char *arg, const char *optname)
 		}
 		break;
 	case 'C':
-		ret = uri_parse(arg, &control_uri);
-		if (ret < 0) {
-			ERR("Invalid control URI specified");
-			goto end;
-		}
-		if (control_uri->port == 0) {
-			control_uri->port = DEFAULT_NETWORK_CONTROL_PORT;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"-C, --control-port");
+		} else {
+			ret = uri_parse(arg, &control_uri);
+			if (ret < 0) {
+				ERR("Invalid control URI specified");
+				goto end;
+			}
+			if (control_uri->port == 0) {
+				control_uri->port = DEFAULT_NETWORK_CONTROL_PORT;
+			}
 		}
 		break;
 	case 'D':
-		ret = uri_parse(arg, &data_uri);
-		if (ret < 0) {
-			ERR("Invalid data URI specified");
-			goto end;
-		}
-		if (data_uri->port == 0) {
-			data_uri->port = DEFAULT_NETWORK_DATA_PORT;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"-D, -data-port");
+		} else {
+			ret = uri_parse(arg, &data_uri);
+			if (ret < 0) {
+				ERR("Invalid data URI specified");
+				goto end;
+			}
+			if (data_uri->port == 0) {
+				data_uri->port = DEFAULT_NETWORK_DATA_PORT;
+			}
 		}
 		break;
 	case 'L':
-		ret = uri_parse(arg, &live_uri);
-		if (ret < 0) {
-			ERR("Invalid live URI specified");
-			goto end;
-		}
-		if (live_uri->port == 0) {
-			live_uri->port = DEFAULT_NETWORK_VIEWER_PORT;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"-L, -live-port");
+		} else {
+			ret = uri_parse(arg, &live_uri);
+			if (ret < 0) {
+				ERR("Invalid live URI specified");
+				goto end;
+			}
+			if (live_uri->port == 0) {
+				live_uri->port = DEFAULT_NETWORK_VIEWER_PORT;
+			}
 		}
 		break;
 	case 'd':
@@ -233,23 +249,33 @@ int set_option(int opt, const char *arg, const char *optname)
 		opt_background = 1;
 		break;
 	case 'g':
-		tracing_group_name = strdup(arg);
-		if (tracing_group_name == NULL) {
-			ret = -errno;
-			PERROR("strdup");
-			goto end;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"-g, --group");
+		} else {
+			tracing_group_name = strdup(arg);
+			if (tracing_group_name == NULL) {
+				ret = -errno;
+				PERROR("strdup");
+				goto end;
+			}
+			tracing_group_name_override = 1;
 		}
-		tracing_group_name_override = 1;
 		break;
 	case 'h':
 		usage();
 		exit(EXIT_FAILURE);
 	case 'o':
-		ret = asprintf(&opt_output_path, "%s", arg);
-		if (ret < 0) {
-			ret = -errno;
-			PERROR("asprintf opt_output_path");
-			goto end;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"-o, --output");
+		} else {
+			ret = asprintf(&opt_output_path, "%s", arg);
+			if (ret < 0) {
+				ret = -errno;
+				PERROR("asprintf opt_output_path");
+				goto end;
+			}
 		}
 		break;
 	case 'v':
@@ -359,9 +385,14 @@ int set_options(int argc, char **argv)
 			continue;
 		}
 
-		config_path = utils_expand_path(optarg);
-		if (!config_path) {
-			ERR("Failed to resolve path: %s", optarg);
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"-f, --config");
+		} else {
+			config_path = utils_expand_path(optarg);
+			if (!config_path) {
+				ERR("Failed to resolve path: %s", optarg);
+			}
 		}
 	}
 
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index e084aba..e68aa79 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -42,6 +42,7 @@
 
 #include <common/common.h>
 #include <common/compat/socket.h>
+#include <common/compat/getenv.h>
 #include <common/defaults.h>
 #include <common/kernel-consumer/kernel-consumer.h>
 #include <common/futex.h>
@@ -367,19 +368,19 @@ void setup_consumerd_path(void)
 	/*
 	 * runtime env. var. overrides the build default.
 	 */
-	bin = getenv("LTTNG_CONSUMERD32_BIN");
+	bin = lttng_secure_getenv("LTTNG_CONSUMERD32_BIN");
 	if (bin) {
 		consumerd32_bin = bin;
 	}
-	bin = getenv("LTTNG_CONSUMERD64_BIN");
+	bin = lttng_secure_getenv("LTTNG_CONSUMERD64_BIN");
 	if (bin) {
 		consumerd64_bin = bin;
 	}
-	libdir = getenv("LTTNG_CONSUMERD32_LIBDIR");
+	libdir = lttng_secure_getenv("LTTNG_CONSUMERD32_LIBDIR");
 	if (libdir) {
 		consumerd32_libdir = libdir;
 	}
-	libdir = getenv("LTTNG_CONSUMERD64_LIBDIR");
+	libdir = lttng_secure_getenv("LTTNG_CONSUMERD64_LIBDIR");
 	if (libdir) {
 		consumerd64_libdir = libdir;
 	}
@@ -2440,7 +2441,7 @@ static pid_t spawn_consumerd(struct consumer_data *consumer_data)
 				char *tmp;
 				size_t tmplen;
 
-				tmp = getenv("LD_LIBRARY_PATH");
+				tmp = lttng_secure_getenv("LD_LIBRARY_PATH");
 				if (!tmp) {
 					tmp = "";
 				}
@@ -2483,7 +2484,7 @@ static pid_t spawn_consumerd(struct consumer_data *consumer_data)
 				char *tmp;
 				size_t tmplen;
 
-				tmp = getenv("LD_LIBRARY_PATH");
+				tmp = lttng_secure_getenv("LD_LIBRARY_PATH");
 				if (!tmp) {
 					tmp = "";
 				}
@@ -4385,10 +4386,20 @@ static int set_option(int opt, const char *arg, const char *optname)
 		}
 		break;
 	case 'c':
-		snprintf(client_unix_sock_path, PATH_MAX, "%s", arg);
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"-c, --client-sock");
+		} else {
+			snprintf(client_unix_sock_path, PATH_MAX, "%s", arg);
+		}
 		break;
 	case 'a':
-		snprintf(apps_unix_sock_path, PATH_MAX, "%s", arg);
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"-a, --apps-sock");
+		} else {
+			snprintf(apps_unix_sock_path, PATH_MAX, "%s", arg);
+		}
 		break;
 	case 'd':
 		opt_daemon = 1;
@@ -4397,20 +4408,25 @@ static int set_option(int opt, const char *arg, const char *optname)
 		opt_background = 1;
 		break;
 	case 'g':
-		/*
-		 * If the override option is set, the pointer points to a
-		 * *non* const thus freeing it even though the variable type is
-		 * set to const.
-		 */
-		if (tracing_group_name_override) {
-			free((void *) tracing_group_name);
-		}
-		tracing_group_name = strdup(arg);
-		if (!tracing_group_name) {
-			PERROR("strdup");
-			ret = -ENOMEM;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"-g, --group");
+		} else {
+			/*
+			 * If the override option is set, the pointer points to a
+			 * *non* const thus freeing it even though the variable type is
+			 * set to const.
+			 */
+			if (tracing_group_name_override) {
+				free((void *) tracing_group_name);
+			}
+			tracing_group_name = strdup(arg);
+			if (!tracing_group_name) {
+				PERROR("strdup");
+				ret = -ENOMEM;
+			}
+			tracing_group_name_override = 1;
 		}
-		tracing_group_name_override = 1;
 		break;
 	case 'h':
 		usage();
@@ -4422,22 +4438,52 @@ static int set_option(int opt, const char *arg, const char *optname)
 		opt_sig_parent = 1;
 		break;
 	case 'E':
-		snprintf(kconsumer_data.err_unix_sock_path, PATH_MAX, "%s", arg);
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--kconsumerd-err-sock");
+		} else {
+			snprintf(kconsumer_data.err_unix_sock_path, PATH_MAX, "%s", arg);
+		}
 		break;
 	case 'C':
-		snprintf(kconsumer_data.cmd_unix_sock_path, PATH_MAX, "%s", arg);
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--kconsumerd-cmd-sock");
+		} else {
+			snprintf(kconsumer_data.cmd_unix_sock_path, PATH_MAX, "%s", arg);
+		}
 		break;
 	case 'F':
-		snprintf(ustconsumer64_data.err_unix_sock_path, PATH_MAX, "%s", arg);
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--ustconsumerd64-err-sock");
+		} else {
+			snprintf(ustconsumer64_data.err_unix_sock_path, PATH_MAX, "%s", arg);
+		}
 		break;
 	case 'D':
-		snprintf(ustconsumer64_data.cmd_unix_sock_path, PATH_MAX, "%s", arg);
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--ustconsumerd64-cmd-sock");
+		} else {
+			snprintf(ustconsumer64_data.cmd_unix_sock_path, PATH_MAX, "%s", arg);
+		}
 		break;
 	case 'H':
-		snprintf(ustconsumer32_data.err_unix_sock_path, PATH_MAX, "%s", arg);
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--ustconsumerd32-err-sock");
+		} else {
+			snprintf(ustconsumer32_data.err_unix_sock_path, PATH_MAX, "%s", arg);
+		}
 		break;
 	case 'G':
-		snprintf(ustconsumer32_data.cmd_unix_sock_path, PATH_MAX, "%s", arg);
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--ustconsumerd32-cmd-sock");
+		} else {
+			snprintf(ustconsumer32_data.cmd_unix_sock_path, PATH_MAX, "%s", arg);
+		}
 		break;
 	case 'N':
 		opt_no_kernel = 1;
@@ -4466,97 +4512,142 @@ static int set_option(int opt, const char *arg, const char *optname)
 		}
 		break;
 	case 'u':
-		if (consumerd32_bin_override) {
-			free((void *) consumerd32_bin);
-		}
-		consumerd32_bin = strdup(arg);
-		if (!consumerd32_bin) {
-			PERROR("strdup");
-			ret = -ENOMEM;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--consumerd32-path");
+		} else {
+			if (consumerd32_bin_override) {
+				free((void *) consumerd32_bin);
+			}
+			consumerd32_bin = strdup(arg);
+			if (!consumerd32_bin) {
+				PERROR("strdup");
+				ret = -ENOMEM;
+			}
+			consumerd32_bin_override = 1;
 		}
-		consumerd32_bin_override = 1;
 		break;
 	case 'U':
-		if (consumerd32_libdir_override) {
-			free((void *) consumerd32_libdir);
-		}
-		consumerd32_libdir = strdup(arg);
-		if (!consumerd32_libdir) {
-			PERROR("strdup");
-			ret = -ENOMEM;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--consumerd32-libdir");
+		} else {
+			if (consumerd32_libdir_override) {
+				free((void *) consumerd32_libdir);
+			}
+			consumerd32_libdir = strdup(arg);
+			if (!consumerd32_libdir) {
+				PERROR("strdup");
+				ret = -ENOMEM;
+			}
+			consumerd32_libdir_override = 1;
 		}
-		consumerd32_libdir_override = 1;
 		break;
 	case 't':
-		if (consumerd64_bin_override) {
-			free((void *) consumerd64_bin);
-		}
-		consumerd64_bin = strdup(arg);
-		if (!consumerd64_bin) {
-			PERROR("strdup");
-			ret = -ENOMEM;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--consumerd64-path");
+		} else {
+			if (consumerd64_bin_override) {
+				free((void *) consumerd64_bin);
+			}
+			consumerd64_bin = strdup(arg);
+			if (!consumerd64_bin) {
+				PERROR("strdup");
+				ret = -ENOMEM;
+			}
+			consumerd64_bin_override = 1;
 		}
-		consumerd64_bin_override = 1;
 		break;
 	case 'T':
-		if (consumerd64_libdir_override) {
-			free((void *) consumerd64_libdir);
-		}
-		consumerd64_libdir = strdup(arg);
-		if (!consumerd64_libdir) {
-			PERROR("strdup");
-			ret = -ENOMEM;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--consumerd64-libdir");
+		} else {
+			if (consumerd64_libdir_override) {
+				free((void *) consumerd64_libdir);
+			}
+			consumerd64_libdir = strdup(arg);
+			if (!consumerd64_libdir) {
+				PERROR("strdup");
+				ret = -ENOMEM;
+			}
+			consumerd64_libdir_override = 1;
 		}
-		consumerd64_libdir_override = 1;
 		break;
 	case 'p':
-		free(opt_pidfile);
-		opt_pidfile = strdup(arg);
-		if (!opt_pidfile) {
-			PERROR("strdup");
-			ret = -ENOMEM;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"-p, --pidfile");
+		} else {
+			free(opt_pidfile);
+			opt_pidfile = strdup(arg);
+			if (!opt_pidfile) {
+				PERROR("strdup");
+				ret = -ENOMEM;
+			}
 		}
 		break;
 	case 'J': /* Agent TCP port. */
 	{
-		unsigned long v;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--agent-tcp-port");
+		} else {
+			unsigned long v;
 
-		errno = 0;
-		v = strtoul(arg, NULL, 0);
-		if (errno != 0 || !isdigit(arg[0])) {
-			ERR("Wrong value in --agent-tcp-port parameter: %s", arg);
-			return -1;
-		}
-		if (v == 0 || v >= 65535) {
-			ERR("Port overflow in --agent-tcp-port parameter: %s", arg);
-			return -1;
+			errno = 0;
+			v = strtoul(arg, NULL, 0);
+			if (errno != 0 || !isdigit(arg[0])) {
+				ERR("Wrong value in --agent-tcp-port parameter: %s", arg);
+				return -1;
+			}
+			if (v == 0 || v >= 65535) {
+				ERR("Port overflow in --agent-tcp-port parameter: %s", arg);
+				return -1;
+			}
+			agent_tcp_port = (uint32_t) v;
+			DBG3("Agent TCP port set to non default: %u", agent_tcp_port);
 		}
-		agent_tcp_port = (uint32_t) v;
-		DBG3("Agent TCP port set to non default: %u", agent_tcp_port);
 		break;
 	}
 	case 'l':
-		free(opt_load_session_path);
-		opt_load_session_path = strdup(arg);
-		if (!opt_load_session_path) {
-			PERROR("strdup");
-			ret = -ENOMEM;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"-l, --load");
+		} else {
+			free(opt_load_session_path);
+			opt_load_session_path = strdup(arg);
+			if (!opt_load_session_path) {
+				PERROR("strdup");
+				ret = -ENOMEM;
+			}
 		}
 		break;
 	case 'P': /* probe modules list */
-		free(kmod_probes_list);
-		kmod_probes_list = strdup(arg);
-		if (!kmod_probes_list) {
-			PERROR("strdup");
-			ret = -ENOMEM;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--kmod-probes");
+		} else {
+			free(kmod_probes_list);
+			kmod_probes_list = strdup(arg);
+			if (!kmod_probes_list) {
+				PERROR("strdup");
+				ret = -ENOMEM;
+			}
 		}
 		break;
 	case 'e':
-		free(kmod_extra_probes_list);
-		kmod_extra_probes_list = strdup(arg);
-		if (!kmod_extra_probes_list) {
-			PERROR("strdup");
-			ret = -ENOMEM;
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"--extra-kmod-probes");
+		} else {
+			free(kmod_extra_probes_list);
+			kmod_extra_probes_list = strdup(arg);
+			if (!kmod_extra_probes_list) {
+				PERROR("strdup");
+				ret = -ENOMEM;
+			}
 		}
 		break;
 	case 'f':
@@ -4672,9 +4763,14 @@ static int set_options(int argc, char **argv)
 			continue;
 		}
 
-		config_path = utils_expand_path(optarg);
-		if (!config_path) {
-			ERR("Failed to resolve path: %s", optarg);
+		if (lttng_is_setuid_setgid()) {
+			WARN("Getting '%s' argument from setuid/setgid binary refused for security reasons.",
+				"-f, --config");
+		} else {
+			config_path = utils_expand_path(optarg);
+			if (!config_path) {
+				ERR("Failed to resolve path: %s", optarg);
+			}
 		}
 	}
 
diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
index 154f6df..8e5bb0f 100644
--- a/src/bin/lttng/lttng.c
+++ b/src/bin/lttng/lttng.c
@@ -30,6 +30,7 @@
 
 #include <lttng/lttng.h>
 #include <common/error.h>
+#include <common/compat/getenv.h>
 
 #include "command.h"
 
@@ -445,6 +446,11 @@ static int parse_args(int argc, char **argv)
 	int opt, ret;
 	char *user;
 
+	if (lttng_is_setuid_setgid()) {
+		ERR("'%s' is not allowed to be executed as a setuid/setgid binary for security reasons. Aborting.", argv[0]);
+		clean_exit(EXIT_FAILURE);
+	}
+
 	if (argc < 2) {
 		usage(stderr);
 		clean_exit(EXIT_FAILURE);
diff --git a/src/common/compat/Makefile.am b/src/common/compat/Makefile.am
index 537375b..5df27df 100644
--- a/src/common/compat/Makefile.am
+++ b/src/common/compat/Makefile.am
@@ -9,4 +9,5 @@ COMPAT=compat-poll.c
 endif
 
 libcompat_la_SOURCES = poll.h fcntl.h endian.h mman.h clone.h \
-                       socket.h compat-fcntl.c uuid.h tid.h $(COMPAT)
+		socket.h compat-fcntl.c uuid.h tid.h \
+		getenv.h $(COMPAT)
diff --git a/src/common/compat/getenv.h b/src/common/compat/getenv.h
new file mode 100644
index 0000000..23a6dfe
--- /dev/null
+++ b/src/common/compat/getenv.h
@@ -0,0 +1,43 @@
+#ifndef _COMPAT_GETENV_H
+#define _COMPAT_GETENV_H
+
+/*
+ * Copyright (C) 2015 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <common/error.h>
+
+static inline
+int lttng_is_setuid_setgid(void)
+{
+	return geteuid() != getuid() || getegid() != getgid();
+}
+
+static inline
+char *lttng_secure_getenv(const char *name)
+{
+	if (lttng_is_setuid_setgid()) {
+		WARN("Getting environment variable '%s' from setuid/setgid binary refused for security reasons.",
+			name);
+		return NULL;
+	}
+	return getenv(name);
+}
+
+#endif /* _COMPAT_GETENV_H */
diff --git a/src/common/config/config.c b/src/common/config/config.c
index 86b1be8..ece7cdb 100644
--- a/src/common/config/config.c
+++ b/src/common/config/config.c
@@ -32,6 +32,7 @@
 #include <common/error.h>
 #include <common/macros.h>
 #include <common/utils.h>
+#include <common/compat/getenv.h>
 #include <lttng/lttng-error.h>
 #include <libxml/parser.h>
 #include <libxml/valid.h>
@@ -595,7 +596,7 @@ static
 char *get_session_config_xsd_path()
 {
 	char *xsd_path;
-	const char *base_path = getenv(DEFAULT_SESSION_CONFIG_XSD_PATH_ENV);
+	const char *base_path = lttng_secure_getenv(DEFAULT_SESSION_CONFIG_XSD_PATH_ENV);
 	size_t base_path_len;
 	size_t max_path_len;
 
diff --git a/src/common/runas.c b/src/common/runas.c
index c146f65..471bb22 100644
--- a/src/common/runas.c
+++ b/src/common/runas.c
@@ -35,6 +35,7 @@
 #include <common/utils.h>
 #include <common/compat/mman.h>
 #include <common/compat/clone.h>
+#include <common/compat/getenv.h>
 
 #include "runas.h"
 
@@ -88,7 +89,7 @@ int use_clone(void)
 static
 int use_clone(void)
 {
-	return !getenv("LTTNG_DEBUG_NOCLONE");
+	return !lttng_secure_getenv("LTTNG_DEBUG_NOCLONE");
 }
 #endif
 
diff --git a/src/common/utils.c b/src/common/utils.c
index 7f91dcb..9a53330 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -35,6 +35,7 @@
 
 #include <common/common.h>
 #include <common/runas.h>
+#include <common/compat/getenv.h>
 
 #include "utils.h"
 #include "defaults.h"
@@ -885,11 +886,11 @@ char *utils_get_home_dir(void)
 	char *val = NULL;
 	struct passwd *pwd;
 
-	val = getenv(DEFAULT_LTTNG_HOME_ENV_VAR);
+	val = lttng_secure_getenv(DEFAULT_LTTNG_HOME_ENV_VAR);
 	if (val != NULL) {
 		goto end;
 	}
-	val = getenv(DEFAULT_LTTNG_FALLBACK_HOME_ENV_VAR);
+	val = lttng_secure_getenv(DEFAULT_LTTNG_FALLBACK_HOME_ENV_VAR);
 	if (val != NULL) {
 		goto end;
 	}
@@ -954,7 +955,7 @@ end:
 LTTNG_HIDDEN
 char *utils_get_kmod_probes_list(void)
 {
-	return getenv(DEFAULT_LTTNG_KMOD_PROBES);
+	return lttng_secure_getenv(DEFAULT_LTTNG_KMOD_PROBES);
 }
 
 /*
@@ -964,7 +965,7 @@ char *utils_get_kmod_probes_list(void)
 LTTNG_HIDDEN
 char *utils_get_extra_kmod_probes_list(void)
 {
-	return getenv(DEFAULT_LTTNG_EXTRA_KMOD_PROBES);
+	return lttng_secure_getenv(DEFAULT_LTTNG_EXTRA_KMOD_PROBES);
 }
 
 /*
-- 
2.1.1
