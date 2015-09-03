From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: add missing ust-elf.h header to
	dist
Date: Thu,  3 Sep 2015 16:14:41 -0400
Message-ID: <1441311281-3561-1-git-send-email-mjeanson__25930.5209074684$1441311354$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZXauL-0005kc-2S
 for lttng-dev@lists.lttng.org; Thu, 03 Sep 2015 16:14:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 82B56340475
 for <lttng-dev@lists.lttng.org>; Thu,  3 Sep 2015 20:14:48 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 include/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/Makefile.am b/include/Makefile.am
index 44102ef..3c9cf24 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -24,7 +24,8 @@ nobase_include_HEADERS = \
 	lttng/tracelog.h \
 	lttng/lttng-ust-tracelog.h \
 	lttng/ust-clock.h \
-	lttng/ust-getcpu.h
+	lttng/ust-getcpu.h \
+	lttng/ust-elf.h
 
 # note: usterr-signal-safe.h, core.h and share.h need namespace cleanup.
 
-- 
1.9.1
