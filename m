From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 11/24] Add : Compatibility layer for
	limit.h
Date: Mon, 27 Oct 2014 20:49:29 +0000
Message-ID: <1414442926-14381-12-git-send-email-c.briere__1768.22060389004$1414443634$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]
 helo=usmailout3.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEV-0007ni-N4
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:48 -0400
Received: from uscpsbgex3.samsung.com
 (u124.gpu85.samsung.co.kr [203.254.195.124]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE4003LIF6KVU30@usmailout3.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:32 -0400 (EDT)
In-reply-to: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Content-language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>, "dgoulet@efficios.com" <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "karim.yaghmour@opersys.com" <karim.yaghmour@opersys.com>
List-Id: lttng-dev@lists.lttng.org

From: Charles Briere <c.briere@samsung.com>

Define the following values if not already defined :

	* HOST_NAME_MAX to 64
	* NAME_MAX to 255
	* PATH_MAX to 4096

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 include/lttng/constant.h                   |  2 +-
 include/lttng/load-internal.h              |  2 +-
 include/lttng/save-internal.h              |  2 +-
 include/lttng/snapshot-internal.h          |  2 +-
 include/lttng/snapshot.h                   |  2 +-
 src/bin/lttng-consumerd/health-consumerd.c |  2 +-
 src/bin/lttng-consumerd/lttng-consumerd.c  |  2 +-
 src/bin/lttng-relayd/connection.h          |  2 +-
 src/bin/lttng-relayd/health-relayd.c       |  2 +-
 src/bin/lttng-relayd/health-relayd.h       |  2 +-
 src/bin/lttng-relayd/live.c                |  2 +-
 src/bin/lttng-relayd/lttng-relayd.h        |  2 +-
 src/bin/lttng-relayd/lttng-viewer-abi.h    |  2 +-
 src/bin/lttng-relayd/main.c                |  2 +-
 src/bin/lttng-relayd/session.h             |  2 +-
 src/bin/lttng-relayd/stream.h              |  2 +-
 src/bin/lttng-relayd/viewer-stream.h       |  2 +-
 src/bin/lttng-sessiond/lttng-ust-error.h   |  2 +-
 src/bin/lttng-sessiond/main.c              |  2 +-
 src/bin/lttng-sessiond/session.c           |  2 +-
 src/bin/lttng-sessiond/session.h           |  2 +-
 src/bin/lttng-sessiond/shm.c               |  2 +-
 src/bin/lttng-sessiond/snapshot.h          |  2 +-
 src/bin/lttng-sessiond/trace-ust.h         |  2 +-
 src/bin/lttng-sessiond/ust-metadata.c      |  2 +-
 src/bin/lttng/commands/view.c              |  1 +
 src/bin/lttng/conf.c                       |  2 +-
 src/bin/lttng/utils.c                      |  2 +-
 src/common/align.h                         |  2 +-
 src/common/compat/Makefile.am              |  2 +-
 src/common/compat/compat-epoll.c           |  2 +-
 src/common/compat/limits.h                 | 36 ++++++++++++++++++++++++++++++
 src/common/consumer.h                      |  2 +-
 src/common/futex.c                         |  2 +-
 src/common/index/ctf-index.h               |  2 +-
 src/common/readwrite.c                     |  2 +-
 src/common/runas.c                         |  2 +-
 src/common/sessiond-comm/inet.c            |  2 +-
 src/common/sessiond-comm/inet.h            |  2 +-
 src/common/sessiond-comm/inet6.c           |  2 +-
 src/common/sessiond-comm/inet6.h           |  2 +-
 src/common/sessiond-comm/relayd.h          |  2 +-
 src/common/sessiond-comm/sessiond-comm.c   |  2 +-
 src/common/sessiond-comm/sessiond-comm.h   |  2 +-
 src/common/sessiond-comm/unix.c            |  2 +-
 src/common/sessiond-comm/unix.h            |  2 +-
 src/common/utils.c                         |  2 +-
 src/lib/lttng-ctl/lttng-ctl-health.c       |  2 +-
 tests/unit/test_utils_expand_path.c        |  2 +-
 49 files changed, 84 insertions(+), 47 deletions(-)
 create mode 100644 src/common/compat/limits.h

diff --git a/include/lttng/constant.h b/include/lttng/constant.h
index ed3ebe0..1d6479b 100644
--- a/include/lttng/constant.h
+++ b/include/lttng/constant.h
@@ -28,7 +28,7 @@
 #endif /* defined __GNUC__ */
 #endif /* LTTNG_DEPRECATED */
 
-#include <limits.h>
+#include <common/compat/limits.h>
 /*
  * Necessary to include the fixed width type limits on glibc versions older
  * than 2.18 when building with a C++ compiler.
diff --git a/include/lttng/load-internal.h b/include/lttng/load-internal.h
index 85f0afa..84c1ab0 100644
--- a/include/lttng/load-internal.h
+++ b/include/lttng/load-internal.h
@@ -19,7 +19,7 @@
 #ifndef LTTNG_LOAD_INTERNAL_ABI_H
 #define LTTNG_LOAD_INTERNAL_ABI_H
 
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdint.h>
 
 #include <common/macros.h>
diff --git a/include/lttng/save-internal.h b/include/lttng/save-internal.h
index f4a56f8..3e22923 100644
--- a/include/lttng/save-internal.h
+++ b/include/lttng/save-internal.h
@@ -18,7 +18,7 @@
 #ifndef LTTNG_SAVE_INTERNAL_ABI_H
 #define LTTNG_SAVE_INTERNAL_ABI_H
 
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdint.h>
 
 #include <common/macros.h>
diff --git a/include/lttng/snapshot-internal.h b/include/lttng/snapshot-internal.h
index a14564b..0bcac69 100644
--- a/include/lttng/snapshot-internal.h
+++ b/include/lttng/snapshot-internal.h
@@ -18,7 +18,7 @@
 #ifndef LTTNG_SNAPSHOT_INTERNAL_ABI_H
 #define LTTNG_SNAPSHOT_INTERNAL_ABI_H
 
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdint.h>
 
 /*
diff --git a/include/lttng/snapshot.h b/include/lttng/snapshot.h
index 90c712a..8b2749f 100644
--- a/include/lttng/snapshot.h
+++ b/include/lttng/snapshot.h
@@ -18,7 +18,7 @@
 #ifndef LTTNG_SNAPSHOT_H
 #define LTTNG_SNAPSHOT_H
 
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdint.h>
 #include <sys/types.h>
 
diff --git a/src/bin/lttng-consumerd/health-consumerd.c b/src/bin/lttng-consumerd/health-consumerd.c
index d1478e5..079a14b 100644
--- a/src/bin/lttng-consumerd/health-consumerd.c
+++ b/src/bin/lttng-consumerd/health-consumerd.c
@@ -19,7 +19,7 @@
 #include <fcntl.h>
 #include <getopt.h>
 #include <grp.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <pthread.h>
 #include <signal.h>
 #include <stdio.h>
diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index 5d57030..bdd8ddc 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -20,7 +20,7 @@
 #include <fcntl.h>
 #include <getopt.h>
 #include <grp.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <pthread.h>
 #include <signal.h>
 #include <stdio.h>
diff --git a/src/bin/lttng-relayd/connection.h b/src/bin/lttng-relayd/connection.h
index 70fe4ba..9678187 100644
--- a/src/bin/lttng-relayd/connection.h
+++ b/src/bin/lttng-relayd/connection.h
@@ -19,7 +19,7 @@
 #ifndef _CONNECTION_H
 #define _CONNECTION_H
 
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <inttypes.h>
 #include <pthread.h>
 #include <urcu.h>
diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/health-relayd.c
index 8a5cbdf..3a5cc90 100644
--- a/src/bin/lttng-relayd/health-relayd.c
+++ b/src/bin/lttng-relayd/health-relayd.c
@@ -19,7 +19,7 @@
 #include <fcntl.h>
 #include <getopt.h>
 #include <grp.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <pthread.h>
 #include <signal.h>
 #include <stdio.h>
diff --git a/src/bin/lttng-relayd/health-relayd.h b/src/bin/lttng-relayd/health-relayd.h
index 7c7b6e7..911b04a 100644
--- a/src/bin/lttng-relayd/health-relayd.h
+++ b/src/bin/lttng-relayd/health-relayd.h
@@ -19,7 +19,7 @@
  * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <lttng/health-internal.h>
 
 #define LTTNG_RELAYD_HEALTH_ENV		"LTTNG_RELAYD_HEALTH"
diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index 5684608..43fc0fb 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -19,7 +19,7 @@
 #define _GNU_SOURCE
 #include <getopt.h>
 #include <grp.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <pthread.h>
 #include <signal.h>
 #include <stdio.h>
diff --git a/src/bin/lttng-relayd/lttng-relayd.h b/src/bin/lttng-relayd/lttng-relayd.h
index 896925f..65ab13a 100644
--- a/src/bin/lttng-relayd/lttng-relayd.h
+++ b/src/bin/lttng-relayd/lttng-relayd.h
@@ -20,7 +20,7 @@
 #define LTTNG_RELAYD_H
 
 #define _LGPL_SOURCE
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <urcu.h>
 #include <urcu/wfcqueue.h>
 
diff --git a/src/bin/lttng-relayd/lttng-viewer-abi.h b/src/bin/lttng-relayd/lttng-viewer-abi.h
index f9bce98..0bd163a 100644
--- a/src/bin/lttng-relayd/lttng-viewer-abi.h
+++ b/src/bin/lttng-relayd/lttng-viewer-abi.h
@@ -25,7 +25,7 @@
  * SOFTWARE.
  */
 
-#include <limits.h>
+#include <common/compat/limits.h>
 
 #define LTTNG_VIEWER_PATH_MAX		4096
 #define LTTNG_VIEWER_NAME_MAX		255
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 802d7e1..747e023 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -20,7 +20,7 @@
 #define _GNU_SOURCE
 #include <getopt.h>
 #include <grp.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <pthread.h>
 #include <signal.h>
 #include <stdio.h>
diff --git a/src/bin/lttng-relayd/session.h b/src/bin/lttng-relayd/session.h
index cb125be..df46eff 100644
--- a/src/bin/lttng-relayd/session.h
+++ b/src/bin/lttng-relayd/session.h
@@ -19,7 +19,7 @@
 #ifndef _SESSION_H
 #define _SESSION_H
 
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <inttypes.h>
 #include <pthread.h>
 #include <urcu/list.h>
diff --git a/src/bin/lttng-relayd/stream.h b/src/bin/lttng-relayd/stream.h
index 4dd2e62..2403491 100644
--- a/src/bin/lttng-relayd/stream.h
+++ b/src/bin/lttng-relayd/stream.h
@@ -19,7 +19,7 @@
 #ifndef _STREAM_H
 #define _STREAM_H
 
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <inttypes.h>
 #include <pthread.h>
 #include <urcu/list.h>
diff --git a/src/bin/lttng-relayd/viewer-stream.h b/src/bin/lttng-relayd/viewer-stream.h
index 003b119..a9f24b7 100644
--- a/src/bin/lttng-relayd/viewer-stream.h
+++ b/src/bin/lttng-relayd/viewer-stream.h
@@ -19,7 +19,7 @@
 #ifndef _VIEWER_STREAM_H
 #define _VIEWER_STREAM_H
 
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <inttypes.h>
 #include <pthread.h>
 
diff --git a/src/bin/lttng-sessiond/lttng-ust-error.h b/src/bin/lttng-sessiond/lttng-ust-error.h
index d9062c0..9b8b811 100644
--- a/src/bin/lttng-sessiond/lttng-ust-error.h
+++ b/src/bin/lttng-sessiond/lttng-ust-error.h
@@ -26,7 +26,7 @@
  * These declarations should NOT be considered stable API.
  */
 
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <unistd.h>
 
 #include "lttng-ust-abi.h"
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index fa09758..7d6d87f 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -20,7 +20,7 @@
 #define _GNU_SOURCE
 #include <getopt.h>
 #include <grp.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <paths.h>
 #include <pthread.h>
 #include <signal.h>
diff --git a/src/bin/lttng-sessiond/session.c b/src/bin/lttng-sessiond/session.c
index cd59cb7..5c371d6 100644
--- a/src/bin/lttng-sessiond/session.c
+++ b/src/bin/lttng-sessiond/session.c
@@ -16,7 +16,7 @@
  */
 
 #define _GNU_SOURCE
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng-sessiond/session.h b/src/bin/lttng-sessiond/session.h
index 368b352..63ade8d 100644
--- a/src/bin/lttng-sessiond/session.h
+++ b/src/bin/lttng-sessiond/session.h
@@ -18,9 +18,9 @@
 #ifndef _LTT_SESSION_H
 #define _LTT_SESSION_H
 
-#include <limits.h>
 #include <urcu/list.h>
 
+#include <common/compat/limits.h>
 #include <common/hashtable/hashtable.h>
 
 #include "snapshot.h"
diff --git a/src/bin/lttng-sessiond/shm.c b/src/bin/lttng-sessiond/shm.c
index fa3867c..d6cf3af 100644
--- a/src/bin/lttng-sessiond/shm.c
+++ b/src/bin/lttng-sessiond/shm.c
@@ -20,7 +20,7 @@
 
 #define _GNU_SOURCE
 #include <fcntl.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
diff --git a/src/bin/lttng-sessiond/snapshot.h b/src/bin/lttng-sessiond/snapshot.h
index bdf0570..116371f 100644
--- a/src/bin/lttng-sessiond/snapshot.h
+++ b/src/bin/lttng-sessiond/snapshot.h
@@ -18,7 +18,7 @@
 #ifndef SNAPSHOT_H
 #define SNAPSHOT_H
 
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdint.h>
 
 #include <common/common.h>
diff --git a/src/bin/lttng-sessiond/trace-ust.h b/src/bin/lttng-sessiond/trace-ust.h
index 795389e..d4475b9 100644
--- a/src/bin/lttng-sessiond/trace-ust.h
+++ b/src/bin/lttng-sessiond/trace-ust.h
@@ -19,7 +19,7 @@
 #define _LTT_TRACE_UST_H
 
 #include <config.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <urcu/list.h>
 
 #include <lttng/lttng.h>
diff --git a/src/bin/lttng-sessiond/ust-metadata.c b/src/bin/lttng-sessiond/ust-metadata.c
index f430ae1..f70c4b2 100644
--- a/src/bin/lttng-sessiond/ust-metadata.c
+++ b/src/bin/lttng-sessiond/ust-metadata.c
@@ -24,7 +24,7 @@
 #include <string.h>
 #include <stdarg.h>
 #include <stdio.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <unistd.h>
 #include <inttypes.h>
 #include <common/common.h>
diff --git a/src/bin/lttng/commands/view.c b/src/bin/lttng/commands/view.c
index dcd4d66..6b0f454 100644
--- a/src/bin/lttng/commands/view.c
+++ b/src/bin/lttng/commands/view.c
@@ -25,6 +25,7 @@
 #include <unistd.h>
 
 #include "../command.h"
+#include <common/compat/limits.h>
 #include <config.h>
 
 static char *opt_session_name;
diff --git a/src/bin/lttng/conf.c b/src/bin/lttng/conf.c
index 55ed635..5982215 100644
--- a/src/bin/lttng/conf.c
+++ b/src/bin/lttng/conf.c
@@ -16,7 +16,7 @@
  */
 
 #define _GNU_SOURCE
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
index fc592eb..78fc830 100644
--- a/src/bin/lttng/utils.c
+++ b/src/bin/lttng/utils.c
@@ -19,7 +19,7 @@
 #include <assert.h>
 #include <stdlib.h>
 #include <ctype.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <signal.h>
diff --git a/src/common/align.h b/src/common/align.h
index fe32673..117aa10 100644
--- a/src/common/align.h
+++ b/src/common/align.h
@@ -19,7 +19,7 @@
 
 #include "bug.h"
 #include <unistd.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 
 #ifndef PAGE_SIZE	/* Cygwin limits.h defines its own PAGE_SIZE */
 #define PAGE_SIZE		sysconf(_SC_PAGE_SIZE)
diff --git a/src/common/compat/Makefile.am b/src/common/compat/Makefile.am
index 40495ed..caa076c 100644
--- a/src/common/compat/Makefile.am
+++ b/src/common/compat/Makefile.am
@@ -10,4 +10,4 @@ endif
 
 libcompat_la_SOURCES = poll.h fcntl.h endian.h mman.h clone.h \
                        socket.h compat-fcntl.c uuid.h tid.h netinet/in.h \
-		       $(COMPAT)
+		       limits.h $(COMPAT)
diff --git a/src/common/compat/compat-epoll.c b/src/common/compat/compat-epoll.c
index 368fae1..50b85d2 100644
--- a/src/common/compat/compat-epoll.c
+++ b/src/common/compat/compat-epoll.c
@@ -18,7 +18,7 @@
 #define _GNU_SOURCE
 #include <assert.h>
 #include <fcntl.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/src/common/compat/limits.h b/src/common/compat/limits.h
new file mode 100644
index 0000000..6782949
--- /dev/null
+++ b/src/common/compat/limits.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) 2014 - Charles Briere <charlesbriere.flatzo@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef _COMPAT_LIMITS_H
+#define _COMPAT_LIMITS_H
+
+#include <limits.h>
+#include <config.h>
+
+#ifndef HOST_NAME_MAX
+# define HOST_NAME_MAX 64
+#endif
+
+#ifndef NAME_MAX
+# define NAME_MAX 255
+#endif
+
+#ifndef PATH_MAX
+# define PATH_MAX 4096
+#endif
+
+#endif /* _COMPAT_LIMITS_H */
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 4ac823c..2be4d71 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -20,7 +20,7 @@
 #ifndef LIB_CONSUMER_H
 #define LIB_CONSUMER_H
 
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <poll.h>
 #include <unistd.h>
 #include <urcu/list.h>
