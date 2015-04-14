From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-tools v2] Fix python bindings' Makefile
	for out-of-tree builds
Date: Tue, 14 Apr 2015 16:45:27 -0400
Message-ID: <1429044327-31152-1-git-send-email-simon.marchi__38710.3884168484$1429044410$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [96.127.255.83] (helo=smtp.electronicbox.net)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <simon.marchi@polymtl.ca>) id 1Yi7i8-0001Pt-70
 for lttng-dev@lists.lttng.org; Tue, 14 Apr 2015 16:45:40 -0400
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

The references to the built archives should use top_builddir and not
top_srcdir, because that's where they are.

And new in V2, I got a new error:

  lttng_wrap.c:2970:25: fatal error: lttng/lttng.h: No such file or directory
   #include <lttng/lttng.h>

I think we are missing the -I$(top_srcdir)/include. I had not noticed this
previously, probably because I had an lttng/lttng.h in
/usr/local/include or /usr/include. Also, the other includes seem
unnecessary. The This is not really related to out-of-tree builds though.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 extras/bindings/swig/python/Makefile.am | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/extras/bindings/swig/python/Makefile.am b/extras/bindings/swig/python/Makefile.am
index ec35930..35f28d5 100644
--- a/extras/bindings/swig/python/Makefile.am
+++ b/extras/bindings/swig/python/Makefile.am
@@ -1,8 +1,7 @@
 lttng.i: lttng.i.in
-	sed "s/LTTNG_VERSION_STR/LTTng $(PACKAGE_VERSION)/g" <lttng.i.in >lttng.i
+	sed "s/LTTNG_VERSION_STR/LTTng $(PACKAGE_VERSION)/g" < $(srcdir)/lttng.i.in >lttng.i
 
-AM_CFLAGS = $(PYTHON_INCLUDE) -I$(top_srcdir)/lib/lttng-ctl -I../common \
-              $(BUDDY_CFLAGS)
+AM_CFLAGS = $(PYTHON_INCLUDE) -I$(top_srcdir)/include
 
 EXTRA_DIST = lttng.i.in
 nodist_python_PYTHON = lttng.py
@@ -12,9 +11,9 @@ MAINTAINERCLEANFILES = lttng_wrap.c lttng.py
 
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
2.3.5
