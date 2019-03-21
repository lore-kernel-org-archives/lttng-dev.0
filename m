From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools v2] Change lttng_poll_wait behaviour
 of compat-poll to match compat-epoll
Date: Thu, 21 Mar 2019 11:04:51 -0400
Message-ID: <20190321150453.7312-6-ylamarre__15073.9505699434$1553180817$gmane$org@efficios.com>
References: <20190321150453.7312-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44Q97g1FYzz187X
 for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2019 11:05:03 -0400 (EDT)
In-Reply-To: <20190321150453.7312-1-ylamarre@efficios.com>
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
 src/common/compat/compat-poll.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-poll.c
index b7c17df7..6aa9414d 100644
--- a/src/common/compat/compat-poll.c
+++ b/src/common/compat/compat-poll.c
@@ -292,6 +292,7 @@ error:
 int compat_poll_wait(struct lttng_poll_event *events, int timeout)
 {
 	int ret;
+	int eidx = 0;
 
 	if (events == NULL || events->current.events == NULL) {
 		ERR("poll wait arguments error");
@@ -324,10 +325,36 @@ int compat_poll_wait(struct lttng_poll_event *events, int timeout)
 	}
 
 	/*
-	 * poll() should always iterate on all FDs since we handle the pollset in
-	 * user space and after poll returns, we have to try every fd for a match.
+	 * Swap all nonzero revents pollfd structs to the beginning of the array to
+	 * emulate compat-epoll behaviour. This algorithm takes advantage of poll's
+	 * returned value and the burst nature of waking events on the file
+	 * descriptors. The while loop garantees that idlepfd will always point to
+	 * a pollfd with revents == 0.
 	 */
-	return events->wait.nb_fd;
+	if (ret == events->wait.nb_fd) {
+		goto skip;
+	}
+	while (eidx < ret && events->wait.events[eidx].revents != 0) {
+		eidx += 1;
+	}
+
+	for (int idx = eidx + 1; eidx < ret; idx++) {
+		struct pollfd swapfd;
+		struct pollfd *idlepfd = &events->wait.events[eidx];
+		struct pollfd *ipfd = &events->wait.events[idx];
+
+		assert(idx < events->wait.nb_fd);
+
+		if (ipfd->revents != 0) {
+			swapfd = *ipfd;
+			*ipfd = *idlepfd;
+			*idlepfd = swapfd;
+			eidx += 1;
+		}
+	}
+
+skip:
+	return ret;
 
 error:
 	return -1;
-- 
2.11.0
