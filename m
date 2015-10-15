From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace] compat send no SIGPIPE:
	multithread-safe
Date: Thu, 15 Oct 2015 12:07:46 -0400
Message-ID: <1444925266-403-1-git-send-email-mathieu.desnoyers__28284.3112982393$1444925336$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Zml4Q-0004Z2-K2
 for lttng-dev@lists.lttng.org; Thu, 15 Oct 2015 12:07:59 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mjeanson@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The current implementation of the no-SIGPIPE send in the compatibility
layer has side-effects on multithreaded processes due to use of
sigaction(). Although multithread-safety is not strictly needed since
Babeltrace is single-threaded for now, there is no reason to keep this
limitation deeply rooted in a compatibility layer.

Use the multithreaded-safe algorithm to catch SIGPIPE implemented in
LTTng-UST for the write() system call for platforms that do not have
MSG_NOSIGNAL. It was originally implented in LTTng-UST as part of the
ring buffer wakeup. This is a re-implementation of this same algorithm
under MIT license. It uses signal masks and sigtimedwait.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/babeltrace/compat/send.h | 70 ++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/include/babeltrace/compat/send.h b/include/babeltrace/compat/send.h
index 98e1feb..3c6d01a 100644
--- a/include/babeltrace/compat/send.h
+++ b/include/babeltrace/compat/send.h
@@ -5,6 +5,7 @@
  * babeltrace/compat/send.h
  *
  * Copyright (C) 2015  Michael Jeanson <mjeanson@efficios.com>
+ *               2015  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -27,9 +28,7 @@
 
 /*
  * This wrapper is used on platforms that have no way of ignoring SIGPIPE
- * during a send(). Instead, we set the signal action to ignore. This is OK
- * in a single-threaded app, but would be problematic in a multi-threaded app
- * since sigaction applies to all threads.
+ * during a send().
  */
 
 #ifndef MSG_NOSIGNAL
@@ -45,32 +44,69 @@ ssize_t bt_send_nosigpipe(int fd, const void *buffer, size_t size)
 	return send(fd, buffer, size, MSG_NOSIGNAL);
 }
 #else
+
+#include <signal.h>
+
 static inline
 ssize_t bt_send_nosigpipe(int fd, const void *buffer, size_t size)
 {
 	ssize_t sent;
 	int saved_err;
-	struct sigaction act, oldact;
+	sigset_t sigpipe_set, pending_set, old_set;
+	int sigpipe_was_pending;
 
-	/* Set SIGPIPE action to ignore and save current signal action */
-	act.sa_handler = SIG_IGN;
-	if (sigaction(SIGPIPE, &act, &oldact)) {
-		perror("sigaction");
-		sent = -1;
-		goto end;
+	/*
+	 * Discard the SIGPIPE from send(), not disturbing any SIGPIPE
+	 * that might be already pending. If a bogus SIGPIPE is sent to
+	 * the entire process concurrently by a malicious user, it may
+	 * be simply discarded.
+	 */
+	if (sigemptyset(&pending_set)) {
+		return -1;
+	}
+	/*
+	 * sigpending returns the mask of signals that are _both_
+	 * blocked for the thread _and_ pending for either the thread or
+	 * the entire process.
+	 */
+	if (sigpending(&pending_set)) {
+		return -1;
+	}
+	sigpipe_was_pending = sigismember(&pending_set, SIGPIPE);
+	/*
+	 * If sigpipe was pending, it means it was already blocked, so
+	 * no need to block it.
+	 */
+	if (!sigpipe_was_pending) {
+		if (sigemptyset(&sigpipe_set)) {
+			return -1;
+		}
+		if (sigaddset(&sigpipe_set, SIGPIPE)) {
+			return -1;
+		}
+		if (pthread_sigmask(SIG_BLOCK, &sigpipe_set, &old_set)) {
+			return -1;
+		}
 	}
 
-	/* Send and save errno */
+	/* Send and save errno. */
 	sent = send(fd, buffer, size, 0);
 	saved_err = errno;
 
-	/* Restore original signal action */
-	if (sigaction(SIGPIPE, &oldact, NULL)) {
-		perror("sigaction");
-		sent = -1;
-		goto end;
-	}
+	if (sent == -1 && errno == EPIPE && !sigpipe_was_pending) {
+		struct timespec timeout = { 0, 0 };
+		int ret;
 
+		do {
+			ret = sigtimedwait(&sigpipe_set, NULL,
+				&timeout);
+		} while (ret == -1 && errno == EINTR);
+	}
+	if (!sigpipe_was_pending) {
+		if (pthread_sigmask(SIG_SETMASK, &old_set, NULL)) {
+			return -1;
+		}
+	}
 	/* Restore send() errno */
 	errno = saved_err;
 end:
-- 
2.1.4
