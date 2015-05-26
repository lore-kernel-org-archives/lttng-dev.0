From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: [PATCH lttng-modules] Fix: Update kmem event for
	Ubuntu's 3.16 kernel too
Date: Tue, 26 May 2015 16:12:00 -0400
Message-ID: <1432671120-15661-1-git-send-email-alexmonthy__13323.2068307281$1432671268$gmane$org@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1YxLDb-0007IE-PO
 for lttng-dev@lists.lttng.org; Tue, 26 May 2015 16:13:04 -0400
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

The upstream patch in question in commit 72906e1 was also
cherry-picked into Ubuntu's 3.16 kernel backport branch
(called lts-utopic).
The version check should also include this branch.

The other backport branch, lts-vivid, and all following ones
will be covered by the standard

  LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,2)

check, so should not require other workarounds.

References #889.

Signed-off-by: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
---
 instrumentation/events/lttng-module/kmem.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/kmem.h b/instrumentation/events/lttng-module/kmem.h
index 1d4eb62..6461788 100644
--- a/instrumentation/events/lttng-module/kmem.h
+++ b/instrumentation/events/lttng-module/kmem.h
@@ -203,7 +203,8 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(kmem_mm_page, mm_page_pcpu_drain,
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,2)	\
 	|| LTTNG_KERNEL_RANGE(3,14,36, 3,15,0)		\
 	|| LTTNG_DEBIAN_KERNEL_RANGE(3,16,7,9,0,0, 3,17,0,0,0,0)	\
-	|| LTTNG_UBUNTU_KERNEL_RANGE(3,13,0,50, 3,14,0,0))
+	|| LTTNG_UBUNTU_KERNEL_RANGE(3,13,0,50, 3,14,0,0)	\
+	|| LTTNG_UBUNTU_KERNEL_RANGE(3,16,0,38, 3,17,0,0))
 
 LTTNG_TRACEPOINT_EVENT_MAP(mm_page_alloc_extfrag,
 
-- 
2.1.4
