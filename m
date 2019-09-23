From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: lttng-crash: detect truncated
 files
Date: Mon, 23 Sep 2019 14:31:33 -0400
Message-ID: <20190923183133.18786-1-mathieu.desnoyers__12109.9792116851$1569263523$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46cXwG2Bvbz1PPg
 for <lttng-dev@lists.lttng.org>; Mon, 23 Sep 2019 14:31:42 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Detect truncated files which size is smaller than the ring buffer
header.

This can be caused by a situation where sessiond is killed with SIGKILL
while doing a metadata regenerate command.

Without this fix, lttng-crash is killed with a "Bus error" when
encountering a truncated file.

Fixes: #1166
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-crash/lttng-crash.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-crash/lttng-crash.c b/src/bin/lttng-crash/lttng-crash.c
index 298ed71a..47358df9 100644
--- a/src/bin/lttng-crash/lttng-crash.c
+++ b/src/bin/lttng-crash/lttng-crash.c
@@ -498,7 +498,8 @@ int check_magic(const uint8_t *magic)
 }
 
 static
-int get_crash_layout(struct lttng_crash_layout *layout, int fd)
+int get_crash_layout(struct lttng_crash_layout *layout, int fd,
+		const char *input_file)
 {
 	char *map;
 	int ret = 0, unmapret;
@@ -509,7 +510,17 @@ int get_crash_layout(struct lttng_crash_layout *layout, int fd)
 	const struct crash_abi_unknown *abi;
 	uint16_t endian;
 	enum lttng_crash_type layout_type;
+	struct stat stat;
 
+	ret = fstat(fd, &stat);
+	if (ret < 0) {
+		PERROR("fstat");
+		return -1;
+	}
+	if (stat.st_size < RB_CRASH_DUMP_ABI_LEN) {
+		ERR("File: '%s' truncated", input_file);
+		return -1;
+	}
 	map = mmap(NULL, RB_CRASH_DUMP_ABI_LEN, PROT_READ, MAP_PRIVATE,
 		fd, 0);
 	if (map == MAP_FAILED) {
@@ -838,7 +849,7 @@ int extract_file(int output_dir_fd, const char *output_file,
 	}
 
 	/* Query the crash ABI layout */
-	ret = get_crash_layout(&layout, fd_src);
+	ret = get_crash_layout(&layout, fd_src, input_file);
 	if (ret) {
 		goto close_src;
 	}
-- 
2.11.0
