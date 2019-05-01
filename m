From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools v2 06/20] Clean-up: Removed
 deprecated field
Date: Wed,  1 May 2019 15:34:30 -0400
Message-ID: <20190501193444.17403-7-ylamarre__29009.0910204285$1556739751$gmane$org@efficios.com>
References: <20190501193444.17403-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44vTB91Jzyz1Kcj
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2019 15:34:57 -0400 (EDT)
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

The command using this field was dropped in 2.9, but the field was
left in the union.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/common/sessiond-comm/sessiond-comm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index f9f6f97b..ac59d770 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -421,7 +421,6 @@ struct lttcomm_session_msg {
 		struct {
 			char channel_name[LTTNG_SYMBOL_NAME_LEN];
 		} LTTNG_PACKED list;
-		struct lttng_calibrate calibrate;
 		/* Used by the set_consumer_url and used by create_session also call */
 		struct {
 			/* Number of lttng_uri following */
-- 
2.11.0
