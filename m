From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH lttng-modules 3/3] Use 3.18 syscall
	instrumentation for MIPS32.
Date: Mon,  9 Feb 2015 11:49:18 +0100
Message-ID: <1423478958-10776-4-git-send-email-larper__33609.8690437668$1423479061$gmane$org@axis.com>
References: <1423478958-10776-1-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bes.se.axis.com ([195.60.68.10])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <lars.persson@axis.com>) id 1YKluH-0006Hb-PX
 for lttng-dev@lists.lttng.org; Mon, 09 Feb 2015 05:49:35 -0500
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 48E242E116
 for <lttng-dev@lists.lttng.org>; Mon,  9 Feb 2015 11:49:28 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id MeI4tbNzzPis for <lttng-dev@lists.lttng.org>;
 Mon,  9 Feb 2015 11:49:27 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id 380C42E3E4
 for <lttng-dev@lists.lttng.org>; Mon,  9 Feb 2015 11:49:27 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 06CDDF57
 for <lttng-dev@lists.lttng.org>; Mon,  9 Feb 2015 11:49:27 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id D9B53A67
 for <lttng-dev@lists.lttng.org>; Mon,  9 Feb 2015 11:49:26 +0100 (CET)
In-Reply-To: <1423478958-10776-1-git-send-email-larper@axis.com>
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


Signed-off-by: Lars Persson <larper@axis.com>
---
 instrumentation/syscalls/headers/syscalls_integers.h |    2 +-
 instrumentation/syscalls/headers/syscalls_pointers.h |    2 +-
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
1.7.10.4
