From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: UST per-UID channels persist
	across	application teardown
Date: Tue, 2 Jul 2013 16:20:33 -0400
Message-ID: <20130702202033.GA11433__11480.0854972147$1372796467$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uu741-0002LF-32
	for lttng-dev@lists.lttng.org; Tue, 02 Jul 2013 16:20:37 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Fixes #582

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 2d7a81f..c329650 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -377,10 +377,12 @@ void delete_ust_app_channel(int sock, struct ust_app_channel *ua_chan,
 		delete_ust_app_event(sock, ua_event);
 	}
 
-	/* Wipe and free registry from session registry. */
-	registry = get_session_registry(ua_chan->session);
-	if (registry) {
-		ust_registry_channel_del_free(registry, ua_chan->key);
+	if (ua_chan->session->buffer_type == LTTNG_BUFFER_PER_PID) {
+		/* Wipe and free registry from session registry. */
+		registry = get_session_registry(ua_chan->session);
+		if (registry) {
+			ust_registry_channel_del_free(registry, ua_chan->key);
+		}
 	}
 
 	if (ua_chan->obj != NULL) {
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
