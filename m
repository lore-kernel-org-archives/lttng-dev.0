From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: define _LGPL_SOURCE in C files
Date: Thu, 13 Nov 2014 16:22:33 -0500
Message-ID: <1415913753-19134-1-git-send-email-mathieu.desnoyers__45975.6810604178$1415913825$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Xp1qo-0007o4-Nl
 for lttng-dev@lists.lttng.org; Thu, 13 Nov 2014 16:22:51 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Defining this in headers is a bad practice, since the header is not
necessarily the first in the include list.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-consumerd/health-consumerd.c   | 1 +
 src/bin/lttng-consumerd/lttng-consumerd.c    | 1 +
 src/bin/lttng-relayd/cmd-2-1.c               | 1 +
 src/bin/lttng-relayd/cmd-2-2.c               | 1 +
 src/bin/lttng-relayd/cmd-2-4.c               | 1 +
 src/bin/lttng-relayd/cmd-generic.c           | 1 +
 src/bin/lttng-relayd/connection.c            | 1 +
 src/bin/lttng-relayd/ctf-trace.c             | 1 +
 src/bin/lttng-relayd/health-relayd.c         | 1 +
 src/bin/lttng-relayd/index.c                 | 1 +
 src/bin/lttng-relayd/live.c                  | 1 +
 src/bin/lttng-relayd/lttng-relayd.h          | 1 -
 src/bin/lttng-relayd/main.c                  | 1 +
 src/bin/lttng-relayd/session.c               | 1 +
 src/bin/lttng-relayd/stream.c                | 1 +
 src/bin/lttng-relayd/utils.c                 | 1 +
 src/bin/lttng-relayd/viewer-stream.c         | 1 +
 src/bin/lttng-sessiond/agent-thread.c        | 1 +
 src/bin/lttng-sessiond/agent.c               | 1 +
 src/bin/lttng-sessiond/buffer-registry.c     | 1 +
 src/bin/lttng-sessiond/channel.c             | 1 +
 src/bin/lttng-sessiond/cmd.c                 | 1 +
 src/bin/lttng-sessiond/consumer.c            | 1 +
 src/bin/lttng-sessiond/context.c             | 1 +
 src/bin/lttng-sessiond/event.c               | 1 +
 src/bin/lttng-sessiond/fd-limit.c            | 1 +
 src/bin/lttng-sessiond/ht-cleanup.c          | 1 +
 src/bin/lttng-sessiond/kernel-consumer.c     | 1 +
 src/bin/lttng-sessiond/kernel.c              | 1 +
 src/bin/lttng-sessiond/load-session-thread.c | 1 +
 src/bin/lttng-sessiond/lttng-sessiond.h      | 1 -
 src/bin/lttng-sessiond/main.c                | 1 +
 src/bin/lttng-sessiond/modprobe.c            | 1 +
 src/bin/lttng-sessiond/save.c                | 1 +
 src/bin/lttng-sessiond/session.c             | 1 +
 src/bin/lttng-sessiond/shm.c                 | 1 +
 src/bin/lttng-sessiond/snapshot.c            | 1 +
 src/bin/lttng-sessiond/syscall.c             | 1 +
 src/bin/lttng-sessiond/trace-kernel.c        | 1 +
 src/bin/lttng-sessiond/trace-ust.c           | 1 +
 src/bin/lttng-sessiond/ust-app.c             | 1 +
 src/bin/lttng-sessiond/ust-consumer.c        | 1 +
 src/bin/lttng-sessiond/ust-metadata.c        | 1 +
 src/bin/lttng-sessiond/ust-registry.c        | 1 +
 src/bin/lttng-sessiond/ust-thread.c          | 1 +
 src/bin/lttng-sessiond/utils.c               | 1 +
 src/bin/lttng/commands/add_context.c         | 1 +
 src/bin/lttng/commands/calibrate.c           | 1 +
 src/bin/lttng/commands/create.c              | 1 +
 src/bin/lttng/commands/destroy.c             | 1 +
 src/bin/lttng/commands/disable_channels.c    | 1 +
 src/bin/lttng/commands/disable_events.c      | 1 +
 src/bin/lttng/commands/enable_channels.c     | 1 +
 src/bin/lttng/commands/enable_events.c       | 1 +
 src/bin/lttng/commands/list.c                | 1 +
 src/bin/lttng/commands/load.c                | 1 +
 src/bin/lttng/commands/save.c                | 1 +
 src/bin/lttng/commands/set_session.c         | 1 +
 src/bin/lttng/commands/snapshot.c            | 1 +
 src/bin/lttng/commands/start.c               | 1 +
 src/bin/lttng/commands/stop.c                | 1 +
 src/bin/lttng/commands/version.c             | 1 +
 src/bin/lttng/commands/view.c                | 1 +
 src/bin/lttng/conf.c                         | 1 +
 src/bin/lttng/lttng.c                        | 1 +
 src/bin/lttng/utils.c                        | 1 +
 src/common/compat/compat-epoll.c             | 1 +
 src/common/compat/compat-fcntl.c             | 1 +
 src/common/compat/compat-poll.c              | 1 +
 src/common/config/config.c                   | 1 +
 src/common/consumer-metadata-cache.c         | 1 +
 src/common/consumer-stream.c                 | 1 +
 src/common/consumer-timer.c                  | 1 +
 src/common/consumer.c                        | 1 +
 src/common/daemonize.c                       | 1 +
 src/common/defaults.c                        | 2 ++
 src/common/error.c                           | 1 +
 src/common/futex.c                           | 1 +
 src/common/hashtable/hashtable.c             | 1 +
 src/common/hashtable/rculfhash-mm-chunk.c    | 2 ++
 src/common/hashtable/rculfhash-mm-mmap.c     | 2 ++
 src/common/hashtable/rculfhash-mm-order.c    | 2 ++
 src/common/hashtable/utils.c                 | 1 +
 src/common/health/health.c                   | 1 +
 src/common/index/index.c                     | 1 +
 src/common/kernel-consumer/kernel-consumer.c | 1 +
 src/common/kernel-ctl/kernel-ctl.c           | 2 ++
 src/common/mi-lttng.c                        | 3 ++-
 src/common/pipe.c                            | 1 +
 src/common/readwrite.c                       | 2 ++
 src/common/relayd/relayd.c                   | 1 +
 src/common/runas.c                           | 1 +
 src/common/sessiond-comm/inet.c              | 1 +
 src/common/sessiond-comm/inet6.c             | 1 +
 src/common/sessiond-comm/sessiond-comm.c     | 1 +
 src/common/sessiond-comm/unix.c              | 1 +
 src/common/testpoint/testpoint.c             | 1 +
 src/common/uri.c                             | 1 +
 src/common/ust-consumer/ust-consumer.c       | 1 +
 src/common/utils.c                           | 1 +
 src/lib/lttng-ctl/load.c                     | 1 +
 src/lib/lttng-ctl/lttng-ctl-health.c         | 2 ++
 src/lib/lttng-ctl/lttng-ctl.c                | 1 +
 src/lib/lttng-ctl/save.c                     | 1 +
 src/lib/lttng-ctl/snapshot.c                 | 1 +
 105 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/src/bin/lttng-consumerd/health-consumerd.c b/src/bin/lttng-consumerd/health-consumerd.c