diff --git a/src/common/futex.c b/src/common/futex.c
index b373ed5..e70eb19 100644
--- a/src/common/futex.c
+++ b/src/common/futex.c
@@ -17,7 +17,7 @@
  */
 
 #define _GNU_SOURCE
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <common/compat/syscall.h>
 #include <unistd.h>
 #include <urcu.h>
diff --git a/src/common/index/ctf-index.h b/src/common/index/ctf-index.h
index 0efa888..574f6ef 100644
--- a/src/common/index/ctf-index.h
+++ b/src/common/index/ctf-index.h
@@ -25,7 +25,7 @@
 #ifndef LTTNG_INDEX_H
 #define LTTNG_INDEX_H
 
-#include <limits.h>
+#include <common/compat/limits.h>
 
 #define CTF_INDEX_MAGIC 0xC1F1DCC1
 #define CTF_INDEX_MAJOR 1
diff --git a/src/common/readwrite.c b/src/common/readwrite.c
index d33e051..2b17868 100644
--- a/src/common/readwrite.c
+++ b/src/common/readwrite.c
@@ -17,7 +17,7 @@
 
 #include <assert.h>
 #include <errno.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <unistd.h>
 
 #include "readwrite.h"
diff --git a/src/common/runas.c b/src/common/runas.c
index 5ab4271..c59d722 100644
--- a/src/common/runas.c
+++ b/src/common/runas.c
@@ -18,7 +18,7 @@
 
 #define _GNU_SOURCE
 #include <errno.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/common/sessiond-comm/inet.c b/src/common/sessiond-comm/inet.c
