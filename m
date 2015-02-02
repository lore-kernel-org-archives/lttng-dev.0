From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/4] configure: missing check for
	needed header
Date: Mon,  2 Feb 2015 16:33:55 -0500
Message-ID: <1422912837-5003-3-git-send-email-jonathan.rajotte-julien__39424.2939925336$1422912931$gmane$org@efficios.com>
References: <1422912837-5003-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YIOdT-0001Ui-Dq
 for lttng-dev@lists.lttng.org; Mon, 02 Feb 2015 16:34:25 -0500
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

Based on autoscan diagnostic:

autoscan: warning: missing AC_CHECK_HEADERS([arpa/inet.h]) wanted by:
	src/common/uri.c:21
	src/common/sessiond-comm/sessiond-comm.h:38
	src/bin/lttng/utils.c:28
autoscan: warning: missing AC_CHECK_HEADERS([netdb.h]) wanted by:
	src/common/uri.c:22
autoscan: warning: missing AC_CHECK_HEADERS([netinet/in.h]) wanted by:
	src/common/uri.h:21
	src/common/sessiond-comm/sessiond-comm.h:39
	src/bin/lttng/utils.c:27
autoscan: warning: missing AC_CHECK_HEADERS([paths.h]) wanted by:
	src/common/daemonize.c:22
	src/bin/lttng-sessiond/main.c:25
autoscan: warning: missing AC_CHECK_HEADERS([stddef.h]) wanted by:
	src/common/defaults.c:20
	src/common/hashtable/rculfhash-mm-chunk.c:25
	src/bin/lttng-sessiond/ust-clock.h:26
autoscan: warning: missing AC_CHECK_HEADERS([sys/file.h]) wanted by:
	src/common/utils.c:34
autoscan: warning: missing AC_CHECK_HEADERS([sys/ioctl.h]) wanted by:
	src/common/kernel-ctl/kernel-ctl.c:22
autoscan: warning: missing AC_CHECK_HEADERS([sys/mount.h]) wanted by:
	src/bin/lttng-sessiond/main.c:33
	src/bin/lttng-relayd/live.c:30
	src/bin/lttng-relayd/main.c:31
autoscan: warning: missing AC_CHECK_HEADERS([sys/param.h]) wanted by:
	src/common/hashtable/utils.c:57
autoscan: warning: missing AC_CHECK_HEADERS([sys/time.h]) wanted by:
	src/common/compat/compat-poll.c:23
	src/bin/lttng-sessiond/ust-clock.h:24
	src/bin/lttng-sessiond/fd-limit.c:21

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 192b6a8..5290add 100644
--- a/configure.ac
+++ b/configure.ac
@@ -57,7 +57,9 @@ AM_CONDITIONAL([NO_SHARED], [test x$enable_shared = xno])
 AC_CHECK_HEADERS([ \
 	sys/types.h unistd.h fcntl.h string.h pthread.h limits.h \
 	signal.h stdlib.h sys/un.h sys/socket.h stdlib.h stdio.h \
-	getopt.h sys/ipc.h sys/shm.h popt.h grp.h \
+	getopt.h sys/ipc.h sys/shm.h popt.h grp.h arpa/inet.h \
+	netdb.h netinet/in.h paths.h stddef.h sys/file.h sys/ioctl.h \
+	sys/mount.h sys/param.h sys/time.h
 ])
 
 # Basic functions check
-- 
1.9.1