index d1478e5..bd47f0c 100644
--- a/src/bin/lttng-consumerd/health-consumerd.c
+++ b/src/bin/lttng-consumerd/health-consumerd.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <fcntl.h>
 #include <getopt.h>
 #include <grp.h>
diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index 5d57030..299776a 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <fcntl.h>
 #include <getopt.h>
 #include <grp.h>
diff --git a/src/bin/lttng-relayd/cmd-2-1.c b/src/bin/lttng-relayd/cmd-2-1.c
index de70c51..0cd9b5a 100644
--- a/src/bin/lttng-relayd/cmd-2-1.c
+++ b/src/bin/lttng-relayd/cmd-2-1.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <string.h>
 
diff --git a/src/bin/lttng-relayd/cmd-2-2.c b/src/bin/lttng-relayd/cmd-2-2.c
index 978a11e..7dd99ad 100644
--- a/src/bin/lttng-relayd/cmd-2-2.c
+++ b/src/bin/lttng-relayd/cmd-2-2.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <string.h>
 
diff --git a/src/bin/lttng-relayd/cmd-2-4.c b/src/bin/lttng-relayd/cmd-2-4.c
index 6d927a0..d8aa737 100644
--- a/src/bin/lttng-relayd/cmd-2-4.c
+++ b/src/bin/lttng-relayd/cmd-2-4.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <string.h>
 
diff --git a/src/bin/lttng-relayd/cmd-generic.c b/src/bin/lttng-relayd/cmd-generic.c
index 9029dcd..417d6d3 100644
--- a/src/bin/lttng-relayd/cmd-generic.c
+++ b/src/bin/lttng-relayd/cmd-generic.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 
 #include <common/common.h>
