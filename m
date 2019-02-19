From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/1] Fix: consumer snapshot: handle
 unsigned long overflow
Date: Tue, 19 Feb 2019 17:47:49 -0500
Message-ID: <20190219224749.8979-1-mathieu.desnoyers__35061.8201702432$1550616505$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 443wqn3JmJz122Z
 for <lttng-dev@lists.lttng.org>; Tue, 19 Feb 2019 17:48:05 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Comparing the consumed iterator and the produced position without
using a difference generates an empty snapshot when the iterator is
before unsigned long overflow and the produced position is after
unsigned long overflow.

This applies to both UST and kernel consumers.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/kernel-consumer/kernel-consumer.c | 2 +-
 src/common/ust-consumer/ust-consumer.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index 9bed7b55..1533e9ef 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -234,7 +234,7 @@ int lttng_kconsumer_snapshot_channel(struct lttng_consumer_channel *channel,
 				produced_pos, nb_packets_per_stream,
 				stream->max_sb_size);
 
-		while (consumed_pos < produced_pos) {
+		while ((long) (consumed_pos - produced_pos) < 0) {
 			ssize_t read_len;
 			unsigned long len, padded_len;
 
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 46f33005..94b761cb 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -1168,7 +1168,7 @@ static int snapshot_channel(struct lttng_consumer_channel *channel,
 				produced_pos, nb_packets_per_stream,
 				stream->max_sb_size);
 
-		while (consumed_pos < produced_pos) {
+		while ((long) (consumed_pos - produced_pos) < 0) {
 			ssize_t read_len;
 			unsigned long len, padded_len;
 
-- 
2.11.0
