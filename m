From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace] Fix: don't access missing ctf trace
	when getting metadata
Date: Mon, 17 Aug 2015 16:53:44 -0700
Message-ID: <1439855624-9915-1-git-send-email-mathieu.desnoyers__33672.0654312105$1439855705$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZRUE0-0002eH-6k
 for lttng-dev@lists.lttng.org; Mon, 17 Aug 2015 19:54:02 -0400
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

We can get metadata when still in the trace open functions, in which
case the ctf trace is now allocated nor available yet. This fixes a
segmentation fault in stress-test.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 formats/lttng-live/lttng-live-comm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/formats/lttng-live/lttng-live-comm.c b/formats/lttng-live/lttng-live-comm.c
index 9b409bc..57586a1 100644
--- a/formats/lttng-live/lttng-live-comm.c
+++ b/formats/lttng-live/lttng-live-comm.c
@@ -600,6 +600,11 @@ int append_metadata(struct lttng_live_ctx *ctx,
 	struct lttng_live_viewer_stream *metadata;
 	char *metadata_buf = NULL;
 
+	if (!viewer_stream->ctf_trace->handle) {
+		printf_verbose("append_metadata: trace handle not ready yet.\n");
+		return 0;
+	}
+
 	printf_verbose("get_next_index: new metadata needed\n");
 	ret = get_new_metadata(ctx, viewer_stream, &metadata_buf);
 	if (ret < 0) {
-- 
2.1.4
