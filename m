From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: Possible dereference of null
	pointers
Date: Mon, 21 Sep 2015 16:31:25 -0400
Message-ID: <1442867485-15029-1-git-send-email-mjeanson__21455.0068173141$1442867579$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1Ze7kP-0002lz-Cv
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 16:31:45 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/common/sessiond-comm/unix.c                      | 6 ++++++
 src/lib/lttng-ctl/filter/filter-visitor-set-parent.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/src/common/sessiond-comm/unix.c b/src/common/sessiond-comm/unix.c
index 4b64161..77a6013 100644
--- a/src/common/sessiond-comm/unix.c
+++ b/src/common/sessiond-comm/unix.c
@@ -281,6 +281,9 @@ ssize_t lttcomm_send_fds_unix_sock(int sock, int *fds, size_t nb_fd)
 	msg.msg_controllen = CMSG_LEN(sizeof_fds);
 
 	cmptr = CMSG_FIRSTHDR(&msg);
+	if (!cmptr) {
+		return -1;
+	}
 	cmptr->cmsg_level = SOL_SOCKET;
 	cmptr->cmsg_type = SCM_RIGHTS;
 	cmptr->cmsg_len = CMSG_LEN(sizeof_fds);
@@ -408,6 +411,9 @@ ssize_t lttcomm_send_creds_unix_sock(int sock, void *buf, size_t len)
 	msg.msg_controllen = CMSG_LEN(sizeof_cred);
 
 	cmptr = CMSG_FIRSTHDR(&msg);
+	if (!cmptr) {
+		return -1;
+	}
 	cmptr->cmsg_level = SOL_SOCKET;
 	cmptr->cmsg_type = LTTNG_SOCK_CREDS;
 	cmptr->cmsg_len = CMSG_LEN(sizeof_cred);
diff --git a/src/lib/lttng-ctl/filter/filter-visitor-set-parent.c b/src/lib/lttng-ctl/filter/filter-visitor-set-parent.c
index 91c89dc..f591fd0 100644
--- a/src/lib/lttng-ctl/filter/filter-visitor-set-parent.c
+++ b/src/lib/lttng-ctl/filter/filter-visitor-set-parent.c
@@ -36,6 +36,10 @@ int update_child(struct filter_node *parent,
 		struct filter_node *old_child,
 		struct filter_node *new_child)
 {
+	if (!parent) {
+		fprintf(stderr, "[error] %s: NULL parent\n", __func__);
+		return -EINVAL;
+	}
 	switch (parent->type) {
 	case NODE_UNKNOWN:
 	default:
-- 
1.9.1
