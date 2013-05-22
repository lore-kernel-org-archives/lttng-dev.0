From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-ust] Add parameter -f to rm in Makefile
	clean target
Date: Wed, 22 May 2013 13:18:34 -0400
Message-ID: <1369243114-26735-1-git-send-email-simon.marchi__44911.3044458956$1369243250$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.electronicbox.net ([96.127.255.83])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1UfCgQ-0002nB-Bs
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 13:18:38 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

If the files we want to delete do not exist (for example after a failed
build), the make clean fails.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 liblttng-ust-java/Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/liblttng-ust-java/Makefile.am b/liblttng-ust-java/Makefile.am
index 4c998dc..57b9532 100644
--- a/liblttng-ust-java/Makefile.am
+++ b/liblttng-ust-java/Makefile.am
@@ -11,8 +11,8 @@ liblttng_ust_java_la_LIBADD = -lc -L$(top_builddir)/liblttng-ust/.libs -llttng-u
 all: LTTngUst.class org_lttng_ust_LTTngUst.h liblttng-ust-java.jar
 
 clean-local:
-	rm org_lttng_ust_LTTngUst.h
-	rm liblttng-ust-java.jar
+	rm -f org_lttng_ust_LTTngUst.h
+	rm -f liblttng-ust-java.jar
 	rm -rf org/
 
 LTTngUst.c: org_lttng_ust_LTTngUst.h
-- 
1.8.1.2
