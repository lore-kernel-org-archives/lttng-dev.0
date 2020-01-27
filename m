From: "Alex Xu \(Hello71\) via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: [PATCH 1/2] Add FreeBSD, DragonFly to syscall-compat.h
Date: Mon, 27 Jan 2020 13:25:25 -0500
Message-ID: <20200127182526.22881-1-alex_y_xu@yahoo.ca>
References: <20200127182526.22881-1-alex_y_xu.ref@yahoo.ca>
Reply-To: "Alex Xu \(Hello71\)" <alex_y_xu@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic310-48.consmr.mail.gq1.yahoo.com
 (sonic310-48.consmr.mail.gq1.yahoo.com [98.137.69.174])
 by lists.lttng.org (Postfix) with ESMTPS id 485ysH5gSbz1xZr
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 13:27:31 -0500 (EST)
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
List-Id: lttng-dev@lists.lttng.org

---
 include/urcu/syscall-compat.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/urcu/syscall-compat.h b/include/urcu/syscall-compat.h
index fa63a7b..23b266e 100644
--- a/include/urcu/syscall-compat.h
+++ b/include/urcu/syscall-compat.h
@@ -32,8 +32,9 @@
 #elif defined(__linux__) || defined(__GLIBC__)
 #include <syscall.h>
 
-#elif defined(__CYGWIN__) || defined(__APPLE__)
-/* Don't include anything on Cygwin or MacOSX. */
+#elif defined(__CYGWIN__) || defined(__APPLE__) || \
+	defined(__FreeBSD__) || defined(__DragonFly__)
+/* Don't include anything on these platforms. */
 
 #else
 #error "Add platform support to urcu/syscall-compat.h"
-- 
2.25.0
