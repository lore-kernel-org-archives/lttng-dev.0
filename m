Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98177C3DA42
	for <lttng-dev@archiver.kernel.org>; Wed, 17 Jul 2024 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1721233669;
	bh=eWsdpmKE6yGeVLdxl4o2Y+UAf+kQ0uaFZ7WFbstHjjQ=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VOevKXKADvnLNLIqfkk62N/QYhKCfPvT+3cs6W0oxubwRJouWfvURt18QS8ulmC4C
	 1QQ8LGhVh2G77hCg0oobzMxl2Fa3luiktysoEjjNyr0OpWJ8YzxofaHHI8ea2mX59F
	 7NN30XrMFfxOkrBCPWo/8WU8jAJ9EvwNlMeKazbpLBEV7TCoiUC/uGvVm6ivXPHOiJ
	 OFPbkIkyK5FyCGn7TI7vt81fRzPLpO2DUOuVZOad+Zq3EwIuuvG7C46vkS0a8rrPyT
	 PsEt6VcMoRmjnNL541lHhBMocxx0lpfGo3EqHJ3A1IQzChumvvFrdW8e5BlxzVHXn6
	 siWaypMRRI1Lw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WPLvT27Kdz12QJ;
	Wed, 17 Jul 2024 12:27:49 -0400 (EDT)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by lists.lttng.org (Postfix) with ESMTPS id 4WPLvS2VYSz12QG
 for <lttng-dev@lists.lttng.org>; Wed, 17 Jul 2024 12:27:48 -0400 (EDT)
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70b1808dee9so4791586b3a.2
 for <lttng-dev@lists.lttng.org>; Wed, 17 Jul 2024 09:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721233667; x=1721838467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0s4sW351UOPO15pV5RatoSfGBqOCIp0ZGc0ktkI/WBY=;
 b=BG2FrR7qXYbe1JECuGELqs3l+OhdjrGvNhABh/kb/QgzPCTbFtbvZ+yrhQnz8+u5eb
 HwtM6X+1IiqPdzSRfhple1rT65Vt+M5bCdVjCgaA/QEKi7OiqzumqnBc5ClvHaUyqzBv
 NrFnjYDYawAFXPTv8y0WTx3hpa2iId6hb6IIpf4PwDb4CMAyDrQmXXUMgssF2eHQGrEf
 aWV5hTe9PZBtQWND+AZZcUGgrOO4rWM3Ia+UtPNumAIherTwwcdrit/e5HYhmqSfgSZ4
 t/NQEn3TK+zRRckbWFkBAjK7jAwdOm6YTwvjdmRRBmfWlSIWcoN7vgmkiAtedkq//isc
 lsuw==
X-Gm-Message-State: AOJu0Ywa4txVC9jqu2jC+R5pgc4dnMoYhpy6PK4NZ6GA8myG9ZPe6r4b
 RTVDzILpXo4VDRl0wy1QTVXPbBX/UYKzq9KsVbKthm6WDuMcqDSu7jYG4fI2Z9Gh1CB402d6+yb
 vN9NlrXPw59jLgfFygRAoFMFfiQs=
X-Google-Smtp-Source: AGHT+IHVUXsm8v4Et5ZUaohFmSMxDnkQdqIZ5ztJ6a8RtVrlRf8XyuTYaXrY+NMIXwqrljYTFOLssYuk3lVrMtQLwB4=
X-Received: by 2002:a05:6a20:2d06:b0:1c0:e4d6:9c05 with SMTP id
 adf61e73a8af0-1c3fdd0fa8emr2145003637.32.1721233666809; Wed, 17 Jul 2024
 09:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAFZh4h_wh01sjAar-QqHsQ=KY4zLjmpmXuJc83OeYue7YyYW3A@mail.gmail.com>
 <CAFZh4h9iaCGdnDhxik9Qtq82f0MGU2eL+8nBa8qoCCJrH-xsGQ@mail.gmail.com>
 <d30f1655-0efa-440a-ac17-fe82342f4556@efficios.com>
 <CAFZh4h_pOCzpJ6ssdZ7ts3vSdJNfEtS+d+2Foi4qAY6oH0+VKw@mail.gmail.com>
 <33527830-3bf3-4bc3-a53d-55eaefb74902@efficios.com>
