From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 19/28] Add MinGW implementation
 of posix_fallocate
Date: Thu, 2 May 2013 12:00:59 +0000
Message-ID: <009B25148989C6458484484699278506E537E962__25322.6546141834$1367496105$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXsCB-0002Ax-5P
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 08:01:07 -0400
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

Add dummy MinGW implementation of posix_fallocate.
The implementation does not do anything, and always returns zero.
---
 formats/ctf/ctf.c                 |  2 +-
 include/babeltrace/compat/fcntl.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 include/babeltrace/compat/fcntl.h

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index c29fcd7..431b2d4 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -41,7 +41,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
+#include <babeltrace/compat/fcntl.h>
 #include <dirent.h>
 #include <glib.h>
 #include <babeltrace/compat/unistd.h>
diff --git a/include/babeltrace/compat/fcntl.h b/include/babeltrace/compat/fcntl.h
new file mode 100644
index 0000000..0707c28
--- /dev/null
+++ b/include/babeltrace/compat/fcntl.h
@@ -0,0 +1,13 @@
+#ifndef _BABELTRACE_INCLUDE_COMPAT_FCNTL_H
+#define _BABELTRACE_INCLUDE_COMPAT_FCNTL_H
+
+#include <fcntl.h>
+#ifdef __MINGW32__
+static inline
+int posix_fallocate(int fd, off_t offset, off_t len)
+{
+	return 0;
+}
+#endif
+
+#endif
\ No newline at end of file
-- 
1.8.1.msysgit.1
