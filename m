From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu] Fix: typo CPPLAGS in examples Makefile
Date: Mon, 22 Apr 2019 12:04:04 -0400
Message-ID: <20190422160404.10274-1-mjeanson__27864.1411497787$1555949076$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44nrxF1RVRz1K6h
 for <lttng-dev@lists.lttng.org>; Mon, 22 Apr 2019 12:04:16 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E3F091A252C
 for <lttng-dev@lists.lttng.org>; Mon, 22 Apr 2019 12:04:09 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Overriding CPPFLAGS throught the environment was ignored for the
examples.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 doc/examples/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/examples/Makefile.am b/doc/examples/Makefile.am
index 3c3d152..edf00eb 100644
--- a/doc/examples/Makefile.am
+++ b/doc/examples/Makefile.am
@@ -141,7 +141,7 @@ all-local:
 	else \
 		rel_build_subdir="../"; \
 	fi; \
-	$(MAKE) -f dist-files/Makefile CC="$(CC)" CPPFLAGS="$(CPPLAGS)" AM_CPPFLAGS="$(AM_CPPFLAGS) -I"$${rel_src_subdir}/$(top_srcdir)/include/" -I"$${rel_src_subdir}/$(top_srcdir)/src/" -I"$${rel_build_subdir}$(top_builddir)/include/" -I"$${rel_build_subdir}$(top_builddir)/include/src/"" CFLAGS="$(CFLAGS)" AM_CFLAGS="$(AM_CFLAGS)" LDFLAGS="$(LDFLAGS)" AM_LDFLAGS="$(AM_LDFLAGS) -L../../../src/.libs/ -Wl,-rpath "$(PWD)/../../src/.libs/"" AM_V_P="$(AM_V_P)" AM_V_at="$(AM_V_at)" $(AM_MAKEFLAGS) all;
+	$(MAKE) -f dist-files/Makefile CC="$(CC)" CPPFLAGS="$(CPPFLAGS)" AM_CPPFLAGS="$(AM_CPPFLAGS) -I"$${rel_src_subdir}/$(top_srcdir)/include/" -I"$${rel_src_subdir}/$(top_srcdir)/src/" -I"$${rel_build_subdir}$(top_builddir)/include/" -I"$${rel_build_subdir}$(top_builddir)/include/src/"" CFLAGS="$(CFLAGS)" AM_CFLAGS="$(AM_CFLAGS)" LDFLAGS="$(LDFLAGS)" AM_LDFLAGS="$(AM_LDFLAGS) -L../../../src/.libs/ -Wl,-rpath "$(PWD)/../../src/.libs/"" AM_V_P="$(AM_V_P)" AM_V_at="$(AM_V_at)" $(AM_MAKEFLAGS) all;
 
 clean-local:
 	$(AM_V_at)$(MAKE) -f dist-files/Makefile $(AM_MAKEFLAGS) clean; \
-- 
2.17.1
