From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 13/23] Add MinGW implementation of
	sleep
Date: Wed, 22 May 2013 08:06:58 +0000
Message-ID: <009B25148989C6458484484699278506E5382F7B__33509.487755555$1369210060$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf44g-0006WU-6j
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:07:06 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>, =?iso-8859-1?Q?J=E9r=E9mie_Galarneau_=28jeremie=2Egalarneau=40efficios=2E?= =?iso-8859-1?Q?com=29?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Add new function sleep() that calls Windows Sleep() instead.
---
 converter/babeltrace.c             | 2 +-
 include/babeltrace/compat/unistd.h | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index b356c43..5cc9949 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -46,7 +46,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <fcntl.h>
-#include <unistd.h>
+#include <babeltrace/compat/unistd.h>
 #include <inttypes.h>
 #include <babeltrace/compat/ftw.h>
 #include <string.h>
diff --git a/include/babeltrace/compat/unistd.h b/include/babeltrace/compat/unistd.h
index d39dd50..5a741a1 100644
--- a/include/babeltrace/compat/unistd.h
+++ b/include/babeltrace/compat/unistd.h
@@ -16,6 +16,11 @@ int fpathconf (int fd, int name)
 	return MAX_PATH;
 }
 
-#endif
+static inline
+void sleep(unsigned int x)
+{
+	Sleep(1000 * x);
+}
 
 #endif
+#endif
-- 
1.8.1.msysgit.1
