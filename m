From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 3/9] Fix: utils.sh: handle SIGPIPE
Date: Fri,  3 May 2019 09:55:41 -0400
Message-ID: <20190503135547.12968-4-mathieu.desnoyers__9070.52687123127$1556911375$gmane$org@efficios.com>
References: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44wYZ73xyqz1KYy
 for <lttng-dev@lists.lttng.org>; Fri,  3 May 2019 09:55:59 -0400 (EDT)
In-Reply-To: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

perl prove closes its child pipes before giving it a chance to execute
the signal trap handler. This means the child will not be able to
complete execution of the trap handler if that handler writes to stdout
or stderr.

Work-around this situation by redirecting stdin, stdout, and stderr
to /dev/null if a SIGPIPE is caught.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/utils/utils.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
index d273b278..b8ac88c1 100644
--- a/tests/utils/utils.sh
+++ b/tests/utils/utils.sh
@@ -68,9 +68,21 @@ function full_cleanup ()
 	trap - SIGTERM && kill -- -$$
 }
 
+function null_pipes ()
+{
+	exec 0>/dev/null
+	exec 1>/dev/null
+	exec 2>/dev/null
+}
 
 trap full_cleanup SIGINT SIGTERM
 
+# perl prove closes its child pipes before giving it a chance to run its
+# signal trap handlers. Redirect pipes to /dev/null if SIGPIPE is caught
+# to allow those trap handlers to proceed.
+
+trap null_pipes SIGPIPE
+
 function print_ok ()
 {
 	# Check if we are a terminal
-- 
2.11.0
