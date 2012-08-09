From: Danny Serres <danny.serres@efficios.com>
Subject: [babeltrace PATCH] Remove trace-collection.h from
	include_headers
Date: Thu,  9 Aug 2012 14:42:59 -0400
Message-ID: <1344537779-19779-1-git-send-email-danny.serres__36538.2363707342$1344537807$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <danny.serres@efficios.com>) id 1SzXhJ-0004nP-Fx
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 14:43:05 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Danny Serres <danny.serres@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Danny Serres <danny.serres@efficios.com>
---
 include/Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/Makefile.am b/include/Makefile.am
index f7488da..79247a0 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -3,7 +3,6 @@ babeltraceinclude_HEADERS = \
 	babeltrace/format.h \
 	babeltrace/context.h \
 	babeltrace/iterator.h \
-	babeltrace/trace-collection.h \
 	babeltrace/trace-handle.h \
 	babeltrace/list.h \
 	babeltrace/clock-types.h
@@ -21,6 +20,7 @@ noinst_HEADERS = \
 	babeltrace/context-internal.h \
 	babeltrace/iterator-internal.h \
 	babeltrace/prio_heap.h \
+	babeltrace/trace-collection.h \
 	babeltrace/types.h \
 	babeltrace/ctf-ir/metadata.h \
 	babeltrace/ctf/events-internal.h \
-- 
1.7.9.5
