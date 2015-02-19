From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-tools] Fix python bindings' Makefile for
	out-of-tree builds
Date: Thu, 19 Feb 2015 11:18:36 -0500
Message-ID: <1424362716-9913-1-git-send-email-simon.marchi__48978.3186851584$1424362795$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.electronicbox.net ([96.127.255.82])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <simon.marchi@polymtl.ca>) id 1YOToI-0003ob-N4
 for lttng-dev@lists.lttng.org; Thu, 19 Feb 2015 11:18:47 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 extras/bindings/swig/python/Makefile.am | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/extras/bindings/swig/python/Makefile.am b/extras/bindings/swig/python/Makefile.am
index ec35930..3b71171 100644
--- a/extras/bindings/swig/python/Makefile.am
+++ b/extras/bindings/swig/python/Makefile.am
@@ -1,5 +1,5 @@
 lttng.i: lttng.i.in
-	sed "s/LTTNG_VERSION_STR/LTTng $(PACKAGE_VERSION)/g" <lttng.i.in >lttng.i
+	sed "s/LTTNG_VERSION_STR/LTTng $(PACKAGE_VERSION)/g" < $(srcdir)/lttng.i.in >lttng.i
 
 AM_CFLAGS = $(PYTHON_INCLUDE) -I$(top_srcdir)/lib/lttng-ctl -I../common \
               $(BUDDY_CFLAGS)
@@ -12,9 +12,9 @@ MAINTAINERCLEANFILES = lttng_wrap.c lttng.py
 
 nodist__lttng_la_SOURCES = lttng_wrap.c
 _lttng_la_LDFLAGS = -module
-_lttng_la_LIBADD = 	$(top_srcdir)/src/lib/lttng-ctl/liblttng-ctl.la 		\
-			$(top_srcdir)/src/common/sessiond-comm/libsessiond-comm.la		\
-			$(top_srcdir)/src/common/libcommon.la
+_lttng_la_LIBADD = 	$(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la 		\
+			$(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la		\
+			$(top_builddir)/src/common/libcommon.la
 
 lttng_wrap.c: lttng.i
 	$(SWIG) -python -I. -I$(top_srcdir)/src/common/sessiond-comm lttng.i
-- 
2.3.0
