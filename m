From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/1] Fix: relayd: handling of
 lttng_read errors >= 0
Date: Wed,  3 Apr 2019 16:26:45 -0400
Message-ID: <20190403202645.29404-1-mathieu.desnoyers__11917.8090988257$1554323229$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44ZHg02yPSz1Kgv
 for <lttng-dev@lists.lttng.org>; Wed,  3 Apr 2019 16:26:52 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

errno is only set when lttng_read returns a negative value. Else, we
need to print a ERR() statement rather than use PERROR().

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/index/index.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/common/index/index.c b/src/common/index/index.c
index 12d54e00..9bfb56fa 100644
--- a/src/common/index/index.c
+++ b/src/common/index/index.c
@@ -171,10 +171,14 @@ int lttng_index_file_read(const struct lttng_index_file *index_file,
 	}
 
 	ret = lttng_read(fd, element, len);
-	if (ret < len) {
+	if (ret < 0) {
 		PERROR("read index file");
 		goto error;
 	}
+	if (ret < len) {
+		ERR("lttng_read expected %zu, returned %zd", len, ret);
+		goto error;
+	}
 	return 0;
 
 error:
-- 
2.17.1
