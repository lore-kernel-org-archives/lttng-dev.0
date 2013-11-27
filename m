From: Charles Briere <charlesbriere.flatzo@gmail.com>
Subject: [PATCH liburcu 4/5] Fix: Do not redefine gettid on
	Android
Date: Tue, 26 Nov 2013 21:08:21 -0800
Message-ID: <1385528902-4797-4-git-send-email-charlesbriere.flatzo__1930.54809137738$1385529082$gmane$org@gmail.com>
References: <1385528902-4797-1-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1VlXNe-0002PF-37
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 00:09:43 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so9533359pbc.40
	for <lttng-dev@lists.lttng.org>; Tue, 26 Nov 2013 21:09:36 -0800 (PST)
In-Reply-To: <1385528902-4797-1-git-send-email-charlesbriere.flatzo@gmail.com>
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
 tests/common/thread-id.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/common/thread-id.h b/tests/common/thread-id.h
index bad3006..a2c9e3a 100644
--- a/tests/common/thread-id.h
+++ b/tests/common/thread-id.h
@@ -42,6 +42,9 @@ unsigned long urcu_get_thread_id(void)
 {
 	return (unsigned long) pthread_getthreadid_np();
 }
+#elif defined(__Android__)
+// Do not redefine gettid() as it is already included
+// in bionic through <unistd.h>
 #else
 # warning "use pid as thread ID"
 static inline
-- 
1.8.4.2
