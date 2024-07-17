Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DC8C3DA59
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Jul 2024 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1721179660;
	bh=kTQej5LxChHx6Jk+y9NBAezTht9mmOSCNxdkbyptduI=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=X9H0N0XwNupvt+NuiYnYbkMoCTY8MUIj/5LULvv86HHO8VfPzyWgmg7KaMKsKzK/u
	 bMIFQdRqswb8YEr1MJd7JREwpLf5R/aOhqyez6EbXFfRo9PFxKdzMdff9yZkk9d+LB
	 WntVZ3RPaMPNBE7r9U2yB6ppcNoWWgcBWstrwUSJGrzzCGL8LupbrxVfZOc0QBEavu
	 6GD+6d20aydKNUVlK6XxST+BpjXn/zoA3S27rZJdwqTmTVL0mdcScX2D60ik8kQ1WO
	 EZxFaPmUVxxVzQNy3Wyz0/dH4G3WMLaEPJTGzdncry1IZZCmijGHOI+J5ZdWxYiPNJ
	 RxoMK2makEahw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WNywr0nKRz126R;
	Tue, 16 Jul 2024 21:27:40 -0400 (EDT)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by lists.lttng.org (Postfix) with ESMTPS id 4WNywp4wlVz121m
 for <lttng-dev@lists.lttng.org>; Tue, 16 Jul 2024 21:27:38 -0400 (EDT)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c964f5a037so4085938a91.0
 for <lttng-dev@lists.lttng.org>; Tue, 16 Jul 2024 18:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721179657; x=1721784457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gmV7EP5HgZEgVDadm85hqcrZfsbpRjWden+kBwDUWyE=;
 b=l058+mJY2w4Tft2l7yEIVmLL312ldNEGq7unNXaNJ6v3m8Lr/0/3YeFPs1x/JEznMz
 T7lmbOO9SOX9SPbdKg4vYrarV444ZIIQQCLzYk02+ifNe62QmVpNtuhJVvaMugoF/1Vz
 KwVLznj50z/Xfz7C/yiL9fF69y47+XDVH/slRH88+bPQWmr7jim3HnaXdf/3lsQxlV4s
 fnnNGUjie8zH+1B9vd10ca5DSTILF+ba+tO7kDNjpDH6BLR4HOwGu5ZUjwdAXomRxERx
 ihW/CLW1Rr/4i4Img29mU4Fk9qefWhb3MAAtJEX1xFNdtHd6w8g4Iz1C9VoRWoPIDg0m
 XLPA==
X-Gm-Message-State: AOJu0YyaC/hJlOuOroS8Ov3Slm3ErbXt7bw65Jp7VwevEDFEQcxgoUQc
 r4Lo/aASJ7XkA8yDERgsKM81na8k4dHW5AIl9ghDhdmI77Grh4xIt+WuW4pVy1O3poFZlC95NB8
 y8btLvZbX2D9zoW0AMQgjp+KorNc=
X-Google-Smtp-Source: AGHT+IHyM3PKomaKwT5wHcTvzKSD2ZraMWFSXgPnO/VZSsuAYVNeasLqaegx/dNdQcPzO48bLBc4lnoUdHjI6DpBnwQ=
X-Received: by 2002:a17:90a:ea0f:b0:2c9:6cd2:1732 with SMTP id
 98e67ed59e1d1-2cb51e52059mr144574a91.0.1721179657108; Tue, 16 Jul 2024
 18:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAFZh4h_wh01sjAar-QqHsQ=KY4zLjmpmXuJc83OeYue7YyYW3A@mail.gmail.com>
 <CAFZh4h9iaCGdnDhxik9Qtq82f0MGU2eL+8nBa8qoCCJrH-xsGQ@mail.gmail.com>
 <d30f1655-0efa-440a-ac17-fe82342f4556@efficios.com>
In-Reply-To: <d30f1655-0efa-440a-ac17-fe82342f4556@efficios.com>
Date: Tue, 16 Jul 2024 21:27:25 -0400
Message-ID: <CAFZh4h_pOCzpJ6ssdZ7ts3vSdJNfEtS+d+2Foi4qAY6oH0+VKw@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org, yocto@lists.yoctoproject.org
Subject: Re: [lttng-dev] Using lttng-ust 2.13.6 from Yocto Kirkstone and
 getting weird segfault saying strlen_asimd.S can't be found.
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
From: Brian Hutchinson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Brian Hutchinson <b.hutchman@gmail.com>
Content-Type: multipart/mixed; boundary="===============7015148040933196878=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7015148040933196878==
Content-Type: multipart/alternative; boundary="0000000000000e867e061d675e52"

