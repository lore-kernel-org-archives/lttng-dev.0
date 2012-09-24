From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH v2 lttng-tools 1/4] Tests: Add a check for color
	support when printing status
Date: Mon, 24 Sep 2012 12:11:44 -0400
Message-ID: <1348503107-3830-2-git-send-email-christian.babeux__47422.5713209764$1348503457$gmane$org@efficios.com>
References: <1348178720-24610-1-git-send-email-christian.babeux@efficios.com>
	<1348503107-3830-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TGBGS-00031u-7g
	for lttng-dev@lists.lttng.org; Mon, 24 Sep 2012 12:12:08 -0400
Received: by vbme21 with SMTP id e21so7755995vbm.35
	for <lttng-dev@lists.lttng.org>; Mon, 24 Sep 2012 09:12:02 -0700 (PDT)
In-Reply-To: <1348503107-3830-1-git-send-email-christian.babeux@efficios.com>
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

When printing the status of test is OK or FAIL, check if stdout is
attached to a terminal device. This way the output is not cluttered
with useless escape characters. Some use cases where we don't want
colors:

$ ./sometest | less

$ ./sometest > a.log

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/utils.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/utils.h b/tests/utils.h
index 7650865..94891c0 100644
--- a/tests/utils.h
+++ b/tests/utils.h
@@ -16,10 +16,28 @@
  */
 
 #include <stdio.h>
+#include <unistd.h>
 
 #define BRIGHT 1
 #define GREEN 32
 #define RED 31
 
-#define PRINT_OK() printf("%c[%d;%dmOK%c[%dm\n", 0x1B, BRIGHT, GREEN, 0x1B, 0);
-#define PRINT_FAIL() printf("%c[%d;%dmFAIL%c[%dm\n", 0x1B, BRIGHT, RED, 0x1B, 0);
+#define PRINT_OK()							\
+do {									\
+	/* Check for color support */					\
+	if (isatty(STDOUT_FILENO)) {					\
+		printf("%c[%d;%dmOK%c[%dm\n", 0x1B, BRIGHT, GREEN, 0x1B, 0); \
+	} else {							\
+		printf("OK\n");					\
+	}								\
+} while (0)
+
+#define PRINT_FAIL() \
+do {									\
+	/* Check for color support */					\
+	if (isatty(STDOUT_FILENO)) {					\
+		printf("%c[%d;%dmFAIL%c[%dm\n", 0x1B, BRIGHT, RED, 0x1B, 0); \
+	} else {							\
+		printf("FAIL\n");					\
+	}								\
+} while (0)
-- 
1.7.12
