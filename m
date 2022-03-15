Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CFDC433F5
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Mar 2022 14:19:57 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KHwXW4HWDzDQg;
	Tue, 15 Mar 2022 10:19:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1647353996;
	bh=xVg/jR4koGell87F5lcYZGeQqlAFOC7q569dF4WjI58=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=m/o/eQXKRGLJm0o76MRwfRAb9ICWzGIERiIWx5i/k7grYRCZkfzy9gr07mQcI/7Og
	 aUn6n9+waE3loGjYQq3jFkzsFPdG8jgrfGHt8gTRwi7edRue5s/F4kCcw0yxTBHGi9
	 TTsRTiwxftFw8MSSAlBF2QkBVZ/IeiKiNG9Hv17N6yUcPP/BKFHwX3UezoaxcfY6AV
	 EGWh0l34EgfGfXhsrbEoCS4ttk5hO56F3Jndv2mZQlplo4oRULwPKRNdxJmVoy6fuI
	 5eDmNSHB8oqOQaeLai2a5ZzO2yH4UOMIiz7/LsU0ZTwYPH/Z3ISr7HJGn4I5AZJItS
	 RLbDEG4Vc7FRQ==
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 by lists.lttng.org (Postfix) with ESMTPS id 4KHkXD2J2hzDbp
 for <lttng-dev@lists.lttng.org>; Tue, 15 Mar 2022 02:48:59 -0400 (EDT)
Received: by mail-io1-xd33.google.com with SMTP id e22so21083306ioe.11
 for <lttng-dev@lists.lttng.org>; Mon, 14 Mar 2022 23:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=WFoe5EpdxW8QwAH3crxn3NVYlsqQY3vYMULajvYshU4=;
 b=HnBTp/hoe0lmoleVxsZgntYUjBtnmnqS014KYJedzD0Mv1jhIhrzkhcr8ZZua94ehJ
 /s5Vv5Cq/gSE5XFkigfoHgldXKCsD5pfx1VktNvxoZ1Hp6r2VNJlvai4LkCMkHqjXjrH
 HY3gFqtOFXQZ4lYvkOAa8i4S8u+TGAuHw7gy1k8uRXg5m19krQpvJzSKS6m/GcgKT+WM
 Lebv+UNc0cosJyYecTBQt2oIbAZcWH/zDmsXlhNJuE6Kn5x96z8Vw0WMBoq3i5JjqoEf
 sjjyTewYfyxKfo3hVdlQsqPbeyBCBR/bN/QPMfLcjiek3aN6+S8GXMG97hT1p+NpG//L
 tGNQ==
X-Gm-Message-State: AOAM532aMSL1+0snrHhBSdgM6MUafZZ6Fg9he8wfoYBwsNCxsveEKg7C
 vk3zb0azLv1Csr41iS20pHc7ZPKIyvqlpJW5E2d4sap5p8onMl4mUblA1ORrbN2BOJ51evlsGgU
 W779lVtiP8D43tVtUwR/CsCEtpGltAk0p5YXkEg==
X-Google-Smtp-Source: ABdhPJwj23rsS3Ntg2Xp8nWvxb7HRAZm+wIcTX2AuLZwb5GyUb2Ary7vg0Tl5iyjMJlvPbTQJR/XOMXBjxDmV6s7NFE=
X-Received: by 2002:a05:6638:1a1a:b0:317:c31b:c674 with SMTP id
 cd26-20020a0566381a1a00b00317c31bc674mr21913115jab.79.1647326938671; Mon, 14
 Mar 2022 23:48:58 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 15 Mar 2022 12:18:48 +0530
Message-ID: <CAB9=ZW6FEj+zXnVcSaCGCSWF54cZDEv5_25-F0D1SEZHZaZ=rw@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Tue, 15 Mar 2022 10:19:53 -0400
Subject: [lttng-dev] call trace while using lttng in petalinux 2019.2
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
From: GOLLAMUDI MADHAN MOHAN via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: GOLLAMUDI MADHAN MOHAN <madhan.mohan@5g.iith.ac.in>
Content-Type: multipart/mixed; boundary="===============7551828730253643517=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7551828730253643517==
Content-Type: multipart/alternative; boundary="00000000000002465505da3c3199"