In-Reply-To: <33527830-3bf3-4bc3-a53d-55eaefb74902@efficios.com>
Date: Wed, 17 Jul 2024 12:27:35 -0400
Message-ID: <CAFZh4h8k+eGuVJLJ_1vA1_P7+3Hi7h+UgUSmoN51Paxyypw-fA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1071897157144700149=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1071897157144700149==
Content-Type: multipart/alternative; boundary="000000000000492929061d73f16f"

--000000000000492929061d73f16f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 10:13=E2=80=AFAM Kienan Stewart <kstewart@efficios.=
com>
wrote:

> Hi Brian,
>
> thanks! I'll take a look at these and see if I can get any ideas from the=
m.
>
> To go back to your original e-mail, a detail that I hadn't noticed in
> your original backtrace was pointed out to me and I'd like to verify
> with you:
>
> ```
> Core was generated by `./my_app'.
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  __strlen_asimd () at ../sysdeps/aarch64/multiarch/strlen_asimd.S:96
> 96      ../sysdeps/aarch64/multiarch/strlen_asimd.S: No such file or
> directory.
> [Current thread is 1 (Thread 0xffffb8e2d040 (LWP 757))]
> (gdb) bt
> #0  __strlen_asimd () at ../sysdeps/aarch64/multiarch/strlen_asimd.S:96
> #1  0x0000ffffb86c5330 in lttng_ust_tracepoint_module_register () from
> /usr/lib/liblttng-ust-tracepoint.so.1
> #2  0x0000aaaab4c8da18 in lttng_ust__tracepoints__ptrs_init () at
>
> /opt/poky/4.0.18/sysroots/cortexa53-crypto-poky-linux/usr/include/lttng/t=
racepoint.h:629
> #3  0x0000ffffb872b30c in call_init (env=3D<optimized out>,
> argv=3D0xffffe2d66098, argc=3D1) at ../csu/libc-start.c:145
> #4  __libc_start_main_impl (main=3D0xaaaab4bd94e0 <main>, argc=3D1,
> argv=3D0xffffe2d66098, init=3D<optimized out>, fini=3D<optimized out>,
> rtld_fini=3D<optimized out>, stack_end=3D<optimized out>) at
> ../csu/libc-start.c:376
> #5  0x0000aaaab4bd9230 in _start () at ../sysdeps/aarch64/start.S:81
> ```
>
> The library loaded at frame 1 is
> `/usr/lib/liblttng-ust-tracepoint.so.1`; however, in frame 2 the
> reference is from
>
> `/opt/poky/4.0.18/sysroots/cortexa53-crypto-poky-linux/usr/include/lttng/=
tracepoint.h`.


> Are the LTTng libraries in `/usr/lib` the exact same version as the
> headers in
> `/opt/poky/4.0.18/sysroots/cortexa53-cryptop-poky-linux/usr/include/lttng=
`?
>

Yes.  The sdk was created by yocto using populate_sdk which includes the
target image sysroot in the sdk.  Hopefully I explained that right. The
target image drives the contents of the sdk and the generated sdk is what
is used to cross compile the application specifically for the target we are
running on (NXP imx8mm).


> If some of your app is compiled using one version of headers and a
> different version of the library is loaded at runtime, there could be an
> ABI mismatch.
>

> You could check what the include paths are during compilation and
> `LD_LIBRARY_PATH` at runtime. Running with the environment variable
> `LD_DEBUG=3Dbindings,libs` (see `man ld.so` for more info).
>

I've been down that road a few times before with the same line of thinking
(ABI issue) and believe I've proven I don't have those issues.  That's one
of the reasons I hand built lttng-ust in native environment (on the actual
target) to verify it wasn't an issue with a yocto recipe, cross compiling
etc..

I've been thru this process with different OS versions (yocto Dunfell
before), kernel version, toolchain version etc., and now the same with
Kirkstone based components.


> In any case, I'll take a look over the most recent backtraces and see if
> anything else jumps out.
>

Thanks!  I'm running out of things to try.

I don't fully understand the implications of some of this documentation,
but I have learned enough to know LD_PRELOAD means nothing if everything is
static built.  Our application is heavily multi threaded, uses fork, clone
and who knows if it's doing double closes or not ... so I've tried these
LD_PRELOAD "helpers" or whatever they are, before and didn't get a
different result, but now know it's only for shared library object.  So now
I will experiment with making our tpp a shared object and try LD_PRELOAD of
fork, fd and pthread helpers and starting my app that way.

This is what I'm referring to above from the lttng docs:
Use LTTng-UST with daemons
<https://lttng.org/docs/v2.13/#doc-using-lttng-ust-with-daemons>

If your instrumented application calls fork(2)
<https://man7.org/linux/man-pages/man2/fork.2.html>, clone(2)
<https://man7.org/linux/man-pages/man2/clone.2.html>, or BSD=E2=80=99s rfor=
k(2)
<http://www.freebsd.org/cgi/man.cgi?query=3Drfork&sektion=3D2&manpath=3DFre=
eBSD+4.10-RELEASE>,
without a following exec(3)
<https://man7.org/linux/man-pages/man3/exec.3.html>-family system call, you
must preload the liblttng-ust-fork.so shared object when you start the
application.

LD_PRELOAD=3Dliblttng-ust-fork.so ./my-app

If your tracepoint provider package is a shared library which you also
preload, you must put both shared objects in LD_PRELOAD:

LD_PRELOAD=3Dliblttng-ust-fork.so:/path/to/tp.so ./my-app

Use LTTng-UST with applications which close file descriptors that don=E2=80=
=99t
belong to them <https://lttng.org/docs/v2.13/#doc-liblttng-ust-fd>
Since 2.9

If your instrumented application closes one or more file descriptors which
it did not open itself, you must preload the liblttng-ust-fd.so shared
object when you start the application:

LD_PRELOAD=3Dliblttng-ust-fd.so ./my-app

Typical use cases include closing all the file descriptors after fork(2)
<https://man7.org/linux/man-pages/man2/fork.2.html> or rfork(2)
<http://www.freebsd.org/cgi/man.cgi?query=3Drfork&sektion=3D2&manpath=3DFre=
eBSD+4.10-RELEASE>
and buggy applications doing =E2=80=9Cdouble closes=E2=80=9D.


Thanks,

Brian


>
>
> On 7/16/24 9:27 PM, Brian Hutchinson wrote:
> > Hi Kienan,
> >
> > On Thu, Jul 11, 2024 at 8:38=E2=80=AFAM Kienan Stewart <kstewart@effici=
os.com
> > <mailto:kstewart@efficios.com>> wrote:
> >
> >     Hi Brian,
> >
> >     On 7/11/24 8:33 AM, Brian Hutchinson via lttng-dev wrote:
> >       > ...
> >       >
> >       > I'm not sure about this, still trying to comprehend everything,
> >     but I
> >       > think my issue could be related to all this gcc TLS, heap,
> >     trampoline
> >       > talk here:
> >       >
> >       >
> >     https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg13584.htm=
l
> >     <
> https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg13584.html>
> >       >
> >     <
> https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg13584.html <
> https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg13584.html>>
> >       >
> >       > Regards,
> >       >
> >       > Brian
> >       >
> >
> >     You could try using lttng-ust 2.13.8, which includes a fix for the
> >     discussion you referenced.
> >
> >
> https://github.com/lttng/lttng-ust/commit/5db715e800d9b721f48495a987cd26c=
25965e836
> <
> https://github.com/lttng/lttng-ust/commit/5db715e800d9b721f48495a987cd26c=
25965e836
> >
> >
> >     Please let us know if it doesn't solve it.
> >
> >     thanks,
> >     kienan
> >
> >
> > I updated to lttng-ust 2.13.8 as you suggested.  At first, I pulled in
> > the recipe from master branch of Yocto, but had the same problem as
> > before after rebuilding.
> >
> > Next, I downloaded the 2.13.8 lttng-ust tarball from the lttng site and
> > setup a native build environment on my target and built lttng-ust 2.13.=
8
> > and my app as a second independent build method for sanity check.  I ca=
n
> > report that I get the exact same result as before this way too.
> >
> > In both cases, I verified that I had the commit you referenced above.
> >
> > I did a backtrace of the three threads captured in the coredump and sho=
w
> > them below in hopes it will shed light on what I need to try next.
> >
> > (gdb) thread apply all backtrace
> >
> > Thread 3 (Thread 0xffffbe7de7e0 (LWP 559)):
> > #0  syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38
> > #1  0x0000ffffbeef1bb8 in lttng_ust_futex (val3=3D0, uaddr2=3D0x0,
> > timeout=3D0x0, val=3D0, op=3D0, uaddr=3D0xffffbefd8000) at
> > ../../../src/lib/lttng-ust/futex.h:56
> > #2  lttng_ust_futex_async (op=3D0, val=3D0, timeout=3D0x0, uaddr2=3D0x0=
, val3=3D0,
> > uaddr=3D0xffffbefd8000) at ../../../src/lib/lttng-ust/futex.h:88
> > #3  wait_for_sessiond (sock_info=3D0xffffbef6b638 <global_apps>) at
> > lttng-ust-comm.c:1761
> > #4  ust_listener_thread (arg=3D0xffffbef6b638 <global_apps>) at
> > lttng-ust-comm.c:1832
> > #5  0x0000ffffbe9206a8 in start_thread (arg=3D0xffffc1bd8687) at
> > pthread_create.c:442
> > #6  0x0000ffffbe98801c in thread_start () at
> > ../sysdeps/unix/sysv/linux/aarch64/clone.S:79
> >
> > Thread 2 (Thread 0xffffbdfce7e0 (LWP 560)):
> > #0  syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38
> > #1  0x0000ffffbeef1bb8 in lttng_ust_futex (val3=3D0, uaddr2=3D0x0,
> > timeout=3D0x0, val=3D0, op=3D0, uaddr=3D0xffffbefd7000) at
> > ../../../src/lib/lttng-ust/futex.h:56
> > #2  lttng_ust_futex_async (op=3D0, val=3D0, timeout=3D0x0, uaddr2=3D0x0=
, val3=3D0,
> > uaddr=3D0xffffbefd7000) at ../../../src/lib/lttng-ust/futex.h:88
> > #3  wait_for_sessiond (sock_info=3D0xffffbef695e0 <local_apps>) at
> > lttng-ust-comm.c:1761
> > #4  ust_listener_thread (arg=3D0xffffbef695e0 <local_apps>) at
> > lttng-ust-comm.c:1832
> > #5  0x0000ffffbe9206a8 in start_thread (arg=3D0xffffc1bd8687) at
> > pthread_create.c:442
> > #6  0x0000ffffbe98801c in thread_start () at
> > ../sysdeps/unix/sysv/linux/aarch64/clone.S:79
> >
> > Thread 1 (Thread 0xffffbefcf460 (LWP 545)):
> > #0  __strlen_asimd () at ../sysdeps/aarch64/multiarch/strlen_asimd.S:96
> > #1  0x0000ffffbe834bd0 in lttng_ust_tp_validate_event_name
> > (tp=3D0xaaaab8f14de0
> > <lttng_ust_tracepoint_hello_world___my_first_tracepoint>,
> > tp=3D0xaaaab8f14de0
> > <lttng_ust_tracepoint_hello_world___my_first_tracepoint>) at
> > tracepoint.c:143
> > #2  add_callsite (tp=3D0xaaaab8f14de0
> > <lttng_ust_tracepoint_hello_world___my_first_tracepoint>,
> > lib=3D0xaaaae74fad30) at tracepoint.c:412
> > #3  lib_register_callsites (lib=3D0xaaaae74fad30) at tracepoint.c:552
> > #4  lttng_ust_tracepoint_module_register (tracepoints_start=3D<optimize=
d
> > out>, tracepoints_count=3D<optimized out>) at tracepoint.c:956
> > #5  0x0000aaaab8758204 in lttng_ust.tracepoints.ptrs_init ()
> > #6  0x0000ffffbe8cb30c in call_init (env=3D<optimized out>,
> > argv=3D0xffffc1bd8c88, argc=3D1) at ../csu/libc-start.c:145
> > #7  __libc_start_main_impl (main=3D0xaaaab867aabc <main>, argc=3D1,
> > argv=3D0xffffc1bd8c88, init=3D<optimized out>, fini=3D<optimized out>,
> > rtld_fini=3D<optimized out>, stack_end=3D<optimized out>) at
> > ../csu/libc-start.c:376
> > #8  0x0000aaaab867a7f0 in _start () at ../sysdeps/aarch64/start.S:81
> >
> > Regards,
> >
> > Brian
>

--000000000000492929061d73f16f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 17, 2024 at 10:13=E2=80=
=AFAM Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com" target=3D=
"_blank">kstewart@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Hi Brian,<br>
<br>
thanks! I&#39;ll take a look at these and see if I can get any ideas from t=
hem.<br>
<br>
To go back to your original e-mail, a detail that I hadn&#39;t noticed in <=
br>
your original backtrace was pointed out to me and I&#39;d like to verify <b=
r>
with you:<br>
<br>
```<br>
Core was generated by `./my_app&#39;.<br>
Program terminated with signal SIGSEGV, Segmentation fault.<br>
#0=C2=A0 __strlen_asimd () at ../sysdeps/aarch64/multiarch/strlen_asimd.S:9=
6<br>
96=C2=A0 =C2=A0 =C2=A0 ../sysdeps/aarch64/multiarch/strlen_asimd.S: No such=
 file or <br>
directory.<br>
[Current thread is 1 (Thread 0xffffb8e2d040 (LWP 757))]<br>
(gdb) bt<br>
#0=C2=A0 __strlen_asimd () at ../sysdeps/aarch64/multiarch/strlen_asimd.S:9=
6<br>
#1=C2=A0 0x0000ffffb86c5330 in lttng_ust_tracepoint_module_register () from=
 <br>
/usr/lib/liblttng-ust-tracepoint.so.1<br>
#2=C2=A0 0x0000aaaab4c8da18 in lttng_ust__tracepoints__ptrs_init () at <br>
/opt/poky/4.0.18/sysroots/cortexa53-crypto-poky-linux/usr/include/lttng/tra=
cepoint.h:629<br>
#3=C2=A0 0x0000ffffb872b30c in call_init (env=3D&lt;optimized out&gt;, <br>
argv=3D0xffffe2d66098, argc=3D1) at ../csu/libc-start.c:145<br>
#4=C2=A0 __libc_start_main_impl (main=3D0xaaaab4bd94e0 &lt;main&gt;, argc=
=3D1, <br>
argv=3D0xffffe2d66098, init=3D&lt;optimized out&gt;, fini=3D&lt;optimized o=
ut&gt;, <br>
rtld_fini=3D&lt;optimized out&gt;, stack_end=3D&lt;optimized out&gt;) at <b=
r>
../csu/libc-start.c:376<br>
#5=C2=A0 0x0000aaaab4bd9230 in _start () at ../sysdeps/aarch64/start.S:81<b=
r>
```<br>
<br>
The library loaded at frame 1 is <br>
`/usr/lib/liblttng-ust-tracepoint.so.1`; however, in frame 2 the <br>
reference is from <br>
`/opt/poky/4.0.18/sysroots/cortexa53-crypto-poky-linux/usr/include/lttng/tr=
acepoint.h`.</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Are the LTTng libraries in `/usr/lib` the exact same version as the <br>
headers in <br>
`/opt/poky/4.0.18/sysroots/cortexa53-cryptop-poky-linux/usr/include/lttng`?=
<br></blockquote><div><br></div><div>Yes.=C2=A0 The sdk was created by yoct=
o using populate_sdk which includes the
 target image sysroot in the sdk.=C2=A0 Hopefully I explained that right. T=
