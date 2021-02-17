Return-Path: <SRS0=umfz=HT=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7396CC433DB
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Feb 2021 20:06:58 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52F264E5F
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Feb 2021 20:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52F264E5F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DgplM6fBsz1Xt;
	Wed, 17 Feb 2021 15:06:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1613592416;
	bh=kLr1qutrzDm3fjL77TksYOPb+kTilopaNhZmV0+sub8=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=05Q7M1qL/nEFKKc2ls/Hn6Ao4yI3uEn1DaL2+KHvxnLbT6fXxOuYzvO+gIW8kOAlg
	 uGESEC8Cstes2wpsWGp7E1HXRPvDUx/+IrhTJ3i4q8yd2ch9OtQpAom9XL7dbDm6W7
	 EXYSpdjqniNm7UsHVQP18etWvjJ8nxcsxmKWmQ5tzyrhbVDD+GMrioNWpXJAb4F33s
	 b96plB/PHXXaf3u7o0GAdtXo0CsGbr6eZVFcKhCEfdEKSuGr+PrIisFKqY1vZlL/Yv
	 XE5lU0Jl11Y017QSo4/J8trSJiTsZYZkpIkoorMv6aUzHuBN7vRDX98wNGtP5DVIvg
	 8+MSC12rX280g==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4DgplK6cShz21T
 for <lttng-dev@lists.lttng.org>; Wed, 17 Feb 2021 15:06:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 53F0332423E
 for <lttng-dev@lists.lttng.org>; Wed, 17 Feb 2021 15:06:47 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id X4AR5kN0c6vM; Wed, 17 Feb 2021 15:06:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id ED84A32423C;
 Wed, 17 Feb 2021 15:06:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ED84A32423C
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Iu47rLtWdr8q; Wed, 17 Feb 2021 15:06:46 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id DEAB432407E;
 Wed, 17 Feb 2021 15:06:46 -0500 (EST)
Date: Wed, 17 Feb 2021 15:06:46 -0500 (EST)
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, lwn@lwn.net
Message-ID: <424165303.25817.1613592406800.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Index: Q9VqS6nKdol5OMjUduAPKUZnxS3Q9Q==
Thread-Topic: Userspace RCU 0.11.3 and 0.12.2
Subject: [lttng-dev] [RELEASE] Userspace RCU 0.11.3 and 0.12.2
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

This is a bugfix release announcement for the Userspace RCU library
(liburcu) for its two currently maintained branches.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

The Changelog entries highlight the relevant fixes:

2021-02-17 Userspace RCU 0.11.3
        * fix: exclude clang from GCC version blacklists
        * aarch64: blacklist gcc prior to 5.1
        * Fix: configure: support Autoconf 2.70
        * fix: bump tests thread limit to 4096
        * cleanup: Improve wording of CONFIG_RCU_DEBUG description
        * fix: explicitly include urcu/config.h in files using CONFIG_RCU_ defines
        * Fix typo in README.md
        * fix: add -lurcu-common to pkg-config libs for each flavor
        * call_rcu: Fix race between rcu_barrier() and call_rcu_data_free()

2021-02-17 Userspace RCU 0.12.2
        * fix: exclude clang from GCC version blacklists
        * aarch64: blacklist gcc prior to 5.1
        * Fix: configure: support Autoconf 2.70
        * fix: bump tests thread limit to 4096
        * cleanup: Improve wording of CONFIG_RCU_DEBUG description
        * fix: explicitly include urcu/config.h in files using CONFIG_RCU_ defines
        * Fix typo in README.md
        * fix: add -lurcu-common to pkg-config libs for each flavor
        * call_rcu: Fix race between rcu_barrier() and call_rcu_data_free()

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