--00000000000002465505da3c3199
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Sir/Madam,
                           I am Madhan , working as an embedded engineer in
5GTB. I am using lttng in petalinux 2019.2(kernel 4.19) .And getting a call
Trace error. Refer the below log for more details.


root@xilinx-zcu111-2019_2:~# lttng create
Spawning a session daemon
[  163.902282] lttng_kretprobes: loading out-of-tree module taints kernel.
[  163.987461] Unable to handle kernel paging request at virtual address
00000000000010c0
[  163.995379] Mem abort info:
[  163.998179]   ESR =3D 0x96000005
[  164.001233]   Exception class =3D DABT (current EL), IL =3D 32 bits
[  164.007149]   SET =3D 0, FnV =3D 0
[  164.010203]   EA =3D 0, S1PTW =3D 0
[  164.013333] Data abort info:
[  164.016218]   ISV =3D 0, ISS =3D 0x00000005
[  164.020054]   CM =3D 0, WnR =3D 0
[  164.023028] user pgtable: 4k pages, 39-bit VAs, pgdp =3D 00000000df6dd54=
e
[  164.029646] [00000000000010c0] pgd=3D0000000000000000, pud=3D00000000000=
00000
[  164.036447] Internal error: Oops: 96000005 [#1] SMP
[  164.041318] Modules linked in: lttng_tracer(O+) lttng_statedump(O)
lttng_ftrace(O) lttng_kprobes(O) lttng_clock(O) lttng_lib_ring_buffer(O)
lttng_kretprobes(O) uio_pdrv_genirq
[  164.056963] CPU: 1 PID: 4955 Comm: modprobe Tainted: G           O
 4.19.0-xilinx-v2019.2 #1
[  164.065734] Hardware name: ZynqMP ZCU111 RevA (DT)
[  164.070510] pstate: 60000005 (nZCv daif -PAN -UAO)
[  164.075429] pc : lttng_tracepoint_notify+0x188/0x228 [lttng_tracer]
[  164.081767] lr : lttng_tracepoint_notify+0x14c/0x228 [lttng_tracer]
[  164.088016] sp : ffffff8011613a40
[  164.091314] x29: ffffff8011613a40 x28: ffffff801163f000
[  164.096618] x27: 0000000000000100 x26: ffffff800813c958
[  164.101921] x25: ffffff8000e22758 x24: 0000000000000000
[  164.107225] x23: 00000000000010c0 x22: ffffff8000e42ed8
[  164.112528] x21: ffffffc87accc400 x20: ffffff8000e42ef8
[  164.117832] x19: 0000000000000001 x18: 0000000000000000
[  164.123135] x17: 0000000000000000 x16: 0000000000000000
[  164.128439] x15: ffffffffffffffff x14: 0000000000000000
[  164.133742] x13: 0000000000000000 x12: 0000000000000000
[  164.139046] x11: 0000000000000001 x10: 0101010101010101
[  164.144349] x9 : 6d64686b625e6f38 x8 : 706d75645f6c6f63
[  164.149653] x7 : 6f746f72705f7039 x6 : ffffffc8778d5ec1
[  164.154957] x5 : ffffff8009458000 x4 : 0000000000000000
[  164.160260] x3 : ffffff8000db77a0 x2 : ffffffc87828a380
[  164.165563] x1 : 0000000000000007 x0 : ffffff8000d13048
[  164.170869] Process modprobe (pid: 4955, stack limit =3D
0x00000000e6162018)
[  164.177725] Call trace:
[  164.180235]  lttng_tracepoint_notify+0x188/0x228 [lttng_tracer]
[  164.186148]  register_tracepoint_module_notifier+0x6c/0x98
[  164.191709]  lttng_tracepoint_init+0x54/0xc80 [lttng_tracer]
[  164.197438]  lttng_events_init+0x4c/0x1e0 [lttng_tracer]
[  164.202734]  do_one_initcall+0x68/0x1ec
[  164.206562]  do_init_module+0x60/0x1f0
[  164.210302]  load_module+0x1ca0/0x2270
[  164.214035]  __se_sys_finit_module+0xc0/0xd0
[  164.218288]  __arm64_sys_finit_module+0x24/0x30
[  164.222802]  el0_svc_common+0x98/0x100
[  164.226543]  el0_svc_handler+0x74/0x90
[  164.230275]  el0_svc+0x8/0xc
[  164.233142] Code: 6b18003f 54fffc49 f9415c00 b8b8d817 (f94002f3)
[  164.239226] ---[ end trace c1cc2d1f9d55794a ]---
[  195.613567] lttng_ring_buffer_client_overwrite: gave up waiting for init
of module lttng_tracer.
[  195.622371] lttng_ring_buffer_client_overwrite: Unknown symbol
lttng_transport_unregister (err -16)
^C
root@xilinx-zcu111-2019_2:~# uname -a
Linux xilinx-zcu111-2019_2 4.19.0-xilinx-v2019.2 #1 SMP Mon Mar 14 15:09:26
UTC 2022 aarch64 GNU/Linux
root@xilinx-zcu111-2019_2:~# uname -a
Linux xilinx-zcu111-2019_2 4.19.0-xilinx-v2019.2 #1 SMP Mon Mar 14 15:09:26
UTC 2022 aarch64 GNU/Linux
root@xilinx-zcu111-2019_2:~# [  226.333565]
lttng_ring_buffer_client_overwrite: gave up waiting for init of module
lttng_tracer.
[  226.342368] lttng_ring_buffer_client_overwrite: Unknown symbol
lttng_last_tsc (err -16)
[  257.053564] lttng_ring_buffer_client_overwrite: gave up waiting for init
of module lttng_tracer.
[  257.062358] lttng_ring_buffer_client_overwrite: Unknown symbol
lttng_transport_register (err -16)
[  287.773562] lttng_ring_buffer_client_overwrite: gave up waiting for init
of module lttng_tracer.
[  287.782356] lttng_ring_buffer_client_overwrite: Unknown symbol
lttng_transport_unregister (err -16)
[  318.493567] lttng_ring_buffer_client_overwrite: gave up waiting for init
of module lttng_tracer.
[  318.502364] lttng_ring_buffer_client_overwrite: Unknown symbol
lttng_last_tsc (err -16)
[  349.213564] lttng_ring_buffer_client_overwrite: gave up waiting for init
of module lttng_tracer.
[  349.222363] lttng_ring_buffer_client_overwrite: Unknown symbol
lttng_transport_register (err -16)


Thank You
with regards
G Madhan Mohan

--=20


Disclaimer:- This=C2=A0footer text is to convey that this email is sent by =
one=20
of the=C2=A0users of IITH. So, do not mark it as SPAM.

--00000000000002465505da3c3199
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Sir/Madam,<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I am Madhan , wo=
rking as an embedded=C2=A0engineer=C2=A0in 5GTB. I am using=C2=A0lttng in p=
etalinux 2019.2(kernel 4.19) .And getting a call Trace error. Refer the bel=
ow log for more=C2=A0details.</div><div><br></div><div><br></div><div>root@=
xilinx-zcu111-2019_2:~# lttng create<br>Spawning a session daemon<br>[ =C2=
=A0163.902282] lttng_kretprobes: loading out-of-tree module taints kernel.<=
br>[ =C2=A0163.987461] Unable to handle kernel paging request at virtual ad=
dress 00000000000010c0<br>[ =C2=A0163.995379] Mem abort info:<br>[ =C2=A016=
3.998179] =C2=A0 ESR =3D 0x96000005<br>[ =C2=A0164.001233] =C2=A0 Exception=
 class =3D DABT (current EL), IL =3D 32 bits<br>[ =C2=A0164.007149] =C2=A0 =
