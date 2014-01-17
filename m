From: Marc-Andre Laperle <marc-andre.laperle@ericsson.com>
Subject: [PATCH] Use uint32_t for
	lttng_viewer_stream.metadata_flag
Date: Fri, 17 Jan 2014 18:47:43 -0500
Message-ID: <1390002463-21184-1-git-send-email-marc-andre.laperle__20055.2053437152$1390002607$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <marc-andre.laperle@ericsson.com>) id 1W4J9z-0001nU-Gz
	for lttng-dev@lists.lttng.org; Fri, 17 Jan 2014 18:49:14 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This struct is meant to be sent over the network so members should be
of exact-width.

Signed-off-by: Marc-Andre Laperle <marc-andre.laperle@ericsson.com>
---
 src/bin/lttng-relayd/lttng-viewer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bin/lttng-relayd/lttng-viewer.h b/src/bin/lttng-relayd/lttng-viewer.h
index 1977a43..6330270 100644
--- a/src/bin/lttng-relayd/lttng-viewer.h
+++ b/src/bin/lttng-relayd/lttng-viewer.h
@@ -100,7 +100,7 @@ struct lttng_viewer_session {
 struct lttng_viewer_stream {
 	uint64_t id;
 	uint64_t ctf_trace_id;
-	int metadata_flag;
+	uint32_t metadata_flag;
 	char path_name[LTTNG_VIEWER_PATH_MAX];
 	char channel_name[LTTNG_VIEWER_NAME_MAX];
 } __attribute__((__packed__));
-- 
1.8.3.2
