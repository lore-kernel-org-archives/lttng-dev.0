From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust 3/4] Add silent rules support for docs
Date: Thu, 20 Dec 2018 15:22:41 -0500
Message-ID: <20181220202242.6119-3-mjeanson__14983.658589381$1545337279$gmane$org@efficios.com>
References: <20181220202242.6119-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43LNVN01x1z16cW
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 15:22:51 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id EF732A7BAC
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 15:22:51 -0500 (EST)
In-Reply-To: <20181220202242.6119-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 doc/man/Makefile.am | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/doc/man/Makefile.am b/doc/man/Makefile.am
index fcc4c5c7..f562bfd1 100644
--- a/doc/man/Makefile.am
+++ b/doc/man/Makefile.am
@@ -47,26 +47,35 @@ MAN = $(MAN1) $(MAN3)
 if MAN_PAGES_OPT
 # At this point, we know the user asked to build the man pages.
 if HAVE_ASCIIDOC_XMLTO
+
+asciidoc_verbose = $(asciidoc_verbose_@AM_V@)
+asciidoc_verbose_ = $(asciidoc_verbose_@AM_DEFAULT_V@)
+asciidoc_verbose_0 = @echo "  ASCIIDOC  " $@;
+
+xmlto_verbose = $(xmlto_verbose_@AM_V@)
+xmlto_verbose_ = $(xmlto_verbose_@AM_DEFAULT_V@)
+xmlto_verbose_0 = @echo "  XMLTO     " $@;
+
 # Tools to execute:
-ADOC = $(ASCIIDOC) -f $(ASCIIDOC_CONF) -d manpage \
+ADOC = $(asciidoc_verbose)$(ASCIIDOC) -f $(ASCIIDOC_CONF) -d manpage \
 	-a lttng_version="$(PACKAGE_VERSION)" \
 	-a lttng_ust_register_timeout="@LTTNG_UST_DEFAULT_CONSTRUCTOR_TIMEOUT_MS@"
 
 ADOC_DOCBOOK = $(ADOC) -b docbook
-XTO = $(XMLTO) -m $(XSL_FILE) man
+XTO = $(xmlto_verbose)$(XMLTO) -m $(XSL_FILE) man
 
 # Recipes:
 %.1.xml: $(srcdir)/%.1.txt $(COMMON_DEPS)
 	$(ADOC_DOCBOOK) -o $@ $<
 
 %.1: %.1.xml $(XSL_FILE)
-	$(XTO) $<
+	$(XTO) $< 2>/dev/null
 
 %.3.xml: $(srcdir)/%.3.txt $(COMMON_DEPS)
 	$(ADOC_DOCBOOK) -o $@ $<
 
 %.3: %.3.xml $(XSL_FILE)
-	$(XTO) $<
+	$(XTO) $< 2>/dev/null
 
 # Only clean the generated files if we have the tools to generate them again.
 CLEANFILES = $(MAN_XML) $(MAN)
-- 
2.17.1
