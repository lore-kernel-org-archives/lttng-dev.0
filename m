From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: health check and time
Date: Mon, 23 Jul 2012 15:12:05 -0400
Message-ID: <20120723191204.GA12711__39884.6131786287$1343070762$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1StO34-0007Ea-P3
	for lttng-dev@lists.lttng.org; Mon, 23 Jul 2012 15:12:06 -0400
Content-Disposition: inline
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

I notice that currently, the health check code does not have a notion of
"time flow": therefore, two consecutive calls to lttng_health_check()
might end up returning a bad state (0) just because there was too little
time between the invocations.

However, the lttng.h documentation states:

/*
 * Check session daemon health for a specific component.
 *
 * Return 0 if health is OK or 1 if BAD. A returned value of -1 indicate that
 * the control library was not able to connect to the session daemon health
 * socket.
 *
 * Any other positive value is an lttcomm error which can be translate with
 * lttng_strerror().
 */
extern int lttng_health_check(enum lttng_health_component c);

Therefore, the user would expect that handling the time flow in between
the invocation is dealth with internally, which is what I remember we
agreed on.

So we would need to add some time information to the "last" snapshot, so
we can do a time delta between the current and last snapshot to figure
out if we need to report the thread as stalled or not.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: David Goulet <dgoulet@efficios.com>
---
diff --git a/src/bin/lttng-sessiond/health.c b/src/bin/lttng-sessiond/health.c
index d7d25cf..cbda651 100644
--- a/src/bin/lttng-sessiond/health.c
+++ b/src/bin/lttng-sessiond/health.c
@@ -20,12 +20,58 @@
 #include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <time.h>
 
 #include <common/error.h>
 
 #include "health.h"
 
 /*
+ * If a thread stalls for this amount of time, it will be considered
+ * bogus (bad health).
+ */
+#define HEALTH_CHECK_DELTA_S	20
+#define HEALTH_CHECK_DELTA_NS	0
+
+static const struct timespec time_delta = {
+	.tv_sec = HEALTH_CHECK_DELTA_S,
+	.tv_nsec = HEALTH_CHECK_DELTA_NS,
+};
+
+static
+void time_diff(const struct timespec *time_a, const struct timespec *time_b,
+		struct timespec *res)
+{
+	if (time_a->tv_nsec - time_b->tv_nsec < 0) {
+		res->tv_sec = time_a->tv_sec - time_b->tv_sec - 1;
+		res->tv_nsec = 1000000000L + time_a->tv_sec - time_b->tv_sec;
+	} else {
+		res->tv_sec = time_a->tv_sec - time_b->tv_sec;
+		res->tv_nsec = time_a->tv_sec - time_b->tv_sec;
+	}
+}
+
+/*
+ * Return true if time_a - time_b > diff, else false.
+ */
+static
+int time_diff_gt(const struct timespec *time_a, const struct timespec *time_b,
+		const struct timespec *diff)
+{
+	struct timespec res;
+
+	time_diff(time_a, time_b, &res);
+	time_diff(&res, diff, &res);
+	if (res.tv_sec > 0) {
+		return 1;
+	}
+	if (res.tv_sec == 0 && res.tv_nsec > 0) {
+		return 1;
+	}
+	return 0;
+}
+
+/*
  * Check health of a specific health state counter.
  *
  * Return 0 if health is bad or else 1.
@@ -33,28 +79,55 @@
 int health_check_state(struct health_state *state)
 {
 	unsigned long current, last;
-	int ret = 1;
+	struct timespec current_time;
+	int retval = 1, ret;
 
 	assert(state);
 
 	last = state->last;
 	current = uatomic_read(&state->current);
+	ret = clock_gettime(CLOCK_MONOTONIC, &current_time);
+	if (ret) {
+		PERROR("Error reading time\n");
+		/* error */
+		retval = 0;
+		goto end;
+	}
 
 	/*
-	 * Here are the conditions for a bad health. Either flag
-	 * HEALTH_ERROR is set, or the progress counter is the same as
-	 * the last one and we are NOT waiting for a poll() call.
+	 * Thread is in are in bad health if flag HEALTH_ERROR is set. It
+	 * is also in bad health if, after the delta delay has passed,
+	 * its the progress counter has not moved and it has NOT been
+	 * waiting for a poll() call.
 	 */
-	if ((uatomic_read(&state->flags) & HEALTH_ERROR)
-			|| (current == last && !HEALTH_IS_IN_POLL(current))) {
-		/* error */
-		ret = 0;
+	if (uatomic_read(&state->flags) & HEALTH_ERROR) {
+		retval = 0;
+		goto end;
+	}
+
+	/*
+	 * Initial condition need to update the last counter and sample
+	 * time, but should not check health in this initial case,
+	 * because we don't know how much time has passed.
+	 */
+	if (state->last_time.tv_sec == 0 && state->last_time.tv_nsec == 0) {
+		/* update last counter and last sample time */
+		state->last = current;
+		memcpy(&state->last_time, &current_time, sizeof(current_time));
+	} else {
+		if (time_diff_gt(&current_time, &state->last_time, &time_delta)) {
+			if (current == last && !HEALTH_IS_IN_POLL(current)) {
+				/* error */
+				retval = 0;
+			}
+			/* update last counter and last sample time */
+			state->last = current;
+			memcpy(&state->last_time, &current_time, sizeof(current_time));
+		}
 	}
 
+end:
 	DBG("Health state current %" PRIu64 ", last %" PRIu64 ", ret %d",
 			current, last, ret);
-
-	/* update last counter */
-	state->last = current;
-	return ret;
+	return retval;
 }
diff --git a/src/bin/lttng-sessiond/health.h b/src/bin/lttng-sessiond/health.h
index b268860..8f19fe8 100644
--- a/src/bin/lttng-sessiond/health.h
+++ b/src/bin/lttng-sessiond/health.h
@@ -20,6 +20,7 @@
 
 #include <stdint.h>
 #include <urcu/uatomic.h>
+#include <time.h>
 
 /*
  * These are the value added to the current state depending of the position in
@@ -37,10 +38,12 @@ enum health_flags {
 
 struct health_state {
 	/*
-	 * last counter is only read and updated by the health_check
-	 * thread (single updater).
+	 * last counter and last_time are only read and updated by the
+	 * health_check thread (single updater).
 	 */
 	unsigned long last;
+	struct timespec last_time;
+
 	/*
 	 * current and flags are updated by multiple threads concurrently.
 	 */
@@ -104,7 +107,9 @@ static inline void health_error(struct health_state *state)
 static inline void health_init(struct health_state *state)
 {
 	assert(state);
-	uatomic_set(&state->last, 0);
+	state->last = 0;
+	state->last_time.tv_sec = 0;
+	state->last_time.tv_nsec = 0;
 	uatomic_set(&state->current, 0);
 	uatomic_set(&state->flags, 0);
 }


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
