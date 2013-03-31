From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-tools] Fix link: move -lrt at the end of
	the link line
Date: Sun, 31 Mar 2013 14:40:18 -0400
Message-ID: <1364755218-27374-1-git-send-email-simon.marchi__13851.3222606436$1364755258$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.electronicbox.net ([96.127.255.83])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1UMNAr-00024J-W0
	for lttng-dev@lists.lttng.org; Sun, 31 Mar 2013 14:40:14 -0400
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

It has to be after libconsumer.la.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 src/bin/lttng-consumerd/Makefile.am |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-consumerd/Makefile.am b/src/bin/lttng-consumerd/Makefile.am
index a418eb4..d340c68 100644
--- a/src/bin/lttng-consumerd/Makefile.am
+++ b/src/bin/lttng-consumerd/Makefile.am
@@ -4,10 +4,11 @@ lttnglibexec_PROGRAMS = lttng-consumerd
 
 lttng_consumerd_SOURCES = lttng-consumerd.c lttng-consumerd.h
 
-lttng_consumerd_LDADD = -lrt \
+lttng_consumerd_LDADD = \
 	   $(top_builddir)/src/common/libconsumer.la \
 	   $(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la \
-	   $(top_builddir)/src/common/libcommon.la
+	   $(top_builddir)/src/common/libcommon.la \
+	   -lrt
 
 if HAVE_LIBLTTNG_UST_CTL
 lttng_consumerd_LDADD += -llttng-ust-ctl
-- 
1.7.10.4
