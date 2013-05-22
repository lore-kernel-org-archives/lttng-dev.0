From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 08/23] Add MinGW implementation of
	gmtime_r
Date: Wed, 22 May 2013 08:06:21 +0000
Message-ID: <009B25148989C6458484484699278506E5382F29__38418.7235533775$1369210035$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf445-0006T5-2f
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:06:29 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>, =?iso-8859-1?Q?J=E9r=E9mie_Galarneau_=28jeremie=2Egalarneau=40efficios=2E?= =?iso-8859-1?Q?com=29?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Add a (non-recursive) implementation of gmtime_r, as it missing
in the MinGW library.
Implementation is written in file include/babeltrace/compat/time.h
which must be included in the source files that call gmtime_r.

Note that the Windows function gmtime_s is not available under
MinGW32.
---
 formats/ctf/ctf.c                |  1 +
 include/babeltrace/compat/time.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 include/babeltrace/compat/time.h

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index bb43664..2f743c7 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -52,6 +52,7 @@
 #include "metadata/ctf-ast.h"
 #include "events-private.h"
 #include <babeltrace/compat/memstream.h>
+#include <babeltrace/compat/time.h>
 
 #define LOG2_CHAR_BIT	3
 
diff --git a/include/babeltrace/compat/time.h b/include/babeltrace/compat/time.h
new file mode 100644
index 0000000..3238d58
--- /dev/null
+++ b/include/babeltrace/compat/time.h
@@ -0,0 +1,20 @@
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
+
+	r = gmtime(timep);
+	memcpy(result, r, sizeof (struct tm));
+	return result;
+}
+
+#endif
+#endif
-- 
1.8.1.msysgit.1
