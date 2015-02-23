From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH babeltrace 1/3] Configure: add missing check for
	used funcs
Date: Mon, 23 Feb 2015 15:50:36 -0500
Message-ID: <1424724638-4608-2-git-send-email-jonathan.rajotte-julien__16396.5597203516$1424724731$gmane$org@efficios.com>
References: <1424724638-4608-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YPzy4-0000Ig-9B
 for lttng-dev@lists.lttng.org; Mon, 23 Feb 2015 15:51:08 -0500
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
configure.ac: warning: missing AC_CHECK_FUNCS([ftruncate]) wanted by: formats/ctf/writer/writer.c:237
configure.ac: warning: missing AC_CHECK_FUNCS([gethostbyname]) wanted by: formats/lttng-live/lttng-live-comm.c:122
configure.ac: warning: missing AC_CHECK_FUNCS([localtime_r]) wanted by: formats/ctf/ctf.c:341
configure.ac: warning: missing AC_CHECK_FUNCS([memset]) wanted by: converter/babeltrace-log.c:228
configure.ac: warning: missing AC_CHECK_FUNCS([mkdir]) wanted by: converter/babeltrace-log.c:404
configure.ac: warning: missing AC_CHECK_FUNCS([rmdir]) wanted by: converter/babeltrace-log.c:467
configure.ac: warning: missing AC_CHECK_FUNCS([setenv]) wanted by: include/babeltrace/compat/utc.h:71
configure.ac: warning: missing AC_CHECK_FUNCS([socket]) wanted by: formats/lttng-live/lttng-live-comm.c:129
configure.ac: warning: missing AC_CHECK_FUNCS([strchr]) wanted by: converter/babeltrace-log.c:244
configure.ac: warning: missing AC_CHECK_FUNCS([strdup]) wanted by: converter/babeltrace.c:701
configure.ac: warning: missing AC_CHECK_FUNCS([strerror]) wanted by: formats/ctf/ctf.c:682
configure.ac: warning: missing AC_CHECK_FUNCS([strndup]) wanted by: formats/lttng-live/lttng-live-comm.c:280
configure.ac: warning: missing AC_CHECK_FUNCS([strrchr]) wanted by: converter/babeltrace-log.c:334
configure.ac: warning: missing AC_CHECK_FUNCS([strtoull]) wanted by: converter/babeltrace.c:354
configure.ac: warning: missing AC_CHECK_FUNCS([tzset]) wanted by: include/babeltrace/compat/utc.h:72

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 934bf03..ffe352f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -55,7 +55,11 @@ AC_TYPE_SIZE_T
 # Checks for library functions.
 AC_FUNC_MALLOC
 AC_FUNC_MMAP
-AC_CHECK_FUNCS([bzero gettimeofday munmap strtoul])
+AC_CHECK_FUNCS([ \
+	bzero gettimeofday munmap strtoul ftruncate gethostbyname \
+	localtime_r memset mkdir rmdir setenv socket \
+	strchr strdup strerror strndup strrchr strtoull tzset \
+])
 
 # Check for MinGW32.
 MINGW32=no
-- 
1.9.1
