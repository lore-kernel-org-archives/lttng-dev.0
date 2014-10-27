From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 14/24] Add : Compatibility layer for
	signal.h
Date: Mon, 27 Oct 2014 20:49:29 +0000
Message-ID: <1414442926-14381-15-git-send-email-c.briere__30827.0195070238$1414443490$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]
 helo=usmailout4.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEU-0007nh-JJ
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:46 -0400
Received: from uscpsbgex4.samsung.com
 (u125.gpu85.samsung.co.kr [203.254.195.125]) by usmailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400KYQF6KOX20@usmailout4.samsung.com> for
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

Provide an implementation of sigwaitinfo() if nonexistant

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 configure.ac                                     |  2 ++
 extras/core-handler/crash.c                      |  2 +-
 src/bin/lttng-consumerd/health-consumerd.c       |  2 +-
 src/bin/lttng-consumerd/lttng-consumerd.c        |  2 +-
 src/bin/lttng-relayd/health-relayd.c             |  2 +-
 src/bin/lttng-relayd/live.c                      |  2 +-
 src/bin/lttng-relayd/main.c                      |  2 +-
 src/bin/lttng-sessiond/main.c                    |  2 +-
 src/bin/lttng-sessiond/ust-app.c                 |  2 +-
 src/bin/lttng/lttng.c                            |  2 +-
 src/bin/lttng/utils.c                            |  2 +-
 src/common/compat/Makefile.am                    |  2 +-
 src/common/compat/compat-signal.c                | 44 ++++++++++++++++++++++++
 src/common/compat/signal.h                       | 37 ++++++++++++++++++++
 src/common/consumer-timer.c                      |  4 +--
 src/common/consumer.c                            |  2 +-
 src/common/runas.c                               |  2 +-
 src/common/ust-consumer/ust-consumer.c           |  2 +-
 tests/regression/ust/exit-fast/exit-fast.c       |  2 +-
 tests/regression/ust/high-throughput/main.c      |  2 +-
 tests/regression/ust/linking/demo.c              |  2 +-
 tests/regression/ust/multi-session/gen-nevents.c |  2 +-
 tests/regression/ust/overlap/demo/demo.c         |  2 +-
 23 files changed, 104 insertions(+), 21 deletions(-)
 create mode 100644 src/common/compat/compat-signal.c
 create mode 100644 src/common/compat/signal.h

