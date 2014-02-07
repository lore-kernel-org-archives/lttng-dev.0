From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Cleanup inconsistent use of spaces
	and tabs in README
Date: Fri,  7 Feb 2014 12:48:51 -0500
Message-ID: <1391795331-866-1-git-send-email-christian.babeux__6918.62878525189$1391795451$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1WBpYj-000101-RC
	for lttng-dev@lists.lttng.org; Fri, 07 Feb 2014 12:49:55 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so6514501qcq.18
	for <lttng-dev@lists.lttng.org>; Fri, 07 Feb 2014 09:49:44 -0800 (PST)
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

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 README | 58 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/README b/README
index 4d70318..b217759 100644
--- a/README
+++ b/README
@@ -11,11 +11,11 @@ Latest development can be found at:
 
 REQUIREMENTS:
 
-	- Linux kernel >= 2.6.27
-	  For epoll() support, at least this version is needed. However, poll() is
-	  also supported by running "./configure --disable-epoll". Using that, the
-	  kernel version can probably be older but we can't provide any guarantee.
-	  Please let us know if you are able to go lower without any problems.
+    - Linux kernel >= 2.6.27
+      For epoll() support, at least this version is needed. However, poll() is
+      also supported by running "./configure --disable-epoll". Using that, the
+      kernel version can probably be older but we can't provide any guarantee.
+      Please let us know if you are able to go lower without any problems.
 
     - liburcu
       Userspace RCU library, by Mathieu Desnoyers and Paul E. McKenney
@@ -61,8 +61,8 @@ REQUIREMENTS:
 
     - For kernel tracing: modprobe
 
-	- bash
-	  Needed for running "make check".
+    - bash
+      Needed for running "make check".
 
 For developers using the git tree:
 
@@ -128,8 +128,8 @@ PACKAGE CONTENTS:
       The LTTng tracing control library.
 
     - libsessiond-comm (internal)
-	  The lttng-sessiond communication library. In order to talk with
-	  lttng-sessiond, this library must be used.
+      The lttng-sessiond communication library. In order to talk with
+      lttng-sessiond, this library must be used.
 
     - libkernel-ctl (internal)
       Kernel tracer control and ioctl definitions.
@@ -137,26 +137,26 @@ PACKAGE CONTENTS:
     - libconsumer (internal)
       Library for Kernel and (optionally) UST trace consumer.
 
-	- libkernel-consumer (internal)
-	  Library for Kernel consumer control
+    - libkernel-consumer (internal)
+      Library for Kernel consumer control
 
-	- libust-consumer (internal)
-	  Library for UST consumer control
+    - libust-consumer (internal)
+      Library for UST consumer control
 
-	- libhashtable (internal)
-	  Library wrapper over URCU hashtables.
+    - libhashtable (internal)
+      Library wrapper over URCU hashtables.
 
-	- libcommon (internal)
-	  Contains multiple useful function call used by the whole tree.
+    - libcommon (internal)
+      Contains multiple useful function call used by the whole tree.
 
-	- libcompat (internal)
-	  Compatibility library mostly for FreeBSD and Linux.
-	
-	- librelayd (internal)
-	  Library for all relayd interactions over the network.
+    - libcompat (internal)
+      Compatibility library mostly for FreeBSD and Linux.
 
-	- lttng-relayd
-	  The relay daemon used for network streaming
+    - librelayd (internal)
+      Library for all relayd interactions over the network.
+
+    - lttng-relayd
+      The relay daemon used for network streaming
 
     - lttng-consumerd
       The consumer daemon which uses libconsumer.
@@ -173,9 +173,9 @@ PACKAGE CONTENTS:
     - tests
       Various test programs.
 
-	- doc
-	  Various documentations and quickstart guide.
+    - doc
+      Various documentations and quickstart guide.
 
-	- extras
-	  Contains extra data such as bash completion file. Python bindings for
-	  liblttng-ctl are also available there.
+    - extras
+      Contains extra data such as bash completion file. Python bindings for
+      liblttng-ctl are also available there.
-- 
1.8.5.2
