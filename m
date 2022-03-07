Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEB1C433F5
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Mar 2022 21:18:05 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KCBBh31jMz91f;
	Mon,  7 Mar 2022 16:18:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646687885;
	bh=ZnhPelR9rFbYppx5aqTPJanRnoho5prvNfPiW93TKh0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=QGoInM9kfIZa2vPTfMrlAG4ltrrdH7BkHJmMmdfhuXwvcy/vJVHPNmeU9jhKbLTBg
	 Ye3ZdnAQ+K21ItMF/9bi35hxs8GvZlFrxU4cn1CE+xI3lYfxBnv1bHnCeXp21YBuVC
	 dzdYVI5o8qxR7vkNGyHkO5oD4PcicjnbV0SxswIZi5IgicMbdEtNAMEjIQcOPl3fP0
	 nNx7hJJwh+VA/TE5F8r6j8+OHmkqLRizC54m/OfOxR0aFNqcyy2FmR1Ppg1uqNg9KZ
	 7PpBKn5TpxcZDB72uESa/Mw4fap8bgV22968e0b6Vh3eKAtkiFOuI69B09lsffJ9YK
	 dAoBghqhUNOuw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KCBBf0DlCz91c
 for <lttng-dev@lists.lttng.org>; Mon,  7 Mar 2022 16:18:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B7FF634EE0B
 for <lttng-dev@lists.lttng.org>; Mon,  7 Mar 2022 16:17:55 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id suQxVMfNVwYo; Mon,  7 Mar 2022 16:17:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6DED234E8F7;
 Mon,  7 Mar 2022 16:17:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6DED234E8F7
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id lEyQmS_tXKbR; Mon,  7 Mar 2022 16:17:55 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 62EC234ED19;
 Mon,  7 Mar 2022 16:17:55 -0500 (EST)
Date: Mon, 7 Mar 2022 16:17:55 -0500 (EST)
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, 
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1107588912.127428.1646687875294.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF97 (Linux)/8.8.15_GA_4232)
Thread-Index: sdhEkjIbeJvKI/brt+/jEwlhtEXs8w==
Thread-Topic: LTTng-modules 2.13.2 (Linux kernel tracer)
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.13.2 (Linux kernel tracer)
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

The 2.13.2 release of the LTTng kernel tracer includes a fix for the
syscall tracing feature. A bug crept into 2.13.0 which caused the
system call input arguments to be recorded on return from system call
rather than the output arguments. This fix was in the master branch of
lttng-modules, but was not cherry-picked into the 2.13 stable branch.

This missing backport went unnoticed through our CI integration       
because the relevant kernel tracer tests were not part of lttng-tools 
default test suite: "make check". This is now fixed in the lttng-tools
project.

This release also contains commits needed to trace the 5.17 kernels
(currently at v5.17-rc7).

Users of lttng-modules 2.13.0 and 2.13.1 should upgrade to 2.13.2
if they want to gather useful output arguments on return from system
call into their trace, rather than an extra copy of the system call
input arguments.

Thanks,

Mathieu

Changelog:

2022-03-07 (National Cereal Day) LTTng modules 2.13.2
        * Fix: incorrect in/out direction for syscall exit
        * fix: net: socket: rename SKB_DROP_REASON_SOCKET_FILTER (v5.17)
        * fix: net: skb: introduce kfree_skb_reason() (v5.17)
        * fix: random: rather than entropy_store abstraction, use global (v5.17)
        * fix: btrfs: pass fs_info to trace_btrfs_transaction_commit (v5.17)
        * fix: mm: compaction: fix the migration stats in trace_mm_compaction_migratepages() (v5.17)
        * fix: block: remove the ->rq_disk field in struct request (v5.17)
        * fix: block: remove GENHD_FL_SUPPRESS_PARTITION_INFO (v5.17)
        * Copyright ownership transfer

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
