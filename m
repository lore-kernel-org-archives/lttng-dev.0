From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 10/28] Memstream functions for
	MinGW32
Date: Thu, 2 May 2013 11:51:56 +0000
Message-ID: <009B25148989C6458484484699278506E537E8C7__18898.7705078491$1367495560$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXs3P-0001xe-Nz
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:52:03 -0400
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

In Windows, you cannot unlink a file while it is still in use,
so we won't even try.
Add a Windows-specific implementation of mkstemp, which provides a
temporary file in the correct Windows directory. The temporary
file is opened with such flags that it will be deleted once it's closed.
---
 compat/Makefile.am                    |  2 +-
 compat/compat_stdlib.c                | 22 ++++++++++++++++++++++
 include/babeltrace/compat/memstream.h | 18 ++++++++++++++----
 include/babeltrace/compat/stdlib.h    | 11 +++++++++++
 4 files changed, 48 insertions(+), 5 deletions(-)
 create mode 100644 compat/compat_stdlib.c
 create mode 100644 include/babeltrace/compat/stdlib.h

diff --git a/compat/Makefile.am b/compat/Makefile.am
index e573854..e5a41d9 100644
--- a/compat/Makefile.am
+++ b/compat/Makefile.am
@@ -9,5 +9,5 @@ libcompat_la_LDFLAGS = \
 	-Wl,--no-as-needed
 
 if BABELTRACE_BUILD_WITH_MINGW
-libcompat_la_SOURCES += compat_mman.c compat_uuid.c
+libcompat_la_SOURCES += compat_mman.c compat_uuid.c compat_stdlib.c
 endif
diff --git a/compat/compat_stdlib.c b/compat/compat_stdlib.c
new file mode 100644
index 0000000..51a032c
--- /dev/null
+++ b/compat/compat_stdlib.c
@@ -0,0 +1,22 @@
+/* This file is only built under MINGW32 */
+
+#include <windows.h>
+#include <stdlib.h>
+
+int mkstemp(char *template)
+{
+	char tempPath[MAX_PATH];
+	char tmpname[MAX_PATH];
+	HANDLE file;
+
+	extern int _open_osfhandle(int *, int);
+
+	/* Ignore the template. Use Windows calls to create a temporary file whose name begins with BBT */
+	GetTempPath(MAX_PATH, tempPath);
+	GetTempFileName(tempPath, "BBT", 0, tmpname);
+
+	file = CreateFile(tmpname, GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
+		NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_TEMPORARY | FILE_FLAG_DELETE_ON_CLOSE, NULL);
+
+	return _open_osfhandle((int *)file, 0);
+}
diff --git a/include/babeltrace/compat/memstream.h b/include/babeltrace/compat/memstream.h
index d2a96cb..44bc30c 100644
--- a/include/babeltrace/compat/memstream.h
+++ b/include/babeltrace/compat/memstream.h
@@ -1,5 +1,5 @@
-#ifndef _BABELTRACE_FORMAT_CTF_MEMSTREAM_H
-#define _BABELTRACE_FORMAT_CTF_MEMSTREAM_H
+#ifndef _BABELTRACE_COMPAT_MEMSTREAM_H
+#define _BABELTRACE_COMPAT_MEMSTREAM_H
 
 /*
  * format/ctf/memstream.h
@@ -41,7 +41,7 @@ FILE *babeltrace_fmemopen(void *buf, size_t size, const char *mode)
 
 #else /* BABELTRACE_HAVE_FMEMOPEN */
 
-#include <stdlib.h>
+#include <babeltrace/compat/stdlib.h>
 #include <stdio.h>
 
 /*
@@ -85,10 +85,14 @@ FILE *babeltrace_fmemopen(void *buf, size_t size, const char *mode)
 		goto error_close;
 	}
 	/* We keep the handle open, but can unlink the file on the VFS. */
+	/* Unlinking under MINGW only gives an error, so let's not even try. */
+#ifndef __MINGW32__
 	ret = unlink(tmpname);
 	if (ret < 0) {
 		perror("unlink");
 	}
+#endif
+
 	return fp;
 
 error_close:
@@ -97,10 +101,12 @@ error_close:
 		perror("close");
 	}
 error_unlink:
+#ifndef __MINGW32__
 	ret = unlink(tmpname);
 	if (ret < 0) {
 		perror("unlink");
 	}
+#endif
 	return NULL;
 }
 
@@ -154,17 +160,21 @@ FILE *babeltrace_open_memstream(char **ptr, size_t *sizeloc)
 	 * with read from fp. No need to keep the file around, just the
 	 * handle.
 	 */
+#ifndef __MINGW32__
 	ret = unlink(tmpname);
 	if (ret < 0) {
 		perror("unlink");
 	}
+#endif
 	return fp;
 
 error_unlink:
+#ifndef __MINGW32__
 	ret = unlink(tmpname);
 	if (ret < 0) {
 		perror("unlink");
 	}
+#endif
 	return NULL;
 }
 
@@ -233,4 +243,4 @@ error_free:
 
 #endif /* BABELTRACE_HAVE_OPEN_MEMSTREAM */
 
-#endif /* _BABELTRACE_FORMAT_CTF_MEMSTREAM_H */
+#endif /* _BABELTRACE_COMPAT_MEMSTREAM_H */
diff --git a/include/babeltrace/compat/stdlib.h b/include/babeltrace/compat/stdlib.h
new file mode 100644
index 0000000..385fff1
--- /dev/null
+++ b/include/babeltrace/compat/stdlib.h
@@ -0,0 +1,11 @@
+#ifndef _BABELTRACE_COMPAT_STDLIB_H
+#define BABELTRACE_COMPAT_STDLIB_H
+
+#include <stdlib.h>
+
+#ifdef __MINGW32__
+int mkstemp(char *template);
+#endif
+
+#endif
+
-- 
1.8.1.msysgit.1
