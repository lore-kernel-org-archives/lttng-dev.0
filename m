From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/6] Add debugging output to
	ht-cleanup thread
Date: Mon,  5 Jan 2015 16:43:03 -0500
Message-ID: <1420494188-20782-1-git-send-email-mathieu.desnoyers__35153.1564527706$1420494252$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y8FQl-0005cH-2q
 for lttng-dev@lists.lttng.org; Mon, 05 Jan 2015 16:43:20 -0500
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
 src/bin/lttng-sessiond/ht-cleanup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/bin/lttng-sessiond/ht-cleanup.c b/src/bin/lttng-sessiond/ht-cleanup.c
index 79fb9cd..ace41e5 100644
--- a/src/bin/lttng-sessiond/ht-cleanup.c
+++ b/src/bin/lttng-sessiond/ht-cleanup.c
@@ -42,6 +42,7 @@ void *thread_ht_cleanup(void *data)
 	health_register(health_sessiond, HEALTH_SESSIOND_TYPE_HT_CLEANUP);
 
 	if (testpoint(sessiond_thread_ht_cleanup)) {
+		DBG("[ht-thread] testpoint.");
 		goto error_testpoint;
 	}
 
@@ -49,12 +50,14 @@ void *thread_ht_cleanup(void *data)
 
 	ret = sessiond_set_ht_cleanup_thread_pollset(&events, 2);
 	if (ret < 0) {
+		DBG("[ht-thread] sessiond_set_ht_cleanup_thread_pollset error %d.", ret);
 		goto error_poll_create;
 	}
 
 	/* Add pipe to the pollset. */
 	ret = lttng_poll_add(&events, ht_cleanup_pipe[0], LPOLLIN | LPOLLERR);
 	if (ret < 0) {
+		DBG("[ht-thread] lttng_poll_add error %d.", ret);
 		goto error;
 	}
 
@@ -145,6 +148,7 @@ restart:
 			ret = sessiond_check_ht_cleanup_quit(pollfd, revents);
 			if (ret) {
 				err = 0;
+				DBG("[ht-cleanup] quit.");
 				goto exit;
 			}
 		}
-- 
2.1.1
