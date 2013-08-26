From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [LTTNG-TOOLS PATCH 01/01] Added event exclusion
Date: Mon, 26 Aug 2013 12:52:39 +0000
Message-ID: <009B25148989C6458484484699278506E53869C5__14952.0629704513$1377521701$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VDwHn-0000eF-95
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 08:52:49 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

From fef5a576084bf261b4d297f2d11843ef6bdf305b Mon Sep 17 00:00:00 2001
From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Date: Thu, 22 Aug 2013 13:44:50 +0300
Subject: [PATCH] Added event exclusion

Added a new parameter to enable-event command. With this command,
you can exclude events from a wildcard specification.

For instance, running
lttng enable-event -u -a --exclude "met:*"
will enable all tracepoint events (-a) except the ones starting with
'met:'.

It is also possible to exclude events by prepending them with a '!'
character. That is, the previous command can also be given as
lttng enable-event -u "\!met:"
lttng enable-event -a
---
 src/bin/lttng/commands/enable_events.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index 36ee84f..b87c135 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -42,6 +42,7 @@ static char *opt_function;
 static char *opt_function_entry_symbol;
 static char *opt_channel_name;
 static char *opt_filter;
+static char *opt_exclude;
 #if 0
 /* Not implemented yet */
 static char *opt_cmd_name;
@@ -60,6 +61,7 @@ enum {
 	OPT_LOGLEVEL_ONLY,
 	OPT_LIST_OPTIONS,
 	OPT_FILTER,
+	OPT_EXCLUDE,
 };
 
 static struct lttng_handle *handle;
@@ -87,6 +89,7 @@ static struct poptOption long_options[] = {
 	{"loglevel-only",  0,     POPT_ARG_STRING, 0, OPT_LOGLEVEL_ONLY, 0, 0},
 	{"list-options", 0, POPT_ARG_NONE, NULL, OPT_LIST_OPTIONS, NULL, NULL},
 	{"filter",         'f', POPT_ARG_STRING, &opt_filter, OPT_FILTER, 0, 0},
+	{"exclude",        'x', POPT_ARG_STRING, &opt_exclude, OPT_EXCLUDE, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0}
 };
 
@@ -105,6 +108,11 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "  -a, --all                Enable all tracepoints and syscalls\n");
 	fprintf(ofp, "  -k, --kernel             Apply for the kernel tracer\n");
 	fprintf(ofp, "  -u, --userspace          Apply to the user-space tracer\n");
+	fprintf(ofp, "  -x, --exclude LIST       Add exceptions to UST tracepoints:\n");
+	fprintf(ofp, "                           - Events that match any of the items\n");
+	fprintf(ofp, "                             in the comma-separated LIST are\n");
+	fprintf(ofp, "                             not enabled, even if they match\n");
+	fprintf(ofp, "                             a wildcard definition of an event.\n");
 	fprintf(ofp, "\n");
 	fprintf(ofp, "Event options:\n");
 	fprintf(ofp, "    --tracepoint           Tracepoint event (default)\n");
@@ -333,6 +341,7 @@ static int enable_events(char *session_name)
 	char *event_name, *channel_name = NULL;
 	struct lttng_event ev;
 	struct lttng_domain dom;
+	char * exclude_name = NULL;
 
 	memset(&ev, 0, sizeof(ev));
 	memset(&dom, 0, sizeof(dom));
@@ -367,6 +376,35 @@ static int enable_events(char *session_name)
 		goto error;
 	}
 
+	/* handle exclusion options */
+	if (opt_exclude) {
+		exclude_name = strtok(opt_exclude, ",");
+		while (exclude_name != NULL) {
+			/* Copy name and type of the event */
+			/* prepend event name with '!' to indicate exclusion */
+			ev.name[0] = '!';
+			strncpy(ev.name + 1, exclude_name, LTTNG_SYMBOL_NAME_LEN - 1);
+			ev.name[LTTNG_SYMBOL_NAME_LEN - 1] = '\0';
+			ev.type = LTTNG_EVENT_TRACEPOINT;
+			ret = lttng_enable_event(handle, &ev, channel_name);
+			if (ret < 0) {
+				ERR("Event exclusion %s: %s (channel %s, session %s)", exclude_name,
+						lttng_strerror(ret),
+						ret == -LTTNG_ERR_NEED_CHANNEL_NAME
+							? print_raw_channel_name(channel_name)
+							: print_channel_name(channel_name),
+						session_name);
+			} else {
+				MSG("%s event %s excluded in channel %s",
+						opt_kernel ? "kernel": "UST", exclude_name,
+						print_channel_name(channel_name));
+			}
+
+			/* next exclusion event */
+			exclude_name = strtok(NULL, ",");
+		}
+	}
+
 	if (opt_enable_all) {
 		/* Default setup for enable all */
 		if (opt_kernel) {
@@ -701,6 +739,10 @@ int cmd_enable_events(int argc, const char **argv)
 			goto end;
 		case OPT_FILTER:
 			break;
+		case OPT_EXCLUDE:
+			opt_exclude = poptGetOptArg(pc);
+			break;
+			
 		default:
 			usage(stderr);
 			ret = CMD_UNDEFINED;
-- 
1.8.1.2
