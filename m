From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: typo 'leat' -> 'least'
Date: Thu, 15 Nov 2018 12:16:36 -0500
Message-ID: <20181115171637.3839-1-mjeanson__693.245713091706$1542302112$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42wp1m2JHXzrFh
 for <lttng-dev@lists.lttng.org>; Thu, 15 Nov 2018 12:16:43 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/common/defaults.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/defaults.c b/src/common/defaults.c
index 3bb42280f..874578183 100644
--- a/src/common/defaults.c
+++ b/src/common/defaults.c
@@ -118,7 +118,7 @@ static void __attribute__((constructor)) init_default_pthread_attr(void)
 	}
 
 	if (rlim.rlim_max > 0 && selected_ss > rlim.rlim_max) {
-		WARN("Your system's stack size restrictions (%zu bytes) may be too low for the LTTng daemons to function properly, please set the stack size limit to at leat %zu bytes to ensure reliable operation",
+		WARN("Your system's stack size restrictions (%zu bytes) may be too low for the LTTng daemons to function properly, please set the stack size limit to at least %zu bytes to ensure reliable operation",
 			(size_t) rlim.rlim_max, (size_t) DEFAULT_LTTNG_THREAD_STACK_SIZE);
 		selected_ss = (size_t) rlim.rlim_max;
 	}
-- 
2.17.1
