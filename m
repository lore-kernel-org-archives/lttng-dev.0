From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace 1/3] Fix: out-of-bound memory access
Date: Tue,  9 Feb 2016 13:27:22 -0500
Message-ID: <1455042444-23148-1-git-send-email-mathieu.desnoyers__35512.2256828055$1455042542$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1aTD19-0007dn-SM
 for lttng-dev@lists.lttng.org; Tue, 09 Feb 2016 13:28:06 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

We need to check for end of stream before updating the current packet
index, else we access memory beyond the last stream packet index array
element. This fixes valgrind errors which appear at commit

480ef05 Support ctf index version 1.1

due to change of the element size, but actually caused by commit

2654fe9 Fix: events discarded timing inaccuracy

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 formats/ctf/ctf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index a617497..37ebdfc 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -951,6 +951,11 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 			assert(0);
 		}
 
+		if (pos->cur_index >= pos->packet_index->len) {
+			pos->offset = EOF;
+			return;
+		}
+
 		packet_index = &g_array_index(pos->packet_index,
 				struct packet_index, pos->cur_index);
 		if (pos->cur_index > 0) {
@@ -963,11 +968,6 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 		ctf_update_current_packet_index(&file_stream->parent,
 				prev_index, packet_index);
 
-		if (pos->cur_index >= pos->packet_index->len) {
-			pos->offset = EOF;
-			return;
-		}
-
 		/*
 		 * We need to check if we are in trace read or called
 		 * from packet indexing.  In this last case, the
-- 
2.1.4
