From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 20/28] Add MinGW implementation
	of readdir_r
Date: Thu, 2 May 2013 12:01:45 +0000
Message-ID: <009B25148989C6458484484699278506E537E973__19441.8078558103$1367496146$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXsCv-0002C9-3q
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 08:01:53 -0400
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

---
 formats/ctf/ctf.c                  |  2 +-
 include/babeltrace/compat/dirent.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 include/babeltrace/compat/dirent.h

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 431b2d4..c6043bc 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -42,7 +42,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <babeltrace/compat/fcntl.h>
-#include <dirent.h>
+#include <babeltrace/compat/dirent.h>
 #include <glib.h>
 #include <babeltrace/compat/unistd.h>
 #include <stdlib.h>
diff --git a/include/babeltrace/compat/dirent.h b/include/babeltrace/compat/dirent.h
new file mode 100644
index 0000000..281f40b
--- /dev/null
+++ b/include/babeltrace/compat/dirent.h
@@ -0,0 +1,20 @@
+#ifndef _BABELTRACE_INCLUDE_COMPAT_DIRENT_H
+#define _BABELTRACE_INCLUDE_COMPAT_DIRENT_H
+
+#include <dirent.h>
+
+#ifdef __MINGW32__
+static inline
+int readdir_r (DIR *dirp, struct dirent *entry, struct dirent **result)
+{
+	errno = 0;
+	entry = readdir (dirp);
+	*result = entry;
+	if (entry == NULL && errno != 0) {
+		return -1;
+	}
+	return 0;
+}
+#endif
+
+#endif
-- 
1.8.1.msysgit.1