he target image drives the contents of the sdk and the generated sdk is wha=
t is used to cross compile the application specifically for the target we a=
re running on (NXP imx8mm).<br></div><div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
If some of your app is compiled using one version of headers and a <br>
different version of the library is loaded at runtime, there could be an <b=
r>
ABI mismatch.<br></blockquote><div></div><div></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
You could check what the include paths are during compilation and <br>
`LD_LIBRARY_PATH` at runtime. Running with the environment variable <br>
`LD_DEBUG=3Dbindings,libs` (see `man ld.so` for more info).<br></blockquote=
><div>=C2=A0</div><div>I&#39;ve been down that road a few times before with=
 the same line of thinking (ABI issue) and believe I&#39;ve proven I don&#3=
9;t have those issues.=C2=A0 That&#39;s one of the reasons I hand built ltt=
ng-ust in native environment (on the actual target) to verify it wasn&#39;t=
 an issue with a yocto recipe, cross compiling etc..<br></div><div><br></di=
v><div>I&#39;ve been thru this process with different OS versions (yocto Du=
nfell before), kernel version, toolchain version etc., and now the same wit=
h Kirkstone based components.<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
In any case, I&#39;ll take a look over the most recent backtraces and see i=
f <br>
anything else jumps out.<br></blockquote><div><br></div><div>Thanks!=C2=A0 =
I&#39;m running out of things to try.</div><div></div><div><br></div><div>I=
 don&#39;t fully understand the implications of some of this documentation,=
 but I have learned enough to know LD_PRELOAD means nothing if everything i=
