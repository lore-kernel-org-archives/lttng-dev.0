From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: add subdir-objects to
	Makefile.am
Date: Thu, 17 Sep 2015 15:09:10 -0400
Message-ID: <1442516950-22760-1-git-send-email-mathieu.desnoyers__15532.6369953857$1442517048$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZceYb-000728-RX
 for lttng-dev@lists.lttng.org; Thu, 17 Sep 2015 15:09:31 -0400
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

Fixes the following warning introduced by the runas worker changes. Use
the same technique used in src/bin/lttng/Makefile.am.

src/common/Makefile.am:17: warning: source file 'sessiond-comm/unix.c' is in a subdirectory,
src/common/Makefile.am:17: but option 'subdir-objects' is disabled
automake: warning: possible forward-incompatibility.
automake: At least a source file is in a subdirectory, but the 'subdir-objects'
automake: automake option hasn't been enabled.  For now, the corresponding output
automake: object file(s) will be placed in the top-level directory.  However,
automake: this behaviour will change in future Automake versions: they will
automake: unconditionally cause object files to be placed in the same subdirectory
automake: of the corresponding sources.
automake: You are advised to start using 'subdir-objects' option throughout your
automake: project, to avoid future incompatibilities.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/common/Makefile.am b/src/common/Makefile.am
index 64110e6..5b71612 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -1,5 +1,7 @@
 AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
 
+AUTOMAKE_OPTIONS = subdir-objects
+
 SUBDIRS = compat health hashtable kernel-ctl sessiond-comm relayd \
 		  kernel-consumer ust-consumer testpoint index config
 
-- 
2.1.4
