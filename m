From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tool] Fix: out-of-tree build: missing xsd
	file for mi tests and save-load tests
Date: Wed, 28 Jan 2015 16:45:29 -0500
Message-ID: <1422481529-5558-1-git-send-email-jonathan.rajotte-julien__35431.140746414$1422481631$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YGaQn-0008Gv-Jh
 for lttng-dev@lists.lttng.org; Wed, 28 Jan 2015 16:45:57 -0500
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/common/Makefile.am        | 14 ++++++++++++++
 src/common/config/Makefile.am | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/src/common/Makefile.am b/src/common/Makefile.am
index 3a2f4f0..97d0ecc 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -41,3 +41,17 @@ if HAVE_LIBLTTNG_UST_CTL
 libconsumer_la_LIBADD += \
 		$(top_builddir)/src/common/ust-consumer/libust-consumer.la
 endif
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
