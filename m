From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 1/4 v2] Fix: disable kernel event
	based on name and event type
Date: Mon, 21 Sep 2015 18:43:54 -0400
Message-ID: <1442875437-15639-1-git-send-email-jonathan.rajotte-julien__5094.32274052433$1442875635$gmane$org@efficios.com>
References: <CA+jJMxvMk+jb3nNMv9fk=-REKGT2XC4KtihyDR7xCH7_S86h4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1Ze9oh-0003cF-Hw
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 18:44:20 -0400
In-Reply-To: <CA+jJMxvMk+jb3nNMv9fk=-REKGT2XC4KtihyDR7xCH7_S86h4w@mail.gmail.com>
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

The -a argument is interpreted as a zero-length event name
instead of '*' which is actually a valid wildcard event
name by itself. This simplify how a disable action is handled.

The event type can now be passed as argument
and is a new criteria while disabling kernel events.
The default is to disable for all event type.

UST and agent domain do not support yet disabling by event
type.

e.g:
	# Only disable kernel event of type tracepoint.
	lttng disable -a -k --tracepoint

	# Only disable the event with name '*' and type syscall.
	lttng disable -k '*' --syscall

	# Disable all kernel event of all type.
	lttng disable -a -k

Fixes #925

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/cmd.c            | 28 ++++------
 src/bin/lttng-sessiond/event.c          | 66 +++++++----------------
 src/bin/lttng-sessiond/event.h          |  5 +-
 src/bin/lttng/commands/disable_events.c | 94 +++++++++++++++++++++++++--------
 src/lib/lttng-ctl/lttng-ctl.c           |  4 --
 5 files changed, 101 insertions(+), 96 deletions(-)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 7878a05..0daeb9e 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -1225,32 +1225,22 @@ int cmd_disable_event(struct ltt_session *session,
 
 		switch (event->type) {
 		case LTTNG_EVENT_ALL:
-			ret = event_kernel_disable_event_all(kchan);
-			if (ret != LTTNG_OK) {
-				goto error_unlock;
-			}
-			break;
-		case LTTNG_EVENT_TRACEPOINT:	/* fall-through */
+		case LTTNG_EVENT_TRACEPOINT:
 		case LTTNG_EVENT_SYSCALL:
-			if (!strcmp(event_name, "*")) {
-				ret = event_kernel_disable_event_type(kchan,
-					event->type);
+		case LTTNG_EVENT_PROBE:
+		case LTTNG_EVENT_FUNCTION:
+		case LTTNG_EVENT_FUNCTION_ENTRY:/* fall-through */
+			if (event_name[0] == '\0') {
+				ret = event_kernel_disable_event(kchan,
+					NULL, event->type);
 			} else {
 				ret = event_kernel_disable_event(kchan,
-					event_name);
+					event_name, event->type);
 			}
 			if (ret != LTTNG_OK) {
 				goto error_unlock;
 			}
 			break;
-		case LTTNG_EVENT_PROBE:
-		case LTTNG_EVENT_FUNCTION:
-		case LTTNG_EVENT_FUNCTION_ENTRY:
-			ret = event_kernel_disable_event(kchan, event_name);
-			if (ret != LTTNG_OK) {
-				goto error_unlock;
-			}
-			break;
 		default:
 			ret = LTTNG_ERR_UNK;
 			goto error_unlock;
@@ -1273,7 +1263,7 @@ int cmd_disable_event(struct ltt_session *session,
 
 		/*
 		 * If a non-default channel has been created in the
-		 * session, explicitely require that -c chan_name needs
+		 * session, explicitly require that -c chan_name needs
 		 * to be provided.
 		 */
 		if (usess->has_non_default_channel && channel_name[0] == '\0') {
diff --git a/src/bin/lttng-sessiond/event.c b/src/bin/lttng-sessiond/event.c
index 13f09a5..447b872 100644
--- a/src/bin/lttng-sessiond/event.c
+++ b/src/bin/lttng-sessiond/event.c
@@ -61,45 +61,15 @@ static void add_unique_ust_event(struct lttng_ht *ht,
 }
 
 /*
- * Disable kernel tracepoint event for a channel from the kernel session.
+ * Disable kernel tracepoint events for a channel from the kernel session of
+ * a specified event_name and event type.
+ * On type LTTNG_EVENT_ALL all events with event_name are disabled.
+ * If event_name is NULL all events of the specified type are disabled.
  */
 int event_kernel_disable_event(struct ltt_kernel_channel *kchan,
-		char *event_name)
+		char *event_name, enum lttng_event_type type)
 {
-	int ret;
-	struct ltt_kernel_event *kevent;
-
-	assert(kchan);
-
-	kevent = trace_kernel_get_event_by_name(event_name, kchan,
-			LTTNG_EVENT_ALL);
-	if (kevent == NULL) {
-		ret = LTTNG_ERR_NO_EVENT;
-		goto error;
-	}
-
-	ret = kernel_disable_event(kevent);
-	if (ret < 0) {
-		ret = LTTNG_ERR_KERN_DISABLE_FAIL;
-		goto error;
-	}
-
-	DBG("Kernel event %s disable for channel %s.",
-			kevent->event->name, kchan->channel->name);
-
-	ret = LTTNG_OK;
-
-error:
-	return ret;
-}
-
-/*
- * Disable kernel tracepoint events for a channel from the kernel session.
- */
-int event_kernel_disable_event_type(struct ltt_kernel_channel *kchan,
-		enum lttng_event_type type)
-{
-	int ret;
+	int ret, error = 0, found = 0;
 	struct ltt_kernel_event *kevent;
 
 	assert(kchan);
@@ -108,22 +78,26 @@ int event_kernel_disable_event_type(struct ltt_kernel_channel *kchan,
 	cds_list_for_each_entry(kevent, &kchan->events_list.head, list) {
 		if (type != LTTNG_EVENT_ALL && kevent->type != type)
 			continue;
+		if (event_name != NULL && strcmp(event_name, kevent->event->name)) {
+			continue;
+		}
+		found++;
 		ret = kernel_disable_event(kevent);
 		if (ret < 0) {
-			/* We continue disabling the rest */
+			error = 1;
 			continue;
 		}
 	}
-	ret = LTTNG_OK;
-	return ret;
-}
+	DBG("Disable kernel event: found %d events with name: %s and type: %d",
+			found, event_name ? event_name : "NULL", type);
 
-/*
- * Disable all kernel event for a channel from the kernel session.
- */
-int event_kernel_disable_event_all(struct ltt_kernel_channel *kchan)
-{
-	return event_kernel_disable_event_type(kchan, LTTNG_EVENT_ALL);
+	if (event_name != NULL && !found) {
+		ret = LTTNG_ERR_NO_EVENT;
+	} else {
+		ret = error ? LTTNG_ERR_KERN_DISABLE_FAIL : LTTNG_OK;
+	}
+
+	return ret;
 }
 
 /*
diff --git a/src/bin/lttng-sessiond/event.h b/src/bin/lttng-sessiond/event.h
index 7c5231d..45dd1fc 100644
--- a/src/bin/lttng-sessiond/event.h
+++ b/src/bin/lttng-sessiond/event.h
@@ -23,10 +23,7 @@
 struct agent;
 
 int event_kernel_disable_event(struct ltt_kernel_channel *kchan,
-		char *event_name);
-int event_kernel_disable_event_type(struct ltt_kernel_channel *kchan,
-		enum lttng_event_type type);
-int event_kernel_disable_event_all(struct ltt_kernel_channel *kchan);
+		char *event_name, enum lttng_event_type event_type);
 
 int event_kernel_enable_event(struct ltt_kernel_channel *kchan,
 		struct lttng_event *event, char *filter_expression,
diff --git a/src/bin/lttng/commands/disable_events.c b/src/bin/lttng/commands/disable_events.c
index c6ec85f..440d107 100644
--- a/src/bin/lttng/commands/disable_events.c
+++ b/src/bin/lttng/commands/disable_events.c
@@ -43,8 +43,11 @@ static int opt_event_type;
 
 enum {
 	OPT_HELP = 1,
-	OPT_USERSPACE,
-	OPT_SYSCALL,
+	OPT_TYPE_SYSCALL,
+	OPT_TYPE_TRACEPOINT,
+	OPT_TYPE_PROBE,
+	OPT_TYPE_FUNCTION,
+	OPT_TYPE_ALL,
 	OPT_LIST_OPTIONS,
 };
 
@@ -61,8 +64,12 @@ static struct poptOption long_options[] = {
 	{"log4j",          'l', POPT_ARG_VAL, &opt_log4j, 1, 0, 0},
 	{"python",         'p', POPT_ARG_VAL, &opt_python, 1, 0, 0},
 	{"kernel",         'k', POPT_ARG_VAL, &opt_kernel, 1, 0, 0},
-	{"syscall",        0,   POPT_ARG_NONE, 0, OPT_SYSCALL, 0, 0},
-	{"userspace",      'u', POPT_ARG_NONE, 0, OPT_USERSPACE, 0, 0},
+	{"userspace",      'u', POPT_ARG_VAL, &opt_userspace, 1, 0, 0},
+	{"syscall",          0, POPT_ARG_NONE, 0, OPT_TYPE_SYSCALL, 0, 0},
+	{"probe",            0, POPT_ARG_NONE, 0, OPT_TYPE_PROBE, 0, 0},
+	{"tracepoint",       0, POPT_ARG_NONE, 0, OPT_TYPE_TRACEPOINT, 0, 0},
+	{"function",         0, POPT_ARG_NONE, 0, OPT_TYPE_FUNCTION, 0, 0},
+	{"all",              0, POPT_ARG_NONE, 0, OPT_TYPE_ALL, 0, 0},
 	{"list-options", 0, POPT_ARG_NONE, NULL, OPT_LIST_OPTIONS, NULL, NULL},
 	{0, 0, 0, 0, 0, 0, 0}
 };
@@ -86,8 +93,12 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "  -l, --log4j              Apply to Java application using LOG4j\n");
 	fprintf(ofp, "  -p, --python             Apply to Python application using logging\n");
 	fprintf(ofp, "\n");
-	fprintf(ofp, "Event options:\n");
+	fprintf(ofp, "Event type options (Only supported with kernel domain):\n");
+	fprintf(ofp, "      --all                All event types (default)\n");
+	fprintf(ofp, "      --tracepoint         Tracepoint event\n");
 	fprintf(ofp, "      --syscall            System call event\n");
+	fprintf(ofp, "      --probe              Probe event\n");
+	fprintf(ofp, "      --function           Function event\n");
 	fprintf(ofp, "\n");
 }
 
@@ -103,6 +114,27 @@ const char *print_raw_channel_name(const char *name)
 	return name ? : "<default>";
 }
 
+static
+const char *print_event_type(const enum lttng_event_type ev_type)
+{
+	switch (ev_type) {
+	case LTTNG_EVENT_ALL:
+		return "any";
+	case LTTNG_EVENT_TRACEPOINT:
+		return "tracepoint";
+	case LTTNG_EVENT_PROBE:
+		return "probe";
+	case LTTNG_EVENT_FUNCTION:
+		return "function";
+	case LTTNG_EVENT_FUNCTION_ENTRY:
+		return "function entry";
+	case LTTNG_EVENT_SYSCALL:
+		return "syscall";
+	default:
+		return "";
+	}
+}
+
 /* Mi print a partial event.
  * enabled is 0 or 1
  * success is 0 or 1
@@ -213,14 +245,8 @@ static int disable_events(char *session_name)
 	/* Set default loglevel to any/unknown */
 	event.loglevel = -1;
 
-	switch (opt_event_type) {
-	case LTTNG_EVENT_SYSCALL:
-		event.type = LTTNG_EVENT_SYSCALL;
-		break;
-	default:
-		event.type = LTTNG_EVENT_ALL;
-		break;
-	}
+	/* opt_event_type contain the event type to disable at this point */
+	event.type = opt_event_type;
 
 	if (opt_disable_all) {
 		command_ret = lttng_disable_event_ext(handle, &event, channel_name, NULL);
@@ -232,9 +258,9 @@ static int disable_events(char *session_name)
 		} else {
 			enabled = 0;
 			success = 1;
-			MSG("All %s %s are disabled in channel %s",
+			MSG("All %s events of type %s are disabled in channel %s",
 					get_domain_str(dom.type),
-					opt_event_type == LTTNG_EVENT_SYSCALL ? "system calls" : "events",
+					print_event_type(opt_event_type),
 					print_channel_name(channel_name));
 		}
 
@@ -255,9 +281,9 @@ static int disable_events(char *session_name)
 			event.name[sizeof(event.name) - 1] = '\0';
 			command_ret = lttng_disable_event_ext(handle, &event, channel_name, NULL);
 			if (command_ret < 0) {
-				ERR("%s %s: %s (channel %s, session %s)",
-						opt_event_type == LTTNG_EVENT_SYSCALL ? "System call" : "Event",
+				ERR("%s of type %s : %s (channel %s, session %s)",
 						event_name,
+						print_event_type(opt_event_type),
 						lttng_strerror(command_ret),
 						command_ret == -LTTNG_ERR_NEED_CHANNEL_NAME
 							? print_raw_channel_name(channel_name)
@@ -271,10 +297,10 @@ static int disable_events(char *session_name)
 				 */
 				enabled = 1;
 			} else {
-				MSG("%s %s %s disabled in channel %s for session %s",
+				MSG("%s %s of type %s disabled in channel %s for session %s",
 						get_domain_str(dom.type),
-						opt_event_type == LTTNG_EVENT_SYSCALL ? "system call" : "event",
 						event_name,
+						print_event_type(opt_event_type),
 						print_channel_name(channel_name),
 						session_name);
 				success = 1;
@@ -338,12 +364,21 @@ int cmd_disable_events(int argc, const char **argv)
 		case OPT_HELP:
 			usage(stdout);
 			goto end;
-		case OPT_USERSPACE:
-			opt_userspace = 1;
-			break;
-		case OPT_SYSCALL:
+		case OPT_TYPE_SYSCALL:
 			opt_event_type = LTTNG_EVENT_SYSCALL;
 			break;
+		case OPT_TYPE_TRACEPOINT:
+			opt_event_type = LTTNG_EVENT_TRACEPOINT;
+			break;
+		case OPT_TYPE_PROBE:
+			opt_event_type = LTTNG_EVENT_PROBE;
+			break;
+		case OPT_TYPE_FUNCTION:
+			opt_event_type = LTTNG_EVENT_FUNCTION;
+			break;
+		case OPT_TYPE_ALL:
+			opt_event_type = LTTNG_EVENT_ALL;
+			break;
 		case OPT_LIST_OPTIONS:
 			list_cmd_options(stdout, long_options);
 			goto end;
@@ -372,6 +407,19 @@ int cmd_disable_events(int argc, const char **argv)
 		goto end;
 	}
 
+	/* Ust and agent only support ALL event type */
+	if ((opt_userspace || opt_jul || opt_log4j || opt_python)
+			&& opt_event_type != LTTNG_EVENT_ALL) {
+		ERR("UST and agent (-j | -l | -p) event(s) disabling based on event type is not supported.\n");
+		usage(stderr);
+		ret = CMD_ERROR;
+		goto end;
+	}
+
+	if (opt) {
+		/* code */
+	}
+
 	opt_event_list = (char*) poptGetArg(pc);
 	if (opt_event_list == NULL && opt_disable_all == 0) {
 		ERR("Missing event name(s).\n");
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 9cbfef5..1007326 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -1091,10 +1091,6 @@ int lttng_disable_event_ext(struct lttng_handle *handle,
 	}
 
 	lsm.cmd_type = LTTNG_DISABLE_EVENT;
-	if (ev->name[0] == '\0') {
-		/* Disable all events */
-		lttng_ctl_copy_string(ev->name, "*", sizeof(ev->name));
-	}
 
 	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
 	/* FIXME: copying non-packed struct to packed struct. */
-- 
2.1.4
