From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 23/24] Android : Define posix_fadvise
Date: Mon, 27 Oct 2014 20:49:30 +0000
Message-ID: <1414442926-14381-24-git-send-email-c.briere__8853.24029154635$1414443866$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]
 helo=usmailout3.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEc-0007nm-LN
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:54 -0400
Received: from uscpsbgex3.samsung.com
 (u124.gpu85.samsung.co.kr [203.254.195.124]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE4004L7F6N5N30@usmailout3.samsung.com> for
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

Mapping from __NR_arm_fadvise64_64  to posix_fadvise
is not done within BIONIC

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 configure.ac              | 1 +
 src/common/compat/fcntl.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index 91efd17..ea37ad0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,6 +67,7 @@ AC_CHECK_TYPES([in_port_t], [], [], [[#include <netinet/in.h>]])
 
 AC_CHECK_DECLS([sigwaitinfo],[],[], [[#include <signal.h>]])
 AC_CHECK_DECLS([pthread_cancel], [], [], [[#include <pthread.h>]])
+AC_CHECK_DECLS([posix_fadvise],[],[], [[#include <fcntl.h>]])
 
 AC_CHECK_FUNCS([getpwuid_r],[],[])
 
diff --git a/src/common/compat/fcntl.h b/src/common/compat/fcntl.h
index 1325a3f..779c942 100644
--- a/src/common/compat/fcntl.h
+++ b/src/common/compat/fcntl.h
@@ -36,6 +36,12 @@ extern int compat_sync_file_range(int fd, off64_t offset, off64_t nbytes,
 #define lttng_sync_file_range(fd, offset, nbytes, flags) \
 	compat_sync_file_range(fd, offset, nbytes, flags)
 
+# if !HAVE_DECL_POSIX_FADVISE
+#  if defined(__NR_arm_fadvise64_64)
+#   define posix_fadvise(fd, offset, len, advise) syscall(__NR_arm_fadvise64_64, fd, offset, len, advise)
+#  endif
+# endif
+
 # ifndef POSIX_FADV_DONTNEED
 #  include <linux/fadvise.h>
 # endif
-- 
2.1.2
