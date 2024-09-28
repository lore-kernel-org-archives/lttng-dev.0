Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D22CF6493
	for <lttng-dev@archiver.kernel.org>; Sat, 28 Sep 2024 15:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1727535690;
	bh=gS50+7klyoUIipIdbPxYI/4sonPrfItWTD7T3DK9VTw=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=x7PVVyWtLuZZepPb1CYsck6H2qEXkcTJpjKxfAQdK40rO6xMYl+II5h7+xlIj/O+t
	 4B8VufGL6+F1RDJOhbLoejxna75K4iTFjTQyn8XlUEcTlcYZh3sAI10M9aDfmq1fzz
	 gaec46zR5VWaj3+AafmncStV6mZRDOtBZPHTYLIGVjrL7VlJ9DTSA49QvtbDoDZcPk
	 ai3eA+bOZweGzCg7QFEUM07CgJ8C1m1ejn6+YqPa9M9gdH8aQhLabKwJzdCGeaqMhM
	 cpvGhDfZTJTb3dNOrqBHp15/7kD9dzOLyq1BOvBkWFvw+F+Akwlnl/kWuAbyciv5Ce
	 ccyLmvD9FBfow==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4XG9X93VjGz1dyy;
	Sat, 28 Sep 2024 11:01:29 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4XG9X73scxz1dcT
 for <lttng-dev@lists.lttng.org>; Sat, 28 Sep 2024 11:01:27 -0400 (EDT)
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown
 [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4XG9X0517Cz1cPx;
 Sat, 28 Sep 2024 11:01:20 -0400 (EDT)
Message-ID: <e367cf33-e113-4fb8-9f48-94bb7a531604@efficios.com>
Date: Sat, 28 Sep 2024 10:59:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.13.15 (Linux kernel tracer)
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

* New in this release: Introduce support for Linux v6.11.

Detailed change log:

2024-09-28 (Ask a Stupid Question Day) LTTng modules 2.13.15
         * Fix: scsi: sd: Atomic write support added in 6.11-rc1
         * Fix: block_start removed from btrfs_get_extent in 6.11-rc1
         * Fix: block_len removed frmo btrfs_get_extent in 6.11-rc1
         * Fix: orig_start removed from btrfs_get_extent in 6.11-rc1
         * Fix: ext4_da_reserve_space changed in 6.11-rc1
         * Fix: kfree_skb changed in 6.11-rc1
         * Fix: event notifier: set eval_capture to false for kprobe and uprobe

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
