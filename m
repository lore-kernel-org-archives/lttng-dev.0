From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 01/13] Fix: agents ht leaks on
	destroy session
Date: Wed, 17 Dec 2014 20:45:12 -0500
Message-ID: <1418867124-17343-2-git-send-email-mathieu.desnoyers__8448.59684953025$1418867197$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1Q9p-0006Ae-H7
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:45:40 -0500
In-Reply-To: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
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
 src/bin/lttng-sessiond/trace-ust.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index 971c56e..a3e25aa 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -766,6 +766,8 @@ void trace_ust_destroy_session(struct ltt_ust_session *session)
 	}
 	rcu_read_unlock();
 
+	ht_cleanup_push(session->agents);
+
 	/* Cleanup UID buffer registry object(s). */
 	cds_list_for_each_entry_safe(reg, sreg, &session->buffer_reg_uid_list,
 			lnode) {
-- 
2.1.1
