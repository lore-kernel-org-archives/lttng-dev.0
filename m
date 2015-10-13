From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] Fix: babeltrace-log packet seek
Date: Tue, 13 Oct 2015 12:06:26 -0400
Message-ID: <1444752386-17139-1-git-send-email-mathieu.desnoyers__49793.838899541$1444752463$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Zm264-0006NK-Hk
 for lttng-dev@lists.lttng.org; Tue, 13 Oct 2015 12:06:46 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, mjeanson@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Packet seek has been removed from ctf helper headers somewhere around
Babeltrace 1.1. Since then, babeltrace-log is broken when it needs to
output a file larger than the fixed-sized packet (WRITE_PACKET_LEN
currently defined as (getpagesize() * 8 * CHAR_BIT).

Correctly handle the non-zero return values on ctf_align_pos() and
ctf_move_pos() on the dummy position copy, which are used to validate
whether we need to switch packet or not. Also add an initial packet seek
at the beginning of the file.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 converter/babeltrace-log.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
index 5a8b26a..c6f751e 100644
--- a/converter/babeltrace-log.c
+++ b/converter/babeltrace-log.c
@@ -276,13 +276,15 @@ void trace_string(char *line, struct ctf_stream_pos *pos, size_t len)
 	printf_debug("read: %s\n", line);
 
 	for (;;) {
+		int packet_filled = 0;
+
 		ctf_dummy_pos(pos, &dummy);
 		write_event_header(&dummy, line, &tline, len, &tlen, &ts);
 		if (!ctf_align_pos(&dummy, sizeof(uint8_t) * CHAR_BIT))
-			goto error;
+			packet_filled = 1;
 		if (!ctf_move_pos(&dummy, tlen * CHAR_BIT))
-			goto error;
-		if (ctf_pos_packet(&dummy)) {
+			packet_filled = 1;
+		if (packet_filled || ctf_pos_packet(&dummy)) {
 			ctf_pos_pad_packet(pos);
 			write_packet_header(pos, s_uuid);
 			write_packet_context(pos);
@@ -325,6 +327,7 @@ void trace_text(FILE *input, int output)
 		fprintf(stderr, "Error in ctf_init_pos\n");
 		return;
 	}
+	ctf_packet_seek(&pos.parent, 0, SEEK_CUR);
 	write_packet_header(&pos, s_uuid);
 	write_packet_context(&pos);
 	for (;;) {
-- 
2.1.4
