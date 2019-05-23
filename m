From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools stable-2.9/2.10] Fix: initialize
 syscall table when kernel tracer is lazily initialized
Date: Thu, 23 May 2019 12:56:57 -0400
Message-ID: <20190523165657.19454-1-mathieu.desnoyers__45247.9677552887$1558630646$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 458wdt4Z6Zz11rZ
 for <lttng-dev@lists.lttng.org>; Thu, 23 May 2019 12:57:06 -0400 (EDT)
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

How to reproduce:

start lttng-sessiond while lttng-modules are not installed, then install
lttng-modules. Then issue "lttng list --syscall -k". It will show an
empty syscall list because the system call list has not been
initialized.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 577936a8..d559306c 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -2652,6 +2652,12 @@ static int init_kernel_tracer(void)
 	}
 
 	DBG("Kernel tracer fd %d", kernel_tracer_fd);
+
+	ret = syscall_init_table();
+	if (ret < 0) {
+		ERR("Unable to populate syscall table. Syscall tracing won't "
+			"work for this session daemon.");
+	}
 	return 0;
 
 error_version:
@@ -5771,14 +5777,6 @@ int main(int argc, char **argv)
 		/* Setup kernel tracer */
 		if (!config.no_kernel) {
 			init_kernel_tracer();
-			if (kernel_tracer_fd >= 0) {
-				ret = syscall_init_table();
-				if (ret < 0) {
-					ERR("Unable to populate syscall table. "
-						"Syscall tracing won't work "
-						"for this session daemon.");
-				}
-			}
 		}
 
 		/* Set ulimit for open files */
-- 
2.11.0
