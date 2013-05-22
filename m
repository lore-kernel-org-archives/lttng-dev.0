From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 17/23] Add MinGW implementation of
	flockfile
Date: Wed, 22 May 2013 08:07:21 +0000
Message-ID: <009B25148989C6458484484699278506E5382FAA__2382.55393128402$1369210085$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf453-0006Zs-LE
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:07:29 -0400
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

Add a dummy implementation of flockfile for MinGW.
The function does not do anything; it only returns.
---
 include/babeltrace/compat/stdio.h | 14 ++++++++++++++
 tests/lib/tap.c                   |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 include/babeltrace/compat/stdio.h

diff --git a/include/babeltrace/compat/stdio.h b/include/babeltrace/compat/stdio.h
new file mode 100644
index 0000000..62ecf97
--- /dev/null
+++ b/include/babeltrace/compat/stdio.h
@@ -0,0 +1,14 @@
+#ifndef _BABELTRACE_COMPAT_STDIO_H
+#define _BABELTRACE_COMPAT_STDIO_H
+
+#include <stdio.h>
+
+#ifdef __MINGW32__
+static inline void flockfile (FILE * filehandle)
+{
+	return;
+}
+
+#endif
+
+#endif
diff --git a/tests/lib/tap.c b/tests/lib/tap.c
index a430951..8bcdf36 100644
--- a/tests/lib/tap.c
+++ b/tests/lib/tap.c
@@ -27,7 +27,7 @@
 #define _GNU_SOURCE
 #include <ctype.h>
 #include <stdarg.h>
-#include <stdio.h>
+#include <babeltrace/compat/stdio.h>
 #include <stdlib.h>
 
 #include "tap.h"
-- 
1.8.1.msysgit.1
