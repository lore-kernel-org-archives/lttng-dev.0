From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Load x86-exceptions lttng-modules
	probe
Date: Fri, 23 Oct 2015 19:36:04 -0400
Message-ID: <1445643364-12175-1-git-send-email-mathieu.desnoyers__24754.9208034345$1445643424$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Zplsc-0005hn-7A
 for lttng-dev@lists.lttng.org; Fri, 23 Oct 2015 19:36:15 -0400
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
 src/bin/lttng-sessiond/modprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 8603d04..2c527dc 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -92,6 +92,7 @@ struct kern_modules_param kern_modules_probes_default[] = {
 	{ "lttng-probe-workqueue" },
 	{ "lttng-probe-writeback" },
 	{ "lttng-probe-x86-irq-vectors" },
+	{ "lttng-probe-x86-exceptions" },
 };
 
 /* dynamic probe modules list */
-- 
2.1.4
