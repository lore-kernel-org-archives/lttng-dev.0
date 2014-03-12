From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH lttng-ust] Use autoconf AM_MAINTAINER_MODE.
Date: Wed, 12 Mar 2014 10:28:49 +0100
Message-ID: <1394616529-18940-1-git-send-email-larper__8936.79984515092$1394616593$gmane$org@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bes.se.axis.com ([195.60.68.10])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <lars.persson@axis.com>) id 1WNfTG-0005Jk-Hy
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 05:29:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 111B02E455
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 10:29:01 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 5p6sn-klLnds for <lttng-dev@lists.lttng.org>;
	Wed, 12 Mar 2014 10:28:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id B11722E452
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 10:28:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 9AE2CBD2
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 10:28:59 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 8F6C38A0
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 10:28:59 +0100 (CET)
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

Give distribution maintainers the option to skip rebuilding
autoconf and automake generated files. The default behaviour
is still to have the rebuild rules enabled.

Signed-off-by: Lars Persson <larper@axis.com>
---
 configure.ac |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index f507883..6dafbc6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -19,6 +19,7 @@ AC_CANONICAL_TARGET
 AC_CANONICAL_HOST
 AC_CONFIG_MACRO_DIR([config])
 AM_INIT_AUTOMAKE([foreign dist-bzip2 no-dist-gzip])
+AM_MAINTAINER_MODE([enable])
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 AC_CONFIG_SRCDIR([include/lttng/tracepoint.h])
 
-- 
1.7.2.5
