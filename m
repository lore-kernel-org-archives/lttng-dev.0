From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH babeltrace] Fix: Support out of tree builds in
	babeltrace.
Date: Wed, 12 Mar 2014 08:12:46 +0100
Message-ID: <1394608366-28338-1-git-send-email-larper__21577.5526398376$1394608492$gmane$org@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bastet.se.axis.com ([195.60.68.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <lars.persson@axis.com>) id 1WNdMh-0004A2-7P
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 03:14:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id D24F91818E
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 08:13:59 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id Q5X365fvuAcj for <lttng-dev@lists.lttng.org>;
	Wed, 12 Mar 2014 08:13:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 452DD18111
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 08:13:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 2E817B68
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 08:13:59 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 2385DB67
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 08:13:59 +0100 (CET)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Lars Persson <larper@axis.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Lars Persson <larper@axis.com>
---
 formats/lttng-live/Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/formats/lttng-live/Makefile.am b/formats/lttng-live/Makefile.am
index c834699..2c6b0bd 100644
--- a/formats/lttng-live/Makefile.am
+++ b/formats/lttng-live/Makefile.am
@@ -1,4 +1,4 @@
-AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include -I$(top_builddir)/include
+AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include -I$(top_builddir)/include -I$(top_srcdir)
 
 lib_LTLIBRARIES = libbabeltrace-lttng-live.la
 
-- 
1.7.2.5
