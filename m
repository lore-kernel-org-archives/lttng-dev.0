From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH 2/2] urcu: add notice to URCU_TLS() for it is
	not async-signal-safe
Date: Wed, 8 Aug 2012 16:31:13 +0800
Message-ID: <1344414673-14714-2-git-send-email-laijs__11492.7080263898$1344414651$gmane$org@cn.fujitsu.com>
References: <1344414673-14714-1-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1Sz1en-0005mx-Pt
	for lttng-dev@lists.lttng.org; Wed, 08 Aug 2012 04:30:22 -0400
In-Reply-To: <1344414673-14714-1-git-send-email-laijs@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com, lttng-dev@lists.lttng.org
Cc: eag0628@gmail.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
 urcu/tls-compat.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/urcu/tls-compat.h b/urcu/tls-compat.h
index 192a536..b7bf363 100644
--- a/urcu/tls-compat.h
+++ b/urcu/tls-compat.h
@@ -59,6 +59,20 @@ extern "C" {
 
 #else /* #ifndef CONFIG_RCU_TLS */
 
+/*
+ * NOTE: URCU_TLS() is NOT async-signal-safe, you can't use it
+ * inside any function which can be called from signal handler.
+ *
+ * But if pthread_getspecific() is async-signal-safe in your
+ * platform, you can make URCU_TLS() async-signal-safe via:
+ * ensuring the first call to URCU_TLS() of a given TLS variable of
+ * all threads is called earliest from a non-signal handler function.
+ *
+ * Exmaple: In any thread, the first call of URCU_TLS(rcu_reader)
+ * is called from rcu_register_thread(), so we can ensure all later
+ * URCU_TLS(rcu_reader) in any thread is async-signal-safe.
+ */
+
 # include <pthread.h>
 
 struct urcu_tls {
-- 
1.7.4.4
