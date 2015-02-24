From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH userspace-rcu 3/3] Configure: add check for used
	type
Date: Mon, 23 Feb 2015 22:29:24 -0500
Message-ID: <1424748564-28837-3-git-send-email-jonathan.rajotte-julien__23361.7541417063$1424748670$gmane$org@efficios.com>
References: <1424748564-28837-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YQ6C2-0002M2-LC
 for lttng-dev@lists.lttng.org; Mon, 23 Feb 2015 22:29:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 47E76340207
 for <lttng-dev@lists.lttng.org>; Tue, 24 Feb 2015 03:29:58 +0000 (UTC)
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
 configure.ac | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure.ac b/configure.ac
index d847da7..ed59d16 100644
--- a/configure.ac
+++ b/configure.ac
@@ -53,6 +53,10 @@ LT_INIT
 AC_C_INLINE
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
+AC_TYPE_INT32_T
+AC_TYPE_UINT32_T
+AC_TYPE_UINT64_T
+AC_TYPE_UINT8_T
 
 # Checks for library functions.
 AC_FUNC_MALLOC
-- 
1.9.1
