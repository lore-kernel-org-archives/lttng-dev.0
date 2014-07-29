From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: out of tree build by
	adding missing ini.c include
Date: Tue, 29 Jul 2014 18:10:27 -0400
Message-ID: <1406671828-27743-1-git-send-email-mathieu.desnoyers__13312.9894421019$1406671884$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XCFba-0006uc-Fc
 for lttng-dev@lists.lttng.org; Tue, 29 Jul 2014 18:10:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 45461340261
 for <lttng-dev@lists.lttng.org>; Tue, 29 Jul 2014 22:10:50 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/config/ini.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/common/config/ini.c b/src/common/config/ini.c
index 4369a32..7b2a4b6 100644
--- a/src/common/config/ini.c
+++ b/src/common/config/ini.c
@@ -31,9 +31,11 @@
  * http://code.google.com/p/inih/
  */
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <ctype.h>
 #include <string.h>
+#include <common/common.h>
 
 #include "ini.h"
 
-- 
2.0.1
