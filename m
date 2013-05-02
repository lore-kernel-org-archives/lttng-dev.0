From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 25/28] Replace mkdir with
	compat_mkdir
Date: Thu, 2 May 2013 12:05:55 +0000
Message-ID: <009B25148989C6458484484699278506E537E9CA__41340.8024506227$1367496397$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXsGx-0002Hl-2z
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 08:06:03 -0400
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

The MinGW implementation of mkdir only accepts one parameter.
Replace mkdir with compat_mkdir that in MinGW will ignore the
parameters after the first one.
---
 converter/babeltrace-log.c        |  2 +-
 include/babeltrace/compat/fcntl.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
index ac3bb3f..f997aad 100644
--- a/converter/babeltrace-log.c
+++ b/converter/babeltrace-log.c
@@ -332,7 +332,7 @@ int main(int argc, char **argv)
 		exit(EXIT_SUCCESS);
 	}
 
-	ret = mkdir(s_outputname, S_IRWXU|S_IRWXG);
+	ret = compat_mkdir(s_outputname, S_IRWXU|S_IRWXG);
 	if (ret) {
 		perror("mkdir");
 		goto error;
diff --git a/include/babeltrace/compat/fcntl.h b/include/babeltrace/compat/fcntl.h
index f58a1bf..167353c 100644
--- a/include/babeltrace/compat/fcntl.h
+++ b/include/babeltrace/compat/fcntl.h
@@ -6,6 +6,18 @@
 #include <stdarg.h>
 #include <stdio.h>
 
+#ifndef S_IRGRP
+#define S_IRGRP 0
+#endif
+
+#ifndef S_IWGRP
+#define S_IWGRP 0
+#endif
+
+#ifndef S_IRWXG
+#define S_IRWXG 0
+#endif
+
 #ifdef __MINGW32__
 static inline
 int posix_fallocate(int fd, off_t offset, off_t len)
@@ -68,4 +80,19 @@ int compat_closedirfd(int dirfd)
 #endif
 }
 
+static inline
+int compat_mkdir(const char *pathname, ...)
+{
+#ifdef __MINGW32__
+	return mkdir(pathname);
+#else
+	mode_t mode = 0;
+	va_list args;
+	va_start (args, pathname);
+	mode = (mode_t)va_arg(args, int);
+	va_end(args);
+	return mkdir(pathname, mode);
+#endif
+}
+
 #endif
\ No newline at end of file
-- 
1.8.1.msysgit.1
