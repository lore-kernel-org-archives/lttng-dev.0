From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/3] Fix: disable all ust events
Date: Thu, 10 Sep 2015 16:10:56 -0400
Message-ID: <1441915857-1544-2-git-send-email-jonathan.rajotte-julien__898.540896787558$1441915974$gmane$org@efficios.com>
References: <1441915857-1544-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1Za8Bv-0006zo-Q2
 for lttng-dev@lists.lttng.org; Thu, 10 Sep 2015 16:11:33 -0400
In-Reply-To: <1441915857-1544-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Handle * event correctly.

Fixes #936

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 058dbae..470f29d 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -1290,7 +1290,11 @@ int cmd_disable_event(struct ltt_session *session,
 
 		switch (event->type) {
 		case LTTNG_EVENT_ALL:
-			ret = event_ust_disable_tracepoint(usess, uchan, event_name);
+			if (strncmp(event->name, "*", 1) == 0 && strlen(event->name) == 1) {
+				ret = event_ust_disable_all_tracepoints(usess, uchan);
+			} else {
+				ret = event_ust_disable_tracepoint(usess, uchan, event_name);
+			}
 			if (ret != LTTNG_OK) {
 				goto error_unlock;
 			}
-- 
2.1.4
