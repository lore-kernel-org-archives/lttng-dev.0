From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: measure UST clock offset with
	best sample (v2)
Date: Thu, 30 Jan 2014 17:06:30 -0500
Message-ID: <1391119590-16367-1-git-send-email-mathieu.desnoyers__49797.405410982$1391119677$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1W8zl1-0003pb-4k
	for lttng-dev@lists.lttng.org; Thu, 30 Jan 2014 17:06:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 1F20D340189
	for <lttng-dev@lists.lttng.org>; Thu, 30 Jan 2014 22:06:45 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Fixes #729

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-metadata.c |   55 ++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-metadata.c b/src/bin/lttng-sessiond/ust-metadata.c
index b0f83d2..f430ae1 100644
--- a/src/bin/lttng-sessiond/ust-metadata.c
+++ b/src/bin/lttng-sessiond/ust-metadata.c
@@ -37,6 +37,13 @@
 #define max_t(type, a, b)	((type) ((a) > (b) ? (a) : (b)))
 #endif
 
+#define NR_CLOCK_OFFSET_SAMPLES		10
+
+struct offset_sample {
+	uint64_t offset;		/* correlation offset */
+	uint64_t measure_delta;		/* lower is better */
+};
+
 static inline
 int fls(unsigned int x)
 {
@@ -490,31 +497,57 @@ int _lttng_event_header_declare(struct ust_registry_session *session)
 	);
 }
 
-/*
- * Approximation of NTP time of day to clock monotonic correlation,
- * taken at start of trace.
- * Yes, this is only an approximation. Yes, we can (and will) do better
- * in future versions.
- */
 static
-uint64_t measure_clock_offset(void)
+int measure_single_clock_offset(struct offset_sample *sample)
 {
-	uint64_t offset, monotonic[2], realtime;
+	uint64_t offset, monotonic[2], measure_delta, realtime;
 	struct timespec rts = { 0, 0 };
 	int ret;
 
 	monotonic[0] = trace_clock_read64();
 	ret = clock_gettime(CLOCK_REALTIME, &rts);
-	if (ret < 0)
-		return 0;
+	if (ret < 0) {
+		return ret;
+	}
 	monotonic[1] = trace_clock_read64();
+	measure_delta = monotonic[1] - monotonic[0];
+	if (measure_delta > sample->measure_delta) {
+		/*
+		 * Discard value if it took longer to read than the best
+		 * sample so far.
+		 */
+		return 0;
+	}
 	offset = (monotonic[0] + monotonic[1]) >> 1;
 	realtime = (uint64_t) rts.tv_sec * 1000000000ULL;
 	realtime += rts.tv_nsec;
 	offset = realtime - offset;
-	return offset;
+	sample->offset = offset;
+	sample->measure_delta = measure_delta;
+	return 0;
 }
 
+/*
+ * Approximation of NTP time of day to clock monotonic correlation,
+ * taken at start of trace. Keep the measurement that took the less time
+ * to complete, thus removing imprecision caused by preemption.
+ */
+static
+uint64_t measure_clock_offset(void)
+{
+	int i;
+	struct offset_sample offset_best_sample = {
+		.offset = 0,
+		.measure_delta = UINT64_MAX,
+	};
+
+	for (i = 0; i < NR_CLOCK_OFFSET_SAMPLES; i++) {
+		if (measure_single_clock_offset(&offset_best_sample)) {
+			return 0;
+		}
+	}
+	return offset_best_sample.offset;
+}
 
 /*
  * Should be called with session registry mutex held.
-- 
1.7.10.4