--0000000000000e867e061d675e52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kienan,

On Thu, Jul 11, 2024 at 8:38=E2=80=AFAM Kienan Stewart <kstewart@efficios.c=
om>
wrote:

> Hi Brian,
>
> On 7/11/24 8:33 AM, Brian Hutchinson via lttng-dev wrote:
>  > ...
>  >
>  > I'm not sure about this, still trying to comprehend everything, but I
>  > think my issue could be related to all this gcc TLS, heap, trampoline
>  > talk here:
>  >
>  > https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg13584.html
>  > <https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg13584.html>
>  >
>  > Regards,
>  >
>  > Brian
>  >
>
> You could try using lttng-ust 2.13.8, which includes a fix for the
> discussion you referenced.
>
>
> https://github.com/lttng/lttng-ust/commit/5db715e800d9b721f48495a987cd26c=
25965e836
>
> Please let us know if it doesn't solve it.
>
> thanks,
> kienan
>

I updated to lttng-ust 2.13.8 as you suggested.  At first, I pulled in the
recipe from master branch of Yocto, but had the same problem as before
after rebuilding.

Next, I downloaded the 2.13.8 lttng-ust tarball from the lttng site and
setup a native build environment on my target and built lttng-ust 2.13.8
and my app as a second independent build method for sanity check.  I can
report that I get the exact same result as before this way too.

In both cases, I verified that I had the commit you referenced above.

I did a backtrace of the three threads captured in the coredump and show
them below in hopes it will shed light on what I need to try next.

(gdb) thread apply all backtrace

Thread 3 (Thread 0xffffbe7de7e0 (LWP 559)):
#0  syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38
#1  0x0000ffffbeef1bb8 in lttng_ust_futex (val3=3D0, uaddr2=3D0x0, timeout=
=3D0x0,
val=3D0, op=3D0, uaddr=3D0xffffbefd8000) at ../../../src/lib/lttng-ust/fute=
x.h:56
#2  lttng_ust_futex_async (op=3D0, val=3D0, timeout=3D0x0, uaddr2=3D0x0, va=
l3=3D0,
uaddr=3D0xffffbefd8000) at ../../../src/lib/lttng-ust/futex.h:88
#3  wait_for_sessiond (sock_info=3D0xffffbef6b638 <global_apps>) at
lttng-ust-comm.c:1761
#4  ust_listener_thread (arg=3D0xffffbef6b638 <global_apps>) at
lttng-ust-comm.c:1832
#5  0x0000ffffbe9206a8 in start_thread (arg=3D0xffffc1bd8687) at
pthread_create.c:442
#6  0x0000ffffbe98801c in thread_start () at
../sysdeps/unix/sysv/linux/aarch64/clone.S:79

Thread 2 (Thread 0xffffbdfce7e0 (LWP 560)):
#0  syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38
#1  0x0000ffffbeef1bb8 in lttng_ust_futex (val3=3D0, uaddr2=3D0x0, timeout=
=3D0x0,
val=3D0, op=3D0, uaddr=3D0xffffbefd7000) at ../../../src/lib/lttng-ust/fute=
x.h:56
#2  lttng_ust_futex_async (op=3D0, val=3D0, timeout=3D0x0, uaddr2=3D0x0, va=
l3=3D0,
uaddr=3D0xffffbefd7000) at ../../../src/lib/lttng-ust/futex.h:88
#3  wait_for_sessiond (sock_info=3D0xffffbef695e0 <local_apps>) at
lttng-ust-comm.c:1761
#4  ust_listener_thread (arg=3D0xffffbef695e0 <local_apps>) at
lttng-ust-comm.c:1832
#5  0x0000ffffbe9206a8 in start_thread (arg=3D0xffffc1bd8687) at
pthread_create.c:442
#6  0x0000ffffbe98801c in thread_start () at
../sysdeps/unix/sysv/linux/aarch64/clone.S:79

