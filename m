From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: FD leak in accept error
	handling
Date: Sat, 27 Sep 2014 19:49:22 -0400
Message-ID: <1411861762-17552-1-git-send-email-mathieu.desnoyers__34520.8581108183$1411861975$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XY1kM-0007go-BQ
 for lttng-dev@lists.lttng.org; Sat, 27 Sep 2014 19:49:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CE5863402C8
 for <lttng-dev@lists.lttng.org>; Sat, 27 Sep 2014 23:49:41 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

*** CID 1241799:  Resource leak  (RESOURCE_LEAK)
/src/common/sessiond-comm/inet.c: 324 in lttcomm_accept_inet_sock()
318
319     end:
320             return new_sock;
321
322     error:
323             free(new_sock);
>>>     CID 1241799:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "new_fd" going out of scope leaks the handle.
324             return NULL;
325     }
326
327     /*
328      * Make the socket listen using LTTNG_SESSIOND_COMM_MAX_LISTEN.
329      */

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/sessiond-comm/inet.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/common/sessiond-comm/inet.c b/src/common/sessiond-comm/inet.c
index cf06ecb..4e34ad0 100644
--- a/src/common/sessiond-comm/inet.c
+++ b/src/common/sessiond-comm/inet.c
@@ -272,7 +272,7 @@ error_connect:
 LTTNG_HIDDEN
 struct lttcomm_sock *lttcomm_accept_inet_sock(struct lttcomm_sock *sock)
 {
-	int new_fd;
+	int new_fd, closeret;
 	socklen_t len;
 	struct lttcomm_sock *new_sock;
 	unsigned long timeout;
@@ -305,10 +305,18 @@ struct lttcomm_sock *lttcomm_accept_inet_sock(struct lttcomm_sock *sock)
 
 		ret = lttcomm_setsockopt_rcv_timeout(new_fd, timeout);
 		if (ret) {
+			closeret = close(new_fd);
+			if (closeret) {
+				PERROR("close");
+			}
 			goto error;
 		}
 		ret = lttcomm_setsockopt_snd_timeout(new_fd, timeout);
 		if (ret) {
+			closeret = close(new_fd);
+			if (closeret) {
+				PERROR("close");
+			}
 			goto error;
 		}
 	}
-- 
2.1.0
