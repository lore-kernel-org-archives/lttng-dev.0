Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7592FC433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 18 Mar 2022 15:00:21 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KKnHl4vTpzFrC;
	Fri, 18 Mar 2022 11:00:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1647615620;
	bh=UgYCnpOSkb4YmNZM1RCVNfOEQvyKEqYA5eW+UiRmbhQ=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=X5gtJSpE0mPH3Sj2Vo8PGjN7J3Dtx/DON0K7NLqMNET8AFHA0iKqB9B7MR6tSOmdJ
	 8s23+8xiJxrzvgkaPJNQpu8G5YFYZF4W/pXsEa5HVvZQ7e/rPa3tIBwIegoeKmpksk
	 RHWsheYTVJ1Ux4s5lCaNRHVcFNGmP9TijsP/yVGHDxr23Kc55JAjzcB6I3EObVn3lk
	 sI3uN8PATZy2PeTQjhgMDAEK6dG5ss/xpsMn36CQsJrKg9VRr5lmA/wIysJ3hBZPp4
	 dNv+07lSw6iqgUE/huYpelz8Jrkm0hmDirUKapjKaGLFwuHXIX+hWgxvt8Etvb/EIR
	 JLpXidV6nAMKA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KKnHj1V5xzG0K
 for <lttng-dev@lists.lttng.org>; Fri, 18 Mar 2022 11:00:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0A4982F2D58
 for <lttng-dev@lists.lttng.org>; Fri, 18 Mar 2022 11:00:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ylNSQKQJ69h4; Fri, 18 Mar 2022 11:00:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4D3A52F3141;
 Fri, 18 Mar 2022 11:00:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4D3A52F3141
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id SHsgf-e6Trsi; Fri, 18 Mar 2022 11:00:00 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 3E7D62F313D;
 Fri, 18 Mar 2022 11:00:00 -0400 (EDT)
Date: Fri, 18 Mar 2022 11:00:00 -0400 (EDT)
To: Milian Wolff <milian.wolff@kdab.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <881325190.163218.1647615600126.JavaMail.zimbra@efficios.com>
In-Reply-To: <5884867.lOV4Wx5bFT@agathemoarbauer>
References: <5884867.lOV4Wx5bFT@agathemoarbauer>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Topic: getting lttng-modules to work on archlinux?
Thread-Index: MiyCEsVVVr/YMN4coVLeUVr6QyQX3g==
Subject: Re: [lttng-dev] getting lttng-modules to work on archlinux?
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