diff --git a/src/bin/lttng-relayd/connection.c b/src/bin/lttng-relayd/connection.c
index 4cf87ad..2376a3f 100644
--- a/src/bin/lttng-relayd/connection.c
+++ b/src/bin/lttng-relayd/connection.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <common/common.h>
 
 #include "connection.h"
diff --git a/src/bin/lttng-relayd/ctf-trace.c b/src/bin/lttng-relayd/ctf-trace.c
index 9e9a5c6..59946ea 100644
--- a/src/bin/lttng-relayd/ctf-trace.c
+++ b/src/bin/lttng-relayd/ctf-trace.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 
 #include <common/common.h>
diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/health-relayd.c
index 8a5cbdf..5c4fb50 100644
--- a/src/bin/lttng-relayd/health-relayd.c
+++ b/src/bin/lttng-relayd/health-relayd.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <fcntl.h>
 #include <getopt.h>
 #include <grp.h>
diff --git a/src/bin/lttng-relayd/index.c b/src/bin/lttng-relayd/index.c
index 8cacdd2..a3190b7 100644
--- a/src/bin/lttng-relayd/index.c
+++ b/src/bin/lttng-relayd/index.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 
 #include <common/common.h>
diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index 5684608..2940b2c 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <getopt.h>
 #include <grp.h>
 #include <limits.h>
diff --git a/src/bin/lttng-relayd/lttng-relayd.h b/src/bin/lttng-relayd/lttng-relayd.h
index 896925f..0a3ce47 100644
--- a/src/bin/lttng-relayd/lttng-relayd.h
+++ b/src/bin/lttng-relayd/lttng-relayd.h
@@ -19,7 +19,6 @@
 #ifndef LTTNG_RELAYD_H
 #define LTTNG_RELAYD_H
 
-#define _LGPL_SOURCE
 #include <limits.h>
 #include <urcu.h>
 #include <urcu/wfcqueue.h>
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 802d7e1..824f145 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -18,6 +18,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <getopt.h>
 #include <grp.h>
 #include <limits.h>
diff --git a/src/bin/lttng-relayd/session.c b/src/bin/lttng-relayd/session.c
index a9907c4..e0c450c 100644
--- a/src/bin/lttng-relayd/session.c
+++ b/src/bin/lttng-relayd/session.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <common/common.h>
 
 #include "ctf-trace.h"
diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
index 410fae8..6988e00 100644
--- a/src/bin/lttng-relayd/stream.c
+++ b/src/bin/lttng-relayd/stream.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <common/common.h>
 
 #include "index.h"
diff --git a/src/bin/lttng-relayd/utils.c b/src/bin/lttng-relayd/utils.c
index 392fab6..dbb1d1c 100644
--- a/src/bin/lttng-relayd/utils.c
+++ b/src/bin/lttng-relayd/utils.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng-relayd/viewer-stream.c b/src/bin/lttng-relayd/viewer-stream.c
index 5ab7be7..2f5d6f7 100644
--- a/src/bin/lttng-relayd/viewer-stream.c
+++ b/src/bin/lttng-relayd/viewer-stream.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <common/common.h>
 #include <common/index/index.h>
 
diff --git a/src/bin/lttng-sessiond/agent-thread.c b/src/bin/lttng-sessiond/agent-thread.c
index 1caf748..134aeb1 100644
--- a/src/bin/lttng-sessiond/agent-thread.c
+++ b/src/bin/lttng-sessiond/agent-thread.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 
 #include <common/common.h>
diff --git a/src/bin/lttng-sessiond/agent.c b/src/bin/lttng-sessiond/agent.c
index 5cb8336..dac03c9 100644
--- a/src/bin/lttng-sessiond/agent.c
+++ b/src/bin/lttng-sessiond/agent.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <urcu/uatomic.h>
 
diff --git a/src/bin/lttng-sessiond/buffer-registry.c b/src/bin/lttng-sessiond/buffer-registry.c
index bab1f30..0ff76de 100644
--- a/src/bin/lttng-sessiond/buffer-registry.c
+++ b/src/bin/lttng-sessiond/buffer-registry.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <inttypes.h>
 
 #include <common/common.h>
diff --git a/src/bin/lttng-sessiond/channel.c b/src/bin/lttng-sessiond/channel.c
index 1d04b1f..7ea43b8 100644
--- a/src/bin/lttng-sessiond/channel.c
+++ b/src/bin/lttng-sessiond/channel.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <inttypes.h>
 #include <string.h>
 #include <unistd.h>
diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 17091de..b04f15c 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <inttypes.h>
 #include <urcu/list.h>
diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
index ce3e5da..42738bc 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng-sessiond/context.c b/src/bin/lttng-sessiond/context.c
index 2cc6a30..cd4b85f 100644
--- a/src/bin/lttng-sessiond/context.c
+++ b/src/bin/lttng-sessiond/context.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/bin/lttng-sessiond/event.c b/src/bin/lttng-sessiond/event.c
index 181926b..3db3089 100644
--- a/src/bin/lttng-sessiond/event.c
+++ b/src/bin/lttng-sessiond/event.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <errno.h>
 #include <urcu/list.h>
 #include <string.h>
diff --git a/src/bin/lttng-sessiond/fd-limit.c b/src/bin/lttng-sessiond/fd-limit.c
index a886d33..17a18af 100644
--- a/src/bin/lttng-sessiond/fd-limit.c
+++ b/src/bin/lttng-sessiond/fd-limit.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <urcu/uatomic.h>
 #include <sys/time.h>
 #include <sys/resource.h>
diff --git a/src/bin/lttng-sessiond/ht-cleanup.c b/src/bin/lttng-sessiond/ht-cleanup.c
index a201506..0469f92 100644
--- a/src/bin/lttng-sessiond/ht-cleanup.c
+++ b/src/bin/lttng-sessiond/ht-cleanup.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 
 #include <common/hashtable/hashtable.h>
diff --git a/src/bin/lttng-sessiond/kernel-consumer.c b/src/bin/lttng-sessiond/kernel-consumer.c
index d71f8ce..f634cd3 100644
--- a/src/bin/lttng-sessiond/kernel-consumer.c
+++ b/src/bin/lttng-sessiond/kernel-consumer.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
index 00bfbbc..b742697 100644
--- a/src/bin/lttng-sessiond/kernel.c
+++ b/src/bin/lttng-sessiond/kernel.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng-sessiond/load-session-thread.c b/src/bin/lttng-sessiond/load-session-thread.c
index 868d7c5..3be93cf 100644
--- a/src/bin/lttng-sessiond/load-session-thread.c
+++ b/src/bin/lttng-sessiond/load-session-thread.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <common/error.h>
 #include <common/config/config.h>
 
diff --git a/src/bin/lttng-sessiond/lttng-sessiond.h b/src/bin/lttng-sessiond/lttng-sessiond.h
index d015012..488cf2f 100644
--- a/src/bin/lttng-sessiond/lttng-sessiond.h
+++ b/src/bin/lttng-sessiond/lttng-sessiond.h
@@ -19,7 +19,6 @@
 #ifndef _LTT_SESSIOND_H
 #define _LTT_SESSIOND_H
 
-#define _LGPL_SOURCE
 #include <urcu.h>
 #include <urcu/wfcqueue.h>
 
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 9542e65..a7f77c0 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -18,6 +18,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <getopt.h>
 #include <grp.h>
 #include <limits.h>
diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index a28356b..ebf3664 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c
index aae56a8..b78e7f7 100644
--- a/src/bin/lttng-sessiond/save.c
+++ b/src/bin/lttng-sessiond/save.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <inttypes.h>
 #include <string.h>
diff --git a/src/bin/lttng-sessiond/session.c b/src/bin/lttng-sessiond/session.c
index cd59cb7..99b0165 100644
--- a/src/bin/lttng-sessiond/session.c
+++ b/src/bin/lttng-sessiond/session.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <limits.h>
 #include <inttypes.h>
 #include <stdio.h>
diff --git a/src/bin/lttng-sessiond/shm.c b/src/bin/lttng-sessiond/shm.c
index a5caa8b..e955d12 100644
--- a/src/bin/lttng-sessiond/shm.c
+++ b/src/bin/lttng-sessiond/shm.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <fcntl.h>
 #include <limits.h>
 #include <sys/mman.h>
diff --git a/src/bin/lttng-sessiond/snapshot.c b/src/bin/lttng-sessiond/snapshot.c
index 8faf9a7..1060269 100644
--- a/src/bin/lttng-sessiond/snapshot.c
+++ b/src/bin/lttng-sessiond/snapshot.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <inttypes.h>
 #include <string.h>
diff --git a/src/bin/lttng-sessiond/syscall.c b/src/bin/lttng-sessiond/syscall.c
index b4f2e1e..eb81d67 100644
--- a/src/bin/lttng-sessiond/syscall.c
+++ b/src/bin/lttng-sessiond/syscall.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <common/bitfield.h>
 #include <common/common.h>
 #include <common/kernel-ctl/kernel-ctl.h>
