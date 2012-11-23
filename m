From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-modules 1/2] Fix compilation for 3.0
	branch (>= 3.0.39).
Date: Fri, 23 Nov 2012 17:56:08 -0500
Message-ID: <1353711369-8449-1-git-send-email-simon.marchi__47290.7954630957$1353711413$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1Tc2AW-0002Yr-7T
	for lttng-dev@lists.lttng.org; Fri, 23 Nov 2012 17:56:20 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

The isolate_mode_t type that appeared in 3.2 was backported to 3.0.39 so
the version check must be fixed. It was not backported to the 3.1 branch
though, so it must be excluded.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 probes/lttng-probe-vmscan.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/probes/lttng-probe-vmscan.c b/probes/lttng-probe-vmscan.c
index 2abd0e4..0205c7e 100644
--- a/probes/lttng-probe-vmscan.c
+++ b/probes/lttng-probe-vmscan.c
@@ -30,6 +30,8 @@
  */
 #include <trace/events/vmscan.h>
 
+#include "../lttng-kernel-version.h"
+
 /*
  * Create LTTng tracepoint probes.
  */
@@ -37,7 +39,8 @@
 #define CREATE_TRACE_POINTS
 #define TRACE_INCLUDE_PATH ../instrumentation/events/lttng-module
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0))
+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(3,0,38)) || \
+	LTTNG_KERNEL_RANGE(3,1,0, 3,1,10)
 typedef int isolate_mode_t;
 #endif
 
-- 
1.7.1