s static built.=C2=A0 Our application is heavily multi threaded, uses fork,=
 clone and who knows if it&#39;s doing double closes or not ... so I&#39;ve=
 tried these LD_PRELOAD &quot;helpers&quot; or whatever they are, before an=
d didn&#39;t get a different result, but now know it&#39;s only for shared =
library object.=C2=A0 So now I will experiment with making our tpp a shared=
 object and try LD_PRELOAD of fork, fd and pthread helpers and starting my =
app that way.</div><div><br></div><div>This is what I&#39;m referring to ab=
ove from the lttng docs:<br></div><div><h5><a href=3D"https://lttng.org/doc=
s/v2.13/#doc-using-lttng-ust-with-daemons" target=3D"_blank">Use <span>LTTn=
g-UST</span> with daemons</a></h5><p>If your instrumented application calls=
 <a href=3D"https://man7.org/linux/man-pages/man2/fork.2.html" target=3D"_b=
lank">fork<span>(2)</span></a>, <a href=3D"https://man7.org/linux/man-pages=
/man2/clone.2.html" target=3D"_blank">clone<span>(2)</span></a>,
or BSD=E2=80=99s <a href=3D"http://www.freebsd.org/cgi/man.cgi?query=3Drfor=
k&amp;sektion=3D2&amp;manpath=3DFreeBSD+4.10-RELEASE" target=3D"_blank">rfo=
rk<span>(2)</span></a>, without a following <a href=3D"https://man7.org/lin=
ux/man-pages/man3/exec.3.html" target=3D"_blank">exec<span>(3)</span></a>-f=
amily
system call, you must preload the <code>liblttng-ust-fork.so</code> shared
object when you start the application.</p><div></div><div><pre>LD_PRELOAD=
=3Dliblttng-ust-fork.so ./my-app</pre></div><p>If your tracepoint provider =
package is
a shared library which you also preload, you must put both
shared objects in <code>LD_PRELOAD</code>:</p><div></div><div><pre>LD_PRELO=
AD=3Dliblttng-ust-fork.so:/path/to/tp.so ./my-app</pre></div><h5><a href=3D=
"https://lttng.org/docs/v2.13/#doc-liblttng-ust-fd" target=3D"_blank">Use <=
span>LTTng-UST</span> with applications which close file descriptors that d=
on=E2=80=99t belong to them</a></h5><div>Since 2.9</div><p>If your instrume=
nted application closes one or more file descriptors
which it did not open itself, you must preload the
<code>liblttng-ust-fd.so</code> shared object when you start the applicatio=
n:</p><div></div><div><pre>LD_PRELOAD=3Dliblttng-ust-fd.so ./my-app</pre></=
div><p>Typical use cases include closing all the file descriptors after
<a href=3D"https://man7.org/linux/man-pages/man2/fork.2.html" target=3D"_bl=
ank">fork<span>(2)</span></a> or <a href=3D"http://www.freebsd.org/cgi/man.=
cgi?query=3Drfork&amp;sektion=3D2&amp;manpath=3DFreeBSD+4.10-RELEASE" targe=
t=3D"_blank">rfork<span>(2)</span></a> and buggy applications doing
=E2=80=9Cdouble closes=E2=80=9D.</p><p><br></p><p></p><p>Thanks,</p><p></p>=
<p>Brian<br></p></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
<br>
On 7/16/24 9:27 PM, Brian Hutchinson wrote:<br>
&gt; Hi Kienan,<br>
&gt; <br>
&gt; On Thu, Jul 11, 2024 at 8:38=E2=80=AFAM Kienan Stewart &lt;<a href=3D"=
mailto:kstewart@efficios.com" target=3D"_blank">kstewart@efficios.com</a> <=
br>
&gt; &lt;mailto:<a href=3D"mailto:kstewart@efficios.com" target=3D"_blank">=
kstewart@efficios.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Brian,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 7/11/24 8:33 AM, Brian Hutchinson via lttng-dev =
wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; I&#39;m not sure about this, still tryi=
ng to comprehend everything,<br>
&gt;=C2=A0 =C2=A0 =C2=A0but I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; think my issue could be related to all =
this gcc TLS, heap,<br>
&gt;=C2=A0 =C2=A0 =C2=A0trampoline<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; talk here:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://www.mail-archive.com/lttng-dev@l=
ists.lttng.org/msg13584.html" rel=3D"noreferrer" target=3D"_blank">https://=
www.mail-archive.com/lttng-dev@lists.lttng.org/msg13584.html</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www.mail-archive.com/lttng-d=
ev@lists.lttng.org/msg13584.html" rel=3D"noreferrer" target=3D"_blank">http=
s://www.mail-archive.com/lttng-dev@lists.lttng.org/msg13584.html</a>&gt;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://www.mail-archive.com/lttng-d=
ev@lists.lttng.org/msg13584.html" rel=3D"noreferrer" target=3D"_blank">http=
s://www.mail-archive.com/lttng-dev@lists.lttng.org/msg13584.html</a> &lt;<a=
 href=3D"https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg13584.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/lttng=
