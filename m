From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH lttng-tools 02/14] Added a low-level endian
	conversion function check in configure.ac to add support for
	systems where only BSD-like 'betoh*(...)' functions are
	available (such as Android when compiling with Bionic).
Date: Mon,  6 May 2013 18:18:39 +0000
Message-ID: <1367864331-15212-2-git-send-email-charlesbriere.flatzo__48528.0134751976$1367864383$gmane$org@gmail.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1UZQ04-0008WH-PR
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 14:19:00 -0400
Received: by mail-qe0-f46.google.com with SMTP id f6so2207480qej.19
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 11:18:55 -0700 (PDT)
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
 configure.ac                   | 10 ++++++++++
 src/bin/lttng-relayd/cmd-2-2.c |  1 +
 src/bin/lttng-relayd/main.c    |  1 +
 src/common/compat/endian.h     |  6 +++++-
 src/common/relayd/relayd.c     |  1 +
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index eee025a..618d203 100644
--- a/configure.ac
+++ b/configure.ac
@@ -123,6 +123,16 @@ AC_CHECK_LIB([pthread], [pthread_create], [],
 ]
 )
 
+# Check low-level endian compat functions
+AC_CHECK_DECL(be64toh, [], 
+[
+	AC_CHECK_DECL(betoh64, [AC_DEFINE_UNQUOTED([LTTNG_HAVE_BETOH64], 1, [Has BSD-style endian conversion operations.])], 
+	[
+		AC_MSG_ERROR([Cannot find be64toh, betoh64 or any similar functions.])
+	])
+]
+)
+
 # Check libpopt
 AC_CHECK_LIB([popt], [poptGetContext], [],
 [
diff --git a/src/bin/lttng-relayd/cmd-2-2.c b/src/bin/lttng-relayd/cmd-2-2.c
index 0450fbf..09ff7f5 100644
--- a/src/bin/lttng-relayd/cmd-2-2.c
+++ b/src/bin/lttng-relayd/cmd-2-2.c
@@ -22,6 +22,7 @@
 
 #include <common/common.h>
 #include <common/sessiond-comm/relayd.h>
+#include <common/compat/endian.h>
 
 #include "cmd-generic.h"
 #include "cmd-2-1.h"
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 9a2b3bd..0bf3ead 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -43,6 +43,7 @@
 #include <common/common.h>
 #include <common/compat/poll.h>
 #include <common/compat/socket.h>
+#include <common/compat/endian.h>
 #include <common/defaults.h>
 #include <common/futex.h>
 #include <common/sessiond-comm/sessiond-comm.h>
diff --git a/src/common/compat/endian.h b/src/common/compat/endian.h
index 2850866..b7f66cc 100644
--- a/src/common/compat/endian.h
+++ b/src/common/compat/endian.h
@@ -15,11 +15,15 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#ifdef _COMPAT_ENDIAN_H
+#ifndef _COMPAT_ENDIAN_H
 #define _COMPAT_ENDIAN_H
 
 #ifdef __linux__
 #include <endian.h>
+#ifdef LTTNG_HAVE_BETOH64
+#define be64toh(x) betoh64(x)
+#define be32toh(x) betoh32(x)
+#endif // LTTNG_HAVE_BETOH64
 #elif defined(__FreeBSD__)
 #include <machine/endian.h>
 #else
diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
index 82bcf5f..ba7bd13 100644
--- a/src/common/relayd/relayd.c
+++ b/src/common/relayd/relayd.c
@@ -26,6 +26,7 @@
 #include <common/common.h>
 #include <common/defaults.h>
 #include <common/sessiond-comm/relayd.h>
+#include <common/compat/endian.h>
 
 #include "relayd.h"
 
-- 
1.8.1.msysgit.1
