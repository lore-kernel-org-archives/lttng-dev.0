From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: check for socket lib before
	function checks
Date: Thu, 15 Oct 2015 16:38:59 -0400
Message-ID: <1444941539-15017-1-git-send-email-mjeanson__4969.98256207934$1444941624$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZmpJ3-0005xV-Em
 for lttng-dev@lists.lttng.org; Thu, 15 Oct 2015 16:39:25 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

On platforms that require extra libraries to link socket apps,
running this macro before the function checks will lead to
socket functions being correctly detected.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 31bc76a..55a357b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -81,9 +81,11 @@ if test ! -f "$srcdir/formats/ctf/metadata/ctf-lexer.c"; then
         ])
 fi
 
-
 AM_PATH_GLIB_2_0(2.22.0, ,AC_MSG_ERROR([glib is required in order to compile BabelTrace - download it from ftp://ftp.gtk.org/pub/gtk]) , gmodule)
 
+# Check what libraries are required on this platform to link sockets programs.
+AX_LIB_SOCKET_NSL
+
 # Checks for typedefs, structures, and compiler characteristics.
 AC_C_INLINE
 AC_TYPE_PID_T
@@ -145,9 +147,6 @@ esac
 
 AM_CONDITIONAL([BABELTRACE_BUILD_WITH_MINGW], [test "x$MINGW32" = "xyes"])
 
-# Check what libraries are required on this platform to link sockets programs.
-AX_LIB_SOCKET_NSL
-
 # Check for libuuid
 AC_CHECK_LIB([uuid], [uuid_generate],
 [
-- 
1.9.1