-dev@lists.lttng.org/msg13584.html</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Brian<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You could try using lttng-ust 2.13.8, which include=
s a fix for the<br>
&gt;=C2=A0 =C2=A0 =C2=A0discussion you referenced.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/lttng/lttng-ust/commi=
t/5db715e800d9b721f48495a987cd26c25965e836" rel=3D"noreferrer" target=3D"_b=
lank">https://github.com/lttng/lttng-ust/commit/5db715e800d9b721f48495a987c=
d26c25965e836</a> &lt;<a href=3D"https://github.com/lttng/lttng-ust/commit/=
5db715e800d9b721f48495a987cd26c25965e836" rel=3D"noreferrer" target=3D"_bla=
nk">https://github.com/lttng/lttng-ust/commit/5db715e800d9b721f48495a987cd2=
6c25965e836</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Please let us know if it doesn&#39;t solve it.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0kienan<br>
&gt; <br>
&gt; <br>
&gt; I updated to lttng-ust 2.13.8 as you suggested.=C2=A0 At first, I pull=
ed in <br>
&gt; the recipe from master branch of Yocto, but had the same problem as <b=
r>
&gt; before after rebuilding.<br>
&gt; <br>
&gt; Next, I downloaded the 2.13.8 lttng-ust tarball from the lttng site an=
d <br>
&gt; setup a native build environment on my target and built lttng-ust 2.13=
.8 <br>
&gt; and my app as a second independent build method for sanity check.=C2=
=A0 I can <br>
&gt; report that I get the exact same result as before this way too.<br>
&gt; <br>
&gt; In both cases, I verified that I had the commit you referenced above.<=
br>
&gt; <br>
&gt; I did a backtrace of the three threads captured in the coredump and sh=
ow <br>
&gt; them below in hopes it will shed light on what I need to try next.<br>
&gt; <br>
&gt; (gdb) thread apply all backtrace<br>
&gt; <br>
&gt; Thread 3 (Thread 0xffffbe7de7e0 (LWP 559)):<br>
&gt; #0 =C2=A0syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38=
<br>
&gt; #1 =C2=A00x0000ffffbeef1bb8 in lttng_ust_futex (val3=3D0, uaddr2=3D0x0=
, <br>
&gt; timeout=3D0x0, val=3D0, op=3D0, uaddr=3D0xffffbefd8000) at <br>
&gt; ../../../src/lib/lttng-ust/futex.h:56<br>
&gt; #2 =C2=A0lttng_ust_futex_async (op=3D0, val=3D0, timeout=3D0x0, uaddr2=
=3D0x0, val3=3D0, <br>
&gt; uaddr=3D0xffffbefd8000) at ../../../src/lib/lttng-ust/futex.h:88<br>
&gt; #3 =C2=A0wait_for_sessiond (sock_info=3D0xffffbef6b638 &lt;global_apps=
&gt;) at <br>
&gt; lttng-ust-comm.c:1761<br>
&gt; #4 =C2=A0ust_listener_thread (arg=3D0xffffbef6b638 &lt;global_apps&gt;=
) at <br>
&gt; lttng-ust-comm.c:1832<br>
&gt; #5 =C2=A00x0000ffffbe9206a8 in start_thread (arg=3D0xffffc1bd8687) at =
<br>
&gt; pthread_create.c:442<br>
&gt; #6 =C2=A00x0000ffffbe98801c in thread_start () at <br>
&gt; ../sysdeps/unix/sysv/linux/aarch64/clone.S:79<br>
&gt; <br>
&gt; Thread 2 (Thread 0xffffbdfce7e0 (LWP 560)):<br>
&gt; #0 =C2=A0syscall () at ../sysdeps/unix/sysv/linux/aarch64/syscall.S:38=
<br>
&gt; #1 =C2=A00x0000ffffbeef1bb8 in lttng_ust_futex (val3=3D0, uaddr2=3D0x0=
, <br>
&gt; timeout=3D0x0, val=3D0, op=3D0, uaddr=3D0xffffbefd7000) at <br>
&gt; ../../../src/lib/lttng-ust/futex.h:56<br>
&gt; #2 =C2=A0lttng_ust_futex_async (op=3D0, val=3D0, timeout=3D0x0, uaddr2=
=3D0x0, val3=3D0, <br>
&gt; uaddr=3D0xffffbefd7000) at ../../../src/lib/lttng-ust/futex.h:88<br>
&gt; #3 =C2=A0wait_for_sessiond (sock_info=3D0xffffbef695e0 &lt;local_apps&=
gt;) at <br>
&gt; lttng-ust-comm.c:1761<br>
&gt; #4 =C2=A0ust_listener_thread (arg=3D0xffffbef695e0 &lt;local_apps&gt;)=
 at <br>
