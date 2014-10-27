From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 15/24] Add : Compatibility layer for
	stat.h
Date: Mon, 27 Oct 2014 20:49:29 +0000
Message-ID: <1414442926-14381-16-git-send-email-c.briere__21171.840807847$1414443731$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]
 helo=usmailout4.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEY-0007nh-Eo
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:50 -0400
Received: from uscpsbgex3.samsung.com
 (u124.gpu85.samsung.co.kr [203.254.195.124]) by usmailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400KYAF6LP620@usmailout4.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:33 -0400 (EDT)
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

This is required when building from Android NDK,
but not necessary when building from AOSP tree.

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 src/bin/lttng-consumerd/health-consumerd.c         |  2 +-
 src/bin/lttng-consumerd/lttng-consumerd.c          |  2 +-
 src/bin/lttng-relayd/health-relayd.c               |  2 +-
 src/bin/lttng-relayd/live.c                        |  2 +-
 src/bin/lttng-relayd/main.c                        |  2 +-
 src/bin/lttng-sessiond/consumer.c                  |  2 +-
 src/bin/lttng-sessiond/kernel-consumer.c           |  2 +-
 src/bin/lttng-sessiond/main.c                      |  2 +-
 src/bin/lttng-sessiond/save.c                      |  2 +-
 src/bin/lttng-sessiond/session.c                   |  2 +-
 src/bin/lttng-sessiond/shm.c                       |  2 +-
 src/bin/lttng-sessiond/ust-app.c                   |  2 +-
 src/bin/lttng-sessiond/ust-consumer.c              |  2 +-
 src/bin/lttng/commands/add_context.c               |  2 +-
 src/bin/lttng/commands/calibrate.c                 |  2 +-
 src/bin/lttng/commands/create.c                    |  2 +-
 src/bin/lttng/commands/destroy.c                   |  2 +-
 src/bin/lttng/commands/disable_channels.c          |  2 +-
 src/bin/lttng/commands/disable_events.c            |  2 +-
 src/bin/lttng/commands/enable_channels.c           |  2 +-
 src/bin/lttng/commands/enable_events.c             |  2 +-
 src/bin/lttng/commands/set_session.c               |  2 +-
 src/bin/lttng/commands/snapshot.c                  |  2 +-
 src/bin/lttng/commands/start.c                     |  2 +-
 src/bin/lttng/commands/stop.c                      |  2 +-
 src/bin/lttng/commands/version.c                   |  2 +-
 src/bin/lttng/commands/view.c                      |  2 +-
 src/bin/lttng/conf.c                               |  2 +-
 src/common/compat/compat-epoll.c                   |  2 +-
 src/common/compat/stat.h                           | 29 ++++++++++++++++++++++
 src/common/config/config.c                         |  2 +-
 src/common/index/index.c                           |  2 +-
 src/common/kernel-consumer/kernel-consumer.c       |  2 +-
 src/common/relayd/relayd.c                         |  2 +-
 src/common/runas.c                                 |  2 +-
 src/common/sessiond-comm/inet.c                    |  2 +-
 src/common/sessiond-comm/inet6.c                   |  2 +-
 src/common/sessiond-comm/sessiond-comm.c           |  2 +-
 src/common/sessiond-comm/unix.c                    |  2 +-
 src/common/ust-consumer/ust-consumer.c             |  2 +-
 src/common/utils.c                                 |  2 +-
 tests/regression/tools/filtering/gen-ust-events.c  |  2 +-
 tests/regression/tools/live/live_test.c            |  2 +-
 tests/regression/tools/mi/validate_xml.c           |  2 +-
 tests/regression/ust/high-throughput/main.c        |  2 +-
 tests/regression/ust/linking/demo.c                |  2 +-
 tests/regression/ust/multi-session/gen-nevents.c   |  2 +-
 tests/regression/ust/overlap/demo/demo.c           |  2 +-
 tests/unit/test_utils_expand_path.c                |  2 +-
 .../utils/testapp/gen-ust-events/gen-ust-events.c  |  2 +-
 .../testapp/gen-ust-nevents/gen-ust-nevents.c      |  2 +-
 .../utils/testapp/gen-ust-tracef/gen-ust-tracef.c  |  2 +-
 52 files changed, 80 insertions(+), 51 deletions(-)
 create mode 100644 src/common/compat/stat.h

