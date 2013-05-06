From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH lttng-tools 08/14] Added configure option for
	specifying lttng run directory [LTTNG_RUNDIR] Set different
	default run directory for Android
Date: Mon,  6 May 2013 18:18:45 +0000
Message-ID: <1367864331-15212-8-git-send-email-charlesbriere.flatzo__16140.3838465505$1367864422$gmane$org@gmail.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1UZQ0E-00005g-TW
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 14:19:11 -0400
Received: by mail-qa0-f53.google.com with SMTP id f11so1115742qae.12
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 11:19:05 -0700 (PDT)
In-Reply-To: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: Charles Briere <charlesbriere.flatzo@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
---
 configure.ac          | 23 +++++++++++++++++++++--
 src/common/defaults.h |  2 --
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index eb79fc4..b3738d2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -43,8 +43,10 @@ AM_CONDITIONAL([NO_SHARED], [test x$enable_shared = xno])
 
 AM_CONDITIONAL([TARGET_HOST_ANDROID], [false])
 case "${host}" in
-    *-*-linux-androideabi) AM_CONDITIONAL([TARGET_HOST_ANDROID], [true])
-    ;;
+	*-*-linux-androideabi)
+		AM_CONDITIONAL([TARGET_HOST_ANDROID], [true])
+		target_host_android="yes"
+	;;
 esac
 
 AC_CHECK_HEADERS([ \
@@ -256,6 +258,23 @@ AC_CHECK_LIB([c], [open_memstream],
 ]
 )
 
+AC_ARG_VAR([LTTNG_RUNDIR], [Path to run directory, default to /var/run])
+
+AS_IF([test -n "$LTTNG_RUNDIR"],
+[
+	lttng_rundir=$LTTNG_RUNDIR
+],
+[
+	AS_IF([test "x$target_host_android" = "xyes"],
+	[
+		lttng_rundir="/data/lttng/var/run"
+	],
+	[
+		lttng_rundir="/var/run/lttng"
+	])
+])
+AC_DEFINE_UNQUOTED([DEFAULT_LTTNG_RUNDIR], ["$lttng_rundir"], [Location of the run directory])
+
 # For Python
 # SWIG version needed or newer:
 swig_version=2.0.0
diff --git a/src/common/defaults.h b/src/common/defaults.h
index fb6a975..74400d7 100644
--- a/src/common/defaults.h
+++ b/src/common/defaults.h
@@ -76,8 +76,6 @@
 #define DEFAULT_USTCONSUMERD32_CMD_SOCK_PATH    DEFAULT_USTCONSUMERD32_PATH "/command"
 #define DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH    DEFAULT_USTCONSUMERD32_PATH "/error"
 
-/* Default lttng run directory */
-#define DEFAULT_LTTNG_RUNDIR                    "/var/run/lttng"
 #define DEFAULT_LTTNG_HOME_RUNDIR               "%s/.lttng"
 #define DEFAULT_LTTNG_SESSIOND_PIDFILE          "lttng-sessiond.pid"
 
-- 
1.8.1.msysgit.1
