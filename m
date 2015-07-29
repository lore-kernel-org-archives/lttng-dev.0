From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH lttng-modules v2 3/3] Use 3.18 syscall
	instrumentation for MIPS32.
Date: Wed, 29 Jul 2015 11:58:55 +0200
Message-ID: <1438163935-8906-4-git-send-email-larper__3590.69418996132$1438164027$gmane$org@axis.com>
References: <1438163935-8906-1-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bastet.se.axis.com ([195.60.68.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <lars.persson@axis.com>) id 1ZKO8m-0004Lv-Fb
 for lttng-dev@lists.lttng.org; Wed, 29 Jul 2015 05:59:15 -0400
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id A285618199
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jul 2015 11:59:04 +0200 (CEST)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id qVgbGniKTHK3 for <lttng-dev@lists.lttng.org>;
 Wed, 29 Jul 2015 11:59:04 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id 3FD2618172
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jul 2015 11:59:04 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 28B3D1031
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jul 2015 11:59:04 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id 1CC09DDB
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jul 2015 11:59:04 +0200 (CEST)
In-Reply-To: <1438163935-8906-1-git-send-email-larper@axis.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Lars Persson <larper@axis.com>
List-Id: lttng-dev@lists.lttng.org

---
 instrumentation/syscalls/headers/syscalls_integers.h | 2 +-
 instrumentation/syscalls/headers/syscalls_pointers.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/instrumentation/syscalls/headers/syscalls_integers.h b/instrumentation/syscalls/headers/syscalls_integers.h
index 2992439..8cccccf 100644
--- a/instrumentation/syscalls/headers/syscalls_integers.h
+++ b/instrumentation/syscalls/headers/syscalls_integers.h
@@ -15,5 +15,5 @@
 #endif
 
 #ifdef CONFIG_CPU_MIPS32
-#include "mips-32-syscalls-3.13.0_integers.h"
+#include "mips-32-syscalls-3.18.0_integers.h"
 #endif
diff --git a/instrumentation/syscalls/headers/syscalls_pointers.h b/instrumentation/syscalls/headers/syscalls_pointers.h
index 9fde85a..ab95df8 100644
--- a/instrumentation/syscalls/headers/syscalls_pointers.h
+++ b/instrumentation/syscalls/headers/syscalls_pointers.h
@@ -15,5 +15,5 @@
 #endif
 
 #ifdef CONFIG_CPU_MIPS32
-#include "mips-32-syscalls-3.13.0_pointers.h"
+#include "mips-32-syscalls-3.18.0_pointers.h"
 #endif
-- 
2.1.4
