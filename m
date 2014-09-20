From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-tools] Fix out-of-tree build
Date: Fri, 19 Sep 2014 21:29:23 -0400
Message-ID: <1411176563-20209-1-git-send-email-simon.marchi__19029.0984850892$1411176610$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.electronicbox.net ([96.127.255.82])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <simon.marchi@polymtl.ca>) id 1XV9UR-0004Bp-To
 for lttng-dev@lists.lttng.org; Fri, 19 Sep 2014 21:29:33 -0400
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

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 tests/regression/tools/mi/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/regression/tools/mi/Makefile.am b/tests/regression/tools/mi/Makefile.am
index 4c77f56..c4081db 100644
--- a/tests/regression/tools/mi/Makefile.am
+++ b/tests/regression/tools/mi/Makefile.am
@@ -1,4 +1,4 @@
-AM_CPPFLAGS = -I$(srcdir)/include
+AM_CPPFLAGS = -I$(top_srcdir)/include
 
 noinst_PROGRAMS = validate_xml extract_xml
 validate_xml_SOURCES = validate_xml.c
-- 
2.1.0
