From: Yannick Lamarre <ylamarre@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix typo
Date: Mon, 18 Feb 2019 09:51:27 -0500 (EST)
Message-ID: <1005193472.139.1550501487781.JavaMail.zimbra__3632.70841059915$1550501509$gmane$org@efficios.com>
References: <20190215211423.7077-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 4436JQ3BzJzgP1
 for <lttng-dev@lists.lttng.org>; Mon, 18 Feb 2019 09:51:34 -0500 (EST)
In-Reply-To: <20190215211423.7077-1-ylamarre@efficios.com>
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

Forget about this patch, here is v2 [1].


[1] https://lists.lttng.org/pipermail/lttng-dev/2019-February/028528.html

----- Original Message -----
From: "Yannick Lamarre" <ylamarre@efficios.com>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
Sent: Friday, February 15, 2019 4:14:23 PM
Subject: [lttng-dev] [PATCH lttng-tools] Fix typo

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/common/compat/poll.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
index d4bd87f5..ad5bca21 100644
--- a/src/common/compat/poll.h
+++ b/src/common/compat/poll.h
@@ -177,7 +177,7 @@ extern int compat_epoll_del(struct lttng_poll_event *events, int fd);
 extern int compat_epoll_mod(struct lttng_poll_event *events,
 		int fd, uint32_t req_events);
 #define lttng_poll_mod(events, fd, req_events) \
-	compat_epoll_add(events, fd, req_events)
+	compat_epoll_mod(events, fd, req_events)
 
 /*
  * Set up the poll set limits variable poll_max_size
@@ -356,12 +356,12 @@ extern int compat_poll_del(struct lttng_poll_event *events, int fd);
 	compat_poll_del(events, fd)
 
 /*
- * Modify an fd's events in the epoll set.
+ * Modify an fd's events in the poll set.
  */
 extern int compat_poll_mod(struct lttng_poll_event *events,
 		int fd, uint32_t req_events);
 #define lttng_poll_mod(events, fd, req_events) \
-	compat_poll_add(events, fd, req_events)
+	compat_poll_mod(events, fd, req_events)
 
 /*
  * Set up the poll set limits variable poll_max_size
-- 
2.11.0

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
