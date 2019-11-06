From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-tools 2/3] align.h: Implement
 ALIGN_FLOOR macro
Date: Tue,  5 Nov 2019 19:55:26 -0500
Message-ID: <20191106005527.7584-2-mathieu.desnoyers__36361.7451906734$1573001789$gmane$org@efficios.com>
References: <20191106005527.7584-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 4777PK3b0sz1RJn
 for <lttng-dev@lists.lttng.org>; Tue,  5 Nov 2019 19:55:31 -0500 (EST)
In-Reply-To: <20191106005527.7584-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Implement the ALIGN_FLOOR macro which aligns the given value to the
previous alignment boundary, or keeps the value as-is if it is already
aligned.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/align.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/common/align.h b/src/common/align.h
index ed353206..c8d9d517 100644
--- a/src/common/align.h
+++ b/src/common/align.h
@@ -35,6 +35,12 @@
 #define ALIGN(v, align)		__ALIGN_MASK(v, (__typeof__(v)) (align) - 1)
 #endif
 
+#define __ALIGN_FLOOR_MASK(v, mask)	((v) & ~(mask))
+
+#ifndef ALIGN_FLOOR
+#define ALIGN_FLOOR(v, align)	__ALIGN_FLOOR_MASK(v, (__typeof__(v)) (align) - 1)
+#endif
+
 #define PAGE_ALIGN(addr)	ALIGN(addr, PAGE_SIZE)
 
 /**
-- 
2.17.1
