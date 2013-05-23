From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Fix: increment channel refcount on
	add_stream
Date: Thu, 23 May 2013 17:43:51 -0400
Message-ID: <1369345431-15885-1-git-send-email-jdesfossez__31886.2257212915$1369345478$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1UfdIp-0000Bd-EE
	for lttng-dev@lists.lttng.org; Thu, 23 May 2013 17:44:03 -0400
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
 src/common/consumer.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index c9e4bae..bfb809a 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -663,6 +663,9 @@ static int add_stream(struct lttng_consumer_stream *stream,
 		uatomic_inc(&relayd->refcount);
 	}
 
+	/* Update channel refcount once added without error(s). */
+	uatomic_inc(&stream->chan->refcount);
+
 	/*
 	 * When nb_init_stream_left reaches 0, we don't need to trigger any action
 	 * in terms of destroying the associated channel, because the action that
-- 
1.7.10.4