----- On Mar 18, 2022, at 10:34 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hey all,
> 
> in the past lttng-modules used to work on archlinux. But with a current
> kernel, I cannot get it to work anymore. Has anyone an idea what is going on
> here?
> 
> I compiled and installed lttng-modules from the latest git, which works fine.
> 
> ```
>    make
>    sudo make modules_install
>    sudo depmod -a
> ```
> 
> But loading the kernel modules then fails like this:
> 
> ```
> lttng-sessiond
> Error: Unable to load required module lttng-ring-buffer-client-discard
> Warning: No kernel tracer available
> ```
> 
> In dmesg I see the following output then, and I wonder if I'm doing something
> obviously wrong?
> 
> ```
> [16245.772646] Spectre V2 : System may be vulnerable to spectre v2
> [16245.772653] lttng_uprobes: loading module not compiled with retpoline
> compiler.

Hi Milian,

I suspect you need to use the same compiler (a compiler that supports retpoline
Spectre v2 mitigation) to compile lttng-modules as was used to compile your kernel.

I suspect the kernel rejects those modules because they are compiled with a
different compiler than your Linux kernel.

Thanks,

Mathieu


> [16245.773120] sysfs: cannot create duplicate filename '/module/lttng_uprobes/
> sections/.note.gnu.property'
> [16245.773124] CPU: 11 PID: 96193 Comm: lttng-sessiond Tainted: PF          OE
> 5.16.15-arch1-1 #1 670d2d5f7504498b520804dd7ff7fca01cc55e90
> [16245.773129] Hardware name: LENOVO 20Y30018GE/20Y30018GE, BIOS N40ET32W
> (1.14 ) 01/03/2022
> [16245.773131] Call Trace:
> [16245.773134]  <TASK>
> [16245.773138]  dump_stack_lvl+0x48/0x5e
> [16245.773147]  sysfs_warn_dup.cold+0x17/0x24
> [16245.773155]  sysfs_add_bin_file_mode_ns+0xae/0xc0
> [16245.773160]  internal_create_group+0x1ce/0x390
> [16245.773165]  mod_sysfs_setup+0x4e1/0x720
> [16245.773171]  load_module+0x25e8/0x27e0
> [16245.773178]  ? __do_sys_init_module+0x12e/0x1b0
> [16245.773181]  __do_sys_init_module+0x12e/0x1b0
> [16245.773185]  do_syscall_64+0x59/0x80
> [16245.773189]  ? syscall_exit_to_user_mode+0x23/0x40
> [16245.773193]  ? do_syscall_64+0x69/0x80
> [16245.773195]  ? syscall_exit_to_user_mode+0x23/0x40
> [16245.773198]  ? do_syscall_64+0x69/0x80
> [16245.773200]  ? do_user_addr_fault+0x1d7/0x690
> [16245.773205]  ? exc_page_fault+0x72/0x170
> [16245.773208]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [16245.773213] RIP: 0033:0x7f32283b06ae
> [16245.773216] Code: 48 8b 0d ed 66 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
> 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d ba 66 0e 00 f7 d8 64 89 01 48
> [16245.773219] RSP: 002b:00007fff964fc8c8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000af
> [16245.773223] RAX: ffffffffffffffda RBX: 0000559300c063d0 RCX: 00007f32283b06ae
> [16245.773224] RDX: 00007f322879732c RSI: 0000000000037320 RDI:
> 00007f3224925010
> [16245.773226] RBP: 00007f3224925010 R08: 00007f32249c7000 R09:
> 0000000000000000
> [16245.773228] R10: 0000000000037701 R11: 0000000000000246 R12:
> 00007f322879732c
> [16245.773230] R13: 0000559300c06380 R14: 0000000000000000 R15:
> 0000559300c08670
> [16245.773233]  </TASK>
> [16245.774070] Spectre V2 : System may be vulnerable to spectre v2
> [16245.774075] lttng_kprobes: loading module not compiled with retpoline
> compiler.
> [16245.774608] sysfs: cannot create duplicate filename '/module/lttng_kprobes/
> sections/.note.gnu.property'
> [16245.774611] CPU: 11 PID: 96193 Comm: lttng-sessiond Tainted: PF          OE
> 5.16.15-arch1-1 #1 670d2d5f7504498b520804dd7ff7fca01cc55e90
> [16245.774615] Hardware name: LENOVO 20Y30018GE/20Y30018GE, BIOS N40ET32W
> (1.14 ) 01/03/2022
> [16245.774617] Call Trace:
> [16245.774620]  <TASK>
> [16245.774622]  dump_stack_lvl+0x48/0x5e
> [16245.774630]  sysfs_warn_dup.cold+0x17/0x24
> [16245.774636]  sysfs_add_bin_file_mode_ns+0xae/0xc0
> [16245.774643]  internal_create_group+0x1ce/0x390
> [16245.774648]  mod_sysfs_setup+0x4e1/0x720
> [16245.774655]  load_module+0x25e8/0x27e0
> [16245.774659]  ? prepare_alloc_pages.constprop.0+0x7e/0x150
> [16245.774668]  ? __do_sys_init_module+0x12e/0x1b0
> [16245.774671]  __do_sys_init_module+0x12e/0x1b0
> [16245.774675]  do_syscall_64+0x59/0x80
> [16245.774681]  ? vfs_read+0xf1/0x190
> [16245.774686]  ? syscall_exit_to_user_mode+0x23/0x40
> [16245.774690]  ? do_syscall_64+0x69/0x80
> [16245.774692]  ? exc_page_fault+0x72/0x170
> [16245.774696]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [16245.774700] RIP: 0033:0x7f32283b06ae
> [16245.774703] Code: 48 8b 0d ed 66 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
> 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d ba 66 0e 00 f7 d8 64 89 01 48
> [16245.774706] RSP: 002b:00007fff964fc8c8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000af
> [16245.774711] RAX: ffffffffffffffda RBX: 0000559300c06250 RCX: 00007f32283b06ae
> [16245.774713] RDX: 00007f322879732c RSI: 000000000002ee48 RDI:
> 0000559300ca7440
> [16245.774714] RBP: 0000559300ca7440 R08: 0000000000000000 R09:
> 0000000000000000
> [16245.774715] R10: 0000000000086551 R11: 0000000000000246 R12:
> 00007f322879732c
> [16245.774717] R13: 0000559300c06200 R14: 0000000000000000 R15:
> 0000559300c06450
> [16245.774720]  </TASK>
> [16245.775610] Spectre V2 : System may be vulnerable to spectre v2
> [16245.775614] lttng_kretprobes: loading module not compiled with retpoline
> compiler.
> [16245.775873] sysfs: cannot create duplicate filename '/module/
> lttng_kretprobes/sections/.note.gnu.property'
> [16245.775876] CPU: 11 PID: 96193 Comm: lttng-sessiond Tainted: PF          OE
> 5.16.15-arch1-1 #1 670d2d5f7504498b520804dd7ff7fca01cc55e90
> [16245.775881] Hardware name: LENOVO 20Y30018GE/20Y30018GE, BIOS N40ET32W
> (1.14 ) 01/03/2022
> [16245.775882] Call Trace:
> [16245.775885]  <TASK>
> [16245.775887]  dump_stack_lvl+0x48/0x5e
> [16245.775893]  sysfs_warn_dup.cold+0x17/0x24
> [16245.775898]  sysfs_add_bin_file_mode_ns+0xae/0xc0
> [16245.775904]  internal_create_group+0x1ce/0x390
> [16245.775909]  mod_sysfs_setup+0x4e1/0x720
> [16245.775915]  load_module+0x25e8/0x27e0
> [16245.775922]  ? __do_sys_init_module+0x12e/0x1b0
> [16245.775925]  __do_sys_init_module+0x12e/0x1b0
> [16245.775929]  do_syscall_64+0x59/0x80
> [16245.775933]  ? do_user_addr_fault+0x1d7/0x690
> [16245.775938]  ? exc_page_fault+0x72/0x170
> [16245.775942]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [16245.775947] RIP: 0033:0x7f32283b06ae
> [16245.775951] Code: 48 8b 0d ed 66 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
> 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d ba 66 0e 00 f7 d8 64 89 01 48
> [16245.775953] RSP: 002b:00007fff964fc8c8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000af
> [16245.775957] RAX: ffffffffffffffda RBX: 0000559300c060c0 RCX: 00007f32283b06ae
> [16245.775959] RDX: 00007f322879732c RSI: 0000000000032190 RDI:
> 0000559300d1ad20
> [16245.775961] RBP: 0000559300d1ad20 R08: 0000000000000000 R09:
> 0000000000000000
> [16245.775962] R10: 000000000000138b R11: 0000000000000246 R12:
> 00007f322879732c
> [16245.775964] R13: 0000559300c06070 R14: 0000000000000000 R15:
> 0000559300c086c0
> [16245.775967]  </TASK>
> [16245.781844] Spectre V2 : System may be vulnerable to spectre v2
> [16245.781851] lttng_lib_ring_buffer: loading module not compiled with
> retpoline compiler.
> [16245.782493] sysfs: cannot create duplicate filename '/module/
> lttng_lib_ring_buffer/sections/.text'
> [16245.782497] CPU: 11 PID: 96193 Comm: lttng-sessiond Tainted: PF          OE
> 5.16.15-arch1-1 #1 670d2d5f7504498b520804dd7ff7fca01cc55e90
> [16245.782502] Hardware name: LENOVO 20Y30018GE/20Y30018GE, BIOS N40ET32W
> (1.14 ) 01/03/2022
> [16245.782505] Call Trace:
> [16245.782508]  <TASK>
> [16245.782517]  dump_stack_lvl+0x48/0x5e
> [16245.782528]  sysfs_warn_dup.cold+0x17/0x24
> [16245.782534]  sysfs_add_bin_file_mode_ns+0xae/0xc0
> [16245.782541]  internal_create_group+0x1ce/0x390
> [16245.782546]  mod_sysfs_setup+0x4e1/0x720
> [16245.782552]  load_module+0x25e8/0x27e0
> [16245.782559]  ? __do_sys_init_module+0x12e/0x1b0
> [16245.782562]  __do_sys_init_module+0x12e/0x1b0
> [16245.782567]  do_syscall_64+0x59/0x80
> [16245.782571]  ? do_syscall_64+0x69/0x80
> [16245.782574]  ? syscall_exit_to_user_mode+0x23/0x40
> [16245.782577]  ? do_syscall_64+0x69/0x80
> [16245.782580]  ? exc_page_fault+0x72/0x170
> [16245.782584]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [16245.782589] RIP: 0033:0x7f32283b06ae
> [16245.782593] Code: 48 8b 0d ed 66 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
> 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d ba 66 0e 00 f7 d8 64 89 01 48
> [16245.782595] RSP: 002b:00007fff964fc8c8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000af
> [16245.782599] RAX: ffffffffffffffda RBX: 0000559300c05f30 RCX: 00007f32283b06ae
> [16245.782601] RDX: 00007f322879732c RSI: 0000000000188f58 RDI:
> 00007f3224519010
> [16245.782602] RBP: 00007f3224519010 R08: 00007f322477c000 R09:
> 0000000000000000
> [16245.782604] R10: 0000000000062ef1 R11: 0000000000000246 R12:
> 00007f322879732c
> [16245.782606] R13: 0000559300c05ee0 R14: 0000000000000000 R15:
> 0000559300c08710
> [16245.782609]  </TASK>
> [16245.784406] Spectre V2 : System may be vulnerable to spectre v2
> [16245.784411] lttng_statedump: loading module not compiled with retpoline
> compiler.
> [16245.784546] lttng_statedump: Unknown symbol wrapper_kallsyms_lookup_name
> (err -2)
> [16245.784585] lttng_statedump: Unknown symbol wrapper_irq_to_desc (err -2)
> [16246.003631] audit: type=1106 audit(1647613550.654:388): pid=96182 uid=1000
> auid=1000 ses=1 msg='op=PAM:session_close
> grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root" exe="/
> usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/6 res=success'
> [16247.424446] Spectre V2 : System may be vulnerable to spectre v2
> [16247.424453] lttng_statedump: loading module not compiled with retpoline
> compiler.
> [16247.424612] lttng_statedump: Unknown symbol wrapper_kallsyms_lookup_name
> (err -2)
> [16247.424651] lttng_statedump: Unknown symbol wrapper_irq_to_desc (err -2)
> ```
> 
> Thanks
> --
> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> KDAB (Deutschland) GmbH, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt, C++ and OpenGL Experts
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
