From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools v4 8/8] Fix typo
Date: Mon,  1 Apr 2019 13:59:25 -0400
Message-ID: <20190401175925.8512-9-ylamarre__24470.6063343742$1554141665$gmane$org@efficios.com>
References: <20190401175925.8512-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Y0V45xvRz17wv
 for <lttng-dev@lists.lttng.org>; Mon,  1 Apr 2019 13:59:40 -0400 (EDT)
In-Reply-To: <20190401175925.8512-1-ylamarre@efficios.com>
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

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/common/compat/poll.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
index 5eb7ff9c..d7020f36 100644
--- a/src/common/compat/poll.h
+++ b/src/common/compat/poll.h
@@ -358,7 +358,7 @@ extern int compat_poll_del(struct lttng_poll_event *events, int fd);
 	compat_poll_del(events, fd)
 
 /*
- * Modify an fd's events in the epoll set.
+ * Modify an fd's events in the poll set.
  */
 extern int compat_poll_mod(struct lttng_poll_event *events,
 		int fd, uint32_t req_events);
-- 
2.11.0
