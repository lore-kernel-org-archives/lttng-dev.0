From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 24/28] Add a function to check for
	legal exclusions
Date: Thu,  7 Nov 2013 12:22:03 +0200
Message-ID: <1383819727-6843-5-git-send-email-jp_ikaheimonen__38166.3799788386$1383820093$gmane$org@mentor.com>
References: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjJ-0007e6-P7
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:26 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMjE-0006Fc-BC from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:20 -0800
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

Add a function check_exclusion_subsets() that checks the event name
against a given list of exclusion names. Report warnings and/or errors
if an exclusion is not a proper subset of the event.

Return a newly allocated list of newly allocated exclusion name strings,
the count of items in that list, and an error code.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng/commands/enable_events.c | 88 ++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index a363c3e..f88f53f 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -337,6 +337,94 @@ const char *print_raw_channel_name(const char *name)
 }
 
 /*
+ * Compare list of exclusions against an event name.
+ * Return a list of legal exclusion names.
+ * Produce an error or a warning about others (depending on the situation)
+ */
+static
+int check_exclusion_subsets(const char *event_name,
+		const char *exclusions,
+		int *exclusion_count_ptr,
+		char ***exclusion_list_ptr)
+{
+	const char *excluder_ptr;
+	const char *event_ptr;
+	const char *next_excluder;
+	int excluder_length;
+	int exclusion_count = 0;
+	char **exclusion_list = NULL;
+	int ret = CMD_SUCCESS;
+
+	if (event_name[strlen(event_name) - 1] != '*') {
+		ERR("Event %s: Excluders can only be used with wildcarded events", event_name);
+		goto error;
+	}
+
+	next_excluder = exclusions;
+	while (*next_excluder != 0) {
+		event_ptr = event_name;
+		excluder_ptr = next_excluder;
+		excluder_length = strcspn(next_excluder, ",");
+
+		/* Scan both the excluder and the event letter by letter */
+		while (1) {
+			char e, x;
+
+			e = *event_ptr;
+			x = *excluder_ptr;
+
+			if (x == '*') {
+				/* Event is a subset of the excluder */
+				ERR("Event %s: %.*s excludes all events from %s",
+						event_name,
+						excluder_length,
+						next_excluder,
+						event_name);
+				goto error;
+			}
+			if (e == '*') {
+				/* Excluder is a proper subset of event */
+				exclusion_count++;
+				exclusion_list = realloc(exclusion_list, sizeof(char **) * exclusion_count);
+				exclusion_list[exclusion_count - 1] = strndup(next_excluder, excluder_length);
+
+				break;
+			}
+			if (x != e) {
+				/* Excluder and event sets have no common elements */
+				WARN("Event %s: %.*s does not exclude any events from %s",
+						event_name,
+						excluder_length,
+						next_excluder,
+						event_name);
+				break;
+			}
+			excluder_ptr++;
+			event_ptr++;
+		}
+		/* next excluder */
+		next_excluder += excluder_length;
+		if (*next_excluder == ',') {
+			next_excluder++;
+		}
+	}
+	goto end;
+error:
+	while (exclusion_count--) {
+		free(exclusion_list[exclusion_count]);
+	}
+	if (exclusion_list != NULL) {
+		free(exclusion_list);
+	}
+	exclusion_list = NULL;
+	exclusion_count = 0;
+	ret = CMD_ERROR;
+end:
+	*exclusion_count_ptr = exclusion_count;
+	*exclusion_list_ptr = exclusion_list;
+	return ret;
+}
+/*
  * Enabling event using the lttng API.
  */
 static int enable_events(char *session_name)
-- 
1.8.1.2
