From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/4] Fix: print format type mismatch
Date: Tue,  2 Dec 2014 17:21:09 -0500
Message-ID: <1417558872-25339-1-git-send-email-mathieu.desnoyers__3322.15376333824$1417558927$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Xvvp0-0005MK-Io
 for lttng-dev@lists.lttng.org; Tue, 02 Dec 2014 17:21:27 -0500
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/syscall.c b/src/bin/lttng-sessiond/syscall.c
index c38f891..a6f0e1e 100644
--- a/src/bin/lttng-sessiond/syscall.c
+++ b/src/bin/lttng-sessiond/syscall.c
@@ -73,7 +73,7 @@ int syscall_init_table(void)
 	}
 
 	while (fscanf(fp,
-				"syscall { index = %lu; \
+				"syscall { index = %zu; \
 				name = %" XSTR(SYSCALL_NAME_LEN) "[^;]; \
 				bitness = %u; };\n",
 				&index, name, &bitness) == 3) {
-- 
2.1.1
