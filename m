From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Code cleanup in contexts
Date: Thu, 14 Mar 2019 12:31:35 -0400
Message-ID: <20190314163135.24046-1-mjeanson__47079.3268688553$1552581121$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44KvNx5PWqz15ww
 for <lttng-dev@lists.lttng.org>; Thu, 14 Mar 2019 12:31:45 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id C125F13470C
 for <lttng-dev@lists.lttng.org>; Thu, 14 Mar 2019 12:31:44 -0400 (EDT)
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 liblttng-ust/lttng-context-cpu-id.c        |  5 +----
 liblttng-ust/lttng-context-perf-counters.c |  5 +----
 liblttng-ust/lttng-context-procname.c      | 10 ++--------
 liblttng-ust/lttng-context-pthread-id.c    |  5 +----
 4 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/liblttng-ust/lttng-context-cpu-id.c b/liblttng-ust/lttng-context-cpu-id.c
index 7cbf3cea..a3252f15 100644
--- a/liblttng-ust/lttng-context-cpu-id.c
+++ b/liblttng-ust/lttng-context-cpu-id.c
@@ -61,10 +61,7 @@ static
 void cpu_id_get_value(struct lttng_ctx_field *field,
 		struct lttng_ctx_value *value)
 {
-	int cpu;
-
-	cpu = lttng_ust_get_cpu();
-	value->u.s64 = cpu;
+	value->u.s64 = lttng_ust_get_cpu();
 }
 
 int lttng_add_cpu_id_to_ctx(struct lttng_ctx **ctx)
diff --git a/liblttng-ust/lttng-context-perf-counters.c b/liblttng-ust/lttng-context-perf-counters.c
index a15417cc..4816f89b 100644
--- a/liblttng-ust/lttng-context-perf-counters.c
+++ b/liblttng-ust/lttng-context-perf-counters.c
@@ -367,10 +367,7 @@ static
 void perf_counter_get_value(struct lttng_ctx_field *field,
 		struct lttng_ctx_value *value)
 {
-	uint64_t v;
-
-	v = wrapper_perf_counter_read(field);
-	value->u.s64 = v;
+	value->u.s64 = wrapper_perf_counter_read(field);
 }
 
 /* Called with UST lock held */
diff --git a/liblttng-ust/lttng-context-procname.c b/liblttng-ust/lttng-context-procname.c
index 8c1520ad..c6d02cf6 100644
--- a/liblttng-ust/lttng-context-procname.c
+++ b/liblttng-ust/lttng-context-procname.c
@@ -78,10 +78,7 @@ void lttng_context_procname_reset(void)
 static
 size_t procname_get_size(struct lttng_ctx_field *field, size_t offset)
 {
-	size_t size = 0;
-
-	size += LTTNG_UST_PROCNAME_LEN;
-	return size;
+	return LTTNG_UST_PROCNAME_LEN;
 }
 
 static
@@ -99,10 +96,7 @@ static
 void procname_get_value(struct lttng_ctx_field *field,
 		struct lttng_ctx_value *value)
 {
-	char *procname;
-
-	procname = wrapper_getprocname();
-	value->u.str = procname;
+	value->u.str = wrapper_getprocname();
 }
 
 int lttng_add_procname_to_ctx(struct lttng_ctx **ctx)
diff --git a/liblttng-ust/lttng-context-pthread-id.c b/liblttng-ust/lttng-context-pthread-id.c
index 552100de..5f9faf85 100644
--- a/liblttng-ust/lttng-context-pthread-id.c
+++ b/liblttng-ust/lttng-context-pthread-id.c
@@ -52,10 +52,7 @@ static
 void pthread_id_get_value(struct lttng_ctx_field *field,
 		struct lttng_ctx_value *value)
 {
-	unsigned long pthread_id;
-
-	pthread_id = (unsigned long) pthread_self();
-	value->u.s64 = pthread_id;
+	value->u.s64 = (unsigned long) pthread_self();
 }
 
 int lttng_add_pthread_id_to_ctx(struct lttng_ctx **ctx)
-- 
2.17.1
