From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH lttng-tools] Use autoconf AM_MAINTAINER_MODE.
Date: Wed, 12 Mar 2014 10:22:40 +0100
Message-ID: <1394616160-12744-1-git-send-email-larper__18415.9675184221$1394616230$gmane$org@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bastet.se.axis.com ([195.60.68.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <lars.persson@axis.com>) id 1WNfNI-0005EW-BX
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 05:23:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id E4B051819F
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 10:22:50 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id b-oqudXLwyFr for <lttng-dev@lists.lttng.org>;
	Wed, 12 Mar 2014 10:22:48 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id DBB381819E
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 10:22:48 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id BA9FCBCC
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 10:22:48 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id AF47D8BE
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 10:22:48 +0100 (CET)
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
index 614c8d1..26f286b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -4,6 +4,7 @@ AC_CANONICAL_TARGET
 AC_CANONICAL_HOST
 AC_CONFIG_MACRO_DIR([config])
 AM_INIT_AUTOMAKE([foreign dist-bzip2 no-dist-gzip])
+AM_MAINTAINER_MODE([enable])
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
 # Compute minor/major/patchlevel version numbers
-- 
1.7.2.5
