From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: lttng-crash: fd leak
Date: Thu,  3 Sep 2015 17:52:06 -0400
Message-ID: <1441317127-10878-1-git-send-email-jonathan.rajotte-julien__6216.80744593522$1441317216$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZXcQs-0006MR-Ta
 for lttng-dev@lists.lttng.org; Thu, 03 Sep 2015 17:52:39 -0400
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

At the same time make sure to have on one exit-point.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-crash/lttng-crash.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng-crash/lttng-crash.c b/src/bin/lttng-crash/lttng-crash.c
index 4f1efe9..8e57034 100644
--- a/src/bin/lttng-crash/lttng-crash.c
+++ b/src/bin/lttng-crash/lttng-crash.c
@@ -103,7 +103,7 @@ enum rb_modes {
 
 struct crash_abi_unknown {
 	uint8_t magic[RB_CRASH_DUMP_ABI_MAGIC_LEN];
-	uint64_t mmap_length;	/* Overall lenght of crash record */
+	uint64_t mmap_length;	/* Overall length of crash record */
 	uint16_t endian;	/*
 				 * { 0x12, 0x34 }: big endian
 				 * { 0x34, 0x12 }: little endian
@@ -326,26 +326,30 @@ int copy_file(const char *file_dest, const char *file_src)
 	int fd_src, fd_dest;
 	ssize_t readlen, writelen;
 	char buf[COPY_BUFLEN];
+	int ret;
 
 	DBG("Copy metadata file '%s' into '%s'", file_src, file_dest);
 
 	fd_src = open(file_src, O_RDONLY);
 	if (fd_src < 0) {
 		PERROR("Error opening %s for reading", file_src);
-		return fd_src;
+		ret = fd_src;
+		goto error;
 	}
 	fd_dest = open(file_dest, O_RDWR | O_CREAT | O_EXCL,
 			S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
 	if (fd_dest < 0) {
 		PERROR("Error opening %s for writing", file_dest);
-		return fd_dest;
+		ret = fd_dest;
+		goto error;
 	}
 
 	for (;;) {
 		readlen = lttng_read(fd_src, buf, COPY_BUFLEN);
 		if (readlen < 0) {
 			PERROR("Error reading input file");
-			return -1;
+			ret = -1;
+			goto error;
 		}
 		if (!readlen) {
 			break;
@@ -353,10 +357,26 @@ int copy_file(const char *file_dest, const char *file_src)
 		writelen = lttng_write(fd_dest, buf, readlen);
 		if (writelen < readlen) {
 			PERROR("Error writing to output file");
-			return -1;
+			ret = -1;
+			goto error;
 		}
 	}
+
+	ret = close(fd_src);
+	if (ret < 0) {
+		PERROR("Error closing %s", file_src);
+		goto error;
+	}
+
+	ret = close(fd_dest);
+	if (ret < 0) {
+		PERROR("Error closing %s", file_dest);
+		goto error;
+	}
+
 	return 0;
+error:
+	return ret;
 }
 
 static
-- 
2.1.4
