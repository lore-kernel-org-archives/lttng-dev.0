From: Mohamad Gebai <mohamad.gebai@gmail.com>
Subject: [PATCH lttng-ust] Fix linking warning.
Date: Fri, 27 Sep 2013 15:44:08 -0400
Message-ID: <1380311048-2013-1-git-send-email-mohamad.gebai__32941.6284141645$1380311115$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mohamad.gebai@gmail.com>) id 1VPdxf-0001j2-SK
	for lttng-dev@lists.lttng.org; Fri, 27 Sep 2013 15:44:26 -0400
Received: by mail-ie0-f175.google.com with SMTP id e14so4841253iej.20
	for <lttng-dev@lists.lttng.org>; Fri, 27 Sep 2013 12:44:16 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Mohamad Gebai <mohamad.gebai@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

lttng_static_ctx should be extern in this header to avoid getting a
warning when --warn-common is used.

PS: Thanks to Yannick Brosseau for his help.

Signed-off-by: Mohamad Gebai <mohamad.gebai@polymtl.ca>
---
 include/lttng/ust-events.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
index 74a3bc6..c563511 100644
--- a/include/lttng/ust-events.h
+++ b/include/lttng/ust-events.h
@@ -543,7 +543,7 @@ int lttng_attach_context(struct lttng_ust_context *context_param,
 		struct lttng_ctx **ctx, struct lttng_session *session);
 void lttng_context_init(void);
 void lttng_context_exit(void);
-struct lttng_ctx *lttng_static_ctx;	/* Used by filtering */
+extern struct lttng_ctx *lttng_static_ctx;	/* Used by filtering */
 
 void lttng_transport_register(struct lttng_transport *transport);
 void lttng_transport_unregister(struct lttng_transport *transport);
-- 
1.7.10.4