diff --git a/src/bin/lttng-sessiond/trace-kernel.c b/src/bin/lttng-sessiond/trace-kernel.c
index 093297c..1069d1f 100644
--- a/src/bin/lttng-sessiond/trace-kernel.c
+++ b/src/bin/lttng-sessiond/trace-kernel.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index 1f6fd52..511ac90 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 5ebe991..5de7a5a 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <errno.h>
 #include <inttypes.h>
 #include <pthread.h>
diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond/ust-consumer.c
index 4b52d59..f120144 100644
--- a/src/bin/lttng-sessiond/ust-consumer.c
+++ b/src/bin/lttng-sessiond/ust-consumer.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng-sessiond/ust-metadata.c b/src/bin/lttng-sessiond/ust-metadata.c
index f430ae1..3794292 100644
--- a/src/bin/lttng-sessiond/ust-metadata.c
+++ b/src/bin/lttng-sessiond/ust-metadata.c
@@ -20,6 +20,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <stdint.h>
 #include <string.h>
 #include <stdarg.h>
diff --git a/src/bin/lttng-sessiond/ust-registry.c b/src/bin/lttng-sessiond/ust-registry.c
index dc49416..3f4a962 100644
--- a/src/bin/lttng-sessiond/ust-registry.c
+++ b/src/bin/lttng-sessiond/ust-registry.c
@@ -15,6 +15,7 @@
  * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <inttypes.h>
 
diff --git a/src/bin/lttng-sessiond/ust-thread.c b/src/bin/lttng-sessiond/ust-thread.c
index 080afa5..d92c1f9 100644
--- a/src/bin/lttng-sessiond/ust-thread.c
+++ b/src/bin/lttng-sessiond/ust-thread.c
@@ -15,6 +15,7 @@
  * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 
 #include <common/common.h>
diff --git a/src/bin/lttng-sessiond/utils.c b/src/bin/lttng-sessiond/utils.c
index c9c51ed..fef3180 100644
--- a/src/bin/lttng-sessiond/utils.c
+++ b/src/bin/lttng-sessiond/utils.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <stdlib.h>
 #include <unistd.h>
 
diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/commands/add_context.c
index e50ed84..1ba13bf 100644
--- a/src/bin/lttng/commands/add_context.c
+++ b/src/bin/lttng/commands/add_context.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <ctype.h>
 #include <popt.h>
 #include <stdio.h>
diff --git a/src/bin/lttng/commands/calibrate.c b/src/bin/lttng/commands/calibrate.c
index 567f4a5..80b6d39 100644
--- a/src/bin/lttng/commands/calibrate.c
+++ b/src/bin/lttng/commands/calibrate.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <popt.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng/commands/create.c b/src/bin/lttng/commands/create.c
index 4f97c86..1fa6d41 100644
--- a/src/bin/lttng/commands/create.c
+++ b/src/bin/lttng/commands/create.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <ctype.h>
 #include <popt.h>
diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands/destroy.c
index 50d5bb4..95343c9 100644
--- a/src/bin/lttng/commands/destroy.c
+++ b/src/bin/lttng/commands/destroy.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <popt.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng/commands/disable_channels.c b/src/bin/lttng/commands/disable_channels.c
index 27f1db5..96a9e5d 100644
--- a/src/bin/lttng/commands/disable_channels.c
+++ b/src/bin/lttng/commands/disable_channels.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <popt.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng/commands/disable_events.c b/src/bin/lttng/commands/disable_events.c
index e833fe9..9ab8bf0 100644
--- a/src/bin/lttng/commands/disable_events.c
+++ b/src/bin/lttng/commands/disable_events.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <popt.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
index a58ebe0..f8272e9 100644
--- a/src/bin/lttng/commands/enable_channels.c
+++ b/src/bin/lttng/commands/enable_channels.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <popt.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index c4da3df..5ef3490 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <popt.h>
 #include <stdio.h>
diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index 12499ee..f69d34d 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <inttypes.h>
 #include <popt.h>
 #include <stdio.h>
diff --git a/src/bin/lttng/commands/load.c b/src/bin/lttng/commands/load.c
index caa5713..708ef0b 100644
--- a/src/bin/lttng/commands/load.c
+++ b/src/bin/lttng/commands/load.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <inttypes.h>
 #include <popt.h>
 #include <stdio.h>
