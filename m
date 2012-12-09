From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH lttng-modules] Fix possible kernel build errors
	with linux-patches
Date: Sun,  9 Dec 2012 08:58:58 -0600
Message-ID: <1355065138-4272-1-git-send-email-andrew_gabbasov__27065.8506117345$1355065191$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1ThiLZ-0006am-Ra
	for lttng-dev@lists.lttng.org; Sun, 09 Dec 2012 09:59:13 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1ThiLT-0006mw-77 from Andrew_Gabbasov@mentor.com
	for lttng-dev@lists.lttng.org; Sun, 09 Dec 2012 06:59:07 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Kernel sources of version 2.6.32 - 2.6.34 with applied patches
from linux-patches may fail to compile if tracepoint samples
are configured to build. Some part of backported commits
are added to the kernel patches to avoid those errors.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 .../backport-tp-2.6.34-tracepoint-data.patch       |   20 +++++++++++++++++---
 .../backport-tracepoint-data-2.6.32-33.patch       |   20 +++++++++++++++++---
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/linux-patches/backport-tp-2.6.34-tracepoint-data.patch b/linux-patches/backport-tp-2.6.34-tracepoint-data.patch
index 385e87e..0ffd7e1 100644
--- a/linux-patches/backport-tp-2.6.34-tracepoint-data.patch
+++ b/linux-patches/backport-tp-2.6.34-tracepoint-data.patch
@@ -10,9 +10,10 @@ Date:   Sat Sep 1 17:45:09 2012 -0700
     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 
 ---
- include/linux/tracepoint.h |  149 ++++++++++++++++++++++++++++++++++-----------
- kernel/tracepoint.c        |  144 +++++++++++++++++++++++++++++++------------
- 2 files changed, 219 insertions(+), 74 deletions(-)
+ include/linux/tracepoint.h             |  149 +++++++++++++++++++++++++--------
+ kernel/tracepoint.c                    |  144 ++++++++++++++++++++++---------
+ samples/tracepoints/tp-samples-trace.h |    4 +-
+ 3 files changed, 220 insertions(+), 77 deletions(-)
 
 Index: linux/include/linux/tracepoint.h
 ===================================================================
@@ -543,3 +544,16 @@ Index: linux/kernel/tracepoint.c
  EXPORT_SYMBOL_GPL(tracepoint_probe_unregister_noupdate);
  
  /**
+Index: linux/samples/tracepoints/tp-samples-trace.h
+===================================================================
+--- linux.orig/samples/tracepoints/tp-samples-trace.h
++++ linux/samples/tracepoints/tp-samples-trace.h
+@@ -7,7 +7,5 @@
+ DECLARE_TRACE(subsys_event,
+ 	TP_PROTO(struct inode *inode, struct file *file),
+ 	TP_ARGS(inode, file));
+-DECLARE_TRACE(subsys_eventb,
+-	TP_PROTO(void),
+-	TP_ARGS());
++DECLARE_TRACE_NOARGS(subsys_eventb);
+ #endif
diff --git a/linux-patches/backport-tracepoint-data-2.6.32-33.patch b/linux-patches/backport-tracepoint-data-2.6.32-33.patch
index e344bac..e53b476 100644
--- a/linux-patches/backport-tracepoint-data-2.6.32-33.patch
+++ b/linux-patches/backport-tracepoint-data-2.6.32-33.patch
@@ -10,9 +10,10 @@ Date:   Sat Sep 1 17:45:09 2012 -0700
     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 
 ---
- include/linux/tracepoint.h |  141 ++++++++++++++++++++++++++++++++++----------
- kernel/tracepoint.c        |  144 ++++++++++++++++++++++++++++++++-------------
- 2 files changed, 215 insertions(+), 70 deletions(-)
+ include/linux/tracepoint.h             |  141 +++++++++++++++++++++++++-------
+ kernel/tracepoint.c                    |  144 ++++++++++++++++++++++++---------
+ samples/tracepoints/tp-samples-trace.h |    4 +-
+ 3 files changed, 216 insertions(+), 73 deletions(-)
 
 Index: linux/include/linux/tracepoint.h
 ===================================================================
@@ -539,3 +540,16 @@ Index: linux/kernel/tracepoint.c
  EXPORT_SYMBOL_GPL(tracepoint_probe_unregister_noupdate);
  
  /**
+Index: linux/samples/tracepoints/tp-samples-trace.h
+===================================================================
+--- linux.orig/samples/tracepoints/tp-samples-trace.h
++++ linux/samples/tracepoints/tp-samples-trace.h
+@@ -7,7 +7,5 @@
+ DECLARE_TRACE(subsys_event,
+ 	TP_PROTO(struct inode *inode, struct file *file),
+ 	TP_ARGS(inode, file));
+-DECLARE_TRACE(subsys_eventb,
+-	TP_PROTO(void),
+-	TP_ARGS());
++DECLARE_TRACE_NOARGS(subsys_eventb);
+ #endif
-- 
1.7.10.4
