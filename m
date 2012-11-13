From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-tools 1/3] Add max() and min() macro in
	common
Date: Tue, 13 Nov 2012 14:28:41 -0500
Message-ID: <1352834923-662-1-git-send-email-simon.marchi__5305.33199566907$1352835088$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1TYMAB-0000uZ-PB
	for lttng-dev@lists.lttng.org; Tue, 13 Nov 2012 14:28:47 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 src/common/macros.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/common/macros.h b/src/common/macros.h
index 8185c85..81f901c 100644
--- a/src/common/macros.h
+++ b/src/common/macros.h
@@ -52,4 +52,12 @@
 #define ARRAY_SIZE(array)   (sizeof(array) / (sizeof((array)[0])))
 #endif
 
+#ifndef max
+#define max(a, b) ((a) > (b) ? (a) : (b))
+#endif
+
+#ifndef min
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
 #endif /* _MACROS_H */
-- 
1.7.1
