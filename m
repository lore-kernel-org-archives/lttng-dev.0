From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] Cleanup: Remove misplaced config.h include
Date: Tue, 7 Aug 2012 10:43:18 -0400
Message-ID: <20120807144318.GA30155__39756.1556696475$1344350624$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Syl0C-0005zV-MN
	for lttng-dev@lists.lttng.org; Tue, 07 Aug 2012 10:43:20 -0400
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

config.h should _always_ be included first, before system headers, to
ensure coherent size_t across the file.

We force the config.h inclusion by the compiler, so this is not an issue
(configure.ac: DEFAULT_INCLUDES="-I\$(top_srcdir) -I\$(top_builddir)
-I\$(top_builddir)/src -I\$(top_builddir)/include -include config.h"),
but let's remove this misleading line of code.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/common/hashtable/rculfhash.c b/src/common/hashtable/rculfhash.c
index 776f9f3..423d186 100644
--- a/src/common/hashtable/rculfhash.c
+++ b/src/common/hashtable/rculfhash.c
@@ -157,7 +157,6 @@
 #include <stdint.h>
 #include <string.h>
 
-#include "config.h"
 #include <urcu.h>
 #include <urcu-call-rcu.h>
 #include <urcu/arch.h>

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
