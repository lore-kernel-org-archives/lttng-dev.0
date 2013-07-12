From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Missing NULL pointer init in tap.c
Date: Fri, 12 Jul 2013 11:41:08 -0400
Message-ID: <20130712154108.GA16307__7894.90470565415$1373643709$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UxfT6-0002ZX-Uw
	for lttng-dev@lists.lttng.org; Fri, 12 Jul 2013 11:41:13 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Could lead to free() of unitialized pointer.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/tests/utils/tap/tap.c b/tests/utils/tap/tap.c
index a430951..86c89a2 100644
--- a/tests/utils/tap/tap.c
+++ b/tests/utils/tap/tap.c
@@ -294,7 +294,7 @@ int
 skip(unsigned int n, char *fmt, ...)
 {
 	va_list ap;
-	char *skip_msg;
+	char *skip_msg = NULL;
 
 	LOCK;
 
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
