From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH babeltrace 2/3] Configure: add check on headers
Date: Mon, 23 Feb 2015 15:50:37 -0500
Message-ID: <1424724638-4608-3-git-send-email-jonathan.rajotte-julien__1030.56736193157$1424724767$gmane$org@efficios.com>
References: <1424724638-4608-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YPzy7-0000Iv-Dn
 for lttng-dev@lists.lttng.org; Mon, 23 Feb 2015 15:51:09 -0500
In-Reply-To: <1424724638-4608-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

Base on autoscan report:

configure.ac: warning: missing AC_CHECK_HEADERS([fcntl.h]) wanted by: lib/context.c:44
configure.ac: warning: missing AC_CHECK_HEADERS([limits.h]) wanted by: include/babeltrace/compat/limits.h:26
configure.ac: warning: missing AC_CHECK_HEADERS([netdb.h]) wanted by: formats/lttng-live/lttng-live-comm.c:27
configure.ac: warning: missing AC_CHECK_HEADERS([netinet/in.h]) wanted by: formats/lttng-live/lttng-live-comm.c:26
configure.ac: warning: missing AC_CHECK_HEADERS([stddef.h]) wanted by: include/babeltrace/compiler.h:28
configure.ac: warning: missing AC_CHECK_HEADERS([sys/socket.h]) wanted by: formats/lttng-live/lttng-live-comm.c:24

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.ac b/configure.ac
index ffe352f..e2e029c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -21,6 +21,8 @@ AC_PROG_LN_S
 
 AC_CONFIG_HEADERS([config.h])
 
+AC_CHECK_HEADERS([fcntl.h limits.h netdb.h netinet/in.h stddef.h sys/socket.h])
+
 AC_SYS_LARGEFILE
 
 # Checks for programs.
-- 
1.9.1
