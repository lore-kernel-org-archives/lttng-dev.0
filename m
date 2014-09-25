From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-ust] Fix: Wrong CLASSPATH when building
	liblttng-ust-java oot
Date: Thu, 25 Sep 2014 12:07:32 -0400
Message-ID: <1411661252-28088-1-git-send-email-christian.babeux__39810.4695989334$1411661345$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <christian.babeux@0x80.ca>) id 1XXBaQ-0006tn-Oy
 for lttng-dev@lists.lttng.org; Thu, 25 Sep 2014 12:08:10 -0400
Received: by mail-qg0-f44.google.com with SMTP id f51so7950365qge.31
 for <lttng-dev@lists.lttng.org>; Thu, 25 Sep 2014 09:08:00 -0700 (PDT)
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
 liblttng-ust-java/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/liblttng-ust-java/Makefile.am b/liblttng-ust-java/Makefile.am
index 203a9ff..fee9b7d 100644
--- a/liblttng-ust-java/Makefile.am
+++ b/liblttng-ust-java/Makefile.am
@@ -20,7 +20,7 @@ $(jarfile): classnoinst.stamp
 org_lttng_ust_LTTngUst.h: jni-header.stamp
 
 jni-header.stamp: $(dist_noinst_JAVA)
-	$(JAVAH) -cp . $(JAVAHFLAGS) org.lttng.ust.LTTngUst && \
+	$(JAVAH) -cp $(srcdir) $(JAVAHFLAGS) org.lttng.ust.LTTngUst && \
 	echo "JNI header generated" > jni-header.stamp
 
 all-local: org_lttng_ust_LTTngUst.h
-- 
2.1.0
