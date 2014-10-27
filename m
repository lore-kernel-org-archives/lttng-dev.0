From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 22/24] Android : Missing defintion
	in fcntl.h
Date: Mon, 27 Oct 2014 20:49:30 +0000
Message-ID: <1414442926-14381-23-git-send-email-c.briere__5644.34698685563$1414443552$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]
 helo=usmailout1.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEX-0007nk-NY
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:46 -0400
Received: from uscpsbgex4.samsung.com
 (u125.gpu85.samsung.co.kr [203.254.195.125]) by mailout1.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400E1WF6MMB40@mailout1.w2.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:34 -0400 (EDT)
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

Add includes for the missing declarations

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 src/common/compat/fcntl.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/common/compat/fcntl.h b/src/common/compat/fcntl.h
index 04fe03a..1325a3f 100644
--- a/src/common/compat/fcntl.h
+++ b/src/common/compat/fcntl.h
@@ -36,6 +36,14 @@ extern int compat_sync_file_range(int fd, off64_t offset, off64_t nbytes,
 #define lttng_sync_file_range(fd, offset, nbytes, flags) \
 	compat_sync_file_range(fd, offset, nbytes, flags)
 
+# ifndef POSIX_FADV_DONTNEED
+#  include <linux/fadvise.h>
+# endif
+
+# ifndef SYNC_FILE_RANGE_WRITE
+#  include <linux/fs.h>
+#endif
+
 #endif /* __linux__ */
 
 #if (defined(__FreeBSD__) || defined(__CYGWIN__))
-- 
2.1.2
