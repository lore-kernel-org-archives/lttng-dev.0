From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 28/28] Open files as binary under
	Windows
Date: Thu, 2 May 2013 12:09:06 +0000
Message-ID: <009B25148989C6458484484699278506E537E9FD__9640.87648685581$1367496588$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXsK2-0002Ml-ST
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 08:09:15 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

---
 formats/ctf/ctf.c                     | 2 +-
 include/babeltrace/compat/memstream.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 7878555..c6c18a2 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -1085,7 +1085,7 @@ int ctf_open_trace_metadata_read(struct ctf_trace *td,
 			goto end_free;
 		}
 
-		fp = fdopen(metadata_stream->pos.fd, "r");
+		fp = fdopen(metadata_stream->pos.fd, "rb");
 		if (!fp) {
 			fprintf(stderr, "[error] Unable to open metadata stream.\n");
 			perror("Metadata stream open");
diff --git a/include/babeltrace/compat/memstream.h b/include/babeltrace/compat/memstream.h
index 44bc30c..be6d1a6 100644
--- a/include/babeltrace/compat/memstream.h
+++ b/include/babeltrace/compat/memstream.h
@@ -70,7 +70,7 @@ FILE *babeltrace_fmemopen(void *buf, size_t size, const char *mode)
 	/*
 	 * We need to write to the file.
 	 */
-	fp = fdopen(ret, "w+");
+	fp = fdopen(ret, "w+b");
 	if (!fp) {
 		goto error_unlink;
 	}
@@ -151,7 +151,7 @@ FILE *babeltrace_open_memstream(char **ptr, size_t *sizeloc)
 	if (ret < 0) {
 		return NULL;
 	}
-	fp = fdopen(ret, "w+");
+	fp = fdopen(ret, "w+b");
 	if (!fp) {
 		goto error_unlink;
 	}
-- 
1.8.1.msysgit.1
