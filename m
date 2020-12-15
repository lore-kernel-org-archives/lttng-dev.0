Return-Path: <SRS0=KqGB=FT=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8F4C4361B
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Dec 2020 16:29:20 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C5E207E8
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Dec 2020 16:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C5E207E8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CwNxn5x1JzDqq;
	Tue, 15 Dec 2020 11:29:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1608049757;
	bh=6WihHR6W9Mv9td/EyM4NdZHibK6wBydo34bAyTwPR2A=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Yl555gTDyGwjvF1sVN1VKXTztbnnMv3pcdhMNeGCKIBpHDgXwl9dlZaBS4HzzeA/R
	 U1pQhd+C5pckPXOl2VV0Jp8CKjDxR9R3U7xzeJFMKO60J+7rD90vhfzQ5CkOiviX+s
	 Px+ZMFOvIIcB/uTOY7JILv2nh9obS4OTbMaJi4GsZT7QoNiNt+YkrXSlw3ABSHU2eZ
	 hQHTboseZpsLmErTG+uAwZ2ZQOk0TE7rmJTyQ2MVHlv853c1+FmcD53XSjkdkFAvju
	 wAmLNc4sgpCOR0cmfRKmEY7+e1XZ5Hjn3frmihMeCFMNsm7zSZ53tznNJumRWQ1ZE4
	 HXmMyeVnCWXGA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CwNxg2pmLzF60
 for <lttng-dev@lists.lttng.org>; Tue, 15 Dec 2020 11:29:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5F30373CF;
 Tue, 15 Dec 2020 11:29:11 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 6O463upLA--d; Tue, 15 Dec 2020 11:29:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2BD4373CE;
 Tue, 15 Dec 2020 11:29:11 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2BD4373CE
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id womxrYWwF67N; Tue, 15 Dec 2020 11:29:11 -0500 (EST)
Received: from multivac.lan (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id 0F9E273CA;
 Tue, 15 Dec 2020 11:29:11 -0500 (EST)
To: lttng-dev@lists.lttng.org
Date: Tue, 15 Dec 2020 11:28:50 -0500
Message-Id: <20201215162850.78638-4-mjeanson@efficios.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215162850.78638-1-mjeanson@efficios.com>
References: <20201215162850.78638-1-mjeanson@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH urcu 4/4] Don't force a target and optimization
 level on ARMv7
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

We shouldn't force a specific target cpu for the compiler on ARMv7 but
let the system or the user choose it. If some of our code depends on a
specific target CPU features, it should be compile tested.

Also remove the default optimisation level of O1, it's potentially a
workaround to an early armv7 compiler performance problem and anyway
most builds will have an optimisation level flag set in the CFLAGS which
will override this one.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Change-Id: I1d1bb5cc0fa0be8f8b1d6a9ad7bf063809be1aef
---
 configure.ac | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index daa967a..f477425 100644
--- a/configure.ac
+++ b/configure.ac
@@ -119,10 +119,6 @@ AS_CASE([$host],[*-cygwin*],
 	[AM_CONDITIONAL(USE_CYGWIN, false)]
 )
 
-AS_IF([test "$host_cpu" = "armv7l"],[
-	AM_CFLAGS="$AM_CFLAGS -mcpu=cortex-a9 -mtune=cortex-a9 -O1"
-])
-
 # Search for clock_gettime
 AC_SEARCH_LIBS([clock_gettime], [rt], [
 	AC_DEFINE([CONFIG_RCU_HAVE_CLOCK_GETTIME], [1])
-- 
2.29.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
