From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH lttng-modules 2/2] Use kernel 3.13 syscall
	tables for MIPS32
Date: Sun, 16 Mar 2014 17:32:34 +0100
Message-ID: <1394987554-29338-2-git-send-email-larper__15373.2585757554$1394987642$gmane$org@axis.com>
References: <1394987554-29338-1-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bes.se.axis.com ([195.60.68.10])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <lars.persson@axis.com>) id 1WPDzv-00050D-9C
	for lttng-dev@lists.lttng.org; Sun, 16 Mar 2014 12:33:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id D8BAB2E53E
	for <lttng-dev@lists.lttng.org>; Sun, 16 Mar 2014 17:33:09 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id IGuShgpea1TU for <lttng-dev@lists.lttng.org>;
	Sun, 16 Mar 2014 17:33:08 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id E56D82E53C
	for <lttng-dev@lists.lttng.org>; Sun, 16 Mar 2014 17:33:08 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id CE77CBCB
	for <lttng-dev@lists.lttng.org>; Sun, 16 Mar 2014 17:33:08 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id C332570F
	for <lttng-dev@lists.lttng.org>; Sun, 16 Mar 2014 17:33:08 +0100 (CET)
In-Reply-To: <1394987554-29338-1-git-send-email-larper@axis.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
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
 .../syscalls/headers/syscalls_integers.h           |    4 ++++
 .../syscalls/headers/syscalls_pointers.h           |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/instrumentation/syscalls/headers/syscalls_integers.h b/instrumentation/syscalls/headers/syscalls_integers.h
index ce0409f..2992439 100644
--- a/instrumentation/syscalls/headers/syscalls_integers.h
+++ b/instrumentation/syscalls/headers/syscalls_integers.h
@@ -13,3 +13,7 @@
 #ifdef CONFIG_PPC
 #include "powerpc-32-syscalls-3.0.34_integers.h"
 #endif
+
+#ifdef CONFIG_CPU_MIPS32
+#include "mips-32-syscalls-3.13.0_integers.h"
+#endif
diff --git a/instrumentation/syscalls/headers/syscalls_pointers.h b/instrumentation/syscalls/headers/syscalls_pointers.h
index f5ca566..9fde85a 100644
--- a/instrumentation/syscalls/headers/syscalls_pointers.h
+++ b/instrumentation/syscalls/headers/syscalls_pointers.h
@@ -13,3 +13,7 @@
 #ifdef CONFIG_PPC
 #include "powerpc-32-syscalls-3.0.34_pointers.h"
 #endif
+
+#ifdef CONFIG_CPU_MIPS32
+#include "mips-32-syscalls-3.13.0_pointers.h"
+#endif
-- 
1.7.2.5
