From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix cross-compile
Date: Wed, 7 Nov 2012 15:13:21 -0500
Message-ID: <20121107201321.GA31570__5592.17395862124$1352319240$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TWC03-00047n-9x
	for lttng-dev@lists.lttng.org; Wed, 07 Nov 2012 15:13:23 -0500
Content-Disposition: inline
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

configure.ac should use --target, not --host to get the target info we
want to compile for. --host is for the host that does the build.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/configure.ac b/configure.ac
index a3120fc..49d324e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -313,7 +313,7 @@ AS_ECHO("$version_description")
 AS_ECHO()
 
 # Target architecture we're building for
-target_arch=$host_cpu
+target_arch=$target_cpu
 [
 for f in $CFLAGS; do
         if test $f = "-m32"; then


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
