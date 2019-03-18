From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 3/5] Fix: pipe: stop using
 ->can_merge (v5.1)
Date: Mon, 18 Mar 2019 16:20:34 -0400
Message-ID: <20190318202036.17523-3-mjeanson__18686.5611978405$1552940552$gmane$org@efficios.com>
References: <20190318202036.17523-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44NSHg24BBz17XT
 for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2019 16:21:03 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E66531C8D85
 for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2019 16:21:02 -0400 (EDT)
In-Reply-To: <20190318202036.17523-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

See upstream commit:

  commit 01e7187b41191376cee8bea8de9f907b001e87b4
  Author: Jann Horn <jannh@google.com>
  Date:   Wed Jan 23 15:19:18 2019 +0100

    pipe: stop using ->can_merge

    Al Viro pointed out that since there is only one pipe buffer type to which
    new data can be appended, it isn't necessary to have a ->can_merge field in
    struct pipe_buf_operations, we can just check for a magic type.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 lib/ringbuffer/ring_buffer_splice.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/ringbuffer/ring_buffer_splice.c b/lib/ringbuffer/ring_buffer_splice.c
index 468641b..52179a7 100644
--- a/lib/ringbuffer/ring_buffer_splice.c
+++ b/lib/ringbuffer/ring_buffer_splice.c
@@ -43,7 +43,9 @@ static void lib_ring_buffer_pipe_buf_release(struct pipe_inode_info *pipe,
 }
 
 static const struct pipe_buf_operations ring_buffer_pipe_buf_ops = {
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(5,1,0))
 	.can_merge = 0,
+#endif
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0))
 	.map = generic_pipe_buf_map,
 	.unmap = generic_pipe_buf_unmap,
-- 
2.17.1
