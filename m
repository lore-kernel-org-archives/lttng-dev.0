From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: memstream compat layer requires
	use of babeltrace_close_memstream
Date: Thu, 15 Oct 2015 12:08:48 -0400
Message-ID: <1444925328-16174-1-git-send-email-mjeanson__39863.7152313769$1444925407$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1Zml5Z-0004bx-MS
 for lttng-dev@lists.lttng.org; Thu, 15 Oct 2015 12:09:12 -0400
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

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

In compatibility mode, the babeltrace compat layer around memstream
copies the file content into the buffer only at close.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 formats/lttng-live/lttng-live-comm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/formats/lttng-live/lttng-live-comm.c b/formats/lttng-live/lttng-live-comm.c
index 91e344c..6422e65 100644
--- a/formats/lttng-live/lttng-live-comm.c
+++ b/formats/lttng-live/lttng-live-comm.c
@@ -932,8 +932,9 @@ int get_new_metadata(struct lttng_live_ctx *ctx,
 		}
 	} while (ret > 0 || !len_read);
 
-	if (fclose(metadata_stream->metadata_fp_write))
-		perror("fclose");
+	if (babeltrace_close_memstream(metadata_buf, &size,
+			metadata_stream->metadata_fp_write))
+		perror("babeltrace_close_memstream");
 	metadata_stream->metadata_fp_write = NULL;
 
 error:
-- 
1.9.1
