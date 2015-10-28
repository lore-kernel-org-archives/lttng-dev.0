From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2 stable-2.6] Fix: rculfhash
	should not include specific rcu flavor
Date: Wed, 28 Oct 2015 15:55:57 -0400
Message-ID: <1446062158-1807-1-git-send-email-mathieu.desnoyers__22525.4730125473$1446062225$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZrWpM-0007Q3-UB
 for lttng-dev@lists.lttng.org; Wed, 28 Oct 2015 15:56:09 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/hashtable/rculfhash.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/common/hashtable/rculfhash.c b/src/common/hashtable/rculfhash.c
index ff7e681..e11c654 100644
--- a/src/common/hashtable/rculfhash.c
+++ b/src/common/hashtable/rculfhash.c
@@ -264,9 +264,10 @@
 #include <stdint.h>
 #include <string.h>
 #include <sched.h>
+#include <unistd.h>
 
 #include "config.h"
-#include <urcu.h>
+#include <urcu-pointer.h>
 #include <urcu-call-rcu.h>
 #include <urcu/arch.h>
 #include <urcu/uatomic.h>
-- 
2.1.4
