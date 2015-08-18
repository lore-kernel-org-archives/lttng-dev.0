From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/2] Fix: return error on ask_new_stream when
	should quit
Date: Tue, 18 Aug 2015 16:36:17 -0700
Message-ID: <1439940978-3953-1-git-send-email-mathieu.desnoyers__16076.3953732841$1439941043$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZRqQh-0001W8-2S
 for lttng-dev@lists.lttng.org; Tue, 18 Aug 2015 19:36:35 -0400
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

Otherwise, the caller will try to continue adding partially set streams
to the trace.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 formats/lttng-live/lttng-live-comm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/formats/lttng-live/lttng-live-comm.c b/formats/lttng-live/lttng-live-comm.c
index 47ea589..8fa90cf 100644
--- a/formats/lttng-live/lttng-live-comm.c
+++ b/formats/lttng-live/lttng-live-comm.c
@@ -560,10 +560,11 @@ restart:
 		id = g_array_index(ctx->session_ids, uint64_t, i);
 		ret = lttng_live_get_new_streams(ctx, id);
 		printf_verbose("Asking for new streams returns %d\n", ret);
+		if (lttng_live_should_quit()) {
+			ret = -1;
+			goto end;
+		}
 		if (ret < 0) {
-			if (lttng_live_should_quit()) {
-				goto end;
-			}
 			if (ret == -LTTNG_VIEWER_NEW_STREAMS_HUP) {
 				printf_verbose("Session %" PRIu64 " closed\n",
 						id);
@@ -1699,6 +1700,7 @@ int lttng_live_read(struct lttng_live_ctx *ctx)
 			}
 			ret = ask_new_streams(ctx);
 			if (ret < 0) {
+				ret = 0;
 				goto end_free;
 			}
 			if (!ctx->session->stream_count) {
-- 
2.1.4