index 32a16a6..fb2f097 100644
--- a/src/common/sessiond-comm/inet.c
+++ b/src/common/sessiond-comm/inet.c
@@ -17,7 +17,7 @@
 
 #define _GNU_SOURCE
 #include <assert.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/common/sessiond-comm/inet.h b/src/common/sessiond-comm/inet.h
index 83209bb..7b20524 100644
--- a/src/common/sessiond-comm/inet.h
+++ b/src/common/sessiond-comm/inet.h
@@ -19,7 +19,7 @@
 #define _LTTCOMM_INET_H
 
 #define _GNU_SOURCE
-#include <limits.h>
+#include <common/compat/limits.h>
 
 #include "sessiond-comm.h"
 
diff --git a/src/common/sessiond-comm/inet6.c b/src/common/sessiond-comm/inet6.c
index 5b137c4..c0c307f 100644
--- a/src/common/sessiond-comm/inet6.c
+++ b/src/common/sessiond-comm/inet6.c
@@ -17,7 +17,7 @@
 
 #define _GNU_SOURCE
 #include <assert.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/common/sessiond-comm/inet6.h b/src/common/sessiond-comm/inet6.h
index 4cb4dca..1d1c8f9 100644
--- a/src/common/sessiond-comm/inet6.h
+++ b/src/common/sessiond-comm/inet6.h
@@ -19,7 +19,7 @@
 #define _LTTCOMM_INET6_H
 
 #define _GNU_SOURCE
