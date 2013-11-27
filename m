From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH liburcu 4/5] Fix: Do not redefine gettid on
	Android
Date: Wed, 27 Nov 2013 07:48:32 -0800
Message-ID: <1385567313-8138-4-git-send-email-charlesbriere.flatzo__12277.2628478289$1385567776$gmane$org@gmail.com>
References: <1385567313-8138-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1VlhNI-0002Va-Cu
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 10:50:09 -0500
Received: by mail-pb0-f50.google.com with SMTP id rr13so10695628pbb.9
	for <lttng-dev@lists.lttng.org>; Wed, 27 Nov 2013 07:49:54 -0800 (PST)
In-Reply-To: <1385567313-8138-1-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: Charles Briere <charlesbriere.flatzo@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Bionic already defines gettid through <unistd.h>

Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
---
 tests/common/thread-id.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/common/thread-id.h b/tests/common/thread-id.h
index bad3006..b89a100 100644
--- a/tests/common/thread-id.h
+++ b/tests/common/thread-id.h
@@ -42,6 +42,11 @@ unsigned long urcu_get_thread_id(void)
 {
 	return (unsigned long) pthread_getthreadid_np();
 }
+#elif defined(__Android__)
+/* 
+ * Do not redefine gettid() as it is already included
+ * in bionic through <unistd.h>
+ */
 #else
 # warning "use pid as thread ID"
 static inline
-- 
1.8.4.2
