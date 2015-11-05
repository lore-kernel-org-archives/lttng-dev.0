From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace] Fix: BABELTRACE_HAVE_LIBC_UUID
	misspelled as BT_HAVE_LIBC_UUID
Date: Thu,  5 Nov 2015 12:52:37 -0500
Message-ID: <1446745957-2004-1-git-send-email-mjeanson__20226.184387184$1446746069$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZuOiZ-0004Wt-As
 for lttng-dev@lists.lttng.org; Thu, 05 Nov 2015 12:53:00 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 include/babeltrace/compat/uuid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/babeltrace/compat/uuid.h b/include/babeltrace/compat/uuid.h
index 369e478..4237eb5 100644
--- a/include/babeltrace/compat/uuid.h
+++ b/include/babeltrace/compat/uuid.h
@@ -83,7 +83,7 @@ int bt_uuid_compare(const unsigned char *uuid_a,
 }
 #endif
 
-#elif defined(BT_HAVE_LIBC_UUID)
+#elif defined(BABELTRACE_HAVE_LIBC_UUID)
 #include <uuid.h>
 #include <stdint.h>
 #include <string.h>
-- 
1.9.1
