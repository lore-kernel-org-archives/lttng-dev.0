From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/3] Fix: relayd: make viewer
	streams consider metadata sent
Date: Thu,  3 Sep 2015 17:17:28 -0400
Message-ID: <1441315050-17271-1-git-send-email-mathieu.desnoyers__37906.3288135969$1441315274$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZXbt8-00065C-9a
 for lttng-dev@lists.lttng.org; Thu, 03 Sep 2015 17:17:53 -0400
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

The metadata stream does not use prev seq, and is therefore not sent to
viewers if we depend on prev seq. Use the metadata_received field
instead to achieve the same purpose: if a viewer try to attach to a
session that has not received metadata yet, it will get and error
(metadata stream cannot be found when attaching).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/live.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index 4586e9b..2d0b687 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -316,8 +316,14 @@ int make_viewer_streams(struct relay_session *session,
 			/*
 			 * Stream has no data, don't consider it yet.
 			 */
-			if (stream->prev_seq == -1ULL) {
-				goto next;
+			if (stream->is_metadata) {
+				if (!stream->metadata_received) {
+					goto next;
+				}
+			} else {
+				if (stream->prev_seq == -1ULL) {
+					goto next;
+				}
 			}
 			vstream = viewer_stream_get_by_id(stream->stream_handle);
 			if (!vstream) {
-- 
2.1.4
