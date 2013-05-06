From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH lttng-tools 07/14] Adding missing SPLICE syscall
	wrappers for Android
Date: Mon,  6 May 2013 18:18:44 +0000
Message-ID: <1367864331-15212-7-git-send-email-charlesbriere.flatzo__11559.6278607429$1367864427$gmane$org@gmail.com>
References: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1UZQ0D-00005S-AY
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 14:19:09 -0400
Received: by mail-qa0-f48.google.com with SMTP id i13so1608409qae.7
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 11:19:03 -0700 (PDT)
In-Reply-To: <1367864331-15212-1-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: Charles Briere <charlesbriere.flatzo@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
---
 src/common/compat/fcntl.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/common/compat/fcntl.h b/src/common/compat/fcntl.h
index 04fe03a..80a6899 100644
--- a/src/common/compat/fcntl.h
+++ b/src/common/compat/fcntl.h
@@ -31,6 +31,27 @@ typedef off64_t loff_t;
 #endif
 
 #ifdef __linux__
+#ifdef __ANDROID__
+#include <asm/unistd.h>
+#include <sys/syscall.h>
+#define SPLICE_F_MOVE		(0x01)
+#define SPLICE_F_NONBLOCK	(0x02)
+#define SPLICE_F_MORE		(0x04)
+#define SPLICE_F_GIFT		(0x08)
+static inline ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
+	                      loff_t *off_out, size_t len, unsigned int flags)
+{
+	return syscall(__NR_splice,fd_in,off_in,fd_out,off_out,len,flags);
+}
+#include <linux/fs.h>
+#include <linux/fadvise.h>
+#define POSIX_FADV_DONTNEED 0
+static inline int posix_fadvise(int fd, off_t offset, off_t len, int advice)
+{
+       return -ENOSYS;
+}
+#endif /* __ANDROID__ */
+
 extern int compat_sync_file_range(int fd, off64_t offset, off64_t nbytes,
 		unsigned int flags);
 #define lttng_sync_file_range(fd, offset, nbytes, flags) \
-- 
1.8.1.msysgit.1
