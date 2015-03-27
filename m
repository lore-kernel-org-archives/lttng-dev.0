From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: leak on error in lttng-crash
Date: Fri, 27 Mar 2015 15:52:00 -0400
Message-ID: <1427485920-31975-1-git-send-email-mathieu.desnoyers__24441.1941654564$1427485999$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1YbaId-000579-HY
 for lttng-dev@lists.lttng.org; Fri, 27 Mar 2015 15:52:12 -0400
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

Found by Coverity:
** CID 1291945:  Resource leaks  (RESOURCE_LEAK)
/src/bin/lttng-crash/lttng-crash.c: 769 in copy_crash_data()

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-crash/lttng-crash.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-crash/lttng-crash.c b/src/bin/lttng-crash/lttng-crash.c
index 793877d..4f1efe9 100644
--- a/src/bin/lttng-crash/lttng-crash.c
+++ b/src/bin/lttng-crash/lttng-crash.c
@@ -766,7 +766,8 @@ int copy_crash_data(const struct lttng_crash_layout *layout, int fd_dest,
 	readlen = lttng_read(fd_src, buf, src_file_len);
 	if (readlen < 0) {
 		PERROR("Error reading input file");
-		return -1;
+		ret = -1;
+		goto end;
 	}
 
 	prod_offset = crash_get_field(layout, buf, prod_offset);
-- 
2.1.4
