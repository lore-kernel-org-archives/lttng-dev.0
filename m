From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH] Fix: mi: snapshot: missing error handling for
	session name
Date: Tue,  6 Jan 2015 10:59:47 -0500
Message-ID: <1420559987-29062-1-git-send-email-jonathan.rajotte-julien__2953.49865123189$1420560118$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1Y8WYR-0002sf-5Z
 for lttng-dev@lists.lttng.org; Tue, 06 Jan 2015 11:00:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 046BE340163
 for <lttng-dev@lists.lttng.org>; Tue,  6 Jan 2015 16:00:23 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/common/mi-lttng.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
index 752bcec..fed0985 100644
--- a/src/common/mi-lttng.c
+++ b/src/common/mi-lttng.c
@@ -1341,6 +1341,9 @@ int mi_lttng_snapshot_output_session_name(struct mi_writer *writer,
 	/* Snapshot output list for current session name */
 	ret = mi_lttng_writer_write_element_string(writer, config_element_name,
 			session_name);
+	if (ret) {
+		goto end;
+	}
 
 	/* Open element snapshots (sequence one snapshot) */
 	ret = mi_lttng_writer_open_element(writer, mi_lttng_element_snapshots);
-- 
1.9.1
