From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 2/9] Explicitely stop the session on
	lttng destroy
Date: Mon, 13 Jul 2015 11:28:02 -0400
Message-ID: <1436801289-17554-3-git-send-email-jdesfossez__10003.0441921719$1436801603$gmane$org@efficios.com>
References: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfeh-0008PU-B5
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:28:32 -0400
In-Reply-To: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This is going to be useful for the upcoming feature that checks and
eventually displays the amount of lost packets/discarded events.

If we don't do that, more events might be lost/discarded between the
"lttng destroy" command and the time the trace is actually stopped.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/bin/lttng/commands/destroy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands/destroy.c
index 53fe3ac..3a6e3ef 100644
--- a/src/bin/lttng/commands/destroy.c
+++ b/src/bin/lttng/commands/destroy.c
@@ -78,6 +78,13 @@ static int destroy_session(struct lttng_session *session)
 	int ret;
 	char *session_name = NULL;
 
+	ret = lttng_stop_tracing_no_wait(session->name);
+	if (ret < 0) {
+		if (ret != -LTTNG_ERR_TRACE_ALREADY_STOPPED) {
+			ERR("%s", lttng_strerror(ret));
+		}
+	}
+
 	ret = lttng_destroy_session(session->name);
 	if (ret < 0) {
 		switch (-ret) {
-- 
1.9.1
