From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools stable-2.2] Fix: possible
	double-close on	stream out_fd
Date: Thu, 4 Jul 2013 18:37:35 -0400
Message-ID: <20130704223735.GA10902__6606.83422252095$1372977505$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uus9g-0006BF-Tb
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 18:37:37 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index fc86965..06801b9 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -582,11 +582,12 @@ int lttng_kconsumer_on_recv_stream(struct lttng_consumer_stream *stream)
 	return 0;
 
 error_close_fd:
-	{
+	if (stream->out_fd >= 0) {
 		int err;
 
 		err = close(stream->out_fd);
 		assert(!err);
+		stream->out_fd = -1;
 	}
 error:
 	return ret;

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
