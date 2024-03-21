Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE5BC54E58
	for <lttng-dev@archiver.kernel.org>; Thu, 21 Mar 2024 19:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1711051092;
	bh=unrwkwI7CAOr2+/zrIG4KyY3g+AznqM2vmMOu2NZaPQ=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=m8DAhsyPjDXvv1pzyxM7Wel1Wnola0auQk3olT+h+ZEIlW/y/nsMSB5OiSq3LLkC9
	 iB7RWdsvpDCRUvXj8LreEO512sDQ2dk/SztHXVbg/+CtqSYVhUu5xu0PkBu63xciti
	 S24+bJLxGnVgsZFeK0ZFDDDs3NBYxS5c7ny5hQtDdhoQx2IG7vPDRxkz8n1KJNPFvU
	 wDKzT0TQXCYb2w1QLLF58qEWQmdae8KDZItCnWx5USdjcmpwI1qQe4BUDBiasTK9K5
	 2fsNllTNE8sU8LvU+PjirzHrNhGcP2uQIaT00lZvlxxubUp44bBChu/bou23xVUB/p
	 xIJmvvPLR8kGA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V0x8g1Z4Jz2TmG;
	Thu, 21 Mar 2024 15:58:11 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4V0x8d13QSz2Tq3
 for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2024 15:58:09 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4V0x8V1C3tzlr8;
 Thu, 21 Mar 2024 15:58:02 -0400 (EDT)
Message-ID: <b0c3b8ec-90fe-4813-8df5-92168f621808@efficios.com>
Date: Thu, 21 Mar 2024 15:58:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.12.16 and 2.13.12 (Linux
 kernel tracer)
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

This is a release announcement for the currently maintained
LTTng-modules Linux kernel tracer stables branches.

* New and noteworthy in these releases:

Linux kernel v6.8 is now supported by LTTng modules 2.13.12. If you need
support for recent kernels (v5.18+), you will need to upgrade to a
recent LTTng-modules 2.13.x.

Both releases correct issues with SLE kernel version ranges detection.

A compilation fix for RHEL 9.3 kernel is present in v2.13.12.

Feedback is welcome!

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Detailed change logs:

2024-03-21 (National Common Courtesy Day) LTTng modules 2.13.12
         * docs: Add supported versions and fix-backport policy
         * docs: Add links to project resources
         * Fix: Correct minimum version in jbd2 SLE kernel range
         * Fix: Handle recent SLE major version codes
         * Fix: build on sles15sp4
         * Compile fixes for RHEL 9.3 kernels
         * Fix: ext4_discard_preallocations changed in linux 6.8.0-rc3
         * Fix: btrfs_get_extent flags and compress_type changed in linux 6.8.0-rc1
         * Fix: btrfs_chunk tracepoints changed in linux 6.8.0-rc1
         * Fix: strlcpy removed in linux 6.8.0-rc1
         * Fix: timer_start changed in linux 6.8.0-rc1
         * Fix: sched_stat_runtime changed in linux 6.8.0-rc1

2024-03-21 (National Common Courtesy Day) 2.12.16
         * fix: lttng-probe-kvm-x86-mmu build with linux 6.6
         * docs: Add supported versions and fix-backport policy
         * docs: Add links to project resources
         * Fix: Correct minimum version in jbd2 SLE kernel range
         * Fix: Handle recent SLE major version codes
         * Fix: build on sles15sp4

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
