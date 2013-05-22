From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 23/23] Open files as binary under
	Windows
Date: Wed, 22 May 2013 08:08:31 +0000
Message-ID: <009B25148989C6458484484699278506E538301F__29152.6229623289$1369210147$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf46B-0006fP-9n
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:08:39 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>, =?iso-8859-1?Q?J=E9r=E9mie_Galarneau_=28jeremie=2Egalarneau=40efficios=2E?= =?iso-8859-1?Q?com=29?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

When opening files with open() or fdopen(), use the "b" flag to
avoid CR/LF transformations under Windows.
---
 formats/ctf/ctf.c                     | 2 +-
 include/babeltrace/compat/memstream.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index ffa5387..5a7779f 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -1105,7 +1105,7 @@ int ctf_open_trace_metadata_read(struct ctf_trace *td,
 			goto end_free;
 		}
 
-		fp = fdopen(metadata_stream->pos.fd, "r");
+		fp = fdopen(metadata_stream->pos.fd, "rb");
 		if (!fp) {
 			fprintf(stderr, "[error] Unable to open metadata stream.\n");
 			perror("Metadata stream open");
diff --git a/include/babeltrace/compat/memstream.h b/include/babeltrace/compat/memstream.h
index fb24ad9..cc5328d 100644
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
@@ -149,7 +149,7 @@ FILE *babeltrace_open_memstream(char **ptr, size_t *sizeloc)
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
