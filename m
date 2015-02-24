From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH userspace-rcu 2/3] Configure: add missing check
	of headers
Date: Mon, 23 Feb 2015 22:29:23 -0500
Message-ID: <1424748564-28837-2-git-send-email-jonathan.rajotte-julien__38841.4735826247$1424748692$gmane$org@efficios.com>
References: <1424748564-28837-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YQ6C1-0002M1-6j
 for lttng-dev@lists.lttng.org; Mon, 23 Feb 2015 22:29:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BC996340146
 for <lttng-dev@lists.lttng.org>; Tue, 24 Feb 2015 03:29:56 +0000 (UTC)
In-Reply-To: <1424748564-28837-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index 1ea744c..d847da7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -61,6 +61,9 @@ AC_CHECK_FUNCS(
 	[bzero gettimeofday munmap sched_getcpu strtoul sysconf gettid memeset strerror]
 )
 
+# Check for headers
+AC_CHECK_HEADERS([limits.h stddef.h sys/time.h])
+
 # Find arch type
 AS_CASE([$host_cpu],
 	[i386], [ARCHTYPE="x86" && SUBARCHTYPE="x86compat"],
-- 
1.9.1
