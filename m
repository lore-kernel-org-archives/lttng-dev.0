From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace] Fix: allow empty CTF files
Date: Sun,  4 Jan 2015 21:23:09 -0500
Message-ID: <1420424589-14868-1-git-send-email-mathieu.desnoyers__38133.4283425987$1420424658$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y7xKI-0007wD-0M
 for lttng-dev@lists.lttng.org; Sun, 04 Jan 2015 21:23:30 -0500
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

There are expected situtations in which CTF producers (like LTTng) can
generate empty CTF trace files. The current babeltrace behavior is to
trigger an error when an empty file is encountered. Change this to allow
reading the rest of the trace anyway.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 formats/ctf/ctf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 58b5488..40da01d 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -1964,6 +1964,11 @@ int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
 		ret = 0;
 		goto fd_is_dir_ok;
 	}
+	if (!statbuf.st_size) {
+		/** Skip empty files. */
+		ret = 0;
+		goto fd_is_empty_file;
+	}
 
 	file_stream = g_new0(struct ctf_file_stream, 1);
 	file_stream->pos.last_offset = LAST_OFFSET_POISON;
@@ -1998,6 +2003,7 @@ int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
 	index_name = malloc((strlen(path) + sizeof(INDEX_PATH)) * sizeof(char));
 	if (!index_name) {
 		fprintf(stderr, "[error] Cannot allocate index filename\n");
+		ret = -ENOMEM;
 		goto error_def;
 	}
 	snprintf(index_name, strlen(path) + sizeof(INDEX_PATH),
@@ -2056,6 +2062,7 @@ error_def:
 		fprintf(stderr, "Error on ctf_fini_pos\n");
 	}
 	g_free(file_stream);
+fd_is_empty_file:
 fd_is_dir_ok:
 fstat_error:
 	closeret = close(fd);
-- 
2.1.1
