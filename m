From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: session list lock must be held
 on session put operation
Date: Wed, 19 Dec 2018 13:47:23 -0500
Message-ID: <20181219184723.11974-1-jonathan.rajotte-julien__35648.3504096561$1545245139$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43KkQw5Fl4z16Tx
 for <lttng-dev@lists.lttng.org>; Wed, 19 Dec 2018 13:47:36 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/rotation-thread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/rotation-thread.c b/src/bin/lttng-sessiond/rotation-thread.c
index 8e63e160f..6669372dd 100644
--- a/src/bin/lttng-sessiond/rotation-thread.c
+++ b/src/bin/lttng-sessiond/rotation-thread.c
@@ -761,9 +761,9 @@ int handle_job_queue(struct rotation_thread_handle *handle,
 			 * possible for a job targeting that session to have
 			 * already been queued before it was destroyed.
 			 */
-			session_unlock_list();
 			free(job);
 			session_put(session);
+			session_unlock_list();
 			continue;
 		}
 
@@ -832,7 +832,6 @@ int handle_condition(const struct lttng_condition *condition,
 		goto end;
 	}
 	session_lock(session);
-	session_unlock_list();
 
 	ret = unsubscribe_session_consumed_size_rotation(session,
 			notification_thread_handle);
@@ -861,6 +860,7 @@ int handle_condition(const struct lttng_condition *condition,
 end_unlock:
 	session_unlock(session);
 	session_put(session);
+	session_unlock_list();
 end:
 	return ret;
 }
-- 
2.17.1
