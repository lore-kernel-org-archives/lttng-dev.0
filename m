From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH lttng-modules] Make upper bound of kernel
	version checking macro exclusive
Date: Tue, 27 Nov 2012 06:21:53 -0600
Message-ID: <1354018913-14211-1-git-send-email-andrew_gabbasov__40539.8945360959$1354018968$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1TdKB0-000716-Ss
	for lttng-dev@lists.lttng.org; Tue, 27 Nov 2012 07:22:10 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1TdKAu-0005Iy-PT from Andrew_Gabbasov@mentor.com
	for lttng-dev@lists.lttng.org; Tue, 27 Nov 2012 04:22:04 -0800
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

It's more usable to have the upper limit exclusive. It helps to avoid
hardcoding of stable branch highest version number, i.e. having a range
from 3.1.0 up to 3.2.0 (exclusively) gives us all 3.1.x versions.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 lttng-kernel-version.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lttng-kernel-version.h b/lttng-kernel-version.h
index 280a398..0eb56b3 100644
--- a/lttng-kernel-version.h
+++ b/lttng-kernel-version.h
@@ -27,10 +27,10 @@
 
 /*
  * This macro checks if the kernel version is between the two specified
- * versions (inclusive).
+ * versions (lower limit inclusive, upper limit exclusive).
  */
 #define LTTNG_KERNEL_RANGE(a_low, b_low, c_low, a_high, b_high, c_high) \
 	(LINUX_VERSION_CODE >= KERNEL_VERSION(a_low, b_low, c_low) && \
-	 LINUX_VERSION_CODE <= KERNEL_VERSION(a_high, b_high, c_high))
+	 LINUX_VERSION_CODE < KERNEL_VERSION(a_high, b_high, c_high))
 
 #endif /* _LTTNG_KERNEL_VERSION_H */
-- 
1.7.10.4