Thread 1 (Thread 0xffffbefcf460 (LWP 545)):
#0  __strlen_asimd () at ../sysdeps/aarch64/multiarch/strlen_asimd.S:96
#1  0x0000ffffbe834bd0 in lttng_ust_tp_validate_event_name
(tp=3D0xaaaab8f14de0
<lttng_ust_tracepoint_hello_world___my_first_tracepoint>, tp=3D0xaaaab8f14d=
e0
<lttng_ust_tracepoint_hello_world___my_first_tracepoint>) at
tracepoint.c:143
#2  add_callsite (tp=3D0xaaaab8f14de0
<lttng_ust_tracepoint_hello_world___my_first_tracepoint>,
lib=3D0xaaaae74fad30) at tracepoint.c:412
#3  lib_register_callsites (lib=3D0xaaaae74fad30) at tracepoint.c:552
#4  lttng_ust_tracepoint_module_register (tracepoints_start=3D<optimized
out>, tracepoints_count=3D<optimized out>) at tracepoint.c:956
#5  0x0000aaaab8758204 in lttng_ust.tracepoints.ptrs_init ()
#6  0x0000ffffbe8cb30c in call_init (env=3D<optimized out>,
argv=3D0xffffc1bd8c88, argc=3D1) at ../csu/libc-start.c:145
#7  __libc_start_main_impl (main=3D0xaaaab867aabc <main>, argc=3D1,
argv=3D0xffffc1bd8c88, init=3D<optimized out>, fini=3D<optimized out>,
rtld_fini=3D<optimized out>, stack_end=3D<optimized out>) at
../csu/libc-start.c:376
#8  0x0000aaaab867a7f0 in _start () at ../sysdeps/aarch64/start.S:81

Regards,

Brian

--0000000000000e867e061d675e52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Kienan,</div><div></div><div></di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Thu, Jul 11, 2024 at 8:38=E2=80=AFAM Kienan Stewart &lt;<a href=3D"mai=
lto:kstewart@efficios.com" target=3D"_blank">kstewart@efficios.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Brian,=
<br>
<br>
On 7/11/24 8:33 AM, Brian Hutchinson via lttng-dev wrote:<br>
=C2=A0&gt; ...<br>
=C2=A0&gt;<br>
=C2=A0&gt; I&#39;m not sure about this, still trying to comprehend everythi=
ng, but I<br>
=C2=A0&gt; think my issue could be related to all this gcc TLS, heap, tramp=
oline<br>
=C2=A0&gt; talk here:<br>
=C2=A0&gt;<br>
=C2=A0&gt; <a href=3D"https://www.mail-archive.com/lttng-dev@lists.lttng.or=
g/msg13584.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-arch=
ive.com/lttng-dev@lists.lttng.org/msg13584.html</a><br>
=C2=A0&gt; &lt;<a href=3D"https://www.mail-archive.com/lttng-dev@lists.lttn=
g.org/msg13584.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-=
archive.com/lttng-dev@lists.lttng.org/msg13584.html</a>&gt;<br>
=C2=A0&gt;<br>
=C2=A0&gt; Regards,<br>
=C2=A0&gt;<br>
=C2=A0&gt; Brian<br>
=C2=A0&gt;<br>
<br>
You could try using lttng-ust 2.13.8, which includes a fix for the <br>
discussion you referenced.<br>
<br>
<a href=3D"https://github.com/lttng/lttng-ust/commit/5db715e800d9b721f48495=
a987cd26c25965e836" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/lttng/lttng-ust/commit/5db715e800d9b721f48495a987cd26c25965e836</a><br>
<br>
Please let us know if it doesn&#39;t solve it.<br>
<br>
thanks,<br>
kienan<br></blockquote><div><br></div><div>I updated to lttng-ust 2.13.8 as=
 you suggested.=C2=A0 At first, I pulled in the recipe from master branch o=
f Yocto, but had the same problem as before after rebuilding.<br></div><div=
><br></div><div>Next, I downloaded the 2.13.8 lttng-ust tarball from the lt=
tng site and setup a native build environment on my target and built lttng-=
ust 2.13.8 and my app as a second independent build method for sanity check=
.=C2=A0 I can report that I get the exact same result as before this way to=
o. <br></div><div><br></div><div>In both cases, I verified that I had the c=
ommit you referenced above.</div><div><br></div><div>I did a backtrace of t=
he three threads captured in the coredump and show them below in hopes it w=
ill shed light on what I need to try next.</div><div><br></div><div><span s=
tyle=3D"font-family:monospace"><span style=3D"color:rgb(0,0,0);background-c=
olor:rgb(255,255,255)">(gdb) thread apply all backtrace
</span><br>
<br>Thread 3 (Thread 0xffffbe7de7e0 (LWP 559)):
<br>#0 =C2=A0syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38
<br>#1 =C2=A00x0000ffffbeef1bb8 in lttng_ust_futex (val3=3D0, uaddr2=3D0x0,=
=20
timeout=3D0x0, val=3D0, op=3D0, uaddr=3D0xffffbefd8000) at=20
../../../src/lib/lttng-ust/futex.h:56
<br>#2 =C2=A0lttng_ust_futex_async (op=3D0, val=3D0, timeout=3D0x0, uaddr2=
=3D0x0, val3=3D0, uaddr=3D0xffffbefd8000) at ../../../src/lib/lttng-ust/fut=
ex.h:88
<br>#3 =C2=A0wait_for_sessiond (sock_info=3D0xffffbef6b638 &lt;global_apps&=
gt;) at lttng-ust-comm.c:1761
<br>#4 =C2=A0ust_listener_thread (arg=3D0xffffbef6b638 &lt;global_apps&gt;)=
 at lttng-ust-comm.c:1832
