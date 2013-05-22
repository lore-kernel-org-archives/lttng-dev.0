From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 16/23] Add MinGW implementation of
	readdir_r
Date: Wed, 22 May 2013 08:07:16 +0000
Message-ID: <009B25148989C6458484484699278506E5382F9E__42556.0815180235$1369210080$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf44z-0006ZD-5O
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:07:25 -0400
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

---
 formats/ctf/ctf.c                  |  2 +-
 include/babeltrace/compat/dirent.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 include/babeltrace/compat/dirent.h

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 0db23c3..ad3c3b1 100644
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
