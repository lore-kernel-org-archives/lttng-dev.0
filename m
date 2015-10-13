From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: posix_fallocate() returns int >
	0 on errors
Date: Tue, 13 Oct 2015 12:15:08 -0400
Message-ID: <1444752908-15363-1-git-send-email-mjeanson__3058.02979642085$1444752974$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1Zm2EU-0006S3-1G
 for lttng-dev@lists.lttng.org; Tue, 13 Oct 2015 12:15:22 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 formats/ctf/ctf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 74fcb5b..19f61b5 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -906,7 +906,7 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 		pos->packet_size = WRITE_PACKET_LEN;
 		off = posix_fallocate(pos->fd, pos->mmap_offset,
 				      pos->packet_size / CHAR_BIT);
-		assert(off >= 0);
+		assert(off == 0);
 		pos->offset = 0;
 	} else {
 	read_next_packet:
-- 
1.9.1
