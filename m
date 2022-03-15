Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E253C433F5
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Mar 2022 15:49:52 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KHyXG70r2zDjv;
	Tue, 15 Mar 2022 11:49:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1647359391;
	bh=+HA+lSrg4350vIlGVBWvyt+N0X2btGBET5hg7yzB36E=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=HlfDTuPqBtWP8bZacr52wY08VEJvA/oaI/8jVDsevOrsiGTlVyn7Qevvs5yIyhjVz
	 kw/KVTQwGUwxCdTGQsofBoShS9QwP1qO7PZ01TiQ4z2smEv8IiLfW1RExuZQIAF2pk
	 GyM/2Qikg7UGnMW0wmSjb7RsLrZNOEqn4UVJzJdFLinBburBZ+lBPkzDeZfw56wzdD
	 3GDdReIVdX0L+ApvqvFB7hOuBGDtSAZebuIDKXFEIdhOhEr4HFkwnGv8Fmw41tkwMq
	 g6ae6F+armp1eJ+TczyI2GLnOHc1bLn/n05lJMl6MXlRMhYSAty2xdkYJUhqVk+rKq
	 4De/yh4whXM3g==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KHyXF1lnnzDqX
 for <lttng-dev@lists.lttng.org>; Tue, 15 Mar 2022 11:49:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A4CFA3B50E8
 for <lttng-dev@lists.lttng.org>; Tue, 15 Mar 2022 11:49:43 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id IuOr4ojxVf08; Tue, 15 Mar 2022 11:49:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 51C1B3B5805;
 Tue, 15 Mar 2022 11:49:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 51C1B3B5805
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id plwpNE8pAppH; Tue, 15 Mar 2022 11:49:42 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 443FD3B5804;
 Tue, 15 Mar 2022 11:49:42 -0400 (EDT)
Date: Tue, 15 Mar 2022 11:49:42 -0400 (EDT)
To: GOLLAMUDI MADHAN MOHAN <madhan.mohan@5g.iith.ac.in>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <795806806.151478.1647359382157.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAB9=ZW6FEj+zXnVcSaCGCSWF54cZDEv5_25-F0D1SEZHZaZ=rw@mail.gmail.com>
References: <CAB9=ZW6FEj+zXnVcSaCGCSWF54cZDEv5_25-F0D1SEZHZaZ=rw@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Topic: call trace while using lttng in petalinux 2019.2 (kernel 4.19)
Thread-Index: /iM6dznc+I24zGeX3o8JjtohSSqzmg==
Subject: Re: [lttng-dev] call trace while using lttng in petalinux 2019.2
 (kernel 4.19)
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



----- On Mar 15, 2022, at 2:48 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Dear Sir/Madam,
> I am Madhan , working as an embedded engineer in 5GTB. I am using lttng in
> petalinux 2019.2(kernel 4.19) .And getting a call Trace error. Refer the below
> log for more details.

