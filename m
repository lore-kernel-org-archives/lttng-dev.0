From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH v2 lttng-ust] Fix: Java Agent JAR file symlink
	should be created after objects install
Date: Tue,  4 Nov 2014 16:28:19 -0500
Message-ID: <1415136499-3063-1-git-send-email-christian.babeux__38174.6289822788$1415136601$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <christian.babeux@0x80.ca>) id 1XllfL-0000VM-3v
 for lttng-dev@lists.lttng.org; Tue, 04 Nov 2014 16:29:29 -0500
Received: by mail-qa0-f54.google.com with SMTP id u7so10621695qaz.13
 for <lttng-dev@lists.lttng.org>; Tue, 04 Nov 2014 13:29:21 -0800 (PST)
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

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 liblttng-ust-java-agent/java/Makefile.am | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/liblttng-ust-java-agent/java/Makefile.am b/liblttng-ust-java-agent/java/Makefile.am
index 5a406e4..f9344bb 100644
--- a/liblttng-ust-java-agent/java/Makefile.am
+++ b/liblttng-ust-java-agent/java/Makefile.am
@@ -46,7 +46,7 @@ classes += $(pkgpath)/log4j/*.class
 endif
 
 $(jarfile): classnoinst.stamp
-	$(JAR) cfm $(JARFLAGS) $@ $(jarfile_manifest) $(classes) && $(LN_S) $@ $(jarfile_symlink)
+	$(JAR) cfm $(JARFLAGS) $@ $(jarfile_manifest) $(classes) && rm -f $(jarfile_symlink) && $(LN_S) $@ $(jarfile_symlink)
 
 $(jarfile_old): classnoinst.stamp
 	$(JAR) cf $(JARFLAGS) $@ $(pkgpath)/*.class \
@@ -62,11 +62,11 @@ log4j-jni-header.stamp: $(dist_noinst_JAVA)
 
 all-local: $(stamp)
 
-install-data-local:
-	cd $(DESTDIR)/$(jardir); rm -f $(jarfile_symlink); $(LN_S) $(jarfile) $(jarfile_symlink)
+install-data-hook:
+	cd $(DESTDIR)/$(jardir) && rm -f $(jarfile_symlink) && $(LN_S) $(jarfile) $(jarfile_symlink)
 
-uninstall-local:
-	cd $(DESTDIR)/$(jardir); rm -f $(jarfile_symlink)
+uninstall-hook:
+	cd $(DESTDIR)/$(jardir) && rm -f $(jarfile_symlink)
 
 CLEANFILES = $(jarfile) $(jarfile_old) $(pkgpath)/*.class $(pkgpath_old)/*.class $(pkgpath)/jul/*.class \
 	$(pkgpath)/log4j/*.class jul-jni-header.stamp log4j-jni-header.stamp \
-- 
2.1.1
