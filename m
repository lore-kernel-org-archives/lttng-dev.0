From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tool 2/2] Fix: out-of-tree build: missing
	xsd file for mi test execution
Date: Fri, 30 Jan 2015 13:30:11 -0500
Message-ID: <1422642611-28785-2-git-send-email-jonathan.rajotte-julien__19225.521622184$1422642715$gmane$org@efficios.com>
References: <1422642611-28785-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YHGL1-0004hm-9h
 for lttng-dev@lists.lttng.org; Fri, 30 Jan 2015 13:30:46 -0500
In-Reply-To: <1422642611-28785-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

This need to be backported to stable 2.6.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/common/Makefile.am | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

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
-- 
1.9.1
