From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH babeltrace] Fix: Check return value of
	fpathconf
Date: Fri,  4 Dec 2015 16:55:51 -0500
Message-ID: <1449266151-9372-1-git-send-email-mjeanson__3554.24735830656$1449266213$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1a4yKh-00045E-GX
 for lttng-dev@lists.lttng.org; Fri, 04 Dec 2015 16:56:06 -0500
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

Current glibc has a bug in fpathconf(fd, _PC_NAME_MAX) where it will
fail with a 32bit userland on a 64bit kernel and where the filesystem
has a large block count, see glibc bug #18675.

In any case, we should check this return value because on a failure we
we don't allocate enough memory for dirent and then overflow on the
readdir_r call.

This patch is an RFC, I'm not sure what is the best way to handle the
failure, should we instead fallback on using the global "NAME_MAX"?

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 formats/ctf/ctf.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index a617497..bc1aa93 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -2113,6 +2113,7 @@ int ctf_open_trace_read(struct ctf_trace *td,
 	struct dirent *dirent;
 	struct dirent *diriter;
 	size_t dirent_len;
+	int pc_name_max;
 	char *ext;
 
 	td->flags = flags;
@@ -2162,8 +2163,15 @@ int ctf_open_trace_read(struct ctf_trace *td,
 	 * the stream array.
 	 */
 
-	dirent_len = offsetof(struct dirent, d_name) +
-			fpathconf(td->dirfd, _PC_NAME_MAX) + 1;
+	pc_name_max = fpathconf(td->dirfd, _PC_NAME_MAX);
+	if (pc_name_max) {
+		perror("Error on fpathconf");
+		fprintf(stderr, "[error] Failed to get _PC_NAME_MAX for path \"%s\".\n", path);
+		ret = -1;
+		goto error_metadata;
+	}
+
+	dirent_len = offsetof(struct dirent, d_name) + pc_name_max + 1;
 
 	dirent = malloc(dirent_len);
 
-- 
1.9.1
