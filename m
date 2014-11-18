From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 2/2] Fix: sanity check in iterator
	creation
Date: Tue, 18 Nov 2014 12:52:32 -0500
Message-ID: <1416333152-12536-2-git-send-email-jdesfossez__20952.9940075756$1416333202$gmane$org@efficios.com>
References: <1416333152-12536-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XqmxH-0001dG-BG
 for lttng-dev@lists.lttng.org; Tue, 18 Nov 2014 12:52:46 -0500
In-Reply-To: <1416333152-12536-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This function is part of the API, so we need more sanity checks before
using the structures provided by the caller.

Refs: #827

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 lib/iterator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/iterator.c b/lib/iterator.c
index d2464ab..540d5e9 100644
--- a/lib/iterator.c
+++ b/lib/iterator.c
@@ -720,7 +720,7 @@ int bt_iter_init(struct bt_iter *iter,
 	int i;
 	int ret = 0;
 
-	if (!iter || !ctx)
+	if (!iter || !ctx || !ctx->tc || !ctx->tc->array)
 		return -EINVAL;
 
 	if (ctx->current_iterator) {
-- 
1.9.1
