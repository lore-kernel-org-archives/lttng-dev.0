Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69B8C433EF
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Mar 2022 13:25:19 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KJWH2143zzDvv;
	Wed, 16 Mar 2022 09:25:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1647437118;
	bh=IJXrK4HTIt3KYnYQa0ezkHck6GIzM33byifvte5K8Fo=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QU35WFBNmDSkhfAsqbe7nIPUIqGbvzNgHPwJK10Gh12z4didM2Qvkw+mRECx51lqB
	 w61x6C2HNvKTs/KlFATSCeBJ16defM0hPjghrE8VfxN3GhAiYgAM77hpcVF70XY1G8
	 awsh2XZ8Ehc/BtW3rg6v69MDraCP5Y8khB4dOw5iPjvw9RGyQnZKTVsfA7/zaG4R9r
	 p4qhsvq31fmHA62ex++IPIniwRX1BVoHTuZgsO6vPkbsQvuGmwqPYKZuD03GJZAhTe
	 ioE8DY4rYzl9cjAQBh+jFF3CoxEMVgzjMwz9lrIN4J4TfX0L/UjjNwlyqJ+ClSBPXL
	 F45AN7dPArxFA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KJWH01W7czF59
 for <lttng-dev@lists.lttng.org>; Wed, 16 Mar 2022 09:25:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A6B793E5D95
 for <lttng-dev@lists.lttng.org>; Wed, 16 Mar 2022 09:25:09 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id m09M1nEzaVlb; Wed, 16 Mar 2022 09:25:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C04803E5AD7;
 Wed, 16 Mar 2022 09:25:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C04803E5AD7
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 08tw3yb_q0Pc; Wed, 16 Mar 2022 09:25:08 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id B1F063E5BF7;
 Wed, 16 Mar 2022 09:25:08 -0400 (EDT)
Date: Wed, 16 Mar 2022 09:25:08 -0400 (EDT)
To: GOLLAMUDI MADHAN MOHAN <madhan.mohan@5g.iith.ac.in>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <239772948.153082.1647437108628.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAB9=ZW6nDGJ+xv+6h4FHL2-63J9YE5P1KoAyvB+yWAx0rr46wA@mail.gmail.com>
References: <CAB9=ZW6FEj+zXnVcSaCGCSWF54cZDEv5_25-F0D1SEZHZaZ=rw@mail.gmail.com>
 <795806806.151478.1647359382157.JavaMail.zimbra@efficios.com>
 <CAB9=ZW6nDGJ+xv+6h4FHL2-63J9YE5P1KoAyvB+yWAx0rr46wA@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Topic: call trace while using lttng in petalinux 2019.2 (kernel 4.19)
Thread-Index: xfWBSDPQScJfooyP4oiuZ8X3XIi3aQ==
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
Content-Type: multipart/mixed; boundary="===============4404688676320869315=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4404688676320869315==
Content-Type: multipart/alternative; 
	boundary="=_ab51642b-f666-4612-892d-490cf9664c7a"

--=_ab51642b-f666-4612-892d-490cf9664c7a
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Mar 16, 2022, at 8:17 AM, GOLLAMUDI MADHAN MOHAN <madhan.mohan@5g.=
iith.ac.in> wrote:=20

> hi sir,
> lttng version 2.9.5 - Joann=C3=A8s
> modinfo command is not available used $ lttng version command

Hi,=20

Please keep the lttng-dev mailing list in CC, as this discussion started th=
ere. The=20
answers we come up with can be useful to others.=20

The version you provided here is the version of lttng-tools installed on yo=
ur system,=20
which is not relevant to investigate your issue.=20

What is needed here is the version of lttng-modules: the Linux kernel modul=
es implementing=20
the kernel tracing feature of LTTng. Those are different packages altogethe=
r.=20

May I recommend that you install the package containing the "modinfo" tool =
on your system=20
to query the lttng-modules version ?=20

An alternative to query the lttng-modules version, if you really cannot ins=
tall modinfo, would=20
be:=20

strings /lib/modules/$(uname -r)/extra/lttng-tracer.ko | grep "^version=3D"=
=20

Thank you,=20

Mathieu=20

> Thank You
> with regards
> G Madhan Mohan

