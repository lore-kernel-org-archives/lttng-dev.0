From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2.4] Fix: relayd should listen for
	viewers on localhost only by default
Date: Fri, 28 Feb 2014 08:33:49 -0500
Message-ID: <1393594429-23262-1-git-send-email-mathieu.desnoyers__17161.5867912353$1393594511$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1WJNZn-00048G-4h
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 08:34:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 2FF82340220
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 13:34:08 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Having relayd listening by default on 0.0.0.0 (all interfaces) with a
protocol without authentication is an information leak waiting to
happen.

Users should explicitely specify if they want to listen on all
interfaces, using e.g. -L tcp://0.0.0.0:5344 (see lttng-relayd(8)
manpage for details). They should only do so if they use a firewall, or
are within a secured network.

Fixes #746

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 doc/man/lttng-relayd.8              |   20 +++++++++++++-------
 src/bin/lttng-relayd/main.c         |   15 +++++++++------
 src/bin/lttng-sessiond/jul-thread.c |    3 ++-
 src/common/defaults.h               |    8 +++++++-
 4 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/doc/man/lttng-relayd.8 b/doc/man/lttng-relayd.8
index e75711a..1e1e664 100644
--- a/doc/man/lttng-relayd.8
+++ b/doc/man/lttng-relayd.8
@@ -17,12 +17,18 @@ It's tracers help tracking down performance issues and debugging problems
 involving multiple concurrent processes and threads. Tracing across multiple
 systems is also possible.
 
-The relay daemon listens on the network and receives traces streamed by a
-remote consumer. This daemon does not require any particular permissions as
-long as it can write in the output folder and listen on the ports.
-
-Once a trace has been streamed completely, the trace can be processed by any
-tool that can process a local LTTng CTF trace.
+The relay daemon listens by default on all network interfaces to gather
+trace data, but only on localhost for viewer connections. This daemon
+does not require any particular permissions as long as it can write in
+the output folder and listen on the ports. If a user is within a secured
+network and/or has proper firewall settings, lttng-relayd can listen to
+viewer connections from all network interfaces by specifying '-L
+tcp://0.0.0.0:5344'.
+
+Traces can be either viewed "live" (as they are produced) by attaching
+to the live viewer port using LTTng live protocol, or after tracing has
+been stopped. Once a trace has been streamed completely, the trace can
+be processed by any tool that can process a local LTTng CTF trace.
 
 By default, the relayd outputs the traces in :
 ~/lttng-traces/hostname/session-name/domain-name
@@ -63,7 +69,7 @@ Control port URL (tcp://0.0.0.0:5342 is the default)
 Data port URL (tcp://0.0.0.0:5343 is the default)
 .TP
 .BR "-L, --live-port URL"
-Live view port URL (tcp://0.0.0.0:5344 is the default).
+Live view port URL (tcp://localhost:5344 is the default).
 .TP
 .BR "-o, --output"
 Output base directory. Must use an absolute path (~/lttng-traces is the default)
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 60b6bf2..53eaca2 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -382,8 +382,9 @@ int set_options(int argc, char **argv)
 
 	/* assign default values */
 	if (control_uri == NULL) {
-		ret = asprintf(&default_address, "tcp://0.0.0.0:%d",
-				DEFAULT_NETWORK_CONTROL_PORT);
+		ret = asprintf(&default_address,
+			"tcp://" DEFAULT_NETWORK_CONTROL_BIND_ADDRESS ":%d",
+			DEFAULT_NETWORK_CONTROL_PORT);
 		if (ret < 0) {
 			PERROR("asprintf default data address");
 			goto exit;
@@ -397,8 +398,9 @@ int set_options(int argc, char **argv)
 		}
 	}
 	if (data_uri == NULL) {
-		ret = asprintf(&default_address, "tcp://0.0.0.0:%d",
-				DEFAULT_NETWORK_DATA_PORT);
+		ret = asprintf(&default_address,
+			"tcp://" DEFAULT_NETWORK_DATA_BIND_ADDRESS ":%d",
+			DEFAULT_NETWORK_DATA_PORT);
 		if (ret < 0) {
 			PERROR("asprintf default data address");
 			goto exit;
@@ -412,8 +414,9 @@ int set_options(int argc, char **argv)
 		}
 	}
 	if (live_uri == NULL) {
-		ret = asprintf(&default_address, "tcp://0.0.0.0:%d",
-				DEFAULT_NETWORK_VIEWER_PORT);
+		ret = asprintf(&default_address,
+			"tcp://" DEFAULT_NETWORK_VIEWER_BIND_ADDRESS ":%d",
+			DEFAULT_NETWORK_VIEWER_PORT);
 		if (ret < 0) {
 			PERROR("asprintf default viewer control address");
 			goto exit;
diff --git a/src/bin/lttng-sessiond/jul-thread.c b/src/bin/lttng-sessiond/jul-thread.c
index 9c924ea..d8748f2 100644
--- a/src/bin/lttng-sessiond/jul-thread.c
+++ b/src/bin/lttng-sessiond/jul-thread.c
@@ -34,7 +34,8 @@
  * can let the user define a custom one. However, localhost is ALWAYS the
  * default listening address.
  */
-static const char *default_reg_uri = "tcp://localhost";
+static const char *default_reg_uri =
+	"tcp://" DEFAULT_NETWORK_VIEWER_BIND_ADDRESS;
 
 /*
  * Update JUL application using the given socket. This is done just after
diff --git a/src/common/defaults.h b/src/common/defaults.h
index 31ea734..8a79874 100644
--- a/src/common/defaults.h
+++ b/src/common/defaults.h
@@ -209,7 +209,13 @@
  */
 #define DEFAULT_SEM_WAIT_TIMEOUT            30    /* in seconds */
 
-/* Default network ports for trace streaming support */
+/* Default bind addresses for network services. */
+#define DEFAULT_NETWORK_CONTROL_BIND_ADDRESS    "0.0.0.0"
+#define DEFAULT_NETWORK_DATA_BIND_ADDRESS       "0.0.0.0"
+#define DEFAULT_NETWORK_VIEWER_BIND_ADDRESS     "localhost"
+#define DEFAULT_JUL_BIND_ADDRESS                "localhost"
+
+/* Default network ports for trace streaming support. */
 #define DEFAULT_NETWORK_CONTROL_PORT        5342
 #define DEFAULT_NETWORK_DATA_PORT           5343
 #define DEFAULT_NETWORK_VIEWER_PORT         5344
-- 
1.7.10.4
