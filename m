From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tool 1/2] Fix: out-of-tree build: missing
	xsd file for save-load test execution
Date: Fri, 30 Jan 2015 13:30:10 -0500
Message-ID: <1422642611-28785-1-git-send-email-jonathan.rajotte-julien__5423.83666984296$1422642704$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YHGKy-0004hl-Ht
 for lttng-dev@lists.lttng.org; Fri, 30 Jan 2015 13:30:43 -0500
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

This need to be backported to stable 2.6 and stable 2.5

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/common/config/Makefile.am | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/common/config/Makefile.am b/src/common/config/Makefile.am
index 5acc89d..e36b42f 100644
--- a/src/common/config/Makefile.am
+++ b/src/common/config/Makefile.am
@@ -9,3 +9,17 @@ libconfig_la_LIBADD = $(XML_LIBS)
 xmldir = $(datadir)/xml/lttng
 dist_xml_DATA = session.xsd
 EXTRA_DIST = session.xsd
+
+all-local:
+	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
+		for script in $(EXTRA_DIST); do \
+		cp -f $(srcdir)/$$script $(builddir); \
+		done; \
+	fi
+
+clean-local:
+	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
+		for script in $(EXTRA_DIST); do \
+		rm -f $(builddir)/$$script; \
+		done; \
+	fi
-- 
1.9.1
