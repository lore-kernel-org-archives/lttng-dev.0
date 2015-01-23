From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] Fix: java-agent: out-of-tree path to
	java manifest
Date: Fri, 23 Jan 2015 13:22:11 -0500
Message-ID: <1422037331-22693-1-git-send-email-jonathan.rajotte-julien__17287.0395392694$1422037437$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YEisg-0000Ge-H0
 for lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 13:22:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E8A5F34027C
 for <lttng-dev@lists.lttng.org>; Fri, 23 Jan 2015 18:22:55 +0000 (UTC)
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

This should also be backported to stable-2.6.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 liblttng-ust-java-agent/java/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/liblttng-ust-java-agent/java/Makefile.am b/liblttng-ust-java-agent/java/Makefile.am
index bcf6abe..399b533 100644
--- a/liblttng-ust-java-agent/java/Makefile.am
+++ b/liblttng-ust-java-agent/java/Makefile.am
@@ -4,7 +4,7 @@ pkgpath = org/lttng/ust/agent
 pkgpath_old = org/lttng/ust/jul
 
 jarfile_version = 1.0.0
-jarfile_manifest = $(pkgpath)/Manifest.txt
+jarfile_manifest = $(srcdir)/$(pkgpath)/Manifest.txt
 jarfile_symlink = liblttng-ust-agent.jar
 jarfile = liblttng-ust-agent-$(jarfile_version).jar
 
-- 
1.9.1