diff --git a/src/bin/lttng/commands/save.c b/src/bin/lttng/commands/save.c
index 67862a4..43f10dc 100644
--- a/src/bin/lttng/commands/save.c
+++ b/src/bin/lttng/commands/save.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <inttypes.h>
 #include <popt.h>
 #include <stdio.h>
diff --git a/src/bin/lttng/commands/set_session.c b/src/bin/lttng/commands/set_session.c
index fd3d9a1..3196f12 100644
--- a/src/bin/lttng/commands/set_session.c
+++ b/src/bin/lttng/commands/set_session.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <popt.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng/commands/snapshot.c b/src/bin/lttng/commands/snapshot.c
index f3ef3af..4b38edf 100644
--- a/src/bin/lttng/commands/snapshot.c
+++ b/src/bin/lttng/commands/snapshot.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <inttypes.h>
 #include <popt.h>
diff --git a/src/bin/lttng/commands/start.c b/src/bin/lttng/commands/start.c
index 5ca92d8..8016434 100644
--- a/src/bin/lttng/commands/start.c
+++ b/src/bin/lttng/commands/start.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <popt.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng/commands/stop.c b/src/bin/lttng/commands/stop.c
index a72f313..5ac182b 100644
--- a/src/bin/lttng/commands/stop.c
+++ b/src/bin/lttng/commands/stop.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <popt.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng/commands/version.c b/src/bin/lttng/commands/version.c
index f4d8963..a2409c3 100644
--- a/src/bin/lttng/commands/version.c
+++ b/src/bin/lttng/commands/version.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <popt.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng/commands/view.c b/src/bin/lttng/commands/view.c
index dcd4d66..37fb4b8 100644
--- a/src/bin/lttng/commands/view.c
+++ b/src/bin/lttng/commands/view.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <popt.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng/conf.c b/src/bin/lttng/conf.c
index 55ed635..4bcf49e 100644
--- a/src/bin/lttng/conf.c
+++ b/src/bin/lttng/conf.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
index e4a8fd2..7658afc 100644
--- a/src/bin/lttng/lttng.c
+++ b/src/bin/lttng/lttng.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <getopt.h>
 #include <signal.h>
 #include <stdio.h>
diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
index c518405..3cc254a 100644
--- a/src/bin/lttng/utils.c
+++ b/src/bin/lttng/utils.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <stdlib.h>
 #include <ctype.h>
diff --git a/src/common/compat/compat-epoll.c b/src/common/compat/compat-epoll.c
index 368fae1..29bd2f8 100644
--- a/src/common/compat/compat-epoll.c
+++ b/src/common/compat/compat-epoll.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/src/common/compat/compat-fcntl.c b/src/common/compat/compat-fcntl.c
index b462fd7..527abd8 100644
--- a/src/common/compat/compat-fcntl.c
+++ b/src/common/compat/compat-fcntl.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <common/compat/fcntl.h>
 #include <unistd.h>
 
diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-poll.c
index 4893768..3293244 100644
--- a/src/common/compat/compat-poll.c
+++ b/src/common/compat/compat-poll.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <stdlib.h>
 #include <sys/resource.h>
diff --git a/src/common/config/config.c b/src/common/config/config.c
index 971946c..f93c5a6 100644
--- a/src/common/config/config.c
+++ b/src/common/config/config.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <ctype.h>
 #include <stdio.h>
diff --git a/src/common/consumer-metadata-cache.c b/src/common/consumer-metadata-cache.c
index 0f086fe..9cd99e5 100644
--- a/src/common/consumer-metadata-cache.c
+++ b/src/common/consumer-metadata-cache.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <pthread.h>
 #include <stdlib.h>
diff --git a/src/common/consumer-stream.c b/src/common/consumer-stream.c
index 8fe02e7..ba72dce 100644
--- a/src/common/consumer-stream.c
+++ b/src/common/consumer-stream.c
@@ -18,6 +18,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <inttypes.h>
 #include <sys/mman.h>
diff --git a/src/common/consumer-timer.c b/src/common/consumer-timer.c
index 1408052..e7343af 100644
--- a/src/common/consumer-timer.c
+++ b/src/common/consumer-timer.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <inttypes.h>
 #include <signal.h>
diff --git a/src/common/consumer.c b/src/common/consumer.c
index 999e400..e37c725 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -18,6 +18,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <poll.h>
 #include <pthread.h>