diff --git a/src/bin/lttng-consumerd/health-consumerd.c b/src/bin/lttng-consumerd/health-consumerd.c
index e826d51..5f2415b 100644
--- a/src/bin/lttng-consumerd/health-consumerd.c
+++ b/src/bin/lttng-consumerd/health-consumerd.c
@@ -29,7 +29,7 @@
 #include <sys/resource.h>
 #include <sys/shm.h>
 #include <sys/socket.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <urcu/list.h>
 #include <poll.h>
diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index b57d6df..70605bf 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -30,7 +30,7 @@
 #include <sys/resource.h>
 #include <sys/shm.h>
 #include <sys/socket.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <urcu/list.h>
 #include <poll.h>
diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/health-relayd.c
index 535f151..812fb03 100644
--- a/src/bin/lttng-relayd/health-relayd.c
+++ b/src/bin/lttng-relayd/health-relayd.c
@@ -29,7 +29,7 @@
 #include <sys/resource.h>
 #include <sys/shm.h>
 #include <sys/socket.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <urcu/list.h>
 #include <poll.h>
diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index e1f6486..4163e08 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -29,7 +29,7 @@
 #include <sys/mount.h>
 #include <sys/resource.h>
 #include <sys/socket.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <inttypes.h>
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 6520056..e5f1dde 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -30,7 +30,7 @@
 #include <sys/mount.h>
 #include <sys/resource.h>
 #include <sys/socket.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <inttypes.h>
diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
index ce3e5da..2c21cc4 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <inttypes.h>
diff --git a/src/bin/lttng-sessiond/kernel-consumer.c b/src/bin/lttng-sessiond/kernel-consumer.c
index d71f8ce..33b9159 100644
--- a/src/bin/lttng-sessiond/kernel-consumer.c
+++ b/src/bin/lttng-sessiond/kernel-consumer.c
@@ -19,7 +19,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <unistd.h>
 
 #include <common/common.h>
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 95cfb54..5fe3043 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -32,7 +32,7 @@
 #include <sys/mount.h>
 #include <sys/resource.h>
 #include <sys/socket.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <urcu/uatomic.h>
diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c
index 6135dae..23e1155 100644
--- a/src/bin/lttng-sessiond/save.c
+++ b/src/bin/lttng-sessiond/save.c
@@ -21,7 +21,7 @@
 #include <string.h>
 #include <urcu/uatomic.h>
 #include <unistd.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 
 #include <common/defaults.h>
 #include <common/error.h>
diff --git a/src/bin/lttng-sessiond/session.c b/src/bin/lttng-sessiond/session.c
index 5c371d6..f1d5218 100644
--- a/src/bin/lttng-sessiond/session.c
+++ b/src/bin/lttng-sessiond/session.c
@@ -21,7 +21,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <urcu.h>
 
 #include <common/common.h>
diff --git a/src/bin/lttng-sessiond/shm.c b/src/bin/lttng-sessiond/shm.c
index d6cf3af..e9ed714 100644
--- a/src/bin/lttng-sessiond/shm.c
+++ b/src/bin/lttng-sessiond/shm.c
@@ -22,7 +22,7 @@
 #include <fcntl.h>
 #include <common/compat/limits.h>
 #include <sys/mman.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index f00d292..e85ab76 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -22,7 +22,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <urcu/compiler.h>
diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond/ust-consumer.c
index 9e9d63f..10903f1 100644
--- a/src/bin/lttng-sessiond/ust-consumer.c
+++ b/src/bin/lttng-sessiond/ust-consumer.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <unistd.h>
 #include <inttypes.h>
 
diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/commands/add_context.c
index e50ed84..704e8c1 100644
--- a/src/bin/lttng/commands/add_context.c
+++ b/src/bin/lttng/commands/add_context.c
@@ -21,7 +21,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/src/bin/lttng/commands/calibrate.c b/src/bin/lttng/commands/calibrate.c
index 567f4a5..5c9a43a 100644
--- a/src/bin/lttng/commands/calibrate.c
+++ b/src/bin/lttng/commands/calibrate.c
@@ -21,7 +21,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <inttypes.h>
diff --git a/src/bin/lttng/commands/create.c b/src/bin/lttng/commands/create.c
index 4f97c86..330eb26 100644
--- a/src/bin/lttng/commands/create.c
+++ b/src/bin/lttng/commands/create.c
@@ -22,7 +22,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <time.h>
 #include <unistd.h>
diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands/destroy.c
index 50d5bb4..ac998a7 100644
--- a/src/bin/lttng/commands/destroy.c
+++ b/src/bin/lttng/commands/destroy.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/src/bin/lttng/commands/disable_channels.c b/src/bin/lttng/commands/disable_channels.c
index 27f1db5..4f9f032 100644
--- a/src/bin/lttng/commands/disable_channels.c
+++ b/src/bin/lttng/commands/disable_channels.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <assert.h>
diff --git a/src/bin/lttng/commands/disable_events.c b/src/bin/lttng/commands/disable_events.c
index 1ce687a..74d116a 100644
--- a/src/bin/lttng/commands/disable_events.c
+++ b/src/bin/lttng/commands/disable_events.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <assert.h>
diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
index a58ebe0..4489bd9 100644
--- a/src/bin/lttng/commands/enable_channels.c
+++ b/src/bin/lttng/commands/enable_channels.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <inttypes.h>
diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index 8b1215b..50948fc 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -21,7 +21,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <inttypes.h>
diff --git a/src/bin/lttng/commands/set_session.c b/src/bin/lttng/commands/set_session.c
index fd3d9a1..2fbe398 100644
--- a/src/bin/lttng/commands/set_session.c
+++ b/src/bin/lttng/commands/set_session.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <assert.h>
diff --git a/src/bin/lttng/commands/snapshot.c b/src/bin/lttng/commands/snapshot.c
index f3ef3af..5d38356 100644
--- a/src/bin/lttng/commands/snapshot.c
+++ b/src/bin/lttng/commands/snapshot.c
@@ -22,7 +22,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <assert.h>
diff --git a/src/bin/lttng/commands/start.c b/src/bin/lttng/commands/start.c
index 5ca92d8..444ce9a 100644
--- a/src/bin/lttng/commands/start.c
+++ b/src/bin/lttng/commands/start.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/src/bin/lttng/commands/stop.c b/src/bin/lttng/commands/stop.c
index a72f313..949433c 100644
--- a/src/bin/lttng/commands/stop.c
+++ b/src/bin/lttng/commands/stop.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <assert.h>
diff --git a/src/bin/lttng/commands/version.c b/src/bin/lttng/commands/version.c
index f4d8963..d79317c 100644
--- a/src/bin/lttng/commands/version.c
+++ b/src/bin/lttng/commands/version.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <config.h>
diff --git a/src/bin/lttng/commands/view.c b/src/bin/lttng/commands/view.c
index 6b0f454..a797dc8 100644
--- a/src/bin/lttng/commands/view.c
+++ b/src/bin/lttng/commands/view.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/src/bin/lttng/conf.c b/src/bin/lttng/conf.c
index 5982215..1e052c5 100644
--- a/src/bin/lttng/conf.c
+++ b/src/bin/lttng/conf.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/src/common/compat/compat-epoll.c b/src/common/compat/compat-epoll.c
index 50b85d2..aad9455 100644
--- a/src/common/compat/compat-epoll.c
+++ b/src/common/compat/compat-epoll.c
@@ -21,7 +21,7 @@
 #include <common/compat/limits.h>
 #include <stdlib.h>
 #include <sys/types.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <unistd.h>
 #include <config.h>
 
