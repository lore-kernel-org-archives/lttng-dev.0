From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH babeltrace] Use autoconf AM_MAINTAINER_MODE.
Date: Wed, 12 Mar 2014 10:05:17 +0100
Message-ID: <1394615117-2388-1-git-send-email-larper__16526.1050024585$1394615205$gmane$org@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bastet.se.axis.com ([195.60.68.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <lars.persson@axis.com>) id 1WNf6i-000550-H7
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 05:05:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 115511819A
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 10:05:43 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 2XmRvYgW9wlH for <lttng-dev@lists.lttng.org>;
	Wed, 12 Mar 2014 10:05:41 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 96BF01816E
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 10:05:41 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 7F8CDBD4
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 10:05:41 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 7469770F
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 10:05:41 +0100 (CET)
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
index 7a98612..faa3f98 100644
--- a/configure.ac
+++ b/configure.ac
@@ -11,6 +11,7 @@ AC_CONFIG_AUX_DIR([config])
 AC_CANONICAL_TARGET
 AC_CANONICAL_HOST
 AM_INIT_AUTOMAKE([foreign dist-bzip2 no-dist-gzip])
+AM_MAINTAINER_MODE([enable])
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
 AC_CONFIG_MACRO_DIR([m4])
-- 
1.7.2.5
