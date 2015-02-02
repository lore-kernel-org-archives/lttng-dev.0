From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 1/4] configure: missing check of
	functions
Date: Mon,  2 Feb 2015 16:33:54 -0500
Message-ID: <1422912837-5003-2-git-send-email-jonathan.rajotte-julien__3316.40713052384$1422912920$gmane$org@efficios.com>
References: <1422912837-5003-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YIOdQ-0001Uh-C1
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

Based on autoscan diagnostic

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configure.ac b/configure.ac
index 8d1ff86..192b6a8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -60,6 +60,14 @@ AC_CHECK_HEADERS([ \
 	getopt.h sys/ipc.h sys/shm.h popt.h grp.h \
 ])
 
+# Basic functions check
+AC_CHECK_FUNCS([ \
+	atexit bzero clock_gettime dup2 fdatasync ftruncate \
+	gethostbyname gethostname getpagesize localtime_r memchr memset \
+	mkdir munmap putenv realpath rmdir socket strchr strcspn strdup \
+	strncasecmp strndup strpbrk strrchr strstr strtol strtoul \
+	strtoull \
+])
 # Babeltrace viewer check
 AC_ARG_WITH([babeltrace-bin],
 	AS_HELP_STRING([--with-babeltrace-bin],
-- 
1.9.1
