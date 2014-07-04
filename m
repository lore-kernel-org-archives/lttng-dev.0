From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust] Bugfix for #745 deadlock with baddr
	statedump+fork
Date: Fri, 4 Jul 2014 14:21:52 +0200
Message-ID: <1404476512-18305-2-git-send-email-paul_woegerer__10906.4666940414$1404476587$gmane$org@mentor.com>
References: <1404476512-18305-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1X32VS-00052l-Cy
 for lttng-dev@lists.lttng.org; Fri, 04 Jul 2014 08:22:26 -0400
In-Reply-To: <1404476512-18305-1-git-send-email-paul_woegerer@mentor.com>
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

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 liblttng-ust/lttng-ust-comm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 5df33f5..8fa2e03 100644
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
@@ -502,11 +503,18 @@ int handle_register_done(struct sock_info *sock_info)
 static
 void handle_pending_statedump(struct sock_info *sock_info)
 {
+	int ret;
 	int ctor_passed = sock_info->constructor_sem_posted;
 
 	if (ctor_passed && sock_info->statedump_pending) {
+		do {
+			ret = sem_wait(&fork_child_wait);
+		} while (ret < 0 && errno == EINTR);
+		assert(!ret);
 		sock_info->statedump_pending = 0;
 		lttng_handle_pending_statedump(sock_info);
+		ret = sem_post(&fork_child_wait);
+		assert(!ret);
 	}
 }
 
@@ -1436,6 +1444,9 @@ void __attribute__((constructor)) lttng_ust_init(void)
 	ret = sem_init(&constructor_wait, 0, 0);
 	assert(!ret);
 
+	ret = sem_init(&fork_child_wait, 0, 1);
+	assert(!ret);
+
 	ret = setup_local_apps();
 	if (ret) {
 		DBG("local apps setup returned %d", ret);
@@ -1627,6 +1638,12 @@ void ust_before_fork(sigset_t *save_sigset)
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
@@ -1637,6 +1654,10 @@ static void ust_after_fork_common(sigset_t *restore_sigset)
 
 	DBG("process %d", getpid());
 	ust_unlock();
+
+	ret = sem_post(&fork_child_wait);
+	assert(!ret);
+
 	/* Restore signals */
 	ret = sigprocmask(SIG_SETMASK, restore_sigset, NULL);
 	if (ret == -1) {
-- 
2.0.1
