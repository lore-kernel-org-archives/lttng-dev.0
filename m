From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 25/28] Parse exclusions and forward
	them to the control handler
Date: Thu,  7 Nov 2013 12:22:04 +0200
Message-ID: <1383819727-6843-6-git-send-email-jp_ikaheimonen__3977.08590976453$1383820111$gmane$org@mentor.com>
References: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjL-0007eD-6L
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:28 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMjF-0006Fl-OP from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:21 -0800
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

For the enable-event command, parse the given exclusions,
and send them to the control handler.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng/commands/enable_events.c | 50 ++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index f88f53f..90ecdda 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -433,6 +433,8 @@ static int enable_events(char *session_name)
 	char *event_name, *channel_name = NULL;
 	struct lttng_event ev;
 	struct lttng_domain dom;
+	int exclusion_count = 0;
+	char **exclusion_list = NULL;
 
 	memset(&ev, 0, sizeof(ev));
 	memset(&dom, 0, sizeof(dom));
@@ -494,8 +496,18 @@ static int enable_events(char *session_name)
 			}
 		}
 
+		if (opt_exclude) {
+			ret = check_exclusion_subsets("*", opt_exclude,
+					&exclusion_count, &exclusion_list);
+			if (ret == CMD_ERROR) {
+				goto error;
+			}
+		}
 		if (!opt_filter) {
-			ret = lttng_enable_event(handle, &ev, channel_name);
+			ret = lttng_enable_event_with_exclusions(handle,
+					&ev, channel_name,
+					NULL,
+					exclusion_count, exclusion_list);
 			if (ret < 0) {
 				switch (-ret) {
 				case LTTNG_ERR_KERN_EVENT_EXIST:
@@ -555,8 +567,8 @@ static int enable_events(char *session_name)
 			}
 		}
 		if (opt_filter) {
-			ret = lttng_enable_event_with_filter(handle, &ev, channel_name,
-						opt_filter);
+			ret = lttng_enable_event_with_exclusions(handle, &ev, channel_name,
+						opt_filter, exclusion_count, exclusion_list);
 			if (ret < 0) {
 				switch (-ret) {
 				case LTTNG_ERR_FILTER_EXIST:
@@ -669,6 +681,23 @@ static int enable_events(char *session_name)
 				goto error;
 			}
 
+			if (opt_exclude) {
+				/* Free previously allocated items */
+				if (exclusion_list != NULL) {
+					while (exclusion_count--) {
+						free(exclusion_list[exclusion_count]);
+					}
+					free(exclusion_list);
+					exclusion_list = NULL;
+				}
+				/* Check for proper subsets */
+				ret = check_exclusion_subsets(event_name, opt_exclude,
+						&exclusion_count, &exclusion_list);
+				if (ret == CMD_ERROR) {
+					goto error;
+				}
+			}
+
 			ev.loglevel_type = opt_loglevel_type;
 			if (opt_loglevel) {
 				ev.loglevel = loglevel_str_to_value(opt_loglevel);
@@ -697,7 +726,9 @@ static int enable_events(char *session_name)
 		}
 
 		if (!opt_filter) {
-			ret = lttng_enable_event(handle, &ev, channel_name);
+			ret = lttng_enable_event_with_exclusions(handle,
+					&ev, channel_name,
+					NULL, exclusion_count, exclusion_list);
 			if (ret < 0) {
 				/* Turn ret to positive value to handle the positive error code */
 				switch (-ret) {
@@ -724,8 +755,8 @@ static int enable_events(char *session_name)
 		}
 
 		if (opt_filter) {
-			ret = lttng_enable_event_with_filter(handle, &ev, channel_name,
-					opt_filter);
+			ret = lttng_enable_event_with_exclusions(handle, &ev, channel_name,
+					opt_filter, exclusion_count, exclusion_list);
 			if (ret < 0) {
 				switch (-ret) {
 				case LTTNG_ERR_FILTER_EXIST:
@@ -760,6 +791,13 @@ error:
 	}
 	lttng_destroy_handle(handle);
 
+	if (exclusion_list != NULL) {
+		while (exclusion_count--) {
+			free(exclusion_list[exclusion_count]);
+		}
+		free(exclusion_list);
+	}
+
 	return ret;
 }
 
-- 
1.8.1.2
