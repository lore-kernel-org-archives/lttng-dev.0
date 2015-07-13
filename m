From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [UST PATCH 1/3] Add stream instance id to the packet
	header
Date: Mon, 13 Jul 2015 11:12:07 -0400
Message-ID: <1436800329-15061-1-git-send-email-jdesfossez__15083.899224601$1436800384$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfP0-0008CP-Ph
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:12:19 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This new field allows the viewer to distinguish between trace files
belonging to the same packet stream (in LTTng: the same CPU in the same
channel).

This is a locked-step with the corresponding commit in lttng-tools.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 liblttng-ust/lttng-ring-buffer-client.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/liblttng-ust/lttng-ring-buffer-client.h b/liblttng-ust/lttng-ring-buffer-client.h
index c0ae0c8..41baab0 100644
--- a/liblttng-ust/lttng-ring-buffer-client.h
+++ b/liblttng-ust/lttng-ring-buffer-client.h
@@ -45,6 +45,7 @@ struct packet_header {
 					 */
 	uint8_t uuid[LTTNG_UST_UUID_LEN];
 	uint32_t stream_id;
+	uint64_t stream_instance_id;
 
 	struct {
 		/* Stream packet context */
@@ -342,6 +343,7 @@ static void client_buffer_begin(struct lttng_ust_lib_ring_buffer *buf, uint64_t
 	header->magic = CTF_MAGIC_NUMBER;
 	memcpy(header->uuid, lttng_chan->uuid, sizeof(lttng_chan->uuid));
 	header->stream_id = lttng_chan->id;
+	header->stream_instance_id = buf->backend.cpu;
 	header->ctx.timestamp_begin = tsc;
 	header->ctx.timestamp_end = 0;
 	header->ctx.content_size = ~0ULL; /* for debugging */
-- 
1.9.1