diff --git a/src/common/daemonize.c b/src/common/daemonize.c
index a8e2906..b9d0b03 100644
--- a/src/common/daemonize.c
+++ b/src/common/daemonize.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <unistd.h>
 #include <paths.h>
 #include <fcntl.h>
diff --git a/src/common/defaults.c b/src/common/defaults.c
index d74a42b..974f7c6 100644
--- a/src/common/defaults.c
+++ b/src/common/defaults.c
@@ -15,6 +15,8 @@
  * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <stddef.h>
 #include <unistd.h>
 
diff --git a/src/common/error.c b/src/common/error.c
index 852de6f..2cebbf9 100644
--- a/src/common/error.c
+++ b/src/common/error.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <inttypes.h>
 
diff --git a/src/common/futex.c b/src/common/futex.c
index 0b27a5b..7f07b11 100644
--- a/src/common/futex.c
+++ b/src/common/futex.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <limits.h>
 #include <sys/syscall.h>
 #include <unistd.h>
diff --git a/src/common/hashtable/hashtable.c b/src/common/hashtable/hashtable.c
index b08a57e..3a38cbf 100644
--- a/src/common/hashtable/hashtable.c
+++ b/src/common/hashtable/hashtable.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <string.h>
 #include <urcu.h>
diff --git a/src/common/hashtable/rculfhash-mm-chunk.c b/src/common/hashtable/rculfhash-mm-chunk.c
index 7204831..2e4e049 100644
--- a/src/common/hashtable/rculfhash-mm-chunk.c
+++ b/src/common/hashtable/rculfhash-mm-chunk.c
@@ -20,6 +20,8 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <stddef.h>
 #include "rculfhash-internal.h"
 
diff --git a/src/common/hashtable/rculfhash-mm-mmap.c b/src/common/hashtable/rculfhash-mm-mmap.c
index b136e1a..cd415db 100644
--- a/src/common/hashtable/rculfhash-mm-mmap.c
+++ b/src/common/hashtable/rculfhash-mm-mmap.c
@@ -20,6 +20,8 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <unistd.h>
 #include <sys/mman.h>
 #include "rculfhash-internal.h"
diff --git a/src/common/hashtable/rculfhash-mm-order.c b/src/common/hashtable/rculfhash-mm-order.c
index 6e3d29b..0ce98d7 100644
--- a/src/common/hashtable/rculfhash-mm-order.c
+++ b/src/common/hashtable/rculfhash-mm-order.c
@@ -21,6 +21,8 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include "rculfhash-internal.h"
 
 static
diff --git a/src/common/hashtable/utils.c b/src/common/hashtable/utils.c
index 1ea699d..3c6994b 100644
--- a/src/common/hashtable/utils.c
+++ b/src/common/hashtable/utils.c
@@ -49,6 +49,7 @@
  * byte), but shoehorning those bytes into integers efficiently is messy.
  */
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <stdint.h>     /* defines uint32_t etc */
 #include <stdio.h>      /* defines printf for tests */
diff --git a/src/common/health/health.c b/src/common/health/health.c
index 49f6dc0..3eea3ad 100644
--- a/src/common/health/health.c
+++ b/src/common/health/health.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <inttypes.h>
 #include <stdio.h>
diff --git a/src/common/index/index.c b/src/common/index/index.c
index a462a63..35cff53 100644
--- a/src/common/index/index.c
+++ b/src/common/index/index.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <sys/stat.h>
 #include <sys/types.h>
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index cbd1b5a..f2023a6 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <poll.h>
 #include <pthread.h>
diff --git a/src/common/kernel-ctl/kernel-ctl.c b/src/common/kernel-ctl/kernel-ctl.c
index f3ef93d..b223cea 100644
--- a/src/common/kernel-ctl/kernel-ctl.c
+++ b/src/common/kernel-ctl/kernel-ctl.c
@@ -16,6 +16,8 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#define _GNU_SOURCE
+#define _LGPL_SOURCE
 #define __USE_LINUX_IOCTL_DEFS
 #include <sys/ioctl.h>
 #include <string.h>
diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
index 882afc1..752bcec 100644
--- a/src/common/mi-lttng.c
+++ b/src/common/mi-lttng.c
@@ -16,7 +16,8 @@
  * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-
+#define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <include/config.h>
 #include <common/config/config.h>
 #include <lttng/snapshot-internal.h>
diff --git a/src/common/pipe.c b/src/common/pipe.c
index 5e2fc6c..09e905d 100644
--- a/src/common/pipe.c
+++ b/src/common/pipe.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <fcntl.h>
 #include <unistd.h>
