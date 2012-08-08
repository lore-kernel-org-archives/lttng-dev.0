From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH 1/2] urcu: add hint to DEFINE_URCU_TLS() for
	compound types
Date: Wed, 8 Aug 2012 16:31:12 +0800
Message-ID: <1344414673-14714-1-git-send-email-laijs__3841.32780968702$1344414650$gmane$org@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1Sz1em-0005mx-9D
	for lttng-dev@lists.lttng.org; Wed, 08 Aug 2012 04:30:20 -0400
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

Just a hint.

Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
 urcu/tls-compat.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/urcu/tls-compat.h b/urcu/tls-compat.h
index 9686eca..192a536 100644
--- a/urcu/tls-compat.h
+++ b/urcu/tls-compat.h
@@ -34,6 +34,21 @@ extern "C" {
 
 #ifdef CONFIG_RCU_TLS	/* Based on ax_tls.m4 */
 
+/*
+ * Hint: How to define/declare TLS variables of compound types
+ *       such as array or function pointers?
+ *
+ * Answer: Use typedef to assign a type_name to the compound type.
+ * Example: Define a TLS variable which is an int array with len=4:
+ *
+ * 	typedef int my_int_array_type[4];
+ * 	DEFINE_URCU_TLS(my_int_array_type, var_name);
+ *
+ * Another exmaple:
+ * 	typedef void (*call_rcu_flavor)(struct rcu_head *, XXXX);
+ * 	DECLARE_URCU_TLS(call_rcu_flavor, p_call_rcu);
+ */
+
 # define DECLARE_URCU_TLS(type, name)	\
 	CONFIG_RCU_TLS type name
 
-- 
1.7.4.4
