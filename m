From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 28/28] When listing events,
	show exclusions if they exist
Date: Thu,  7 Nov 2013 12:22:07 +0200
Message-ID: <1383819727-6843-9-git-send-email-jp_ikaheimonen__25101.1801105507$1383820172$gmane$org@mentor.com>
References: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjP-0007gL-5G
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:33 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMjJ-0006GP-NK from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:25 -0800
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

Add "[has exclusions]" to the printout of an event, if that
event has exclusions added.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 include/lttng/lttng.h         |  3 ++-
 src/bin/lttng-sessiond/cmd.c  |  3 +++
 src/bin/lttng/commands/list.c | 15 +++++++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
index 255f7c4..85fdfaa 100644
--- a/include/lttng/lttng.h
+++ b/include/lttng/lttng.h
@@ -226,7 +226,7 @@ struct lttng_event_function_attr {
  *
  * The structures should be initialized to zero before use.
  */
-#define LTTNG_EVENT_PADDING1               15
+#define LTTNG_EVENT_PADDING1               14
 #define LTTNG_EVENT_PADDING2               LTTNG_SYMBOL_NAME_LEN + 32
 struct lttng_event {
 	enum lttng_event_type type;
@@ -238,6 +238,7 @@ struct lttng_event {
 	int32_t enabled;	/* Does not apply: -1 */
 	pid_t pid;
 	unsigned char filter;	/* filter enabled ? */
+	unsigned char exclusion; /* exclusions added ? */
 
 	char padding[LTTNG_EVENT_PADDING1];
 
diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 69dfda6..d00bf1e 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -305,6 +305,9 @@ static int list_lttng_ust_global_events(char *channel_name,
 		if (uevent->filter) {
 			tmp[i].filter = 1;
 		}
+		if (uevent->exclusion) {
+			tmp[i].exclusion = 1;
+		}
 		i++;
 	}
 
diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index bca06e7..6a54279 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -168,6 +168,15 @@ const char *filter_string(int value)
 	}
 }
 
+static
+const char *exclusion_string(int value)
+{
+	switch (value) {
+	case 1: return " [has exclusions]";
+	default: return "";
+	}
+}
+
 static const char *loglevel_string(int value)
 {
 	switch (value) {
@@ -217,18 +226,20 @@ static void print_events(struct lttng_event *event)
 	case LTTNG_EVENT_TRACEPOINT:
 	{
 		if (event->loglevel != -1) {
-			MSG("%s%s (loglevel: %s (%d)) (type: tracepoint)%s%s",
+			MSG("%s%s (loglevel: %s (%d)) (type: tracepoint)%s%s%s",
 				indent6,
 				event->name,
 				loglevel_string(event->loglevel),
 				event->loglevel,
 				enabled_string(event->enabled),
+				exclusion_string(event->exclusion),
 				filter_string(event->filter));
 		} else {
-			MSG("%s%s (type: tracepoint)%s%s",
+			MSG("%s%s (type: tracepoint)%s%s%s",
 				indent6,
 				event->name,
 				enabled_string(event->enabled),
+				exclusion_string(event->exclusion),
 				filter_string(event->filter));
 		}
 		break;
-- 
1.8.1.2
