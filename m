From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH] ctf-text: hide packet_seq_num and
	packet_seq_num_padding
Date: Mon, 13 Jul 2015 11:29:28 -0400
Message-ID: <1436801368-18117-1-git-send-email-jdesfossez__9581.38527717001$1436801856$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEffm-0008TO-3i
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:29:38 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

These fields are introduced in lttng-tools 2.7 and do not need to be
output to the babeltrace CLI users for now.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf-text/ctf-text.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
index 9d5123a..0c2c388 100644
--- a/formats/ctf-text/ctf-text.c
+++ b/formats/ctf-text/ctf-text.c
@@ -115,7 +115,9 @@ static GQuark Q_STREAM_PACKET_CONTEXT_TIMESTAMP_BEGIN,
 	Q_STREAM_PACKET_CONTEXT_TIMESTAMP_END,
 	Q_STREAM_PACKET_CONTEXT_EVENTS_DISCARDED,
 	Q_STREAM_PACKET_CONTEXT_CONTENT_SIZE,
-	Q_STREAM_PACKET_CONTEXT_PACKET_SIZE;
+	Q_STREAM_PACKET_CONTEXT_PACKET_SIZE,
+	Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM,
+	Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM_PADDING;
 
 static
 void __attribute__((constructor)) init_quarks(void)
@@ -125,6 +127,8 @@ void __attribute__((constructor)) init_quarks(void)
 	Q_STREAM_PACKET_CONTEXT_EVENTS_DISCARDED = g_quark_from_static_string("stream.packet.context.events_discarded");
 	Q_STREAM_PACKET_CONTEXT_CONTENT_SIZE = g_quark_from_static_string("stream.packet.context.content_size");
 	Q_STREAM_PACKET_CONTEXT_PACKET_SIZE = g_quark_from_static_string("stream.packet.context.packet_size");
+	Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM = g_quark_from_static_string("stream.packet.context.packet_seq_num");
+	Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM_PADDING = g_quark_from_static_string("stream.packet.context.packet_seq_num_padding");
 }
 
 static
@@ -152,6 +156,10 @@ int print_field(struct bt_definition *definition)
 		return 0;
 	if (definition->path == Q_STREAM_PACKET_CONTEXT_PACKET_SIZE)
 		return 0;
+	if (definition->path == Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM)
+		return 0;
+	if (definition->path == Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM_PADDING)
+		return 0;
 
 	return 1;
 }
-- 
1.9.1
