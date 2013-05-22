From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 07/23] Memstream functions for MinGW32
Date: Wed, 22 May 2013 08:06:13 +0000
Message-ID: <009B25148989C6458484484699278506E5382F1A__23013.0447926514$1369210010$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf43x-0006ST-3c
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:06:21 -0400
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

Add a Windows-specific implementation of mktemp, which provides a
temporary file in the correct TEMP directory. The temporary file
is opened in such a manner that it will be deleted when it is closed.

Rename the unlink function to unlink_open_file, which unlinks the file
in non-MinGW systems. Under MinGW, the file will be deleted by Windows,
when the file is closed.
---
 compat/Makefile.am                    |  2 +-
 compat/compat_stdlib.c                | 24 ++++++++++++++++++++++++
 include/babeltrace/compat/memstream.h | 20 ++++++++++++--------
 include/babeltrace/compat/stdlib.h    | 17 +++++++++++++++++
 4 files changed, 54 insertions(+), 9 deletions(-)
 create mode 100644 compat/compat_stdlib.c
 create mode 100644 include/babeltrace/compat/stdlib.h

diff --git a/compat/Makefile.am b/compat/Makefile.am
index 00a7e02..16dd2e9 100644
--- a/compat/Makefile.am
+++ b/compat/Makefile.am
@@ -8,5 +8,5 @@ libcompat_la_LDFLAGS = \
 	-Wl,--no-as-needed
 
 if BABELTRACE_BUILD_WITH_MINGW
-libcompat_la_SOURCES += compat_mman.c compat_uuid.c
+libcompat_la_SOURCES += compat_mman.c compat_uuid.c compat_stdlib.c
 endif
diff --git a/compat/compat_stdlib.c b/compat/compat_stdlib.c
new file mode 100644
index 0000000..17e0b71
--- /dev/null
+++ b/compat/compat_stdlib.c
@@ -0,0 +1,24 @@
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
+	/* Note that the file is opened with the attribute
+	   FILE_FLAG_DELETE_ON_CLOSE. This unlinks the file automatically when it is closed. */
+	file = CreateFile(tmpname, GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
+		NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_TEMPORARY | FILE_FLAG_DELETE_ON_CLOSE, NULL);
+
+	return _open_osfhandle((int *)file, 0);
+}
diff --git a/include/babeltrace/compat/memstream.h b/include/babeltrace/compat/memstream.h
index d2a96cb..fb24ad9 100644
--- a/include/babeltrace/compat/memstream.h
+++ b/include/babeltrace/compat/memstream.h
@@ -1,8 +1,8 @@
-#ifndef _BABELTRACE_FORMAT_CTF_MEMSTREAM_H
-#define _BABELTRACE_FORMAT_CTF_MEMSTREAM_H
+#ifndef _BABELTRACE_COMPAT_MEMSTREAM_H
+#define _BABELTRACE_COMPAT_MEMSTREAM_H
 
 /*
- * format/ctf/memstream.h
+ * include/babeltrace/compat/memstream.h
  *
  * Copyright 2012 (c) - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  *
@@ -41,7 +41,7 @@ FILE *babeltrace_fmemopen(void *buf, size_t size, const char *mode)
 
 #else /* BABELTRACE_HAVE_FMEMOPEN */
 
-#include <stdlib.h>
+#include <babeltrace/compat/stdlib.h>
 #include <stdio.h>
 
 /*
@@ -84,11 +84,13 @@ FILE *babeltrace_fmemopen(void *buf, size_t size, const char *mode)
 		perror("fseek");
 		goto error_close;
 	}
+
 	/* We keep the handle open, but can unlink the file on the VFS. */
-	ret = unlink(tmpname);
+	ret = unlink_open_file(tmpname);
 	if (ret < 0) {
 		perror("unlink");
 	}
+
 	return fp;
 
 error_close:
@@ -97,10 +99,12 @@ error_close:
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
 
@@ -154,14 +158,14 @@ FILE *babeltrace_open_memstream(char **ptr, size_t *sizeloc)
 	 * with read from fp. No need to keep the file around, just the
 	 * handle.
 	 */
-	ret = unlink(tmpname);
+	ret = unlink_open_file(tmpname);
 	if (ret < 0) {
 		perror("unlink");
 	}
 	return fp;
 
 error_unlink:
-	ret = unlink(tmpname);
+	ret = unlink_open_file(tmpname);
 	if (ret < 0) {
 		perror("unlink");
 	}
@@ -233,4 +237,4 @@ error_free:
 
 #endif /* BABELTRACE_HAVE_OPEN_MEMSTREAM */
 
-#endif /* _BABELTRACE_FORMAT_CTF_MEMSTREAM_H */
+#endif /* _BABELTRACE_COMPAT_MEMSTREAM_H */
diff --git a/include/babeltrace/compat/stdlib.h b/include/babeltrace/compat/stdlib.h
new file mode 100644
index 0000000..25670eb
--- /dev/null
+++ b/include/babeltrace/compat/stdlib.h
@@ -0,0 +1,17 @@
+#ifndef _BABELTRACE_COMPAT_STDLIB_H
+#define BABELTRACE_COMPAT_STDLIB_H
+
+#include <stdlib.h>
+
+#ifdef __MINGW32__
+int mkstemp(char *template);
+
+/* Under MINGW32, we cannot unlink a file while it is open. */
+/* Instead, we have opened the file (in mkstemp) in such a way
+   that it will be automatically deleted when it gets closed. */
+#define unlink_open_file(X) 0
+#else
+#define unlink_open_file(X) unlink(X)
+#endif
+
+#endif /* BABELTRACE_COMPAT_STDLIB_H */
-- 
1.8.1.msysgit.1
