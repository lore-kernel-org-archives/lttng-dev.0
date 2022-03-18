Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF55C433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 18 Mar 2022 14:42:44 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KKmvR2R7czFhb;
	Fri, 18 Mar 2022 10:42:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1647614564;
	bh=ScWiEl4DX7ZUIRIR0Dvm8pT860mig8/PP3dzpEiGb88=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=U9H207Lqmt/vkRok7NK1UCrNzsdiQB18uo8DUNAvsKZ8bmVRqZuXQGKAOCnH4xY3s
	 44uUv9oEPcwitVICHM1fY3JV59CYXFN2xKsLXgI6SNNRS8WRkTfWfc+g0HOTCCC2Sb
	 CNsZUF5zinKTNs6H0wrwfJBaZhX1/lo3WASCO7RO7BtBeNtDQHNK5daIuzLs6iF8pt
	 WHcJ1+rXV2bXWT5sS7XRRSN1h6Vr82fIeMbeNAEaWcsnonYO45l97Cvu+TpnkykcTR
	 r7nP+54wSWkpN2it0E+7EbU2EpGdvWYf3Zto66/lVZ6jCrOFbajbGj5UqTgoE/kVEK
	 WNQ6TKOySSJeA==
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 by lists.lttng.org (Postfix) with ESMTPS id 4KKmvP2xKXzG2Y
 for <lttng-dev@lists.lttng.org>; Fri, 18 Mar 2022 10:42:40 -0400 (EDT)
X-Virus-Scanned: amavisd-new at kdab.com
To: lttng-dev@lists.lttng.org
Date: Fri, 18 Mar 2022 15:34:36 +0100
Message-ID: <5884867.lOV4Wx5bFT@agathemoarbauer>
MIME-Version: 1.0
Subject: [lttng-dev] getting lttng-modules to work on archlinux?
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
From: Milian Wolff via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Milian Wolff <milian.wolff@kdab.com>
Content-Type: multipart/mixed; boundary="===============8480819974722930437=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8480819974722930437==
Content-Type: multipart/signed; boundary="nextPart4804366.31r3eYUQgx";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart4804366.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey all,

in the past lttng-modules used to work on archlinux. But with a current 
kernel, I cannot get it to work anymore. Has anyone an idea what is going on 
here?

I compiled and installed lttng-modules from the latest git, which works fine.

```
    make
    sudo make modules_install
    sudo depmod -a
```

But loading the kernel modules then fails like this:

```
lttng-sessiond 
Error: Unable to load required module lttng-ring-buffer-client-discard
Warning: No kernel tracer available
```

In dmesg I see the following output then, and I wonder if I'm doing something 
obviously wrong?

