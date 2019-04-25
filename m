From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools v5 6/8] Change lttng_poll_wait
 behaviour of compat-poll to match compat-epoll
Date: Thu, 25 Apr 2019 10:36:18 -0400
Message-ID: <20190425143620.3348-7-ylamarre__14372.6618540072$1556203180$gmane$org@efficios.com>
References: <20190425143620.3348-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44qfrb3r9dz1KSv
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 10:36:31 -0400 (EDT)
In-Reply-To: <20190425143620.3348-1-ylamarre@efficios.com>
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

This removes the need to verify for idle file descriptors and mitigates
risks of bug due to behaviour mismatch.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
Iterator declaration moved to the begining of function.
 src/common/compat/compat-poll.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-poll.c
index 2318920a..0220b278 100644
--- a/src/common/compat/compat-poll.c
+++ b/src/common/compat/compat-poll.c
@@ -293,7 +293,9 @@ error:
  */
 int compat_poll_wait(struct lttng_poll_event *events, int timeout)
 {
-	int ret;
+	int ret, active_fd_count;
+	int idle_pfd_index = 0;
+	size_t i;
 
 	if (events == NULL || events->current.events == NULL) {
 		ERR("poll wait arguments error");
@@ -325,11 +327,39 @@ int compat_poll_wait(struct lttng_poll_event *events, int timeout)
 		goto error;
 	}
 
+	active_fd_count = ret;
+
 	/*
-	 * poll() should always iterate on all FDs since we handle the pollset in
-	 * user space and after poll returns, we have to try every fd for a match.
+	 * Swap all active pollfd structs to the beginning of the
+	 * array to emulate compat-epoll behaviour. This algorithm takes
+	 * advantage of poll's returned value and the burst nature of active
+	 * events on the file descriptors. The while loop guarantees that
+	 * idle_pfd will always point to an idle fd.
 	 */
-	return events->wait.nb_fd;
+	if (active_fd_count == events->wait.nb_fd) {
+		goto end;
+	}
+	while (idle_pfd_index < active_fd_count &&
+			events->wait.events[idle_pfd_index].revents != 0) {
+		idle_pfd_index++;
+	}
+
+	for (i = idle_pfd_index + 1; idle_pfd_index < active_fd_count;
+			i++) {
+		struct pollfd swap_pfd;
+		struct pollfd *idle_pfd = &events->wait.events[idle_pfd_index];
+		struct pollfd *current_pfd = &events->wait.events[i];
+
+		if (ipfd->revents != 0) {
+			swap_pfd = *current_pfd;
+			*current_pfd = *idle_pfd;
+			*idle_pfd = swap_pfd;
+			idle_pfd_index++;
+		}
+	}
+
+end:
+	return ret;
 
 error:
 	return -1;
-- 
2.11.0
