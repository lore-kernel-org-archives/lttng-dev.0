From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools v2 05/20] Clean-up: Remove
 unused structure
Date: Wed,  1 May 2019 15:34:29 -0400
Message-ID: <20190501193444.17403-6-ylamarre__25272.8700915881$1556739842$gmane$org@efficios.com>
References: <20190501193444.17403-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44vTBC5GjGz1Khw
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2019 15:34:59 -0400 (EDT)
In-Reply-To: <20190501193444.17403-1-ylamarre@efficios.com>
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
 src/common/sessiond-comm/sessiond-comm.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 84d87808..f9f6f97b 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -782,21 +782,6 @@ struct lttcomm_consumer_status_channel {
 #include <lttng/ust-abi.h>
 
 /*
- * Data structure for the commands sent from sessiond to UST.
- */
-struct lttcomm_ust_msg {
-	uint32_t handle;
-	uint32_t cmd;
-	union {
-		struct lttng_ust_channel channel;
-		struct lttng_ust_stream stream;
-		struct lttng_ust_event event;
-		struct lttng_ust_context context;
-		struct lttng_ust_tracer_version version;
-	} u;
-} LTTNG_PACKED;
-
-/*
  * Data structure for the response from UST to the session daemon.
  * cmd_type is sent back in the reply for validation.
  */
-- 
2.11.0
