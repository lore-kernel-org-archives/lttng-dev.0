From: Tony Jones <tonyj@suse.com>
Subject: [RFC lttng-tools] Do not list or allow unsupported perf
	events
Date: Thu, 10 Sep 2015 12:21:32 -0700
Message-ID: <1441912892-30236-1-git-send-email-tonyj__25942.6928045743$1441913924$gmane$org@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx2.suse.de ([195.135.220.15])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <tonyj@suse.com>) id 1Za7Ph-0006gr-A7
 for lttng-dev@lists.lttng.org; Thu, 10 Sep 2015 15:21:43 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: David Goulet <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Query the perf api to determine the list of events that are actually
supported by the PMU.  Reject events that are not supported.   On an
AMD Opteron 6128 the following currently listed events are not supported:

	perf:bus-cycles, perf:L1-dcache-store-misses,
	perf:L1-icache-stores, perf:L1-icache-store-misses,
	perf:L1-icache-prefetch-misses, perf:LLC-store-misses,
	perf:LLC-prefetches, perf:LLC-prefetch-misses, perf:dTLB-stores,
	perf:dTLB-store-misses, perf:dTLB-prefetches,
	perf:dTLB-prefetch-misses

It's not clear to me (hence the RFC) why parts of the perf ABI definitions
had been replicated into add_context.c rather than just including
perf_event.h (other than to avoid an autotools dependancy/check on
perf_event.h which this patch still needs). It is also possible that 
querying the available events would be better handled over the lttng 
user->kernel ABI.

Thoughts?
---
 src/bin/lttng/commands/add_context.c | 92 ++++++++++--------------------------
 1 file changed, 25 insertions(+), 67 deletions(-)

diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/commands/add_context.c
index cf3f3ef..6f52edb 100644
--- a/src/bin/lttng/commands/add_context.c
+++ b/src/bin/lttng/commands/add_context.c
@@ -26,6 +26,8 @@
 #include <sys/types.h>
 #include <unistd.h>
 
+#include <linux/perf_event.h>
+
 #include <urcu/list.h>
 
 #include <common/mi-lttng.h>
@@ -77,72 +79,6 @@ enum context_type {
 	CONTEXT_PERF_THREAD_COUNTER = 14,
 };
 
