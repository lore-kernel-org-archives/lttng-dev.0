From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools 02/18] Clean-up: Switch enum
 fields in lttcomm_consumer_msg
Date: Thu, 18 Apr 2019 12:18:34 -0400
Message-ID: <20190418161850.1536-3-ylamarre__10857.5492793292$1555604413$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44lPS31H73z1JmD
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 12:18:59 -0400 (EDT)
In-Reply-To: <20190418161850.1536-1-ylamarre@efficios.com>
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
 src/common/sessiond-comm/sessiond-comm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 556c277f..43a57736 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -564,7 +564,7 @@ struct lttcomm_consumer_msg {
 			uint32_t nb_init_streams;
 			char name[LTTNG_SYMBOL_NAME_LEN];
 			/* Use splice or mmap to consume this fd */
-			enum lttng_event_output output;
+			uint32_t output; /* enum lttng_event_output */
 			int type; /* Per cpu or metadata. */
 			uint64_t tracefile_size; /* bytes */
 			uint32_t tracefile_count; /* number of tracefiles */
@@ -591,7 +591,7 @@ struct lttcomm_consumer_msg {
 		} LTTNG_PACKED stream;	/* Only used by Kernel. */
 		struct {
 			uint64_t net_index;
-			enum lttng_stream_type type;
+			uint32_t type; /* enum lttng_stream_type */
 			/* Open socket to the relayd */
 			struct lttcomm_relayd_sock_serialized sock;
 			/* Tracing session id associated to the relayd. */
-- 
2.11.0
