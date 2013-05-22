From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 15/23] Add MinGW implementation of
	posix_fallocate
Date: Wed, 22 May 2013 08:07:10 +0000
Message-ID: <009B25148989C6458484484699278506E5382F92__12714.5935003229$1369210069$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf44t-0006YS-20
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:07:19 -0400
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

Add MinGW implementation of posix_fallocate.
The implementation is in a new source file (compat_fcntl.c).
Add the new source file to the build.
---
 compat/Makefile.am                |  2 +-
 compat/compat_fcntl.c             | 23 +++++++++++++++++++++++
 formats/ctf/ctf.c                 |  2 +-
 include/babeltrace/compat/fcntl.h | 11 +++++++++++
 4 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 compat/compat_fcntl.c
 create mode 100644 include/babeltrace/compat/fcntl.h

diff --git a/compat/Makefile.am b/compat/Makefile.am
index 16dd2e9..03b3daf 100644
--- a/compat/Makefile.am
+++ b/compat/Makefile.am
@@ -8,5 +8,5 @@ libcompat_la_LDFLAGS = \
 	-Wl,--no-as-needed
 
 if BABELTRACE_BUILD_WITH_MINGW
-libcompat_la_SOURCES += compat_mman.c compat_uuid.c compat_stdlib.c
+libcompat_la_SOURCES += compat_mman.c compat_uuid.c compat_stdlib.c compat_fcntl.c
 endif
diff --git a/compat/compat_fcntl.c b/compat/compat_fcntl.c
new file mode 100644
index 0000000..3fd23a9
--- /dev/null
+++ b/compat/compat_fcntl.c
@@ -0,0 +1,23 @@
+/* This file is only built under MINGW32 */
+
+#include <windows.h>
+#include <fcntl.h>
+
+int posix_fallocate(int fd, off_t offset, off_t len)
+{
+	HANDLE handle;
+	LARGE_INTEGER current_pos;
+	LARGE_INTEGER pos;
+	BOOL ret;
+
+	handle = (HANDLE) _get_osfhandle(fd);
+	pos.QuadPart = 0;
+	SetFilePointerEx(handle, pos, &current_pos, FILE_CURRENT);
+	pos.QuadPart = (__int64)offset + (__int64)len;
+	SetFilePointerEx(handle, pos, NULL, FILE_BEGIN);
+	ret = SetEndOfFile(handle);
+	SetFilePointerEx(handle, current_pos, NULL, FILE_BEGIN);
+	if (ret == 0)
+		return -1;
+	return 0;
+}
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index b476a29..0db23c3 100644
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
index 0000000..9fc7539
--- /dev/null
+++ b/include/babeltrace/compat/fcntl.h
@@ -0,0 +1,11 @@
+#ifndef _BABELTRACE_INCLUDE_COMPAT_FCNTL_H
+#define _BABELTRACE_INCLUDE_COMPAT_FCNTL_H
+
+#include <fcntl.h>
+#ifdef __MINGW32__
+
+int posix_fallocate(int fd, off_t offset, off_t len);
+
+#endif
+
+#endif
-- 
1.8.1.msysgit.1