-/*
- * Taken from the Perf ABI (all enum perf_*)
- */
-enum perf_type {
-	PERF_TYPE_HARDWARE = 0,
-	PERF_TYPE_SOFTWARE = 1,
-	PERF_TYPE_HW_CACHE = 3,
-};
-
-enum perf_count_hard {
-	PERF_COUNT_HW_CPU_CYCLES		= 0,
-	PERF_COUNT_HW_INSTRUCTIONS		= 1,
-	PERF_COUNT_HW_CACHE_REFERENCES		= 2,
-	PERF_COUNT_HW_CACHE_MISSES		= 3,
-	PERF_COUNT_HW_BRANCH_INSTRUCTIONS	= 4,
-	PERF_COUNT_HW_BRANCH_MISSES		= 5,
-	PERF_COUNT_HW_BUS_CYCLES		= 6,
-	PERF_COUNT_HW_STALLED_CYCLES_FRONTEND	= 7,
-	PERF_COUNT_HW_STALLED_CYCLES_BACKEND	= 8,
-};
-
-enum perf_count_soft {
-	PERF_COUNT_SW_CPU_CLOCK        = 0,
-	PERF_COUNT_SW_TASK_CLOCK       = 1,
-	PERF_COUNT_SW_PAGE_FAULTS      = 2,
-	PERF_COUNT_SW_CONTEXT_SWITCHES = 3,
-	PERF_COUNT_SW_CPU_MIGRATIONS   = 4,
-	PERF_COUNT_SW_PAGE_FAULTS_MIN  = 5,
-	PERF_COUNT_SW_PAGE_FAULTS_MAJ  = 6,
-	PERF_COUNT_SW_ALIGNMENT_FAULTS = 7,
-	PERF_COUNT_SW_EMULATION_FAULTS = 8,
-};
-
-/*
- * Generalized hardware cache events:
- *
- *       { L1-D, L1-I, LLC, ITLB, DTLB, BPU } x
- *       { read, write, prefetch } x
- *       { accesses, misses }
- */
-enum perf_hw_cache_id {
-	PERF_COUNT_HW_CACHE_L1D			= 0,
-	PERF_COUNT_HW_CACHE_L1I			= 1,
-	PERF_COUNT_HW_CACHE_LL			= 2,
-	PERF_COUNT_HW_CACHE_DTLB		= 3,
-	PERF_COUNT_HW_CACHE_ITLB		= 4,
-	PERF_COUNT_HW_CACHE_BPU			= 5,
-
-	PERF_COUNT_HW_CACHE_MAX,		/* non-ABI */
-};
-
-enum perf_hw_cache_op_id {
-	PERF_COUNT_HW_CACHE_OP_READ		= 0,
-	PERF_COUNT_HW_CACHE_OP_WRITE		= 1,
-	PERF_COUNT_HW_CACHE_OP_PREFETCH		= 2,
-
-	PERF_COUNT_HW_CACHE_OP_MAX,		/* non-ABI */
-};
-
-enum perf_hw_cache_op_result_id {
-	PERF_COUNT_HW_CACHE_RESULT_ACCESS	= 0,
-	PERF_COUNT_HW_CACHE_RESULT_MISS		= 1,
-
-	PERF_COUNT_HW_CACHE_RESULT_MAX,		/* non-ABI */
-};
-
 static struct poptOption long_options[] = {
 	/* longName, shortName, argInfo, argPtr, value, descrip, argDesc */
 	{"help",           'h', POPT_ARG_NONE, 0, OPT_HELP, 0, 0},
@@ -461,6 +397,25 @@ struct ctx_type_list {
 	.head = CDS_LIST_HEAD_INIT(ctx_type_list.head),
 };
 
+static int is_event_supported(const struct ctx_opts *ctx)
+{
+	int fd;
+	struct perf_event_attr attr = {
+		.type = ctx->u.perf.type,
+		.config = ctx->u.perf.config,
+		.disabled = 1
+	};
+
+	if (ctx->ctx_type == CONTEXT_PERF_CPU_COUNTER ||
+	    ctx->ctx_type == CONTEXT_PERF_THREAD_COUNTER) {
+		if ((fd = syscall(__NR_perf_event_open, &attr,  0, -1, -1, 0)) < 0)
+			return 0;
+
+		close(fd);
+	}
+	return 1;
+}
+
 /*
  * Pretty print context type.
  */
@@ -473,6 +428,8 @@ static void print_ctx_type(FILE *ofp)
 	fprintf(ofp, "%s", indent);
 	len = indent_len;
 	while (ctx_opts[i].symbol != NULL) {
+		if (!is_event_supported(&ctx_opts[i]))
+			goto next;
 		if (!ctx_opts[i].hide_help) {
 			if (len > indent_len) {
 				if (len + strlen(ctx_opts[i].symbol) + 2
@@ -486,6 +443,7 @@ static void print_ctx_type(FILE *ofp)
 			}
 			len += fprintf(ofp, "%s", ctx_opts[i].symbol);
 		}
+next:
 		i++;
 	}
 }
@@ -538,7 +496,7 @@ static int find_ctx_type_idx(const char *opt)
 	int ret = -1, i = 0;
 
 	while (ctx_opts[i].symbol != NULL) {
-		if (strcmp(opt, ctx_opts[i].symbol) == 0) {
+		if (strcmp(opt, ctx_opts[i].symbol) == 0 && is_event_supported(&ctx_opts[i])) {
 			ret = i;
 			goto end;
 		}
-- 
2.4.6
