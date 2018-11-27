From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: use sys/types.h for ssize_t on
 Cygwin
Date: Tue, 27 Nov 2018 14:24:01 -0500
Message-ID: <20181127192401.8236-1-mjeanson__22464.831316802$1543346554$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 434DHf5q2JzwS1
 for <lttng-dev@lists.lttng.org>; Tue, 27 Nov 2018 14:24:30 -0500 (EST)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 include/lttng/location-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lttng/location-internal.h b/include/lttng/location-internal.h
index 9072ef34..6c2a9923 100644
--- a/include/lttng/location-internal.h
+++ b/include/lttng/location-internal.h
@@ -22,7 +22,7 @@
 #include <common/dynamic-buffer.h>
 #include <common/buffer-view.h>
 #include <common/macros.h>
-#include <stddef.h>
+#include <sys/types.h>
 
 struct lttng_trace_archive_location {
 	enum lttng_trace_archive_location_type type;
-- 
2.17.1
