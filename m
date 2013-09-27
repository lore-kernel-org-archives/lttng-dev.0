From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 2/3] Add --exclude option to
	enable-event
Date: Fri, 27 Sep 2013 07:14:44 +0000
Message-ID: <009B25148989C6458484484699278506E538A677__39752.3868982264$1380266193$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VPSGM-0002Km-Kh
	for lttng-dev@lists.lttng.org; Fri, 27 Sep 2013 03:14:57 -0400
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
List-Id: lttng-dev@lists.lttng.org

Add exclusions to wildcarded events.
---
 src/bin/lttng/commands/enable_events.c | 207 +++++++++++++++++++++++++++++----
 1 file changed, 186 insertions(+), 21 deletions(-)

diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index 36ee84f..f30ff80 100644
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
 
@@ -189,6 +192,11 @@ static void usage(FILE *ofp)
 	fprintf(ofp, "                           '$ctx.procname == \"demo*\"'\n");
 	fprintf(ofp, "                           '$ctx.vpid >= 4433 && $ctx.vpid < 4455'\n");
 	fprintf(ofp, "                           '$ctx.vtid == 1234'\n");
+	fprintf(ofp, "  -x, --exclude LIST       Add exceptions to UST tracepoints:\n");
+	fprintf(ofp, "                           Events that match any of the items\n");
+	fprintf(ofp, "                           in the comma-separated LIST are\n");
+	fprintf(ofp, "                           not enabled, even if they match\n");
+	fprintf(ofp, "                           a wildcard definition of the event,\n");
 	fprintf(ofp, "\n");
 }
 
@@ -325,6 +333,79 @@ const char *print_raw_channel_name(const char *name)
 }
 
 /*
+ * Return a combined name of event_name+legal exclusions
+ * or NULL
+*/
+static
+char * check_exclusion_subsets(const char *event_name,
+		const char *exclusions)
+{
+	const char * excluder_ptr;
+	const char * event_ptr;
+	const char * next_excluder;
+	const char * excluder_name;
+	char * combined_name;
+	int excluder_length;
+	int excluder_added;
+
+	combined_name = malloc(strlen(event_name) + strlen(exclusions) + 1);
+	excluder_added = 0;
+
+	if (event_name[strlen(event_name) - 1] != '*') {
+		ERR("Event %s: Excluders can only be used with wildcarded events", event_name);
+		goto error;
+	}
+
+	strcpy(combined_name, event_name);
+
+	next_excluder = exclusions;
+	while (*next_excluder != 0) {
+		excluder_ptr = next_excluder;
+		event_ptr = event_name;
+		excluder_name = next_excluder;
+
+		excluder_length = strcspn(next_excluder, ",");
+		next_excluder += excluder_length;
+		if (*next_excluder == ',')
+			next_excluder++;
+
+		while(1) {
+			char e, x;
+			x = *excluder_ptr;
+			e = *event_ptr;
+			if (x == '*') {
+				/* ERR  excluder excludes all events */
+				ERR("Event %s: %.*s excludes all events from %s",
+						event_name, excluder_length, excluder_name, event_name);
+				goto error;
+				break;
+			}
+			if (e == '*') {
+				/* good, go to next */
+				if (excluder_added == 1)
+					strcat(combined_name, ",");
+				excluder_added = 1;
+				strncat(combined_name, excluder_name, excluder_length);
+				break;
+			}
+			if (x != e) {
+				/* WARN  excluder is not part of event */
+				WARN("Event %s: %.*s does not exclude any events from %s",
+					event_name, excluder_length, excluder_name, event_name);
+				break;
+			}
+			excluder_ptr++;
+			event_ptr++;
+		}
+	}
+	goto end;
+error:
+	free(combined_name);
+	combined_name = NULL;
+end:
+	return combined_name;
+}
+/*
  * Enabling event using the lttng API.
  */
 static int enable_events(char *session_name)
@@ -343,6 +424,11 @@ static int enable_events(char *session_name)
 			ret = CMD_ERROR;
 			goto error;
 		}
+		if (opt_exclude) {
+			ERR("Event name exclusions implemented for userspace tracepoint events only");
+			ret = CMD_ERROR;
+			goto error;
+		}
 	}
 
 	/* Create lttng domain */
