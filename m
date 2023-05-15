Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F0EC77B7D
	for <lttng-dev@archiver.kernel.org>; Mon, 15 May 2023 20:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684181900;
	bh=I5Yci1xhHeUUcfeQOJeFmXD18bXbrnD8K9lcY563sb8=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=iFCuqnR9ouCkVRYvohlZG1DuH0UCK1fnsGJkhbjudPmU32OGiokLLKZU90WRBRLdC
	 Wbnaz7ymQF0gMIrH8d1nH4NT3X8bkkCvhuZOGN9DMdpg5aOuyh8rW436L+6rKrQpm/
	 0yiOUoxoFT+/WB+mqPZap2qJ/PyVtEkp0fipe5XFHJefssLMZxZtr287hodIRIEVGr
	 1Jf5cz7WfD8bpTicC7pdT6C1jbeSorTYLpdE594Rz+P6qgKfhJ2sGNMPtEf6wCpHBb
	 z+MrgYwH1tdr2H2UZ/Gy3ccxv93izpOrAp3GM1TRGydgTvgtFCJMKVIfhhwKCorA/Q
	 pphqS+8lMqfsQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QKrKR2pbFz1Df5;
	Mon, 15 May 2023 16:18:19 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QKrKM3zpXz1Df0
 for <lttng-dev@lists.lttng.org>; Mon, 15 May 2023 16:18:15 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKrKM0F3Nz12nV;
 Mon, 15 May 2023 16:18:15 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Mon, 15 May 2023 16:17:08 -0400
Message-Id: <20230515201718.9809-2-odion@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 01/11] configure: Add --disable-atomic-builtins
 option
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Cc: Olivier Dion <odion@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

By default, if the toolchain supports atomic builtins, use them for the
uatomic API. This requires that the toolchains used to compile the
library and the user application supports such builtins.

The advantage of using these builtins is that they are well known
synchronization primitives by several tools such as TSAN.

Change-Id: Ia8e97112681f744f17816dbc4cbbec805a483331
Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 README.md    | 11 +++++++++++
 configure.ac | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/README.md b/README.md
index ba5bb08..6ce96c9 100644
--- a/README.md
+++ b/README.md
@@ -429,6 +429,17 @@ still being used to iterate on a hash table.
 This option alters the rculfhash ABI. Make sure to compile both library
 and application with matching configuration.
 
+### Usage of `--disable-atomic-builtins`
+
+By default, the configure script will check if the toolchain supports atomic
+builtins. If so, then the RCU memory model is implemented using the atomic
+builtins of the toolchain.
+
+Building liburcu with `--disable-atomic-builtins` force to use the legacy
+internal implementations for atomic accesses.
+
+This option is useful if for example the atomic builtins for a given toolchain
+version is known to be broken or to be inefficient.
 
 Make targets
 ------------
diff --git a/configure.ac b/configure.ac
index 909cf1d..4450a31 100644
--- a/configure.ac
+++ b/configure.ac
@@ -230,6 +230,11 @@ AE_FEATURE([rcu-debug], [Enable internal debugging self-checks. Introduces a per
 AE_FEATURE_DEFAULT_DISABLE
 AE_FEATURE([cds-lfht-iter-debug], [Enable extra debugging checks for lock-free hash table iterator traversal. Alters the rculfhash ABI. Make sure to compile both library and application with matching configuration.])
 
+# toolchain atomic builtins
+# Enabled by default
+AE_FEATURE_DEFAULT_ENABLE
+AE_FEATURE([atomic-builtins], [Disable the usage of toolchain atomic builtins.])
+
 # When given, add -Werror to WARN_CFLAGS and WARN_CXXFLAGS.
 # Disabled by default
 AE_FEATURE_DEFAULT_DISABLE
@@ -259,6 +264,23 @@ AE_IF_FEATURE_ENABLED([cds-lfht-iter-debug], [
   AC_DEFINE([CONFIG_CDS_LFHT_ITER_DEBUG], [1], [Enable extra debugging checks for lock-free hash table iterator traversal. Alters the rculfhash ABI. Make sure to compile both library and application with matching configuration.])
 ])
 
+AE_IF_FEATURE_ENABLED([atomic-builtins], [
+  AC_COMPILE_IFELSE(
+	[AC_LANG_PROGRAM(
+		[[int x, y;]],
+		[[__atomic_store_n(&x, 0, __ATOMIC_RELAXED);
+		  __atomic_load_n(&x, __ATOMIC_RELAXED);
+		  y = __atomic_exchange_n(&x, 1, __ATOMIC_RELAXED);
+		  __atomic_compare_exchange_n(&x, &y, 0, 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
+		  __atomic_add_fetch(&x, 1, __ATOMIC_RELAXED);
+		  __atomic_sub_fetch(&x, 1, __ATOMIC_RELAXED);
+		  __atomic_and_fetch(&x, 0x01, __ATOMIC_RELAXED);
+		  __atomic_or_fetch(&x, 0x01, __ATOMIC_RELAXED);
+		  __atomic_thread_fence(__ATOMIC_RELAXED);
+		  __atomic_signal_fence(__ATOMIC_RELAXED);]])],
+	[AC_DEFINE([CONFIG_RCU_USE_ATOMIC_BUILTINS], [1], [Use compiler atomic builtins.])],
+	[AE_FEATURE_DISABLE(atomic-builtins)])
+])
 
 ##                                                                          ##
 ## Set automake variables for optional feature conditionnals in Makefile.am ##
@@ -361,6 +383,10 @@ PPRINT_PROP_BOOL([Internal debugging], $value)
 AE_IS_FEATURE_ENABLED([cds-lfht-iter-debug]) && value=1 || value=0
 PPRINT_PROP_BOOL([Lock-free HT iterator debugging], $value)
 
+# atomic builtins enabled/disabled
+AE_IS_FEATURE_ENABLED([atomic-builtins]) && value=1 || value=0
+PPRINT_PROP_BOOL([Use toolchain atomic builtins], $value)
+
 PPRINT_PROP_BOOL([Multi-flavor support], 1)
 
 report_bindir="`eval eval echo $bindir`"
-- 
2.39.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
