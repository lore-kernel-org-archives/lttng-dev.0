From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: Live tracing does not honor
	live timer after first tracefile with tracefile rotation
Date: Fri, 21 Nov 2014 18:31:39 +0100
Message-ID: <1416591099-1920-1-git-send-email-mathieu.desnoyers__2909.20021147958$1416591156$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Xrs3i-000813-Hv
 for lttng-dev@lists.lttng.org; Fri, 21 Nov 2014 12:31:52 -0500
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

When we pass to the 2nd sub-file (or following sub-files) of a stream in
relayd, the live timer has no visible effect from a live reader
perspective, and then everything is flushed when we reach the following
sub-file.

This is caused by the reset of stream->total_index_received after each
tracefile rotation. It should keep on incrementing to match what is
expected by check in check_index_status():

  (rstream->total_index_received <= vstream->last_sent_index)

Fixes #863

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 00b8735..03ea108 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -2333,7 +2333,6 @@ int relay_process_data(struct relay_connection *conn)
 				stream->tracefile_size, stream->tracefile_count,
 				relayd_uid, relayd_gid, stream->fd,
 				&(stream->tracefile_count_current), &stream->fd);
-		stream->total_index_received = 0;
 		pthread_mutex_unlock(&stream->viewer_stream_rotation_lock);
 		if (ret < 0) {
 			ERR("Rotating stream output file");
-- 
2.1.1