SET =3D 0, FnV =3D 0<br>[ =C2=A0164.010203] =C2=A0 EA =3D 0, S1PTW =3D 0<br=
>[ =C2=A0164.013333] Data abort info:<br>[ =C2=A0164.016218] =C2=A0 ISV =3D=
 0, ISS =3D 0x00000005<br>[ =C2=A0164.020054] =C2=A0 CM =3D 0, WnR =3D 0<br=
>[ =C2=A0164.023028] user pgtable: 4k pages, 39-bit VAs, pgdp =3D 00000000d=
f6dd54e<br>[ =C2=A0164.029646] [00000000000010c0] pgd=3D0000000000000000, p=
ud=3D0000000000000000<br>[ =C2=A0164.036447] Internal error: Oops: 96000005=
 [#1] SMP<br>[ =C2=A0164.041318] Modules linked in: lttng_tracer(O+) lttng_=
statedump(O) lttng_ftrace(O) lttng_kprobes(O) lttng_clock(O) lttng_lib_ring=
_buffer(O) lttng_kretprobes(O) uio_pdrv_genirq<br>[ =C2=A0164.056963] CPU: =
1 PID: 4955 Comm: modprobe Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O =
=C2=A0 =C2=A0 =C2=A04.19.0-xilinx-v2019.2 #1<br>[ =C2=A0164.065734] Hardwar=
e name: ZynqMP ZCU111 RevA (DT)<br>[ =C2=A0164.070510] pstate: 60000005 (nZ=
Cv daif -PAN -UAO)<br>[ =C2=A0164.075429] pc : lttng_tracepoint_notify+0x18=
8/0x228 [lttng_tracer]<br>[ =C2=A0164.081767] lr : lttng_tracepoint_notify+=
0x14c/0x228 [lttng_tracer]<br>[ =C2=A0164.088016] sp : ffffff8011613a40<br>=
[ =C2=A0164.091314] x29: ffffff8011613a40 x28: ffffff801163f000 <br>[ =C2=
=A0164.096618] x27: 0000000000000100 x26: ffffff800813c958 <br>[ =C2=A0164.=
101921] x25: ffffff8000e22758 x24: 0000000000000000 <br>[ =C2=A0164.107225]=
 x23: 00000000000010c0 x22: ffffff8000e42ed8 <br>[ =C2=A0164.112528] x21: f=
fffffc87accc400 x20: ffffff8000e42ef8 <br>[ =C2=A0164.117832] x19: 00000000=
00000001 x18: 0000000000000000 <br>[ =C2=A0164.123135] x17: 000000000000000=
0 x16: 0000000000000000 <br>[ =C2=A0164.128439] x15: ffffffffffffffff x14: =
0000000000000000 <br>[ =C2=A0164.133742] x13: 0000000000000000 x12: 0000000=
000000000 <br>[ =C2=A0164.139046] x11: 0000000000000001 x10: 01010101010101=
01 <br>[ =C2=A0164.144349] x9 : 6d64686b625e6f38 x8 : 706d75645f6c6f63 <br>=
[ =C2=A0164.149653] x7 : 6f746f72705f7039 x6 : ffffffc8778d5ec1 <br>[ =C2=
=A0164.154957] x5 : ffffff8009458000 x4 : 0000000000000000 <br>[ =C2=A0164.=
160260] x3 : ffffff8000db77a0 x2 : ffffffc87828a380 <br>[ =C2=A0164.165563]=
 x1 : 0000000000000007 x0 : ffffff8000d13048 <br>[ =C2=A0164.170869] Proces=
s modprobe (pid: 4955, stack limit =3D 0x00000000e6162018)<br>[ =C2=A0164.1=
77725] Call trace:<br>[ =C2=A0164.180235] =C2=A0lttng_tracepoint_notify+0x1=
88/0x228 [lttng_tracer]<br>[ =C2=A0164.186148] =C2=A0register_tracepoint_mo=
dule_notifier+0x6c/0x98<br>[ =C2=A0164.191709] =C2=A0lttng_tracepoint_init+=
0x54/0xc80 [lttng_tracer]<br>[ =C2=A0164.197438] =C2=A0lttng_events_init+0x=
4c/0x1e0 [lttng_tracer]<br>[ =C2=A0164.202734] =C2=A0do_one_initcall+0x68/0=
x1ec<br>[ =C2=A0164.206562] =C2=A0do_init_module+0x60/0x1f0<br>[ =C2=A0164.=
210302] =C2=A0load_module+0x1ca0/0x2270<br>[ =C2=A0164.214035] =C2=A0__se_s=
ys_finit_module+0xc0/0xd0<br>[ =C2=A0164.218288] =C2=A0__arm64_sys_finit_mo=
dule+0x24/0x30<br>[ =C2=A0164.222802] =C2=A0el0_svc_common+0x98/0x100<br>[ =
=C2=A0164.226543] =C2=A0el0_svc_handler+0x74/0x90<br>[ =C2=A0164.230275] =
=C2=A0el0_svc+0x8/0xc<br>[ =C2=A0164.233142] Code: 6b18003f 54fffc49 f9415c=
00 b8b8d817 (f94002f3) <br>[ =C2=A0164.239226] ---[ end trace c1cc2d1f9d557=
94a ]---<br>[ =C2=A0195.613567] lttng_ring_buffer_client_overwrite: gave up=
 waiting for init of module lttng_tracer.<br>[ =C2=A0195.622371] lttng_ring=
_buffer_client_overwrite: Unknown symbol lttng_transport_unregister (err -1=
6)<br>^C<br>root@xilinx-zcu111-2019_2:~# uname -a<br>Linux xilinx-zcu111-20=
19_2 4.19.0-xilinx-v2019.2 #1 SMP Mon Mar 14 15:09:26 UTC 2022 aarch64 GNU/=
Linux<br>root@xilinx-zcu111-2019_2:~# uname -a<br>Linux xilinx-zcu111-2019_=
2 4.19.0-xilinx-v2019.2 #1 SMP Mon Mar 14 15:09:26 UTC 2022 aarch64 GNU/Lin=
ux<br>root@xilinx-zcu111-2019_2:~# [ =C2=A0226.333565] lttng_ring_buffer_cl=
ient_overwrite: gave up waiting for init of module lttng_tracer.<br>[ =C2=
=A0226.342368] lttng_ring_buffer_client_overwrite: Unknown symbol lttng_las=
t_tsc (err -16)<br>[ =C2=A0257.053564] lttng_ring_buffer_client_overwrite: =
gave up waiting for init of module lttng_tracer.<br>[ =C2=A0257.062358] ltt=
ng_ring_buffer_client_overwrite: Unknown symbol lttng_transport_register (e=
rr -16)<br>[ =C2=A0287.773562] lttng_ring_buffer_client_overwrite: gave up =
waiting for init of module lttng_tracer.<br>[ =C2=A0287.782356] lttng_ring_=
buffer_client_overwrite: Unknown symbol lttng_transport_unregister (err -16=
)<br>[ =C2=A0318.493567] lttng_ring_buffer_client_overwrite: gave up waitin=
g for init of module lttng_tracer.<br>[ =C2=A0318.502364] lttng_ring_buffer=
_client_overwrite: Unknown symbol lttng_last_tsc (err -16)<br>[ =C2=A0349.2=
13564] lttng_ring_buffer_client_overwrite: gave up waiting for init of modu=
le lttng_tracer.<br>[ =C2=A0349.222363] lttng_ring_buffer_client_overwrite:=
 Unknown symbol lttng_transport_register (err -16)<br></div><div><br></div>=
<div><br></div><div>Thank You=C2=A0</div><div>with regards</div><div>G Madh=
an Mohan</div></div>

<br>
<span><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom=
:0pt"><span style=3D"font-size:11pt;font-family:Arial;color:rgb(34,34,34);v=
ertical-align:baseline;white-space:pre-wrap;background-color:yellow">Discla=
imer:- </span><span style=3D"background-color:rgb(255,255,255);color:rgb(34=
,34,34);font-size:small">This=C2=A0</span><span style=3D"background-color:r=
gb(255,255,255);color:rgb(34,34,34);font-size:small">footer text is to conv=
ey that this email is sent by one of the=C2=A0</span><span style=3D"backgro=
und-color:rgb(255,255,255);color:rgb(34,34,34);font-size:small">users of II=
TH. So, do not mark it as SPAM.</span></p></span>
--00000000000002465505da3c3199--

--===============7551828730253643517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7551828730253643517==--
