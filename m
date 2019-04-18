From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools 03/18] Clean-up: Switch enum
 fields in lttcomm_consumer_status_msg
Date: Thu, 18 Apr 2019 12:18:35 -0400
Message-ID: <20190418161850.1536-4-ylamarre__4247.69142862118$1555604447$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44lPS32Hkkz1JmG
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
 src/common/sessiond-comm/sessiond-comm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 43a57736..1324f0b3 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -756,7 +756,7 @@ struct lttcomm_consumer_channel_monitor_msg {
  * Status message returned to the sessiond after a received command.
  */
 struct lttcomm_consumer_status_msg {
-	enum lttcomm_return_code ret_code;
+	uint32_t ret_code; /* enum lttcomm_return_code */
 } LTTNG_PACKED;
 
 struct lttcomm_consumer_status_channel {
-- 
2.11.0
