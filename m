From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 20/23] Replace mkdir with a more
 compatible compat_mkdir
Date: Wed, 22 May 2013 08:07:39 +0000
Message-ID: <009B25148989C6458484484699278506E5382FE8__43645.2806149193$1369210100$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf45L-0006c7-UY
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:07:48 -0400
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

The MinGW implementation of mkdir only accepts one parameter.
Replace mkdir with compat_mkdir that in MinGW will ignore
the parameters after the first one.
---
 converter/babeltrace-log.c        |  2 +-
 include/babeltrace/compat/fcntl.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
index a2db91a..570a420 100644
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
index 2d6f8e5..efca923 100644
--- a/include/babeltrace/compat/fcntl.h
+++ b/include/babeltrace/compat/fcntl.h
@@ -7,10 +7,31 @@
 #include <stdio.h>
 #include <unistd.h>
 
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
 
 int posix_fallocate(int fd, off_t offset, off_t len);
 
+static inline
+int compat_mkdir(const char *pathname, ...)
+{
+	return mkdir(pathname);
+}
+#else
+
+#define compat_mkdir(X,Y) mkdir((X),(Y))
+
 #endif
 
 /*
-- 
1.8.1.msysgit.1