```
[16245.772646] Spectre V2 : System may be vulnerable to spectre v2
[16245.772653] lttng_uprobes: loading module not compiled with retpoline 
compiler.
[16245.773120] sysfs: cannot create duplicate filename '/module/lttng_uprobes/
sections/.note.gnu.property'
[16245.773124] CPU: 11 PID: 96193 Comm: lttng-sessiond Tainted: PF          OE     
5.16.15-arch1-1 #1 670d2d5f7504498b520804dd7ff7fca01cc55e90
[16245.773129] Hardware name: LENOVO 20Y30018GE/20Y30018GE, BIOS N40ET32W 
(1.14 ) 01/03/2022
[16245.773131] Call Trace:
[16245.773134]  <TASK>
[16245.773138]  dump_stack_lvl+0x48/0x5e
[16245.773147]  sysfs_warn_dup.cold+0x17/0x24
[16245.773155]  sysfs_add_bin_file_mode_ns+0xae/0xc0
[16245.773160]  internal_create_group+0x1ce/0x390
[16245.773165]  mod_sysfs_setup+0x4e1/0x720
[16245.773171]  load_module+0x25e8/0x27e0
[16245.773178]  ? __do_sys_init_module+0x12e/0x1b0
[16245.773181]  __do_sys_init_module+0x12e/0x1b0
[16245.773185]  do_syscall_64+0x59/0x80
[16245.773189]  ? syscall_exit_to_user_mode+0x23/0x40
[16245.773193]  ? do_syscall_64+0x69/0x80
[16245.773195]  ? syscall_exit_to_user_mode+0x23/0x40
[16245.773198]  ? do_syscall_64+0x69/0x80
[16245.773200]  ? do_user_addr_fault+0x1d7/0x690
[16245.773205]  ? exc_page_fault+0x72/0x170
[16245.773208]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[16245.773213] RIP: 0033:0x7f32283b06ae
[16245.773216] Code: 48 8b 0d ed 66 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 
01 f0 ff ff 73 01 c3 48 8b 0d ba 66 0e 00 f7 d8 64 89 01 48
[16245.773219] RSP: 002b:00007fff964fc8c8 EFLAGS: 00000246 ORIG_RAX: 
00000000000000af
[16245.773223] RAX: ffffffffffffffda RBX: 0000559300c063d0 RCX: 00007f32283b06ae
[16245.773224] RDX: 00007f322879732c RSI: 0000000000037320 RDI: 
00007f3224925010
[16245.773226] RBP: 00007f3224925010 R08: 00007f32249c7000 R09: 
0000000000000000
[16245.773228] R10: 0000000000037701 R11: 0000000000000246 R12: 
00007f322879732c
[16245.773230] R13: 0000559300c06380 R14: 0000000000000000 R15: 
0000559300c08670
[16245.773233]  </TASK>
[16245.774070] Spectre V2 : System may be vulnerable to spectre v2
[16245.774075] lttng_kprobes: loading module not compiled with retpoline 
compiler.
[16245.774608] sysfs: cannot create duplicate filename '/module/lttng_kprobes/
sections/.note.gnu.property'
[16245.774611] CPU: 11 PID: 96193 Comm: lttng-sessiond Tainted: PF          OE     
5.16.15-arch1-1 #1 670d2d5f7504498b520804dd7ff7fca01cc55e90
[16245.774615] Hardware name: LENOVO 20Y30018GE/20Y30018GE, BIOS N40ET32W 
(1.14 ) 01/03/2022
[16245.774617] Call Trace:
[16245.774620]  <TASK>
[16245.774622]  dump_stack_lvl+0x48/0x5e
[16245.774630]  sysfs_warn_dup.cold+0x17/0x24
[16245.774636]  sysfs_add_bin_file_mode_ns+0xae/0xc0
[16245.774643]  internal_create_group+0x1ce/0x390
[16245.774648]  mod_sysfs_setup+0x4e1/0x720
[16245.774655]  load_module+0x25e8/0x27e0
[16245.774659]  ? prepare_alloc_pages.constprop.0+0x7e/0x150
[16245.774668]  ? __do_sys_init_module+0x12e/0x1b0
[16245.774671]  __do_sys_init_module+0x12e/0x1b0
[16245.774675]  do_syscall_64+0x59/0x80
[16245.774681]  ? vfs_read+0xf1/0x190
[16245.774686]  ? syscall_exit_to_user_mode+0x23/0x40
[16245.774690]  ? do_syscall_64+0x69/0x80
[16245.774692]  ? exc_page_fault+0x72/0x170
[16245.774696]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[16245.774700] RIP: 0033:0x7f32283b06ae
[16245.774703] Code: 48 8b 0d ed 66 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 
01 f0 ff ff 73 01 c3 48 8b 0d ba 66 0e 00 f7 d8 64 89 01 48
[16245.774706] RSP: 002b:00007fff964fc8c8 EFLAGS: 00000246 ORIG_RAX: 
00000000000000af
[16245.774711] RAX: ffffffffffffffda RBX: 0000559300c06250 RCX: 00007f32283b06ae
[16245.774713] RDX: 00007f322879732c RSI: 000000000002ee48 RDI: 
0000559300ca7440
[16245.774714] RBP: 0000559300ca7440 R08: 0000000000000000 R09: 
0000000000000000
[16245.774715] R10: 0000000000086551 R11: 0000000000000246 R12: 
00007f322879732c
[16245.774717] R13: 0000559300c06200 R14: 0000000000000000 R15: 
0000559300c06450
[16245.774720]  </TASK>
[16245.775610] Spectre V2 : System may be vulnerable to spectre v2
[16245.775614] lttng_kretprobes: loading module not compiled with retpoline 
compiler.
[16245.775873] sysfs: cannot create duplicate filename '/module/
lttng_kretprobes/sections/.note.gnu.property'
[16245.775876] CPU: 11 PID: 96193 Comm: lttng-sessiond Tainted: PF          OE     
5.16.15-arch1-1 #1 670d2d5f7504498b520804dd7ff7fca01cc55e90
[16245.775881] Hardware name: LENOVO 20Y30018GE/20Y30018GE, BIOS N40ET32W 
(1.14 ) 01/03/2022
[16245.775882] Call Trace:
[16245.775885]  <TASK>
[16245.775887]  dump_stack_lvl+0x48/0x5e
[16245.775893]  sysfs_warn_dup.cold+0x17/0x24
[16245.775898]  sysfs_add_bin_file_mode_ns+0xae/0xc0
[16245.775904]  internal_create_group+0x1ce/0x390
[16245.775909]  mod_sysfs_setup+0x4e1/0x720
[16245.775915]  load_module+0x25e8/0x27e0
[16245.775922]  ? __do_sys_init_module+0x12e/0x1b0
[16245.775925]  __do_sys_init_module+0x12e/0x1b0
[16245.775929]  do_syscall_64+0x59/0x80
[16245.775933]  ? do_user_addr_fault+0x1d7/0x690
[16245.775938]  ? exc_page_fault+0x72/0x170
[16245.775942]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[16245.775947] RIP: 0033:0x7f32283b06ae
[16245.775951] Code: 48 8b 0d ed 66 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 
01 f0 ff ff 73 01 c3 48 8b 0d ba 66 0e 00 f7 d8 64 89 01 48
[16245.775953] RSP: 002b:00007fff964fc8c8 EFLAGS: 00000246 ORIG_RAX: 
00000000000000af
[16245.775957] RAX: ffffffffffffffda RBX: 0000559300c060c0 RCX: 00007f32283b06ae
[16245.775959] RDX: 00007f322879732c RSI: 0000000000032190 RDI: 
0000559300d1ad20
[16245.775961] RBP: 0000559300d1ad20 R08: 0000000000000000 R09: 
0000000000000000
[16245.775962] R10: 000000000000138b R11: 0000000000000246 R12: 
00007f322879732c
[16245.775964] R13: 0000559300c06070 R14: 0000000000000000 R15: 
0000559300c086c0
[16245.775967]  </TASK>
[16245.781844] Spectre V2 : System may be vulnerable to spectre v2
[16245.781851] lttng_lib_ring_buffer: loading module not compiled with 
retpoline compiler.
[16245.782493] sysfs: cannot create duplicate filename '/module/
lttng_lib_ring_buffer/sections/.text'
[16245.782497] CPU: 11 PID: 96193 Comm: lttng-sessiond Tainted: PF          OE     
5.16.15-arch1-1 #1 670d2d5f7504498b520804dd7ff7fca01cc55e90
[16245.782502] Hardware name: LENOVO 20Y30018GE/20Y30018GE, BIOS N40ET32W 
(1.14 ) 01/03/2022
[16245.782505] Call Trace:
[16245.782508]  <TASK>
[16245.782517]  dump_stack_lvl+0x48/0x5e
[16245.782528]  sysfs_warn_dup.cold+0x17/0x24
[16245.782534]  sysfs_add_bin_file_mode_ns+0xae/0xc0
[16245.782541]  internal_create_group+0x1ce/0x390
[16245.782546]  mod_sysfs_setup+0x4e1/0x720
[16245.782552]  load_module+0x25e8/0x27e0
[16245.782559]  ? __do_sys_init_module+0x12e/0x1b0
[16245.782562]  __do_sys_init_module+0x12e/0x1b0
[16245.782567]  do_syscall_64+0x59/0x80
[16245.782571]  ? do_syscall_64+0x69/0x80
[16245.782574]  ? syscall_exit_to_user_mode+0x23/0x40
[16245.782577]  ? do_syscall_64+0x69/0x80
[16245.782580]  ? exc_page_fault+0x72/0x170
[16245.782584]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[16245.782589] RIP: 0033:0x7f32283b06ae
[16245.782593] Code: 48 8b 0d ed 66 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 
01 f0 ff ff 73 01 c3 48 8b 0d ba 66 0e 00 f7 d8 64 89 01 48
[16245.782595] RSP: 002b:00007fff964fc8c8 EFLAGS: 00000246 ORIG_RAX: 
00000000000000af
[16245.782599] RAX: ffffffffffffffda RBX: 0000559300c05f30 RCX: 00007f32283b06ae
[16245.782601] RDX: 00007f322879732c RSI: 0000000000188f58 RDI: 
00007f3224519010
[16245.782602] RBP: 00007f3224519010 R08: 00007f322477c000 R09: 
0000000000000000
[16245.782604] R10: 0000000000062ef1 R11: 0000000000000246 R12: 
00007f322879732c
[16245.782606] R13: 0000559300c05ee0 R14: 0000000000000000 R15: 
0000559300c08710
[16245.782609]  </TASK>
[16245.784406] Spectre V2 : System may be vulnerable to spectre v2
[16245.784411] lttng_statedump: loading module not compiled with retpoline 
compiler.
[16245.784546] lttng_statedump: Unknown symbol wrapper_kallsyms_lookup_name 
(err -2)
[16245.784585] lttng_statedump: Unknown symbol wrapper_irq_to_desc (err -2)
[16246.003631] audit: type=1106 audit(1647613550.654:388): pid=96182 uid=1000 
auid=1000 ses=1 msg='op=PAM:session_close 
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root" exe="/
usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/6 res=success'
[16247.424446] Spectre V2 : System may be vulnerable to spectre v2
[16247.424453] lttng_statedump: loading module not compiled with retpoline 
compiler.
[16247.424612] lttng_statedump: Unknown symbol wrapper_kallsyms_lookup_name 
(err -2)
[16247.424651] lttng_statedump: Unknown symbol wrapper_irq_to_desc (err -2)
```