diff --git a/src/common/readwrite.c b/src/common/readwrite.c
index d33e051..a862d1c 100644
--- a/src/common/readwrite.c
+++ b/src/common/readwrite.c
@@ -15,6 +15,8 @@
  * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <limits.h>
diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
index 38ebdbd..47db408 100644
--- a/src/common/relayd/relayd.c
+++ b/src/common/relayd/relayd.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/common/runas.c b/src/common/runas.c
index 5ab4271..c146f65 100644
--- a/src/common/runas.c
+++ b/src/common/runas.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <errno.h>
 #include <limits.h>
 #include <stdio.h>
diff --git a/src/common/sessiond-comm/inet.c b/src/common/sessiond-comm/inet.c
index 32a16a6..2703a66 100644
--- a/src/common/sessiond-comm/inet.c
+++ b/src/common/sessiond-comm/inet.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <limits.h>
 #include <stdio.h>
diff --git a/src/common/sessiond-comm/inet6.c b/src/common/sessiond-comm/inet6.c
index 5b137c4..9eab3fa 100644
--- a/src/common/sessiond-comm/inet6.c
+++ b/src/common/sessiond-comm/inet6.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <limits.h>
 #include <stdio.h>
diff --git a/src/common/sessiond-comm/sessiond-comm.c b/src/common/sessiond-comm/sessiond-comm.c
index 65952b2..a985dc7 100644
--- a/src/common/sessiond-comm/sessiond-comm.c
+++ b/src/common/sessiond-comm/sessiond-comm.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <limits.h>
 #include <stdio.h>
diff --git a/src/common/sessiond-comm/unix.c b/src/common/sessiond-comm/unix.c
index 2c87b82..97537c5 100644
--- a/src/common/sessiond-comm/unix.c
+++ b/src/common/sessiond-comm/unix.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <limits.h>
 #include <stdio.h>
diff --git a/src/common/testpoint/testpoint.c b/src/common/testpoint/testpoint.c
index 6893a41..144323e 100644
--- a/src/common/testpoint/testpoint.c
+++ b/src/common/testpoint/testpoint.c
@@ -18,6 +18,7 @@
 #ifndef NTESTPOINT
 
 #define _GNU_SOURCE /* for RTLD_DEFAULT GNU extension */
+#define _LGPL_SOURCE
 #include <dlfcn.h>  /* for dlsym   */
 #include <stdlib.h> /* for getenv  */
 #include <string.h> /* for strncmp */
diff --git a/src/common/uri.c b/src/common/uri.c
index 408b75c..668e617 100644
--- a/src/common/uri.c
+++ b/src/common/uri.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <arpa/inet.h>
 #include <netdb.h>
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index bff360e..52b6979 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -17,6 +17,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <lttng/ust-ctl.h>
 #include <poll.h>
diff --git a/src/common/utils.c b/src/common/utils.c
index 1d07cb3..4e78767 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -18,6 +18,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <ctype.h>
 #include <fcntl.h>
diff --git a/src/lib/lttng-ctl/load.c b/src/lib/lttng-ctl/load.c
index 21619a6..3599503 100644
--- a/src/lib/lttng-ctl/load.c
+++ b/src/lib/lttng-ctl/load.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <string.h>
 
diff --git a/src/lib/lttng-ctl/lttng-ctl-health.c b/src/lib/lttng-ctl/lttng-ctl-health.c
index ba9aac0..83f0925 100644
--- a/src/lib/lttng-ctl/lttng-ctl-health.c
+++ b/src/lib/lttng-ctl/lttng-ctl-health.c
@@ -20,6 +20,8 @@
  * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <unistd.h>
 #include <sys/types.h>
 #include <stdint.h>
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index aae0e4f..d573eb0 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -20,6 +20,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <grp.h>
 #include <errno.h>
diff --git a/src/lib/lttng-ctl/save.c b/src/lib/lttng-ctl/save.c
index d414a9d..8f8cbb6 100644
--- a/src/lib/lttng-ctl/save.c
+++ b/src/lib/lttng-ctl/save.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <string.h>
 
diff --git a/src/lib/lttng-ctl/snapshot.c b/src/lib/lttng-ctl/snapshot.c
index 6b7b8a9..db9c071 100644
--- a/src/lib/lttng-ctl/snapshot.c
+++ b/src/lib/lttng-ctl/snapshot.c
@@ -16,6 +16,7 @@
  */
 
 #define _GNU_SOURCE
+#define _LGPL_SOURCE
 #include <assert.h>
 #include <string.h>
 
-- 
2.1.1
