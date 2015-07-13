From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 4/9] Metadata for instance_id and
	packet_seq_num
Date: Mon, 13 Jul 2015 11:28:04 -0400
Message-ID: <1436801289-17554-5-git-send-email-jdesfossez__1381.13218495182$1436801393$gmane$org@efficios.com>
References: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfeb-0008PJ-Ub
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:28:26 -0400
In-Reply-To: <1436801289-17554-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

The UST tracer now stores a stream_instance_id in each packet to allow
the viewers to match streams split in multiple trace files.

Also, a sequence_number is stored in each packet so it is possible to
compute the number of lost packets in overwrite mode.

This is a locked-step with the corresponding lttng-ust commits.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c      |  3 ++-
 src/bin/lttng-sessiond/ust-metadata.c | 51 ++++++++++++++++++++++++-----------
 src/bin/lttng-sessiond/ust-registry.h |  3 ++-
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 08b6a76..564de69 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -4829,7 +4829,8 @@ static int reply_ust_register_channel(int sock, int sobjd, int cobjd,
 
 	/* Append to metadata */
 	if (!chan_reg->metadata_dumped) {
-		ret_code = ust_metadata_channel_statedump(registry, chan_reg);
+		ret_code = ust_metadata_channel_statedump(registry, chan_reg,
+				&ua_chan->attr);
 		if (ret_code) {
 			ERR("Error appending channel metadata (errno = %d)", ret_code);
 			goto reply;
diff --git a/src/bin/lttng-sessiond/ust-metadata.c b/src/bin/lttng-sessiond/ust-metadata.c
index ea59788..8589136 100644
--- a/src/bin/lttng-sessiond/ust-metadata.c
+++ b/src/bin/lttng-sessiond/ust-metadata.c
@@ -29,6 +29,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include <common/common.h>
+#include <common/utils.h>
 
 #include "ust-registry.h"
 #include "ust-clock.h"
@@ -46,6 +47,10 @@ struct offset_sample {
 	uint64_t measure_delta;		/* lower is better */
 };
 
+static
+int _lttng_stream_packet_context_declare(struct ust_registry_session *session,
+		struct ustctl_consumer_channel_attr *attr);
+
 static inline
 int fls(unsigned int x)
 {
@@ -413,7 +418,8 @@ end:
  * Should be called with session registry mutex held.
  */
 int ust_metadata_channel_statedump(struct ust_registry_session *session,
-		struct ust_registry_channel *chan)
+		struct ust_registry_channel *chan,
+		struct ustctl_consumer_channel_attr *attr)
 {
 	int ret = 0;
 
@@ -427,8 +433,7 @@ int ust_metadata_channel_statedump(struct ust_registry_session *session,
 	ret = lttng_metadata_printf(session,
 		"stream {\n"
 		"	id = %u;\n"
-		"	event.header := %s;\n"
-		"	packet.context := struct packet_context;\n",
+		"	event.header := %s;\n",
 		chan->chan_id,
 		chan->header_type == USTCTL_CHANNEL_HEADER_COMPACT ?
 			"struct event_header_compact" :
@@ -436,6 +441,15 @@ int ust_metadata_channel_statedump(struct ust_registry_session *session,
 	if (ret)
 		goto end;
 
+	ret = lttng_metadata_printf(session,
+			"	packet.context := ");
+	if (ret)
+		goto end;
+
+	ret = _lttng_stream_packet_context_declare(session, attr);
+	if (ret)
+		goto end;
+
 	if (chan->ctx_fields) {
 		ret = lttng_metadata_printf(session,
 			"	event.context := struct {\n");
@@ -464,18 +478,26 @@ end:
 }
 
 static
-int _lttng_stream_packet_context_declare(struct ust_registry_session *session)
+int _lttng_stream_packet_context_declare(struct ust_registry_session *session,
+		struct ustctl_consumer_channel_attr *attr)
 {
+	unsigned int padding = utils_get_count_order_u64(attr->subbuf_size);
+	unsigned int field_size = 64;
+
 	return lttng_metadata_printf(session,
 		"struct packet_context {\n"
-		"	uint64_clock_monotonic_t timestamp_begin;\n"
-		"	uint64_clock_monotonic_t timestamp_end;\n"
-		"	uint64_t content_size;\n"
-		"	uint64_t packet_size;\n"
-		"	unsigned long events_discarded;\n"
-		"	uint32_t cpu_id;\n"
-		"};\n\n"
-		);
+		"		uint64_clock_monotonic_t timestamp_begin;\n"
+		"		uint64_clock_monotonic_t timestamp_end;\n"
+		"		uint64_t content_size;\n"
+		"		uint64_t packet_size;\n"
+		"		integer { size = %u; signed = false;"
+		" align = 1; } packet_seq_num_padding;\n"
+		"		integer { size = %u; signed = false;"
+		" align = 1; } packet_seq_num;\n"
+		"		unsigned long events_discarded;\n"
+		"		uint32_t cpu_id;\n"
+		"	};\n\n",
+		padding, field_size - padding);
 }
 
 /*
@@ -630,6 +652,7 @@ int ust_metadata_session_statedump(struct ust_registry_session *session,
 		"		uint32_t magic;\n"
 		"		uint8_t  uuid[16];\n"
 		"		uint32_t stream_id;\n"
+		"		uint64_t stream_instance_id;\n"
 		"	};\n"
 		"};\n\n",
 		session->uint8_t_alignment,
@@ -743,10 +766,6 @@ int ust_metadata_session_statedump(struct ust_registry_session *session,
 	if (ret)
 		goto end;
 
-	ret = _lttng_stream_packet_context_declare(session);
-	if (ret)
-		goto end;
-
 	ret = _lttng_event_header_declare(session);
 	if (ret)
 		goto end;
diff --git a/src/bin/lttng-sessiond/ust-registry.h b/src/bin/lttng-sessiond/ust-registry.h
index 77d4d91..0c6cf54 100644
--- a/src/bin/lttng-sessiond/ust-registry.h
+++ b/src/bin/lttng-sessiond/ust-registry.h
@@ -256,7 +256,8 @@ void ust_registry_destroy_event(struct ust_registry_channel *chan,
 int ust_metadata_session_statedump(struct ust_registry_session *session,
 		struct ust_app *app, uint32_t major, uint32_t minor);
 int ust_metadata_channel_statedump(struct ust_registry_session *session,
-		struct ust_registry_channel *chan);
+		struct ust_registry_channel *chan,
+		struct ustctl_consumer_channel_attr *attr);
 int ust_metadata_event_statedump(struct ust_registry_session *session,
 		struct ust_registry_channel *chan,
 		struct ust_registry_event *event);
-- 
1.9.1