diff --git a/src/common/compat/stat.h b/src/common/compat/stat.h
new file mode 100644
index 0000000..67da0a6
--- /dev/null
+++ b/src/common/compat/stat.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2014 - Charles Briere <c.briere@samsung.com>
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
+#ifndef _COMPAT_SYS_STAT_H
+#define _COMPAT_SYS_STAT_H
+
+#include <config.h>
+
+# if HAVE_SYS_STAT_H
+#  include <sys/stat.h>
+# elif HAVE_LINUX_STAT_H
+#  include <linux/stat.h>
+# endif /* HAVE_SYS_STAT_H */
+
+#endif /* _COMPAT_SYS_STAT_H */
diff --git a/src/common/config/config.c b/src/common/config/config.c
index e44710b..1b9a457 100644
--- a/src/common/config/config.c
+++ b/src/common/config/config.c
@@ -25,7 +25,7 @@
 #include <dirent.h>
 #include <unistd.h>
 #include <sys/types.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 
 #include <common/defaults.h>
 #include <common/error.h>
diff --git a/src/common/index/index.c b/src/common/index/index.c
index a462a63..f74e245 100644
--- a/src/common/index/index.c
+++ b/src/common/index/index.c
@@ -18,7 +18,7 @@
 
 #define _GNU_SOURCE
 #include <assert.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <fcntl.h>
 
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index cbd1b5a..d898d66 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -27,7 +27,7 @@
 #include <sys/types.h>
 #include <inttypes.h>
 #include <unistd.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 
 #include <bin/lttng-consumerd/health-consumerd.h>
 #include <common/common.h>
diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
index 38ebdbd..b1a8df8 100644
--- a/src/common/relayd/relayd.c
+++ b/src/common/relayd/relayd.c
@@ -20,7 +20,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <inttypes.h>
 
 #include <common/common.h>
diff --git a/src/common/runas.c b/src/common/runas.c
index 5b4c2ec..40304b6 100644
--- a/src/common/runas.c
+++ b/src/common/runas.c
@@ -24,7 +24,7 @@
 #include <string.h>
 #include <sys/wait.h>
 #include <sys/types.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/src/common/sessiond-comm/inet.c b/src/common/sessiond-comm/inet.c
index fb2f097..4c94575 100644
--- a/src/common/sessiond-comm/inet.c
+++ b/src/common/sessiond-comm/inet.c
@@ -21,7 +21,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <errno.h>
diff --git a/src/common/sessiond-comm/inet6.c b/src/common/sessiond-comm/inet6.c
index c0c307f..566d365 100644
--- a/src/common/sessiond-comm/inet6.c
+++ b/src/common/sessiond-comm/inet6.c
@@ -21,7 +21,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <errno.h>
diff --git a/src/common/sessiond-comm/sessiond-comm.c b/src/common/sessiond-comm/sessiond-comm.c
index 2a04a85..abe4493 100644
--- a/src/common/sessiond-comm/sessiond-comm.c
+++ b/src/common/sessiond-comm/sessiond-comm.c
@@ -22,7 +22,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <errno.h>
diff --git a/src/common/sessiond-comm/unix.c b/src/common/sessiond-comm/unix.c
index 0dd7f27..6a54f60 100644
--- a/src/common/sessiond-comm/unix.c
+++ b/src/common/sessiond-comm/unix.c
@@ -22,7 +22,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <errno.h>
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index d5ff6c7..9e1b633 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -25,7 +25,7 @@
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/socket.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <inttypes.h>
 #include <unistd.h>
diff --git a/src/common/utils.c b/src/common/utils.c
index 9a05ea2..eae59cb 100644
--- a/src/common/utils.c
+++ b/src/common/utils.c
@@ -24,7 +24,7 @@
 #include <common/compat/limits.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <inttypes.h>
diff --git a/tests/regression/tools/filtering/gen-ust-events.c b/tests/regression/tools/filtering/gen-ust-events.c
index c789c89..6108ee2 100644
--- a/tests/regression/tools/filtering/gen-ust-events.c
+++ b/tests/regression/tools/filtering/gen-ust-events.c
@@ -21,7 +21,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/tests/regression/tools/live/live_test.c b/tests/regression/tools/live/live_test.c
index d2c9050..02d6144 100644
--- a/tests/regression/tools/live/live_test.c
+++ b/tests/regression/tools/live/live_test.c
@@ -31,7 +31,7 @@
 #include <netdb.h>
 #include <fcntl.h>
 #include <sys/mman.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 
 #include <tap/tap.h>
 #include <lttng/lttng.h>
