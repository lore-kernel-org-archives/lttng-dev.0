From: Wade Farnsworth <wade_farnsworth@mentor.com>
Subject: [PATCH lttng-tools] Insert V4L2 instrumentation module
 on session start
Date: Fri, 28 Mar 2014 13:09:59 -0700
Message-ID: <5335D717.6080808__1022.4619917155$1396037567$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wade_farnsworth@mentor.com>) id 1WTd6t-0003Ht-UF
 for lttng-dev@lists.lttng.org; Fri, 28 Mar 2014 16:10:45 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
 by relay1.mentorg.com with esmtp
 id 1WTd6o-00039o-Fi from wade_farnsworth@mentor.com
 for lttng-dev@lists.lttng.org; Fri, 28 Mar 2014 13:10:34 -0700
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Requires V4L2 instrumentation patch for lttng-modules.

Signed-off-by: Wade Farnsworth <wade_farnsworth@mentor.com>
---
 src/bin/lttng-sessiond/modprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 92563b0..4ef4d4c 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -78,6 +78,7 @@ const struct kern_modules_param kern_modules_list[] = {
 	{ "lttng-probe-timer", 0 },
 	{ "lttng-probe-udp", 0 },
 	{ "lttng-probe-vmscan", 0 },
+	{ "lttng-probe-v4l2", 0 },
 	{ "lttng-probe-workqueue", 0 },
 	{ "lttng-probe-writeback", 0 },
 };
-- 
1.9.0
