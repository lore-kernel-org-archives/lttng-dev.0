From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Bump LTTNG_UST_ABI to 8.0
Date: Tue, 30 Apr 2019 14:59:51 -0400
Message-ID: <20190430185951.12050-1-mathieu.desnoyers__17357.1269189537$1556650815$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44trSD4zfGz1KZN
 for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2019 14:59:56 -0400 (EDT)
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/lttng-ust-abi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/lttng-ust-abi.h b/src/bin/lttng-sessiond/lttng-ust-abi.h
index 687eb0b2..40ba1f47 100644
--- a/src/bin/lttng-sessiond/lttng-ust-abi.h
+++ b/src/bin/lttng-sessiond/lttng-ust-abi.h
@@ -44,8 +44,8 @@
 #define LTTNG_UST_COMM_MAGIC			0xC57C57C5
 
 /* Version for ABI between liblttng-ust, sessiond, consumerd */
-#define LTTNG_UST_ABI_MAJOR_VERSION		7
-#define LTTNG_UST_ABI_MINOR_VERSION		2
+#define LTTNG_UST_ABI_MAJOR_VERSION		8
+#define LTTNG_UST_ABI_MINOR_VERSION		0
 
 struct lttng_ust_calibrate;
 
-- 
2.11.0
