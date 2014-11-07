From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH babeltrace] Remove duplicate include of unistd
	in test_ctf_writer
Date: Fri,  7 Nov 2014 10:20:28 -0500
Message-ID: <1415373628-32259-1-git-send-email-christian.babeux__36197.054552804$1415373699$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <christian.babeux@0x80.ca>) id 1XmlLS-0004Km-IN
 for lttng-dev@lists.lttng.org; Fri, 07 Nov 2014 10:21:05 -0500
Received: by mail-qa0-f49.google.com with SMTP id i13so2383335qae.8
 for <lttng-dev@lists.lttng.org>; Fri, 07 Nov 2014 07:20:55 -0800 (PST)
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

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/lib/test_ctf_writer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/lib/test_ctf_writer.c b/tests/lib/test_ctf_writer.c
index bd33ab7..9d428c2 100644
--- a/tests/lib/test_ctf_writer.c
+++ b/tests/lib/test_ctf_writer.c
@@ -34,7 +34,6 @@
 #include <babeltrace/compat/limits.h>
 #include <string.h>
 #include <assert.h>
-#include <unistd.h>
 #include <sys/wait.h>
 #include <fcntl.h>
 #include <dirent.h>
-- 
2.1.1