-#include <limits.h>
+#include <common/compat/limits.h>
 
 #include "sessiond-comm.h"
 
diff --git a/src/common/sessiond-comm/relayd.h b/src/common/sessiond-comm/relayd.h
index ff56d3a..70f7c73 100644
--- a/src/common/sessiond-comm/relayd.h
+++ b/src/common/sessiond-comm/relayd.h
@@ -21,10 +21,10 @@
 
 #define _GNU_SOURCE
 
-#include <limits.h>
 #include <stdint.h>
 
 #include <lttng/lttng.h>
+#include <common/compat/limits.h>
 #include <common/defaults.h>
 #include <common/index/ctf-index.h>
 #include <config.h>
diff --git a/src/common/sessiond-comm/sessiond-comm.c b/src/common/sessiond-comm/sessiond-comm.c
index 65952b2..2a04a85 100644
--- a/src/common/sessiond-comm/sessiond-comm.c
+++ b/src/common/sessiond-comm/sessiond-comm.c
@@ -18,7 +18,7 @@
 
 #define _GNU_SOURCE
 #include <assert.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 9842214..b830abf 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -26,7 +26,7 @@
 #define _LTTNG_SESSIOND_COMM_H
 
 #define _GNU_SOURCE
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <lttng/lttng.h>
 #include <lttng/snapshot-internal.h>
 #include <lttng/save-internal.h>
