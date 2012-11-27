From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH lttng-modules] Update using of kernel version
	checking macro to new range
Date: Tue, 27 Nov 2012 06:22:26 -0600
Message-ID: <1354018946-14252-1-git-send-email-andrew_gabbasov__39765.2026302696$1354018995$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1TdKBT-00071w-J4
	for lttng-dev@lists.lttng.org; Tue, 27 Nov 2012 07:22:39 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1TdKBO-0005Kj-3e from Andrew_Gabbasov@mentor.com
	for lttng-dev@lists.lttng.org; Tue, 27 Nov 2012 04:22:34 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 probes/lttng-probe-vmscan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/probes/lttng-probe-vmscan.c b/probes/lttng-probe-vmscan.c
index 0205c7e..4f5739c 100644
--- a/probes/lttng-probe-vmscan.c
+++ b/probes/lttng-probe-vmscan.c
@@ -39,8 +39,8 @@
 #define CREATE_TRACE_POINTS
 #define TRACE_INCLUDE_PATH ../instrumentation/events/lttng-module
 
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(3,0,38)) || \
-	LTTNG_KERNEL_RANGE(3,1,0, 3,1,10)
+#if ((LINUX_VERSION_CODE <= KERNEL_VERSION(3,0,38)) || \
+	LTTNG_KERNEL_RANGE(3,1,0, 3,2,0))
 typedef int isolate_mode_t;
 #endif
 
-- 
1.7.10.4
