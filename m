From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: uninitialized return value
Date: Fri, 23 Jan 2015 11:28:59 -0500
Message-ID: <1422030540-3544-1-git-send-email-mathieu.desnoyers__46190.5799144462$1422030592$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1YEh6c-00081F-89
 for lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 11:29:14 -0500
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 41a6d39..bdee8e6 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -4132,7 +4132,7 @@ static
 int ust_app_flush_session(struct ltt_ust_session *usess)
 
 {
-	int ret;
+	int ret = 0;
 
 	DBG("Flushing session buffers for all ust apps");
 
@@ -4173,7 +4173,6 @@ int ust_app_flush_session(struct ltt_ust_session *usess)
 			/* Push metadata. */
 			(void) push_metadata(ust_session_reg, usess->consumer);
 		}
-		ret = 0;
 		break;
 	}
 	case LTTNG_BUFFER_PER_PID:
@@ -4192,6 +4191,7 @@ int ust_app_flush_session(struct ltt_ust_session *usess)
 		break;
 	}
 	default:
+		ret = -1;
 		assert(0);
 		break;
 	}
-- 
2.1.1
