From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: notification thread: free
 session trigger list on error
Date: Wed, 12 Dec 2018 15:11:14 -0500
Message-ID: <20181212201115.14997-1-mathieu.desnoyers__28087.584678042$1544645362$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43FScl6Tptz1785
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 15:11:19 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/notification-thread-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bin/lttng-sessiond/notification-thread-events.c b/src/bin/lttng-sessiond/notification-thread-events.c
index ba4e5a05..3482a7e8 100644
--- a/src/bin/lttng-sessiond/notification-thread-events.c
+++ b/src/bin/lttng-sessiond/notification-thread-events.c
@@ -1518,6 +1518,7 @@ struct session_info *find_or_create_session_info(
 	if (!session) {
 		ERR("[notification-thread] Failed to allocation session info for session \"%s\" (uid = %i, gid = %i)",
 				name, uid, gid);
+		lttng_session_trigger_list_destroy(trigger_list);
 		goto error;
 	}
 	trigger_list = NULL;
-- 
2.11.0
