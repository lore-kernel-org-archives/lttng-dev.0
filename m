From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust v2] Bugfix for
	http://bugs.lttng.org/issues/745
Date: Wed, 25 Jun 2014 14:05:49 +0200
Message-ID: <1403697949-20140-1-git-send-email-paul_woegerer__17943.2019860998$1403698016$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1Wzlxq-0007gg-1Y
 for lttng-dev@lists.lttng.org; Wed, 25 Jun 2014 08:06:10 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

In case of a fork prevent ust_lock_nocheck() in ust_before_fork() to be
executed before handle_pending_statedump() gets completed.

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 liblttng-ust/lttng-ust-comm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 5df33f5..7cda59f 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -173,6 +173,7 @@ void ust_unlock(void)
  *   daemon problems).
  */
 static sem_t constructor_wait;
+static sem_t fork_child_wait;
 /*
  * Doing this for both the global and local sessiond.
  */
@@ -502,12 +503,16 @@ int handle_register_done(struct sock_info *sock_info)
 static
 void handle_pending_statedump(struct sock_info *sock_info)
 {
+	int ret;
 	int ctor_passed = sock_info->constructor_sem_posted;
 
 	if (ctor_passed && sock_info->statedump_pending) {
 		sock_info->statedump_pending = 0;
 		lttng_handle_pending_statedump(sock_info);
 	}
+
+	ret = sem_post(&fork_child_wait);
+	assert(!ret);
 }
 
 static
@@ -1436,6 +1441,9 @@ void __attribute__((constructor)) lttng_ust_init(void)
 	ret = sem_init(&constructor_wait, 0, 0);
 	assert(!ret);
 
+	ret = sem_init(&fork_child_wait, 0, 0);
+	assert(!ret);
+
 	ret = setup_local_apps();
 	if (ret) {
 		DBG("local apps setup returned %d", ret);
@@ -1627,6 +1635,12 @@ void ust_before_fork(sigset_t *save_sigset)
 	if (ret == -1) {
 		PERROR("sigprocmask");
 	}
+
+	do {
+		ret = sem_wait(&fork_child_wait);
+	} while (ret < 0 && errno == EINTR);
+	assert(!ret);
+
 	ust_lock_nocheck();
 	rcu_bp_before_fork();
 }
-- 
2.0.0
