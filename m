From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH userspace-rcu 1/3] Configure: add missing check
	for funcs: memset, strerror
Date: Mon, 23 Feb 2015 22:29:22 -0500
Message-ID: <1424748564-28837-1-git-send-email-jonathan.rajotte-julien__32475.3418834463$1424748654$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YQ6Bz-0002M0-FB
 for lttng-dev@lists.lttng.org; Mon, 23 Feb 2015 22:29:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 058EF340145
 for <lttng-dev@lists.lttng.org>; Tue, 24 Feb 2015 03:29:55 +0000 (UTC)
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
 configure.ac | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 008336c..1ea744c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -57,7 +57,9 @@ AC_TYPE_SIZE_T
 # Checks for library functions.
 AC_FUNC_MALLOC
 AC_FUNC_MMAP
-AC_CHECK_FUNCS([bzero gettimeofday munmap sched_getcpu strtoul sysconf gettid])
+AC_CHECK_FUNCS(
+	[bzero gettimeofday munmap sched_getcpu strtoul sysconf gettid memeset strerror]
+)
 
 # Find arch type
 AS_CASE([$host_cpu],
-- 
1.9.1
