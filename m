From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: [RFC PATCH lttng-tools] callsite: add "ip" context
Date: Wed, 10 Jul 2013 11:06:45 +0200
Message-ID: <91594846.t4zsffeB9Q__44077.8702650734$1373447242$gmane$org@atv-pwoegere-l3.atv.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1UwqMP-00015q-J3
	for lttng-dev@lists.lttng.org; Wed, 10 Jul 2013 05:06:53 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This follow-up patch provides the necessary bits to allow
specifying context "ip" for the add-context command.

Thanks,
Paul

--
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division


From 4d968927ebee90173f31b11594620d1ba5a40fd9 Mon Sep 17 00:00:00 2001
From: Paul Woegerer <paul_woegerer@mentor.com>
Date: Wed, 10 Jul 2013 09:16:29 +0200
Subject: [PATCH] callsite: add "ip" context

Support ip context in lttng add-context -t.
---
 include/lttng/lttng.h                  | 1 +
 src/bin/lttng-sessiond/lttng-ust-abi.h | 1 +
 src/bin/lttng-sessiond/trace-ust.c     | 3 +++
 src/bin/lttng/commands/add_context.c   | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
index 8323245..3e7fb63 100644
--- a/include/lttng/lttng.h
+++ b/include/lttng/lttng.h
@@ -126,6 +126,7 @@ enum lttng_event_context_type {
 	LTTNG_EVENT_CONTEXT_VPPID             = 9,
 	LTTNG_EVENT_CONTEXT_PTHREAD_ID        = 10,
 	LTTNG_EVENT_CONTEXT_HOSTNAME          = 11,
+	LTTNG_EVENT_CONTEXT_IP                = 12,
 };
 
 enum lttng_calibrate_type {
diff --git a/src/bin/lttng-sessiond/lttng-ust-abi.h b/src/bin/lttng-sessiond/lttng-ust-abi.h
index 03d2e65..6326b1e 100644
--- a/src/bin/lttng-sessiond/lttng-ust-abi.h
+++ b/src/bin/lttng-sessiond/lttng-ust-abi.h
@@ -139,6 +139,7 @@ enum lttng_ust_context_type {
 	LTTNG_UST_CONTEXT_VPID			= 1,
 	LTTNG_UST_CONTEXT_PTHREAD_ID		= 2,
 	LTTNG_UST_CONTEXT_PROCNAME		= 3,
+	LTTNG_UST_CONTEXT_IP			= 4,
 };
 
 #define LTTNG_UST_CONTEXT_PADDING1	16
diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index 65fe84b..77f5e25 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -432,6 +432,9 @@ struct ltt_ust_context *trace_ust_create_context(
 	case LTTNG_EVENT_CONTEXT_PROCNAME:
 		utype = LTTNG_UST_CONTEXT_PROCNAME;
 		break;
+	case LTTNG_EVENT_CONTEXT_IP:
+		utype = LTTNG_UST_CONTEXT_IP;
+		break;
 	default:
 		ERR("Invalid UST context");
 		return NULL;
diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/commands/add_context.c
index 4904d27..fad85b5 100644
--- a/src/bin/lttng/commands/add_context.c
+++ b/src/bin/lttng/commands/add_context.c
@@ -67,6 +67,7 @@ enum context_type {
 	CONTEXT_VPPID        = 9,
 	CONTEXT_PTHREAD_ID   = 10,
 	CONTEXT_HOSTNAME     = 11,
+	CONTEXT_IP           = 12,
 };
 
 /*
@@ -203,6 +204,7 @@ const struct ctx_opts {
 	{ "ppid", CONTEXT_PPID },
 	{ "vppid", CONTEXT_VPPID },
 	{ "hostname", CONTEXT_HOSTNAME },
+	{ "ip", CONTEXT_IP },
 	/* Perf options */
 	PERF_HW(cpu-cycles, CPU_CYCLES),
 	PERF_HW(cycles, CPU_CYCLES),
-- 
1.8.1.4
