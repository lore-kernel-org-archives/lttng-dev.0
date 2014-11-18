From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: UST subbuffers silently
	dropped on moderate trace traffic
Date: Tue, 18 Nov 2014 17:33:23 +0100
Message-ID: <1416328403-28494-1-git-send-email-mathieu.desnoyers__48458.7521561936$1416328462$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Xqlih-0001BJ-Jd
 for lttng-dev@lists.lttng.org; Tue, 18 Nov 2014 11:33:42 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Well, it looks like we really screwed up on this one.

lttng-tools commit 02b3d1769d5f8a33e4109b1e681141c9295dfda6 introduced
an important regression for lttng-ust tracing in the consumer daemon:
after reading a sub-buffer, a check has been added to see whether there
are more sub-buffers available to read, and if it is the case, it
ensures the wakeup pipe will be awakened again.

The issue lies in the use of ustctl_put_next_subbuf() in this check.
This acts as if the sub-buffer has been read, when in reality it has not
been read. It therefore trashes the data contained by this sub-buffer.

This check should use ustctl_put_subbuf(), which does not move the
consumer position.

This is a severe bug, and the fix needs to be applied to stable-2.6,
stable-2.5, and stable-2.4.

Fixes #861

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/ust-consumer/ust-consumer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 52b6979..24ba387 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -1882,7 +1882,7 @@ static int notify_if_more_data(struct lttng_consumer_stream *stream,
 		goto end;
 	}
 
-	ret = ustctl_put_next_subbuf(ustream);
+	ret = ustctl_put_subbuf(ustream);
 	assert(!ret);
 
 	/* This stream still has data. Flag it and wake up the data thread. */
-- 
2.1.1
