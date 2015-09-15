From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: add missing test file to
	EXTRA_DIST
Date: Tue, 15 Sep 2015 10:37:48 -0400
Message-ID: <1442327868-9659-1-git-send-email-mjeanson__14497.4188217477$1442327965$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZbrN4-0007pH-Lb
 for lttng-dev@lists.lttng.org; Tue, 15 Sep 2015 10:38:15 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 tests/regression/tools/save-load/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/regression/tools/save-load/Makefile.am b/tests/regression/tools/save-load/Makefile.am
index 6b496be..d6a6ae3 100644
--- a/tests/regression/tools/save-load/Makefile.am
+++ b/tests/regression/tools/save-load/Makefile.am
@@ -1,5 +1,6 @@
 noinst_SCRIPTS = test_save test_load
-EXTRA_DIST = $(noinst_SCRIPTS) load-42.lttng load-42-complex.lttng
+EXTRA_DIST = $(noinst_SCRIPTS) load-42.lttng load-42-complex.lttng \
+	     load-42-trackers.lttng
 
 all-local:
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
-- 
1.9.1
