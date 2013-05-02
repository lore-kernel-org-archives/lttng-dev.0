From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 13/28] Add compat library to
	executables
Date: Thu, 2 May 2013 11:54:37 +0000
Message-ID: <009B25148989C6458484484699278506E537E8FA__32374.541872605$1367495718$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXs61-00021d-O6
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:54:45 -0400
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
 converter/Makefile.am | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/converter/Makefile.am b/converter/Makefile.am
index 2bde9c3..ca03927 100644
--- a/converter/Makefile.am
+++ b/converter/Makefile.am
@@ -13,6 +13,7 @@ babeltrace_LDFLAGS = -Wl,--no-as-needed
 babeltrace_LDADD = \
 	$(top_builddir)/lib/libbabeltrace.la \
 	$(top_builddir)/formats/ctf/libbabeltrace-ctf.la \
+	$(top_builddir)/compat/libcompat.la \
 	$(top_builddir)/formats/ctf-text/libbabeltrace-ctf-text.la \
 	$(top_builddir)/formats/ctf-metadata/libbabeltrace-ctf-metadata.la \
 	$(top_builddir)/formats/bt-dummy/libbabeltrace-dummy.la
@@ -21,7 +22,8 @@ babeltrace_log_SOURCES = babeltrace-log.c
 
 babeltrace_log_LDADD = \
 	$(top_builddir)/lib/libbabeltrace.la \
-	$(top_builddir)/formats/ctf/libbabeltrace-ctf.la
+	$(top_builddir)/formats/ctf/libbabeltrace-ctf.la \
+	$(top_builddir)/compat/libcompat.la
 
 if BABELTRACE_BUILD_WITH_LIBUUID
 babeltrace_log_LDADD += -luuid
-- 
1.8.1.msysgit.1
