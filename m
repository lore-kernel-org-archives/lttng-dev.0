From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust 1/2] Bugfix for #745 deadlock with
	baddr statedump+fork
Date: Mon, 14 Jul 2014 10:38:24 +0200
Message-ID: <1405327105-20507-2-git-send-email-paul_woegerer__35223.7064311796$1405327187$gmane$org@mentor.com>
References: <1879691854.11749.1404998687774.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1X6bmh-0003Ly-PN
 for lttng-dev@lists.lttng.org; Mon, 14 Jul 2014 04:39:00 -0400
In-Reply-To: <1879691854.11749.1404998687774.JavaMail.zimbra@efficios.com>
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
 liblttng-ust/lttng-ust-comm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 5df33f5..a73808e 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -86,6 +86,14 @@ static DEFINE_URCU_TLS(int, ust_mutex_nest);
  */
 static pthread_mutex_t ust_exit_mutex = PTHREAD_MUTEX_INITIALIZER;
 
+/*
+ * ust_fork_mutex protects base address statedump tracing against forks. It
+ * prevents the dynamic loader lock to be taken (by base address statedump
+ * tracing) while a fork is happening, thus preventing deadlock issues with
+ * the dynamic loader lock.
+ */
+static pthread_mutex_t ust_fork_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 /* Should the ust comm thread quit ? */
 static int lttng_ust_comm_should_quit;
 
@@ -505,8 +513,10 @@ void handle_pending_statedump(struct sock_info *sock_info)
 	int ctor_passed = sock_info->constructor_sem_posted;
 
 	if (ctor_passed && sock_info->statedump_pending) {
+		pthread_mutex_lock(&ust_fork_mutex);
 		sock_info->statedump_pending = 0;
 		lttng_handle_pending_statedump(sock_info);
+		pthread_mutex_unlock(&ust_fork_mutex);
 	}
 }
 
@@ -1627,6 +1637,9 @@ void ust_before_fork(sigset_t *save_sigset)
 	if (ret == -1) {
 		PERROR("sigprocmask");
 	}
+
+	pthread_mutex_lock(&ust_fork_mutex);
+
 	ust_lock_nocheck();
 	rcu_bp_before_fork();
 }
@@ -1637,6 +1650,9 @@ static void ust_after_fork_common(sigset_t *restore_sigset)
 
 	DBG("process %d", getpid());
 	ust_unlock();
+
+	pthread_mutex_unlock(&ust_fork_mutex);
+
 	/* Restore signals */
 	ret = sigprocmask(SIG_SETMASK, restore_sigset, NULL);
 	if (ret == -1) {
-- 
2.0.1