Thanks
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart4804366.31r3eYUQgx
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEekw
ggWBMIIEaaADAgECAhA5ckQ6+SK3UdfTbBDdMTWVMA0GCSqGSIb3DQEBDAUAMHsxCzAJBgNVBAYT
AkdCMRswGQYDVQQIDBJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNV
BAoMEUNvbW9kbyBDQSBMaW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2VydmljZXMw
HhcNMTkwMzEyMDAwMDAwWhcNMjgxMjMxMjM1OTU5WjCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgT
Ck5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNU
IE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkw
ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCAEmUXNg7D2wiz0KxXDXbtzSfTTK1Qg2Hi
qiBNCS1kCdzOiZ/MPans9s/B3PHTsdZ7NygRK0faOca8Ohm0X6a9fZ2jY0K2dvKpOyuR+OJv0OwW
IJAJPuLodMkYtJHUYmTbf6MG8YgYapAiPLz+E/CHFHv25B+O1ORRxhFnRghRy4YUVD+8M/5+bJz/
Fp0YvVGONaanZshyZ9shZrHUm3gDwFA66Mzw3LyeTP6vBZY1H1dat//O+T23LLb2VN3I5xI6Ta5M
irdcmrS3ID3KfyI0rn47aGYBROcBTkZTmzNg95S+UzeQc0PzMsNT79uq/nROacdrjGCT3sTHDN/h
Mq7MkztReJVni+49Vv4M0GkPGw/zJSZrM233bkf6c0Plfg6lZrEpfDKEY1WJxA3Bk1QwGROs0303
p+tdOmw1XNtB1xLaqUkL39iAigmTYo61Zs8liM2EuLE/pDkP2QKe6xJMlXzzawWpXhaDzLhn4ugT
ncxbgtNMs+1b/97lc6wjOy0AvzVVdAlJ2ElYGn+SNuZRkg7zJn0cTRe8yexDJtC/QV9AqURE9Jnn
V4eeUB9XVKg+/XRjL7FQZQnmWEIuQxpMtPAlR1n6BB6T1CZGSlCBst6+eLf8ZxXhyVeEHg9j1uli
utZfVS7qXMYoCAQlObgOK6nyTJccBz8NUvXt7y+CDwIDAQABo4HyMIHvMB8GA1UdIwQYMBaAFKAR
CiM+lvEH7OKvKe+CpX/QMKS0MB0GA1UdDgQWBBRTeb9aqitKz1SA4dibwJ3ysgNmyzAOBgNVHQ8B
Af8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zARBgNVHSAECjAIMAYGBFUdIAAwQwYDVR0fBDwwOjA4
oDagNIYyaHR0cDovL2NybC5jb21vZG9jYS5jb20vQUFBQ2VydGlmaWNhdGVTZXJ2aWNlcy5jcmww
NAYIKwYBBQUHAQEEKDAmMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wDQYJ
KoZIhvcNAQEMBQADggEBABiHUdx0IT2ciuAntzPQLszs8ObLXhHeIm+bdY6ecv7k1v6qH5yWLe8D
Sn6u9I1vcjxDO8A/67jfXKqpxq7y/Njuo3tD9oY2fBTgzfT3P/7euLSK8JGW/v1DZH79zNIBoX19
+BkZyUIrE79Yi7qkomYEdoiRTgyJFM6iTckys7roFBq8cfFb8EELmAAKIgMQ5Qyx+c2SNxntO/Hk
Orb5RRMmda+7qu8/e3c70sQCkT0ZANMXXDnbP3sYDUXNk4WWL13fWRZPP1G91UUYP+1KjugGYXQj
FrUNUHMnREd/EF2JKmuFMRTE6KlqTIC8anjPuH+OdnKZDJ3+15EIFqGjX5UwggYQMIID+KADAgEC
AhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UE
CBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJV
U1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UE
CBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
IExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyjztlApB/975
Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUfItMltrMaXqcESJuK
8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeWQcpGEGFUUd0kN+oH
ox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YBrf24k5Ee1sLTHsLt
piK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewDch/8kHPo5fZl5u1B
0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHY
m8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1UdDwEB/wQEAwIBhjAS
BgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAE
CjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VT
RVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/Bggr
BgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0Q0Eu
Y3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUA
A4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+xswhh2GqkW5JQrM8
zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9IHk96VwsacIvBF8J
fqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7kkmka2RQb9d90nmN
HdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1eoYV7lNwNBKpeHdN
uO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4KxaYIhvqPqUMWqRd
Wyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL1Ygz3SBsyECa0waq
4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQOZ1YL5ezMTX0ZSLw
rymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qodx/PL+5jR87myx5uY
dBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i5ZgtwCLXgAIe5W8m
ybM2JzCCBkwwggU0oAMCAQICEHR8gsPqhWo7MMOepQh9ypIwDQYJKoZIhvcNAQELBQAwgZYxCzAJ
BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQx
GDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1
dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMjAwNTEyMDAwMDAwWhcNMjMwNTEy
MjM1OTU5WjCCAVkxCzAJBgNVBAYTAlNFMQ8wDQYDVQQREwY2ODMgMzExEjAQBgNVBAgTCVZhZXJt
bGFuZDEQMA4GA1UEBxMHSGFnZm9yczEYMBYGA1UECRMPTm9ycmluZ3MgdmFlZyAyMQ8wDQYDVQQS
EwZCb3ggMzAxJjAkBgNVBAoMHUtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCMR0wGwYDVQQL
ExRBIEtEQUIgR3JvdXAgQ29tcGFueTFDMEEGA1UECww6SXNzdWVkIHRocm91Z2ggS2xhcsOkbHZk
YWxlbnMgRGF0YWtvbnN1bHQgQUIgRS1QS0kgTWFuYWdlcjEfMB0GA1UECxMWQ29ycG9yYXRlIFNl
Y3VyZSBFbWFpbDEVMBMGA1UEAxMMTWlsaWFuIFdvbGZmMSQwIgYJKoZIhvcNAQkBFhVtaWxpYW4u
d29sZmZAa2RhYi5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC8vdk66W4eo0O1
1Dh3zPXW/zrkwzzxRR0Air/VRxAIG5q/klE9mF2gsGBPXQpCtDMvkuvSLQ+5mR50Cb+V+4Y9n0W6
98JoyQHYAo6uswLyTchcF6IVckkkZrm1RD1DXnlIHpCsacO7PDDxMslzFs5XZfRkH4F1SKkiVwup
/Nsn0z12SGRzxSUUxr4VHZgIqgRGqVSbVJfjtTRigAu+fmXUXHs0bMRv8TonzrDRlN61m1UakrFu
qvKAgXYfZULZ52IKNK/jq8nPHJDD9oOr5pVi4Yx9GyVeMM0qNPC74fJnGh7lOpJiAcqYBEis73lm
U+RtH3Bj85Qdqvwxo3bf7s1zAgMBAAGjggHOMIIByjAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+o
mULPyeCtADAdBgNVHQ4EFgQUMc6p+s2l6xbyh8jLYeP7fQrRiW4wDgYDVR0PAQH/BAQDAgWgMAwG
A1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYM
KwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1Ud
HwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhl
bnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcw
AoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25h
bmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20w
IAYDVR0RBBkwF4EVbWlsaWFuLndvbGZmQGtkYWIuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQBW3rFX
47Cnu8JMNm8row/96V8xGwPzir9lEpnasNxi+GhvQjGzvoP5oxMoBJ+hgD8fMk5X15IDuKa9KVHb
BzBG9kOPGB4h/89voWpzWIVy7Q3k+dPByfghbufR+83TvN20lV9VqXYjPeYypHlD/vJ4Z8iWn3s3
0iUfYr1CCr8zoje1hijPM9A0wN7K8iCtIc4OAfJpwKsXMCNAv1SdxD196vCKrTnWiEmAw0g8FpDM
GWIww0+2Qq+Peeoe53+34GetRPIbS5jPlCEy7xgC8c7qoJTNzhCyVENRByoA5dsLzK+Nv0IT1h2C
gu2w5VxHo0DjlCmYddu46uwpWjKpNuhaMYICbTCCAmkCAQEwgaswgZYxCzAJBgNVBAYTAkdCMRsw
GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1Nl
Y3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9u
IGFuZCBTZWN1cmUgRW1haWwgQ0ECEHR8gsPqhWo7MMOepQh9ypIwDQYJYIZIAWUDBAIBBQCggZMw
GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjIwMzE4MTQzNDM2WjAo
BgkqhkiG9w0BCQ8xGzAZMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQg
Jk/ubgc14w5jMOVeznMX2pY4oqsAH1HUK99NILaLTAwwDQYJKoZIhvcNAQEBBQAEggEABdW2uu2T
NmZRQnV0itvXHhN0qVMnnZoJ6k8Y5G7Da6t623fG4uFloBhkLz2M5zhvmNHdOepCyq/Gx2w4vppt
Ke23fmX2YqA6S1gDwBedqFcyLzwoVOfu6tOrstu19bSc7yfNHr/qkjnox/FjOmnPNiSDxOPasV0a
ihW1NtJv14W2N8wxfdf1CZHJ7w8EQgy7lemOYdc3a0RT8Yra7iT5t6gzaOJGbjkS5zWf2aQztfVm
jT5eFvGx43hQC3gs+WEBQpmXIdp4gmKYbbPa6N8wPt8ez1zTEQFyPML6gC9ioIABzL/VFnAIBipq
47tfKGXCbThmYTc+QqpP2pOIjaJx4gAAAAAAAA==


--nextPart4804366.31r3eYUQgx--



--===============8480819974722930437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8480819974722930437==--


