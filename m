From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH] Fix: safety checks for opening mmap
	traces
Date: Fri, 10 Aug 2012 17:32:35 -0400
Message-ID: <1344634355-10923-1-git-send-email-jdesfossez__8228.23752319$1344634394$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1Szwp5-0000BN-NO
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 17:32:47 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

When adding a mmap trace in the context, we don't have any tracefile and
index, some safety checks were missing in the path handling and
timestamp manipulation.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/ctf.c |    9 +++++++++
 lib/context.c     |    6 ++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index f33fa33..69917f7 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -167,6 +167,9 @@ uint64_t ctf_timestamp_begin(struct trace_descriptor *descriptor,
 			if (!stream_pos->packet_real_index)
 				goto error;
 
+			if (stream_pos->packet_real_index->len <= 0)
+				continue;
+
 			if (type == BT_CLOCK_REAL) {
 				index = &g_array_index(stream_pos->packet_real_index,
 						struct packet_index,
@@ -225,6 +228,9 @@ uint64_t ctf_timestamp_end(struct trace_descriptor *descriptor,
 			if (!stream_pos->packet_real_index)
 				goto error;
 
+			if (stream_pos->packet_real_index->len <= 0)
+				continue;
+
 			if (type == BT_CLOCK_REAL) {
 				index = &g_array_index(stream_pos->packet_real_index,
 						struct packet_index,
@@ -1845,6 +1851,9 @@ int ctf_convert_index_timestamp(struct trace_descriptor *tdp)
 			stream_pos->packet_real_index = g_array_new(FALSE, TRUE,
 					sizeof(struct packet_index));
 
+			if (!stream_pos->packet_cycles_index)
+				continue;
+
 			for (k = 0; k < stream_pos->packet_cycles_index->len; k++) {
 				struct packet_index *index;
 				struct packet_index new_index;
diff --git a/lib/context.c b/lib/context.c
index 373944c..e2c1739 100644
--- a/lib/context.c
+++ b/lib/context.c
@@ -104,8 +104,10 @@ int bt_context_add_trace(struct bt_context *ctx, const char *path,
 	}
 	handle->format = fmt;
 	handle->td = td;
-	strncpy(handle->path, path, PATH_MAX);
-	handle->path[PATH_MAX - 1] = '\0';
+	if (path) {
+		strncpy(handle->path, path, PATH_MAX);
+		handle->path[PATH_MAX - 1] = '\0';
+	}
 
 	if (fmt->set_handle)
 		fmt->set_handle(td, handle);
-- 
1.7.10.4
