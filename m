From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [babeltrace RFC PATCH 2/2] Fix: use nscanf() to fix
	unbounded scanf()
Date: Thu, 20 Feb 2014 21:15:42 -0500
Message-ID: <1392948942-10604-2-git-send-email-mathieu.desnoyers__49005.2016721622$1392949223$gmane$org@efficios.com>
References: <1392948942-10604-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1WGfee-0000GU-D9
	for lttng-dev@lists.lttng.org; Thu, 20 Feb 2014 21:16:06 -0500
In-Reply-To: <1392948942-10604-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jeremie.galarneau@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 formats/ctf/Makefile.am                |    1 +
 formats/ctf/ctf.c                      |    5 ++++-
 formats/lttng-live/Makefile.am         |    3 ++-
 formats/lttng-live/lttng-live-plugin.c |   32 ++++++++++++++++++--------------
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/formats/ctf/Makefile.am b/formats/ctf/Makefile.am
index 5d8a297..c5d5216 100644
--- a/formats/ctf/Makefile.am
+++ b/formats/ctf/Makefile.am
@@ -17,6 +17,7 @@ libbabeltrace_ctf_la_LDFLAGS = \
 
 libbabeltrace_ctf_la_LIBADD = \
 	$(top_builddir)/lib/libbabeltrace.la \
+	$(top_builddir)/lib/libnscanf.la \
 	types/libctf-types.la \
 	metadata/libctf-parser.la \
 	metadata/libctf-ast.la \
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 2ff68bb..a4dc2c5 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -36,6 +36,7 @@
 #include <babeltrace/compat/uuid.h>
 #include <babeltrace/endian.h>
 #include <babeltrace/ctf/ctf-index.h>
+#include <babeltrace/nscanf.h>
 #include <inttypes.h>
 #include <stdio.h>
 #include <sys/mman.h>
@@ -1252,7 +1253,9 @@ int ctf_trace_metadata_read(struct ctf_trace *td, FILE *metadata_fp,
 			td->byte_order = BYTE_ORDER;
 
 			/* Check text-only metadata header and version */
-			nr_items = fscanf(fp, "/* CTF %10u.%10u", &major, &minor);
+			nr_items = fnscanf(fp, "/* CTF %u.%u",
+				NSCANF_LEN(NSCANF_LEN_u32, NSCANF_LEN_u32),
+				&major, &minor);
 			if (nr_items < 2)
 				fprintf(stderr, "[warning] Ill-shapen or missing \"/* CTF x.y\" header for text-only metadata.\n");
 			if (check_version(major, minor) < 0) {
diff --git a/formats/lttng-live/Makefile.am b/formats/lttng-live/Makefile.am
index c834699..727ddac 100644
--- a/formats/lttng-live/Makefile.am
+++ b/formats/lttng-live/Makefile.am
@@ -14,4 +14,5 @@ libbabeltrace_lttng_live_la_LDFLAGS = \
 	-Wl,--no-as-needed -version-info $(BABELTRACE_LIBRARY_VERSION)
 
 libbabeltrace_lttng_live_la_LIBADD = \
-	$(top_builddir)/lib/libbabeltrace.la
+	$(top_builddir)/lib/libbabeltrace.la \
+	$(top_builddir)/lib/libnscanf.la
diff --git a/formats/lttng-live/lttng-live-plugin.c b/formats/lttng-live/lttng-live-plugin.c
index b3c660c..d09efcf 100644
--- a/formats/lttng-live/lttng-live-plugin.c
+++ b/formats/lttng-live/lttng-live-plugin.c
@@ -26,6 +26,7 @@
 #include <babeltrace/ctf-text/types.h>
 #include <babeltrace/format.h>
 #include <babeltrace/babeltrace-internal.h>
+#include <babeltrace/nscanf.h>
 #include <inttypes.h>
 #include <sys/mman.h>
 #include <errno.h>
@@ -48,15 +49,9 @@ int parse_url(const char *path, struct lttng_live_ctx *ctx)
 	int ret = -1, proto, proto_offset = 0;
 	size_t path_len = strlen(path);
 
-	/*
-	 * Since sscanf API does not allow easily checking string length
-	 * against a size defined by a macro. Test it beforehand on the
-	 * input. We know the output is always <= than the input length.
-	 */
-	if (path_len > NAME_MAX) {
-		goto end;
-	}
-	ret = sscanf(path, "net%d://", &proto);
+	ret = snscanf(path, "net%d://",
+		NSCANF_LEN(NSCANF_LEN_s32),
+		&proto);
 	if (ret < 1) {
 		proto = 4;
 		/* net:// */
@@ -70,16 +65,21 @@ int parse_url(const char *path, struct lttng_live_ctx *ctx)
 	}
 	/* TODO : parse for IPv6 as well */
 	/* Parse the hostname or IP */
-	ret = sscanf(&path[proto_offset], "%[a-zA-Z.0-9%-]%s",
+	ret = snscanf(&path[proto_offset], "%[a-zA-Z.0-9%-]%s",
+		NSCANF_LEN(sizeof(ctx->relay_hostname), sizeof(remain[0])),
 		ctx->relay_hostname, remain[0]);
 	if (ret == 2) {
 		/* Optional port number */
 		switch (remain[0][0]) {
 		case ':':
-			ret = sscanf(remain[0], ":%d%s", &ctx->port, remain[1]);
+			ret = snscanf(remain[0], ":%d%s",
+				NSCANF_LEN(NSCANF_LEN_s32, sizeof(remain[1])),
+				&ctx->port, remain[1]);
 			/* Optional session ID with port number */
 			if (ret == 2) {
-				ret = sscanf(remain[1], "/%s", remain[2]);
+				ret = snscanf(remain[1], "/%s",
+					NSCANF_LEN(sizeof(remain[2])),
+					remain[2]);
 				/* Accept 0 or 1 (optional) */
 				if (ret < 0) {
 					goto end;
@@ -88,7 +88,9 @@ int parse_url(const char *path, struct lttng_live_ctx *ctx)
 			break;
 		case '/':
 			/* Optional session ID */
-			ret = sscanf(remain[0], "/%s", remain[2]);
+			ret = snscanf(remain[0], "/%s",
+				NSCANF_LEN(sizeof(remain[2])),
+				remain[2]);
 			/* Accept 0 or 1 (optional) */
 			if (ret < 0) {
 				goto end;
@@ -112,7 +114,9 @@ int parse_url(const char *path, struct lttng_live_ctx *ctx)
 		ret = 0;
 		goto end;
 	}
-	ret = sscanf(remain[2], "host/%[a-zA-Z.0-9%-]/%s",
+	ret = snscanf(remain[2], "host/%[a-zA-Z.0-9%-]/%s",
+			NSCANF_LEN(sizeof(ctx->traced_hostname),
+				sizeof(ctx->session_name)),
 			ctx->traced_hostname, ctx->session_name);
 	if (ret != 2) {
 		fprintf(stderr, "[error] Format : "
-- 
1.7.10.4