diff --git a/tests/regression/tools/mi/validate_xml.c b/tests/regression/tools/mi/validate_xml.c
index e3c6350..9e1a62d 100644
--- a/tests/regression/tools/mi/validate_xml.c
+++ b/tests/regression/tools/mi/validate_xml.c
@@ -32,7 +32,7 @@
 #include <dirent.h>
 #include <unistd.h>
 #include <sys/types.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 
 #include <libxml/xmlschemas.h>
 #include <libxml/parser.h>
diff --git a/tests/regression/ust/high-throughput/main.c b/tests/regression/ust/high-throughput/main.c
index 27f95de..5a6989b 100644
--- a/tests/regression/ust/high-throughput/main.c
+++ b/tests/regression/ust/high-throughput/main.c
@@ -22,7 +22,7 @@
 #include <sys/mman.h>
 #include <stdarg.h>
 #include <sys/types.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <fcntl.h>
 #include <common/compat/signal.h>
 #include <string.h>
diff --git a/tests/regression/ust/linking/demo.c b/tests/regression/ust/linking/demo.c
index 2917f26..b167ee1 100644
--- a/tests/regression/ust/linking/demo.c
+++ b/tests/regression/ust/linking/demo.c
@@ -22,7 +22,7 @@
 #include <sys/mman.h>
 #include <stdarg.h>
 #include <sys/types.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <fcntl.h>
 #include <common/compat/signal.h>
 #include <string.h>
diff --git a/tests/regression/ust/multi-session/gen-nevents.c b/tests/regression/ust/multi-session/gen-nevents.c
index c96fdb5..05cffac 100644
--- a/tests/regression/ust/multi-session/gen-nevents.c
+++ b/tests/regression/ust/multi-session/gen-nevents.c
@@ -25,7 +25,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/tests/regression/ust/overlap/demo/demo.c b/tests/regression/ust/overlap/demo/demo.c
index f2a8042..661facf 100644
--- a/tests/regression/ust/overlap/demo/demo.c
+++ b/tests/regression/ust/overlap/demo/demo.c
@@ -22,7 +22,7 @@
 #include <sys/mman.h>
 #include <stdarg.h>
 #include <sys/types.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <fcntl.h>
 #include <common/compat/signal.h>
 #include <string.h>
diff --git a/tests/unit/test_utils_expand_path.c b/tests/unit/test_utils_expand_path.c
index 15e56a1..58961d3 100644
--- a/tests/unit/test_utils_expand_path.c
+++ b/tests/unit/test_utils_expand_path.c
@@ -21,7 +21,7 @@
 #include <stdlib.h>
 #include <common/compat/limits.h>
 
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 
 #include <tap/tap.h>
diff --git a/tests/utils/testapp/gen-ust-events/gen-ust-events.c b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
index 77d88db..759e25e 100644
--- a/tests/utils/testapp/gen-ust-events/gen-ust-events.c
+++ b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
@@ -23,7 +23,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/tests/utils/testapp/gen-ust-nevents/gen-ust-nevents.c b/tests/utils/testapp/gen-ust-nevents/gen-ust-nevents.c
index c7a5e5f..ef24127 100644
--- a/tests/utils/testapp/gen-ust-nevents/gen-ust-nevents.c
+++ b/tests/utils/testapp/gen-ust-nevents/gen-ust-nevents.c
@@ -21,7 +21,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/tests/utils/testapp/gen-ust-tracef/gen-ust-tracef.c b/tests/utils/testapp/gen-ust-tracef/gen-ust-tracef.c
index 1c3493d..cb87e6c 100644
--- a/tests/utils/testapp/gen-ust-tracef/gen-ust-tracef.c
+++ b/tests/utils/testapp/gen-ust-tracef/gen-ust-tracef.c
@@ -23,7 +23,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/stat.h>
+#include <common/compat/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
 
-- 
2.1.2
