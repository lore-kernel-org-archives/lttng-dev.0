From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-ust] Fix: Java Agent JAR file symlink
	should be created after objects install
Date: Tue,  4 Nov 2014 15:40:47 -0500
Message-ID: <1415133647-18866-1-git-send-email-christian.babeux__20590.0309644223$1415133714$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <christian.babeux@0x80.ca>) id 1XlkuT-0000C9-1Q
 for lttng-dev@lists.lttng.org; Tue, 04 Nov 2014 15:41:04 -0500
Received: by mail-qc0-f181.google.com with SMTP id w7so11420785qcr.26
 for <lttng-dev@lists.lttng.org>; Tue, 04 Nov 2014 12:40:55 -0800 (PST)
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
 liblttng-ust-java-agent/java/Makefile.am | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/liblttng-ust-java-agent/java/Makefile.am b/liblttng-ust-java-agent/java/Makefile.am
index 5a406e4..42b3ede 100644
--- a/liblttng-ust-java-agent/java/Makefile.am
+++ b/liblttng-ust-java-agent/java/Makefile.am
@@ -46,7 +46,7 @@ classes += $(pkgpath)/log4j/*.class
 endif
 
 $(jarfile): classnoinst.stamp
-	$(JAR) cfm $(JARFLAGS) $@ $(jarfile_manifest) $(classes) && $(LN_S) $@ $(jarfile_symlink)
+	$(JAR) cfm $(JARFLAGS) $@ $(jarfile_manifest) $(classes) && rm -f $(jarfile_symlink); $(LN_S) $@ $(jarfile_symlink)
 
 $(jarfile_old): classnoinst.stamp
 	$(JAR) cf $(JARFLAGS) $@ $(pkgpath)/*.class \
@@ -62,10 +62,10 @@ log4j-jni-header.stamp: $(dist_noinst_JAVA)
 
 all-local: $(stamp)
 
-install-data-local:
+install-data-hook:
 	cd $(DESTDIR)/$(jardir); rm -f $(jarfile_symlink); $(LN_S) $(jarfile) $(jarfile_symlink)
 
-uninstall-local:
+uninstall-hook:
 	cd $(DESTDIR)/$(jardir); rm -f $(jarfile_symlink)
 
 CLEANFILES = $(jarfile) $(jarfile_old) $(pkgpath)/*.class $(pkgpath_old)/*.class $(pkgpath)/jul/*.class \
-- 
2.1.1
