From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu 2/3] Fix: symbol aliases with TLS compat
Date: Wed, 12 Dec 2018 15:01:38 -0500
Message-ID: <20181212200139.19046-2-mjeanson__13609.3948888176$1544644811$gmane$org@efficios.com>
References: <20181212200139.19046-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43FSPw2gdWz175W
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 15:01:56 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id D24A7A340E
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 15:01:55 -0500 (EST)
In-Reply-To: <20181212200139.19046-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/urcu-bp.c    |  3 +--
 src/urcu-qsbr.c  |  3 +--
 src/urcu-utils.h | 14 ++++++++++++++
 src/urcu.c       |  3 +--
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/src/urcu-bp.c b/src/urcu-bp.c
index 0653f9d..54fda16 100644
--- a/src/urcu-bp.c
+++ b/src/urcu-bp.c
@@ -151,8 +151,7 @@ URCU_ATTR_ALIAS("urcu_bp_gp") extern struct urcu_bp_gp rcu_gp_bp;
  * by both the reader and the writers.
  */
 DEFINE_URCU_TLS(struct urcu_bp_reader *, urcu_bp_reader);
-URCU_ATTR_ALIAS("urcu_bp_reader")
-extern struct urcu_bp_reader *rcu_reader_bp;
+DEFINE_URCU_TLS_ALIAS(struct urcu_bp_reader *, urcu_bp_reader, rcu_reader_bp);
 
 static CDS_LIST_HEAD(registry);
 
diff --git a/src/urcu-qsbr.c b/src/urcu-qsbr.c
index 6ff933a..ab20ebe 100644
--- a/src/urcu-qsbr.c
+++ b/src/urcu-qsbr.c
@@ -81,8 +81,7 @@ URCU_ATTR_ALIAS("urcu_qsbr_gp") extern struct urcu_gp rcu_gp_qsbr;
  * writers.
  */
 DEFINE_URCU_TLS(struct urcu_qsbr_reader, urcu_qsbr_reader);
-URCU_ATTR_ALIAS("urcu_qsbr_reader")
-extern struct urcu_qsbr_reader rcu_reader_qsbr;
+DEFINE_URCU_TLS_ALIAS(struct urcu_qsbr_reader, urcu_qsbr_reader, rcu_reader_qsbr);
 
 static CDS_LIST_HEAD(registry);
 
diff --git a/src/urcu-utils.h b/src/urcu-utils.h
index 3c3c7a1..eab6212 100644
--- a/src/urcu-utils.h
+++ b/src/urcu-utils.h
@@ -33,4 +33,18 @@
 #define URCU_ATTR_ALIAS(x) __attribute__((alias(x)))
 #endif
 
+#ifdef CONFIG_RCU_TLS
+#define DEFINE_URCU_TLS_ALIAS_1(type, name, alias)		\
+	URCU_ATTR_ALIAS(#name)					\
+	extern type alias
+
+#else
+#define DEFINE_URCU_TLS_ALIAS_1(type, name, alias)		\
+	URCU_ATTR_ALIAS("*__tls_access_" #name)			\
+	type *__tls_access_ ## alias()
+#endif
+
+#define DEFINE_URCU_TLS_ALIAS(type, name, alias)		\
+	DEFINE_URCU_TLS_ALIAS_1(type, name, alias)
+
 #endif /* _URCU_UTILS_H */
diff --git a/src/urcu.c b/src/urcu.c
index c4e2dde..2cac0b6 100644
--- a/src/urcu.c
+++ b/src/urcu.c
@@ -138,8 +138,7 @@ extern struct urcu_gp alias_rcu_gp;
  * writers.
  */
 DEFINE_URCU_TLS(struct urcu_reader, rcu_reader);
-URCU_ATTR_ALIAS(urcu_stringify(rcu_reader))
-extern struct urcu_reader alias_rcu_reader;
+DEFINE_URCU_TLS_ALIAS(struct urcu_reader, rcu_reader, alias_rcu_reader);
 
 static CDS_LIST_HEAD(registry);
 
-- 
2.17.1
