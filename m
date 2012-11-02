From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Remove dependency to urcu-cds
	in tools tests
Date: Fri,  2 Nov 2012 15:04:02 -0400
Message-ID: <1351883042-23390-1-git-send-email-christian.babeux__26872.6919348866$1351883097$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TUMXM-0008JA-Bq
	for lttng-dev@lists.lttng.org; Fri, 02 Nov 2012 15:04:12 -0400
Received: by mail-ie0-f176.google.com with SMTP id k11so6322736iea.35
	for <lttng-dev@lists.lttng.org>; Fri, 02 Nov 2012 12:04:12 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The -lurcu-cds link flag is not mandatory to link any of the tests.
Also, adding this flag can cause multiple symbol definition errors
when linking statically because the libhashtable contains symbol
names that are also present in urcu-cds.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/tools/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tools/Makefile.am b/tests/tools/Makefile.am
index 56eda3a..cd7ff32 100644
--- a/tests/tools/Makefile.am
+++ b/tests/tools/Makefile.am
@@ -1,7 +1,7 @@
 SUBDIRS = streaming filtering health
 
 AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src -I$(top_srcdir)/tests -g -Wall
-AM_LDFLAGS = -lurcu -lurcu-cds
+AM_LDFLAGS = -lurcu
 
 EXTRA_DIST = runall.sh
 
-- 
1.8.0
