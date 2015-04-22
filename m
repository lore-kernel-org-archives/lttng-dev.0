From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Man page: reference lttng-crash
	under --shm-path option
Date: Wed, 22 Apr 2015 15:39:00 -0400
Message-ID: <1429731540-30119-1-git-send-email-jonathan.rajotte-julien__40287.9471345388$1429731638$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1Yl0UU-0001eN-57
 for lttng-dev@lists.lttng.org; Wed, 22 Apr 2015 15:39:30 -0400
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 doc/man/lttng.1 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
index e077b09..4b40a62 100644
--- a/doc/man/lttng.1
+++ b/doc/man/lttng.1
@@ -312,6 +312,8 @@ Path where shared memory holding buffers should be created. Useful
 when used with PRAMFS or other persistent memory filesystems to extract
 trace data in the event of a crash requiring a reboot.
 
+See the \fBlttng-crash(1)\fP utility for more information on crash recovery.
+
 .TP
 .BR "\-U, \-\-set-url=URL"
 Set URL for the consumer output destination. It is persistent for the
@@ -1116,6 +1118,7 @@ found.
 .BR lttng-ust(3),
 .BR lttng-sessiond(8),
 .BR lttng-relayd(8),
+.BR lttng-crash(1),
 
 .SH "BUGS"
 
-- 
2.1.4
