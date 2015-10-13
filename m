From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] Fix: handle EINTR return value for
	bt_posix_fallocate
Date: Tue, 13 Oct 2015 16:04:23 -0400
Message-ID: <1444766663-10751-1-git-send-email-mathieu.desnoyers__699.977359227155$1444766733$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Zm5oK-0007ew-4G
 for lttng-dev@lists.lttng.org; Tue, 13 Oct 2015 16:04:37 -0400
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 formats/ctf/ctf.c             | 9 +++++----
 formats/ctf/ir/event-fields.c | 8 ++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 8236b6e..757fa85 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -861,7 +861,6 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 	struct ctf_file_stream *file_stream =
 		container_of(pos, struct ctf_file_stream, pos);
 	int ret;
-	off_t off;
 	struct packet_index *packet_index, *prev_index;
 
 	switch (whence) {
@@ -905,9 +904,11 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 		}
 		pos->content_size = -1U;	/* Unknown at this point */
 		pos->packet_size = WRITE_PACKET_LEN;
-		off = bt_posix_fallocate(pos->fd, pos->mmap_offset,
-				      pos->packet_size / CHAR_BIT);
-		assert(off == 0);
+		do {
+			ret = bt_posix_fallocate(pos->fd, pos->mmap_offset,
+					      pos->packet_size / CHAR_BIT);
+		} while (ret == EINTR);
+		assert(ret == 0);
 		pos->offset = 0;
 	} else {
 	read_next_packet:
diff --git a/formats/ctf/ir/event-fields.c b/formats/ctf/ir/event-fields.c
index aa7475d..3358ff0 100644
--- a/formats/ctf/ir/event-fields.c
+++ b/formats/ctf/ir/event-fields.c
@@ -2171,9 +2171,13 @@ int increase_packet_size(struct ctf_stream_pos *pos)
 	}
 
 	pos->packet_size += PACKET_LEN_INCREMENT;
-	ret = bt_posix_fallocate(pos->fd, pos->mmap_offset,
-		pos->packet_size / CHAR_BIT);
+	do {
+		ret = bt_posix_fallocate(pos->fd, pos->mmap_offset,
+			pos->packet_size / CHAR_BIT);
+	} while (ret == EINTR);
 	if (ret) {
+		errno = EINTR;
+		ret = -1;
 		goto end;
 	}
 
-- 
2.1.4
