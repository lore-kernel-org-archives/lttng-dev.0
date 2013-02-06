From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-modules] Fix check in
	lttng_strlen_user_inatomic
Date: Wed,  6 Feb 2013 09:54:34 -0500
Message-ID: <1360162474-13940-1-git-send-email-simon.marchi__36676.1860125282$1360162528$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1U36OS-0005By-Ui
	for lttng-dev@lists.lttng.org; Wed, 06 Feb 2013 09:54:37 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

__copy_from_user_inatomic returns the number of bytes that could not be
copied, not an error code. This fixes the test accordingly.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 probes/lttng-probe-user.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/probes/lttng-probe-user.c b/probes/lttng-probe-user.c
index 94ecf2f..a2368b5 100644
--- a/probes/lttng-probe-user.c
+++ b/probes/lttng-probe-user.c
@@ -41,7 +41,7 @@ long lttng_strlen_user_inatomic(const char *addr)
 		ret = __copy_from_user_inatomic(&v,
 			(__force const char __user *)(addr),
 			sizeof(v));
-		if (unlikely(ret == -EFAULT))
+		if (unlikely(ret > 0))
 			break;
 		count++;
 		if (unlikely(!v))
-- 
1.7.1
