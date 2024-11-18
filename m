Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5202CD49207
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Nov 2024 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1731945658;
	bh=0SMGPScg1OjGEEbWukEQ6UEnHRdruCh0flCAnhLlwm4=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=jud0BVzstS9UN6RuXYC0rT0Z59OrO16O1Yv/Sinq5+XFXZCBunDCloDZCmJhwOqKD
	 FXUTjXsbRxyj2z9SgxKyzcG29MSG3/7ee6Tu5Mkhjex46YZW4M0mY4rTU2PMKb1ceJ
	 v8zvCVRtftXVMKexgcbc9UKdQRxXGeYmiiyjVedVNZ1XGr3ZDUxbymhBxLQa837UYu
	 Qrq+xxL1qWQyw82VJuLdamPYDTsSKsGYp5gud9WOSThEGDkSibmKSSl9FThuiSMSXM
	 /rJeHaAuOUXNRtLCplF/cWG64CEo4sHVXykVK/4myJhHMXeT4LVtj7HeAXin36X9km
	 g6hIRsdzFUGyQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4XsXRG1wM5z12qq;
	Mon, 18 Nov 2024 11:00:58 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4XsXRF3Ry7z12ql
 for <lttng-dev@lists.lttng.org>; Mon, 18 Nov 2024 11:00:57 -0500 (EST)
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net
 [96.127.217.162])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4XsXRD3tntzLkV;
 Mon, 18 Nov 2024 11:00:56 -0500 (EST)
Message-ID: <577d4fa9-4d0c-4ff1-ab2c-d4cc088e21b9@efficios.com>
Date: Mon, 18 Nov 2024 11:00:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.12.19 and 2.13.16 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

This is a stable release announcement for the LTTng kernel tracer,
a kernel tracer for the Linux kernel.

The most relevant news about those releases is added support for
the Linux kernel v6.12 by LTTng-modules v2.13.16.

Detailed change logs:

2024-11-18 (Odd Socks Day) LTTng Modules 2.13.16
         * fix: mm/page_alloc: fix tracepoint mm_page_alloc_zone_locked() (v5.15.171)
         * Fix: uprobes: make uprobe_register() return struct uprobe * (v6.12)
         * Fix: silence 'non-consumed' message for non-started sessions
         * fix: writeback: Refine the show_inode_state() macro definition (v6.12)

2024-11-18 (Odd Socks Day) LTTng Modules 2.12.19
         * fix: mm/page_alloc: fix tracepoint mm_page_alloc_zone_locked() (v5.15.171)

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
