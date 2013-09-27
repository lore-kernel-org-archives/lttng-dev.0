From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 3/3] Parse and show exclusions in
 the list command
Date: Fri, 27 Sep 2013 07:14:51 +0000
Message-ID: <009B25148989C6458484484699278506E538A67E__16834.3967329294$1380266233$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VPSGR-0002LO-OZ
	for lttng-dev@lists.lttng.org; Fri, 27 Sep 2013 03:15:01 -0400
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

When showing tracepoint events in the list command,
parse the possible exclusions from the event name
and format the output nicely.
---
 src/bin/lttng/commands/list.c | 58 +++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index 1c7085d..c977a52 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -213,20 +213,52 @@ static void print_events(struct lttng_event *event)
 	switch (event->type) {
 	case LTTNG_EVENT_TRACEPOINT:
 	{
-		if (event->loglevel != -1) {
-			MSG("%s%s (loglevel: %s (%d)) (type: tracepoint)%s%s",
-				indent6,
-				event->name,
-				loglevel_string(event->loglevel),
-				event->loglevel,
-				enabled_string(event->enabled),
-				filter_string(event->filter));
+		int base_name_length;
+		int excludes_found;
+		base_name_length = strcspn(event->name, "*") + 1;
+		if (base_name_length == strlen(event->name) + 1)
+			excludes_found = 0;
+		else if (base_name_length == strlen(event->name)
+				&& event->name[base_name_length - 1] == '*')
+			excludes_found = 0;
+		else
+			excludes_found = 1;
+		if (excludes_found) {
+			if (event->loglevel != -1) {
+				MSG("%s%.*s excluding %s (loglevel: %s (%d)) (type: tracepoint)%s%s",
+					indent6,
+					base_name_length,
+					event->name,
+					event->name + base_name_length,
+					loglevel_string(event->loglevel),
+					event->loglevel,
+					enabled_string(event->enabled),
+					filter_string(event->filter));
+			} else {
+				MSG("%s%.*s excluding %s (type: tracepoint)%s%s",
+					indent6,
+					base_name_length,
+					event->name,
+					event->name + base_name_length,
+					enabled_string(event->enabled),
+					filter_string(event->filter));
+			}
 		} else {
-			MSG("%s%s (type: tracepoint)%s%s",
-				indent6,
-				event->name,
-				enabled_string(event->enabled),
-				filter_string(event->filter));
+			if (event->loglevel != -1) {
+				MSG("%s%s (loglevel: %s (%d)) (type: tracepoint)%s%s",
+					indent6,
+					event->name,
+					loglevel_string(event->loglevel),
+					event->loglevel,
+					enabled_string(event->enabled),
+					filter_string(event->filter));
+			} else {
+				MSG("%s%s (type: tracepoint)%s%s",
+					indent6,
+					event->name,
+					enabled_string(event->enabled),
+					filter_string(event->filter));
+			}
 		}
 		break;
 	}
-- 
1.8.1.2