> root@xilinx-zcu111-2019_2:~# lttng create
> Spawning a session daemon
> [ 163.902282] lttng_kretprobes: loading out-of-tree module taints kernel.
> [ 163.987461] Unable to handle kernel paging request at virtual address
> 00000000000010c0
> [ 163.995379] Mem abort info:
> [ 163.998179] ESR = 0x96000005
> [ 164.001233] Exception class = DABT (current EL), IL = 32 bits
> [ 164.007149] SET = 0, FnV = 0
> [ 164.010203] EA = 0, S1PTW = 0
> [ 164.013333] Data abort info:
> [ 164.016218] ISV = 0, ISS = 0x00000005
> [ 164.020054] CM = 0, WnR = 0
> [ 164.023028] user pgtable: 4k pages, 39-bit VAs, pgdp = 00000000df6dd54e
> [ 164.029646] [00000000000010c0] pgd=0000000000000000, pud=0000000000000000
> [ 164.036447] Internal error: Oops: 96000005 [#1] SMP
> [ 164.041318] Modules linked in: lttng_tracer(O+) lttng_statedump(O)
> lttng_ftrace(O) lttng_kprobes(O) lttng_clock(O) lttng_lib_ring_buffer(O)
> lttng_kretprobes(O) uio_pdrv_genirq
> [ 164.056963] CPU: 1 PID: 4955 Comm: modprobe Tainted: G O 4.19.0-xilinx-v2019.2
> #1
> [ 164.065734] Hardware name: ZynqMP ZCU111 RevA (DT)
> [ 164.070510] pstate: 60000005 (nZCv daif -PAN -UAO)
> [ 164.075429] pc : lttng_tracepoint_notify+0x188/0x228 [lttng_tracer]
> [ 164.081767] lr : lttng_tracepoint_notify+0x14c/0x228 [lttng_tracer]
> [ 164.088016] sp : ffffff8011613a40
> [ 164.091314] x29: ffffff8011613a40 x28: ffffff801163f000
> [ 164.096618] x27: 0000000000000100 x26: ffffff800813c958
> [ 164.101921] x25: ffffff8000e22758 x24: 0000000000000000
> [ 164.107225] x23: 00000000000010c0 x22: ffffff8000e42ed8
> [ 164.112528] x21: ffffffc87accc400 x20: ffffff8000e42ef8
> [ 164.117832] x19: 0000000000000001 x18: 0000000000000000
> [ 164.123135] x17: 0000000000000000 x16: 0000000000000000
> [ 164.128439] x15: ffffffffffffffff x14: 0000000000000000
> [ 164.133742] x13: 0000000000000000 x12: 0000000000000000
> [ 164.139046] x11: 0000000000000001 x10: 0101010101010101
> [ 164.144349] x9 : 6d64686b625e6f38 x8 : 706d75645f6c6f63
> [ 164.149653] x7 : 6f746f72705f7039 x6 : ffffffc8778d5ec1
> [ 164.154957] x5 : ffffff8009458000 x4 : 0000000000000000
> [ 164.160260] x3 : ffffff8000db77a0 x2 : ffffffc87828a380
> [ 164.165563] x1 : 0000000000000007 x0 : ffffff8000d13048
> [ 164.170869] Process modprobe (pid: 4955, stack limit = 0x00000000e6162018)
> [ 164.177725] Call trace:
> [ 164.180235] lttng_tracepoint_notify+0x188/0x228 [lttng_tracer]
> [ 164.186148] register_tracepoint_module_notifier+0x6c/0x98
> [ 164.191709] lttng_tracepoint_init+0x54/0xc80 [lttng_tracer]
> [ 164.197438] lttng_events_init+0x4c/0x1e0 [lttng_tracer]
> [ 164.202734] do_one_initcall+0x68/0x1ec
> [ 164.206562] do_init_module+0x60/0x1f0
> [ 164.210302] load_module+0x1ca0/0x2270
> [ 164.214035] __se_sys_finit_module+0xc0/0xd0
> [ 164.218288] __arm64_sys_finit_module+0x24/0x30
> [ 164.222802] el0_svc_common+0x98/0x100
> [ 164.226543] el0_svc_handler+0x74/0x90
> [ 164.230275] el0_svc+0x8/0xc
> [ 164.233142] Code: 6b18003f 54fffc49 f9415c00 b8b8d817 (f94002f3)
> [ 164.239226] ---[ end trace c1cc2d1f9d55794a ]---
> [ 195.613567] lttng_ring_buffer_client_overwrite: gave up waiting for init of
> module lttng_tracer.
> [ 195.622371] lttng_ring_buffer_client_overwrite: Unknown symbol
> lttng_transport_unregister (err -16)
> ^C
> root@xilinx-zcu111-2019_2:~# uname -a
> Linux xilinx-zcu111-2019_2 4.19.0-xilinx-v2019.2 #1 SMP Mon Mar 14 15:09:26 UTC
> 2022 aarch64 GNU/Linux
> root@xilinx-zcu111-2019_2:~# uname -a
> Linux xilinx-zcu111-2019_2 4.19.0-xilinx-v2019.2 #1 SMP Mon Mar 14 15:09:26 UTC
> 2022 aarch64 GNU/Linux
> root@xilinx-zcu111-2019_2:~# [ 226.333565] lttng_ring_buffer_client_overwrite:
> gave up waiting for init of module lttng_tracer.
> [ 226.342368] lttng_ring_buffer_client_overwrite: Unknown symbol lttng_last_tsc
> (err -16)
> [ 257.053564] lttng_ring_buffer_client_overwrite: gave up waiting for init of
> module lttng_tracer.
> [ 257.062358] lttng_ring_buffer_client_overwrite: Unknown symbol
> lttng_transport_register (err -16)
> [ 287.773562] lttng_ring_buffer_client_overwrite: gave up waiting for init of
> module lttng_tracer.
> [ 287.782356] lttng_ring_buffer_client_overwrite: Unknown symbol
> lttng_transport_unregister (err -16)
> [ 318.493567] lttng_ring_buffer_client_overwrite: gave up waiting for init of
> module lttng_tracer.
> [ 318.502364] lttng_ring_buffer_client_overwrite: Unknown symbol lttng_last_tsc
> (err -16)
> [ 349.213564] lttng_ring_buffer_client_overwrite: gave up waiting for init of
> module lttng_tracer.
> [ 349.222363] lttng_ring_buffer_client_overwrite: Unknown symbol
> lttng_transport_register (err -16)

What is the installed lttng-modules version ? 

You can query it with modinfo /lib/modules/$(uname -r)/extra/lttng-tracer.ko

Thanks, 

Mathieu 

> Thank You
> with regards
> G Madhan Mohan

> Disclaimer:- This footer text is to convey that this email is sent by one of the
> users of IITH. So, do not mark it as SPAM.
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
