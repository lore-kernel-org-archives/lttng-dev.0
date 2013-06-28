From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [LTTng-modules PATCH] The msg part of the
	printk:console event was 1 character too long
Date: Fri, 28 Jun 2013 15:32:34 -0400
Message-ID: <1372447954-4360-1-git-send-email-yannick.brosseau__38181.8414120518$1372448005$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UsePW-0007ZS-Nf
	for lttng-dev@lists.lttng.org; Fri, 28 Jun 2013 15:32:46 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so2365072obb.29
	for <lttng-dev@lists.lttng.org>; Fri, 28 Jun 2013 12:32:41 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 instrumentation/events/lttng-module/printk.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/printk.h b/instrumentation/events/lttng-module/printk.h
index 4c744f9..f4b6028 100644
--- a/instrumentation/events/lttng-module/printk.h
+++ b/instrumentation/events/lttng-module/printk.h
@@ -19,7 +19,7 @@ TRACE_EVENT_CONDITION(console,
 
 	TP_STRUCT__entry(
 		__dynamic_array_text(char, msg,
-			min_t(unsigned, end - start, MSG_TRACE_MAX_LEN) + 1)
+			min_t(unsigned, end - start, MSG_TRACE_MAX_LEN))
 	),
 
 	TP_fast_assign(
-- 
1.7.10.4
