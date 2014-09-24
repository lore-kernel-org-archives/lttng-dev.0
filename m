From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-ust] Fix: Wrong CLASSPATH when building
	liblttng-ust-java-agent oot
Date: Wed, 24 Sep 2014 15:44:05 -0400
Message-ID: <1411587845-12232-1-git-send-email-christian.babeux__2181.73896796561$1411587947$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <christian.babeux@0x80.ca>) id 1XWsUK-0007LX-NT
 for lttng-dev@lists.lttng.org; Wed, 24 Sep 2014 15:44:38 -0400
Received: by mail-qc0-f178.google.com with SMTP id x13so4077502qcv.9
 for <lttng-dev@lists.lttng.org>; Wed, 24 Sep 2014 12:44:27 -0700 (PDT)
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
 liblttng-ust-java-agent/java/Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/liblttng-ust-java-agent/java/Makefile.am b/liblttng-ust-java-agent/java/Makefile.am
index c949bf8..01e81e5 100644
--- a/liblttng-ust-java-agent/java/Makefile.am
+++ b/liblttng-ust-java-agent/java/Makefile.am
@@ -43,11 +43,11 @@ $(jarfile_old): classnoinst.stamp
 	$(pkgpath)/jul/*.class $(pkgpath_old)/*.class
 
 jul-jni-header.stamp: $(dist_noinst_JAVA)
-	$(JAVAH) -cp $(CLASSPATH):. -d $(juljniout) $(JAVAHFLAGS) org.lttng.ust.agent.jul.LTTngLogHandler && \
+	$(JAVAH) -cp $(CLASSPATH):$(srcdir) -d $(juljniout) $(JAVAHFLAGS) org.lttng.ust.agent.jul.LTTngLogHandler && \
 	echo "JUL JNI header generated" > jul-jni-header.stamp
 
 log4j-jni-header.stamp: $(dist_noinst_JAVA)
-	$(JAVAH) -cp $(CLASSPATH):. -d $(log4jjniout) $(JAVAHFLAGS) org.lttng.ust.agent.log4j.LTTngLogAppender && \
+	$(JAVAH) -cp $(CLASSPATH):$(srcdir) -d $(log4jjniout) $(JAVAHFLAGS) org.lttng.ust.agent.log4j.LTTngLogAppender && \
 	echo "Log4j JNI header generated" > log4j-jni-header.stamp
 
 all-local: $(stamp)
-- 
2.1.0