&gt; lttng-ust-comm.c:1832<br>
&gt; #5 =C2=A00x0000ffffbe9206a8 in start_thread (arg=3D0xffffc1bd8687) at =
<br>
&gt; pthread_create.c:442<br>
&gt; #6 =C2=A00x0000ffffbe98801c in thread_start () at <br>
&gt; ../sysdeps/unix/sysv/linux/aarch64/clone.S:79<br>
&gt; <br>
&gt; Thread 1 (Thread 0xffffbefcf460 (LWP 545)):<br>
&gt; #0 =C2=A0__strlen_asimd () at ../sysdeps/aarch64/multiarch/strlen_asim=
d.S:96<br>
&gt; #1 =C2=A00x0000ffffbe834bd0 in lttng_ust_tp_validate_event_name <br>
&gt; (tp=3D0xaaaab8f14de0 <br>
&gt; &lt;lttng_ust_tracepoint_hello_world___my_first_tracepoint&gt;, <br>
&gt; tp=3D0xaaaab8f14de0 <br>
&gt; &lt;lttng_ust_tracepoint_hello_world___my_first_tracepoint&gt;) at <br=
>
&gt; tracepoint.c:143<br>
&gt; #2 =C2=A0add_callsite (tp=3D0xaaaab8f14de0 <br>
&gt; &lt;lttng_ust_tracepoint_hello_world___my_first_tracepoint&gt;, <br>
&gt; lib=3D0xaaaae74fad30) at tracepoint.c:412<br>
&gt; #3 =C2=A0lib_register_callsites (lib=3D0xaaaae74fad30) at tracepoint.c=
:552<br>
&gt; #4 =C2=A0lttng_ust_tracepoint_module_register (tracepoints_start=3D&lt=
;optimized <br>
&gt; out&gt;, tracepoints_count=3D&lt;optimized out&gt;) at tracepoint.c:95=
6<br>
&gt; #5 =C2=A00x0000aaaab8758204 in lttng_ust.tracepoints.ptrs_init ()<br>
&gt; #6 =C2=A00x0000ffffbe8cb30c in call_init (env=3D&lt;optimized out&gt;,=
 <br>
&gt; argv=3D0xffffc1bd8c88, argc=3D1) at ../csu/libc-start.c:145<br>
&gt; #7 =C2=A0__libc_start_main_impl (main=3D0xaaaab867aabc &lt;main&gt;, a=
rgc=3D1, <br>
&gt; argv=3D0xffffc1bd8c88, init=3D&lt;optimized out&gt;, fini=3D&lt;optimi=
zed out&gt;, <br>
&gt; rtld_fini=3D&lt;optimized out&gt;, stack_end=3D&lt;optimized out&gt;) =
at <br>
&gt; ../csu/libc-start.c:376<br>
&gt; #8 =C2=A00x0000aaaab867a7f0 in _start () at ../sysdeps/aarch64/start.S=
:81<br>
&gt; <br>
&gt; Regards,<br>
&gt; <br>
&gt; Brian<br>
</blockquote></div></div>

--000000000000492929061d73f16f--

--===============1071897157144700149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1071897157144700149==--
