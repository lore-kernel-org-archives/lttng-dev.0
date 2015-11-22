From: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH lttng-tools] configure.ac: fix static build
Date: Sun, 22 Nov 2015 23:38:00 +0100
Message-ID: <1448231881-7988-1-git-send-email-s.martin49__38511.4712211818$1448231961$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <s.martin49@gmail.com>) id 1a0dGv-0001rR-Kq
 for lttng-dev@lists.lttng.org; Sun, 22 Nov 2015 17:38:18 -0500
Received: by wmww144 with SMTP id w144so76167817wmw.1
 for <lttng-dev@lists.lttng.org>; Sun, 22 Nov 2015 14:38:07 -0800 (PST)
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

For static build, some extra LDFLAGS may be needed.

Using PKG_CHECK_MODULES instead of AC_CHECK_LIB for librairy detection
allows to get all these flags. Then, the LIBS variable can be extended
with everything that is needed.

So, use PKG_CHECK_MODULES for popt and uuid detection; which both depend
on libintl.

This changes fixes build failures triggered with Buildroot, e.g.:
  http://autobuild.buildroot.net/results/0f1/0f1e015a0c5a5ac2beeb5011d31a1e0058a32a0d/build-end.log

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 configure.ac | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9cc411e..fad4de6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -218,15 +218,17 @@ AC_CHECK_LIB([pthread], [pthread_create], [],
 )
 
 # Check libpopt
-AC_CHECK_LIB([popt], [poptGetContext], [],
+PKG_CHECK_MODULES([POPT], [popt],
+	[LIBS="$LIBS $POPT_LIBS"],
 	[AC_MSG_ERROR([Cannot find libpopt. Use [LDFLAGS]=-Ldir to specify its location.])]
 )
 
 AM_PATH_XML2(2.7.6, true, AC_MSG_ERROR(No supported version of libxml2 found.))
 
 # Check for libuuid
-AC_CHECK_LIB([uuid], [uuid_generate],
+PKG_CHECK_MODULES([UUID], [uuid],
 [
+	LIBS="$LIBS $UUID_LIBS"
 	AC_DEFINE_UNQUOTED([LTTNG_HAVE_LIBUUID], 1, [Has libuuid support.])
 	have_libuuid=yes
 ],
-- 
2.6.2
