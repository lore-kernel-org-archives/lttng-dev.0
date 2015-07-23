From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust 2/2] Doc: add LTTNG_UST_CLOCK_PLUGIN
	to man page
Date: Thu, 23 Jul 2015 13:59:56 -0400
Message-ID: <1437674396-13934-2-git-send-email-jonathan.rajotte-julien__29699.4748212912$1437674469$gmane$org@efficios.com>
References: <1437674396-13934-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZIKmy-0005mP-PP
 for lttng-dev@lists.lttng.org; Thu, 23 Jul 2015 14:00:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0255F340419
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2015 18:00:09 +0000 (UTC)
In-Reply-To: <1437674396-13934-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Also add indications on how to use the plugin with lttng-tools.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 doc/examples/clock-override/README | 4 ++++
 doc/man/lttng-ust.3                | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/doc/examples/clock-override/README b/doc/examples/clock-override/README
index e3ddf22..e6c0c80 100644
--- a/doc/examples/clock-override/README
+++ b/doc/examples/clock-override/README
@@ -2,3 +2,7 @@ This clock override example shows how to implement and load a clock
 override plugin for LTTng-UST. This can be useful in cases where direct
 hardware access is available for architecture-specific clocks, and where
 it should be used rather than the Linux kernel Monotonic clock.
+
+When using LTTng-tools keep in mind that lttng-sessiond uses lttng-ust clock
+definition and functions. Thus LTTNG_UST_CLOCK_PLUGIN need to be define when
+launching lttng-sessiond.
diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
index 829f7ae..e16efea 100644
--- a/doc/man/lttng-ust.3
+++ b/doc/man/lttng-ust.3
@@ -502,6 +502,11 @@ Used by the getcpu override plugin system. The environment variable is used to
 provide the path of the shared object who will act as the getcpu override
 plugin. Example can be found under doc/example/getcpu-override .
 .PP
+.IP "LTTNG_UST_CLOCK_PLUGIN"
+Used by the clock override plugin system. The environment variable is used to
+provide the path of the shared object who will act as the clock override
+plugin. Example can be found under doc/example/clock-override .
+.PP
 
 .SH "SEE ALSO"
 
-- 
2.1.4
