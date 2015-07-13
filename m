From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 8/9] kernctl commands to extract the
	stream instance id
Date: Mon, 13 Jul 2015 11:28:08 -0400
Message-ID: <1436801289-17554-9-git-send-email-jdesfossez__18945.038438733$1436801670$gmane$org@efficios.com>
References: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfeh-0008PY-V0
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:28:32 -0400
In-Reply-To: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/common/kernel-ctl/kernel-ctl.c   | 6 ++++++
 src/common/kernel-ctl/kernel-ctl.h   | 1 +
 src/common/kernel-ctl/kernel-ioctl.h | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/src/common/kernel-ctl/kernel-ctl.c b/src/common/kernel-ctl/kernel-ctl.c
index b3be8be..2f0050c 100644
--- a/src/common/kernel-ctl/kernel-ctl.c
+++ b/src/common/kernel-ctl/kernel-ctl.c
@@ -539,3 +539,9 @@ int kernctl_get_sequence_number(int fd, uint64_t *seq)
 {
 	return ioctl(fd, LTTNG_RING_BUFFER_GET_SEQ_NUM, seq);
 }
+
+/* Returns the stream instance id. */
+int kernctl_get_instance_id(int fd, uint64_t *id)
+{
+	return ioctl(fd, LTTNG_RING_BUFFER_INSTANCE_ID, id);
+}
diff --git a/src/common/kernel-ctl/kernel-ctl.h b/src/common/kernel-ctl/kernel-ctl.h
index ab8154c..9294888 100644
--- a/src/common/kernel-ctl/kernel-ctl.h
+++ b/src/common/kernel-ctl/kernel-ctl.h
@@ -100,5 +100,6 @@ int kernctl_get_packet_size(int fd, uint64_t *packet_size);
 int kernctl_get_stream_id(int fd, uint64_t *stream_id);
 int kernctl_get_current_timestamp(int fd, uint64_t *ts);
 int kernctl_get_sequence_number(int fd, uint64_t *seq);
+int kernctl_get_instance_id(int fd, uint64_t *seq);
 
 #endif /* _LTTNG_KERNEL_CTL_H */
diff --git a/src/common/kernel-ctl/kernel-ioctl.h b/src/common/kernel-ctl/kernel-ioctl.h
index d988a83..b37605b 100644
--- a/src/common/kernel-ctl/kernel-ioctl.h
+++ b/src/common/kernel-ctl/kernel-ioctl.h
@@ -66,6 +66,8 @@
 #define LTTNG_RING_BUFFER_GET_CURRENT_TIMESTAMP   _IOR(0xF6, 0x26, uint64_t)
 /* returns the packet sequence number */
 #define LTTNG_RING_BUFFER_GET_SEQ_NUM             _IOR(0xF6, 0x27, uint64_t)
+/* returns the stream instance id */
+#define LTTNG_RING_BUFFER_INSTANCE_ID             _IOR(0xF6, 0x28, uint64_t)
 
 /* Old ABI (without support for 32/64 bits compat) */
 /* LTTng file descriptor ioctl */
-- 
1.9.1
