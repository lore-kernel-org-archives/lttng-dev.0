From: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Subject: [PATCH lttng-ust] Ignore unexpected old state when
 nesting ust_mutex in the same thread
Date: Tue, 28 May 2019 12:18:37 -0400
Message-ID: <20190528161837.29477-1-gabriel.pollo-guilbert__30076.0717292846$1559060376$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45CzZ05njgz12VT
 for <lttng-dev@lists.lttng.org>; Tue, 28 May 2019 12:19:19 -0400 (EDT)
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
List-Id: lttng-dev@lists.lttng.org

We allow the ust_mutex lock to be nested within the same thread using the
ust_mutex_nest counter. When calling ust_lock(), ust_lock_nocheck() or
ust_unlock() twice or more in the same thread would result in an error
message being thrown.

This error message always appear when an application calls fork(3) (with
liblttng-ust-fork preloaded), the thread would lock before the fork(3) in
ust_before_fork() and the child would lock again during lttng_after_fork_child().

Signed-off-by: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
---
 liblttng-ust/lttng-ust-comm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 61dbb41b..a6449bbc 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -135,7 +135,9 @@ int ust_lock(void)
 		ERR("pthread_setcancelstate: %s", strerror(ret));
 	}
 	if (oldstate != PTHREAD_CANCEL_ENABLE) {
-		ERR("pthread_setcancelstate: unexpected oldstate");
+		if (!URCU_TLS(ust_mutex_nest)) {
+			ERR("pthread_setcancelstate: unexpected oldstate");
+		}
 	}
 	sigfillset(&sig_all_blocked);
 	ret = pthread_sigmask(SIG_SETMASK, &sig_all_blocked, &orig_mask);
@@ -171,7 +173,9 @@ void ust_lock_nocheck(void)
 		ERR("pthread_setcancelstate: %s", strerror(ret));
 	}
 	if (oldstate != PTHREAD_CANCEL_ENABLE) {
-		ERR("pthread_setcancelstate: unexpected oldstate");
+		if (!URCU_TLS(ust_mutex_nest)) {
+			ERR("pthread_setcancelstate: unexpected oldstate");
+		}
 	}
 	sigfillset(&sig_all_blocked);
 	ret = pthread_sigmask(SIG_SETMASK, &sig_all_blocked, &orig_mask);
@@ -210,7 +214,9 @@ void ust_unlock(void)
 		ERR("pthread_setcancelstate: %s", strerror(ret));
 	}
 	if (oldstate != PTHREAD_CANCEL_DISABLE) {
-		ERR("pthread_setcancelstate: unexpected oldstate");
+		if (URCU_TLS(ust_mutex_nest)) {
+			ERR("pthread_setcancelstate: unexpected oldstate");
+		}
 	}
 }
 
-- 
2.21.0
