From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH] Fix: 32bit values index_major/minor used as
	64bit
Date: Tue, 18 Aug 2015 15:39:41 -0400
Message-ID: <1439926781-19841-1-git-send-email-mjeanson__12398.9192689352$1439926851$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZRmjq-0000Ks-Aa
 for lttng-dev@lists.lttng.org; Tue, 18 Aug 2015 15:40:05 -0400
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

This patch fixes compiler warnings on big endian architectures where
be64toh() is a nop and returns the original type.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 formats/ctf/ctf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 5436c2a..74fcb5b 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -1853,10 +1853,10 @@ int import_stream_packet_index(struct ctf_trace *td,
 		goto error;
 	}
 	if (be32toh(index_hdr.index_major) != CTF_INDEX_MAJOR) {
-		fprintf(stderr, "[error] Incompatible index file %" PRIu64
-				".%" PRIu64 ", supported %d.%d\n",
-				be64toh(index_hdr.index_major),
-				be64toh(index_hdr.index_minor), CTF_INDEX_MAJOR,
+		fprintf(stderr, "[error] Incompatible index file %" PRIu32
+				".%" PRIu32 ", supported %d.%d\n",
+				be32toh(index_hdr.index_major),
+				be32toh(index_hdr.index_minor), CTF_INDEX_MAJOR,
 				CTF_INDEX_MINOR);
 		ret = -1;
 		goto error;
-- 
1.9.1
