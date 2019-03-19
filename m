From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools 6/8] Change lttng_poll_wait
 behaviour of compat-poll to match compat-epoll
Date: Tue, 19 Mar 2019 17:17:33 -0400
Message-ID: <20190319211735.7187-7-ylamarre__10490.9161500231$1553030510$gmane$org@efficios.com>
References: <20190319211735.7187-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44P5Vc6MDMz17dH
 for <lttng-dev@lists.lttng.org>; Tue, 19 Mar 2019 17:17:44 -0400 (EDT)
In-Reply-To: <20190319211735.7187-1-ylamarre@efficios.com>
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

This removes the need to verify for eventless file descriptors and
mitigates risks of bug due to behaviour mismatch.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/common/compat/compat-poll.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-poll.c
index b7c17df7..27e2002b 100644
--- a/src/common/compat/compat-poll.c
+++ b/src/common/compat/compat-poll.c
@@ -292,6 +292,8 @@ error:
 int compat_poll_wait(struct lttng_poll_event *events, int timeout)
 {
 	int ret;
+	int count = 0, idx;
+	struct pollfd swapfd;
 
 	if (events == NULL || events->current.events == NULL) {
 		ERR("poll wait arguments error");
@@ -324,10 +326,28 @@ int compat_poll_wait(struct lttng_poll_event *events, int timeout)
 	}
 
 	/*
-	 * poll() should always iterate on all FDs since we handle the pollset in
-	 * user space and after poll returns, we have to try every fd for a match.
+	 * Swap all nonzero revents pollfd structs to the beginning of the array to
+	 * emulate cpmpat-epoll behaviour.
 	 */
-	return events->wait.nb_fd;
+	if ( ret != events->wait.nb_fd && ret != 0) {
+		while (count < ret && events->wait.events[count].revents != 0) {
+			count += 1;
+		}
+		idx = count + 1;
+		while (count < ret) {
+			if (events->wait.events[idx].revents != 0) {
+				swapfd = events->wait.events[idx];
+				events->wait.events[idx] = events->wait.events[count];
+				events->wait.events[count] = swapfd;
+				count += 1;
+			}
+			if (idx < (events->wait.nb_fd - 1)) {
+				idx += 1;
+			}
+		}
+	}
+
+	return ret;
 
 error:
 	return -1;
-- 
2.11.0
