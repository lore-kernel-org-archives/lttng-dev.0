From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: handle negative clock
	offset for lttng-ust metadata
Date: Mon,  8 Feb 2016 17:13:25 -0500
Message-ID: <1454969606-17225-1-git-send-email-mathieu.desnoyers__23778.1717013151$1454969667$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1aSu3t-0007zb-F3
 for lttng-dev@lists.lttng.org; Mon, 08 Feb 2016 17:13:38 -0500
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

In the unlikely situation where a system sets its hardware clock
(CLOCK_REALTIME) to 0 (Epoch) after boot, the difference

  monotonic - realtime

becomes negative.

Fixup this situation by returning a 0 offset in this case.

This ensures that trace viewer implementations (e.g. babeltrace) which
currently cannot handle the negative offset (known bug) still work with
the generated traces.

This patch should be applied to master and stable-2.7.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-metadata.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-metadata.c b/src/bin/lttng-sessiond/ust-metadata.c
index 984d5f8..f7c8b9d 100644
--- a/src/bin/lttng-sessiond/ust-metadata.c
+++ b/src/bin/lttng-sessiond/ust-metadata.c
@@ -604,11 +604,17 @@ int _lttng_event_header_declare(struct ust_registry_session *session)
 	);
 }
 
+/*
+ * The offset between monotonic and realtime clock can be negative if
+ * the system sets the REALTIME clock to 0 after boot.
+ * Currently handle this by flooring the offset at 0.
+ */
 static
 int measure_single_clock_offset(struct offset_sample *sample)
 {
-	uint64_t offset, monotonic[2], measure_delta, realtime;
+	uint64_t monotonic_avg, monotonic[2], measure_delta, realtime;
 	uint64_t tcf = trace_clock_freq();
+	int64_t offset;
 	struct timespec rts = { 0, 0 };
 	int ret;
 
@@ -626,15 +632,18 @@ int measure_single_clock_offset(struct offset_sample *sample)
 		 */
 		return 0;
 	}
-	offset = (monotonic[0] + monotonic[1]) >> 1;
+	monotonic_avg = (monotonic[0] + monotonic[1]) >> 1;
 	realtime = (uint64_t) rts.tv_sec * tcf;
 	if (tcf == NSEC_PER_SEC) {
 		realtime += rts.tv_nsec;
 	} else {
 		realtime += (uint64_t) rts.tv_nsec * tcf / NSEC_PER_SEC;
 	}
-	offset = realtime - offset;
-	sample->offset = offset;
+	offset = (int64_t) realtime - monotonic_avg;
+	if (offset < 0)
+		sample->offset = 0;
+	else
+		sample->offset = offset;
 	sample->measure_delta = measure_delta;
 	return 0;
 }
-- 
2.1.4
