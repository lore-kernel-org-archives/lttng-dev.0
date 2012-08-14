From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH LTTng-UST] Fix UST SIGPIPE handling
Date: Tue, 14 Aug 2012 16:15:31 -0400
Message-ID: <20120814201531.GA8827__34771.7602541254$1344975368$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T1NWX-0008TI-JA
	for lttng-dev@lists.lttng.org; Tue, 14 Aug 2012 16:15:33 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com, christian.babeux@efficios.com, jdesfossez@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

When the consumerd dies (from a SIGKILL), it may close all of its file
descriptors rather abruptly.

We ensured that the UST command threads have all signals blocked, and
they use MSG_NOSIGNAL when sending messages to the sessiond over
sockets.

However, the consumer scheme uses a pipe(2) to transport the "wakeup"
info from the application tracing site to the consumer daemon. It may
send a SIGPIPE to the application in that case, which could kill the
application, an unwanted side-effect.

Block thread SIGPIPE around write() and wait for the signal to fix this.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/libringbuffer/frontend_internal.h b/libringbuffer/frontend_internal.h
index 6d1a75b..020b785 100644
--- a/libringbuffer/frontend_internal.h
+++ b/libringbuffer/frontend_internal.h
@@ -32,6 +32,8 @@
  */
 
 #include <urcu/compiler.h>
+#include <signal.h>
+#include <pthread.h>
 
 #include <lttng/ringbuffer-config.h>
 #include "backend_types.h"
@@ -397,7 +399,9 @@ void lib_ring_buffer_check_deliver(const struct lttng_ust_lib_ring_buffer_config
 				int wakeup_fd = shm_get_wakeup_fd(handle, &buf->self._ref);
 
 				if (wakeup_fd >= 0) {
-					int ret;
+					sigset_t sigpipe_set, pending_set, old_set;
+					int ret, sigpipe_was_pending = 0;
+
 					/*
 					 * Wake-up the other end by
 					 * writing a null byte in the
@@ -416,13 +420,56 @@ void lib_ring_buffer_check_deliver(const struct lttng_ust_lib_ring_buffer_config
 					 * 2) check if there is data in
 					 *    the buffer.
 					 * 3) wait on the pipe (poll).
+					 *
+					 * Discard the SIGPIPE from write(), not
+					 * disturbing any SIGPIPE that might be
+					 * already pending. If a bogus SIGPIPE
+					 * is sent to the entire process
+					 * concurrently by a malicious user, it
+					 * may be simply discarded.
+					 */
+					ret = sigemptyset(&pending_set);
+					assert(!ret);
+					/*
+					 * sigpending returns the mask
+					 * of signals that are _both_
+					 * blocked for the thread _and_
+					 * pending for either the thread
+					 * or the entire process.
 					 */
+					ret = sigpending(&pending_set);
+					assert(!ret);
+					sigpipe_was_pending = sigismember(&pending_set, SIGPIPE);
+					/*
+					 * if the sigpipe was pending,
+					 * it means it was already
+					 * blocked, so no need to block
+					 * it.
+					 */
+					if (!sigpipe_was_pending) {
+						ret = sigemptyset(&sigpipe_set);
+						assert(!ret);
+						ret = sigaddset(&sigpipe_set, SIGPIPE);
+						assert(!ret);
+						ret = pthread_sigmask(SIG_BLOCK, &sigpipe_set, &old_set);
+						assert(!ret);
+					}
 					do {
 						ret = write(wakeup_fd, "", 1);
 					} while (ret == -1L && errno == EINTR);
+					if (ret == -1L && errno == EPIPE && !sigpipe_was_pending) {
+						struct timespec timeout = { 0, 0 };
+						do {
+							ret = sigtimedwait(&sigpipe_set, NULL,
+								&timeout);
+						} while (ret == -1L && errno == EINTR);
+					}
+					if (!sigpipe_was_pending) {
+						ret = pthread_sigmask(SIG_SETMASK, &old_set, NULL);
+						assert(!ret);
+					}
 				}
 			}
-
 		}
 	}
 }

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
