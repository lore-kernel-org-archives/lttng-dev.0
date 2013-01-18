From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [BABELTRACE PATCH] Add missing runall.sh to dist
	packaging
Date: Fri, 18 Jan 2013 11:50:40 -0500
Message-ID: <1358527840-4543-1-git-send-email-yannick.brosseau__37887.8872878433$1358527892$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1TwF9X-0003s9-W0
	for lttng-dev@lists.lttng.org; Fri, 18 Jan 2013 11:50:52 -0500
Received: by mail-ia0-f177.google.com with SMTP id h8so1553204iaa.8
	for <lttng-dev@lists.lttng.org>; Fri, 18 Jan 2013 08:50:47 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 tests/lib/Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/lib/Makefile.am b/tests/lib/Makefile.am
index f7e32c2..e9e264b 100644
--- a/tests/lib/Makefile.am
+++ b/tests/lib/Makefile.am
@@ -12,7 +12,7 @@ noinst_PROGRAMS = test-seeks
 
 test_seeks_SOURCES = test-seeks.c
 
-EXTRA_DIST = README.tap
+EXTRA_DIST = README.tap runall.sh
 
 check-am:
 	./runall.sh
-- 
1.7.10.4
