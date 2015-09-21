From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: glib >= 2.32 required for
	g_hash_table_contains() in lib/values.c
Date: Mon, 21 Sep 2015 16:48:39 -0400
Message-ID: <1442868519-22000-1-git-send-email-mjeanson__35197.612809907$1442868602$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1Ze819-0002u9-Vl
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 16:49:01 -0400
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

---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index dc23daa..a815274 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,7 +54,7 @@ if test ! -f "$srcdir/formats/ctf/metadata/ctf-lexer.c"; then
 fi
 
 
-AM_PATH_GLIB_2_0(2.22.0, ,AC_MSG_ERROR([glib is required in order to compile BabelTrace - download it from ftp://ftp.gtk.org/pub/gtk]) , gmodule)
+AM_PATH_GLIB_2_0(2.32.0, ,AC_MSG_ERROR([glib is required in order to compile BabelTrace - download it from ftp://ftp.gtk.org/pub/gtk]) , gmodule)
 
 # Checks for typedefs, structures, and compiler characteristics.
 AC_C_INLINE
-- 
1.9.1
