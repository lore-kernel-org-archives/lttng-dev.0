From: <maxin.john@enea.com>
Subject: [PATCH] lttng-module: sched.h: Fix compilation on 3.9
	kernel
Date: Fri, 22 Mar 2013 13:58:15 +0100
Message-ID: <1363957095-54785-1-git-send-email-maxin.john__26914.8060739555$1363971214$gmane$org@enea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <Maxin.John@enea.com>) id 1UJ1YN-0006aG-U1
	for lttng-dev@lists.lttng.org; Fri, 22 Mar 2013 08:58:40 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, "Maxin B. John" <maxin.john@enea.com>
List-Id: lttng-dev@lists.lttng.org

From: "Maxin B. John" <maxin.john@enea.com>

With commit 8bd75c77b7c6a3954140dd2e20346aef3efe4a35
included in 3.9-rc1 kernel, rt specific bits in "linux/sched.h"
were moved into new header file "linux/sched/rt.h".

Fixes this compilation error:
 CC [M]  /home/majo/lttng/lttng-modules/probes/lttng-probe-sched.o
...
/home/majo/lttng/lttng-modules/probes/../instrumentation/events/lttng-module
/../../../probes/../instrumentation/events/lttng-module/sched.h:
In function '__event_probe__sched_switch':
/home/majo/lttng/lttng-modules/probes/../instrumentation/events/lttng-module
/../../../probes/../instrumentation/events/lttng-module/sched.h:164:1:
error: 'MAX_RT_PRIO' undeclared (first use in this function)
...

Signed-off-by: Maxin B. John <maxin.john@enea.com>
---
 instrumentation/events/lttng-module/sched.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/instrumentation/events/lttng-module/sched.h b/instrumentation/events/lttng-module/sched.h
index e42acd2..25faad0 100644
--- a/instrumentation/events/lttng-module/sched.h
+++ b/instrumentation/events/lttng-module/sched.h
@@ -8,6 +8,9 @@
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
 #include <linux/version.h>
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0))
+#include <linux/sched/rt.h>
+#endif
 
 #ifndef _TRACE_SCHED_DEF_
 #define _TRACE_SCHED_DEF_
-- 
1.7.5.4
