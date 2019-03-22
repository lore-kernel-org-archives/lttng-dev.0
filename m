From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools v3 3/8] Change LTTNG_POLL_GETNB
 behaviour for poll flavor
Date: Fri, 22 Mar 2019 14:19:23 -0400
Message-ID: <20190322181928.6186-3-ylamarre__38786.9956948393$1553278929$gmane$org@efficios.com>
References: <20190322181928.6186-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44QsPm11Ygz18Sw
 for <lttng-dev@lists.lttng.org>; Fri, 22 Mar 2019 14:19:39 -0400 (EDT)
In-Reply-To: <20190322181928.6186-1-ylamarre@efficios.com>
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

Modify LTTNG_POLL_GETNB to provide compatibility with the epoll flavor.
Since it is only used after a lttng_poll_wait call with no modification
(add, del, mod) between, this change does not modify the behaviour in
its current usage while ensuring similar API behavior between
compatibility layer implementations.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/common/compat/poll.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
index fde54ddb..5eb7ff9c 100644
--- a/src/common/compat/poll.h
+++ b/src/common/compat/poll.h
@@ -315,10 +315,12 @@ static inline int __lttng_poll_get_prev_fd(struct lttng_poll_event *events,
 /*
  * For the following calls, consider 'e' to be a lttng_poll_event pointer and i
  * being the index of the events array.
+ * LTTNG_POLL_GETNB is always used after lttng_poll_wait, thus we can use the
+ * current list for test compatibility purposes.
  */
 #define LTTNG_POLL_GETFD(e, i) LTTNG_REF(e)->wait.events[i].fd
 #define LTTNG_POLL_GETEV(e, i) LTTNG_REF(e)->wait.events[i].revents
-#define LTTNG_POLL_GETNB(e) LTTNG_REF(e)->wait.nb_fd
+#define LTTNG_POLL_GETNB(e) LTTNG_REF(e)->current.nb_fd
 #define LTTNG_POLL_GETSZ(e) LTTNG_REF(e)->wait.events_size
 #define LTTNG_POLL_GET_PREV_FD(e, i, nb_fd) \
 	__lttng_poll_get_prev_fd(LTTNG_REF(e), i, nb_fd)
-- 
2.11.0
