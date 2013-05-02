From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 04/28] Add MinGW32 libraries to
	executable
Date: Thu, 2 May 2013 11:46:53 +0000
Message-ID: <009B25148989C6458484484699278506E537E84C__16103.4460216344$1367495257$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXryZ-0001ph-Tw
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:47:04 -0400
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

Add MinGW32 specific libraries to all link commands.
---
 configure.ac                     | 9 +++++++++
 converter/Makefile.am            | 5 +++++
 formats/ctf/metadata/Makefile.am | 3 +++
 3 files changed, 17 insertions(+)

diff --git a/configure.ac b/configure.ac
index 29366da..65e867c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -37,6 +37,15 @@ AC_FUNC_MALLOC
 AC_FUNC_MMAP
 AC_CHECK_FUNCS([bzero gettimeofday munmap strtoul])
 
+# Check for MinGW32.
+MINGW32=no
+case $host in
+  *-*-mingw*)
+	MINGW32=yes;;
+esac
+
+AM_CONDITIONAL([BABELTRACE_BUILD_WITH_MINGW], [test "x$MINGW32" = "xyes"])
+
 # Check for libuuid
 AC_CHECK_LIB([uuid], [uuid_generate],
 [
diff --git a/converter/Makefile.am b/converter/Makefile.am
index de70313..2bde9c3 100644
--- a/converter/Makefile.am
+++ b/converter/Makefile.am
@@ -29,3 +29,8 @@ endif
 if BABELTRACE_BUILD_WITH_LIBC_UUID
 babeltrace_log_LDADD += -lc
 endif
+
+if BABELTRACE_BUILD_WITH_MINGW
+babeltrace_log_LDADD += -lrpcrt4 -lintl -liconv -lole32 -lpopt -lpthread
+babeltrace_LDADD += -lrpcrt4 -lintl -liconv -lole32 -lpopt -lpthread
+endif
\ No newline at end of file
diff --git a/formats/ctf/metadata/Makefile.am b/formats/ctf/metadata/Makefile.am
index b33ce55..69f7127 100644
--- a/formats/ctf/metadata/Makefile.am
+++ b/formats/ctf/metadata/Makefile.am
@@ -27,6 +27,9 @@ endif
 if BABELTRACE_BUILD_WITH_LIBC_UUID
 libctf_ast_la_LIBADD += -lc
 endif
+if BABELTRACE_BUILD_WITH_MINGW
+libctf_ast_la_LIBADD += -lrpcrt4 -lintl -liconv -lole32 -lpopt
+endif
 
 noinst_PROGRAMS = ctf-parser-test
 ctf_parser_test_SOURCES = ctf-parser-test.c
-- 
1.8.1.msysgit.1