diff --git a/configure.ac b/configure.ac
index fc08cc6..333d172 100644
--- a/configure.ac
+++ b/configure.ac
@@ -65,6 +65,8 @@ AC_CHECK_HEADERS([ \
 
 AC_CHECK_TYPES([in_port_t], [], [], [[#include <netinet/in.h>]])
 
+AC_CHECK_DECLS([sigwaitinfo],[],[], [[#include <signal.h>]])
+
 # Babeltrace viewer check
 AC_ARG_WITH([babeltrace-bin],
 	AS_HELP_STRING([--with-babeltrace-bin],
diff --git a/extras/core-handler/crash.c b/extras/core-handler/crash.c
index 2b9cf4a..e0f7a8f 100644
--- a/extras/core-handler/crash.c
+++ b/extras/core-handler/crash.c
@@ -16,7 +16,7 @@
  */
 
 
-#include <signal.h>
+#include <common/compat/signal.h>
 
 int main(int argc, char *argv[])
 {
diff --git a/src/bin/lttng-consumerd/health-consumerd.c b/src/bin/lttng-consumerd/health-consumerd.c
index 3af18e7..e826d51 100644
--- a/src/bin/lttng-consumerd/health-consumerd.c
+++ b/src/bin/lttng-consumerd/health-consumerd.c
@@ -21,7 +21,7 @@
 #include <grp.h>
 #include <common/compat/limits.h>
 #include <pthread.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index f1bd287..b57d6df 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -22,7 +22,7 @@
 #include <grp.h>
 #include <common/compat/limits.h>
 #include <pthread.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/health-relayd.c
index 312edd5..535f151 100644
--- a/src/bin/lttng-relayd/health-relayd.c
+++ b/src/bin/lttng-relayd/health-relayd.c
@@ -21,7 +21,7 @@
 #include <grp.h>
 #include <common/compat/limits.h>
 #include <pthread.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index 43fc0fb..e1f6486 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -21,7 +21,7 @@
 #include <grp.h>
 #include <common/compat/limits.h>
 #include <pthread.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 747e023..6520056 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -22,7 +22,7 @@
 #include <grp.h>
 #include <common/compat/limits.h>
 #include <pthread.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 7d6d87f..95cfb54 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -23,7 +23,7 @@
 #include <common/compat/limits.h>
 #include <paths.h>
 #include <pthread.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index f8e9693..f00d292 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -27,7 +27,7 @@
 #include <unistd.h>
 #include <urcu/compiler.h>
 #include <lttng/ust-error.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 
 #include <common/common.h>
 #include <common/sessiond-comm/sessiond-comm.h>
diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
index e4a8fd2..e759e8d 100644
--- a/src/bin/lttng/lttng.c
+++ b/src/bin/lttng/lttng.c
@@ -17,7 +17,7 @@
 
 #define _GNU_SOURCE
 #include <getopt.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
index 78fc830..3793b85 100644
--- a/src/bin/lttng/utils.c
+++ b/src/bin/lttng/utils.c
@@ -22,7 +22,7 @@
 #include <common/compat/limits.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
 
diff --git a/src/common/compat/Makefile.am b/src/common/compat/Makefile.am
index caa076c..5fb04a8 100644
--- a/src/common/compat/Makefile.am
+++ b/src/common/compat/Makefile.am
@@ -10,4 +10,4 @@ endif
 
 libcompat_la_SOURCES = poll.h fcntl.h endian.h mman.h clone.h \
                        socket.h compat-fcntl.c uuid.h tid.h netinet/in.h \
-		       limits.h $(COMPAT)
+		       limits.h compat-signal.c $(COMPAT)
diff --git a/src/common/compat/compat-signal.c b/src/common/compat/compat-signal.c
new file mode 100644
index 0000000..9f69427
--- /dev/null
+++ b/src/common/compat/compat-signal.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C)  2014 - Charles Briere <c.briere@samsung.com>
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
+
+#include <common/compat/signal.h>
+
+#if !HAVE_DECL_SIGWAITINFO
+
+#include <time.h>
+#include <unistd.h>
+#include <common/compat/syscall.h>
+
+#define sigtimedwait(set, info, timeout, n) syscall(__NR_rt_sigtimedwait, set, info, timeout, n)
+
+int sigwaitinfo (sigset_t *__set,
+                siginfo_t *__info)
+{
+	struct timespec timeout = {
+		.tv_sec = 10000,
+		.tv_nsec = 0,
+	};
+	/* Last argument is supposed to be sizeof(sigset_t), but
+	 * sigset_t doesn't have the same definition in kernel source
+	 * and android bionic includes so verification in the syscall
+	 * will fail. This assume _NSIG is correctly defined to the
+	 * number of bits for sigset_t. */
+	return sigtimedwait(__set, __info, &timeout, _NSIG/8 );
+}
+
+#endif
diff --git a/src/common/compat/signal.h b/src/common/compat/signal.h
new file mode 100644
index 0000000..965c9bd
--- /dev/null
+++ b/src/common/compat/signal.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright 2014 (c) - Charles Briere <c.briere@samsung.com>
+ *
+ * signal compatibility layer.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include <signal.h>
+#include <config.h>
+
+#ifndef LTTNG_SIGNAL_H
+#define LTTNG_SIGNAL_H
+
+# if !HAVE_DECL_SIGWAITINFO
+int sigwaitinfo (sigset_t *__set,
+                 siginfo_t *__info);
+
+# endif
+
+#endif
diff --git a/src/common/consumer-timer.c b/src/common/consumer-timer.c
index 1408052..f137daa 100644
--- a/src/common/consumer-timer.c
+++ b/src/common/consumer-timer.c
@@ -19,7 +19,7 @@
 #define _GNU_SOURCE
 #include <assert.h>
 #include <inttypes.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 
 #include <bin/lttng-consumerd/health-consumerd.h>
 #include <common/common.h>
@@ -504,7 +504,7 @@ void *consumer_timer_thread(void *data)
 		health_poll_exit();
 		if (signr == -1) {
 			if (errno != EINTR) {
-				PERROR("sigwaitinfo");
+				PERROR("sigwaitinfo; mask : %x; info : %x", mask, info);
 			}
 			continue;
 		} else if (signr == LTTNG_CONSUMER_SIG_SWITCH) {
diff --git a/src/common/consumer.c b/src/common/consumer.c
index 999e400..68f0cbc 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -28,7 +28,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 
 #include <bin/lttng-consumerd/health-consumerd.h>
 #include <common/common.h>
diff --git a/src/common/runas.c b/src/common/runas.c
index c59d722..5b4c2ec 100644
--- a/src/common/runas.c
+++ b/src/common/runas.c
@@ -28,7 +28,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sched.h>
-#include <sys/signal.h>
+#include <common/compat/signal.h>
 
 #include <common/common.h>
 #include <common/utils.h>
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index bff360e..d5ff6c7 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -30,7 +30,7 @@
 #include <inttypes.h>
 #include <unistd.h>
 #include <urcu/list.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 
 #include <bin/lttng-consumerd/health-consumerd.h>
 #include <common/common.h>
diff --git a/tests/regression/ust/exit-fast/exit-fast.c b/tests/regression/ust/exit-fast/exit-fast.c
index 8642656..4f5e957 100644
--- a/tests/regression/ust/exit-fast/exit-fast.c
+++ b/tests/regression/ust/exit-fast/exit-fast.c
@@ -18,7 +18,7 @@
 /* This test generates a single event and exits.
  */
 
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <string.h>
 #include <sys/types.h>
 #include <unistd.h>
diff --git a/tests/regression/ust/high-throughput/main.c b/tests/regression/ust/high-throughput/main.c
index dbd2998..27f95de 100644
--- a/tests/regression/ust/high-throughput/main.c
+++ b/tests/regression/ust/high-throughput/main.c
@@ -24,7 +24,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <string.h>
 #include <arpa/inet.h>
 #include <stdlib.h>
diff --git a/tests/regression/ust/linking/demo.c b/tests/regression/ust/linking/demo.c
index a02ee80..2917f26 100644
--- a/tests/regression/ust/linking/demo.c
+++ b/tests/regression/ust/linking/demo.c
@@ -24,7 +24,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <string.h>
 #include <arpa/inet.h>
 #include <stdlib.h>
diff --git a/tests/regression/ust/multi-session/gen-nevents.c b/tests/regression/ust/multi-session/gen-nevents.c
index 7add252..c96fdb5 100644
--- a/tests/regression/ust/multi-session/gen-nevents.c
+++ b/tests/regression/ust/multi-session/gen-nevents.c
@@ -19,7 +19,7 @@
 
 #include <arpa/inet.h>
 #include <fcntl.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tests/regression/ust/overlap/demo/demo.c b/tests/regression/ust/overlap/demo/demo.c
index e2b61c2..f2a8042 100644
--- a/tests/regression/ust/overlap/demo/demo.c
+++ b/tests/regression/ust/overlap/demo/demo.c
@@ -24,7 +24,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <signal.h>
+#include <common/compat/signal.h>
 #include <string.h>
 #include <arpa/inet.h>
 #include <stdlib.h>
-- 
2.1.2
