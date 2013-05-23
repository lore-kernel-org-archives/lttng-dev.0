From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH v2] Fix: increment channel refcount
	on add_stream
Date: Thu, 23 May 2013 19:07:20 -0400
Message-ID: <1369350440-30563-1-git-send-email-jdesfossez__23642.8104727112$1369350486$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1Ufebd-0000vN-7P
	for lttng-dev@lists.lttng.org; Thu, 23 May 2013 19:07:33 -0400
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

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/common/kernel-consumer/kernel-consumer.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index f3a3a22..f47c498 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -255,6 +255,12 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		new_stream->chan = channel;
 		new_stream->wait_fd = fd;
 
+		/* Metadata chan refcount is increment in add_metadata_stream */
+		if (new_stream->chan->type != CONSUMER_CHANNEL_TYPE_METADATA) {
+			/* Update channel refcount */
+			uatomic_inc(&new_stream->chan->refcount);
+		}
+
 		/*
 		 * The buffer flush is done on the session daemon side for the kernel
 		 * so no need for the stream "hangup_flush_done" variable to be
-- 
1.7.10.4
