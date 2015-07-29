From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH lttng-modules v3 1/3] Do not override the pipe
	syscall on MIPS.
Date: Wed, 29 Jul 2015 12:04:57 +0200
Message-ID: <1438164299-11526-2-git-send-email-larper__42695.4777598896$1438164513$gmane$org@axis.com>
References: <1438164299-11526-1-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bes.se.axis.com ([195.60.68.10])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <lars.persson@axis.com>) id 1ZKOEa-0004Ve-JR
 for lttng-dev@lists.lttng.org; Wed, 29 Jul 2015 06:05:17 -0400
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 1F17B2E4A8
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jul 2015 12:05:07 +0200 (CEST)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id gUs+paqSyEvr for <lttng-dev@lists.lttng.org>;
 Wed, 29 Jul 2015 12:05:06 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id 9FA972E33E
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jul 2015 12:05:06 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 861181031
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jul 2015 12:05:06 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id 778B1CF4
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jul 2015 12:05:06 +0200 (CEST)
In-Reply-To: <1438164299-11526-1-git-send-email-larper@axis.com>
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
 instrumentation/syscalls/headers/syscalls_pointers_override.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/instrumentation/syscalls/headers/syscalls_pointers_override.h b/instrumentation/syscalls/headers/syscalls_pointers_override.h
index a552908..85cb2e8 100644
--- a/instrumentation/syscalls/headers/syscalls_pointers_override.h
+++ b/instrumentation/syscalls/headers/syscalls_pointers_override.h
@@ -41,6 +41,7 @@ SC_LTTNG_TRACEPOINT_EVENT(getcpu,
 	)
 )
 
+#ifndef CONFIG_CPU_MIPS32
 #define OVERRIDE_32_pipe
 #define OVERRIDE_64_pipe
 SC_LTTNG_TRACEPOINT_EVENT(pipe,
@@ -50,6 +51,7 @@ SC_LTTNG_TRACEPOINT_EVENT(pipe,
 		sc_out(ctf_user_array(int, fildes, fildes, 2))
 	)
 )
+#endif
 
 #define OVERRIDE_32_pipe2
 #define OVERRIDE_64_pipe2
-- 
2.1.4
