From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 27/28] Add exclusion names to
	diagnostic printouts
Date: Thu,  7 Nov 2013 12:22:06 +0200
Message-ID: <1383819727-6843-8-git-send-email-jp_ikaheimonen__47172.1050249927$1383820148$gmane$org@mentor.com>
References: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjN-0007fk-SF
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:31 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMjI-0006G2-DT from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:24 -0800
In-Reply-To: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
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

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng/commands/enable_events.c | 82 +++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 11 deletions(-)

diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index 7009df7..42cd022 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -337,6 +337,39 @@ const char *print_raw_channel_name(const char *name)
 }
 
 /*
+ * Return allocated string for pretty-printing exclusion names.
+ */
+static
+char *print_exclusions(int count, char **names)
+{
+	int length = 0;
+	int i;
+	const char *preamble = " excluding ";
+	char *ret;
+
+	if (count == 0) {
+		return strdup("");
+	}
+
+	/* calculate total required length */
+	for (i = 0; i < count; i++) {
+		length += strlen(names[i]) + 1;
+	}
+
+	/* add length of preamble + one for NUL - one for last (missing) comma */
+	length += strlen(preamble);
+	ret = malloc(length);
+	strcpy(ret, preamble);
+	for (i = 0; i < count; i++) {
+		strcat(ret, names[i]);
+		if (i != count - 1) {
+			strcat(ret, ",");
+		}
+	}
+	return ret;
+}
+
+/*
  * Compare list of exclusions against an event name.
  * Return a list of legal exclusion names.
  * Produce an error or a warning about others (depending on the situation)
@@ -535,15 +568,20 @@ static int enable_events(char *session_name)
 			switch (opt_event_type) {
 			case LTTNG_EVENT_TRACEPOINT:
 				if (opt_loglevel) {
-					MSG("All %s tracepoints are enabled in channel %s for loglevel %s",
+					char *exclusion_string = print_exclusions(exclusion_count, exclusion_list);
+					MSG("All %s tracepoints%s are enabled in channel %s for loglevel %s",
 							get_domain_str(dom.type),
+							exclusion_string,
 							print_channel_name(channel_name),
 							opt_loglevel);
+					free(exclusion_string);
 				} else {
-					MSG("All %s tracepoints are enabled in channel %s",
+					char *exclusion_string = print_exclusions(exclusion_count, exclusion_list);
+					MSG("All %s tracepoints%s are enabled in channel %s",
 							get_domain_str(dom.type),
+							exclusion_string,
 							print_channel_name(channel_name));
-
+					free(exclusion_string);
 				}
 				break;
 			case LTTNG_EVENT_SYSCALL:
@@ -554,14 +592,20 @@ static int enable_events(char *session_name)
 				break;
 			case LTTNG_EVENT_ALL:
 				if (opt_loglevel) {
-					MSG("All %s events are enabled in channel %s for loglevel %s",
+					char *exclusion_string = print_exclusions(exclusion_count, exclusion_list);
+					MSG("All %s events%s are enabled in channel %s for loglevel %s",
 							get_domain_str(dom.type),
+							exclusion_string,
 							print_channel_name(channel_name),
 							opt_loglevel);
+					free(exclusion_string);
 				} else {
-					MSG("All %s events are enabled in channel %s",
+					char *exclusion_string = print_exclusions(exclusion_count, exclusion_list);
+					MSG("All %s events%s are enabled in channel %s",
 							get_domain_str(dom.type),
+							exclusion_string,
 							print_channel_name(channel_name));
+					free(exclusion_string);
 				}
 				break;
 			default:
@@ -737,19 +781,24 @@ static int enable_events(char *session_name)
 		}
 
 		if (!opt_filter) {
+			char *exclusion_string;
+
 			ret = lttng_enable_event_with_exclusions(handle,
 					&ev, channel_name,
 					NULL, exclusion_count, exclusion_list);
+			exclusion_string = print_exclusions(exclusion_count, exclusion_list);
 			if (ret < 0) {
 				/* Turn ret to positive value to handle the positive error code */
 				switch (-ret) {
 				case LTTNG_ERR_KERN_EVENT_EXIST:
-					WARN("Kernel event %s already enabled (channel %s, session %s)",
+					WARN("Kernel event %s%s already enabled (channel %s, session %s)",
 							event_name,
+							exclusion_string,
 							print_channel_name(channel_name), session_name);
 					break;
 				default:
-					ERR("Event %s: %s (channel %s, session %s)", event_name,
+					ERR("Event %s%s: %s (channel %s, session %s)", event_name,
+							exclusion_string,
 							lttng_strerror(ret),
 							ret == -LTTNG_ERR_NEED_CHANNEL_NAME
 								? print_raw_channel_name(channel_name)
@@ -759,25 +808,33 @@ static int enable_events(char *session_name)
 				}
 				warn = 1;
 			} else {
-				MSG("%s event %s created in channel %s",
+				MSG("%s event %s%s created in channel %s",
 						get_domain_str(dom.type), event_name,
+						exclusion_string,
 						print_channel_name(channel_name));
 			}
+			free(exclusion_string);
 		}
 
 		if (opt_filter) {
+			char *exclusion_string;
+
 			ret = lttng_enable_event_with_exclusions(handle, &ev, channel_name,
 					opt_filter, exclusion_count, exclusion_list);
+			exclusion_string = print_exclusions(exclusion_count, exclusion_list);
+
 			if (ret < 0) {
 				switch (-ret) {
 				case LTTNG_ERR_FILTER_EXIST:
-					WARN("Filter on event %s is already enabled"
+					WARN("Filter on event %s%s is already enabled"
 							" (channel %s, session %s)",
 						event_name,
+						exclusion_string,
 						print_channel_name(channel_name), session_name);
 					break;
 				default:
-					ERR("Event %s: %s (channel %s, session %s, filter \'%s\')", ev.name,
+					ERR("Event %s%s: %s (channel %s, session %s, filter \'%s\')", ev.name,
+							exclusion_string,
 							lttng_strerror(ret),
 							ret == -LTTNG_ERR_NEED_CHANNEL_NAME
 								? print_raw_channel_name(channel_name)
@@ -787,8 +844,11 @@ static int enable_events(char *session_name)
 				}
 				goto error;
 			} else {
-				MSG("Filter '%s' successfully set", opt_filter);
+				MSG("Event %s%s: Filter '%s' successfully set",
+						event_name, exclusion_string,
+						opt_filter);
 			}
+			free(exclusion_string);
 		}
 
 		/* Next event */
-- 
1.8.1.2
