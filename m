From: Zifei Tong <soariez@gmail.com>
Subject: [RFC PATCH lttng-tools 1/2] Add support for UST dynamic
	instrumentation
Date: Wed,  4 Sep 2013 19:00:40 +0800
Message-ID: <1378292441-18272-1-git-send-email-soariez__9580.76188476316$1378292527$gmane$org@gmail.com>
References: <CAJ7wx-EDBibZ-MO7pWfGGBdx+2yzN7pENpWpEoWAj7r5hDSGSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1VHApv-0001Nf-BD
	for lttng-dev@lists.lttng.org; Wed, 04 Sep 2013 07:01:28 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so271990pab.40
	for <lttng-dev@lists.lttng.org>; Wed, 04 Sep 2013 04:01:17 -0700 (PDT)
In-Reply-To: <CAJ7wx-EDBibZ-MO7pWfGGBdx+2yzN7pENpWpEoWAj7r5hDSGSA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Most parts of code are to deal with passing a varlen payload between
the sessiond, tracer application and lttng command, inspired by how
the filter feature are implemented.

You can also view the patch at:
https://github.com/5kg/lttng-tools/commit/fc2ca02a6915a4da513d47c7386e4a13f6629538
---
 include/lttng/lttng-error.h              |   2 +
 include/lttng/lttng.h                    |  19 ++++-
 src/bin/lttng-sessiond/Makefile.am       |   1 +
 src/bin/lttng-sessiond/cmd.c             |   6 ++
 src/bin/lttng-sessiond/lttng-ust-abi.h   |  30 +++++++-
 src/bin/lttng-sessiond/main.c            |  38 ++++++++++
 src/bin/lttng-sessiond/trace-ust.c       |  19 ++++-
 src/bin/lttng-sessiond/ust-app.c         | 126 +++++++++++++++++++++++++++++++
 src/bin/lttng-sessiond/ust-instrument.h  |  47 ++++++++++++
 src/bin/lttng/commands/enable_events.c   |  84 +++++++++++++++++++--
 src/bin/lttng/commands/list.c            |   2 +
 src/common/error.c                       |   2 +
 src/common/sessiond-comm/sessiond-comm.h |   2 +
 src/lib/lttng-ctl/lttng-ctl.c            |   7 ++
 14 files changed, 374 insertions(+), 11 deletions(-)
 create mode 100644 src/bin/lttng-sessiond/ust-instrument.h

diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h
index 51ef9ca..73e40b4 100644
--- a/include/lttng/lttng-error.h
+++ b/include/lttng/lttng-error.h
@@ -140,6 +140,8 @@ enum lttng_error_code {
 	LTTNG_ERR_FILTER_NOMEM           = 107, /* Lack of memory for filter bytecode */
 	LTTNG_ERR_FILTER_EXIST           = 108, /* Filter already exist */
 	LTTNG_ERR_NO_CONSUMER            = 109, /* No consumer exist for the session */
+	LTTNG_ERR_TARGET_INVAL           = 110, /* Invalid instrument target */
+	LTTNG_ERR_TARGET_NOMEM           = 111, /* Lack of memory for instrument target */
 
 	/* MUST be last element */
 	LTTNG_ERR_NR,                           /* Last element */
diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
index 4ffffd8..a6e018d 100644
--- a/include/lttng/lttng.h
+++ b/include/lttng/lttng.h
@@ -231,11 +231,27 @@ struct lttng_event_function_attr {
 };
 
 /*
+ * Instrument target
+ *
+ * The structures should be initialized to zero before use.
+ */
+#define LTTNG_EVENT_TARGET_PADDING        32
+struct lttng_event_target_attr {
+	int path_len;
+
+	char padding[LTTNG_EVENT_TARGET_PADDING];
+
+	/* This varlen field should always be the last element */
+	char path[0];
+};
+
+/*
  * Generic lttng event
  *
  * The structures should be initialized to zero before use.
  */
-#define LTTNG_EVENT_PADDING1               15
+#define LTTNG_EVENT_PADDING1               \
+	(15 - sizeof(struct lttng_event_target_attr *))
 #define LTTNG_EVENT_PADDING2               LTTNG_SYMBOL_NAME_LEN + 32
 struct lttng_event {
 	enum lttng_event_type type;
@@ -247,6 +263,7 @@ struct lttng_event {
 	int32_t enabled;	/* Does not apply: -1 */
 	pid_t pid;
 	unsigned char filter;	/* filter enabled ? */
+	struct lttng_event_target_attr *target;
 
 	char padding[LTTNG_EVENT_PADDING1];
 
diff --git a/src/bin/lttng-sessiond/Makefile.am b/src/bin/lttng-sessiond/Makefile.am
index 77cc1d2..dce17cb 100644
--- a/src/bin/lttng-sessiond/Makefile.am
+++ b/src/bin/lttng-sessiond/Makefile.am
@@ -11,6 +11,7 @@ lttng_sessiond_SOURCES = utils.c utils.h \
                        kernel.c kernel.h \
                        ust-ctl.h ust-app.h trace-ust.h ust-thread.h \
                        ust-registry.h \
+                       ust-instrument.h \
                        context.c context.h \
                        channel.c channel.h \
                        event.c event.h \
diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index e9fa3b4..c154927 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -235,9 +235,15 @@ static int list_lttng_ust_global_events(char *channel_name,
 			break;
 		case LTTNG_UST_PROBE:
 			tmp[i].type = LTTNG_EVENT_PROBE;
+			memcpy(&tmp[i].attr.probe, &uevent->attr.u.probe,
+					sizeof(struct lttng_ust_probe));
+			/* TODO: List instrument target information */
 			break;
 		case LTTNG_UST_FUNCTION:
 			tmp[i].type = LTTNG_EVENT_FUNCTION;
+			memcpy(&tmp[i].attr.probe, &uevent->attr.u.probe,
+					sizeof(struct lttng_ust_probe));
+			/* TODO: List instrument target information */
 			break;
 		}
 
diff --git a/src/bin/lttng-sessiond/lttng-ust-abi.h b/src/bin/lttng-sessiond/lttng-ust-abi.h
index 98470e4..29fc879 100644
--- a/src/bin/lttng-sessiond/lttng-ust-abi.h
+++ b/src/bin/lttng-sessiond/lttng-ust-abi.h
@@ -100,7 +100,32 @@ struct lttng_ust_stream {
 	 */
 } LTTNG_PACKED;
 
-#define LTTNG_UST_EVENT_PADDING1	16
+/*
+ * Either addr is used, or symbol_name and offset.
+ */
+#define LTTNG_UST_PROBE_PADDING	16
+struct lttng_ust_probe {
+	uint64_t addr;
+
+	uint64_t offset;
+	char symbol_name[LTTNG_UST_SYM_NAME_LEN];
+
+	char padding[LTTNG_UST_PROBE_PADDING];
+} LTTNG_PACKED;
+
+/*
+ * Instrument target
+ */
+#define LTTNG_UST_TARGET_PADDING	32
+struct lttng_ust_target {
+	uint32_t path_len;
+
+	char padding[LTTNG_UST_TARGET_PADDING];
+
+	char path[0];
+} LTTNG_PACKED;
+
+#define LTTNG_UST_EVENT_PADDING1	(16 - sizeof(struct lttng_ust_target *))
 #define LTTNG_UST_EVENT_PADDING2	(LTTNG_UST_SYM_NAME_LEN + 32)
 struct lttng_ust_event {
 	enum lttng_ust_instrumentation instrumentation;
@@ -108,10 +133,12 @@ struct lttng_ust_event {
 
 	enum lttng_ust_loglevel_type loglevel_type;
 	int loglevel;	/* value, -1: all */
+	struct lttng_ust_target *target;
 	char padding[LTTNG_UST_EVENT_PADDING1];
 
 	/* Per instrumentation type configuration */
 	union {
+		struct lttng_ust_probe probe;
 		char padding[LTTNG_UST_EVENT_PADDING2];
 	} u;
 } LTTNG_PACKED;
@@ -275,6 +302,7 @@ struct lttng_ust_filter_bytecode {
 
 /* Event FD commands */
 #define LTTNG_UST_FILTER			_UST_CMD(0xA0)
+#define LTTNG_UST_TARGET			_UST_CMD(0xA1)
 
 #define LTTNG_UST_ROOT_HANDLE	0
 
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index d22e2a6..6c6b60b 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -2876,6 +2876,44 @@ skip_domain:
 	}
 	case LTTNG_ENABLE_EVENT:
 	{
+		/* TODO: Handle dynamic instrumentation with filter */
+		struct lttng_event_target_attr *target;
+
+		if (cmd_ctx->lsm->u.enable.event.target) {
+			if (cmd_ctx->lsm->u.enable.target_len
+					< sizeof(struct lttng_event_target_attr)) {
+				ret = LTTNG_ERR_TARGET_INVAL;
+				goto error;
+			}
+
+			target = zmalloc(cmd_ctx->lsm->u.enable.target_len);
+			if (!target) {
+				ret = LTTNG_ERR_TARGET_NOMEM;
+				goto error;
+			}
+
+			/* Receive var. len. data */
+			DBG("Receiving var len data target from client ...");
+			ret = lttcomm_recv_unix_sock(sock, target,
+					cmd_ctx->lsm->u.enable.target_len);
+			if (ret <= 0) {
+				DBG("Nothing recv() from client var len data... continuing");
+				*sock_error = 1;
+				free(target);
+				ret = LTTNG_ERR_TARGET_INVAL;
+				goto error;
+			}
+
+			if ((sizeof(struct lttng_event_target_attr) + target->path_len)
+						!= cmd_ctx->lsm->u.enable.target_len) {
+				free(target);
+				ret = LTTNG_ERR_TARGET_INVAL;
+				goto error;
+			}
+
+			cmd_ctx->lsm->u.enable.event.target = target;
+		}
+
 		ret = cmd_enable_event(cmd_ctx->session, &cmd_ctx->lsm->domain,
 				cmd_ctx->lsm->u.enable.channel_name,
 				&cmd_ctx->lsm->u.enable.event, NULL, kernel_poll_pipe[1]);
diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index c80d5e7..f5f4122 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -324,12 +324,23 @@ struct ltt_ust_event *trace_ust_create_event(struct lttng_event *ev,
 	switch (ev->type) {
 	case LTTNG_EVENT_PROBE:
 		lue->attr.instrumentation = LTTNG_UST_PROBE;
+		lue->attr.u.probe.addr = ev->attr.probe.addr;
+		lue->attr.u.probe.offset = ev->attr.probe.offset;
+		strncpy(lue->attr.u.probe.symbol_name,
+				ev->attr.probe.symbol_name, LTTNG_UST_SYM_NAME_LEN);
+		lue->attr.u.probe.symbol_name[LTTNG_UST_SYM_NAME_LEN - 1] = '\0';
+		/* Same layout. */
+		lue->attr.target = (struct lttng_ust_target *) ev->target;
 		break;
 	case LTTNG_EVENT_FUNCTION:
 		lue->attr.instrumentation = LTTNG_UST_FUNCTION;
-		break;
-	case LTTNG_EVENT_FUNCTION_ENTRY:
-		lue->attr.instrumentation = LTTNG_UST_FUNCTION;
+		lue->attr.u.probe.addr = ev->attr.probe.addr;
+		lue->attr.u.probe.offset = ev->attr.probe.offset;
+		strncpy(lue->attr.u.probe.symbol_name,
+				ev->attr.probe.symbol_name, LTTNG_UST_SYM_NAME_LEN);
+		lue->attr.u.probe.symbol_name[LTTNG_UST_SYM_NAME_LEN - 1] = '\0';
+		/* Same layout. */
+		lue->attr.target = (struct lttng_ust_target *) ev->target;
 		break;
 	case LTTNG_EVENT_TRACEPOINT:
 		lue->attr.instrumentation = LTTNG_UST_TRACEPOINT;
@@ -514,6 +525,8 @@ void trace_ust_destroy_event(struct ltt_ust_event *event)
 	assert(event);
 
 	DBG2("Trace destroy UST event %s", event->attr.name);
+
+	free(event->attr.target);
 	free(event->filter);
 	free(event);
 }
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 9fe5483..c8333bf 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -38,6 +38,7 @@
 #include "ust-app.h"
 #include "ust-consumer.h"
 #include "ust-ctl.h"
+#include "ust-instrument.h"
 #include "utils.h"
 
 /* Next available channel key. Access under next_channel_key_lock. */
@@ -270,6 +271,7 @@ void delete_ust_app_event(int sock, struct ust_app_event *ua_event)
 
 	assert(ua_event);
 
+	free(ua_event->attr.target);
 	free(ua_event->filter);
 
 	if (ua_event->obj != NULL) {
@@ -927,6 +929,28 @@ error:
 }
 
 /*
+ * Allocate a instrument target and copy the given original one.
+ *
+ * Return allocated instrument target or NULL on error.
+ */
+static struct lttng_ust_target *alloc_copy_ust_app_target(
+		struct lttng_ust_target *orig_t)
+{
+	struct lttng_ust_target *target = NULL;
+
+	target = zmalloc(sizeof(*target) + orig_t->path_len);
+	if (!target) {
+		PERROR("zmalloc alloc ust app instrument target");
+		goto error;
+	}
+
+	memcpy(target, orig_t, sizeof(*target) + orig_t->path_len);
+
+error:
+	return target;
+}
+
+/*
  * Allocate a filter and copy the given original filter.
  *
  * Return allocated filter or NULL on error.
@@ -1067,6 +1091,41 @@ error:
 }
 
 /*
+ * Set the target on the tracer.
+ */
+static
+int set_ust_event_target(struct ust_app_event *ua_event,
+		struct ust_app *app)
+{
+	int ret;
+
+	health_code_update();
+
+	if (!ua_event->attr.target) {
+		ret = 0;
+		goto error;
+	}
+
+	ret = ustctl_set_target(app->sock, ua_event->attr.target,
+			ua_event->obj);
+	if (ret < 0) {
+		if (ret != -EPIPE && ret != -LTTNG_UST_ERR_EXITING) {
+			ERR("UST app event %s set instrument target failed for app (pid: %d) "
+					"with ret %d", ua_event->attr.name, app->pid, ret);
+		} else {
+			DBG3("UST app set instrument target failed. Application is dead.");
+		}
+		goto error;
+	}
+
+	DBG2("UST instrument target set successfully for event %s", ua_event->name);
+
+error:
+	health_code_update();
+	return ret;
+}
+
+/*
  * Set the filter on the tracer.
  */
 static
@@ -1302,6 +1361,14 @@ int create_ust_event(struct ust_app *app, struct ust_app_session *ua_sess,
 
 	health_code_update();
 
+	/* Set instrument target if one is present. */
+	if (ua_event->attr.target) {
+		ret = set_ust_event_target(ua_event, app);
+		if (ret < 0) {
+			goto error;
+		}
+	}
+
 	/* Set filter if one is present. */
 	if (ua_event->filter) {
 		ret = set_ust_event_filter(ua_event, app);
@@ -1353,6 +1420,13 @@ static void shadow_copy_event(struct ust_app_event *ua_event,
 	/* Copy event attributes */
 	memcpy(&ua_event->attr, &uevent->attr, sizeof(ua_event->attr));
 
+	/* Copy instrument target */
+	if (uevent->attr.target) {
+		ua_event->attr.target =
+			alloc_copy_ust_app_target(uevent->attr.target);
+		/* Target might be NULL here in case of ENONEM. */
+	}
+
 	/* Copy filter bytecode */
 	if (uevent->filter) {
 		ua_event->filter = alloc_copy_ust_app_filter(uevent->filter);
@@ -4775,6 +4849,58 @@ int ust_app_recv_notify(int sock)
 
 		break;
 	}
+	case USTCTL_NOTIFY_CMD_INSTRUMENT:
+	{
+		enum lttng_ust_instrumentation instrumentation;
+		char name[LTTNG_UST_SYM_NAME_LEN], symbol[LTTNG_UST_SYM_NAME_LEN];
+		char object_path[PATH_MAX];
+		uint64_t addr, offset;
+		struct ust_app *app;
+
+		DBG2("UST app ustctl instrument probe received");
+
+		ret = ustctl_recv_instrument_probe(sock, object_path, name,
+				&instrumentation, &addr, symbol, &offset);
+		if (ret < 0) {
+			if (ret != -EPIPE && ret != -LTTNG_UST_ERR_EXITING) {
+				ERR("UST app recv instrument failed with ret %d", ret);
+			} else {
+				DBG3("UST app recv instrument failed. Application died");
+			}
+			goto error;
+		}
+
+		rcu_read_lock();
+
+		app = find_app_by_notify_sock(sock);
+		if (app == NULL) {
+			DBG3("UST app instrument failed to find app sock %d", sock);
+			goto error;
+		}
+
+		if (!app->compatible) {
+			goto error;
+		}
+
+		rcu_read_unlock();
+
+		ret = ust_instrument_probe(app, object_path, name, instrumentation,
+				addr, symbol, offset);
+
+		DBG3("UST app replying to instrument probe with pid %u, ret: %d",
+				app->pid, ret);
+
+		ret = ustctl_reply_instrument_probe(sock, ret);
+		if (ret < 0) {
+			if (ret != -EPIPE && ret != -LTTNG_UST_ERR_EXITING) {
+				ERR("UST app reply instrument failed with ret %d", ret);
+			} else {
+				DBG3("UST app reply instrument failed. Application died");
+			}
+			goto error;
+		}
+		break;
+	}
 	default:
 		/* Should NEVER happen. */
 		assert(0);
diff --git a/src/bin/lttng-sessiond/ust-instrument.h b/src/bin/lttng-sessiond/ust-instrument.h
new file mode 100644
index 0000000..4332253
--- /dev/null
+++ b/src/bin/lttng-sessiond/ust-instrument.h
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2013 - Zifei Tong <soariez@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef _LTT_UST_INSTRUMENT_H
+#define _LTT_UST_INSTRUMENT_H
+
+#include <stdint.h>
+
+#include "trace-ust.h"
+
+#if defined(HAVE_UST_INSTRUMENT_PROBE) && defined(HAVE_LIBLTTNG_UST_CTL)
+
+int ust_instrument_probe(struct ust_app* app,
+		const char *object_path,
+		const char *name,
+		enum lttng_ust_instrumentation instrumentation,
+		uint64_t addr,
+		const char *symbol,
+		uint64_t offset);
+
+#else /* HAVE_UST_INSTRUMENT_PROBE && HAVE_LIBLTTNG_UST_CTL */
+
+static inline
+int ust_instrument_probe(struct ust_app *app, const char* object_path,
+		const char* name, enum lttng_ust_instrumentation instrumentation,
+		uint64_t addr, const char *symbol, uint64_t offset)
+{
+	return -ENOSYS;
+}
+
+#endif /* HAVE_UST_INSTRUMENT_PROBE && HAVE_LIBLTTNG_UST_CTL */
+
+#endif /* _LTT_UST_INSTRUEMENT_H */
diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index 26195af..cd8e1a1 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -113,14 +113,16 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "                             e.g.:\n");
 	fprintf(ofp, "                               \"*\"\n");
 	fprintf(ofp, "                               \"app_component:na*\"\n");
-	fprintf(ofp, "    --probe (addr | symbol | symbol+offset)\n");
+	fprintf(ofp, "    --probe [object@](addr | symbol | symbol+offset)\n");
 	fprintf(ofp, "                           Dynamic probe.\n");
-	fprintf(ofp, "                           Addr and offset can be octal (0NNN...),\n");
-	fprintf(ofp, "                           decimal (NNN...) or hexadecimal (0xNNN...)\n");
-	fprintf(ofp, "    --function (addr | symbol | symbol+offset)\n");
+	fprintf(ofp, "                           - userspace tracer requires specifying an object to instrument.\n");
+	fprintf(ofp, "                           - Addr and offset can be octal (0NNN...),\n");
+	fprintf(ofp, "                             decimal (NNN...) or hexadecimal (0xNNN...)\n");
+	fprintf(ofp, "    --function [object@](addr | symbol | symbol+offset)\n");
 	fprintf(ofp, "                           Dynamic function entry/return probe.\n");
-	fprintf(ofp, "                           Addr and offset can be octal (0NNN...),\n");
-	fprintf(ofp, "                           decimal (NNN...) or hexadecimal (0xNNN...)\n");
+	fprintf(ofp, "                           - userspace tracer requires specifying an object to instrument.\n");
+	fprintf(ofp, "                           - Addr and offset can be octal (0NNN...),\n");
+	fprintf(ofp, "                             decimal (NNN...) or hexadecimal (0xNNN...)\n");
 #if 0
 	fprintf(ofp, "    --function:entry symbol\n");
 	fprintf(ofp, "                           Function tracer event\n");
@@ -260,6 +262,58 @@ end:
 }
 
 /*
+ * Parse user-space probe options.
+ */
+static int parse_ust_probe_opts(struct lttng_event *ev, char *opt)
+{
+	char *pos;
+	int ret;
+
+	if (opt == NULL) {
+		ret = -1;
+		goto end;
+	}
+
+	/* Check for pathname */
+	/* TODO: support wildcard matching */
+	if ((pos = strrchr(opt, '@')) != NULL) {
+		struct lttng_event_target_attr *target;
+		char fullpath[PATH_MAX];
+		int path_len;
+
+		/* Process relative path */
+		if (opt[0] != '/') {
+			if (getcwd(fullpath, PATH_MAX) == NULL) {
+				goto error;
+			}
+			strncat(fullpath, "/", 1);
+			strncat(fullpath, opt, pos - opt);
+		} else {
+			strncpy(fullpath, opt, pos - opt);
+		}
+
+		path_len = strnlen(fullpath, PATH_MAX);
+		/* Include the tailing '\0' */
+		target = zmalloc(sizeof(struct lttng_event_target_attr) + path_len + 1);
+		target->path_len = path_len + 1;
+
+		strncpy(target->path, fullpath, path_len);
+		target->path[path_len] = '\0';
+		ev->target = target;
+		DBG("probe object %s", ev->target->path);
+		ret = parse_probe_opts(ev, pos+1);
+		goto end;
+	}
+
+error:
+	/* No match */
+	ret = -1;
+
+end:
+	return ret;
+}
+
+/*
  * Maps loglevel from string to value
  */
 static
@@ -556,7 +610,21 @@ static int enable_events(char *session_name)
 				ev.name[LTTNG_SYMBOL_NAME_LEN - 1] = '\0';
 				break;
 			case LTTNG_EVENT_PROBE:
+				ret = parse_ust_probe_opts(&ev, opt_probe);
+				if (ret < 0) {
+					ERR("Unable to parse probe options");
+					ret = 0;
+					goto error;
+				}
+				break;
 			case LTTNG_EVENT_FUNCTION:
+				ret = parse_ust_probe_opts(&ev, opt_function);
+				if (ret < 0) {
+					ERR("Unable to parse function probe options");
+					ret = 0;
+					goto error;
+				}
+				break;
 			case LTTNG_EVENT_FUNCTION_ENTRY:
 			case LTTNG_EVENT_SYSCALL:
 			default:
@@ -646,6 +714,10 @@ error:
 	}
 	lttng_destroy_handle(handle);
 
+	if (ev.target) {
+		free(ev.target);
+	}
+
 	return ret;
 }
 
diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index 1c7085d..52fb84d 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -240,6 +240,7 @@ static void print_events(struct lttng_event *event)
 			MSG("%soffset: 0x%" PRIx64, indent8, event->attr.probe.offset);
 			MSG("%ssymbol: %s", indent8, event->attr.probe.symbol_name);
 		}
+		/* TODO: add support to print instrument object path */
 		break;
 	case LTTNG_EVENT_PROBE:
 		MSG("%s%s (type: probe)%s%s", indent6,
@@ -251,6 +252,7 @@ static void print_events(struct lttng_event *event)
 			MSG("%soffset: 0x%" PRIx64, indent8, event->attr.probe.offset);
 			MSG("%ssymbol: %s", indent8, event->attr.probe.symbol_name);
 		}
+		/* TODO: add support to print instrument object path */
 		break;
 	case LTTNG_EVENT_FUNCTION_ENTRY:
 		MSG("%s%s (type: function)%s%s", indent6,
diff --git a/src/common/error.c b/src/common/error.c
index 42ed06f..d48e53a 100644
--- a/src/common/error.c
+++ b/src/common/error.c
@@ -112,6 +112,8 @@ static const char *error_string_array[] = {
 	[ ERROR_INDEX(LTTNG_ERR_SNAPSHOT_OUTPUT_EXIST) ] = "Snapshot output already exists",
 	[ ERROR_INDEX(LTTNG_ERR_START_SESSION_ONCE) ] = "Session needs to be started once",
 	[ ERROR_INDEX(LTTNG_ERR_SNAPSHOT_FAIL) ] = "Snapshot record failed",
+	[ ERROR_INDEX(LTTNG_ERR_TARGET_INVAL) ] = "Invalid instrument target",
+	[ ERROR_INDEX(LTTNG_ERR_TARGET_NOMEM) ] = "Not enough memory for instrument target",
 
 	/* Last element */
 	[ ERROR_INDEX(LTTNG_ERR_NR) ] = "Unknown error code"
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index c52a6ca..294e185 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -224,6 +224,8 @@ struct lttcomm_session_msg {
 			struct lttng_event event;
 			/* Length of following bytecode for filter. */
 			uint32_t bytecode_len;
+			/* Length of following instrument target. */
+			uint32_t target_len;
 		} LTTNG_PACKED enable;
 		/* Create channel */
 		struct {
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index daa4a73..695e9ee 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -699,6 +699,13 @@ int lttng_enable_event(struct lttng_handle *handle,
 	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
 			sizeof(lsm.session.name));
 
+	if (ev->target) {
+		lsm.u.enable.target_len = ev->target->path_len
+			+ sizeof(struct lttng_event_target_attr);
+		return lttng_ctl_ask_sessiond_varlen(&lsm, ev->target,
+					lsm.u.enable.target_len, NULL);
+	}
+
 	return lttng_ctl_ask_sessiond(&lsm, NULL);
 }
 
-- 
1.8.4
