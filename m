From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 14/28] Add MinGW implementation
	of fpathconf
Date: Thu, 2 May 2013 11:55:32 +0000
Message-ID: <009B25148989C6458484484699278506E537E90D__1494.63513303107$1367495773$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXs6u-00022s-Pb
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:55:40 -0400
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

The MinGW implementation of fpathconf will always return MAX_PATH.
---
 formats/ctf/ctf.c                  |  2 +-
 include/babeltrace/compat/unistd.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 include/babeltrace/compat/unistd.h

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 255a492..c29fcd7 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -44,7 +44,7 @@
 #include <fcntl.h>
 #include <dirent.h>
 #include <glib.h>
-#include <unistd.h>
+#include <babeltrace/compat/unistd.h>
 #include <stdlib.h>
 
 #include "metadata/ctf-scanner.h"
diff --git a/include/babeltrace/compat/unistd.h b/include/babeltrace/compat/unistd.h
new file mode 100644
index 0000000..f275b22
--- /dev/null
+++ b/include/babeltrace/compat/unistd.h
@@ -0,0 +1,21 @@
+#ifndef _BABELTRACE_INCLUDE_COMPAT_UNISTD_H
+#define _BABELTRACE_INCLUDE_COMPAT_UNISTD_H
+
+#include <unistd.h>
+
+#ifndef _PC_NAME_MAX
+#define _PC_NAME_MAX 0
+#endif
+
+#ifdef __MINGW32__
+
+static inline
+int fpathconf (int fd, int name)
+{
+	/* dummy function that always returns MAX_PATH */
+	return MAX_PATH;
+}
+
+#endif
+
+#endif
\ No newline at end of file
-- 
1.8.1.msysgit.1
