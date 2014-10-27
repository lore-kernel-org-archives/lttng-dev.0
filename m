From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 24/24] Android : Add splice
 compatibility to fcntl layer
Date: Mon, 27 Oct 2014 20:49:30 +0000
Message-ID: <1414442926-14381-25-git-send-email-c.briere__20422.7717630149$1414443567$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]
 helo=usmailout1.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEZ-0007nk-0K
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:48 -0400
Received: from uscpsbgex2.samsung.com
 (u123.gpu85.samsung.co.kr [203.254.195.123]) by mailout1.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400E38F6NVE40@mailout1.w2.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:35 -0400 (EDT)
In-reply-to: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Content-language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>, "dgoulet@efficios.com" <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "karim.yaghmour@opersys.com" <karim.yaghmour@opersys.com>
List-Id: lttng-dev@lists.lttng.org

From: Charles Briere <c.briere@samsung.com>

Define splice() as __NR_splice() when not available directly (happens with BIONIC)
Define SPLICE_*_* values

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 configure.ac              |  2 +-
 src/common/compat/fcntl.h | 26 +++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index ea37ad0..7230e92 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,7 +67,7 @@ AC_CHECK_TYPES([in_port_t], [], [], [[#include <netinet/in.h>]])
 
 AC_CHECK_DECLS([sigwaitinfo],[],[], [[#include <signal.h>]])
 AC_CHECK_DECLS([pthread_cancel], [], [], [[#include <pthread.h>]])
-AC_CHECK_DECLS([posix_fadvise],[],[], [[#include <fcntl.h>]])
+AC_CHECK_DECLS([posix_fadvise, splice],[],[], [[#include <fcntl.h>]])
 
 AC_CHECK_FUNCS([getpwuid_r],[],[])
 
diff --git a/src/common/compat/fcntl.h b/src/common/compat/fcntl.h
index 779c942..b3453a2 100644
--- a/src/common/compat/fcntl.h
+++ b/src/common/compat/fcntl.h
@@ -46,9 +46,33 @@ extern int compat_sync_file_range(int fd, off64_t offset, off64_t nbytes,
 #  include <linux/fadvise.h>
 # endif
 
+# if !HAVE_DECL_SPLICE
+#  if defined(__NR_splice)
+#   define splice(fdin, off_in, fdout, off_out, len, flags) syscall(__NR_splice, fdin, off_in, fdout, off_out, len, flags)
+#  endif
+# endif
+
 # ifndef SYNC_FILE_RANGE_WRITE
 #  include <linux/fs.h>
-#endif
+# endif
+
+# ifndef SPLICE_F_MOVE
+#  define SPLICE_F_MOVE 	1	/* Move pages instead of copying.  */
+# endif
+
+# ifndef SPLICE_F_NONBLOCK
+#  define SPLICE_F_NONBLOCK	2	/* Don't block on the pipe splicing
+					  (but we may still block on the fd
+					  we splice from/to).  */
+# endif
+
+# ifndef SPLICE_F_MORE
+#  define SPLICE_F_MORE 	4	/* Expect more data.  */
+# endif
+
+# ifndef SPLICE_F_GIFT
+#  define SPLICE_F_GIFT		8	/* Pages passed in are a gift.  */
+# endif
 
 #endif /* __linux__ */
 
-- 
2.1.2
