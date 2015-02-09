From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH lttng-modules 1/3] Do not override the pipe
	syscall on MIPS.
Date: Mon,  9 Feb 2015 11:49:16 +0100
Message-ID: <1423478958-10776-2-git-send-email-larper__29095.14117423$1423479020$gmane$org@axis.com>
References: <1423478958-10776-1-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bastet.se.axis.com ([195.60.68.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <lars.persson@axis.com>) id 1YKluG-0006Ha-H0
 for lttng-dev@lists.lttng.org; Mon, 09 Feb 2015 05:49:33 -0500
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 0AA5F180C7
 for <lttng-dev@lists.lttng.org>; Mon,  9 Feb 2015 11:49:27 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id TQ5kmyA27dUn for <lttng-dev@lists.lttng.org>;
 Mon,  9 Feb 2015 11:49:26 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id 4F9D0180A6
 for <lttng-dev@lists.lttng.org>; Mon,  9 Feb 2015 11:49:26 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 37ADBF57
 for <lttng-dev@lists.lttng.org>; Mon,  9 Feb 2015 11:49:26 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id 2B143A67
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

MIPS has a non-standard calling convention for pipe.

Signed-off-by: Lars Persson <larper@axis.com>
---
 instrumentation/syscalls/headers/syscalls_pointers_override.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/instrumentation/syscalls/headers/syscalls_pointers_override.h b/instrumentation/syscalls/headers/syscalls_pointers_override.h
index 6d06098..22e3834 100644
--- a/instrumentation/syscalls/headers/syscalls_pointers_override.h
+++ b/instrumentation/syscalls/headers/syscalls_pointers_override.h
@@ -56,6 +56,7 @@ SC_LTTNG_TRACEPOINT_EVENT(getcpu,
 	TP_printk()
 )
 
+#ifndef CONFIG_CPU_MIPS32
 #define OVERRIDE_32_pipe
 #define OVERRIDE_64_pipe
 SC_LTTNG_TRACEPOINT_EVENT(pipe,
@@ -69,6 +70,7 @@ SC_LTTNG_TRACEPOINT_EVENT(pipe,
 	),
 	TP_printk()
 )
+#endif
 
 #define OVERRIDE_32_pipe2
 #define OVERRIDE_64_pipe2
-- 
1.7.10.4
