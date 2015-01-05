From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 6/6] Fix: exit threads not only on
	goto restart
Date: Mon,  5 Jan 2015 16:43:08 -0500
Message-ID: <1420494188-20782-6-git-send-email-mathieu.desnoyers__40820.5600841486$1420494415$gmane$org@efficios.com>
References: <1420494188-20782-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y8FQt-0005ca-Pb
 for lttng-dev@lists.lttng.org; Mon, 05 Jan 2015 16:43:29 -0500
In-Reply-To: <1420494188-20782-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Exit threads as soon as number of FD is 0, on every loop (no need for
goto restart special case). Number of FD being 0 is a sufficient
condition for exiting the thread: it means the quit pipe has been
removed from the poll set.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/consumer.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index ef5da12..607116f 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -2181,14 +2181,6 @@ void *consumer_thread_metadata_poll(void *data)
 	DBG("Metadata main loop started");
 
 	while (1) {
-		health_code_update();
-
-		/* Only the metadata pipe is set */
-		if (LTTNG_POLL_GETNB(&events) == 0 && consumer_quit == 1) {
-			err = 0;	/* All is OK */
-			goto end;
-		}
-
 restart:
 		health_code_update();
 		health_poll_entry();
@@ -2203,7 +2195,10 @@ restart:
 				ERR("Poll EINTR catched");
 				goto restart;
 			}
-			goto error;
+			if (LTTNG_POLL_GETNB(&events) == 0) {
+				err = 0;	/* All is OK */
+			}
+			goto end;
 		}
 
 		nb_fd = ret;
@@ -2759,14 +2754,6 @@ void *consumer_thread_channel_poll(void *data)
 	DBG("Channel main loop started");
 
 	while (1) {
-		health_code_update();
-
-		/* Only the channel pipe is set */
-		if (LTTNG_POLL_GETNB(&events) == 0 && consumer_quit == 1) {
-			err = 0;	/* All is OK */
-			goto end;
-		}
-
 restart:
 		health_code_update();
 		DBG("Channel poll wait");
@@ -2781,6 +2768,9 @@ restart:
 				ERR("Poll EINTR catched");
 				goto restart;
 			}
+			if (LTTNG_POLL_GETNB(&events) == 0) {
+				err = 0;	/* All is OK */
+			}
 			goto end;
 		}
 
-- 
2.1.1
