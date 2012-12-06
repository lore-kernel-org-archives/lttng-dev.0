From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH babeltrace] Fix erroneous warning/error messages
Date: Thu,  6 Dec 2012 11:14:04 -0500
Message-ID: <1354810444-21670-1-git-send-email-simon.marchi__18187.1439134286$1354810558$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1Tge5V-00006K-DL
	for lttng-dev@lists.lttng.org; Thu, 06 Dec 2012 11:14:13 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

This led to user confusion.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 lib/context.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/context.c b/lib/context.c
index 9c11598..5516e49 100644
--- a/lib/context.c
+++ b/lib/context.c
@@ -90,16 +90,16 @@ int bt_context_add_trace(struct bt_context *ctx, const char *path,
 	if (path) {
 		td = fmt->open_trace(path, O_RDONLY, packet_seek, NULL);
 		if (!td) {
-			fprintf(stderr, "[warning] [Context] Cannot open_trace of the format %s .\n\n",
-					path);
+			fprintf(stderr, "[warning] [Context] Cannot open_trace of format %s at path %s.\n\n",
+					format_name, path);
 			ret = -1;
 			goto end;
 		}
 	} else {
 		td = fmt->open_mmap_trace(stream_list, packet_seek, metadata);
 		if (!td) {
-			fprintf(stderr, "[error] [Context] Cannot open_trace of the format %s .\n\n",
-					path);
+			fprintf(stderr, "[error] [Context] Cannot open_mmap_trace of format %s.\n\n",
+					format_name);
 			ret = -1;
 			goto end;
 		}
-- 
1.7.10.4
