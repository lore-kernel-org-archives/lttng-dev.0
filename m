From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Tests: Remove unused utils.h header
Date: Mon, 13 May 2013 17:51:03 -0400
Message-ID: <1368481863-10412-1-git-send-email-christian.babeux__11233.5389633246$1368481918$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Uc0eW-0002A2-GB
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 17:51:28 -0400
Received: by mail-vc0-f182.google.com with SMTP id ia10so5875587vcb.41
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 14:51:23 -0700 (PDT)
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


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/utils/Makefile.am |  4 ++--
 tests/utils/utils.h     | 43 -------------------------------------------
 2 files changed, 2 insertions(+), 45 deletions(-)
 delete mode 100644 tests/utils/utils.h

diff --git a/tests/utils/Makefile.am b/tests/utils/Makefile.am
index 1b362fc..25c6e04 100644
--- a/tests/utils/Makefile.am
+++ b/tests/utils/Makefile.am
@@ -1,4 +1,4 @@
 SUBDIRS = tap
 
-EXTRA_DIST = utils.sh utils.h test_utils.py
-dist_noinst_SCRIPTS = utils.sh utils.h test_utils.py
+EXTRA_DIST = utils.sh test_utils.py
+dist_noinst_SCRIPTS = utils.sh test_utils.py
diff --git a/tests/utils/utils.h b/tests/utils/utils.h
deleted file mode 100644
index 94891c0..0000000
--- a/tests/utils/utils.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * Copyright (c) - 2011 David Goulet <david.goulet@polymtl.ca>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by as
- * published by the Free Software Foundation; only version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 51
- * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <stdio.h>
-#include <unistd.h>
-
-#define BRIGHT 1
-#define GREEN 32
-#define RED 31
-
-#define PRINT_OK()							\
-do {									\
-	/* Check for color support */					\
-	if (isatty(STDOUT_FILENO)) {					\
-		printf("%c[%d;%dmOK%c[%dm\n", 0x1B, BRIGHT, GREEN, 0x1B, 0); \
-	} else {							\
-		printf("OK\n");					\
-	}								\
-} while (0)
-
-#define PRINT_FAIL() \
-do {									\
-	/* Check for color support */					\
-	if (isatty(STDOUT_FILENO)) {					\
-		printf("%c[%d;%dmFAIL%c[%dm\n", 0x1B, BRIGHT, RED, 0x1B, 0); \
-	} else {							\
-		printf("FAIL\n");					\
-	}								\
-} while (0)
-- 
1.8.2.2
