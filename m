From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] fix: y2038: itimer: change
 implementation to timespec64 (v5.5)
Date: Tue, 10 Dec 2019 11:41:11 -0500
Message-ID: <20191210164114.26954-2-mjeanson__29773.7686590821$1575996137$gmane$org@efficios.com>
References: <20191210164114.26954-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47XQnP2wQQz15JF
 for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2019 11:41:45 -0500 (EST)
In-Reply-To: <20191210164114.26954-1-mjeanson@efficios.com>
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

See upstream commit:

  commit bd40a175769d411b2a37e1c087082ac7ee2c15bb
  Author: Arnd Bergmann <arnd@arndb.de>
  Date:   Thu Nov 7 15:27:39 2019 +0100

    y2038: itimer: change implementation to timespec64

    There is no 64-bit version of getitimer/setitimer since that is not
    actually needed. However, the implementation is built around the
    deprecated 'struct timeval' type.

    Change the code to use timespec64 internally to reduce the dependencies
    on timeval and associated helper functions.

    Minor adjustments in the code are needed to make the native and compat
    version work the same way, and to keep the range check working after
    the conversion.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/timer.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/timer.h b/instrumentation/events/lttng-module/timer.h
index 997084f..1a45d82 100644
--- a/instrumentation/events/lttng-module/timer.h
+++ b/instrumentation/events/lttng-module/timer.h
@@ -294,7 +294,26 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(timer_hrtimer_class, hrtimer_cancel,
  *		zero, otherwise it is started
  * @expires:	the itimers expiry time
  */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,11,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0))
+LTTNG_TRACEPOINT_EVENT_MAP(itimer_state,
+
+	timer_itimer_state,
+
+	TP_PROTO(int which, const struct itimerspec64 *const value,
+		 unsigned long long expires),
+
+	TP_ARGS(which, value, expires),
+
+	TP_FIELDS(
+		ctf_integer(int, which, which)
+		ctf_integer(unsigned long long, expires, expires)
+		ctf_integer(long, value_sec, value->it_value.tv_sec)
+		ctf_integer(long, value_nsec, value->it_value.tv_nsec)
+		ctf_integer(long, interval_sec, value->it_interval.tv_sec)
+		ctf_integer(long, interval_nsec, value->it_interval.tv_nsec)
+	)
+)
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,11,0))
 LTTNG_TRACEPOINT_EVENT_MAP(itimer_state,
 
 	timer_itimer_state,
-- 
2.17.1
