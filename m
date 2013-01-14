From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [lttng-tools PATCH] Add support for kernel uprobes
Date: Sun, 13 Jan 2013 22:03:37 -0500
Message-ID: <1358132617-18443-1-git-send-email-yannick.brosseau__49825.1398130835$1358132668$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1TuaKy-0001cf-QZ
	for lttng-dev@lists.lttng.org; Sun, 13 Jan 2013 22:03:48 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so4456714iea.22
	for <lttng-dev@lists.lttng.org>; Sun, 13 Jan 2013 19:03:43 -0800 (PST)
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

Inspired by the k*probe support.

It add a new option to enable-event --uprobe which require a path name
and an offset in the specified file.

(The file Documentation/trace/uprobetracer.txt in the kernel source provides
and example on how to extract the offset for a symbol in a program)

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 include/lttng/lttng.h                  |   15 +++++++++
 src/bin/lttng-sessiond/cmd.c           |    5 +++
 src/bin/lttng-sessiond/modprobe.c      |    1 +
 src/bin/lttng-sessiond/trace-kernel.c  |    7 ++++
 src/bin/lttng/commands/enable_events.c |   55 ++++++++++++++++++++++++++++++++
 src/bin/lttng/commands/list.c          |    8 +++++
 src/common/lttng-kernel.h              |    7 ++++
 7 files changed, 98 insertions(+)

diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
index e21b479..c790e7b 100644
--- a/include/lttng/lttng.h
+++ b/include/lttng/lttng.h
@@ -72,6 +72,7 @@ enum lttng_event_type {
 	LTTNG_EVENT_FUNCTION_ENTRY            = 3,
 	LTTNG_EVENT_NOOP                      = 4,
 	LTTNG_EVENT_SYSCALL                   = 5,
+	LTTNG_EVENT_UPROBE                    = 6,
 };
 
 /*
@@ -219,6 +220,19 @@ struct lttng_event_function_attr {
 };
 
 /*
+ * Event uprobe.
+ *
+ * The structures should be initialized to zero before use.
+ */
+#define LTTNG_EVENT_UPROBE_PADDING1         24
+struct lttng_event_uprobe_attr {
+	char path[LTTNG_SYMBOL_NAME_LEN];
+	uint64_t offset;
+
+	char padding[LTTNG_EVENT_UPROBE_PADDING1];
+};
+
+/*
  * Generic lttng event
  *
  * The structures should be initialized to zero before use.
@@ -242,6 +256,7 @@ struct lttng_event {
 	union {
 		struct lttng_event_probe_attr probe;
 		struct lttng_event_function_attr ftrace;
+		struct lttng_event_uprobe_attr uprobe;
 
 		char padding[LTTNG_EVENT_PADDING2];
 	} attr;
diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 491acde..d7fee70 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -315,6 +315,11 @@ static int list_lttng_kernel_events(char *channel_name,
 			memcpy(&((*events)[i].attr.ftrace), &event->event->u.ftrace,
 					sizeof(struct lttng_kernel_function));
 			break;
+		case LTTNG_KERNEL_UPROBE:
+			(*events)[i].type = LTTNG_EVENT_UPROBE;
+			memcpy(&(*events)[i].attr.uprobe, &event->event->u.uprobe,
+					sizeof(struct lttng_kernel_uprobe));
+			break;
 		case LTTNG_KERNEL_NOOP:
 			(*events)[i].type = LTTNG_EVENT_NOOP;
 			break;
diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 1a5a1b7..805e127 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -35,6 +35,7 @@ const struct kern_modules_param kern_modules_list[] = {
 	{ "lttng-ftrace", 0 },
 	{ "lttng-kprobes", 0 },
 	{ "lttng-kretprobes", 0 },
+	{ "lttng-uprobes", 0 },
 	{ "lttng-lib-ring-buffer", 1 },
 	{ "lttng-ring-buffer-client-discard", 1 },
 	{ "lttng-ring-buffer-client-overwrite", 1 },
diff --git a/src/bin/lttng-sessiond/trace-kernel.c b/src/bin/lttng-sessiond/trace-kernel.c
index f38cf3d..24f33f9 100644
--- a/src/bin/lttng-sessiond/trace-kernel.c
+++ b/src/bin/lttng-sessiond/trace-kernel.c
@@ -207,6 +207,13 @@ struct ltt_kernel_event *trace_kernel_create_event(struct lttng_event *ev)
 				ev->attr.probe.symbol_name, LTTNG_KERNEL_SYM_NAME_LEN);
 		attr->u.kprobe.symbol_name[LTTNG_KERNEL_SYM_NAME_LEN - 1] = '\0';
 		break;
+	case LTTNG_EVENT_UPROBE:
+		attr->instrumentation = LTTNG_KERNEL_UPROBE;
+		attr->u.uprobe.offset = ev->attr.uprobe.offset;
+		strncpy(attr->u.uprobe.path,
+				ev->attr.uprobe.path, LTTNG_KERNEL_SYM_NAME_LEN);
+		attr->u.uprobe.path[LTTNG_KERNEL_SYM_NAME_LEN - 1] = '\0';
+		break;
 	case LTTNG_EVENT_FUNCTION:
 		attr->instrumentation = LTTNG_KERNEL_KRETPROBE;
 		attr->u.kretprobe.addr = ev->attr.probe.addr;
diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index b6c18e1..61cb15b 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -38,6 +38,7 @@ static char *opt_session_name;
 static int opt_userspace;
 static int opt_enable_all;
 static char *opt_probe;
+static char *opt_uprobe;
 static char *opt_function;
 static char *opt_function_entry_symbol;
 static char *opt_channel_name;
@@ -52,6 +53,7 @@ enum {
 	OPT_HELP = 1,
 	OPT_TRACEPOINT,
 	OPT_PROBE,
+	OPT_UPROBE,
 	OPT_FUNCTION,
 	OPT_FUNCTION_ENTRY,
 	OPT_SYSCALL,
@@ -74,6 +76,7 @@ static struct poptOption long_options[] = {
 	{"userspace",      'u', POPT_ARG_NONE, 0, OPT_USERSPACE, 0, 0},
 	{"tracepoint",     0,   POPT_ARG_NONE, 0, OPT_TRACEPOINT, 0, 0},
 	{"probe",          0,   POPT_ARG_STRING, &opt_probe, OPT_PROBE, 0, 0},
+	{"uprobe",          0,   POPT_ARG_STRING, &opt_uprobe, OPT_UPROBE, 0, 0},
 	{"function",       0,   POPT_ARG_STRING, &opt_function, OPT_FUNCTION, 0, 0},
 #if 0
 	/*
@@ -117,6 +120,10 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "                           Dynamic probe.\n");
 	fprintf(ofp, "                           Addr and offset can be octal (0NNN...),\n");
 	fprintf(ofp, "                           decimal (NNN...) or hexadecimal (0xNNN...)\n");
+	fprintf(ofp, "    --uprobe [path+offset]\n");
+	fprintf(ofp, "                           Dynamic uprobe.\n");
+	fprintf(ofp, "                           offset can be octal (0NNN...),\n");
+	fprintf(ofp, "                           decimal (NNN...) or hexadecimal (0xNNN...)\n");
 	fprintf(ofp, "    --function [addr | symbol | symbol+offset]\n");
 	fprintf(ofp, "                           Dynamic function entry/return probe.\n");
 	fprintf(ofp, "                           Addr and offset can be octal (0NNN...),\n");
@@ -245,6 +252,42 @@ static int parse_probe_opts(struct lttng_event *ev, char *opt)
 end:
 	return ret;
 }
+/*
+ * Parse uprobe options.
+ */
+static int parse_uprobe_opts(struct lttng_event *ev, char *opt)
+{
+	int ret;
+	char s_hex[19];
+	char name[LTTNG_SYMBOL_NAME_LEN];
+
+	if (opt == NULL) {
+		ret = -1;
+		goto end;
+	}
+
+	/* Check for path+offset */
+	ret = sscanf(opt, "%[^'+']+%s", name, s_hex);
+	if (ret == 2) {
+		strncpy(ev->attr.uprobe.path, name, LTTNG_SYMBOL_NAME_LEN);
+		ev->attr.uprobe.path[LTTNG_SYMBOL_NAME_LEN - 1] = '\0';
+		DBG("probe path %s", ev->attr.uprobe.path);
+		if (strlen(s_hex) == 0) {
+			ERR("Invalid uprobe offset %s", s_hex);
+			ret = -1;
+			goto end;
+		}
+		ev->attr.uprobe.offset = strtoul(s_hex, NULL, 0);
+		DBG("uprobe offset %" PRIu64, ev->attr.uprobe.offset);
+		goto end;
+	}
+
+	/* No match */
+	ret = -1;
+
+end:
+	return ret;
+}
 
 /*
  * Maps loglevel from string to value
@@ -471,6 +514,14 @@ static int enable_events(char *session_name)
 					goto error;
 				}
 				break;
+			case LTTNG_EVENT_UPROBE:
+				ret = parse_uprobe_opts(&ev, opt_uprobe);
+				if (ret < 0) {
+					ERR("Unable to parse uprobe options");
+					ret = 0;
+					goto error;
+				}
+				break;
 			case LTTNG_EVENT_FUNCTION:
 				ret = parse_probe_opts(&ev, opt_function);
 				if (ret < 0) {
@@ -522,6 +573,7 @@ static int enable_events(char *session_name)
 				ev.name[LTTNG_SYMBOL_NAME_LEN - 1] = '\0';
 				break;
 			case LTTNG_EVENT_PROBE:
+			case LTTNG_EVENT_UPROBE:
 			case LTTNG_EVENT_FUNCTION:
 			case LTTNG_EVENT_FUNCTION_ENTRY:
 			case LTTNG_EVENT_SYSCALL:
@@ -636,6 +688,9 @@ int cmd_enable_events(int argc, const char **argv)
 		case OPT_PROBE:
 			opt_event_type = LTTNG_EVENT_PROBE;
 			break;
+		case OPT_UPROBE:
+			opt_event_type = LTTNG_EVENT_UPROBE;
+			break;
 		case OPT_FUNCTION:
 			opt_event_type = LTTNG_EVENT_FUNCTION;
 			break;
diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index a6ea6b8..ffae239 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -231,6 +231,14 @@ static void print_events(struct lttng_event *event)
 			MSG("%ssymbol: %s", indent8, event->attr.probe.symbol_name);
 		}
 		break;
+	case LTTNG_EVENT_UPROBE:
+		MSG("%s%s (type: uprobe)%s%s", indent6,
+				event->name, enabled_string(event->enabled),
+				filter_string(event->filter));
+
+		MSG("%spath: %s", indent8, event->attr.uprobe.path);
+		MSG("%soffset: 0x%" PRIx64, indent8, event->attr.uprobe.offset);
+		break;
 	case LTTNG_EVENT_FUNCTION:
 	case LTTNG_EVENT_FUNCTION_ENTRY:
 		MSG("%s%s (type: function)%s%s", indent6,
diff --git a/src/common/lttng-kernel.h b/src/common/lttng-kernel.h
index fa8ba61..a43b956 100644
--- a/src/common/lttng-kernel.h
+++ b/src/common/lttng-kernel.h
@@ -38,6 +38,7 @@ enum lttng_kernel_instrumentation {
 	LTTNG_KERNEL_KRETPROBE     = 3,
 	LTTNG_KERNEL_NOOP          = 4,    /* not hooked */
 	LTTNG_KERNEL_SYSCALL       = 5,
+	LTTNG_KERNEL_UPROBE        = 6,
 };
 
 enum lttng_kernel_context_type {
@@ -96,6 +97,11 @@ struct lttng_kernel_function {
 	char symbol_name[LTTNG_KERNEL_SYM_NAME_LEN];
 }__attribute__((packed));
 
+struct lttng_kernel_uprobe {
+	char path[LTTNG_KERNEL_SYM_NAME_LEN];
+	uint64_t offset;
+}__attribute__((packed));
+
 #define LTTNG_KERNEL_EVENT_PADDING1    16
 #define LTTNG_KERNEL_EVENT_PADDING2    LTTNG_KERNEL_SYM_NAME_LEN + 32
 struct lttng_kernel_event {
@@ -108,6 +114,7 @@ struct lttng_kernel_event {
 		struct lttng_kernel_kretprobe kretprobe;
 		struct lttng_kernel_kprobe kprobe;
 		struct lttng_kernel_function ftrace;
+		struct lttng_kernel_uprobe uprobe;
 		char padding[LTTNG_KERNEL_EVENT_PADDING2];
 	} u;
 }__attribute__((packed));
-- 
1.7.10.4