<br>#5 =C2=A00x0000ffffbe9206a8 in start_thread (arg=3D0xffffc1bd8687) at p=
thread_create.c:442
<br>#6 =C2=A00x0000ffffbe98801c in thread_start () at ../sysdeps/unix/sysv/=
linux/aarch64/clone.S:79
<br>
<br>Thread 2 (Thread 0xffffbdfce7e0 (LWP 560)):
<br>#0 =C2=A0syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38
<br>#1 =C2=A00x0000ffffbeef1bb8 in lttng_ust_futex (val3=3D0, uaddr2=3D0x0,=
=20
timeout=3D0x0, val=3D0, op=3D0, uaddr=3D0xffffbefd7000) at=20
../../../src/lib/lttng-ust/futex.h:56
<br>#2 =C2=A0lttng_ust_futex_async (op=3D0, val=3D0, timeout=3D0x0, uaddr2=
=3D0x0, val3=3D0, uaddr=3D0xffffbefd7000) at ../../../src/lib/lttng-ust/fut=
ex.h:88
<br>#3 =C2=A0wait_for_sessiond (sock_info=3D0xffffbef695e0 &lt;local_apps&g=
t;) at lttng-ust-comm.c:1761
<br>#4 =C2=A0ust_listener_thread (arg=3D0xffffbef695e0 &lt;local_apps&gt;) =
at lttng-ust-comm.c:1832
<br>#5 =C2=A00x0000ffffbe9206a8 in start_thread (arg=3D0xffffc1bd8687) at p=
thread_create.c:442
<br>#6 =C2=A00x0000ffffbe98801c in thread_start () at ../sysdeps/unix/sysv/=
linux/aarch64/clone.S:79
<br>
<br>Thread 1 (Thread 0xffffbefcf460 (LWP 545)):
<br>#0 =C2=A0__strlen_asimd () at ../sysdeps/aarch64/multiarch/strlen_asimd=
.S:96
<br>#1 =C2=A00x0000ffffbe834bd0 in lttng_ust_tp_validate_event_name (tp=3D0=
xaaaab8f14de0 &lt;lttng_ust_tracepoint_hello_world___my_first_tracepoint&gt=
;, tp=3D0xaaaab8f14de0 &lt;lttng_ust_tracepoint_hello_world___my_first_trac=
epoint&gt;) at tracepoint.c:143
<br>#2 =C2=A0add_callsite (tp=3D0xaaaab8f14de0 &lt;lttng_ust_tracepoint_hel=
lo_world___my_first_tracepoint&gt;, lib=3D0xaaaae74fad30) at tracepoint.c:4=
12
<br>#3 =C2=A0lib_register_callsites (lib=3D0xaaaae74fad30) at tracepoint.c:=
552
<br>#4 =C2=A0lttng_ust_tracepoint_module_register (tracepoints_start=3D&lt;=
optimized out&gt;, tracepoints_count=3D&lt;optimized out&gt;) at tracepoint=
.c:956
<br>#5 =C2=A00x0000aaaab8758204 in lttng_ust.tracepoints.ptrs_init ()
<br>#6 =C2=A00x0000ffffbe8cb30c in call_init (env=3D&lt;optimized out&gt;, =
argv=3D0xffffc1bd8c88, argc=3D1) at ../csu/libc-start.c:145
<br>#7 =C2=A0__libc_start_main_impl (main=3D0xaaaab867aabc &lt;main&gt;,=20
argc=3D1, argv=3D0xffffc1bd8c88, init=3D&lt;optimized out&gt;,=20
fini=3D&lt;optimized out&gt;, rtld_fini=3D&lt;optimized out&gt;,=20
stack_end=3D&lt;optimized out&gt;) at ../csu/libc-start.c:376
<br>#8 =C2=A00x0000aaaab867a7f0 in _start () at ../sysdeps/aarch64/start.S:=
81</span></div><div><span style=3D"font-family:monospace"><br></span></div>=
<div><span style=3D"font-family:monospace">Regards,</span></div><div><span =
style=3D"font-family:monospace"><br></span></div><div><span style=3D"font-f=
amily:monospace">Brian<br></span></div></div></div>

--0000000000000e867e061d675e52--

--===============7015148040933196878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7015148040933196878==--
