From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 11/28] Add MinGW implementation
	of gmtime_r
Date: Thu, 2 May 2013 11:52:51 +0000
Message-ID: <009B25148989C6458484484699278506E537E8D8__31867.9580268965$1367495613$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXs4J-0001zB-CY
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:52:59 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Add a (non-recursive) implementation of gmtime_r as it is
missing in the MinGW standard library.
Implementation is written in file include/babeltrace/compat/time.h
which must be included in the source files that call gmtime_r.
---
 formats/ctf/ctf.c                |  1 +
 include/babeltrace/compat/time.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 include/babeltrace/compat/time.h

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 0cfad44..255a492 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -52,6 +52,7 @@
 #include "metadata/ctf-ast.h"
 #include "events-private.h"
 #include "babeltrace/compat/memstream.h"
+#include <babeltrace/compat/time.h>
 
 #define LOG2_CHAR_BIT	3
 
diff --git a/include/babeltrace/compat/time.h b/include/babeltrace/compat/time.h
new file mode 100644
index 0000000..ccfc860
--- /dev/null
+++ b/include/babeltrace/compat/time.h
@@ -0,0 +1,19 @@
+#ifndef _BABELTRACE_INCLUDE_COMPAT_TIME_H
+#define _BABELTRACE_INCLUDE_COMPAT_TIME_H
+
+#include <time.h>
+#include <stdlib.h>
+
+#ifdef __MINGW32__
+
+static inline
+struct tm *gmtime_r(const time_t *timep, struct tm *result)
+{
+	struct tm * r;
+	r = gmtime(timep);
+	memcpy(result, r, sizeof (struct tm));
+	return result;
+}
+
+#endif
+#endif
-- 
1.8.1.msysgit.1
