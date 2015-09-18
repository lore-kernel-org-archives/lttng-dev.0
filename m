From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-tools] Fix: runas: set thread name
Date: Fri, 18 Sep 2015 12:00:04 -0400
Message-ID: <1442592004-32371-1-git-send-email-mathieu.desnoyers__523.011133964424$1442592089$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Zcy58-0004wE-GR
 for lttng-dev@lists.lttng.org; Fri, 18 Sep 2015 12:00:15 -0400
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

In case some system check for the thread name in pidof.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/runas.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/common/runas.c b/src/common/runas.c
index 2634ae9..d313e83 100644
--- a/src/common/runas.c
+++ b/src/common/runas.c
@@ -302,6 +302,7 @@ int run_as_worker(struct run_as_worker *worker)
 	ssize_t writelen;
 	struct run_as_ret sendret;
 	size_t proc_orig_len;
+	int ret;
 
 	/*
 	 * Initialize worker. Set a different process cmdline.
@@ -310,6 +311,14 @@ int run_as_worker(struct run_as_worker *worker)
 	memset(worker->procname, 0, proc_orig_len);
 	strncpy(worker->procname, "lttng-runas", proc_orig_len);
 
+	ret = pthread_setname_np(pthread_self(), "lttng-runas");
+	if (ret) {
+		errno = ret;
+		ret = -1;
+		PERROR("pthread_setname_np");
+		return EXIT_FAILURE;
+	}
+
 	sendret.ret = 0;
 	sendret._errno = 0;
 	writelen = lttcomm_send_unix_sock(worker->sockpair[1], &sendret,
-- 
2.1.4
