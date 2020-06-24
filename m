Return-Path: <SRS0=H5el=AF=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7983C433DF
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Jun 2020 16:10:07 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F738206F7
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Jun 2020 16:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="iZB96mrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F738206F7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49sSlx6624z13PY;
	Wed, 24 Jun 2020 12:10:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593015006;
	bh=BaVx4LaQmWeYd3Ra7XbURBD/jPX7/X4aBe8FCVvHE9U=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=iZB96mrn5hUbj4WRdKFetAq55/737TQ9hwGyOHOhhY21PhFHDLKWpio7Wz/NOMM6w
	 KOfyVWFbLuCmeLc+PV6El1/cyqoGzsq7hGP7HzWx7C0E4/2Y1b+S5Sxj9n0nFL84zX
	 bmS6w0YztjI5t1/GOg6x6Ot6QWBvhfobBnXhUjyIHS8T6ObnCt7cQm4/iyzxc43Ebj
	 4dnLTVF/hY8Oxm5IHMdO6Aq5Y2MhfiKZWvoqXLhEBePu3kM90fkIw1tdXDRb2HKqIA
	 Mvrt8T2Hm+toSvDqm7yEWaDDHcV2C9Pzt/fpyIsDYAxlr4UcPwEOvwWHc83XXrrVqO
	 uMaTqKVvsvevw==
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by lists.lttng.org (Postfix) with ESMTPS id 49sSlw5PsJz13S0
 for <lttng-dev@lists.lttng.org>; Wed, 24 Jun 2020 12:10:04 -0400 (EDT)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-ZtnK3X6WPz22vhq1asPl6g-1; Wed, 24 Jun 2020 12:09:40 -0400
X-MC-Unique: ZtnK3X6WPz22vhq1asPl6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FC38804001
 for <lttng-dev@lists.lttng.org>; Wed, 24 Jun 2020 16:09:39 +0000 (UTC)
Received: from localhost (ovpn-114-150.ams2.redhat.com [10.36.114.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFFD15DAA0;
 Wed, 24 Jun 2020 16:09:35 +0000 (UTC)
To: lttng-dev@lists.lttng.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 24 Jun 2020 17:09:34 +0100
Message-ID: <20200624160934.205881-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Subject: [lttng-dev] [PATCH] Fix: tracepoint.h: define SDT_USE_VARIADIC in
 pkg-config CFLAGS
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Stefan Hajnoczi via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200624160934.Q2ULwh9r1YF3NNwY3eGywsu5dV1_SnsPIV0faIZvky4@z>

LTTng Userspace Tracer 2.11 with sdt enabled can break builds of
applications that include <sys/sdt.h> themselves. QEMU
(https://qemu.org/) is one example.

When applications include <sys/sdt.h> themselves before LTTng Userspace
Tracer header files and the SDT_USE_VARIADIC macro is not defined,
compilation fails due to the absense of STAP_PROBEV() macro that LTTng
Userspace Tracer requires.

Define SDT_USE_VARIADIC in the pkg-config file so that all compilation
units that use LTTng Userspace Tracer are guaranteed to have the macro
defined even if <sys/sdt.h> is included elsewhere before LTTng Userspace
Tracer header files.

In other words, define SDT_USE_VARIADIC on the compiler command-line
instead of in <lttng/tracepoint.h>. This way it will always been defined
when <sys/sdt.h> is included.

Make sure to define SDT_USE_VARIADIC when <lttng/tracepoint.h> is
included without it. This happens when applications do not use
pkg-config.

Fixes: b2f60c7986bb69f81b79b68f1bfe83aafa3278a7 ("Add sdt.h integration")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Warning: this patch doesn't work yet. SDT_CFLAGS also needs to be passed
into LTTng Userspace Tracer's own CFLAGS so that compilation can
succeed. I don't know the autoconf/automake syntax to do this and wanted
to see what you think of this solution before investing more time.
---
 include/lttng/tracepoint.h | 2 ++
 configure.ac               | 2 ++
 lttng-ust.pc.in            | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
index 7cfae3e4..6b699373 100644
--- a/include/lttng/tracepoint.h
+++ b/include/lttng/tracepoint.h
@@ -35,7 +35,9 @@
 #include <lttng/ust-compiler.h>
 
 #ifdef LTTNG_UST_HAVE_SDT_INTEGRATION
+#ifndef SDT_USE_VARIADIC
 #define SDT_USE_VARIADIC
+#endif
 #include <sys/sdt.h>
 #define LTTNG_STAP_PROBEV STAP_PROBEV
 #else
diff --git a/configure.ac b/configure.ac
index eb1bb3e6..bb3eeb60 100644
--- a/configure.ac
+++ b/configure.ac
@@ -427,6 +427,7 @@ AS_IF([test "x$with_sdt" = "xyes"], [
 	]])], [
 		AC_MSG_RESULT([yes])
 		AC_DEFINE([LTTNG_UST_HAVE_SDT_INTEGRATION], [1])
+		SDT_CFLAGS="-DSDT_USE_VARIADIC"
 	], [
 		AC_MSG_RESULT([no])
 		AC_MSG_ERROR([The sdt.h integration was requested but the STAP_PROBEV define cannot be used. Make sure it is installed, and up to date, or use CPPFLAGS=-I/path/ to specify a non-standard path to sys/sdt.h])
@@ -522,6 +523,7 @@ _AC_DEFINE_AND_SUBST([LTTNG_UST_DEFAULT_CONSTRUCTOR_TIMEOUT_MS], [3000])
 AM_CFLAGS="-Wall"
 AC_SUBST(AM_CFLAGS)
 AC_SUBST(JNI_CPPFLAGS)
+AC_SUBST(SDT_CFLAGS)
 
 AC_CONFIG_FILES([
 	Makefile
diff --git a/lttng-ust.pc.in b/lttng-ust.pc.in
index f9adde87..1b96db06 100644
--- a/lttng-ust.pc.in
+++ b/lttng-ust.pc.in
@@ -9,5 +9,5 @@ Version: @PACKAGE_VERSION@
 Requires:
 Requires.private: liburcu-bp
 Libs: -L${libdir} -llttng-ust -ldl
-Cflags: -I${includedir} 
+Cflags: -I${includedir} @SDT_CFLAGS@
 
-- 
2.26.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
