From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Fix: Remove network stream ID ABI
	calls
Date: Tue, 16 Oct 2012 20:44:13 -0400
Message-ID: <1350434653-8724-1-git-send-email-jdesfossez__4000.08147485114$1350434701$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TOHkJ-0000zu-Dr
	for lttng-dev@lists.lttng.org; Tue, 16 Oct 2012 20:44:27 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This patch removes some experimental kernel ABI calls that were not
supposed to get merged. The kernel support for these calls has never
been introduced in lttng-modules.

I'm not sure how it happened, but it seems that this code got introduced
along with the commit 00e2e675d54dc726a7c8f8887c889cc8ef022003

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/common/kernel-ctl/kernel-ctl.c   |    6 ------
 src/common/kernel-ctl/kernel-ctl.h   |    2 --
 src/common/kernel-ctl/kernel-ioctl.h |    4 ----
 3 files changed, 12 deletions(-)

diff --git a/src/common/kernel-ctl/kernel-ctl.c b/src/common/kernel-ctl/kernel-ctl.c
index a93d251..e4a268e 100644
--- a/src/common/kernel-ctl/kernel-ctl.c
+++ b/src/common/kernel-ctl/kernel-ctl.c
@@ -378,9 +378,3 @@ int kernctl_put_subbuf(int fd)
 {
 	return ioctl(fd, RING_BUFFER_PUT_SUBBUF);
 }
-
-/* Set the stream_id */
-int kernctl_set_stream_id(int fd, unsigned long *stream_id)
-{
-	return ioctl(fd, RING_BUFFER_SET_STREAM_ID, stream_id);
-}
diff --git a/src/common/kernel-ctl/kernel-ctl.h b/src/common/kernel-ctl/kernel-ctl.h
index 85a3a18..ea2aa58 100644
--- a/src/common/kernel-ctl/kernel-ctl.h
+++ b/src/common/kernel-ctl/kernel-ctl.h
@@ -66,7 +66,5 @@ int kernctl_get_subbuf(int fd, unsigned long *pos);
 int kernctl_put_subbuf(int fd);
 
 int kernctl_buffer_flush(int fd);
-int kernctl_set_stream_id(int fd, unsigned long *stream_id);
-int kernctl_get_net_stream_id_offset(int fd, unsigned long *offset);
 
 #endif /* _LTTNG_KERNEL_CTL_H */
diff --git a/src/common/kernel-ctl/kernel-ioctl.h b/src/common/kernel-ctl/kernel-ioctl.h
index 8e22632..75d6da0 100644
--- a/src/common/kernel-ctl/kernel-ioctl.h
+++ b/src/common/kernel-ctl/kernel-ioctl.h
@@ -46,8 +46,6 @@
 #define RING_BUFFER_GET_MMAP_READ_OFFSET    _IOR(0xF6, 0x0B, unsigned long)
 /* flush the current sub-buffer */
 #define RING_BUFFER_FLUSH                   _IO(0xF6, 0x0C)
-/* map stream to stream id for network streaming */
-#define RING_BUFFER_SET_STREAM_ID           _IOW(0xF6, 0x0D, unsigned long)
 
 /* Old ABI (without support for 32/64 bits compat) */
 /* LTTng file descriptor ioctl */
@@ -71,8 +69,6 @@
 #define LTTNG_KERNEL_OLD_STREAM                 _IO(0xF6, 0x60)
 #define LTTNG_KERNEL_OLD_EVENT                  \
 		_IOW(0xF6, 0x61, struct lttng_kernel_old_event)
-#define LTTNG_KERNEL_OLD_STREAM_ID_OFFSET       \
-		_IOR(0xF6, 0x62, unsigned long)
 
 /* Event and Channel FD ioctl */
 #define LTTNG_KERNEL_OLD_CONTEXT                \
-- 
1.7.10.4
