From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH babeltrace 3/3] Configure: add check for type
Date: Mon, 23 Feb 2015 15:50:38 -0500
Message-ID: <1424724638-4608-4-git-send-email-jonathan.rajotte-julien__48804.4775127948$1424724787$gmane$org@efficios.com>
References: <1424724638-4608-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YPzy9-0000JA-I0
 for lttng-dev@lists.lttng.org; Mon, 23 Feb 2015 15:51:10 -0500
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

Based on autoscan report:

configure.ac: warning: missing AC_TYPE_INT16_T wanted by: formats/ctf/types/integer.c:111
configure.ac: warning: missing AC_TYPE_INT32_T wanted by: formats/ctf/types/integer.c:120
configure.ac: warning: missing AC_TYPE_INT64_T wanted by: lib/trace-collection.c:111
configure.ac: warning: missing AC_TYPE_INT8_T wanted by: formats/ctf/types/integer.c:103
configure.ac: warning: missing AC_TYPE_OFF_T wanted by: formats/ctf/ctf.c:863
configure.ac: warning: missing AC_TYPE_SSIZE_T wanted by: lib/iterator.c:51
configure.ac: warning: missing AC_TYPE_UINT16_T wanted by: formats/ctf/types/integer.c:71
configure.ac: warning: missing AC_TYPE_UINT32_T wanted by: converter/babeltrace-log.c:127
configure.ac: warning: missing AC_TYPE_UINT64_T wanted by: lib/iterator.c:52
configure.ac: warning: missing AC_TYPE_UINT8_T wanted by: converter/babeltrace-log.c:141

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configure.ac b/configure.ac
index e2e029c..6c1bbc7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -53,6 +53,16 @@ AM_PATH_GLIB_2_0(2.22.0, ,AC_MSG_ERROR([glib is required in order to compile Bab
 AC_C_INLINE
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
+AC_TYPE_INT16_T
+AC_TYPE_INT32_T
+AC_TYPE_INT64_T
+AC_TYPE_INT8_T
+AC_TYPE_OFF_T
+AC_TYPE_SSIZE_T
+AC_TYPE_UINT16_T
+AC_TYPE_UINT32_T
+AC_TYPE_UINT64_T
+AC_TYPE_UINT8_T
 
 # Checks for library functions.
 AC_FUNC_MALLOC
-- 
1.9.1
