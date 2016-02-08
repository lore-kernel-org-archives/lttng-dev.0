From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/2] clock offset: print negative
	value in metadata for lttng-ust metadata
Date: Mon,  8 Feb 2016 17:13:26 -0500
Message-ID: <1454969606-17225-2-git-send-email-mathieu.desnoyers__11679.489297285$1454969691$gmane$org@efficios.com>
References: <1454969606-17225-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1aSu3v-0007zc-4T
 for lttng-dev@lists.lttng.org; Mon, 08 Feb 2016 17:13:40 -0500
In-Reply-To: <1454969606-17225-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

In the upcoming 2.8, we can print the negative value of clock offset in
the metadata, and expect users to update their viewers to correct any
bug that could prevent them from handling those negative values.

This happens only in cases where the system sets CLOCK_REALTIME to 0
after boot, thus leading to a negative clock offset value between
realtime and monotonic clocks.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-metadata.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-metadata.c b/src/bin/lttng-sessiond/ust-metadata.c
index f7c8b9d..e5d4944 100644
--- a/src/bin/lttng-sessiond/ust-metadata.c
+++ b/src/bin/lttng-sessiond/ust-metadata.c
@@ -41,7 +41,7 @@
 #define NR_CLOCK_OFFSET_SAMPLES		10
 
 struct offset_sample {
-	uint64_t offset;		/* correlation offset */
+	int64_t offset;			/* correlation offset */
 	uint64_t measure_delta;		/* lower is better */
 };
 
@@ -607,14 +607,12 @@ int _lttng_event_header_declare(struct ust_registry_session *session)
 /*
  * The offset between monotonic and realtime clock can be negative if
  * the system sets the REALTIME clock to 0 after boot.
- * Currently handle this by flooring the offset at 0.
  */
 static
 int measure_single_clock_offset(struct offset_sample *sample)
 {
 	uint64_t monotonic_avg, monotonic[2], measure_delta, realtime;
 	uint64_t tcf = trace_clock_freq();
-	int64_t offset;
 	struct timespec rts = { 0, 0 };
 	int ret;
 
@@ -639,11 +637,7 @@ int measure_single_clock_offset(struct offset_sample *sample)
 	} else {
 		realtime += (uint64_t) rts.tv_nsec * tcf / NSEC_PER_SEC;
 	}
-	offset = (int64_t) realtime - monotonic_avg;
-	if (offset < 0)
-		sample->offset = 0;
-	else
-		sample->offset = offset;
+	sample->offset = (int64_t) realtime - monotonic_avg;
 	sample->measure_delta = measure_delta;
 	return 0;
 }
@@ -652,9 +646,10 @@ int measure_single_clock_offset(struct offset_sample *sample)
  * Approximation of NTP time of day to clock monotonic correlation,
  * taken at start of trace. Keep the measurement that took the less time
  * to complete, thus removing imprecision caused by preemption.
+ * May return a negative offset.
  */
 static
-uint64_t measure_clock_offset(void)
+int64_t measure_clock_offset(void)
 {
 	int i;
 	struct offset_sample offset_best_sample = {
@@ -802,7 +797,7 @@ int ust_metadata_session_statedump(struct ust_registry_session *session,
 		"	description = \"%s\";\n"
 		"	freq = %" PRIu64 "; /* Frequency, in Hz */\n"
 		"	/* clock value offset from Epoch is: offset * (1/freq) */\n"
-		"	offset = %" PRIu64 ";\n"
+		"	offset = %" PRId64 ";\n"
 		"};\n\n",
 		trace_clock_description(),
 		trace_clock_freq(),
-- 
2.1.4
