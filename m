Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7241FC6379F
	for <lttng-dev@archiver.kernel.org>; Fri, 13 Jan 2023 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1673644827;
	bh=6C3z/Bom2vjnb7pOy5t+MN1x7JBQrdSRyuZ/d/8NDxw=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=J8gsRNG36y0nZARt2HyyfZ/ebkhc+mPJTWdibmujA8LUkC4XXUihwK73l4yFi8mfu
	 1oqCTZLtOpnLK3uKiCvZj9GtslgyDg9bNN6wEaN8o4Ely5PPkMvr6mAammlXnjyv0+
	 toAODdX//0ChYJuel3lv04w9P4e5SY7WDNv7312xhCtUi7Q0rZBz6uxFBJhpXLS5Wp
	 A/XckGmvLDSf6cERtd8evMxYTXb5xc5r0YzoMpEIyW8Lbt/Bwa9KHweHUxmWRmWdK/
	 0aYuz/q8EwTJM2z6mUeZ84sLM34fHv8SeIUwWSqseftiA07Z6CtlRnDE4X1QfRrYLN
	 QDaE54l/nCvHw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NtvTQ3k7Mz1QrD;
	Fri, 13 Jan 2023 16:20:26 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4NtvTL0yFwz1Qdf
 for <lttng-dev@lists.lttng.org>; Fri, 13 Jan 2023 16:20:21 -0500 (EST)
Received: from [10.1.0.205] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4NtvSk161FzgMN;
 Fri, 13 Jan 2023 16:19:50 -0500 (EST)
Message-ID: <d8cf45aa-936c-90e7-61c4-cef6f7fe0006@efficios.com>
Date: Fri, 13 Jan 2023 16:20:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.12.12 and 2.13.8 (Linux
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

Those are stable release updates of the LTTng modules project.

The most relevant change is that the 2.13.8 version introduces
support for the 6.1 Linux kernel, kernel version ranges updates
for the RHEL kernels, and a kallsyms wrapper fix on ppc64el.

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

* New in these releases:

2023-01-13 (National Sticker Day) LTTng modules 2.13.8
         * fix: jbd2: use the correct print format
         * Fix: in_x32_syscall was introduced in v4.7.0
         * Explicitly skip tracing x32 system calls
         * fix: kallsyms wrapper on ppc64el
         * fix: Adjust ranges for RHEL 8.6 kernels
         * fix: kvm-x86 requires CONFIG_KALLSYMS_ALL
         * fix: mm/slab_common: drop kmem_alloc & avoid dereferencing fields when not using (v6.1)

2023-01-13 (National Sticker Day) LTTng modules 2.12.12
         * fix: jbd2: use the correct print format
         * Fix: in_x32_syscall was introduced in v4.7.0
         * Explicitly skip tracing x32 system calls
         * fix: kallsyms wrapper on ppc64el
         * fix: Adjust ranges for RHEL 8.6 kernels
         * fix: kvm-x86 requires CONFIG_KALLSYMS_ALL

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
