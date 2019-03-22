From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools v3 5/8] Fix hang in thread_rotation
 when using compat-poll
Date: Fri, 22 Mar 2019 14:19:25 -0400
Message-ID: <20190322181928.6186-5-ylamarre__18922.2490343795$1553278828$gmane$org@efficios.com>
References: <20190322181928.6186-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44QsPf5BbMz18S2
 for <lttng-dev@lists.lttng.org>; Fri, 22 Mar 2019 14:19:34 -0400 (EDT)
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

Add missing verification to prevent a blocking read on an empty fd.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/bin/lttng-sessiond/rotation-thread.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/bin/lttng-sessiond/rotation-thread.c b/src/bin/lttng-sessiond/rotation-thread.c
index 6669372d..b86b1668 100644
--- a/src/bin/lttng-sessiond/rotation-thread.c
+++ b/src/bin/lttng-sessiond/rotation-thread.c
@@ -974,6 +974,10 @@ void *thread_rotation(void *data)
 			int fd = LTTNG_POLL_GETFD(&thread.events, i);
 			uint32_t revents = LTTNG_POLL_GETEV(&thread.events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
 			DBG("[rotation-thread] Handling fd (%i) activity (%u)",
 					fd, revents);
 
-- 
2.11.0
