From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Filter: Notify the user when a
	filter is already enabled on event(s)
Date: Thu, 23 Aug 2012 18:21:14 -0400
Message-ID: <1345760474-29248-1-git-send-email-christian.babeux__44338.4786755361$1345760533$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-iy0-f176.google.com ([209.85.210.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1T4fmN-0005mr-TB
	for lttng-dev@lists.lttng.org; Thu, 23 Aug 2012 18:21:31 -0400
Received: by iagt4 with SMTP id t4so2439431iag.35
	for <lttng-dev@lists.lttng.org>; Thu, 23 Aug 2012 15:21:26 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng/commands/enable_events.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index a2c8a68..7a65ee6 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -384,7 +384,17 @@ static int enable_events(char *session_name)
 			ret = lttng_set_event_filter(handle, ev.name, channel_name,
 						opt_filter);
 			if (ret < 0) {
-				ERR("Error setting filter");
+				switch (-ret)
+				{
+				case LTTCOMM_FILTER_EXIST:
+					ERR("Filter on events is already enabled (channel %s, session %s)",
+						channel_name, session_name);
+					break;
+				default:
+					ERR("Error setting filter");
+					break;
+				}
+
 				ret = -1;
 				goto error;
 			}
@@ -554,7 +564,17 @@ static int enable_events(char *session_name)
 			ret = lttng_set_event_filter(handle, ev.name,
 				channel_name, opt_filter);
 			if (ret < 0) {
-				ERR("Error setting filter");
+				switch (-ret)
+				{
+				case LTTCOMM_FILTER_EXIST:
+					ERR("Filter on event %s is already enabled (channel %s, session %s)",
+						event_name, channel_name, session_name);
+					break;
+				default:
+					ERR("Error setting filter");
+					break;
+				}
+
 				ret = -1;
 				goto error;
 			}
-- 
1.7.11.4
