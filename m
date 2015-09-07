From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: unbalanced RCU read-side
	lock in enable event command
Date: Mon,  7 Sep 2015 10:36:09 -0400
Message-ID: <1441636569-3488-2-git-send-email-mathieu.desnoyers__8071.97069884769$1441636655$gmane$org@efficios.com>
References: <1441636569-3488-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZYxWw-0008Tm-9R
 for lttng-dev@lists.lttng.org; Mon, 07 Sep 2015 10:36:22 -0400
In-Reply-To: <1441636569-3488-1-git-send-email-mathieu.desnoyers@efficios.com>
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

The event validation fails, an unpaired RCU unlock is performed, thus
underflowing the RCU nesting counter.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 6237d67..ac5b8ec 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -1535,13 +1535,13 @@ static int _cmd_enable_event(struct ltt_session *session,
 
 	DBG("Enable event command for event \'%s\'", event->name);
 
+	rcu_read_lock();
+
 	ret = validate_event_name(event->name);
 	if (ret) {
 		goto error;
 	}
 
-	rcu_read_lock();
-
 	switch (domain->type) {
 	case LTTNG_DOMAIN_KERNEL:
 	{
-- 
2.1.4
