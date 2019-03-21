From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools v2] Fix typo
Date: Thu, 21 Mar 2019 11:04:53 -0400
Message-ID: <20190321150453.7312-8-ylamarre__33914.0402547613$1553180848$gmane$org@efficios.com>
References: <20190321150453.7312-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44Q97g5CMSz187Z
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

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/common/compat/poll.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
index d2826b7a..c7bd0606 100644
--- a/src/common/compat/poll.h
+++ b/src/common/compat/poll.h
@@ -359,7 +359,7 @@ extern int compat_poll_del(struct lttng_poll_event *events, int fd);
 	compat_poll_del(events, fd)
 
 /*
- * Modify an fd's events in the epoll set.
+ * Modify an fd's events in the poll set.
  */
 extern int compat_poll_mod(struct lttng_poll_event *events,
 		int fd, uint32_t req_events);
-- 
2.11.0
