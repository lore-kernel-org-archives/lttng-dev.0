From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [babeltrace RFC PATCH 06/28] Add MinGW implementation
	of UUID
Date: Thu, 2 May 2013 11:47:13 +0000
Message-ID: <009B25148989C6458484484699278506E537E866__24674.1342744373$1367495272$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXryr-0001t6-9i
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:47:21 -0400
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

Implementation of UUID functions for MinGW32, using Windows API.
---
 compat/Makefile.am               |  3 ++
 compat/compat_uuid.c             | 75 ++++++++++++++++++++++++++++++++++++++++
 configure.ac                     |  5 ++-
 include/babeltrace/compat/uuid.h | 32 ++++++++++++++++-
 4 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 compat/compat_uuid.c

diff --git a/compat/Makefile.am b/compat/Makefile.am
index d756aa7..e624a79 100644
--- a/compat/Makefile.am
+++ b/compat/Makefile.am
@@ -8,3 +8,6 @@ libcompat_la_SOURCES = \
 libcompat_la_LDFLAGS = \
 	-Wl,--no-as-needed
 
+if BABELTRACE_BUILD_WITH_MINGW
+libcompat_la_SOURCES += compat_uuid.c
+endif
\ No newline at end of file
diff --git a/compat/compat_uuid.c b/compat/compat_uuid.c
new file mode 100644
index 0000000..0e67f73
--- /dev/null
+++ b/compat/compat_uuid.c
@@ -0,0 +1,75 @@
+/* This file is only built under MINGW32 */
+
+#include <windows.h>
+#include <stdlib.h>
+#include <babeltrace/compat/uuid.h>
+
+static void fix_uuid_endian(struct UUID * uuid)
+{
+	unsigned char * ptr;
+	unsigned char tmp;
+	#define SWAP(p, i, j) tmp=*(p+i);*(p+i)=*(p+j);*(p+j)=tmp;
+	ptr = (unsigned char *)uuid;
+	SWAP(ptr, 0, 3)
+	SWAP(ptr, 1, 2)
+	SWAP(ptr, 4, 5)
+	SWAP(ptr, 6, 7)
+
+}
+
+int compat_uuid_generate(unsigned char *uuid_out)
+{
+	RPC_STATUS status;
+	status = UuidCreate((struct UUID *)uuid_out);
+	if (status == RPC_S_OK)
+		return 0;
+	else
+		return -1;
+}
+
+int compat_uuid_unparse(const unsigned char *uuid_in, char *str_out)
+{
+	RPC_STATUS status;
+	unsigned char *alloc_str;
+	int ret;
+	fix_uuid_endian(uuid_in);
+	status = UuidToString((struct UUID *)uuid_in, &alloc_str);
+	fix_uuid_endian(uuid_in);
+	if (status == RPC_S_OK) {
+		strcpy(str_out, alloc_str);
+		ret = 0;
+	} else {
+		ret = -1;
+	}
+	RpcStringFree(alloc_str);
+	return ret;
+}
+
+int compat_uuid_parse(const char *str_in, unsigned char *uuid_out)
+{
+	RPC_STATUS status;
+
+	status = UuidFromString(str_in, (struct UUID *)uuid_out);
+	fix_uuid_endian(uuid_out);
+
+	if (status == RPC_S_OK)
+		return 0;
+	else
+		return -1;
+}
+
+int compat_uuid_compare(const unsigned char *uuid_a,
+		const unsigned char *uuid_b)
+{
+	RPC_STATUS status;
+	int ret;
+
+	if (UuidCompare((struct UUID *)uuid_a, (struct UUID *)uuid_b, &status) == 0)
+		ret = 0;
+	else
+	{
+		ret = -1;
+	}
+	return ret;
+
+}
diff --git a/configure.ac b/configure.ac
index 65e867c..5f9e38d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -60,7 +60,10 @@ AC_CHECK_LIB([uuid], [uuid_generate],
 		have_libc_uuid=yes
 	],
 	[
-		AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc uuid_create. Use [LDFLAGS]=-Ldir to specify their location.])
+		# for MinGW32 we have our own internal implemenation of uuid using Windows functions.
+		if test "x$MINGW32" = xno; then
+			AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc uuid_create. Use [LDFLAGS]=-Ldir to specify their location.])
+		fi
 	])
 ]
 )
diff --git a/include/babeltrace/compat/uuid.h b/include/babeltrace/compat/uuid.h
index 2ce7467..a916a49 100644
--- a/include/babeltrace/compat/uuid.h
+++ b/include/babeltrace/compat/uuid.h
@@ -122,8 +122,38 @@ int babeltrace_uuid_compare(const unsigned char *uuid_a,
 		return -1;
 }
 
+#elif defined(__MINGW32__)
+static inline
+int babeltrace_uuid_generate(unsigned char *uuid_out)
+{
+	extern int compat_uuid_generate(unsigned char *uuid_out);
+	return compat_uuid_generate(uuid_out);
+}
+
+static inline
+int babeltrace_uuid_unparse(const unsigned char *uuid_in, char *str_out)
+{
+	extern int compat_uuid_unparse(const unsigned char *uuid_in, char *str_out);
+	return compat_uuid_unparse(uuid_in, str_out);
+}
+
+static inline
+int babeltrace_uuid_parse(const char *str_in, unsigned char *uuid_out)
+{
+	extern int compat_uuid_parse(const char *str_in, unsigned char *uuid_out);
+	return compat_uuid_parse(str_in, uuid_out);
+}
+
+static inline
+int babeltrace_uuid_compare(const unsigned char *uuid_a,
+		const unsigned char *uuid_b)
+{
+	extern int compat_uuid_compare(const unsigned char *uuid_a,
+		const unsigned char *uuid_b);
+	return compat_uuid_compare(uuid_a, uuid_b);
+}
 #else
 #error "Babeltrace needs to have a UUID generator configured."
 #endif
 
-#endif /* _BABELTRACE_UUID_H */
+#endif /* _BABELTRACE_INCLUDE_COMPAT_UUID_H */
-- 
1.8.1.msysgit.1
