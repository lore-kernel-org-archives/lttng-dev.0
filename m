From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools v6 1/8] Fix: lttng_poll_mod calls
 compat_(e)poll_add
Date: Thu, 25 Apr 2019 18:23:27 -0400
Message-ID: <20190425222334.30349-2-ylamarre__20479.6984953404$1556231145$gmane$org@efficios.com>
References: <20190425222334.30349-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44qsCn0Bygz1L3n
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 18:23:49 -0400 (EDT)
In-Reply-To: <20190425222334.30349-1-ylamarre@efficios.com>
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

lttng_poll_mod should call compat_(e)poll_mod.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/common/compat/poll.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
index d4bd87f5..fde54ddb 100644
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
@@ -361,7 +361,7 @@ extern int compat_poll_del(struct lttng_poll_event *events, int fd);
 extern int compat_poll_mod(struct lttng_poll_event *events,
 		int fd, uint32_t req_events);
 #define lttng_poll_mod(events, fd, req_events) \
-	compat_poll_add(events, fd, req_events)
+	compat_poll_mod(events, fd, req_events)
 
 /*
  * Set up the poll set limits variable poll_max_size
-- 
2.11.0
