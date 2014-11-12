From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: filter attach vs event
	enable race
Date: Wed, 12 Nov 2014 18:18:32 -0500
Message-ID: <1415834313-10400-1-git-send-email-mathieu.desnoyers__35839.3837036148$1415834391$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XohBu-0000nO-Ti
 for lttng-dev@lists.lttng.org; Wed, 12 Nov 2014 18:19:13 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

In order to correctly handle the use-case where events are enabled
_after_ trace is started, and _after_ applications are already being
traced, the event should be created in a "disabled" state, so that it
does not trace events until its filter is attached.

This fix needs to be done both in lttng-tools and lttng-ust. In order to
keep ABI compatibility between tools and ust within a stable release
cycle, we introduce a new "disabled" within struct lttng_ust_event
padding (previously zeroed). Newer LTTng-UST checks this flag, and
fallback on the old racy behavior (enabling the event on creation) if it
is unset.

Therefore, old session daemon works with newer lttng-ust of the same
stable release, and vice-versa. However, building lttng-tools requires
an upgraded lttng-ust, which contains the communication protocol with
the new "disabled" field.

This patch should be backported to stable-2.4, stable-2.5, stable-2.6
branches.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/trace-ust.c |  5 +++++
 src/bin/lttng-sessiond/ust-app.c   | 27 ++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index 1f6fd52..ac980fd 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -419,6 +419,11 @@ struct ltt_ust_event *trace_ust_create_event(struct lttng_event *ev,
 		ERR("Unknown ust loglevel type (%d)", ev->loglevel_type);
 		goto error_free_event;
 	}
+	/*
+	 * Fix for enabler race. Enable is now done explicitly by
+	 * sessiond after setting filter.
+	 */
+	lue->attr.disabled = 1;
 
 	/* Same layout. */
 	lue->filter_expression = filter_expression;
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 5ebe991..7e4bf94 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1446,7 +1446,32 @@ int create_ust_event(struct ust_app *app, struct ust_app_session *ua_sess,
 	}
 
 	/* If event not enabled, disable it on the tracer */
-	if (ua_event->enabled == 0) {
+	if (ua_event->enabled) {
+		/*
+		 * We now need to explicitly enable the event, since it
+		 * is now disabled at creation.
+		 */
+		ret = enable_ust_event(app, ua_sess, ua_event);
+		if (ret < 0) {
+			/*
+			 * If we hit an EPERM, something is wrong with our enable call. If
+			 * we get an EEXIST, there is a problem on the tracer side since we
+			 * just created it.
+			 */
+			switch (ret) {
+			case -LTTNG_UST_ERR_PERM:
+				/* Code flow problem */
+				assert(0);
+			case -LTTNG_UST_ERR_EXIST:
+				/* It's OK for our use case. */
+				ret = 0;
+				break;
+			default:
+				break;
+			}
+			goto error;
+		}
+	} else {
 		ret = disable_ust_event(app, ua_sess, ua_event);
 		if (ret < 0) {
 			/*
-- 
2.1.1
