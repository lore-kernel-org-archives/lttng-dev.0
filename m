From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 2/3] Fix: signal: Remove
 SEND_SIG_FORCED (v4.20)
Date: Mon,  5 Nov 2018 11:35:53 -0500
Message-ID: <20181105163554.32095-2-mjeanson__23774.7088926428$1541435666$gmane$org@efficios.com>
References: <20181105163554.32095-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42pdbN3nD6zqmR
 for <lttng-dev@lists.lttng.org>; Mon,  5 Nov 2018 11:36:00 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 30621248E15
 for <lttng-dev@lists.lttng.org>; Mon,  5 Nov 2018 11:36:00 -0500 (EST)
In-Reply-To: <20181105163554.32095-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

See upstream commit :

  commit 4ff4c31a6e85f4c49fbeebeaa28018d002884b5a
  Author: Eric W. Biederman <ebiederm@xmission.com>
  Date:   Mon Sep 3 10:39:04 2018 +0200

    signal: Remove SEND_SIG_FORCED

    There are no more users of SEND_SIG_FORCED so it may be safely removed.

    Remove the definition of SEND_SIG_FORCED, it's use in is_si_special,
    it's use in TP_STORE_SIGINFO, and it's use in __send_signal as without
    any users the uses of SEND_SIG_FORCED are now unncessary.

    This makes the code simpler, easier to understand and use.  Users of
    signal sending functions now no longer need to ask themselves do I
    need to use SEND_SIG_FORCED.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/signal.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/instrumentation/events/lttng-module/signal.h b/instrumentation/events/lttng-module/signal.h
index 6c484ba..7e9631d 100644
--- a/instrumentation/events/lttng-module/signal.h
+++ b/instrumentation/events/lttng-module/signal.h
@@ -13,6 +13,17 @@
 #include <linux/signal.h>
 #include <linux/sched.h>
 #undef LTTNG_FIELDS_SIGINFO
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,20,0))
+#define LTTNG_FIELDS_SIGINFO(info)				\
+		ctf_integer(int, errno,				\
+			(info == SEND_SIG_NOINFO || info == SEND_SIG_PRIV) ? \
+			0 :					\
+			info->si_errno)				\
+		ctf_integer(int, code,				\
+			(info == SEND_SIG_NOINFO) ? 		\
+			SI_USER : 				\
+			((info == SEND_SIG_PRIV) ? SI_KERNEL : info->si_code))
+#else /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,20,0) */
 #define LTTNG_FIELDS_SIGINFO(info)				\
 		ctf_integer(int, errno,				\
 			(info == SEND_SIG_NOINFO || info == SEND_SIG_FORCED || info == SEND_SIG_PRIV) ? \
@@ -22,6 +33,7 @@
 			(info == SEND_SIG_NOINFO || info == SEND_SIG_FORCED) ? \
 			SI_USER : 				\
 			((info == SEND_SIG_PRIV) ? SI_KERNEL : info->si_code))
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,20,0) */
 #endif /* _TRACE_SIGNAL_DEF */
 
 /**
-- 
2.17.1
