From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE stable-1.2 PATCH] Hide the packet_seq_num
	field
Date: Mon,  3 Aug 2015 11:35:38 -0400
Message-ID: <1438616138-29252-1-git-send-email-jdesfossez__9838.76136965609$1438616220$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZMHmK-0000Jf-5P
 for lttng-dev@lists.lttng.org; Mon, 03 Aug 2015 11:35:54 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com, jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

The packet_seq_num is a new field in LTTng 2.8 that should be hidden
from the ctf-text output as it is not really relevant for the users of
the text output.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf-text/ctf-text.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
index 9d5123a..2ba0823 100644
--- a/formats/ctf-text/ctf-text.c
+++ b/formats/ctf-text/ctf-text.c
@@ -115,7 +115,8 @@ static GQuark Q_STREAM_PACKET_CONTEXT_TIMESTAMP_BEGIN,
 	Q_STREAM_PACKET_CONTEXT_TIMESTAMP_END,
 	Q_STREAM_PACKET_CONTEXT_EVENTS_DISCARDED,
 	Q_STREAM_PACKET_CONTEXT_CONTENT_SIZE,
-	Q_STREAM_PACKET_CONTEXT_PACKET_SIZE;
+	Q_STREAM_PACKET_CONTEXT_PACKET_SIZE,
+	Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM;
 
 static
 void __attribute__((constructor)) init_quarks(void)
@@ -125,6 +126,7 @@ void __attribute__((constructor)) init_quarks(void)
 	Q_STREAM_PACKET_CONTEXT_EVENTS_DISCARDED = g_quark_from_static_string("stream.packet.context.events_discarded");
 	Q_STREAM_PACKET_CONTEXT_CONTENT_SIZE = g_quark_from_static_string("stream.packet.context.content_size");
 	Q_STREAM_PACKET_CONTEXT_PACKET_SIZE = g_quark_from_static_string("stream.packet.context.packet_size");
+	Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM = g_quark_from_static_string("stream.packet.context.packet_seq_num");
 }
 
 static
@@ -152,6 +154,8 @@ int print_field(struct bt_definition *definition)
 		return 0;
 	if (definition->path == Q_STREAM_PACKET_CONTEXT_PACKET_SIZE)
 		return 0;
+	if (definition->path == Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM)
+		return 0;
 
 	return 1;
 }
-- 
1.9.1
