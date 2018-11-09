From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: max_t/min_t macros are
 missing cast on input
Date: Fri,  9 Nov 2018 17:40:47 -0500
Message-ID: <20181109224047.18750-2-mathieu.desnoyers__27238.114787224$1541803549$gmane$org@efficios.com>
References: <20181109224047.18750-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42sFVV1cfdzqYC
 for <lttng-dev@lists.lttng.org>; Fri,  9 Nov 2018 17:40:49 -0500 (EST)
In-Reply-To: <20181109224047.18750-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, jonathan.rajotte-julien@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The semantic expected from max_t and min_t is to perform the max/min
comparison in the type provided as first parameter.

Cast the input parameters to the proper type before comparing them,
rather than after. There is no more need to cast the result of the
expression now that both inputs are cast to the right type.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/macros.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common/macros.h b/src/common/macros.h
index c521aacd..461202ff 100644
--- a/src/common/macros.h
+++ b/src/common/macros.h
@@ -72,7 +72,7 @@ void *zmalloc(size_t len)
 #endif
 
 #ifndef max_t
-#define max_t(type, a, b)	((type) max(a, b))
+#define max_t(type, a, b)	max((type) a, (type) b)
 #endif
 
 #ifndef min
@@ -80,7 +80,7 @@ void *zmalloc(size_t len)
 #endif
 
 #ifndef min_t
-#define min_t(type, a, b)	((type) min(a, b))
+#define min_t(type, a, b)	min((type) a, (type) b)
 #endif
 
 #ifndef LTTNG_PACKED
-- 
2.11.0
