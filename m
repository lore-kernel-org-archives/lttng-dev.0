From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 03/13] Fix: ust app leak on UST
	buffer creation error
Date: Wed, 17 Dec 2014 20:45:14 -0500
Message-ID: <1418867124-17343-4-git-send-email-mathieu.desnoyers__34262.2674456381$1418867232$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1Q9t-0006Ag-NV
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:45:44 -0500
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
 src/bin/lttng-sessiond/ust-app.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 9dbd49b..3abd127 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1875,6 +1875,7 @@ static int create_ust_app_session(struct ltt_ust_session *usess,
 		/* Init local registry. */
 		ret = setup_buffer_reg_pid(ua_sess, app, NULL);
 		if (ret < 0) {
+			delete_ust_app_session(-1, ua_sess, app);
 			goto error;
 		}
 		break;
@@ -1882,6 +1883,7 @@ static int create_ust_app_session(struct ltt_ust_session *usess,
 		/* Look for a global registry. If none exists, create one. */
 		ret = setup_buffer_reg_uid(usess, app, NULL);
 		if (ret < 0) {
+			delete_ust_app_session(-1, ua_sess, app);
 			goto error;
 		}
 		break;
-- 
2.1.1
