From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 2/3] Fix: Typo in
	LTTNG_FILTER_MAX_LEN
Date: Mon, 27 Aug 2012 14:48:20 -0400
Message-ID: <1346093301-25274-3-git-send-email-christian.babeux__25464.6977330141$1346093356$gmane$org@efficios.com>
References: <1346093301-25274-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-iy0-f176.google.com ([209.85.210.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1T64Ml-0004kh-LZ
	for lttng-dev@lists.lttng.org; Mon, 27 Aug 2012 14:48:51 -0400
Received: by mail-iy0-f176.google.com with SMTP id t4so10155357iag.35
	for <lttng-dev@lists.lttng.org>; Mon, 27 Aug 2012 11:48:51 -0700 (PDT)
In-Reply-To: <1346093301-25274-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng-sessiond/main.c            | 2 +-
 src/common/sessiond-comm/sessiond-comm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 318da74..730ac65 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -2659,7 +2659,7 @@ skip_domain:
 	{
 		struct lttng_filter_bytecode *bytecode;
 
-		if (cmd_ctx->lsm->u.filter.bytecode_len > 65336) {
+		if (cmd_ctx->lsm->u.filter.bytecode_len > LTTNG_FILTER_MAX_LEN) {
 			ret = LTTNG_ERR_FILTER_INVAL;
 			goto error;
 		}
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 32ce384..ff22875 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -208,7 +208,7 @@ struct lttcomm_session_msg {
 	} u;
 };
 
-#define LTTNG_FILTER_MAX_LEN	65336
+#define LTTNG_FILTER_MAX_LEN	65535
 
 /*
  * Filter bytecode data. The reloc table is located at the end of the
-- 
1.7.11.4