> On Tue, Mar 15, 2022 at 9:19 PM Mathieu Desnoyers < [
> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] =
>
> wrote:

>> ----- On Mar 15, 2022, at 2:48 AM, lttng-dev [ mailto:lttng-dev@lists.lt=
tng.org
>> | lttng-dev@lists.lttng.org ] wrote:

>> > Dear Sir/Madam,
>> > I am Madhan , working as an embedded engineer in 5GTB. I am using lttn=
g in
>> > petalinux 2019.2(kernel 4.19) .And getting a call Trace error. Refer t=
he below
>> > log for more details.

>> > root@xilinx-zcu111-2019_2:~# lttng create
>> > Spawning a session daemon
>> > [ 163.902282] lttng_kretprobes: loading out-of-tree module taints kern=
el.
>> > [ 163.987461] Unable to handle kernel paging request at virtual addres=
s
>> > 00000000000010c0
>> > [ 163.995379] Mem abort info:
>> > [ 163.998179] ESR =3D 0x96000005
>> > [ 164.001233] Exception class =3D DABT (current EL), IL =3D 32 bits
>> > [ 164.007149] SET =3D 0, FnV =3D 0
>> > [ 164.010203] EA =3D 0, S1PTW =3D 0
>> > [ 164.013333] Data abort info:
>> > [ 164.016218] ISV =3D 0, ISS =3D 0x00000005
>> > [ 164.020054] CM =3D 0, WnR =3D 0
>> > [ 164.023028] user pgtable: 4k pages, 39-bit VAs, pgdp =3D 00000000df6=
dd54e
>> > [ 164.029646] [00000000000010c0] pgd=3D0000000000000000, pud=3D0000000=
000000000
>> > [ 164.036447] Internal error: Oops: 96000005 [#1] SMP
>> > [ 164.041318] Modules linked in: lttng_tracer(O+) lttng_statedump(O)
>> > lttng_ftrace(O) lttng_kprobes(O) lttng_clock(O) lttng_lib_ring_buffer(=
O)
>> > lttng_kretprobes(O) uio_pdrv_genirq
>> > [ 164.056963] CPU: 1 PID: 4955 Comm: modprobe Tainted: G O 4.19.0-xili=
nx-v2019.2
>> > #1
>> > [ 164.065734] Hardware name: ZynqMP ZCU111 RevA (DT)
>> > [ 164.070510] pstate: 60000005 (nZCv daif -PAN -UAO)
>> > [ 164.075429] pc : lttng_tracepoint_notify+0x188/0x228 [lttng_tracer]
>> > [ 164.081767] lr : lttng_tracepoint_notify+0x14c/0x228 [lttng_tracer]
>> > [ 164.088016] sp : ffffff8011613a40
>> > [ 164.091314] x29: ffffff8011613a40 x28: ffffff801163f000
>> > [ 164.096618] x27: 0000000000000100 x26: ffffff800813c958
>> > [ 164.101921] x25: ffffff8000e22758 x24: 0000000000000000
>> > [ 164.107225] x23: 00000000000010c0 x22: ffffff8000e42ed8
>> > [ 164.112528] x21: ffffffc87accc400 x20: ffffff8000e42ef8
>> > [ 164.117832] x19: 0000000000000001 x18: 0000000000000000
>> > [ 164.123135] x17: 0000000000000000 x16: 0000000000000000
>> > [ 164.128439] x15: ffffffffffffffff x14: 0000000000000000
>> > [ 164.133742] x13: 0000000000000000 x12: 0000000000000000
>> > [ 164.139046] x11: 0000000000000001 x10: 0101010101010101
>> > [ 164.144349] x9 : 6d64686b625e6f38 x8 : 706d75645f6c6f63
>> > [ 164.149653] x7 : 6f746f72705f7039 x6 : ffffffc8778d5ec1
>> > [ 164.154957] x5 : ffffff8009458000 x4 : 0000000000000000
>> > [ 164.160260] x3 : ffffff8000db77a0 x2 : ffffffc87828a380
>> > [ 164.165563] x1 : 0000000000000007 x0 : ffffff8000d13048
>> > [ 164.170869] Process modprobe (pid: 4955, stack limit =3D 0x00000000e=
6162018)
>> > [ 164.177725] Call trace:
>> > [ 164.180235] lttng_tracepoint_notify+0x188/0x228 [lttng_tracer]
>> > [ 164.186148] register_tracepoint_module_notifier+0x6c/0x98
>> > [ 164.191709] lttng_tracepoint_init+0x54/0xc80 [lttng_tracer]
>> > [ 164.197438] lttng_events_init+0x4c/0x1e0 [lttng_tracer]
>> > [ 164.202734] do_one_initcall+0x68/0x1ec
>> > [ 164.206562] do_init_module+0x60/0x1f0
>> > [ 164.210302] load_module+0x1ca0/0x2270
>> > [ 164.214035] __se_sys_finit_module+0xc0/0xd0
>> > [ 164.218288] __arm64_sys_finit_module+0x24/0x30
>> > [ 164.222802] el0_svc_common+0x98/0x100
>> > [ 164.226543] el0_svc_handler+0x74/0x90
>> > [ 164.230275] el0_svc+0x8/0xc
>> > [ 164.233142] Code: 6b18003f 54fffc49 f9415c00 b8b8d817 (f94002f3)
>> > [ 164.239226] ---[ end trace c1cc2d1f9d55794a ]---
>> > [ 195.613567] lttng_ring_buffer_client_overwrite: gave up waiting for =
init of
>> > module lttng_tracer.
>> > [ 195.622371] lttng_ring_buffer_client_overwrite: Unknown symbol
>> > lttng_transport_unregister (err -16)
>> > ^C
>> > root@xilinx-zcu111-2019_2:~# uname -a
>> > Linux xilinx-zcu111-2019_2 4.19.0-xilinx-v2019.2 #1 SMP Mon Mar 14 15:=
09:26 UTC
>> > 2022 aarch64 GNU/Linux
>> > root@xilinx-zcu111-2019_2:~# uname -a
>> > Linux xilinx-zcu111-2019_2 4.19.0-xilinx-v2019.2 #1 SMP Mon Mar 14 15:=
09:26 UTC
>> > 2022 aarch64 GNU/Linux
>> > root@xilinx-zcu111-2019_2:~# [ 226.333565] lttng_ring_buffer_client_ov=
erwrite:
>> > gave up waiting for init of module lttng_tracer.
>> > [ 226.342368] lttng_ring_buffer_client_overwrite: Unknown symbol lttng=
_last_tsc
>> > (err -16)
>> > [ 257.053564] lttng_ring_buffer_client_overwrite: gave up waiting for =
init of
>> > module lttng_tracer.
>> > [ 257.062358] lttng_ring_buffer_client_overwrite: Unknown symbol
>> > lttng_transport_register (err -16)
>> > [ 287.773562] lttng_ring_buffer_client_overwrite: gave up waiting for =
init of
>> > module lttng_tracer.
>> > [ 287.782356] lttng_ring_buffer_client_overwrite: Unknown symbol
>> > lttng_transport_unregister (err -16)
>> > [ 318.493567] lttng_ring_buffer_client_overwrite: gave up waiting for =
init of
>> > module lttng_tracer.
>> > [ 318.502364] lttng_ring_buffer_client_overwrite: Unknown symbol lttng=
_last_tsc
>> > (err -16)
>> > [ 349.213564] lttng_ring_buffer_client_overwrite: gave up waiting for =
init of
>> > module lttng_tracer.
>> > [ 349.222363] lttng_ring_buffer_client_overwrite: Unknown symbol
>> > lttng_transport_register (err -16)

>> What is the installed lttng-modules version ?

>> You can query it with modinfo /lib/modules/$(uname -r)/extra/lttng-trace=
r.ko

>> Thanks,

>> Mathieu

>> > Thank You
>> > with regards
>> > G Madhan Mohan

>> > Disclaimer:- This footer text is to convey that this email is sent by =
one of the
>> > users of IITH. So, do not mark it as SPAM.
>> > _______________________________________________
>> > lttng-dev mailing list
>> > [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

> Disclaimer:- This footer text is to convey that this email is sent by one=
 of the
> users of IITH. So, do not mark it as SPAM.

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_ab51642b-f666-4612-892d-490cf9664c7a
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Mar 16, 2022, at 8:17 AM, GOLLAMUDI MADHAN MOHAN &lt;madhan.mo=
han@5g.iith.ac.in&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_T=
EXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;p=
adding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=
=3D"ltr">hi sir,<div>&nbsp; &nbsp; &nbsp; &nbsp;lttng version 2.9.5 - Joann=
=C3=A8s&nbsp;</div><div>modinfo command&nbsp;is not available used&nbsp; $&=
nbsp;lttng version command</div></div></blockquote><div><br></div><div><div=
>Hi,<br></div><div><br></div><div>Please keep the lttng-dev mailing list in=
 CC, as this discussion started there. The</div><div>answers we come up wit=
h can be useful to others.</div><div><br></div><div>The version you provide=
d here is the version of lttng-tools installed on your system,</div><div>wh=
ich is not relevant to investigate your issue.</div><div><br></div><div>Wha=
t is needed here is the version of lttng-modules: the Linux kernel modules =
implementing</div><div>the kernel tracing feature of LTTng. Those are diffe=
rent packages altogether.</div><div><br></div><div>May I recommend that you=
 install the package containing the "modinfo" tool on your system</div><div=
>to query the lttng-modules version ?</div><div><br></div><div>An alternati=
ve to query the lttng-modules version, if you really cannot install modinfo=
, would</div><div>be:</div><div><br></div><div>strings /lib/modules/$(uname=
 -r)/extra/lttng-tracer.ko | grep "^version=3D"<br></div><div><br></div><di=
v>Thank you,</div><div><br></div><div>Mathieu</div></div><div><br data-mce-=
bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><div dir=3D"ltr"><div><br></div><br><br>Thank You<div>&nbsp;with regards<=
br>G Madhan Mohan<br></div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Tue, Mar 15, 2022 at 9:19 PM Mathieu Desnoyer=
s &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank" r=
el=3D"nofollow noopener noreferrer">mathieu.desnoyers@efficios.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb( 204 , 204 , 204 );padding-left:1ex"><br=
>
<br>
----- On Mar 15, 2022, at 2:48 AM, lttng-dev <a href=3D"mailto:lttng-dev@li=
sts.lttng.org" target=3D"_blank" rel=3D"nofollow noopener noreferrer">lttng=
-dev@lists.lttng.org</a> wrote:<br>
<br>
&gt; Dear Sir/Madam,<br>
&gt; I am Madhan , working as an embedded engineer in 5GTB. I am using lttn=
g in<br>
&gt; petalinux 2019.2(kernel 4.19) .And getting a call Trace error. Refer t=
he below<br>
&gt; log for more details.<br>
<br>
&gt; root@xilinx-zcu111-2019_2:~# lttng create<br>
&gt; Spawning a session daemon<br>
&gt; [ 163.902282] lttng_kretprobes: loading out-of-tree module taints kern=
el.<br>
&gt; [ 163.987461] Unable to handle kernel paging request at virtual addres=
s<br>
&gt; 00000000000010c0<br>
&gt; [ 163.995379] Mem abort info:<br>
&gt; [ 163.998179] ESR =3D 0x96000005<br>
&gt; [ 164.001233] Exception class =3D DABT (current EL), IL =3D 32 bits<br=
>
&gt; [ 164.007149] SET =3D 0, FnV =3D 0<br>
&gt; [ 164.010203] EA =3D 0, S1PTW =3D 0<br>
&gt; [ 164.013333] Data abort info:<br>
&gt; [ 164.016218] ISV =3D 0, ISS =3D 0x00000005<br>
&gt; [ 164.020054] CM =3D 0, WnR =3D 0<br>
&gt; [ 164.023028] user pgtable: 4k pages, 39-bit VAs, pgdp =3D 00000000df6=
dd54e<br>
&gt; [ 164.029646] [00000000000010c0] pgd=3D0000000000000000, pud=3D0000000=
000000000<br>
&gt; [ 164.036447] Internal error: Oops: 96000005 [#1] SMP<br>
&gt; [ 164.041318] Modules linked in: lttng_tracer(O+) lttng_statedump(O)<b=
r>
&gt; lttng_ftrace(O) lttng_kprobes(O) lttng_clock(O) lttng_lib_ring_buffer(=
O)<br>
&gt; lttng_kretprobes(O) uio_pdrv_genirq<br>
&gt; [ 164.056963] CPU: 1 PID: 4955 Comm: modprobe Tainted: G O 4.19.0-xili=
nx-v2019.2<br>
&gt; #1<br>
&gt; [ 164.065734] Hardware name: ZynqMP ZCU111 RevA (DT)<br>
&gt; [ 164.070510] pstate: 60000005 (nZCv daif -PAN -UAO)<br>
&gt; [ 164.075429] pc : lttng_tracepoint_notify+0x188/0x228 [lttng_tracer]<=
br>
&gt; [ 164.081767] lr : lttng_tracepoint_notify+0x14c/0x228 [lttng_tracer]<=
br>
&gt; [ 164.088016] sp : ffffff8011613a40<br>
&gt; [ 164.091314] x29: ffffff8011613a40 x28: ffffff801163f000<br>
&gt; [ 164.096618] x27: 0000000000000100 x26: ffffff800813c958<br>
&gt; [ 164.101921] x25: ffffff8000e22758 x24: 0000000000000000<br>
&gt; [ 164.107225] x23: 00000000000010c0 x22: ffffff8000e42ed8<br>
&gt; [ 164.112528] x21: ffffffc87accc400 x20: ffffff8000e42ef8<br>
&gt; [ 164.117832] x19: 0000000000000001 x18: 0000000000000000<br>
&gt; [ 164.123135] x17: 0000000000000000 x16: 0000000000000000<br>
&gt; [ 164.128439] x15: ffffffffffffffff x14: 0000000000000000<br>
&gt; [ 164.133742] x13: 0000000000000000 x12: 0000000000000000<br>
&gt; [ 164.139046] x11: 0000000000000001 x10: 0101010101010101<br>
&gt; [ 164.144349] x9 : 6d64686b625e6f38 x8 : 706d75645f6c6f63<br>
&gt; [ 164.149653] x7 : 6f746f72705f7039 x6 : ffffffc8778d5ec1<br>
&gt; [ 164.154957] x5 : ffffff8009458000 x4 : 0000000000000000<br>
&gt; [ 164.160260] x3 : ffffff8000db77a0 x2 : ffffffc87828a380<br>
&gt; [ 164.165563] x1 : 0000000000000007 x0 : ffffff8000d13048<br>
&gt; [ 164.170869] Process modprobe (pid: 4955, stack limit =3D 0x00000000e=
6162018)<br>
&gt; [ 164.177725] Call trace:<br>
&gt; [ 164.180235] lttng_tracepoint_notify+0x188/0x228 [lttng_tracer]<br>
&gt; [ 164.186148] register_tracepoint_module_notifier+0x6c/0x98<br>
&gt; [ 164.191709] lttng_tracepoint_init+0x54/0xc80 [lttng_tracer]<br>
&gt; [ 164.197438] lttng_events_init+0x4c/0x1e0 [lttng_tracer]<br>
&gt; [ 164.202734] do_one_initcall+0x68/0x1ec<br>
&gt; [ 164.206562] do_init_module+0x60/0x1f0<br>
&gt; [ 164.210302] load_module+0x1ca0/0x2270<br>
&gt; [ 164.214035] __se_sys_finit_module+0xc0/0xd0<br>
&gt; [ 164.218288] __arm64_sys_finit_module+0x24/0x30<br>
&gt; [ 164.222802] el0_svc_common+0x98/0x100<br>
&gt; [ 164.226543] el0_svc_handler+0x74/0x90<br>
&gt; [ 164.230275] el0_svc+0x8/0xc<br>
&gt; [ 164.233142] Code: 6b18003f 54fffc49 f9415c00 b8b8d817 (f94002f3)<br>
&gt; [ 164.239226] ---[ end trace c1cc2d1f9d55794a ]---<br>
&gt; [ 195.613567] lttng_ring_buffer_client_overwrite: gave up waiting for =
init of<br>
&gt; module lttng_tracer.<br>
&gt; [ 195.622371] lttng_ring_buffer_client_overwrite: Unknown symbol<br>
&gt; lttng_transport_unregister (err -16)<br>
&gt; ^C<br>
&gt; root@xilinx-zcu111-2019_2:~# uname -a<br>
&gt; Linux xilinx-zcu111-2019_2 4.19.0-xilinx-v2019.2 #1 SMP Mon Mar 14 15:=
09:26 UTC<br>
&gt; 2022 aarch64 GNU/Linux<br>
&gt; root@xilinx-zcu111-2019_2:~# uname -a<br>
&gt; Linux xilinx-zcu111-2019_2 4.19.0-xilinx-v2019.2 #1 SMP Mon Mar 14 15:=
09:26 UTC<br>
&gt; 2022 aarch64 GNU/Linux<br>
&gt; root@xilinx-zcu111-2019_2:~# [ 226.333565] lttng_ring_buffer_client_ov=
erwrite:<br>
&gt; gave up waiting for init of module lttng_tracer.<br>
&gt; [ 226.342368] lttng_ring_buffer_client_overwrite: Unknown symbol lttng=
_last_tsc<br>
&gt; (err -16)<br>
&gt; [ 257.053564] lttng_ring_buffer_client_overwrite: gave up waiting for =
init of<br>
&gt; module lttng_tracer.<br>
&gt; [ 257.062358] lttng_ring_buffer_client_overwrite: Unknown symbol<br>
&gt; lttng_transport_register (err -16)<br>
&gt; [ 287.773562] lttng_ring_buffer_client_overwrite: gave up waiting for =
init of<br>
&gt; module lttng_tracer.<br>
&gt; [ 287.782356] lttng_ring_buffer_client_overwrite: Unknown symbol<br>
&gt; lttng_transport_unregister (err -16)<br>
&gt; [ 318.493567] lttng_ring_buffer_client_overwrite: gave up waiting for =
init of<br>
&gt; module lttng_tracer.<br>
&gt; [ 318.502364] lttng_ring_buffer_client_overwrite: Unknown symbol lttng=
_last_tsc<br>
&gt; (err -16)<br>
&gt; [ 349.213564] lttng_ring_buffer_client_overwrite: gave up waiting for =
init of<br>
&gt; module lttng_tracer.<br>
&gt; [ 349.222363] lttng_ring_buffer_client_overwrite: Unknown symbol<br>
&gt; lttng_transport_register (err -16)<br>
<br>
What is the installed lttng-modules version ? <br>
<br>
You can query it with modinfo /lib/modules/$(uname -r)/extra/lttng-tracer.k=
o<br>
<br>
Thanks, <br>
<br>
Mathieu <br>
<br>
&gt; Thank You<br>
&gt; with regards<br>
&gt; G Madhan Mohan<br>
<br>
&gt; Disclaimer:- This footer text is to convey that this email is sent by =
one of the<br>
&gt; users of IITH. So, do not mark it as SPAM.<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" rel=3D"=
nofollow noopener noreferrer">lttng-dev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer nofollow noopener noreferrer" target=3D"_blank">https://=
lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer nofollow noopener nor=
eferrer" target=3D"_blank">http://www.efficios.com</a><br>
</blockquote></div>

<br>
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt">=
<span style=3D"font-size:11pt;font-family:'arial';color:rgb( 34 , 34 , 34 )=
;vertical-align:baseline;white-space:pre-wrap;background-color:yellow">Disc=
laimer:- </span><span style=3D"background-color:rgb( 255 , 255 , 255 );colo=
r:rgb( 34 , 34 , 34 );font-size:small">This&nbsp;</span><span style=3D"back=
ground-color:rgb( 255 , 255 , 255 );color:rgb( 34 , 34 , 34 );font-size:sma=
ll">footer text is to convey that this email is sent by one of the&nbsp;</s=
pan><span style=3D"background-color:rgb( 255 , 255 , 255 );color:rgb( 34 , =
34 , 34 );font-size:small">users of IITH. So, do not mark it as SPAM.</span=
></p><br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST__=
">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effici=
os.com</div></div></body></html>
--=_ab51642b-f666-4612-892d-490cf9664c7a--

--===============4404688676320869315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4404688676320869315==--
