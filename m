From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 04/28] Add exclusions to
	event_ust_enable_tracepoint
Date: Thu,  7 Nov 2013 12:19:26 +0200
Message-ID: <1383819566-6553-1-git-send-email-jp_ikaheimonen__8705.32013145766$1383819624$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMgf-0006vs-Hr
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:19:42 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMga-0005vt-3J from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:19:36 -0800
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

Add exclusion data to prototype of event_ust_enable_tracepoint()

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/cmd.c   | 2 +-
 src/bin/lttng-sessiond/event.c | 3 ++-
 src/bin/lttng-sessiond/event.h | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index dca4859..69dfda6 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -1421,7 +1421,7 @@ int cmd_enable_event(struct ltt_session *session, struct lttng_domain *domain,
 		}
 
 		/* At this point, the session and channel exist on the tracer */
-		ret = event_ust_enable_tracepoint(usess, uchan, event, filter);
+		ret = event_ust_enable_tracepoint(usess, uchan, event, filter, exclusion);
 		if (ret != LTTNG_OK) {
 			goto error;
 		}
diff --git a/src/bin/lttng-sessiond/event.c b/src/bin/lttng-sessiond/event.c
index f22b812..791251e 100644
--- a/src/bin/lttng-sessiond/event.c
+++ b/src/bin/lttng-sessiond/event.c
@@ -408,7 +408,8 @@ error:
  */
 int event_ust_enable_tracepoint(struct ltt_ust_session *usess,
 		struct ltt_ust_channel *uchan, struct lttng_event *event,
-		struct lttng_filter_bytecode *filter)
+		struct lttng_filter_bytecode *filter,
+		struct lttng_event_exclusion *exclusion)
 {
 	int ret = LTTNG_OK, to_create = 0;
 	struct ltt_ust_event *uevent;
diff --git a/src/bin/lttng-sessiond/event.h b/src/bin/lttng-sessiond/event.h
index 1b92a6a..dba2266 100644
--- a/src/bin/lttng-sessiond/event.h
+++ b/src/bin/lttng-sessiond/event.h
@@ -37,7 +37,8 @@ int event_kernel_enable_all(struct ltt_kernel_channel *kchan,
 
 int event_ust_enable_tracepoint(struct ltt_ust_session *usess,
 		struct ltt_ust_channel *uchan, struct lttng_event *event,
-		struct lttng_filter_bytecode *filter);
+		struct lttng_filter_bytecode *filter,
+		struct lttng_event_exclusion *exclusion);
 int event_ust_disable_tracepoint(struct ltt_ust_session *usess,
 		struct ltt_ust_channel *uchan, char *event_name);
 int event_ust_enable_all_tracepoints(struct ltt_ust_session *usess,
-- 
1.8.1.2
