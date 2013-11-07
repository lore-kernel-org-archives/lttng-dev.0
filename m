From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 19/28] Set event exclusions in the
	target when event is created
Date: Thu,  7 Nov 2013 12:21:43 +0200
Message-ID: <1383819703-6793-10-git-send-email-jp_ikaheimonen__46389.9261122153$1383819971$gmane$org@mentor.com>
References: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMj2-0007YU-F3
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:09 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMix-0006EA-0p from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:03 -0800
In-Reply-To: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
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

Add a new function set_ust_event_exclusion() that calls the target-side
function that sets the exclusions to an event and reports possible errors.
Call set_ust_event_exclusion() in create_ust_event().

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/ust-app.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 255a41b..d8adccd 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1137,6 +1137,47 @@ error:
 }
 
 /*
+ * Set event exclusions on the tracer.
+ */
+static
+int set_ust_event_exclusion(struct ust_app_event *ua_event,
+		struct ust_app *app)
+{
+	int ret;
+
+	health_code_update();
+
+	if (!ua_event->exclusion || !ua_event->exclusion->count) {
+		ret = 0;
+		goto error;
+	}
+
+	ret = ustctl_set_exclusion(app->sock, ua_event->exclusion,
+			ua_event->obj);
+	if (ret < 0) {
+		if (ret != -EPIPE && ret != -LTTNG_UST_ERR_EXITING) {
+			ERR("UST app event %s exclusions failed for app (pid: %d) "
+					"with ret %d", ua_event->attr.name, app->pid, ret);
+		} else {
+			/*
+			 * This is normal behavior, an application can die during the
+			 * creation process. Don't report an error so the execution can
+			 * continue normally.
+			 */
+			ret = 0;
+			DBG3("UST app event exclusion failed. Application is dead.");
+		}
+		goto error;
+	}
+
+	DBG2("UST exclusion set successfully for event %s", ua_event->name);
+
+error:
+	health_code_update();
+	return ret;
+}
+
+/*
  * Disable the specified event on to UST tracer for the UST session.
  */
 static int disable_ust_event(struct ust_app *app,
@@ -1375,6 +1416,14 @@ int create_ust_event(struct ust_app *app, struct ust_app_session *ua_sess,
 		}
 	}
 
+	/* Set exclusions for the event */
+	if (ua_event->exclusion) {
+		ret = set_ust_event_exclusion(ua_event, app);
+		if (ret < 0) {
+			goto error;
+		}
+	}
+
 	/* If event not enabled, disable it on the tracer */
 	if (ua_event->enabled == 0) {
 		ret = disable_ust_event(app, ua_sess, ua_event);
-- 
1.8.1.2
