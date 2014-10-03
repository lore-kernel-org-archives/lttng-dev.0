From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: [lttng-modules PATCH] Fix compilation on Ubuntu 14.10
Date: Fri,  3 Oct 2014 15:58:02 -0400
Message-ID: <1412366282-32756-1-git-send-email-alexmonthy__30588.8846669861$1412366356$gmane$org@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1Xa8zQ-0004lW-Ft
 for lttng-dev@lists.lttng.org; Fri, 03 Oct 2014 15:58:14 -0400
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

Extend the range introduced in 2260bfd to also include Ubuntu's
3.16 kernel. The API-changing patch was also backported to that series.
This will also be required for Trusty users once the the Utopic
hardware-enablement stack, including that 3.16 kernel, comes in.

Refs #838. See comment #2 for the patch in question.

Signed-off-by: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
---
 lttng-statedump-impl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lttng-statedump-impl.c b/lttng-statedump-impl.c
index bab5d9f..e0d74f6 100644
--- a/lttng-statedump-impl.c
+++ b/lttng-statedump-impl.c
@@ -412,7 +412,8 @@ void lttng_statedump_process_ns(struct lttng_session *session,
 	 * for details.
 	 */
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0) || \
-		LTTNG_UBUNTU_KERNEL_RANGE(3,13,11,36, 3,14,0,0))
+		LTTNG_UBUNTU_KERNEL_RANGE(3,13,11,36, 3,14,0,0) || \
+		LTTNG_UBUNTU_KERNEL_RANGE(3,16,0,11, 3,17,0,0))
 	proxy = p->nsproxy;
 #else
 	rcu_read_lock();
@@ -430,7 +431,8 @@ void lttng_statedump_process_ns(struct lttng_session *session,
 			p, type, mode, submode, status, NULL);
 	}
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0) || \
-		LTTNG_UBUNTU_KERNEL_RANGE(3,13,11,36, 3,14,0,0))
+		LTTNG_UBUNTU_KERNEL_RANGE(3,13,11,36, 3,14,0,0) || \
+		LTTNG_UBUNTU_KERNEL_RANGE(3,16,0,11, 3,17,0,0))
 	/* (nothing) */
 #else
 	rcu_read_unlock();
-- 
2.1.0
