From: Alexander Grigoriev <alexgri@tbricks.com>
Subject: [PATCH lttng-tools] Fix: Fail to add several
	perf_thread context
Date: Sun,  2 Nov 2014 02:14:45 +0300
Message-ID: <1414883685-25069-1-git-send-email-alexgri__29873.2794043191$1414883760$gmane$org@tbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexgri@tbricks.com>) id 1Xkht5-0004Qr-Pw
 for lttng-dev@lists.lttng.org; Sat, 01 Nov 2014 19:15:17 -0400
Received: by mail-lb0-f178.google.com with SMTP id f15so8479392lbj.23
 for <lttng-dev@lists.lttng.org>; Sat, 01 Nov 2014 16:15:09 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Alexander Grigoriev <alexgri@tbricks.com>, tav@tbricks.com
List-Id: lttng-dev@lists.lttng.org

In commit aa3514e96f12c13f681a81ea275dc51dd63473c8 not removed old check
for duplicate context type in create_ust_app_channel_context() function. If
the one of perf_tread contexts was already added, in the next
similar operation function returns error code EEXIST "UST context
already exist".

Signed-off-by: Alexander Grigoriev <alexgri@tbricks.com>
---
 src/bin/lttng-sessiond/ust-app.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index f8e9693..7f1594b 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1940,13 +1940,6 @@ int create_ust_app_channel_context(struct ust_app_session *ua_sess,
 
 	DBG2("UST app adding context to channel %s", ua_chan->name);
 
-	lttng_ht_lookup(ua_chan->ctx, (void *)((unsigned long)uctx->ctx), &iter);
-	node = lttng_ht_iter_get_node_ulong(&iter);
-	if (node != NULL) {
-		ret = -EEXIST;
-		goto error;
-	}
-
 	ua_ctx = alloc_ust_app_ctx(uctx);
 	if (ua_ctx == NULL) {
 		/* malloc failed */
-- 
1.9.1