@@ -377,6 +463,17 @@ static int enable_events(char *session_name)
 		} else {
 			ev.type = LTTNG_EVENT_TRACEPOINT;
 			strcpy(ev.name, "*");
+			if (opt_exclude) {
+				char * name_with_exclusions;
+				name_with_exclusions = check_exclusion_subsets("*", opt_exclude);
+				if (name_with_exclusions == NULL) {
+					ret = CMD_ERROR;
+					goto error;
+				} else {
+					strcpy(ev.name, name_with_exclusions);
+					free(name_with_exclusions);
+				}
+			}
 			ev.loglevel_type = opt_loglevel_type;
 			if (opt_loglevel) {
 				ev.loglevel = loglevel_str_to_value(opt_loglevel);
@@ -413,15 +510,29 @@ static int enable_events(char *session_name)
 			switch (opt_event_type) {
 			case LTTNG_EVENT_TRACEPOINT:
 				if (opt_loglevel) {
-					MSG("All %s tracepoints are enabled in channel %s for loglevel %s",
-							opt_kernel ? "kernel" : "UST",
-							print_channel_name(channel_name),
-							opt_loglevel);
+					if (opt_exclude) {
+						MSG("All %s tracepoints excluding %s are enabled in channel %s for loglevel %s",
+								opt_kernel ? "kernel" : "UST",
+								opt_exclude,
+								print_channel_name(channel_name),
+								opt_loglevel);
+					} else {
+						MSG("All %s tracepoints are enabled in channel %s for loglevel %s",
+								opt_kernel ? "kernel" : "UST",
+								print_channel_name(channel_name),
+								opt_loglevel);
+					}
 				} else {
-					MSG("All %s tracepoints are enabled in channel %s",
-							opt_kernel ? "kernel" : "UST",
-							print_channel_name(channel_name));
-
+					if (opt_exclude) {
+						MSG("All %s tracepoints excluding %s are enabled in channel %s",
+								opt_kernel ? "kernel" : "UST",
+								opt_exclude,
+								print_channel_name(channel_name));
+					} else {
+						MSG("All %s tracepoints are enabled in channel %s",
+								opt_kernel ? "kernel" : "UST",
+								print_channel_name(channel_name));
+					}
 				}
 				break;
 			case LTTNG_EVENT_SYSCALL:
@@ -432,14 +543,29 @@ static int enable_events(char *session_name)
 				break;
 			case LTTNG_EVENT_ALL:
 				if (opt_loglevel) {
-					MSG("All %s events are enabled in channel %s for loglevel %s",
-							opt_kernel ? "kernel" : "UST",
-							print_channel_name(channel_name),
-							opt_loglevel);
+					if (opt_exclude) {
+						MSG("All %s events excluding %s are enabled in channel %s for loglevel %s",
+								opt_kernel ? "kernel" : "UST",
+								opt_exclude,
+								print_channel_name(channel_name),
+								opt_loglevel);
+					} else {
+						MSG("All %s events are enabled in channel %s for loglevel %s",
+								opt_kernel ? "kernel" : "UST",
+								print_channel_name(channel_name),
+								opt_loglevel);
+					}
 				} else {
-					MSG("All %s events are enabled in channel %s",
-							opt_kernel ? "kernel" : "UST",
-							print_channel_name(channel_name));
+					if (opt_exclude) {
+						MSG("All %s events excluding %s are enabled in channel %s",
+								opt_kernel ? "kernel" : "UST",
+								opt_exclude,
+								print_channel_name(channel_name));
+					} else {
+						MSG("All %s events are enabled in channel %s",
+								opt_kernel ? "kernel" : "UST",
+								print_channel_name(channel_name));
+					}
 				}
 				break;
 			default:
@@ -542,10 +668,14 @@ static int enable_events(char *session_name)
 				goto error;
 			}
 #endif
-
-			DBG("Enabling UST event %s for channel %s, loglevel %s", event_name,
+			if (opt_exclude) {
+				DBG("Enabling UST event %s excluding %s for channel %s, loglevel %s",
+					event_name, opt_exclude, print_channel_name(channel_name),
+					opt_loglevel ? : "<all>");
+			} else {
+				DBG("Enabling UST event %s for channel %s, loglevel %s", event_name,
 					print_channel_name(channel_name), opt_loglevel ? : "<all>");
-
+			}
 			switch (opt_event_type) {
 			case LTTNG_EVENT_ALL:	/* Default behavior is tracepoint */
 				/* Fall-through */
@@ -565,6 +695,31 @@ static int enable_events(char *session_name)
 				goto error;
 			}
 
+			if (opt_exclude)
+			{
+				if (opt_event_type != LTTNG_EVENT_ALL && opt_event_type != LTTNG_EVENT_TRACEPOINT) {
+					ERR("Exclusion options can only be used with tracepoint events");
+					ret = CMD_ERROR;
+					goto error;
+				}
+				/* all excluded items must be subsets of event */
+				char * name_with_exclusions;
+				name_with_exclusions = check_exclusion_subsets(event_name, opt_exclude);
+				if (name_with_exclusions == NULL)
+				{
+					ret = CMD_ERROR;
+					goto error;
+				}
+				if (sizeof(ev.name) < strlen(name_with_exclusions) + 1) {
+					ERR("Event name is too long when excluded events are used");
+					free(name_with_exclusions);
+					ret = CMD_ERROR;
+					goto error;
+				}
+				strncpy(ev.name, name_with_exclusions, sizeof(ev.name));
+				free(name_with_exclusions);
+			}
+
 			ev.loglevel_type = opt_loglevel_type;
 			if (opt_loglevel) {
 				ev.loglevel = loglevel_str_to_value(opt_loglevel);
@@ -603,9 +758,16 @@ static int enable_events(char *session_name)
 				}
 				warn = 1;
 			} else {
-				MSG("%s event %s created in channel %s",
-						opt_kernel ? "kernel": "UST", event_name,
-						print_channel_name(channel_name));
+				int base_length = strcspn(ev.name, "*") + 1;
+				if (base_length < strlen(ev.name)) {
+					MSG("UST event %s excluding %s created in channel %s",
+							event_name, ev.name + base_length, 
+							print_channel_name(channel_name));
+				} else {
+					MSG("%s event %s created in channel %s",
+							opt_kernel ? "kernel": "UST", event_name,
+							print_channel_name(channel_name));
+				}
 			}
 		}
 
@@ -701,6 +863,9 @@ int cmd_enable_events(int argc, const char **argv)
 			goto end;
 		case OPT_FILTER:
 			break;
+		case OPT_EXCLUDE:
+			opt_exclude = poptGetOptArg(pc);
+			break;
 		default:
 			usage(stderr);
 			ret = CMD_UNDEFINED;
-- 
1.8.1.2
