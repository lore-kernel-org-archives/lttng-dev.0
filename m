From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Fix: close wait_fd on kernel tracing
Date: Thu, 23 May 2013 16:13:35 -0400
Message-ID: <1369340015-6895-1-git-send-email-jdesfossez__25019.5775334307$1369340066$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1UfbtV-0007vU-Ta
	for lttng-dev@lists.lttng.org; Thu, 23 May 2013 16:13:50 -0400
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

The wait_fd in the kernel consumer streams was not closed causing a leak
of FDs in the consumer and never triggering the teardown mechanism in
the kernel tracer.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/common/consumer.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 044a504..84865d3 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -463,6 +463,10 @@ void consumer_del_stream(struct lttng_consumer_stream *stream,
 				PERROR("munmap");
 			}
 		}
+		ret = close(stream->wait_fd);
+		if (ret) {
+			PERROR("close");
+		}
 		break;
 	case LTTNG_CONSUMER32_UST:
 	case LTTNG_CONSUMER64_UST:
-- 
1.7.10.4
