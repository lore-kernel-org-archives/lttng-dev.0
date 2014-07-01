From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Fix: get the stream_id when
	generating live beacons
Date: Tue,  1 Jul 2014 13:59:14 -0400
Message-ID: <1404237554-20385-1-git-send-email-jdesfossez__20332.6680035845$1404237610$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1X22L0-00073K-9S
 for lttng-dev@lists.lttng.org; Tue, 01 Jul 2014 13:59:32 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

When we send an empty index (beacon), we need to extract the stream_id
to avoid stalling the client on inactive streams on startup.

This patch should also be backported to 2.4.x.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/common/consumer-timer.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/src/common/consumer-timer.c b/src/common/consumer-timer.c
index c659bf6..d36e2bc 100644
--- a/src/common/consumer-timer.c
+++ b/src/common/consumer-timer.c
@@ -27,6 +27,7 @@
 #include <common/kernel-ctl/kernel-ctl.h>
 #include <common/kernel-consumer/kernel-consumer.h>
 #include <common/consumer-stream.h>
+#include <lttng/ust-ctl.h>
 
 #include "consumer-timer.h"
 #include "consumer-testpoint.h"
@@ -114,12 +115,14 @@ static void metadata_switch_timer(struct lttng_consumer_local_data *ctx,
 	}
 }
 
-static int send_empty_index(struct lttng_consumer_stream *stream, uint64_t ts)
+static int send_empty_index(struct lttng_consumer_stream *stream, uint64_t ts,
+		uint64_t stream_id)
 {
 	int ret;
 	struct ctf_packet_index index;
 
 	memset(&index, 0, sizeof(index));
+	index.stream_id = htobe64(stream_id);
 	index.timestamp_end = htobe64(ts);
 	ret = consumer_stream_write_index(stream, &index);
 	if (ret < 0) {
@@ -132,7 +135,7 @@ error:
 
 static int check_kernel_stream(struct lttng_consumer_stream *stream)
 {
-	uint64_t ts;
+	uint64_t ts, stream_id;
 	int ret;
 
 	/*
@@ -160,8 +163,13 @@ static int check_kernel_stream(struct lttng_consumer_stream *stream)
 			ret = -1;
 			goto error_unlock;
 		}
+		ret = kernctl_get_stream_id(stream->wait_fd, &stream_id);
+		if (ret < 0) {
+			PERROR("kernctl_get_stream_id");
+			goto error_unlock;
+		}
 		DBG("Stream %" PRIu64 " empty, sending beacon", stream->key);
-		ret = send_empty_index(stream, ts);
+		ret = send_empty_index(stream, ts, stream_id);
 		if (ret < 0) {
 			goto error_unlock;
 		}
@@ -175,7 +183,7 @@ error_unlock:
 
 static int check_ust_stream(struct lttng_consumer_stream *stream)
 {
-	uint64_t ts;
+	uint64_t ts, stream_id;
 	int ret;
 
 	assert(stream);
@@ -206,8 +214,13 @@ static int check_ust_stream(struct lttng_consumer_stream *stream)
 			ret = -1;
 			goto error_unlock;
 		}
+		ret = ustctl_get_stream_id(stream->ustream, &stream_id);
+		if (ret < 0) {
+			PERROR("ustctl_get_stream_id");
+			goto error_unlock;
+		}
 		DBG("Stream %" PRIu64 " empty, sending beacon", stream->key);
-		ret = send_empty_index(stream, ts);
+		ret = send_empty_index(stream, ts, stream_id);
 		if (ret < 0) {
 			goto error_unlock;
 		}
-- 
1.9.1
