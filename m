From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH lttng-tools 10/14] Added HOST_NAME_MAX
	definition to compat/socket.h if not already defined (which
	is the case for android)
Date: Mon,  6 May 2013 18:18:47 +0000
Message-ID: <1367864331-15212-10-git-send-email-charlesbriere.flatzo__9169.22081164575$1367864424$gmane$org@gmail.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1UZQ0I-00006F-MI
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 14:19:15 -0400
Received: by mail-qa0-f52.google.com with SMTP id g10so1452907qah.18
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 11:19:09 -0700 (PDT)
In-Reply-To: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
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

From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>

Signed-off-by: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
---
 src/bin/lttng-sessiond/consumer.c     | 1 +
 src/bin/lttng-sessiond/ust-metadata.c | 1 +
 src/common/compat/socket.h            | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
index e3d1be0..98d79e4 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -25,6 +25,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
+#include <common/compat/socket.h>
 #include <common/common.h>
 #include <common/defaults.h>
 #include <common/uri.h>
diff --git a/src/bin/lttng-sessiond/ust-metadata.c b/src/bin/lttng-sessiond/ust-metadata.c
index b0f83d2..28f4d1a 100644
--- a/src/bin/lttng-sessiond/ust-metadata.c
+++ b/src/bin/lttng-sessiond/ust-metadata.c
@@ -28,6 +28,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include <common/common.h>
+#include <common/compat/socket.h>
 
 #include "ust-registry.h"
 #include "ust-clock.h"
diff --git a/src/common/compat/socket.h b/src/common/compat/socket.h
index 4d2925f..46aa9c5 100644
--- a/src/common/compat/socket.h
+++ b/src/common/compat/socket.h
@@ -23,6 +23,15 @@
 
 #include <common/macros.h>
 
+#ifndef HOST_NAME_MAX
+/* 
+ * On some platforms (such as Android), this define might not be
+ * exposed in any kernel headers; the most commonly assigned value
+ * is 64. This can be verified using getconf HOST_MAX_NAME.
+ */
+#define HOST_NAME_MAX 64
+#endif
+
 #ifdef __linux__
 
 #define LTTNG_SOCK_CREDS SCM_CREDENTIALS
-- 
1.8.1.msysgit.1