diff --git a/src/common/sessiond-comm/unix.c b/src/common/sessiond-comm/unix.c
index 2c87b82..0dd7f27 100644
--- a/src/common/sessiond-comm/unix.c
+++ b/src/common/sessiond-comm/unix.c
@@ -18,7 +18,7 @@
 
 #define _GNU_SOURCE
 #include <assert.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/common/sessiond-comm/unix.h b/src/common/sessiond-comm/unix.h
index 19b91ce..9b65586 100644
--- a/src/common/sessiond-comm/unix.h
+++ b/src/common/sessiond-comm/unix.h
@@ -19,7 +19,7 @@
 #define _LTTCOMM_UNIX_H
 
 #define _GNU_SOURCE
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <sys/un.h>
 
 #include <common/compat/socket.h>
diff --git a/src/common/utils.c b/src/common/utils.c
index 1d07cb3..9a05ea2 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -21,7 +21,7 @@
 #include <assert.h>
 #include <ctype.h>
 #include <fcntl.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/stat.h>
diff --git a/src/lib/lttng-ctl/lttng-ctl-health.c b/src/lib/lttng-ctl/lttng-ctl-health.c
index ba9aac0..68e8eb7 100644
--- a/src/lib/lttng-ctl/lttng-ctl-health.c
+++ b/src/lib/lttng-ctl/lttng-ctl-health.c
@@ -23,7 +23,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <stdint.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 #include <errno.h>
 #include <lttng/health-internal.h>
 
diff --git a/tests/unit/test_utils_expand_path.c b/tests/unit/test_utils_expand_path.c
index f863b5d..15e56a1 100644
--- a/tests/unit/test_utils_expand_path.c
+++ b/tests/unit/test_utils_expand_path.c
@@ -19,7 +19,7 @@
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <limits.h>
+#include <common/compat/limits.h>
 
 #include <sys/stat.h>
 #include <sys/types.h>
-- 
2.1.2
