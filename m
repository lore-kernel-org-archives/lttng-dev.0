From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 3/4] configure: add check for
	compiler inline keyword support
Date: Mon,  2 Feb 2015 16:33:56 -0500
Message-ID: <1422912837-5003-4-git-send-email-jonathan.rajotte-julien__43622.6531201557$1422912998$gmane$org@efficios.com>
References: <1422912837-5003-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YIOdU-0001Uj-3E
 for lttng-dev@lists.lttng.org; Mon, 02 Feb 2015 16:34:26 -0500
In-Reply-To: <1422912837-5003-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

Check support of the inline keyword by the compiler.
If not supported, inline is replaced by the appropriate keyword or nothing.[1]

Based on autoscan diagnostic

[1]http://www.gnu.org/software/autoconf/manual/autoconf.html#AC_005fC_005fINLINE

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure.ac b/configure.ac
index 5290add..8871889 100644
--- a/configure.ac
+++ b/configure.ac
@@ -70,6 +70,7 @@ AC_CHECK_FUNCS([ \
 	strncasecmp strndup strpbrk strrchr strstr strtol strtoul \
 	strtoull \
 ])
+
 # Babeltrace viewer check
 AC_ARG_WITH([babeltrace-bin],
 	AS_HELP_STRING([--with-babeltrace-bin],
@@ -414,7 +415,11 @@ fi
 AM_CONDITIONAL([BUILD_JAVA_LOG4J_AGENT], [test "x$build_java_log4j_agent" = "xyes"])
 
 AC_SYS_LARGEFILE
+
+# C compiler tests
 AC_PROG_CC
+AC_C_INLINE
+
 LT_INIT
 AC_PROG_YACC
 AC_PROG_LEX
-- 
1.9.1
