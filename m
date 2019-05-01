From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools v2 03/20] Clean-up: Switch enum
 fields in lttcomm_consumer_status_msg
Date: Wed,  1 May 2019 15:34:27 -0400
Message-ID: <20190501193444.17403-4-ylamarre__29972.8302912385$1556739903$gmane$org@efficios.com>
References: <20190501193444.17403-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44vTBD6qTKz1KjF
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2019 15:35:00 -0400 (EDT)
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

Size of an enum type is not guaranteed by the C spec, which is why the
field's tpye is replaced to uin32_t.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/common/sessiond-comm/sessiond-comm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 47ade871..c6ec8eed 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -768,7 +768,7 @@ struct lttcomm_consumer_channel_monitor_msg {
  * Status message returned to the sessiond after a received command.
  */
 struct lttcomm_consumer_status_msg {
-	enum lttcomm_return_code ret_code;
+	uint32_t ret_code; /* enum lttcomm_return_code */
 } LTTNG_PACKED;
 
 struct lttcomm_consumer_status_channel {
-- 
2.11.0
