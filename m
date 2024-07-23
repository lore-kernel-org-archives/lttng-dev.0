Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE990C3DA63
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Jul 2024 04:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1721710140;
	bh=KNwsdyfwqFMCwZajlCP+a8X35sg5lht6yjXt/1zkLlA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=bQ+bKD7PCEeGFJTlRUIcTkD4RKFmVWBqbvy5gj01Mwv4HFpZ9elDp84BrZjcbGuQz
	 JMKb50bXY01qtDEjzIKnErKVTyu3oaV9xW+rzamSWL98//lFnEZZ1YHFzAbXXPWoCV
	 ivPSG8CQfWxjNF9hSbs6mgyFtNKuLecciNHIUvuYTBHqwFaYk6ZCEq8YzhElJLySTh
	 8766Bd17o7+FXZl0kXO98JOy2TzqwKRAXibvPQ09vK/eQBicr5RMsB6gvfE8rgAB/v
	 5fkzsnWGse4SHJWL7BYJ2s95x6oMo7rTCqccDMpWbyLet39nGVDjZEglWsjIT6/Ave
	 Cbi5RmSnE3BAQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WSl6N0MW3z148m;
	Tue, 23 Jul 2024 00:49:00 -0400 (EDT)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by lists.lttng.org (Postfix) with ESMTPS id 4WSl6K4FhKz13nF
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jul 2024 00:48:57 -0400 (EDT)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cb4c4de4cbso2681372a91.1
 for <lttng-dev@lists.lttng.org>; Mon, 22 Jul 2024 21:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721710136; x=1722314936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0dvAyZb8hMFyZH/MYj9esUZh9TjSQlIPk8taGGxuVaY=;
 b=Tk4mgjatSCPl7Rm9jfAGV8RSZXOptzE/w7B432b20Dv9HavGc/wiwFujDOUbfkRQBJ
 D4VZ1a7ttFoXUonCggYR3wJwG4lGOlxDd1zTnxTIx3cMP9mZ8U27MKunKSTTVUQHW/sD
 j8V5g7QZRHhV/eb+whr2WYJOx0SfcaQTFoShLnbdle6SQPlVuJWJ8914iTyYgKTfCVVg
 xrOQYEfC6z74sFQsJam05nRlEfre4DQnhD/KtlnYP0C439chkKAn/6wjBkHTH4IdiF3q
 RODVsk7SMILRDrVQdMJeSny3IsZUDQHmYEXfbobmgTjtWVFr2mIzger5rxb1Mzo+HtNt
 NHiQ==
X-Gm-Message-State: AOJu0YwMlciME3p7A0ECVmx8iVkB83pspxOyhAEPAbyeeS/01+EYD0R6
 14tRQ1S2I2eFJ+4PvAM1spruk12eZ11/MYww/anK/TAMJXRsXhLMgdd119V69PdAV3njzSCW0zD
 9Tq1WISAVSXw/R8PB0vnet0xnUYk=
X-Google-Smtp-Source: AGHT+IEyK3BM9Aii7xpqihJgKKITcKkSxfL5QQiw3or+d80d3URWkyVaI1T9s89nAIc7565TSIKd1eo2yH6Qf/Qx4X0=
X-Received: by 2002:a17:90a:7307:b0:2cb:5de9:842c with SMTP id
 98e67ed59e1d1-2cd2743b245mr5093160a91.25.1721710134275; Mon, 22 Jul 2024
 21:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAFZh4h_wh01sjAar-QqHsQ=KY4zLjmpmXuJc83OeYue7YyYW3A@mail.gmail.com>
 <CAFZh4h9iaCGdnDhxik9Qtq82f0MGU2eL+8nBa8qoCCJrH-xsGQ@mail.gmail.com>
 <d30f1655-0efa-440a-ac17-fe82342f4556@efficios.com>
 <CAFZh4h_pOCzpJ6ssdZ7ts3vSdJNfEtS+d+2Foi4qAY6oH0+VKw@mail.gmail.com>
 <33527830-3bf3-4bc3-a53d-55eaefb74902@efficios.com>
 <CAFZh4h8k+eGuVJLJ_1vA1_P7+3Hi7h+UgUSmoN51Paxyypw-fA@mail.gmail.com>
 <09087915-9e15-4485-b3d3-f48b245690ec@efficios.com>
In-Reply-To: <09087915-9e15-4485-b3d3-f48b245690ec@efficios.com>
Date: Tue, 23 Jul 2024 00:48:42 -0400
Message-ID: <CAFZh4h_R0E_o4ZVovV_p9Psu-g9nKf_NAd7UFQ-7Lm4Gd1OhMA@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org, yocto@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="000000000000f65438061de2e060"
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000f65438061de2e060
Content-Type: multipart/alternative; boundary="000000000000f65436061de2e05e"

--000000000000f65436061de2e05e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kienan,

Took a while to gather your grocery list but I think I have most of it
below ;)

On Thu, Jul 18, 2024 at 10:27=E2=80=AFAM Kienan Stewart <kstewart@efficios.=
com>
wrote:

> Hi Brian,
>
>
> On 7/17/24 12:27 PM, Brian Hutchinson wrote:
> >
> >
> > On Wed, Jul 17, 2024 at 10:13=E2=80=AFAM Kienan Stewart <kstewart@effic=
ios.com
> > <mailto:kstewart@efficios.com>> wrote:
> >
> >     Hi Brian,
> >
> >     thanks! I'll take a look at these and see if I can get any ideas
> >     from them.
> >
> >     To go back to your original e-mail, a detail that I hadn't noticed =
in
> >     your original backtrace was pointed out to me and I'd like to verif=
y
> >     with you:
> >
> >     ```
> >     Core was generated by `./my_app'.
> >     Program terminated with signal SIGSEGV, Segmentation fault.
> >     #0  __strlen_asimd () at
> ../sysdeps/aarch64/multiarch/strlen_asimd.S:96
> >     96      ../sysdeps/aarch64/multiarch/strlen_asimd.S: No such file o=
r
> >     directory.
> >     [Current thread is 1 (Thread 0xffffb8e2d040 (LWP 757))]
> >     (gdb) bt
> >     #0  __strlen_asimd () at
> ../sysdeps/aarch64/multiarch/strlen_asimd.S:96
> >     #1  0x0000ffffb86c5330 in lttng_ust_tracepoint_module_register ()
> from
> >     /usr/lib/liblttng-ust-tracepoint.so.1
> >     #2  0x0000aaaab4c8da18 in lttng_ust__tracepoints__ptrs_init () at
> >
>  /opt/poky/4.0.18/sysroots/cortexa53-crypto-poky-linux/usr/include/lttng/=
tracepoint.h:629
> >     #3  0x0000ffffb872b30c in call_init (env=3D<optimized out>,
> >     argv=3D0xffffe2d66098, argc=3D1) at ../csu/libc-start.c:145
> >     #4  __libc_start_main_impl (main=3D0xaaaab4bd94e0 <main>, argc=3D1,
> >     argv=3D0xffffe2d66098, init=3D<optimized out>, fini=3D<optimized ou=
t>,
> >     rtld_fini=3D<optimized out>, stack_end=3D<optimized out>) at
> >     ../csu/libc-start.c:376
> >     #5  0x0000aaaab4bd9230 in _start () at ../sysdeps/aarch64/start.S:8=
1
> >     ```
> >
> >     The library loaded at frame 1 is
> >     `/usr/lib/liblttng-ust-tracepoint.so.1`; however, in frame 2 the
> >     reference is from
> >
>  `/opt/poky/4.0.18/sysroots/cortexa53-crypto-poky-linux/usr/include/lttng=
/tracepoint.h`.
> >
> >
> >     Are the LTTng libraries in `/usr/lib` the exact same version as the
> >     headers in
> >
>  `/opt/poky/4.0.18/sysroots/cortexa53-cryptop-poky-linux/usr/include/lttn=
g`?
> >
> >
> > Yes.  The sdk was created by yocto using populate_sdk which includes th=
e
> > target image sysroot in the sdk.  Hopefully I explained that right. The
> > target image drives the contents of the sdk and the generated sdk is
> > what is used to cross compile the application specifically for the
> > target we are running on (NXP imx8mm).
>
> I think that makes sense - the debug information has stored the path of
> the build environment which is the sysroot portion.
>
> >
> >
> >     If some of your app is compiled using one version of headers and a
> >     different version of the library is loaded at runtime, there could
> >     be an
> >     ABI mismatch.
> >
> >
> >     You could check what the include paths are during compilation and
> >     `LD_LIBRARY_PATH` at runtime. Running with the environment variable
> >     `LD_DEBUG=3Dbindings,libs` (see `man ld.so` for more info).
> >
> > I've been down that road a few times before with the same line of
> > thinking (ABI issue) and believe I've proven I don't have those issues.
> > That's one of the reasons I hand built lttng-ust in native environment
> > (on the actual target) to verify it wasn't an issue with a yocto recipe=
,
> > cross compiling etc..
> >
> > I've been thru this process with different OS versions (yocto Dunfell
> > before), kernel version, toolchain version etc., and now the same with
> > Kirkstone based components.
> >
> >     In any case, I'll take a look over the most recent backtraces and
> >     see if
> >     anything else jumps out.
> >
>
> I don't see anything more that stands out.
>
> I'm going to step back a bit to make sure I have correct understanding
> of your situation.
>
> Based on your previous statements, it sounded like you weren't sure if
> your application is statically linked or not. This is different than
> using a statically linked probe provider.
>
> You can verify by running `ldd /path/to/my_app`. lttng-ust doesn't
> support being statically linked, it is always loaded dynamically. The
> trace probe providers (TPPs) may be statically linked, which is different=
.
>
> You mentioned earlier that the building scenario you were using
> resembles the hello world example. To confirm my understanding, do you
> mean the hello-static-lib example in lttng-ust/doc/examples? In the
> docs, this is called "The instrumented application is statically linked
> with the tracepoint provider package archive file". Note that the final
> application still uses dynamic linking (`-ldl -llttng-ust`, and the
> absence of `-static -static-libc` when creating the final executable).
>

I may have not been clear.  Most of the application components are
statically linked but I think there are some that are built as shared
objects (.so's) so that's what I was referring to.  I know that lttng-ust
is dynamically linked ... I think the lttng-ust docs say this is only
option but also makes reference to the fact static linking was once
possible (in some versions of the documentation) but not supported anymore
(I probably have the docs memorized by now ha, ha ... I've looked at many,
many versions of them).

Just for full disclosure my ldd looks like:

       linux-vdso.so.1 (0x0000ffffab196000)
       libfcgi.so.0 =3D> /usr/lib/libfcgi.so.0 (0x0000ffffa57f0000)
       liblttng-ust.so.1 =3D> /usr/lib/liblttng-ust.so.1 (0x0000ffffa575000=
0)
       libxml2.so.2 =3D> /usr/lib/libxml2.so.2 (0x0000ffffa55d0000)
       librt.so.1 =3D> /lib/librt.so.1 (0x0000ffffa55b0000)
       libm.so.6 =3D> /lib/libm.so.6 (0x0000ffffa5510000)
       libstdc++.so.6 =3D> /usr/lib/libstdc++.so.6 (0x0000ffffa52f0000)
       libgcc_s.so.1 =3D> /lib/libgcc_s.so.1 (0x0000ffffa52c0000)
       libc.so.6 =3D> /lib/libc.so.6 (0x0000ffffa5110000)
       /lib/ld-linux-aarch64.so.1 (0x0000ffffab15d000)
       liblttng-ust-common.so.1 =3D> /usr/local/lib/liblttng-ust-common.so.=
1
(0x0000ffffa50e0000)
       liblttng-ust-tracepoint.so.1 =3D>
/usr/local/lib/liblttng-ust-tracepoint.so.1 (0x0000ffffa50a0000)
       libpthread.so.0 =3D> /lib/libpthread.so.0 (0x0000ffffa5080000)
       libz.so.1 =3D> /lib/libz.so.1 (0x0000ffffa5050000)


>
> Further along in stepping back:
>
>   - Does make check for lttng-ust pass in your environment?
>

So I'm glad you mentioned this.  I didn't try to run make check because #1
have never seen anything in the documentation about it and what it does and
#2 It said that it depended on Perl and since this is an embedded system, I
really didn't want to pull it and its dependencies in.

Nevertheless, I ran it on my native target build I setup to see what would
happen.  I didn't notice it complaining about perl so then I checked my
manifest and perl is in fact in our image (I guess some other recipe pulled
it in and I never paid attention to that):

Making check in include
make[1]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/include'
make[1]: Nothing to be done for 'check'.
make[1]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/include'
Making check in src
make[1]: Entering directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/src'
Making check in common
make[2]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/common'
make[2]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/common'
Making check in lib
make[2]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib'
Making check in lttng-ust-common
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-common'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-common'
Making check in lttng-ust-tracepoint
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-tracepoint'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-tracepoint'
Making check in lttng-ust
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust'
Making check in lttng-ust-ctl
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-ctl'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-ctl'
Making check in lttng-ust-fd
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-fd'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-fd'
Making check in lttng-ust-fork
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-fork'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-fork'
Making check in lttng-ust-cyg-profile
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-cyg-profile'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-cyg-profile'
Making check in lttng-ust-libc-wrapper
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-libc-wrapper'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-libc-wrapper'
Making check in lttng-ust-pthread-wrapper
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-pthread-wrapper'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-pthread-wrapper'
Making check in lttng-ust-dl
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-dl'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib/lttng-ust-dl'
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib'
make[3]: Nothing to be done for 'check-am'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib'
make[2]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/src/lib'
make[2]: Entering directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/src'
make[2]: Nothing to be done for 'check-am'.
make[2]: Leaving directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/src'
make[1]: Leaving directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/src'
Making check in tools
make[1]: Entering directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/tools'
make[1]: Nothing to be done for 'check'.
make[1]: Leaving directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/tools'
Making check in doc
make[1]: Entering directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc'
Making check in .
make[2]: Entering directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc'
make[2]: Nothing to be done for 'check-am'.
make[2]: Leaving directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc'
Making check in man
make[2]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/man'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/man'
Making check in examples
make[2]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples'
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/easy-ust'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/easy-ust'
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/demo'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/demo'
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/hello-static-lib'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/hello-static-lib'
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/demo-tracef'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/demo-tracef'
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/clock-override'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/clock-override'
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/getcpu-override'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/getcpu-override'
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/demo-tracelog'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/demo-tracelog'
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/gen-tp'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples/gen-tp'
make[2]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc/examples'
make[1]: Leaving directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/doc'
Making check in tests
make[1]: Entering directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests'
Making check in utils
make[2]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/utils'
make  tap-driver.sh tap.sh utils.sh
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/utils'
make[3]: Nothing to be done for 'tap-driver.sh'.
make[3]: Nothing to be done for 'tap.sh'.
make[3]: Nothing to be done for 'utils.sh'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/utils'
make[2]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/utils'
Making check in unit
make[2]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit'
Making check in gcc-weak-hidden
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/gcc-weak-hidden'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/gcc-weak-hidden'
Making check in libcommon
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/libcommon'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/libcommon'
Making check in libmsgpack
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/libmsgpack'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/libmsgpack'
Making check in libringbuffer
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/libringbuffer'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/libringbuffer'
Making check in pthread_name
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/pthread_name'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/pthread_name'
Making check in snprintf
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/snprintf'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/snprintf'
Making check in ust-elf
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/ust-elf'
make  test_ust_elf
make[4]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/ust-elf'
make[4]: Nothing to be done for 'test_ust_elf'.
make[4]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/ust-elf'
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/ust-elf'
Making check in ust-error
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/ust-error'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/ust-error'
Making check in ust-utils
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/ust-utils'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/ust-utils'
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit'
make[3]: Nothing to be done for 'check-am'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit'
make[2]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit'
Making check in compile
make[2]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile'
Making check in api0
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api0'
Making check in ctf-types
make[4]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api0/ctf-types'
make[4]: Nothing to be done for 'check'.
make[4]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api0/ctf-types'
Making check in hello
make[4]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api0/hello'
make[4]: Nothing to be done for 'check'.
make[4]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api0/hello'
Making check in hello-many
make[4]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api0/hello-many'
make[4]: Nothing to be done for 'check'.
make[4]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api0/hello-many'
Making check in same_line_tracepoint
make[4]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api0/same_line_trace=
point'

make[4]: Nothing to be done for 'check'.
make[4]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api0/same_line_trace=
point'

make[4]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api0'
make[4]: Nothing to be done for 'check-am'.
make[4]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api0'
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api0'
Making check in api1
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1'
Making check in ust-fields
make[4]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1/ust-fields'
make[4]: Nothing to be done for 'check'.
make[4]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1/ust-fields'
Making check in hello
make[4]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1/hello'
make[4]: Nothing to be done for 'check'.
make[4]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1/hello'
Making check in hello-many
make[4]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1/hello-many'
make[4]: Nothing to be done for 'check'.
make[4]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1/hello-many'
Making check in same_line_tracepoint
make[4]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1/same_line_trace=
point'

make[4]: Nothing to be done for 'check'.
make[4]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1/same_line_trace=
point'

Making check in test-app-ctx
make[4]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1/test-app-ctx'
make[4]: Nothing to be done for 'check'.
make[4]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1/test-app-ctx'
make[4]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1'
make[4]: Nothing to be done for 'check-am'.
make[4]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1'
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile/api1'
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile'
make[3]: Nothing to be done for 'check-am'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile'
make[2]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/compile'
Making check in benchmark
make[2]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/benchmark'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/benchmark'
Making check in regression
make[2]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/regression'
Making check in abi0-conflict
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/regression/abi0-conflict'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/regression/abi0-conflict'
make[3]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/regression'
make[3]: Nothing to be done for 'check-am'.
make[3]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/regression'
make[2]: Leaving directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/regression'
make[2]: Entering directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests'
make  check-TESTS
make[3]: Entering directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests'
make[4]: Entering directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests'
PASS: unit/libringbuffer/test_shm 1 - Open a POSIX shm fd
PASS: unit/libringbuffer/test_shm 2 - Create a shm object table
PASS: unit/libringbuffer/test_shm 3 - Allocate the shm object table
PASS: unit/libringbuffer/test_shm 4 - Allocate an object in the shm with
sufficient space
PASS: unit/libringbuffer/test_shm 5 - Allocate an object in the shm with
insufficient space
# unit/gcc-weak-hidden/test_gcc_weak_hidden: Address of weak symbol with
hidden visibility match between compile units within same module for main
program (4 bytes integer object)
# unit/gcc-weak-hidden/test_gcc_weak_hidden: Address of weak symbol with
hidden visibility match between compile units within same module for main
program (pointer object)
# unit/gcc-weak-hidden/test_gcc_weak_hidden: Address of weak symbol with
hidden visibility match between compile units within same module for main
program (24 bytes structure object)
# unit/gcc-weak-hidden/test_gcc_weak_hidden: Address of weak symbol with
hidden visibility match between compile units within same module for shared
library (4 bytes integer object)
# unit/gcc-weak-hidden/test_gcc_weak_hidden: Address of weak symbol with
hidden visibility match between compile units within same module for shared
library (pointer object)
# unit/gcc-weak-hidden/test_gcc_weak_hidden: Address of weak symbol with
hidden visibility match between compile units within same module for shared
library (24 bytes structure object)
PASS: unit/gcc-weak-hidden/test_gcc_weak_hidden 1 - Weak-hidden behavior is
the same for 4 bytes integer and pointer objects within main program
PASS: unit/gcc-weak-hidden/test_gcc_weak_hidden 2 - Weak-hidden behavior is
the same for 4 bytes integer and pointer objects within shared library
PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 1 -
test_get_cpu_mask_from_sysfs - without '\n' expected: '', result: ''
PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 2 -
test_get_cpu_mask_from_sysfs - with '\n' expected: '', result: ''
PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 3 -
test_get_cpu_mask_from_sysfs - without '\n' expected: '0', result: '0'
PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 4 -
test_get_cpu_mask_from_sysfs - with '\n' expected: '0', result: '0'
PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 5 -
test_get_cpu_mask_from_sysfs - without '\n' expected: '0-3', result: '0-3'
PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 6 -
test_get_cpu_mask_from_sysfs - with '\n' expected: '0-3', result: '0-3'
PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 7 -
test_get_cpu_mask_from_sysfs - without '\n' expected: '0,3-7,9', result:
'0,3-7,9'
PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 8 -
test_get_cpu_mask_from_sysfs - with '\n' expected: '0,3-7,9', result:
'0,3-7,9'
# unit/libcommon/test_get_max_cpuid_from_mask: Testing smp helpers
PASS: unit/libcommon/test_get_max_cpuid_from_mask 1 -
get_max_cpuid_from_mask '', expected: '-1', result: '-1'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 2 -
get_max_cpuid_from_mask 'abc', expected: '-1', result: '-1'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 3 -
get_max_cpuid_from_mask ',,,', expected: '-1', result: '-1'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 4 -
get_max_cpuid_from_mask '--', expected: '-1', result: '-1'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 5 -
get_max_cpuid_from_mask ',', expected: '-1', result: '-1'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 6 -
get_max_cpuid_from_mask '-', expected: '-1', result: '-1'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 7 -
get_max_cpuid_from_mask '2147483647', expected: '-1', result: '-1'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 8 -
get_max_cpuid_from_mask '18446744073709551615', expected: '-1', result:
'-1'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 9 -
get_max_cpuid_from_mask '0-2147483647', expected: '-1', result: '-1'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 10 -
get_max_cpuid_from_mask '0-18446744073709551615', expected: '-1', result:
'-1'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 11 -
get_max_cpuid_from_mask '0', expected: '0', result: '0'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 12 -
get_max_cpuid_from_mask '1', expected: '1', result: '1'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 13 -
get_max_cpuid_from_mask '0-1', expected: '1', result: '1'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 14 -
get_max_cpuid_from_mask '1-3', expected: '3', result: '3'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 15 -
get_max_cpuid_from_mask '0,2', expected: '2', result: '2'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 16 -
get_max_cpuid_from_mask '1,2', expected: '2', result: '2'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 17 -
get_max_cpuid_from_mask '0,4-6,127', expected: '127', result: '127'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 18 -
get_max_cpuid_from_mask '0-4095', expected: '4095', result: '4095'
PASS: unit/libcommon/test_get_max_cpuid_from_mask 19 -
get_max_cpuid_from_mask '
PASS: unit/libcommon/test_get_max_cpuid_from_mask 20 -
get_max_cpuid_from_mask 'abc
PASS: unit/libcommon/test_get_max_cpuid_from_mask 21 -
get_max_cpuid_from_mask ',,,
PASS: unit/libcommon/test_get_max_cpuid_from_mask 22 -
get_max_cpuid_from_mask '--
PASS: unit/libcommon/test_get_max_cpuid_from_mask 23 -
get_max_cpuid_from_mask ',
PASS: unit/libcommon/test_get_max_cpuid_from_mask 24 -
get_max_cpuid_from_mask '-
PASS: unit/libcommon/test_get_max_cpuid_from_mask 25 -
get_max_cpuid_from_mask '2147483647
PASS: unit/libcommon/test_get_max_cpuid_from_mask 26 -
get_max_cpuid_from_mask '18446744073709551615
PASS: unit/libcommon/test_get_max_cpuid_from_mask 27 -
get_max_cpuid_from_mask '0-2147483647
PASS: unit/libcommon/test_get_max_cpuid_from_mask 28 -
get_max_cpuid_from_mask '0-18446744073709551615
PASS: unit/libcommon/test_get_max_cpuid_from_mask 29 -
get_max_cpuid_from_mask '0
PASS: unit/libcommon/test_get_max_cpuid_from_mask 30 -
get_max_cpuid_from_mask '1
PASS: unit/libcommon/test_get_max_cpuid_from_mask 31 -
get_max_cpuid_from_mask '0-1
PASS: unit/libcommon/test_get_max_cpuid_from_mask 32 -
get_max_cpuid_from_mask '1-3
PASS: unit/libcommon/test_get_max_cpuid_from_mask 33 -
get_max_cpuid_from_mask '0,2
PASS: unit/libcommon/test_get_max_cpuid_from_mask 34 -
get_max_cpuid_from_mask '1,2
PASS: unit/libcommon/test_get_max_cpuid_from_mask 35 -
get_max_cpuid_from_mask '0,4-6,127
PASS: unit/libcommon/test_get_max_cpuid_from_mask 36 -
get_max_cpuid_from_mask '0-4095
# unit/libcommon/test_get_max_cpuid_from_sysfs: get_max_cpuid_from_sysfs
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 1 -
get_max_cpuid_from_sysfs - cpu set: 'cpu0', expected: '0', result: '0'
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 2 -
get_max_cpuid_from_sysfs - cpu set: 'cpu0 cpu1', expected: '1', result: '1'
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 3 -
get_max_cpuid_from_sysfs - cpu set: 'cpu1 cpu0', expected: '1', result: '1'
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 4 -
get_max_cpuid_from_sysfs - cpu set: 'cpu3', expected: '3', result: '3'
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 5 -
get_max_cpuid_from_sysfs - cpu set: 'cpu99', expected: '99', result: '99'
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 6 -
get_max_cpuid_from_sysfs - cpu set: 'cpu0 cpu3', expected: '3', result: '3'
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 7 -
get_max_cpuid_from_sysfs - cpu set: 'cpufreq cpuidle cpu0 cpu1 cpu2 cpu3',
expected: '3', result: '3'
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 8 -
get_max_cpuid_from_sysfs - cpu set: 'cpu cpu0', expected: '0', result: '0'
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 9 -
get_max_cpuid_from_sysfs - cpu set: 'cpu cpu5', expected: '5', result: '5'
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 10 -
get_max_cpuid_from_sysfs - cpu set: 'toto', expected: '-1', result: '-1'
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 11 -
get_max_cpuid_from_sysfs - cpu set: 'cpu', expected: '-1', result: '-1'
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 12 -
get_max_cpuid_from_sysfs - cpu set: 'cpua cpud', expected: '-1', result:
'-1'
PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 13 -
get_max_cpuid_from_sysfs - cpu set: 'cpufreq cpuidle', expected: '-1',
result: '-1'
PASS: unit/libcommon/test_get_possible_cpus_array_len 1 -
get_possible_cpus_array_len (4 > 0)
PASS: unit/libcommon/test_get_possible_cpus_array_len 2 -
get_num_possible_cpus_fallback (4 > 0)
# unit/libmsgpack/test_msgpack: Testing msgpack implementation
PASS: unit/libmsgpack/test_msgpack 1 - NIL object
PASS: unit/libmsgpack/test_msgpack 2 - String "bye" object
PASS: unit/libmsgpack/test_msgpack 3 - Unsigned integer "1337" object
PASS: unit/libmsgpack/test_msgpack 4 - Unsigned integer "127" object
PASS: unit/libmsgpack/test_msgpack 5 - Unsigned integer "128" object
PASS: unit/libmsgpack/test_msgpack 6 - Unsigned integer "256" object
PASS: unit/libmsgpack/test_msgpack 7 - Unsigned integer "65536" object
PASS: unit/libmsgpack/test_msgpack 8 - Unsigned integer "65535" object
PASS: unit/libmsgpack/test_msgpack 9 - Unsigned integer "4294967295" object
PASS: unit/libmsgpack/test_msgpack 10 - Unsigned integer "4294967296"
object
PASS: unit/libmsgpack/test_msgpack 11 - Signed integer "-32" object
PASS: unit/libmsgpack/test_msgpack 12 - Signed integer "-33" object
PASS: unit/libmsgpack/test_msgpack 13 - Signed integer "-129" object
PASS: unit/libmsgpack/test_msgpack 14 - Signed integer "-32768" object
PASS: unit/libmsgpack/test_msgpack 15 - Signed integer "-32769" object
PASS: unit/libmsgpack/test_msgpack 16 - Signed integer "-2147483648" object
PASS: unit/libmsgpack/test_msgpack 17 - Signed integer "-2147483649" object
PASS: unit/libmsgpack/test_msgpack 18 - double "0.0" object
PASS: unit/libmsgpack/test_msgpack 19 - double "PI" object
PASS: unit/libmsgpack/test_msgpack 20 - double "-PI" object
PASS: unit/libmsgpack/test_msgpack 21 - Array of double object
PASS: unit/libmsgpack/test_msgpack 22 - Map object
PASS: unit/libmsgpack/test_msgpack 23 - Complete capture object
PASS: unit/pthread_name/test_pthread_name 1 - Get the thread name:
'test_pthread_na'
PASS: unit/pthread_name/test_pthread_name 2 - Set a too long thread name:
'thisnameistoolong'
PASS: unit/pthread_name/test_pthread_name 3 - Get the thread name:
'test_pthread_na'
PASS: unit/pthread_name/test_pthread_name 4 - Compare the initial thread
name: 'test_pthread_na' =3D=3D 'test_pthread_na'
PASS: unit/pthread_name/test_pthread_name 5 - Set a short thread name:
'labatt50'
PASS: unit/pthread_name/test_pthread_name 6 - Get a short thread name:
'labatt50'
PASS: unit/pthread_name/test_pthread_name 7 - Compare the short thread
name: 'labatt50' =3D=3D 'labatt50'
PASS: unit/pthread_name/test_pthread_name 8 - Compare the short UST thread
name: 'labatt50-ust' =3D=3D 'labatt50-ust'
PASS: unit/pthread_name/test_pthread_name 9 - Set a long thread name:
'procrastinating'
PASS: unit/pthread_name/test_pthread_name 10 - Get a long thread name:
'procrastinating'
PASS: unit/pthread_name/test_pthread_name 11 - Compare the long thread
name: 'procrastinating' =3D=3D 'procrastinating'
PASS: unit/pthread_name/test_pthread_name 12 - Compare the long UST thread
name: 'procrastina-ust' =3D=3D 'procrastina-ust'
PASS: unit/snprintf/test_snprintf 1 - Got expected output string with
format string "header %d, %s, %03d, '%*d'"
PASS: unit/ust-elf/test_ust_elf 1 - Invoke as:
/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/unit/ust-elf/.libs/lt-ust-elf
<path>
# unit/ust-elf/test_ust_elf: Testing x86 support
PASS: unit/ust-elf/test_ust_elf 2 - lttng_ust_elf_create
PASS: unit/ust-elf/test_ust_elf 3 - lttng_ust_elf_get_memsz returned
successfully
PASS: unit/ust-elf/test_ust_elf 4 - memsz - expected: 5732, got: 5732
PASS: unit/ust-elf/test_ust_elf 5 - lttng_ust_elf_get_build_id returned
successfully
PASS: unit/ust-elf/test_ust_elf 6 - build id marked as found
PASS: unit/ust-elf/test_ust_elf 7 - build_id_len - expected: 20, got: 20
PASS: unit/ust-elf/test_ust_elf 8 - build_id has expected value
PASS: unit/ust-elf/test_ust_elf 9 - lttng_ust_elf_get_debug_link returned
successfully
PASS: unit/ust-elf/test_ust_elf 10 - debug link marked as found
PASS: unit/ust-elf/test_ust_elf 11 - debug link filename - expected:
main.elf.debug, got: main.elf.debug
PASS: unit/ust-elf/test_ust_elf 12 - debug link crc - expected: 0x1531f73c,
got: 0x1531f73c
# unit/ust-elf/test_ust_elf: Testing x86_64 support
PASS: unit/ust-elf/test_ust_elf 13 - lttng_ust_elf_create
PASS: unit/ust-elf/test_ust_elf 14 - lttng_ust_elf_get_memsz returned
successfully
PASS: unit/ust-elf/test_ust_elf 15 - memsz - expected: 2099376, got:
2099376
PASS: unit/ust-elf/test_ust_elf 16 - lttng_ust_elf_get_build_id returned
successfully
PASS: unit/ust-elf/test_ust_elf 17 - build id marked as found
PASS: unit/ust-elf/test_ust_elf 18 - build_id_len - expected: 20, got: 20
PASS: unit/ust-elf/test_ust_elf 19 - build_id has expected value
PASS: unit/ust-elf/test_ust_elf 20 - lttng_ust_elf_get_debug_link returned
successfully
PASS: unit/ust-elf/test_ust_elf 21 - debug link marked as found
PASS: unit/ust-elf/test_ust_elf 22 - debug link filename - expected:
main.elf.debug, got: main.elf.debug
PASS: unit/ust-elf/test_ust_elf 23 - debug link crc - expected: 0xa048a98f,
got: 0xa048a98f
# unit/ust-elf/test_ust_elf: Testing armeb support
PASS: unit/ust-elf/test_ust_elf 24 - lttng_ust_elf_create
PASS: unit/ust-elf/test_ust_elf 25 - lttng_ust_elf_get_memsz returned
successfully
PASS: unit/ust-elf/test_ust_elf 26 - memsz - expected: 34196, got: 34196
PASS: unit/ust-elf/test_ust_elf 27 - lttng_ust_elf_get_build_id returned
successfully
PASS: unit/ust-elf/test_ust_elf 28 - build id marked as found
PASS: unit/ust-elf/test_ust_elf 29 - build_id_len - expected: 20, got: 20
PASS: unit/ust-elf/test_ust_elf 30 - build_id has expected value
PASS: unit/ust-elf/test_ust_elf 31 - lttng_ust_elf_get_debug_link returned
successfully
PASS: unit/ust-elf/test_ust_elf 32 - debug link marked as found
PASS: unit/ust-elf/test_ust_elf 33 - debug link filename - expected:
main.elf.debug, got: main.elf.debug
PASS: unit/ust-elf/test_ust_elf 34 - debug link crc - expected: 0x9d40261b,
got: 0x9d40261b
# unit/ust-elf/test_ust_elf: Testing aarch64_be support
PASS: unit/ust-elf/test_ust_elf 35 - lttng_ust_elf_create
PASS: unit/ust-elf/test_ust_elf 36 - lttng_ust_elf_get_memsz returned
successfully
PASS: unit/ust-elf/test_ust_elf 37 - memsz - expected: 67632, got: 67632
PASS: unit/ust-elf/test_ust_elf 38 - lttng_ust_elf_get_build_id returned
successfully
PASS: unit/ust-elf/test_ust_elf 39 - build id marked as found
PASS: unit/ust-elf/test_ust_elf 40 - build_id_len - expected: 20, got: 20
PASS: unit/ust-elf/test_ust_elf 41 - build_id has expected value
PASS: unit/ust-elf/test_ust_elf 42 - lttng_ust_elf_get_debug_link returned
successfully
PASS: unit/ust-elf/test_ust_elf 43 - debug link marked as found
PASS: unit/ust-elf/test_ust_elf 44 - debug link filename - expected:
main.elf.debug, got: main.elf.debug
PASS: unit/ust-elf/test_ust_elf 45 - debug link crc - expected: 0x2b8cedce,
got: 0x2b8cedce
PASS: unit/ust-elf/test_ust_elf 46 - hello.exec is not PIC
PASS: unit/ust-elf/test_ust_elf 47 - hello.pie is PIC
PASS: unit/ust-elf/test_ust_elf 48 - hello.pic is PIC
PASS: unit/ust-error/test_ust_error 1 - lttng_ust_strerror - Positive
LTTNG_UST_OK returns 'Success' (Success)
PASS: unit/ust-error/test_ust_error 2 - lttng_ust_strerror - Negative
LTTNG_UST_OK returns 'Success' (Success)
PASS: unit/ust-error/test_ust_error 3 - lttng_ust_strerror - Positive large
int returns 'Unknown error' (Unknown error)
PASS: unit/ust-error/test_ust_error 4 - lttng_ust_strerror - Negative large
int returns 'Unknown error' (Unknown error)
PASS: unit/ust-error/test_ust_error 5 - lttng_ust_strerror - Positive
LTTNG_UST_ERR_NR returns 'Unknown error' (Unknown error)
PASS: unit/ust-error/test_ust_error 6 - lttng_ust_strerror - Negative
LTTNG_UST_ERR_NR returns 'Unknown error' (Unknown error)
PASS: unit/ust-error/test_ust_error 7 - lttng_ust_strerror - Positive
LTTNG_UST_ERR_NR + 1 returns 'Unknown error' (Unknown error)
PASS: unit/ust-error/test_ust_error 8 - lttng_ust_strerror - Negative
LTTNG_UST_ERR_NR - 1 returns 'Unknown error' (Unknown error)
PASS: unit/ust-error/test_ust_error 9 - lttng_ust_strerror - Positive
LTTNG_UST_ERR_NOENT returns 'Unknown error' (Unknown error)
PASS: unit/ust-error/test_ust_error 10 - lttng_ust_strerror - Negative
LTTNG_UST_ERR_NOENT returns 'No entry' (No entry)
PASS: unit/ust-error/test_ust_error 11 - lttng_ust_strerror - Positive
LTTNG_UST_ERR_PEERCRED_PID returns 'Unknown error' (Unknown error)
PASS: unit/ust-error/test_ust_error 12 - lttng_ust_strerror - Negative
LTTNG_UST_ERR_PEERCRED_PID returns 'Peer credentials PID is invalid. Socket
appears to belong to a distinct, non-nested pid namespace.' (Peer
credentials PID is invalid. Socket appears to belong to a disti)
PASS: unit/ust-utils/test_ust_utils 1 - lttng_ust_stringify - literal
integer
PASS: unit/ust-utils/test_ust_utils 2 - lttng_ust_stringify - identifier
PASS: unit/ust-utils/test_ust_utils 3 - lttng_ust_is_signed_type - 'signed
char' is signed
PASS: unit/ust-utils/test_ust_utils 4 - lttng_ust_is_signed_type - 'short'
is signed
PASS: unit/ust-utils/test_ust_utils 5 - lttng_ust_is_signed_type - 'int' is
signed
PASS: unit/ust-utils/test_ust_utils 6 - lttng_ust_is_signed_type - 'long'
is signed
PASS: unit/ust-utils/test_ust_utils 7 - lttng_ust_is_signed_type - 'long
long' is signed
PASS: unit/ust-utils/test_ust_utils 8 - lttng_ust_is_signed_type - 'float'
is signed
PASS: unit/ust-utils/test_ust_utils 9 - lttng_ust_is_signed_type - 'double'
is signed
PASS: unit/ust-utils/test_ust_utils 10 - lttng_ust_is_signed_type - 'long
double' is signed
PASS: unit/ust-utils/test_ust_utils 11 - lttng_ust_is_signed_type -
'int8_t' is signed
PASS: unit/ust-utils/test_ust_utils 12 - lttng_ust_is_signed_type -
'int16_t' is signed
PASS: unit/ust-utils/test_ust_utils 13 - lttng_ust_is_signed_type -
'int32_t' is signed
PASS: unit/ust-utils/test_ust_utils 14 - lttng_ust_is_signed_type -
'int64_t' is signed
PASS: unit/ust-utils/test_ust_utils 15 - lttng_ust_is_signed_type -
'intmax_t' is signed
PASS: unit/ust-utils/test_ust_utils 16 - lttng_ust_is_signed_type -
'ssize_t' is signed
PASS: unit/ust-utils/test_ust_utils 17 - lttng_ust_is_signed_type -
'ptrdiff_t' is signed
PASS: unit/ust-utils/test_ust_utils 18 - lttng_ust_is_signed_type -
'intptr_t' is signed
PASS: unit/ust-utils/test_ust_utils 19 - lttng_ust_is_signed_type -
'unsigned char' is unsigned
PASS: unit/ust-utils/test_ust_utils 20 - lttng_ust_is_signed_type -
'unsigned short' is unsigned
PASS: unit/ust-utils/test_ust_utils 21 - lttng_ust_is_signed_type -
'unsigned int' is unsigned
PASS: unit/ust-utils/test_ust_utils 22 - lttng_ust_is_signed_type -
'unsigned long' is unsigned
PASS: unit/ust-utils/test_ust_utils 23 - lttng_ust_is_signed_type -
'unsigned long long' is unsigned
PASS: unit/ust-utils/test_ust_utils 24 - lttng_ust_is_signed_type -
'uint8_t' is unsigned
PASS: unit/ust-utils/test_ust_utils 25 - lttng_ust_is_signed_type -
'uint16_t' is unsigned
PASS: unit/ust-utils/test_ust_utils 26 - lttng_ust_is_signed_type -
'uint32_t' is unsigned
PASS: unit/ust-utils/test_ust_utils 27 - lttng_ust_is_signed_type -
'uint64_t' is unsigned
PASS: unit/ust-utils/test_ust_utils 28 - lttng_ust_is_signed_type -
'uintmax_t' is unsigned
PASS: unit/ust-utils/test_ust_utils 29 - lttng_ust_is_signed_type - '_Bool'
is unsigned
PASS: unit/ust-utils/test_ust_utils 30 - lttng_ust_is_signed_type -
'size_t' is unsigned
PASS: unit/ust-utils/test_ust_utils 31 - lttng_ust_is_signed_type - 'void
*' is unsigned
PASS: unit/ust-utils/test_ust_utils 32 - lttng_ust_is_integer_type - 'char'
is an integer
PASS: unit/ust-utils/test_ust_utils 33 - lttng_ust_is_integer_type -
'short' is an integer
PASS: unit/ust-utils/test_ust_utils 34 - lttng_ust_is_integer_type - 'int'
is an integer
PASS: unit/ust-utils/test_ust_utils 35 - lttng_ust_is_integer_type - 'long'
is an integer
PASS: unit/ust-utils/test_ust_utils 36 - lttng_ust_is_integer_type - 'long
long' is an integer
PASS: unit/ust-utils/test_ust_utils 37 - lttng_ust_is_integer_type -
'signed char' is an integer
PASS: unit/ust-utils/test_ust_utils 38 - lttng_ust_is_integer_type -
'signed short' is an integer
PASS: unit/ust-utils/test_ust_utils 39 - lttng_ust_is_integer_type -
'signed int' is an integer
PASS: unit/ust-utils/test_ust_utils 40 - lttng_ust_is_integer_type -
'signed long' is an integer
PASS: unit/ust-utils/test_ust_utils 41 - lttng_ust_is_integer_type -
'signed long long' is an integer
PASS: unit/ust-utils/test_ust_utils 42 - lttng_ust_is_integer_type -
'unsigned char' is an integer
PASS: unit/ust-utils/test_ust_utils 43 - lttng_ust_is_integer_type -
'unsigned short' is an integer
PASS: unit/ust-utils/test_ust_utils 44 - lttng_ust_is_integer_type -
'unsigned int' is an integer
PASS: unit/ust-utils/test_ust_utils 45 - lttng_ust_is_integer_type -
'unsigned long' is an integer
PASS: unit/ust-utils/test_ust_utils 46 - lttng_ust_is_integer_type -
'unsigned long long' is an integer
PASS: unit/ust-utils/test_ust_utils 47 - lttng_ust_is_integer_type -
'int8_t' is an integer
PASS: unit/ust-utils/test_ust_utils 48 - lttng_ust_is_integer_type -
'int16_t' is an integer
PASS: unit/ust-utils/test_ust_utils 49 - lttng_ust_is_integer_type -
'int32_t' is an integer
PASS: unit/ust-utils/test_ust_utils 50 - lttng_ust_is_integer_type -
'int64_t' is an integer
PASS: unit/ust-utils/test_ust_utils 51 - lttng_ust_is_integer_type -
'intmax_t' is an integer
PASS: unit/ust-utils/test_ust_utils 52 - lttng_ust_is_integer_type -
'uint8_t' is an integer
PASS: unit/ust-utils/test_ust_utils 53 - lttng_ust_is_integer_type -
'uint16_t' is an integer
PASS: unit/ust-utils/test_ust_utils 54 - lttng_ust_is_integer_type -
'uint32_t' is an integer
PASS: unit/ust-utils/test_ust_utils 55 - lttng_ust_is_integer_type -
'uint64_t' is an integer
PASS: unit/ust-utils/test_ust_utils 56 - lttng_ust_is_integer_type -
'uintmax_t' is an integer
PASS: unit/ust-utils/test_ust_utils 57 - lttng_ust_is_integer_type -
'float' is not an integer
PASS: unit/ust-utils/test_ust_utils 58 - lttng_ust_is_integer_type -
'double' is not an integer
PASS: unit/ust-utils/test_ust_utils 59 - lttng_ust_is_integer_type - 'long
double' is not an integer
PASS: unit/ust-utils/test_ust_utils 60 - lttng_ust_is_integer_type - 'void
*' is not an integer
PASS: unit/ust-utils/test_ust_utils 61 - lttng_ust_is_pointer_type - 'char'
is not a pointer
PASS: unit/ust-utils/test_ust_utils 62 - lttng_ust_is_pointer_type -
'short' is not a pointer
PASS: unit/ust-utils/test_ust_utils 63 - lttng_ust_is_pointer_type - 'int'
is not a pointer
PASS: unit/ust-utils/test_ust_utils 64 - lttng_ust_is_pointer_type - 'long'
is not a pointer
PASS: unit/ust-utils/test_ust_utils 65 - lttng_ust_is_pointer_type - 'long
long' is not a pointer
PASS: unit/ust-utils/test_ust_utils 66 - lttng_ust_is_pointer_type -
'signed char' is not a pointer
PASS: unit/ust-utils/test_ust_utils 67 - lttng_ust_is_pointer_type -
'signed short' is not a pointer
PASS: unit/ust-utils/test_ust_utils 68 - lttng_ust_is_pointer_type -
'signed int' is not a pointer
PASS: unit/ust-utils/test_ust_utils 69 - lttng_ust_is_pointer_type -
'signed long' is not a pointer
PASS: unit/ust-utils/test_ust_utils 70 - lttng_ust_is_pointer_type -
'signed long long' is not a pointer
PASS: unit/ust-utils/test_ust_utils 71 - lttng_ust_is_pointer_type -
'unsigned char' is not a pointer
PASS: unit/ust-utils/test_ust_utils 72 - lttng_ust_is_pointer_type -
'unsigned short' is not a pointer
PASS: unit/ust-utils/test_ust_utils 73 - lttng_ust_is_pointer_type -
'unsigned int' is not a pointer
PASS: unit/ust-utils/test_ust_utils 74 - lttng_ust_is_pointer_type -
'unsigned long' is not a pointer
PASS: unit/ust-utils/test_ust_utils 75 - lttng_ust_is_pointer_type -
'unsigned long long' is not a pointer
PASS: unit/ust-utils/test_ust_utils 76 - lttng_ust_is_pointer_type -
'int8_t' is not a pointer
PASS: unit/ust-utils/test_ust_utils 77 - lttng_ust_is_pointer_type -
'int16_t' is not a pointer
PASS: unit/ust-utils/test_ust_utils 78 - lttng_ust_is_pointer_type -
'int32_t' is not a pointer
PASS: unit/ust-utils/test_ust_utils 79 - lttng_ust_is_pointer_type -
'int64_t' is not a pointer
PASS: unit/ust-utils/test_ust_utils 80 - lttng_ust_is_pointer_type -
'intmax_t' is not a pointer
PASS: unit/ust-utils/test_ust_utils 81 - lttng_ust_is_pointer_type -
'uint8_t' is not a pointer
PASS: unit/ust-utils/test_ust_utils 82 - lttng_ust_is_pointer_type -
'uint16_t' is not a pointer
PASS: unit/ust-utils/test_ust_utils 83 - lttng_ust_is_pointer_type -
'uint32_t' is not a pointer
PASS: unit/ust-utils/test_ust_utils 84 - lttng_ust_is_pointer_type -
'uint64_t' is not a pointer
PASS: unit/ust-utils/test_ust_utils 85 - lttng_ust_is_pointer_type -
'uintmax_t' is not a pointer
PASS: unit/ust-utils/test_ust_utils 86 - lttng_ust_is_pointer_type -
'float' is not a pointer
PASS: unit/ust-utils/test_ust_utils 87 - lttng_ust_is_pointer_type -
'double' is not a pointer
PASS: unit/ust-utils/test_ust_utils 88 - lttng_ust_is_pointer_type - 'long
double' is not a pointer
PASS: unit/ust-utils/test_ust_utils 89 - lttng_ust_is_pointer_type - 'void
*' is a pointer
PASS: unit/ust-utils/test_ust_utils 90 - lttng_ust_is_pointer_type - 'void
**' is a pointer
PASS: unit/ust-utils/test_ust_utils 91 - lttng_ust_is_pointer_type -
'struct dummy *' is a pointer
PASS: unit/ust-utils/test_ust_utils 92 - lttng_ust_is_pointer_type - 'int
*' is a pointer
PASS: unit/ust-utils/test_ust_utils 93 - lttng_ust_is_pointer_type - 'float
*' is a pointer
PASS: unit/ust-utils/test_ust_utils 94 - lttng_ust_is_pointer_type -
'double *' is a pointer
# regression/abi0-conflict/test_abi0_conflict: LD_PRELOAD
PASS: regression/abi0-conflict/test_abi0_conflict 1 - LD_PRELOAD: no-ust
app works
PASS: regression/abi0-conflict/test_abi0_conflict 2 - LD_PRELOAD: no-ust
app with abi0 preload succeeds
PASS: regression/abi0-conflict/test_abi0_conflict 3 - LD_PRELOAD: no-ust
app with abi0 and abi1 preload fails
PASS: regression/abi0-conflict/test_abi0_conflict 4 - LD_PRELOAD: no-ust
app with abi1 and abi0 preload fails
PASS: regression/abi0-conflict/test_abi0_conflict 5 - LD_PRELOAD: ust app
works
PASS: regression/abi0-conflict/test_abi0_conflict 6 - LD_PRELOAD: ust app
with abi0 preload fails
PASS: regression/abi0-conflict/test_abi0_conflict 7 - LD_PRELOAD: ust app
with abi0 and abi1 preload fails
PASS: regression/abi0-conflict/test_abi0_conflict 8 - LD_PRELOAD: ust app
with abi1 and abi0 preload fails
# regression/abi0-conflict/test_abi0_conflict: dlopen
PASS: regression/abi0-conflict/test_abi0_conflict 9 - dlopen: no-ust app
works
PASS: regression/abi0-conflict/test_abi0_conflict 10 - dlopen: no-ust app
with abi1 and abi1 succeeds
PASS: regression/abi0-conflict/test_abi0_conflict 11 - dlopen: no-ust app
with abi0 and abi1 fails
PASS: regression/abi0-conflict/test_abi0_conflict 12 - dlopen: no-ust app
with abi1 and abi0 fails
PASS: regression/abi0-conflict/test_abi0_conflict 13 - dlopen: ust app
works
PASS: regression/abi0-conflict/test_abi0_conflict 14 - dlopen: ust app with
abi0 fails
PASS: regression/abi0-conflict/test_abi0_conflict 15 - dlopen: ust app with
abi0 and abi1 fails
PASS: regression/abi0-conflict/test_abi0_conflict 16 - dlopen: ust app with
abi1 and abi0 fails
# regression/abi0-conflict/test_abi0_conflict: Indirect linking
PASS: regression/abi0-conflict/test_abi0_conflict 17 - indirect: no-ust app
with abi0 succeeds
PASS: regression/abi0-conflict/test_abi0_conflict 18 - indirect: no-ust app
with abi1 succeeds
PASS: regression/abi0-conflict/test_abi0_conflict 19 - indirect: no-ust app
with abi0 and abi1 fails
PASS: regression/abi0-conflict/test_abi0_conflict 20 - indirect: ust app
with abi0 fails
PASS: regression/abi0-conflict/test_abi0_conflict 21 - indirect: ust app
with abi1 succeeds
PASS: regression/abi0-conflict/test_abi0_conflict 22 - indirect: ust app
with abi0 and abi1 fails
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Testsuite summary for lttng-ust 2.13.8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

# TOTAL: 278
# PASS:  278
# SKIP:  0
# XFAIL: 0
# FAIL:  0
# XPASS: 0
# ERROR: 0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

make[4]: Leaving directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests'
make[3]: Leaving directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests'
make[2]: Leaving directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests'
make[1]: Leaving directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests'
Making check in extras
make[1]: Entering directory
'/home/iadmin/lttng-ust/lttng-ust-2.13.8/extras'
make[1]: Nothing to be done for 'check'.
make[1]: Leaving directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8/extras'
make[1]: Entering directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8'
make[1]: Nothing to be done for 'check-am'.
make[1]: Leaving directory '/home/iadmin/lttng-ust/lttng-ust-2.13.8'


>   - Does make check for lttng-tools pass in your environment?
>

I'm still using lttng-tools built by yocto so I don't know how to run make
check in that situation.  From devtool maybe???  I don't know, I'd have to
look into that one.   I never upgraded lttng-tools either, only upgraded
lttng-ust and built from source tar to get the fix you mentioned for TLS
stuff.

  - Is this reproducible in non-yocto environments or on other
> architectures with the same project?
>

Hmm, that's a good question.  I don't have any other embedded targets to
try this on that are a different arch.  I think I heard at one point early
on a heavily stubbed out version ran on a PC but I'd have to look into that=
.


>   - Does running the traced application with `LTTNG_UST_DEBUG=3D1` yield
> more information?
>

So far I've just been trying to get the app to run without even starting
lttng just to get past segfault issue.  Here is what it looks like with
debug turned on without starting lttng or a lttng-sessiond:

iblttng_ust_tracepoint[599/599]: Your compiler treats weak symbols with
hidden visibility for integer objects as SAME address between compile units
part of the same module. (in check_weak_hidden() at tracepoint.c:1012)
liblttng_ust_tracepoint[599/599]: Your compiler treats weak symbols with
hidden visibility for pointer objects as SAME address between compile units
part of the same module. (in check_weak_hidden() at tracepoint.c:1016)
liblttng_ust_tracepoint[599/599]: Your compiler treats weak symbols with
hidden visibility for 24-byte structure objects as SAME address between
compile units part of the same module. (in check_weak_hidden() at
tracepoint.c:1020)
liblttng_ust_tracepoint[599/599]: just registered a tracepoints section
from 0xffffb91aec00 and having 26 tracepoints (in
lttng_ust_tracepoint_module_register() at tracepoint.c:960)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_statedump:end" (in lttng_ust_tracepoint_module_register() at
tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_statedump:procname" (in lttng_ust_tracepoint_module_register()
at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_statedump:debug_link" (in lttng_ust_tracepoint_module_register()
at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_statedump:build_id" (in lttng_ust_tracepoint_module_register()
at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_statedump:bin_info" (in lttng_ust_tracepoint_module_register()
at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_statedump:start" (in lttng_ust_tracepoint_module_register() at
tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_lib:unload" (in lttng_ust_tracepoint_module_register() at
tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_lib:debug_link" (in lttng_ust_tracepoint_module_register() at
tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_lib:build_id" (in lttng_ust_tracepoint_module_register() at
tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_lib:load" (in lttng_ust_tracepoint_module_register() at
tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracef:event" (in lttng_ust_tracepoint_module_register() at
tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_LINE" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_FUNCTION" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_UNIT" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_MODULE" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_PROCESS" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_PROGRAM" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_SYSTEM" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_INFO" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_NOTICE" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_WARNING" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_ERR" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_CRIT" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_ALERT" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust_tracepoint[599/599]: registered tracepoint:
"lttng_ust_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_EMERG" (in
lttng_ust_tracepoint_module_register() at tracepoint.c:968)
liblttng_ust[599/599]: Provider "lttng_ust_statedump" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_statedump" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_statedump" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_statedump" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_statedump" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_statedump" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_statedump" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: adding probe lttng_ust_statedump containing 6 events
to lazy registration list (in lttng_ust_probe_register() at
lttng-probes.c:254)
liblttng_ust[599/599]: Provider "lttng_ust_lib" accepted, version 3.0 is
compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_lib" accepted, version 3.0 is
compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_lib" accepted, version 3.0 is
compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_lib" accepted, version 3.0 is
compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_lib" accepted, version 3.0 is
compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: adding probe lttng_ust_lib containing 4 events to
lazy registration list (in lttng_ust_probe_register() at
lttng-probes.c:254)
liblttng_ust[599/599]: Provider "lttng_ust_tracef" accepted, version 3.0 is
compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracef" accepted, version 3.0 is
compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: adding probe lttng_ust_tracef containing 1 events to
lazy registration list (in lttng_ust_probe_register() at
lttng-probes.c:254)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: Provider "lttng_ust_tracelog" accepted, version 3.0
is compatible with LTTng UST provider version 3.0. (in
check_provider_version() at lttng-probes.c:50)
liblttng_ust[599/599]: adding probe lttng_ust_tracelog containing 15 events
to lazy registration list (in lttng_ust_probe_register() at
lttng-probes.c:254)
liblttng_ust[599/599]: dlopened liblttng-ust shared library
(liblttng-ust.so.1). (in lttng_ust_ctor() at lttng-ust-comm.c:2217)
libringbuffer-clients[599/599]: LTT : ltt ring buffer client
"relay-metadata-mmap" init
(in lttng_ring_buffer_metadata_client_init() at
../../src/common/ringbuffer-clients/metadata-template.h:364)
libringbuffer-clients[599/599]: LTT : ltt ring buffer client
"relay-overwrite-mmap" init
(in lttng_ring_buffer_client_overwrite_init() at
../../src/common/ringbuffer-clients/template.h:826)
libringbuffer-clients[599/599]: LTT : ltt ring buffer client
"relay-overwrite-rt-mmap" init
(in lttng_ring_buffer_client_overwrite_rt_init() at
../../src/common/ringbuffer-clients/template.h:826)
libringbuffer-clients[599/599]: LTT : ltt ring buffer client
"relay-discard-mmap" init
(in lttng_ring_buffer_client_discard_init() at
../../src/common/ringbuffer-clients/template.h:826)
libringbuffer-clients[599/599]: LTT : ltt ring buffer client
"relay-discard-rt-mmap" init
(in lttng_ring_buffer_client_discard_rt_init() at
../../src/common/ringbuffer-clients/template.h:826)
liblttng_ust[599/601]: Info: sessiond not accepting connections to local
apps socket (in ust_listener_thread() at lttng-ust-comm.c:1884)
liblttng_ust[599/601]: Waiting for local apps sessiond (in
wait_for_sessiond() at lttng-ust-comm.c:1758)
liblttng_ust[599/600]: Info: sessiond not accepting connections to global
apps socket (in ust_listener_thread() at lttng-ust-comm.c:1884)
Segmentation fault


>   - I'd also run lttng-sessiond with the environment variable
> `LTTNG_UST_DEBUG=3D1` set and `-vvv --verbose-consumer` in the program
> arguments and capture for stdout & stderr into a file for analysis.
>   - Verify if the main program is dynamically linked with `ldd`
>   - Verify which libraries are loaded at runtime and which calls are
> shimmed with `LD_DEBUG=3Dlibs,binding`
>

I provided some of this above.
The output of LD_DEBUG=3Dlibs,bindings is attached as file
ld_debug-libs-bindings.txt
in attached tar file (had to use compression as system rejected this post
as it was too large).


>   - Review in detail which gcc commands are executed to produce the
> tracepoint provider and link it to the main executable.
>

Just like the hello example in the documentation


>
> My current understanding is that the statedump tracepoints are
> registered and those events communicated before the main program's init
> is run (at least for C programs). If you do the following test, I think
> you should be able to see the statedumps. Could you confirm if you have
> them or not?
>
>
> ```
> LTTNG_UST_DEBUG=3D1 lttng-sessiond -vvv --verbose-consumer &>
> /tmp/sessiond.log &
> lttng create
> lttng enable-event -u --all
> lttng start
>
> unset LTTNG_UST_WITHOUT_BADDR_STATEDUMP
> unset LTTNG_UST_WITHOUT_PROCNAME_STATEDUMP
> LTTNG_UST_DEBUG=3D1 LTTNG_UST_REGISTER_TIMEOUT=3D-1 ./my_app
> # Segfault?
>

Yes, still segfault.  The sessiond.log is in attached tar file.


>
> lttng stop
> lttng view # Here you should have the statedump events
> killall lttng-sessiond
>

So the embedded target doesn't have babletrace so I archived the session
and transferred it over to my dev PC and used tracecompas to view the
lttng-session.

You can see that in the my_session.csv file in the attached tar.


> ```
>
> >
> > Thanks!  I'm running out of things to try.
>
> Ultimately, given the bespoke environment, build steps, and application
> it's tough to diagnose a lot of things that we would go over with a fine
> tooth comb: seeing how the TPPs are built and linked, seeing how the
> application is built and linked, analyzing what's happening at runtime,
> having a coredump that allows us to see the variables, etc.
>
> If you can provide a minimal reproducer, it's possible to dig further
> into it.
>
> Otherwise, to look in more detail at your specific project would be
> covered under a service contract (for which we can sign NDAs, etc. as
> needed). Feel free to reach out the sales@efficios.com to organise that.
>

I understand but so far schedules & budget/priorities haven't aligned so
once again I've been scheduled to look at this issue again since we last
tried it on older Dunfell OS with older versions of lttng and it looks like
we have the same problem as before.

Thanks for your help!

Regards,

Brian


>
> >
> > I don't fully understand the implications of some of this documentation=
,
> > but I have learned enough to know LD_PRELOAD means nothing if everythin=
g
> > is static built.  Our application is heavily multi threaded, uses fork,
> > clone and who knows if it's doing double closes or not ... so I've trie=
d
> > these LD_PRELOAD "helpers" or whatever they are, before and didn't get =
a
> > different result, but now know it's only for shared library object.  So
> > now I will experiment with making our tpp a shared object and try
> > LD_PRELOAD of fork, fd and pthread helpers and starting my app that way=
.
>
> LD_PRELOAD has an effect if the application you are running is
> dynamically linked (note: the TPP can be statically linked inside an
> dynamically linked executable, and the preloads are still useful and/or
> needed in that case).
>
> The function of the helpers are to ensure that various system calls
> don't clobber things in use by lttng-ust. E.g., close() is shimmed by
> liblttng-ust-fd.so so that FDs that lttng-ust uses aren't suddenly shut
> by the program.
>
> If you want to see it in action, you could try an experiment with a
> slightly modified hello-static-lib application, with instructions in the
> top comment:
> https://gist.github.com/kienanstewart/299eb6a511d92d458569b210e4a418a8
>
> The effect of the preloads such as liblttng-ust-fd.so are independent of
> how the TPP is built and linked to the application or library.
>
> thanks,
> kienan
>
> >
> > This is what I'm referring to above from the lttng docs:
> >
> >
> >           Use LTTng-UST with daemons
> >           <
> https://lttng.org/docs/v2.13/#doc-using-lttng-ust-with-daemons>
> >
> > If your instrumented application calls fork(2)
> > <https://man7.org/linux/man-pages/man2/fork.2.html>, clone(2)
> > <https://man7.org/linux/man-pages/man2/clone.2.html>, or BSD=E2=80=99s =
rfork(2)
> > <
> http://www.freebsd.org/cgi/man.cgi?query=3Drfork&sektion=3D2&manpath=3DFr=
eeBSD+4.10-RELEASE>,
> without a following exec(3) <
> https://man7.org/linux/man-pages/man3/exec.3.html>-family system call,
> you must preload the |liblttng-ust-fork.so| shared object when you start
> the application.
> >
> > LD_PRELOAD=3Dliblttng-ust-fork.so ./my-app
> >
> > If your tracepoint provider package is a shared library which you also
> > preload, you must put both shared objects in |LD_PRELOAD|:
> >
> > LD_PRELOAD=3Dliblttng-ust-fork.so:/path/to/tp.so ./my-app
> >
> >
> >           Use LTTng-UST with applications which close file descriptors
> >           that don=E2=80=99t belong to them
> >           <https://lttng.org/docs/v2.13/#doc-liblttng-ust-fd>
> >
> > Since 2.9
> >
> > If your instrumented application closes one or more file descriptors
> > which it did not open itself, you must preload the |liblttng-ust-fd.so|
> > shared object when you start the application:
> >
> > LD_PRELOAD=3Dliblttng-ust-fd.so ./my-app
> >
> > Typical use cases include closing all the file descriptors after fork(2=
)
> > <https://man7.org/linux/man-pages/man2/fork.2.html> or rfork(2)
> > <
> http://www.freebsd.org/cgi/man.cgi?query=3Drfork&sektion=3D2&manpath=3DFr=
eeBSD+4.10-RELEASE>
> and buggy applications doing =E2=80=9Cdouble closes=E2=80=9D.
> >
> >
> > Thanks,
> >
> > Brian
> >
> >
>

--000000000000f65436061de2e05e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi Kienan,</div><div dir=
=3D"ltr"><br></div><div>Took a while to gather your grocery list but I thin=
k I have most of it below ;)</div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 18, 2024 at 10:27=E2=80=AFAM =
Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com">kstewart@effici=
os.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi Brian,<br>
<br>
<br>
On 7/17/24 12:27 PM, Brian Hutchinson wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Jul 17, 2024 at 10:13=E2=80=AFAM Kienan Stewart &lt;<a href=3D=
"mailto:kstewart@efficios.com" target=3D"_blank">kstewart@efficios.com</a> =
<br>
&gt; &lt;mailto:<a href=3D"mailto:kstewart@efficios.com" target=3D"_blank">=
kstewart@efficios.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Brian,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0thanks! I&#39;ll take a look at these and see if I =
can get any ideas<br>
&gt;=C2=A0 =C2=A0 =C2=A0from them.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0To go back to your original e-mail, a detail that I=
 hadn&#39;t noticed in<br>
&gt;=C2=A0 =C2=A0 =C2=A0your original backtrace was pointed out to me and I=
&#39;d like to verify<br>
&gt;=C2=A0 =C2=A0 =C2=A0with you:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0```<br>
&gt;=C2=A0 =C2=A0 =C2=A0Core was generated by `./my_app&#39;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Program terminated with signal SIGSEGV, Segmentatio=
n fault.<br>
&gt;=C2=A0 =C2=A0 =C2=A0#0=C2=A0 __strlen_asimd () at ../sysdeps/aarch64/mu=
ltiarch/strlen_asimd.S:96<br>
&gt;=C2=A0 =C2=A0 =C2=A096=C2=A0 =C2=A0 =C2=A0 ../sysdeps/aarch64/multiarch=
/strlen_asimd.S: No such file or<br>
&gt;=C2=A0 =C2=A0 =C2=A0directory.<br>
&gt;=C2=A0 =C2=A0 =C2=A0[Current thread is 1 (Thread 0xffffb8e2d040 (LWP 75=
7))]<br>
&gt;=C2=A0 =C2=A0 =C2=A0(gdb) bt<br>
&gt;=C2=A0 =C2=A0 =C2=A0#0=C2=A0 __strlen_asimd () at ../sysdeps/aarch64/mu=
ltiarch/strlen_asimd.S:96<br>
&gt;=C2=A0 =C2=A0 =C2=A0#1=C2=A0 0x0000ffffb86c5330 in lttng_ust_tracepoint=
_module_register () from<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib/liblttng-ust-tracepoint.so.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0#2=C2=A0 0x0000aaaab4c8da18 in lttng_ust__tracepoin=
ts__ptrs_init () at<br>
&gt;=C2=A0 =C2=A0 =C2=A0/opt/poky/4.0.18/sysroots/cortexa53-crypto-poky-lin=
ux/usr/include/lttng/tracepoint.h:629<br>
&gt;=C2=A0 =C2=A0 =C2=A0#3=C2=A0 0x0000ffffb872b30c in call_init (env=3D&lt=
;optimized out&gt;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0argv=3D0xffffe2d66098, argc=3D1) at ../csu/libc-sta=
rt.c:145<br>
&gt;=C2=A0 =C2=A0 =C2=A0#4=C2=A0 __libc_start_main_impl (main=3D0xaaaab4bd9=
4e0 &lt;main&gt;, argc=3D1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0argv=3D0xffffe2d66098, init=3D&lt;optimized out&gt;=
, fini=3D&lt;optimized out&gt;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0rtld_fini=3D&lt;optimized out&gt;, stack_end=3D&lt;=
optimized out&gt;) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0../csu/libc-start.c:376<br>
&gt;=C2=A0 =C2=A0 =C2=A0#5=C2=A0 0x0000aaaab4bd9230 in _start () at ../sysd=
eps/aarch64/start.S:81<br>
&gt;=C2=A0 =C2=A0 =C2=A0```<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The library loaded at frame 1 is<br>
&gt;=C2=A0 =C2=A0 =C2=A0`/usr/lib/liblttng-ust-tracepoint.so.1`; however, i=
n frame 2 the<br>
&gt;=C2=A0 =C2=A0 =C2=A0reference is from<br>
&gt;=C2=A0 =C2=A0 =C2=A0`/opt/poky/4.0.18/sysroots/cortexa53-crypto-poky-li=
nux/usr/include/lttng/tracepoint.h`.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Are the LTTng libraries in `/usr/lib` the exact sam=
e version as the<br>
&gt;=C2=A0 =C2=A0 =C2=A0headers in<br>
&gt;=C2=A0 =C2=A0 =C2=A0`/opt/poky/4.0.18/sysroots/cortexa53-cryptop-poky-l=
inux/usr/include/lttng`?<br>
&gt; <br>
&gt; <br>
&gt; Yes.=C2=A0 The sdk was created by yocto using populate_sdk which inclu=
des the <br>
&gt; target image sysroot in the sdk.=C2=A0 Hopefully I explained that righ=
t. The <br>
&gt; target image drives the contents of the sdk and the generated sdk is <=
br>
&gt; what is used to cross compile the application specifically for the <br=
>
&gt; target we are running on (NXP imx8mm).<br>
<br>
I think that makes sense - the debug information has stored the path of <br=
>
the build environment which is the sysroot portion.<br>
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0If some of your app is compiled using one version o=
f headers and a<br>
&gt;=C2=A0 =C2=A0 =C2=A0different version of the library is loaded at runti=
me, there could<br>
&gt;=C2=A0 =C2=A0 =C2=A0be an<br>
&gt;=C2=A0 =C2=A0 =C2=A0ABI mismatch.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You could check what the include paths are during c=
ompilation and<br>
&gt;=C2=A0 =C2=A0 =C2=A0`LD_LIBRARY_PATH` at runtime. Running with the envi=
ronment variable<br>
&gt;=C2=A0 =C2=A0 =C2=A0`LD_DEBUG=3Dbindings,libs` (see `man ld.so` for mor=
e info).<br>
&gt; <br>
&gt; I&#39;ve been down that road a few times before with the same line of =
<br>
&gt; thinking (ABI issue) and believe I&#39;ve proven I don&#39;t have thos=
e issues.=C2=A0 <br>
&gt; That&#39;s one of the reasons I hand built lttng-ust in native environ=
ment <br>
&gt; (on the actual target) to verify it wasn&#39;t an issue with a yocto r=
ecipe, <br>
&gt; cross compiling etc..<br>
&gt; <br>
&gt; I&#39;ve been thru this process with different OS versions (yocto Dunf=
ell <br>
&gt; before), kernel version, toolchain version etc., and now the same with=
 <br>
&gt; Kirkstone based components.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0In any case, I&#39;ll take a look over the most rec=
ent backtraces and<br>
&gt;=C2=A0 =C2=A0 =C2=A0see if<br>
&gt;=C2=A0 =C2=A0 =C2=A0anything else jumps out.<br>
&gt; <br>
<br>
I don&#39;t see anything more that stands out.<br>
<br>
I&#39;m going to step back a bit to make sure I have correct understanding =
<br>
of your situation.<br>
<br>
Based on your previous statements, it sounded like you weren&#39;t sure if =
<br>
your application is statically linked or not. This is different than <br>
using a statically linked probe provider.<br>
<br>
You can verify by running `ldd /path/to/my_app`. lttng-ust doesn&#39;t <br>
support being statically linked, it is always loaded dynamically. The <br>
trace probe providers (TPPs) may be statically linked, which is different.<=
br>
<br>
You mentioned earlier that the building scenario you were using <br>
resembles the hello world example. To confirm my understanding, do you <br>
mean the hello-static-lib example in lttng-ust/doc/examples? In the <br>
docs, this is called &quot;The instrumented application is statically linke=
d <br>
with the tracepoint provider package archive file&quot;. Note that the fina=
l <br>
application still uses dynamic linking (`-ldl -llttng-ust`, and the <br>
absence of `-static -static-libc` when creating the final executable).<br><=
/blockquote><div><br></div><div><div>I may have not been clear.=C2=A0 Most =
of the application components are=20
statically linked but I think there are some that are built as shared=20
objects (.so&#39;s) so that&#39;s what I was referring to.=C2=A0 I know tha=
t=20
lttng-ust is dynamically linked ... I think the lttng-ust docs say this=20
is only option but also makes reference to the fact static linking was=20
once possible (in some versions of the documentation) but not supported=20
anymore (I probably have the docs memorized by now ha, ha ... I&#39;ve=20
looked at many, many versions of them).</div><div><br></div><div>Just for f=
ull disclosure my ldd looks like:</div><div><br></div><div><span style=3D"f=
ont-family:monospace"><span style=3D"color:rgb(0,0,0);background-color:rgb(=
255,255,255)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-vdso.so.1 (0x0000f=
fffab196000)
</span><br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0libfcgi.so.0 =3D&gt; =
/usr/lib/libfcgi.so.0 (0x0000ffffa57f0000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0liblttng-ust.so.1 =3D&gt; /u=
sr/lib/liblttng-ust.so.1 (0x0000ffffa5750000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0libxml2.so.2 =3D&gt; /usr/li=
b/libxml2.so.2 (0x0000ffffa55d0000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0librt.so.1 =3D&gt; /lib/libr=
t.so.1 (0x0000ffffa55b0000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0libm.so.6 =3D&gt; /lib/libm.=
so.6 (0x0000ffffa5510000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0libstdc++.so.6 =3D&gt; /usr/=
lib/libstdc++.so.6 (0x0000ffffa52f0000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0libgcc_s.so.1 =3D&gt; /lib/l=
ibgcc_s.so.1 (0x0000ffffa52c0000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0libc.so.6 =3D&gt; /lib/libc.=
so.6 (0x0000ffffa5110000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/lib/ld-linux-aarch64.so.1 (=
0x0000ffffab15d000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0liblttng-ust-common.so.1 =3D=
&gt; /usr/local/lib/liblttng-ust-common.so.1 (0x0000ffffa50e0000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0liblttng-ust-tracepoint.so.1=
 =3D&gt; /usr/local/lib/liblttng-ust-tracepoint.so.1 (0x0000ffffa50a0000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0libpthread.so.0 =3D&gt; /lib=
/libpthread.so.0 (0x0000ffffa5080000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0libz.so.1 =3D&gt; /lib/libz.=
so.1 (0x0000ffffa5050000)</span></div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
Further along in stepping back:<br>
<br>
=C2=A0 - Does make check for lttng-ust pass in your environment?<br></block=
quote><div><br></div><div><div>So I&#39;m glad you mentioned this.=C2=A0 I =
didn&#39;t try to run make check=20
because #1 have never seen anything in the documentation about it and=20
what it does and #2 It said that it depended on Perl and since this is=20
an embedded system, I really didn&#39;t want to pull it and its dependencie=
s
 in.</div><div><br></div><div>Nevertheless, I ran it on my native target
 build I setup to see what would happen.=C2=A0 I didn&#39;t notice it compl=
aining
 about perl so then I checked my manifest and perl is in fact in our=20
image (I guess some other recipe pulled it in and I never paid attention
 to that):</div><div><br></div><div><span style=3D"font-family:monospace"><=
span style=3D"color:rgb(0,0,0);background-color:rgb(255,255,255)">Making ch=
eck in include
</span><br>make[1]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-us=
t-2.13.8/include&#39;
<br>make[1]: Nothing to be done for &#39;check&#39;.
<br>make[1]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/include&#39;
<br>Making check in src
<br>make[1]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src&#39;
<br>Making check in common
<br>make[2]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/common&#39;
<br>make[2]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/common&#39;
<br>Making check in lib
<br>make[2]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/lib&#39;
<br>Making check in lttng-ust-common
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/lib/lttng-ust-common&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/lib/lttng-ust-common&#39;
<br>Making check in lttng-ust-tracepoint
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/lib/lttng-ust-tracepoint&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/lib/lttng-ust-tracepoint&#39;
<br>Making check in lttng-ust
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/lib/lttng-ust&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/lib/lttng-ust&#39;
<br>Making check in lttng-ust-ctl
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/lib/lttng-ust-ctl&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/lib/lttng-ust-ctl&#39;
<br>Making check in lttng-ust-fd
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/lib/lttng-ust-fd&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/lib/lttng-ust-fd&#39;
<br>Making check in lttng-ust-fork
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/lib/lttng-ust-fork&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/lib/lttng-ust-fork&#39;
<br>Making check in lttng-ust-cyg-profile
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/lib/lttng-ust-cyg-profile&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/lib/lttng-ust-cyg-profile&#39;
<br>Making check in lttng-ust-libc-wrapper
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/lib/lttng-ust-libc-wrapper&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/lib/lttng-ust-libc-wrapper&#39;
<br>Making check in lttng-ust-pthread-wrapper
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/lib/lttng-ust-pthread-wrapper&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/lib/lttng-ust-pthread-wrapper&#39;
<br>Making check in lttng-ust-dl
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/lib/lttng-ust-dl&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/lib/lttng-ust-dl&#39;
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src/lib&#39;
<br>make[3]: Nothing to be done for &#39;check-am&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/lib&#39;
<br>make[2]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src/lib&#39;
<br>make[2]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/src&#39;
<br>make[2]: Nothing to be done for &#39;check-am&#39;.
<br>make[2]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src&#39;
<br>make[1]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/src&#39;
<br>Making check in tools
<br>make[1]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tools&#39;
<br>make[1]: Nothing to be done for &#39;check&#39;.
<br>make[1]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tools&#39;
<br>Making check in doc
<br>make[1]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/doc&#39;
<br>Making check in .
<br>make[2]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/doc&#39;
<br>make[2]: Nothing to be done for &#39;check-am&#39;.
<br>make[2]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/doc&#39;
<br>Making check in man
<br>make[2]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/doc/man&#39;
<br>make[2]: Nothing to be done for &#39;check&#39;.
<br>make[2]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/doc/man&#39;
<br>Making check in examples
<br>make[2]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/doc/examples&#39;
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/doc/examples/easy-ust&#39;
<br>make[3]: Nothing to be done for &#39;all&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/doc/examples/easy-ust&#39;
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/doc/examples/demo&#39;
<br>make[3]: Nothing to be done for &#39;all&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/doc/examples/demo&#39;
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/doc/examples/hello-static-lib&#39;
<br>make[3]: Nothing to be done for &#39;all&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/doc/examples/hello-static-lib&#39;
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/doc/examples/demo-tracef&#39;
<br>make[3]: Nothing to be done for &#39;all&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/doc/examples/demo-tracef&#39;
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/doc/examples/clock-override&#39;
<br>make[3]: Nothing to be done for &#39;all&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/doc/examples/clock-override&#39;
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/doc/examples/getcpu-override&#39;
<br>make[3]: Nothing to be done for &#39;all&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/doc/examples/getcpu-override&#39;
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/doc/examples/demo-tracelog&#39;
<br>make[3]: Nothing to be done for &#39;all&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/doc/examples/demo-tracelog&#39;
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/doc/examples/gen-tp&#39;
<br>make[3]: Nothing to be done for &#39;all&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/doc/examples/gen-tp&#39;
<br>make[2]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/doc/examples&#39;
<br>make[1]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/doc&#39;
<br>Making check in tests
<br>make[1]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests&#39;
<br>Making check in utils
<br>make[2]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/utils&#39;
<br>make =C2=A0tap-driver.sh tap.sh utils.sh
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/utils&#39;
<br>make[3]: Nothing to be done for &#39;tap-driver.sh&#39;.
<br>make[3]: Nothing to be done for &#39;tap.sh&#39;.
<br>make[3]: Nothing to be done for &#39;utils.sh&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/utils&#39;
<br>make[2]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/utils&#39;
<br>Making check in unit
<br>make[2]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/unit&#39;
<br>Making check in gcc-weak-hidden
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/unit/gcc-weak-hidden&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/unit/gcc-weak-hidden&#39;
<br>Making check in libcommon
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/unit/libcommon&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/unit/libcommon&#39;
<br>Making check in libmsgpack
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/unit/libmsgpack&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/unit/libmsgpack&#39;
<br>Making check in libringbuffer
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/unit/libringbuffer&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/unit/libringbuffer&#39;
<br>Making check in pthread_name
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/unit/pthread_name&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/unit/pthread_name&#39;
<br>Making check in snprintf
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/unit/snprintf&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/unit/snprintf&#39;
<br>Making check in ust-elf
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/unit/ust-elf&#39;
<br>make =C2=A0test_ust_elf
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/unit/ust-elf&#39;
<br>make[4]: Nothing to be done for &#39;test_ust_elf&#39;.
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/unit/ust-elf&#39;
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/unit/ust-elf&#39;
<br>Making check in ust-error
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/unit/ust-error&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/unit/ust-error&#39;
<br>Making check in ust-utils
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/unit/ust-utils&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/unit/ust-utils&#39;
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/unit&#39;
<br>make[3]: Nothing to be done for &#39;check-am&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/unit&#39;
<br>make[2]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/unit&#39;
<br>Making check in compile
<br>make[2]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile&#39;
<br>Making check in api0
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api0&#39;
<br>Making check in ctf-types
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api0/ctf-types&#39;
<br>make[4]: Nothing to be done for &#39;check&#39;.
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api0/ctf-types&#39;
<br>Making check in hello
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api0/hello&#39;
<br>make[4]: Nothing to be done for &#39;check&#39;.
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api0/hello&#39;
<br>Making check in hello-many
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api0/hello-many&#39;
<br>make[4]: Nothing to be done for &#39;check&#39;.
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api0/hello-many&#39;
<br>Making check in same_line_tracepoint
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api0/same_line_tracepoint&#39;
<br>make[4]: Nothing to be done for &#39;check&#39;.
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api0/same_line_tracepoint&#39;
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api0&#39;
<br>make[4]: Nothing to be done for &#39;check-am&#39;.
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api0&#39;
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api0&#39;
<br>Making check in api1
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api1&#39;
<br>Making check in ust-fields
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api1/ust-fields&#39;
<br>make[4]: Nothing to be done for &#39;check&#39;.
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api1/ust-fields&#39;
<br>Making check in hello
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api1/hello&#39;
<br>make[4]: Nothing to be done for &#39;check&#39;.
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api1/hello&#39;
<br>Making check in hello-many
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api1/hello-many&#39;
<br>make[4]: Nothing to be done for &#39;check&#39;.
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api1/hello-many&#39;
<br>Making check in same_line_tracepoint
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api1/same_line_tracepoint&#39;
<br>make[4]: Nothing to be done for &#39;check&#39;.
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api1/same_line_tracepoint&#39;
<br>Making check in test-app-ctx
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api1/test-app-ctx&#39;
<br>make[4]: Nothing to be done for &#39;check&#39;.
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api1/test-app-ctx&#39;
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile/api1&#39;
<br>make[4]: Nothing to be done for &#39;check-am&#39;.
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api1&#39;
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile/api1&#39;
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/compile&#39;
<br>make[3]: Nothing to be done for &#39;check-am&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile&#39;
<br>make[2]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/compile&#39;
<br>Making check in benchmark
<br>make[2]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/benchmark&#39;
<br>make[2]: Nothing to be done for &#39;check&#39;.
<br>make[2]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/benchmark&#39;
<br>Making check in regression
<br>make[2]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/regression&#39;
<br>Making check in abi0-conflict
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/regression/abi0-conflict&#39;
<br>make[3]: Nothing to be done for &#39;check&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/regression/abi0-conflict&#39;
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests/regression&#39;
<br>make[3]: Nothing to be done for &#39;check-am&#39;.
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/regression&#39;
<br>make[2]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests/regression&#39;
<br>make[2]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests&#39;
<br>make =C2=A0check-TESTS
<br>make[3]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests&#39;
<br>make[4]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/tests&#39;
<br>PASS: unit/libringbuffer/test_shm 1 - Open a POSIX shm fd
<br>PASS: unit/libringbuffer/test_shm 2 - Create a shm object table
<br>PASS: unit/libringbuffer/test_shm 3 - Allocate the shm object table
<br>PASS: unit/libringbuffer/test_shm 4 - Allocate an object in the shm wit=
h sufficient space
<br>PASS: unit/libringbuffer/test_shm 5 - Allocate an object in the shm wit=
h insufficient space
<br># unit/gcc-weak-hidden/test_gcc_weak_hidden: Address of weak=20
symbol with hidden visibility match between compile units within same=20
module for main program (4 bytes integer object)
<br># unit/gcc-weak-hidden/test_gcc_weak_hidden: Address of weak=20
symbol with hidden visibility match between compile units within same=20
module for main program (pointer object)
<br># unit/gcc-weak-hidden/test_gcc_weak_hidden: Address of weak=20
symbol with hidden visibility match between compile units within same=20
module for main program (24 bytes structure object)
<br># unit/gcc-weak-hidden/test_gcc_weak_hidden: Address of weak=20
symbol with hidden visibility match between compile units within same=20
module for shared library (4 bytes integer object)
<br># unit/gcc-weak-hidden/test_gcc_weak_hidden: Address of weak=20
symbol with hidden visibility match between compile units within same=20
module for shared library (pointer object)
<br># unit/gcc-weak-hidden/test_gcc_weak_hidden: Address of weak=20
symbol with hidden visibility match between compile units within same=20
module for shared library (24 bytes structure object)
<br>PASS: unit/gcc-weak-hidden/test_gcc_weak_hidden 1 - Weak-hidden behavio=
r is the same for 4 bytes integer and pointer objects within main program
<br>PASS: unit/gcc-weak-hidden/test_gcc_weak_hidden 2 - Weak-hidden behavio=
r is the same for 4 bytes integer and pointer objects within shared library
<br>PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 1 - test_get_cpu_mask=
_from_sysfs - without &#39;\n&#39; expected: &#39;&#39;, result: &#39;&#39;
<br>PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 2 - test_get_cpu_mask=
_from_sysfs - with &#39;\n&#39; expected: &#39;&#39;, result: &#39;&#39;
<br>PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 3 - test_get_cpu_mask=
_from_sysfs - without &#39;\n&#39; expected: &#39;0&#39;, result: &#39;0&#3=
9;
<br>PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 4 - test_get_cpu_mask=
_from_sysfs - with &#39;\n&#39; expected: &#39;0&#39;, result: &#39;0&#39;
<br>PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 5 - test_get_cpu_mask=
_from_sysfs - without &#39;\n&#39; expected: &#39;0-3&#39;, result: &#39;0-=
3&#39;
<br>PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 6 - test_get_cpu_mask=
_from_sysfs - with &#39;\n&#39; expected: &#39;0-3&#39;, result: &#39;0-3&#=
39;
<br>PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 7 - test_get_cpu_mask=
_from_sysfs - without &#39;\n&#39; expected: &#39;0,3-7,9&#39;, result: &#3=
9;0,3-7,9&#39;
<br>PASS: unit/libcommon/test_get_cpu_mask_from_sysfs 8 - test_get_cpu_mask=
_from_sysfs - with &#39;\n&#39; expected: &#39;0,3-7,9&#39;, result: &#39;0=
,3-7,9&#39;
<br># unit/libcommon/test_get_max_cpuid_from_mask: Testing smp helpers
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 1 - get_max_cpuid_fro=
m_mask &#39;&#39;, expected: &#39;-1&#39;, result: &#39;-1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 2 - get_max_cpuid_fro=
m_mask &#39;abc&#39;, expected: &#39;-1&#39;, result: &#39;-1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 3 - get_max_cpuid_fro=
m_mask &#39;,,,&#39;, expected: &#39;-1&#39;, result: &#39;-1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 4 - get_max_cpuid_fro=
m_mask &#39;--&#39;, expected: &#39;-1&#39;, result: &#39;-1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 5 - get_max_cpuid_fro=
m_mask &#39;,&#39;, expected: &#39;-1&#39;, result: &#39;-1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 6 - get_max_cpuid_fro=
m_mask &#39;-&#39;, expected: &#39;-1&#39;, result: &#39;-1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 7 - get_max_cpuid_fro=
m_mask &#39;2147483647&#39;, expected: &#39;-1&#39;, result: &#39;-1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 8 - get_max_cpuid_fro=
m_mask &#39;18446744073709551615&#39;, expected: &#39;-1&#39;, result: &#39=
;-1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 9 - get_max_cpuid_fro=
m_mask &#39;0-2147483647&#39;, expected: &#39;-1&#39;, result: &#39;-1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 10 - get_max_cpuid_fr=
om_mask &#39;0-18446744073709551615&#39;, expected: &#39;-1&#39;, result: &=
#39;-1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 11 - get_max_cpuid_fr=
om_mask &#39;0&#39;, expected: &#39;0&#39;, result: &#39;0&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 12 - get_max_cpuid_fr=
om_mask &#39;1&#39;, expected: &#39;1&#39;, result: &#39;1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 13 - get_max_cpuid_fr=
om_mask &#39;0-1&#39;, expected: &#39;1&#39;, result: &#39;1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 14 - get_max_cpuid_fr=
om_mask &#39;1-3&#39;, expected: &#39;3&#39;, result: &#39;3&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 15 - get_max_cpuid_fr=
om_mask &#39;0,2&#39;, expected: &#39;2&#39;, result: &#39;2&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 16 - get_max_cpuid_fr=
om_mask &#39;1,2&#39;, expected: &#39;2&#39;, result: &#39;2&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 17 - get_max_cpuid_fr=
om_mask &#39;0,4-6,127&#39;, expected: &#39;127&#39;, result: &#39;127&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 18 - get_max_cpuid_fr=
om_mask &#39;0-4095&#39;, expected: &#39;4095&#39;, result: &#39;4095&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 19 - get_max_cpuid_fr=
om_mask &#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 20 - get_max_cpuid_fr=
om_mask &#39;abc
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 21 - get_max_cpuid_fr=
om_mask &#39;,,,
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 22 - get_max_cpuid_fr=
om_mask &#39;--
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 23 - get_max_cpuid_fr=
om_mask &#39;,
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 24 - get_max_cpuid_fr=
om_mask &#39;-
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 25 - get_max_cpuid_fr=
om_mask &#39;2147483647
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 26 - get_max_cpuid_fr=
om_mask &#39;18446744073709551615
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 27 - get_max_cpuid_fr=
om_mask &#39;0-2147483647
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 28 - get_max_cpuid_fr=
om_mask &#39;0-18446744073709551615
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 29 - get_max_cpuid_fr=
om_mask &#39;0
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 30 - get_max_cpuid_fr=
om_mask &#39;1
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 31 - get_max_cpuid_fr=
om_mask &#39;0-1
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 32 - get_max_cpuid_fr=
om_mask &#39;1-3
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 33 - get_max_cpuid_fr=
om_mask &#39;0,2
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 34 - get_max_cpuid_fr=
om_mask &#39;1,2
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 35 - get_max_cpuid_fr=
om_mask &#39;0,4-6,127
<br>PASS: unit/libcommon/test_get_max_cpuid_from_mask 36 - get_max_cpuid_fr=
om_mask &#39;0-4095
<br># unit/libcommon/test_get_max_cpuid_from_sysfs: get_max_cpuid_from_sysf=
s
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 1 - get_max_cpuid_fr=
om_sysfs - cpu set: &#39;cpu0&#39;, expected: &#39;0&#39;, result: &#39;0&#=
39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 2 - get_max_cpuid_fr=
om_sysfs - cpu set: &#39;cpu0 cpu1&#39;, expected: &#39;1&#39;, result: &#3=
9;1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 3 - get_max_cpuid_fr=
om_sysfs - cpu set: &#39;cpu1 cpu0&#39;, expected: &#39;1&#39;, result: &#3=
9;1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 4 - get_max_cpuid_fr=
om_sysfs - cpu set: &#39;cpu3&#39;, expected: &#39;3&#39;, result: &#39;3&#=
39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 5 - get_max_cpuid_fr=
om_sysfs - cpu set: &#39;cpu99&#39;, expected: &#39;99&#39;, result: &#39;9=
9&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 6 - get_max_cpuid_fr=
om_sysfs - cpu set: &#39;cpu0 cpu3&#39;, expected: &#39;3&#39;, result: &#3=
9;3&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 7 - get_max_cpuid_fr=
om_sysfs - cpu set: &#39;cpufreq cpuidle cpu0 cpu1 cpu2 cpu3&#39;, expected=
: &#39;3&#39;, result: &#39;3&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 8 - get_max_cpuid_fr=
om_sysfs - cpu set: &#39;cpu cpu0&#39;, expected: &#39;0&#39;, result: &#39=
;0&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 9 - get_max_cpuid_fr=
om_sysfs - cpu set: &#39;cpu cpu5&#39;, expected: &#39;5&#39;, result: &#39=
;5&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 10 - get_max_cpuid_f=
rom_sysfs - cpu set: &#39;toto&#39;, expected: &#39;-1&#39;, result: &#39;-=
1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 11 - get_max_cpuid_f=
rom_sysfs - cpu set: &#39;cpu&#39;, expected: &#39;-1&#39;, result: &#39;-1=
&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 12 - get_max_cpuid_f=
rom_sysfs - cpu set: &#39;cpua cpud&#39;, expected: &#39;-1&#39;, result: &=
#39;-1&#39;
<br>PASS: unit/libcommon/test_get_max_cpuid_from_sysfs 13 - get_max_cpuid_f=
rom_sysfs - cpu set: &#39;cpufreq cpuidle&#39;, expected: &#39;-1&#39;, res=
ult: &#39;-1&#39;
<br>PASS: unit/libcommon/test_get_possible_cpus_array_len 1 - get_possible_=
cpus_array_len (4 &gt; 0)
<br>PASS: unit/libcommon/test_get_possible_cpus_array_len 2 - get_num_possi=
ble_cpus_fallback (4 &gt; 0)
<br># unit/libmsgpack/test_msgpack: Testing msgpack implementation
<br>PASS: unit/libmsgpack/test_msgpack 1 - NIL object
<br>PASS: unit/libmsgpack/test_msgpack 2 - String &quot;bye&quot; object
<br>PASS: unit/libmsgpack/test_msgpack 3 - Unsigned integer &quot;1337&quot=
; object
<br>PASS: unit/libmsgpack/test_msgpack 4 - Unsigned integer &quot;127&quot;=
 object
<br>PASS: unit/libmsgpack/test_msgpack 5 - Unsigned integer &quot;128&quot;=
 object
<br>PASS: unit/libmsgpack/test_msgpack 6 - Unsigned integer &quot;256&quot;=
 object
<br>PASS: unit/libmsgpack/test_msgpack 7 - Unsigned integer &quot;65536&quo=
t; object
<br>PASS: unit/libmsgpack/test_msgpack 8 - Unsigned integer &quot;65535&quo=
t; object
<br>PASS: unit/libmsgpack/test_msgpack 9 - Unsigned integer &quot;429496729=
5&quot; object
<br>PASS: unit/libmsgpack/test_msgpack 10 - Unsigned integer &quot;42949672=
96&quot; object
<br>PASS: unit/libmsgpack/test_msgpack 11 - Signed integer &quot;-32&quot; =
object
<br>PASS: unit/libmsgpack/test_msgpack 12 - Signed integer &quot;-33&quot; =
object
<br>PASS: unit/libmsgpack/test_msgpack 13 - Signed integer &quot;-129&quot;=
 object
<br>PASS: unit/libmsgpack/test_msgpack 14 - Signed integer &quot;-32768&quo=
t; object
<br>PASS: unit/libmsgpack/test_msgpack 15 - Signed integer &quot;-32769&quo=
t; object
<br>PASS: unit/libmsgpack/test_msgpack 16 - Signed integer &quot;-214748364=
8&quot; object
<br>PASS: unit/libmsgpack/test_msgpack 17 - Signed integer &quot;-214748364=
9&quot; object
<br>PASS: unit/libmsgpack/test_msgpack 18 - double &quot;0.0&quot; object
<br>PASS: unit/libmsgpack/test_msgpack 19 - double &quot;PI&quot; object
<br>PASS: unit/libmsgpack/test_msgpack 20 - double &quot;-PI&quot; object
<br>PASS: unit/libmsgpack/test_msgpack 21 - Array of double object
<br>PASS: unit/libmsgpack/test_msgpack 22 - Map object
<br>PASS: unit/libmsgpack/test_msgpack 23 - Complete capture object
<br>PASS: unit/pthread_name/test_pthread_name 1 - Get the thread name: &#39=
;test_pthread_na&#39;
<br>PASS: unit/pthread_name/test_pthread_name 2 - Set a too long thread nam=
e: &#39;thisnameistoolong&#39;
<br>PASS: unit/pthread_name/test_pthread_name 3 - Get the thread name: &#39=
;test_pthread_na&#39;
<br>PASS: unit/pthread_name/test_pthread_name 4 - Compare the initial threa=
d name: &#39;test_pthread_na&#39; =3D=3D &#39;test_pthread_na&#39;
<br>PASS: unit/pthread_name/test_pthread_name 5 - Set a short thread name: =
&#39;labatt50&#39;
<br>PASS: unit/pthread_name/test_pthread_name 6 - Get a short thread name: =
&#39;labatt50&#39;
<br>PASS: unit/pthread_name/test_pthread_name 7 - Compare the short thread =
name: &#39;labatt50&#39; =3D=3D &#39;labatt50&#39;
<br>PASS: unit/pthread_name/test_pthread_name 8 - Compare the short UST thr=
ead name: &#39;labatt50-ust&#39; =3D=3D &#39;labatt50-ust&#39;
<br>PASS: unit/pthread_name/test_pthread_name 9 - Set a long thread name: &=
#39;procrastinating&#39;
<br>PASS: unit/pthread_name/test_pthread_name 10 - Get a long thread name: =
&#39;procrastinating&#39;
<br>PASS: unit/pthread_name/test_pthread_name 11 - Compare the long thread =
name: &#39;procrastinating&#39; =3D=3D &#39;procrastinating&#39;
<br>PASS: unit/pthread_name/test_pthread_name 12 - Compare the long UST thr=
ead name: &#39;procrastina-ust&#39; =3D=3D &#39;procrastina-ust&#39;
<br>PASS: unit/snprintf/test_snprintf 1 - Got expected output string with f=
ormat string &quot;header %d, %s, %03d, &#39;%*d&#39;&quot;
<br>PASS: unit/ust-elf/test_ust_elf 1 - Invoke as: /home/iadmin/lttng-ust/l=
ttng-ust-2.13.8/tests/unit/ust-elf/.libs/lt-ust-elf &lt;path&gt;
<br># unit/ust-elf/test_ust_elf: Testing x86 support
<br>PASS: unit/ust-elf/test_ust_elf 2 - lttng_ust_elf_create
<br>PASS: unit/ust-elf/test_ust_elf 3 - lttng_ust_elf_get_memsz returned su=
ccessfully
<br>PASS: unit/ust-elf/test_ust_elf 4 - memsz - expected: 5732, got: 5732
<br>PASS: unit/ust-elf/test_ust_elf 5 - lttng_ust_elf_get_build_id returned=
 successfully
<br>PASS: unit/ust-elf/test_ust_elf 6 - build id marked as found
<br>PASS: unit/ust-elf/test_ust_elf 7 - build_id_len - expected: 20, got: 2=
0
<br>PASS: unit/ust-elf/test_ust_elf 8 - build_id has expected value
<br>PASS: unit/ust-elf/test_ust_elf 9 - lttng_ust_elf_get_debug_link return=
ed successfully
<br>PASS: unit/ust-elf/test_ust_elf 10 - debug link marked as found
<br>PASS: unit/ust-elf/test_ust_elf 11 - debug link filename - expected: ma=
in.elf.debug, got: main.elf.debug
<br>PASS: unit/ust-elf/test_ust_elf 12 - debug link crc - expected: 0x1531f=
73c, got: 0x1531f73c
<br># unit/ust-elf/test_ust_elf: Testing x86_64 support
<br>PASS: unit/ust-elf/test_ust_elf 13 - lttng_ust_elf_create
<br>PASS: unit/ust-elf/test_ust_elf 14 - lttng_ust_elf_get_memsz returned s=
uccessfully
<br>PASS: unit/ust-elf/test_ust_elf 15 - memsz - expected: 2099376, got: 20=
99376
<br>PASS: unit/ust-elf/test_ust_elf 16 - lttng_ust_elf_get_build_id returne=
d successfully
<br>PASS: unit/ust-elf/test_ust_elf 17 - build id marked as found
<br>PASS: unit/ust-elf/test_ust_elf 18 - build_id_len - expected: 20, got: =
20
<br>PASS: unit/ust-elf/test_ust_elf 19 - build_id has expected value
<br>PASS: unit/ust-elf/test_ust_elf 20 - lttng_ust_elf_get_debug_link retur=
ned successfully
<br>PASS: unit/ust-elf/test_ust_elf 21 - debug link marked as found
<br>PASS: unit/ust-elf/test_ust_elf 22 - debug link filename - expected: ma=
in.elf.debug, got: main.elf.debug
<br>PASS: unit/ust-elf/test_ust_elf 23 - debug link crc - expected: 0xa048a=
98f, got: 0xa048a98f
<br># unit/ust-elf/test_ust_elf: Testing armeb support
<br>PASS: unit/ust-elf/test_ust_elf 24 - lttng_ust_elf_create
<br>PASS: unit/ust-elf/test_ust_elf 25 - lttng_ust_elf_get_memsz returned s=
uccessfully
<br>PASS: unit/ust-elf/test_ust_elf 26 - memsz - expected: 34196, got: 3419=
6
<br>PASS: unit/ust-elf/test_ust_elf 27 - lttng_ust_elf_get_build_id returne=
d successfully
<br>PASS: unit/ust-elf/test_ust_elf 28 - build id marked as found
<br>PASS: unit/ust-elf/test_ust_elf 29 - build_id_len - expected: 20, got: =
20
<br>PASS: unit/ust-elf/test_ust_elf 30 - build_id has expected value
<br>PASS: unit/ust-elf/test_ust_elf 31 - lttng_ust_elf_get_debug_link retur=
ned successfully
<br>PASS: unit/ust-elf/test_ust_elf 32 - debug link marked as found
<br>PASS: unit/ust-elf/test_ust_elf 33 - debug link filename - expected: ma=
in.elf.debug, got: main.elf.debug
<br>PASS: unit/ust-elf/test_ust_elf 34 - debug link crc - expected: 0x9d402=
61b, got: 0x9d40261b
<br># unit/ust-elf/test_ust_elf: Testing aarch64_be support
<br>PASS: unit/ust-elf/test_ust_elf 35 - lttng_ust_elf_create
<br>PASS: unit/ust-elf/test_ust_elf 36 - lttng_ust_elf_get_memsz returned s=
uccessfully
<br>PASS: unit/ust-elf/test_ust_elf 37 - memsz - expected: 67632, got: 6763=
2
<br>PASS: unit/ust-elf/test_ust_elf 38 - lttng_ust_elf_get_build_id returne=
d successfully
<br>PASS: unit/ust-elf/test_ust_elf 39 - build id marked as found
<br>PASS: unit/ust-elf/test_ust_elf 40 - build_id_len - expected: 20, got: =
20
<br>PASS: unit/ust-elf/test_ust_elf 41 - build_id has expected value
<br>PASS: unit/ust-elf/test_ust_elf 42 - lttng_ust_elf_get_debug_link retur=
ned successfully
<br>PASS: unit/ust-elf/test_ust_elf 43 - debug link marked as found
<br>PASS: unit/ust-elf/test_ust_elf 44 - debug link filename - expected: ma=
in.elf.debug, got: main.elf.debug
<br>PASS: unit/ust-elf/test_ust_elf 45 - debug link crc - expected: 0x2b8ce=
dce, got: 0x2b8cedce
<br>PASS: unit/ust-elf/test_ust_elf 46 - hello.exec is not PIC
<br>PASS: unit/ust-elf/test_ust_elf 47 - hello.pie is PIC
<br>PASS: unit/ust-elf/test_ust_elf 48 - hello.pic is PIC
<br>PASS: unit/ust-error/test_ust_error 1 - lttng_ust_strerror - Positive L=
TTNG_UST_OK returns &#39;Success&#39; (Success)
<br>PASS: unit/ust-error/test_ust_error 2 - lttng_ust_strerror - Negative L=
TTNG_UST_OK returns &#39;Success&#39; (Success)
<br>PASS: unit/ust-error/test_ust_error 3 - lttng_ust_strerror - Positive l=
arge int returns &#39;Unknown error&#39; (Unknown error)
<br>PASS: unit/ust-error/test_ust_error 4 - lttng_ust_strerror - Negative l=
arge int returns &#39;Unknown error&#39; (Unknown error)
<br>PASS: unit/ust-error/test_ust_error 5 - lttng_ust_strerror - Positive L=
TTNG_UST_ERR_NR returns &#39;Unknown error&#39; (Unknown error)
<br>PASS: unit/ust-error/test_ust_error 6 - lttng_ust_strerror - Negative L=
TTNG_UST_ERR_NR returns &#39;Unknown error&#39; (Unknown error)
<br>PASS: unit/ust-error/test_ust_error 7 - lttng_ust_strerror -=20
Positive LTTNG_UST_ERR_NR + 1 returns &#39;Unknown error&#39; (Unknown erro=
r)
<br>PASS: unit/ust-error/test_ust_error 8 - lttng_ust_strerror -=20
Negative LTTNG_UST_ERR_NR - 1 returns &#39;Unknown error&#39; (Unknown erro=
r)
<br>PASS: unit/ust-error/test_ust_error 9 - lttng_ust_strerror -=20
Positive LTTNG_UST_ERR_NOENT returns &#39;Unknown error&#39; (Unknown error=
)
<br>PASS: unit/ust-error/test_ust_error 10 - lttng_ust_strerror - Negative =
LTTNG_UST_ERR_NOENT returns &#39;No entry&#39; (No entry)
<br>PASS: unit/ust-error/test_ust_error 11 - lttng_ust_strerror -=20
Positive LTTNG_UST_ERR_PEERCRED_PID returns &#39;Unknown error&#39; (Unknow=
n=20
error)
<br>PASS: unit/ust-error/test_ust_error 12 - lttng_ust_strerror -=20
Negative LTTNG_UST_ERR_PEERCRED_PID returns &#39;Peer credentials PID is=20
invalid. Socket appears to belong to a distinct, non-nested pid=20
namespace.&#39; (Peer credentials PID is invalid. Socket appears to belong=
=20
to a disti)
<br>PASS: unit/ust-utils/test_ust_utils 1 - lttng_ust_stringify - literal i=
nteger
<br>PASS: unit/ust-utils/test_ust_utils 2 - lttng_ust_stringify - identifie=
r
<br>PASS: unit/ust-utils/test_ust_utils 3 - lttng_ust_is_signed_type - &#39=
;signed char&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 4 - lttng_ust_is_signed_type - &#39=
;short&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 5 - lttng_ust_is_signed_type - &#39=
;int&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 6 - lttng_ust_is_signed_type - &#39=
;long&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 7 - lttng_ust_is_signed_type - &#39=
;long long&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 8 - lttng_ust_is_signed_type - &#39=
;float&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 9 - lttng_ust_is_signed_type - &#39=
;double&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 10 - lttng_ust_is_signed_type - &#3=
9;long double&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 11 - lttng_ust_is_signed_type - &#3=
9;int8_t&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 12 - lttng_ust_is_signed_type - &#3=
9;int16_t&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 13 - lttng_ust_is_signed_type - &#3=
9;int32_t&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 14 - lttng_ust_is_signed_type - &#3=
9;int64_t&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 15 - lttng_ust_is_signed_type - &#3=
9;intmax_t&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 16 - lttng_ust_is_signed_type - &#3=
9;ssize_t&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 17 - lttng_ust_is_signed_type - &#3=
9;ptrdiff_t&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 18 - lttng_ust_is_signed_type - &#3=
9;intptr_t&#39; is signed
<br>PASS: unit/ust-utils/test_ust_utils 19 - lttng_ust_is_signed_type - &#3=
9;unsigned char&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 20 - lttng_ust_is_signed_type - &#3=
9;unsigned short&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 21 - lttng_ust_is_signed_type - &#3=
9;unsigned int&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 22 - lttng_ust_is_signed_type - &#3=
9;unsigned long&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 23 - lttng_ust_is_signed_type - &#3=
9;unsigned long long&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 24 - lttng_ust_is_signed_type - &#3=
9;uint8_t&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 25 - lttng_ust_is_signed_type - &#3=
9;uint16_t&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 26 - lttng_ust_is_signed_type - &#3=
9;uint32_t&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 27 - lttng_ust_is_signed_type - &#3=
9;uint64_t&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 28 - lttng_ust_is_signed_type - &#3=
9;uintmax_t&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 29 - lttng_ust_is_signed_type - &#3=
9;_Bool&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 30 - lttng_ust_is_signed_type - &#3=
9;size_t&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 31 - lttng_ust_is_signed_type - &#3=
9;void *&#39; is unsigned
<br>PASS: unit/ust-utils/test_ust_utils 32 - lttng_ust_is_integer_type - &#=
39;char&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 33 - lttng_ust_is_integer_type - &#=
39;short&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 34 - lttng_ust_is_integer_type - &#=
39;int&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 35 - lttng_ust_is_integer_type - &#=
39;long&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 36 - lttng_ust_is_integer_type - &#=
39;long long&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 37 - lttng_ust_is_integer_type - &#=
39;signed char&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 38 - lttng_ust_is_integer_type - &#=
39;signed short&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 39 - lttng_ust_is_integer_type - &#=
39;signed int&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 40 - lttng_ust_is_integer_type - &#=
39;signed long&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 41 - lttng_ust_is_integer_type - &#=
39;signed long long&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 42 - lttng_ust_is_integer_type - &#=
39;unsigned char&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 43 - lttng_ust_is_integer_type - &#=
39;unsigned short&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 44 - lttng_ust_is_integer_type - &#=
39;unsigned int&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 45 - lttng_ust_is_integer_type - &#=
39;unsigned long&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 46 - lttng_ust_is_integer_type - &#=
39;unsigned long long&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 47 - lttng_ust_is_integer_type - &#=
39;int8_t&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 48 - lttng_ust_is_integer_type - &#=
39;int16_t&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 49 - lttng_ust_is_integer_type - &#=
39;int32_t&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 50 - lttng_ust_is_integer_type - &#=
39;int64_t&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 51 - lttng_ust_is_integer_type - &#=
39;intmax_t&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 52 - lttng_ust_is_integer_type - &#=
39;uint8_t&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 53 - lttng_ust_is_integer_type - &#=
39;uint16_t&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 54 - lttng_ust_is_integer_type - &#=
39;uint32_t&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 55 - lttng_ust_is_integer_type - &#=
39;uint64_t&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 56 - lttng_ust_is_integer_type - &#=
39;uintmax_t&#39; is an integer
<br>PASS: unit/ust-utils/test_ust_utils 57 - lttng_ust_is_integer_type - &#=
39;float&#39; is not an integer
<br>PASS: unit/ust-utils/test_ust_utils 58 - lttng_ust_is_integer_type - &#=
39;double&#39; is not an integer
<br>PASS: unit/ust-utils/test_ust_utils 59 - lttng_ust_is_integer_type - &#=
39;long double&#39; is not an integer
<br>PASS: unit/ust-utils/test_ust_utils 60 - lttng_ust_is_integer_type - &#=
39;void *&#39; is not an integer
<br>PASS: unit/ust-utils/test_ust_utils 61 - lttng_ust_is_pointer_type - &#=
39;char&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 62 - lttng_ust_is_pointer_type - &#=
39;short&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 63 - lttng_ust_is_pointer_type - &#=
39;int&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 64 - lttng_ust_is_pointer_type - &#=
39;long&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 65 - lttng_ust_is_pointer_type - &#=
39;long long&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 66 - lttng_ust_is_pointer_type - &#=
39;signed char&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 67 - lttng_ust_is_pointer_type - &#=
39;signed short&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 68 - lttng_ust_is_pointer_type - &#=
39;signed int&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 69 - lttng_ust_is_pointer_type - &#=
39;signed long&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 70 - lttng_ust_is_pointer_type - &#=
39;signed long long&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 71 - lttng_ust_is_pointer_type - &#=
39;unsigned char&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 72 - lttng_ust_is_pointer_type - &#=
39;unsigned short&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 73 - lttng_ust_is_pointer_type - &#=
39;unsigned int&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 74 - lttng_ust_is_pointer_type - &#=
39;unsigned long&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 75 - lttng_ust_is_pointer_type - &#=
39;unsigned long long&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 76 - lttng_ust_is_pointer_type - &#=
39;int8_t&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 77 - lttng_ust_is_pointer_type - &#=
39;int16_t&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 78 - lttng_ust_is_pointer_type - &#=
39;int32_t&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 79 - lttng_ust_is_pointer_type - &#=
39;int64_t&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 80 - lttng_ust_is_pointer_type - &#=
39;intmax_t&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 81 - lttng_ust_is_pointer_type - &#=
39;uint8_t&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 82 - lttng_ust_is_pointer_type - &#=
39;uint16_t&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 83 - lttng_ust_is_pointer_type - &#=
39;uint32_t&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 84 - lttng_ust_is_pointer_type - &#=
39;uint64_t&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 85 - lttng_ust_is_pointer_type - &#=
39;uintmax_t&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 86 - lttng_ust_is_pointer_type - &#=
39;float&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 87 - lttng_ust_is_pointer_type - &#=
39;double&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 88 - lttng_ust_is_pointer_type - &#=
39;long double&#39; is not a pointer
<br>PASS: unit/ust-utils/test_ust_utils 89 - lttng_ust_is_pointer_type - &#=
39;void *&#39; is a pointer
<br>PASS: unit/ust-utils/test_ust_utils 90 - lttng_ust_is_pointer_type - &#=
39;void **&#39; is a pointer
<br>PASS: unit/ust-utils/test_ust_utils 91 - lttng_ust_is_pointer_type - &#=
39;struct dummy *&#39; is a pointer
<br>PASS: unit/ust-utils/test_ust_utils 92 - lttng_ust_is_pointer_type - &#=
39;int *&#39; is a pointer
<br>PASS: unit/ust-utils/test_ust_utils 93 - lttng_ust_is_pointer_type - &#=
39;float *&#39; is a pointer
<br>PASS: unit/ust-utils/test_ust_utils 94 - lttng_ust_is_pointer_type - &#=
39;double *&#39; is a pointer
<br># regression/abi0-conflict/test_abi0_conflict: LD_PRELOAD
<br>PASS: regression/abi0-conflict/test_abi0_conflict 1 - LD_PRELOAD: no-us=
t app works
<br>PASS: regression/abi0-conflict/test_abi0_conflict 2 - LD_PRELOAD: no-us=
t app with abi0 preload succeeds
<br>PASS: regression/abi0-conflict/test_abi0_conflict 3 - LD_PRELOAD: no-us=
t app with abi0 and abi1 preload fails
<br>PASS: regression/abi0-conflict/test_abi0_conflict 4 - LD_PRELOAD: no-us=
t app with abi1 and abi0 preload fails
<br>PASS: regression/abi0-conflict/test_abi0_conflict 5 - LD_PRELOAD: ust a=
pp works
<br>PASS: regression/abi0-conflict/test_abi0_conflict 6 - LD_PRELOAD: ust a=
pp with abi0 preload fails
<br>PASS: regression/abi0-conflict/test_abi0_conflict 7 - LD_PRELOAD: ust a=
pp with abi0 and abi1 preload fails
<br>PASS: regression/abi0-conflict/test_abi0_conflict 8 - LD_PRELOAD: ust a=
pp with abi1 and abi0 preload fails
<br># regression/abi0-conflict/test_abi0_conflict: dlopen
<br>PASS: regression/abi0-conflict/test_abi0_conflict 9 - dlopen: no-ust ap=
p works
<br>PASS: regression/abi0-conflict/test_abi0_conflict 10 - dlopen: no-ust a=
pp with abi1 and abi1 succeeds
<br>PASS: regression/abi0-conflict/test_abi0_conflict 11 - dlopen: no-ust a=
pp with abi0 and abi1 fails
<br>PASS: regression/abi0-conflict/test_abi0_conflict 12 - dlopen: no-ust a=
pp with abi1 and abi0 fails
<br>PASS: regression/abi0-conflict/test_abi0_conflict 13 - dlopen: ust app =
works
<br>PASS: regression/abi0-conflict/test_abi0_conflict 14 - dlopen: ust app =
with abi0 fails
<br>PASS: regression/abi0-conflict/test_abi0_conflict 15 - dlopen: ust app =
with abi0 and abi1 fails
<br>PASS: regression/abi0-conflict/test_abi0_conflict 16 - dlopen: ust app =
with abi1 and abi0 fails
<br># regression/abi0-conflict/test_abi0_conflict: Indirect linking
<br>PASS: regression/abi0-conflict/test_abi0_conflict 17 - indirect: no-ust=
 app with abi0 succeeds
<br>PASS: regression/abi0-conflict/test_abi0_conflict 18 - indirect: no-ust=
 app with abi1 succeeds
<br>PASS: regression/abi0-conflict/test_abi0_conflict 19 - indirect: no-ust=
 app with abi0 and abi1 fails
<br>PASS: regression/abi0-conflict/test_abi0_conflict 20 - indirect: ust ap=
p with abi0 fails
<br>PASS: regression/abi0-conflict/test_abi0_conflict 21 - indirect: ust ap=
p with abi1 succeeds
<br>PASS: regression/abi0-conflict/test_abi0_conflict 22 - indirect: ust ap=
p with abi0 and abi1 fails
<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
<br>Testsuite summary for lttng-ust 2.13.8
<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
<br><span style=3D"font-weight:bold;color:rgb(0,0,0);background-color:rgb(2=
55,255,255)"># TOTAL: 278</span><span style=3D"color:rgb(0,0,0);background-=
color:rgb(255,255,255)">
</span><br># PASS: =C2=A0278
<br># SKIP: =C2=A00
<br># XFAIL: 0
<br># FAIL: =C2=A00
<br># XPASS: 0
<br># ERROR: 0
<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
<br>make[4]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests&#39;
<br>make[3]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests&#39;
<br>make[2]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests&#39;
<br>make[1]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/tests&#39;
<br>Making check in extras
<br>make[1]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8/extras&#39;
<br>make[1]: Nothing to be done for &#39;check&#39;.
<br>make[1]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
/extras&#39;
<br>make[1]: Entering directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.=
8&#39;
<br>make[1]: Nothing to be done for &#39;check-am&#39;.
<br>make[1]: Leaving directory &#39;/home/iadmin/lttng-ust/lttng-ust-2.13.8=
&#39;</span></div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
=C2=A0 - Does make check for lttng-tools pass in your environment?<br></blo=
ckquote><div><br></div><div>I&#39;m still using lttng-tools built by yocto =
so I don&#39;t know how to run=20
make check in that situation.=C2=A0 From devtool maybe???=C2=A0 I don&#39;t=
 know, I&#39;d=20
have to look into that one.=C2=A0=C2=A0 I never upgraded lttng-tools either=
, only=20
upgraded lttng-ust and built from source tar to get the fix you=20
mentioned for TLS stuff.</div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
=C2=A0 - Is this reproducible in non-yocto environments or on other <br>
architectures with the same project?<br></blockquote><div><br></div><div>Hm=
m, that&#39;s a good question.=C2=A0 I don&#39;t have any other embedded ta=
rgets to
 try this on that are a different arch.=C2=A0 I think I heard at one point=
=20
early on a heavily stubbed out version ran on a PC but I&#39;d have to look=
=20
into that.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
=C2=A0 - Does running the traced application with `LTTNG_UST_DEBUG=3D1` yie=
ld <br>
more information?<br></blockquote><div><br></div><div><div>So far I&#39;ve =
just been trying to get the app to run without even=20
starting lttng just to get past segfault issue.=C2=A0 Here is what it looks=
=20
like with debug turned on without starting lttng or a lttng-sessiond:</div>=
<div><br></div><div><span style=3D"font-family:monospace"><span style=3D"co=
lor:rgb(0,0,0);background-color:rgb(255,255,255)">iblttng_ust_tracepoint[59=
9/599]:
 Your compiler treats weak symbols with hidden visibility for integer=20
objects as SAME address between compile units part of the same module.=20
(in check_weak_hidden() at tracepoint.c:1012)
</span><br>liblttng_ust_tracepoint[599/599]: Your compiler treats=20
weak symbols with hidden visibility for pointer objects as SAME address=20
between compile units part of the same module. (in check_weak_hidden()=20
at tracepoint.c:1016)
<br>liblttng_ust_tracepoint[599/599]: Your compiler treats weak=20
symbols with hidden visibility for 24-byte structure objects as SAME=20
address between compile units part of the same module. (in=20
check_weak_hidden() at tracepoint.c:1020)
<br>liblttng_ust_tracepoint[599/599]: just registered a tracepoints section=
 from 0xffffb91aec00 and having 26 tracepoints (in lttng_ust_tracepoint_mod=
ule_register() at tracepoint.c:960)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_statedump:end&quot; (in lttng_ust_tracepoint_module_register() at tracepo=
int.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_statedump:procname&quot; (in lttng_ust_tracepoint_module_register() at tr=
acepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_statedump:debug_link&quot; (in lttng_ust_tracepoint_module_register() at =
tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_statedump:build_id&quot; (in lttng_ust_tracepoint_module_register() at tr=
acepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_statedump:bin_info&quot; (in lttng_ust_tracepoint_module_register() at tr=
acepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_statedump:start&quot; (in lttng_ust_tracepoint_module_register() at trace=
point.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_lib:unload&quot; (in lttng_ust_tracepoint_module_register() at tracepoint=
.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_lib:debug_link&quot; (in lttng_ust_tracepoint_module_register() at tracep=
oint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_lib:build_id&quot; (in lttng_ust_tracepoint_module_register() at tracepoi=
nt.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_lib:load&quot; (in lttng_ust_tracepoint_module_register() at tracepoint.c=
:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracef:event&quot; (in lttng_ust_tracepoint_module_register() at tracepoi=
nt.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG&quot; (in lttng_ust_tracepoi=
nt_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_LINE&quot; (in lttng_ust_tra=
cepoint_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_FUNCTION&quot; (in lttng_ust=
_tracepoint_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_UNIT&quot; (in lttng_ust_tra=
cepoint_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_MODULE&quot; (in lttng_ust_t=
racepoint_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_PROCESS&quot; (in lttng_ust_=
tracepoint_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_PROGRAM&quot; (in lttng_ust_=
tracepoint_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_SYSTEM&quot; (in lttng_ust_t=
racepoint_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_INFO&quot; (in lttng_ust_tracepoin=
t_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_NOTICE&quot; (in lttng_ust_tracepo=
int_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_WARNING&quot; (in lttng_ust_tracep=
oint_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_ERR&quot; (in lttng_ust_tracepoint=
_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_CRIT&quot; (in lttng_ust_tracepoin=
t_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_ALERT&quot; (in lttng_ust_tracepoi=
nt_module_register() at tracepoint.c:968)
<br>liblttng_ust_tracepoint[599/599]: registered tracepoint: &quot;lttng_us=
t_tracelog:LTTNG_UST_TRACEPOINT_LOGLEVEL_EMERG&quot; (in lttng_ust_tracepoi=
nt_module_register() at tracepoint.c:968)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_statedump&quot; accepte=
d,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_statedump&quot; accepte=
d,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_statedump&quot; accepte=
d,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_statedump&quot; accepte=
d,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_statedump&quot; accepte=
d,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_statedump&quot; accepte=
d,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_statedump&quot; accepte=
d,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: adding probe lttng_ust_statedump containing 6
 events to lazy registration list (in lttng_ust_probe_register() at=20
lttng-probes.c:254)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_lib&quot; accepted, ver=
sion=20
3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_lib&quot; accepted, ver=
sion=20
3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_lib&quot; accepted, ver=
sion=20
3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_lib&quot; accepted, ver=
sion=20
3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_lib&quot; accepted, ver=
sion=20
3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: adding probe lttng_ust_lib containing 4=20
events to lazy registration list (in lttng_ust_probe_register() at=20
lttng-probes.c:254)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracef&quot; accepted, =
version
 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracef&quot; accepted, =
version
 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: adding probe lttng_ust_tracef containing 1=20
events to lazy registration list (in lttng_ust_probe_register() at=20
lttng-probes.c:254)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: Provider &quot;lttng_ust_tracelog&quot; accepted=
,=20
version 3.0 is compatible with LTTng UST provider version 3.0. (in=20
check_provider_version() at lttng-probes.c:50)
<br>liblttng_ust[599/599]: adding probe lttng_ust_tracelog containing 15
 events to lazy registration list (in lttng_ust_probe_register() at=20
lttng-probes.c:254)
<br>liblttng_ust[599/599]: dlopened liblttng-ust shared library (liblttng-u=
st.so.1). (in lttng_ust_ctor() at lttng-ust-comm.c:2217)
<br>libringbuffer-clients[599/599]: LTT : ltt ring buffer client &quot;rela=
y-metadata-mmap&quot; init
<br> (in lttng_ring_buffer_metadata_client_init() at ../../src/common/ringb=
uffer-clients/metadata-template.h:364)
<br>libringbuffer-clients[599/599]: LTT : ltt ring buffer client &quot;rela=
y-overwrite-mmap&quot; init
<br> (in lttng_ring_buffer_client_overwrite_init() at ../../src/common/ring=
buffer-clients/template.h:826)
<br>libringbuffer-clients[599/599]: LTT : ltt ring buffer client &quot;rela=
y-overwrite-rt-mmap&quot; init
<br> (in lttng_ring_buffer_client_overwrite_rt_init() at ../../src/common/r=
ingbuffer-clients/template.h:826)
<br>libringbuffer-clients[599/599]: LTT : ltt ring buffer client &quot;rela=
y-discard-mmap&quot; init
<br> (in lttng_ring_buffer_client_discard_init() at ../../src/common/ringbu=
ffer-clients/template.h:826)
<br>libringbuffer-clients[599/599]: LTT : ltt ring buffer client &quot;rela=
y-discard-rt-mmap&quot; init
<br> (in lttng_ring_buffer_client_discard_rt_init() at ../../src/common/rin=
gbuffer-clients/template.h:826)
<br>liblttng_ust[599/601]: Info: sessiond not accepting connections to=20
local apps socket (in ust_listener_thread() at lttng-ust-comm.c:1884)
<br>liblttng_ust[599/601]: Waiting for local apps sessiond (in wait_for_ses=
siond() at lttng-ust-comm.c:1758)
<br>liblttng_ust[599/600]: Info: sessiond not accepting connections to=20
global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1884)
<br>Segmentation fault</span></div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
=C2=A0 - I&#39;d also run lttng-sessiond with the environment variable <br>
`LTTNG_UST_DEBUG=3D1` set and `-vvv --verbose-consumer` in the program <br>
arguments and capture for stdout &amp; stderr into a file for analysis.<br>
=C2=A0 - Verify if the main program is dynamically linked with `ldd`<br>
=C2=A0 - Verify which libraries are loaded at runtime and which calls are <=
br>
shimmed with `LD_DEBUG=3Dlibs,binding`<br></blockquote><div><br></div><div>=
<div>I provided some of this above.</div><div>The output of LD_DEBUG=3Dlibs=
,bindings is attached as file <span style=3D"font-family:monospace"><span s=
tyle=3D"color:rgb(0,0,0);background-color:rgb(255,255,255)">ld_debug-libs-b=
indings.txt in attached tar file (had to use compression as system rejected=
 this post as it was too large).<br></span></span></div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
=C2=A0 - Review in detail which gcc commands are executed to produce the <b=
r>
tracepoint provider and link it to the main executable.<br></blockquote><di=
v><br></div><div>Just like the hello example in the documentation</div><div=
>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
My current understanding is that the statedump tracepoints are <br>
registered and those events communicated before the main program&#39;s init=
 <br>
is run (at least for C programs). If you do the following test, I think <br=
>
you should be able to see the statedumps. Could you confirm if you have <br=
>
them or not?<br>
<br>
<br>
```<br>
LTTNG_UST_DEBUG=3D1 lttng-sessiond -vvv --verbose-consumer &amp;&gt; <br>
/tmp/sessiond.log &amp;<br>
lttng create<br>
lttng enable-event -u --all<br>
lttng start<br>
<br>
unset LTTNG_UST_WITHOUT_BADDR_STATEDUMP<br>
unset LTTNG_UST_WITHOUT_PROCNAME_STATEDUMP<br>
LTTNG_UST_DEBUG=3D1 LTTNG_UST_REGISTER_TIMEOUT=3D-1 ./my_app<br>
# Segfault?<br></blockquote><div><br></div><div>Yes, still segfault.=C2=A0 =
The sessiond.log is in attached tar file.<br></div><div>=C2=A0<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
lttng stop<br>
lttng view # Here you should have the statedump events<br>
killall lttng-sessiond<br></blockquote><div><br></div><div><div>So the embe=
dded target doesn&#39;t have babletrace so I archived the=20
session and transferred it over to my dev PC and used tracecompas to=20
view the lttng-session.</div><div><br></div><div>You can see that in the <s=
pan style=3D"font-family:monospace"><span style=3D"color:rgb(0,0,0);backgro=
und-color:rgb(255,255,255)">my_session.csv file in the attached tar.<br></s=
pan></span></div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
```<br>
<br>
&gt; <br>
&gt; Thanks!=C2=A0 I&#39;m running out of things to try.<br>
<br>
Ultimately, given the bespoke environment, build steps, and application <br=
>
it&#39;s tough to diagnose a lot of things that we would go over with a fin=
e <br>
tooth comb: seeing how the TPPs are built and linked, seeing how the <br>
application is built and linked, analyzing what&#39;s happening at runtime,=
 <br>
having a coredump that allows us to see the variables, etc.<br>
<br>
If you can provide a minimal reproducer, it&#39;s possible to dig further <=
br>
into it.<br>
<br>
Otherwise, to look in more detail at your specific project would be <br>
covered under a service contract (for which we can sign NDAs, etc. as <br>
needed). Feel free to reach out the <a href=3D"mailto:sales@efficios.com" t=
arget=3D"_blank">sales@efficios.com</a> to organise that.<br></blockquote><=
div><br></div><div><div>I understand but so far schedules &amp; budget/prio=
rities haven&#39;t=20
aligned so once again I&#39;ve been scheduled to look at this issue again=
=20
since we last tried it on older Dunfell OS with older versions of lttng=20
and it looks like we have the same problem as before.</div><div><br></div><=
div>Thanks for your help!</div><div><br></div><div>Regards,</div><div><br><=
/div><div>Brian</div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
&gt; <br>
&gt; I don&#39;t fully understand the implications of some of this document=
ation, <br>
&gt; but I have learned enough to know LD_PRELOAD means nothing if everythi=
ng <br>
&gt; is static built.=C2=A0 Our application is heavily multi threaded, uses=
 fork, <br>
&gt; clone and who knows if it&#39;s doing double closes or not ... so I&#3=
9;ve tried <br>
&gt; these LD_PRELOAD &quot;helpers&quot; or whatever they are, before and =
didn&#39;t get a <br>
&gt; different result, but now know it&#39;s only for shared library object=
.=C2=A0 So <br>
&gt; now I will experiment with making our tpp a shared object and try <br>
&gt; LD_PRELOAD of fork, fd and pthread helpers and starting my app that wa=
y.<br>
<br>
LD_PRELOAD has an effect if the application you are running is <br>
dynamically linked (note: the TPP can be statically linked inside an <br>
dynamically linked executable, and the preloads are still useful and/or <br=
>
needed in that case).<br>
<br>
The function of the helpers are to ensure that various system calls <br>
don&#39;t clobber things in use by lttng-ust. E.g., close() is shimmed by <=
br>
liblttng-ust-fd.so so that FDs that lttng-ust uses aren&#39;t suddenly shut=
 <br>
by the program.<br>
<br>
If you want to see it in action, you could try an experiment with a <br>
slightly modified hello-static-lib application, with instructions in the <b=
r>
top comment: <br>
<a href=3D"https://gist.github.com/kienanstewart/299eb6a511d92d458569b210e4=
a418a8" rel=3D"noreferrer" target=3D"_blank">https://gist.github.com/kienan=
stewart/299eb6a511d92d458569b210e4a418a8</a><br>
<br>
The effect of the preloads such as liblttng-ust-fd.so are independent of <b=
r>
how the TPP is built and linked to the application or library.<br>
<br>
thanks,<br>
kienan<br>
<br>
&gt; <br>
&gt; This is what I&#39;m referring to above from the lttng docs:<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Use LTTng-UST with daemons<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lttng.o=
rg/docs/v2.13/#doc-using-lttng-ust-with-daemons" rel=3D"noreferrer" target=
=3D"_blank">https://lttng.org/docs/v2.13/#doc-using-lttng-ust-with-daemons<=
/a>&gt;<br>
&gt; <br>
&gt; If your instrumented application calls fork(2) <br>
&gt; &lt;<a href=3D"https://man7.org/linux/man-pages/man2/fork.2.html" rel=
=3D"noreferrer" target=3D"_blank">https://man7.org/linux/man-pages/man2/for=
k.2.html</a>&gt;, clone(2) <br>
&gt; &lt;<a href=3D"https://man7.org/linux/man-pages/man2/clone.2.html" rel=
=3D"noreferrer" target=3D"_blank">https://man7.org/linux/man-pages/man2/clo=
ne.2.html</a>&gt;, or BSD=E2=80=99s rfork(2) <br>
&gt; &lt;<a href=3D"http://www.freebsd.org/cgi/man.cgi?query=3Drfork&amp;se=
ktion=3D2&amp;manpath=3DFreeBSD+4.10-RELEASE" rel=3D"noreferrer" target=3D"=
_blank">http://www.freebsd.org/cgi/man.cgi?query=3Drfork&amp;sektion=3D2&am=
p;manpath=3DFreeBSD+4.10-RELEASE</a>&gt;, without a following exec(3) &lt;<=
a href=3D"https://man7.org/linux/man-pages/man3/exec.3.html" rel=3D"norefer=
rer" target=3D"_blank">https://man7.org/linux/man-pages/man3/exec.3.html</a=
>&gt;-family system call, you must preload the |liblttng-ust-fork.so| share=
d object when you start the application.<br>
&gt; <br>
&gt; LD_PRELOAD=3Dliblttng-ust-fork.so ./my-app<br>
&gt; <br>
&gt; If your tracepoint provider package is a shared library which you also=
 <br>
&gt; preload, you must put both shared objects in |LD_PRELOAD|:<br>
&gt; <br>
&gt; LD_PRELOAD=3Dliblttng-ust-fork.so:/path/to/tp.so ./my-app<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Use LTTng-UST with application=
s which close file descriptors<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0that don=E2=80=99t belong to t=
hem<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lttng.o=
rg/docs/v2.13/#doc-liblttng-ust-fd" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lttng.org/docs/v2.13/#doc-liblttng-ust-fd</a>&gt;<br>
&gt; <br>
&gt; Since 2.9<br>
&gt; <br>
&gt; If your instrumented application closes one or more file descriptors <=
br>
&gt; which it did not open itself, you must preload the |liblttng-ust-fd.so=
| <br>
&gt; shared object when you start the application:<br>
&gt; <br>
&gt; LD_PRELOAD=3Dliblttng-ust-fd.so ./my-app<br>
&gt; <br>
&gt; Typical use cases include closing all the file descriptors after fork(=
2) <br>
&gt; &lt;<a href=3D"https://man7.org/linux/man-pages/man2/fork.2.html" rel=
=3D"noreferrer" target=3D"_blank">https://man7.org/linux/man-pages/man2/for=
k.2.html</a>&gt; or rfork(2) <br>
&gt; &lt;<a href=3D"http://www.freebsd.org/cgi/man.cgi?query=3Drfork&amp;se=
ktion=3D2&amp;manpath=3DFreeBSD+4.10-RELEASE" rel=3D"noreferrer" target=3D"=
_blank">http://www.freebsd.org/cgi/man.cgi?query=3Drfork&amp;sektion=3D2&am=
p;manpath=3DFreeBSD+4.10-RELEASE</a>&gt; and buggy applications doing =E2=
=80=9Cdouble closes=E2=80=9D.<br>
&gt; <br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Brian<br>
&gt; <br>
&gt; <br>
</blockquote></div></div>

--000000000000f65436061de2e05e--

--000000000000f65438061de2e060
Content-Type: application/x-xz; name="log-files.tar.xz"
Content-Disposition: attachment; filename="log-files.tar.xz"
Content-Transfer-Encoding: base64
Content-ID: <f_lyxxqoct0>
X-Attachment-Id: f_lyxxqoct0

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj+Nf/7/xdABcLygbhh+V67tU/Pt+Iu5NiUDjFFV9250vF
jsg0cRvMW8MgviW6GORLF4JTKdbEMxxK2hfQqUnQfZYC3fUGEtzU0GpKov7gqDUnyI8Ql7b5YyGn
wG4Ip4H/wwU+MUObZU198bURSJhcM08PGDlZJ9DoruSeqqAxU/kQdaiLH3PTVg6g2Jch0ZybEmBD
6L5BQ+HfiJDnHGc0ccc7cNdYv22AtGJoOzb91fVBywKmPVjYjknp26y6qDRQw+oYDhHbodlSYesG
9m7/AeO6GMXHTZ+Pd4tvtxcJbW4e+aG/Nq8EzceruoweT2/AWhgijeY63V/aIcau2tXBdwAPjhj9
tYyc/bHviZJk14RqBPlPfoQoBqcvDy6bh/e7G5chbXfVdnCUFhisfZbIV3Tx5pES+1UqGdLLiWc+
jZJkn1X05yml00bN/aOJmdb2sIkLzF3GeDVQ76hJpyqnIzAEa310KvM8QJEbzliud+GZl+S/fJPZ
+Vn0H0LTQCQKAqURibXhDr0OImOHonNdaAN1s2JMr5VDSLAtsWVs9rDHReEc3M+wPYGU8DQUbblh
KR+ZpN/Tp7Nhx6naeh0H7Ivhz42fjRsFc3pjWGfnoo2knTRVB1dbILKT4eDzfe1DZDXxBnT8nyzh
Re1N7E+9QKpxDUjlpyqvMptdCDNt9nxKalKajzLq8bIZFJVqAVUfx6YUnWPWFOVCqjQNMu9cfZG3
Njco4tpupyLjifz9gIm8JBJUj7IBEGuP/TNsiNtZUGIJGW/TveomG8nUtQ7bDTGwulFwE91SS60j
wJipSZ1LoZhMlM43jhjKYw700hKJvdeFr/4gtssC4fpcFhg11O0dbmUI67F3eWEYGPhGKC8sc35z
sb3hMDp8xqFsMVJ4VyHdxQsaUZ1ve3uMoRO5knrGzYEeqdCl7DDu5YQRjQYbI49hOiw7/6Scj7IQ
0DArWwBds/OezuWr9RPts5xaP3KZVS27Ceq//Z22z/iGdfN2DywPRc7UpjaZV7/a67c6X2D+9ps7
XT0yIod1qzBv4JYdGiUvj6RbPrQNonpMT+dYlAFEAX7Fg/jwBnCmadh8RIoHMHchpk+wuZFBGfd+
VBAIU05bQvngouxvqIcKhomZp5ImxpeDjz+tx2d9cJQFKZZJG+onFNrzrad2cIDzQKboK0U/P+Av
5yj457AyC2klAcVVPR3mNv1JoFNqRwp4hyveGDLb+ucmSO+96O54KihMPCnlkGn/p9bYc0kIYtKG
1kPd2Xydmq2WzrPLhBclhikwaMxw6hlRV5B82DL8q/+sF5Ss2FGI1fWVGEfL8Rtnd5/iAKwscRgJ
2vTLwk/R+Vu4L+8ZST1bJ/105ncYKnMA/+jJpv6+LwCuiZbHezFrbPDMgMabfT+42aJZNCaklSWn
E+cgwo/ZZcb7tnshyJfnMmnb0OmwuCnOsUhlm5tuS/5xgw991xmwKLv7etoREX5F7/WcAQnJC5yh
zqdPA0bH6nbjTpI9fh/H6bKO5LB8q5tjgaCM7JSWYEDRrdcJrShcJ5+dICVaOtKODDCHk1Zl/hnK
7o+o3Wl4eQP2ydsAHYyx2LdSzrNJLU3M0sgKPK3oTgI7w0ylMtGJ07cJkYwQlKczHuAxlLLXNcM3
YwOB4hK28nzn51ypyGJs6UnQ5pOaFdbCFvcqC1uJcw8oNnJO5OBgD1xb5Y1R8Ss8uXa7uSSB71G1
wLR6zJyqQH46SFXjE5Bs6O32tWGbD/j8Xh2Ky3XBE/WTR22i+g7E/JguWiO5KFX65Y0MyTxDO17j
IAGnCTzpLk3W3VHf//yNEPZ+E0PDuMZvgF0oSMrnsEtwbWjGnMDeMVT2qaqx2pn+vYt4JEx48j68
lhSNC5Y1r17i9XtvqGcbx9It9K5FTZVazD7AKh8gut4NMtMLbzSvAXOj+IZvoonlWbB8AX3jKJgD
LLozSrd5NTKF8vkJi3gAf870QD1PPLql0wCjVBCZIJPkcz1es3znedNhYzkTti4eJyQK7xTwsv6a
hub/91sNVRXOibUUg24ZBf8IdBAB+nLScv1EDcn7jzPoycpXrQpZnOGcVfwxWo2hD/pvFxqmVdOD
uEQTg/T8DIGQINcnKla+UpUG1sM+9vXuVGnpuXOrE08l1bsm4oFuPljcZqW8c66BhzHTX1l6vhoR
EKD9ffQB9dTau2XMsWNvJFAJ66X26vXP2FYGcznLIDeTdcCFCwQzg11ukN9P40Yply4jdu3yrfdE
8joPOrjXFCKuMZBVeDr0Wz06ERICKl2FuY3iPYfkDu7hV6JrmtFvACdrgiEgyKEMUsnx+2TjYSKU
PW7f4KZVacX3/DOaz88FU8HzW56cHgRRNUTqt+4jJKat526d0XqlgL4Sr7BuV7z6Yg3RS8bCl4O3
0CBE/AjjvK4Pip93WHPyfryuU1ZvdpgL+PhUX/1dWF4tK24njbeuyiVqgCLSD1w+MgtgkTmTIMdL
ieWCoOtDcrnp3Ddu1LfWMujWpDUF7nhnNrEfnQ9N0V30DikXBUIDxtj/JYrFX2CiRV8Lc2fhh3Uk
jRXPychxHkqm1b/clviilza+uy6eRKGctHsUmXFVRQiPOstUO5Yb/9sh6grCLtDpDWQ266DoR2sG
su9pWnhhnwwVhjXrCVgCIV/7bIH2Mk0B7knkwbAnVH+W4D3xyQo5fCXj8UXtsP5jjmu/zqGWmUo8
fMTyG3nsnuPVcFc6l04/w7gE2TgeGU/SjRASJonEaZt5+/BHGOVaizqM+ibYY6pYeCEa6hvmH7Pl
1Xx7MbjzGau50VM6G5xeBSWaV3oug04dKASdb1q5gSHI1QiTDx1IDvWVH+RzfPnAKt+xG8GfIR7a
FUhFtWp8vpLx7v0hfjX+DCx6/95Irw+Hbs7YX/9Dhkdncxel7/mIXAjT1pGn/62hw9G2MTLVeM0w
KrtjZAo/oTqU7Xu0IACD3f3SIoEYYFJJfukCk69MT/1M/5Nh32r3H8RWmPXSiaPT7Zfc1oG5QKsD
ttvdq3HOPyscJVmitIZe2ISZUEelT/BYwh2KoLGfKhJ1GM0uCeXc2fpSZ0RJuaHoKuyoKRMwbs7i
vSDhD8r/ExX3gmfarQ/Gg7gh/aU3XQ/mhifF9HqB/N5ItdyJiHiWtIQrJ+wZHvkNWxzNfFd18Cmg
tV1SbyC1rk8rhttAr40fWi4WGfTt2Up57YzpWXXH8nPHrXWo9Yl8Kb6bxcHY+C/M9rvap05lL8AI
Kd1Zynq3mPgHv0V6o72JISGv/wiAERr9mPCwRt8s9fmVMXQc+Mv8WVeJLVSIvdLBpLGo5FZ45wHg
Oq6Wks3SMDTmSMVT21IDZx1V/Gu91LJznU0fX+a8mbTegZCDKMwVNHlZ8Rv90mjP1vxarfwcLCAx
TBQv5l1U6HOb9Y84jhsNb6k+90wHMmdcf4J19xCtNTgkP92EBzC+oqD67tBDrn0rOZKrv+u5tiI7
+0vy713bns4xoGN6EtVLYYlCL5iAiaXFIxKOI8NdJDRD8qE9kMz8b6QH3wjUnYucPXRK6FoB9mrD
a5kIP2WeG168vbZmAf+ANd08Sph3xZ89YV3NwjdgUebo0no+mIb9D587khel56yx1HifFSfcpwMh
7dPq8IWw/9M77zKB1YgBv/6EoHGdc+suBbOEIJdECFousA3Ytt+JnDurbmdsWTaLIP1F5XrKkjDB
HphUwPJpXNraWdZqsvBMBKEq5ltXkX1G3DxRbeJh2e2NqGQqhbEVx876t1gF2bnaLuTeptHf/mPV
9ezaPMzjgzQ7LkvG0QXNi0/NiWnTWHd2y1RZSa5vUg4u5ZmFdXexZVk3DGGnJrrYQ11qau/FxjOB
LccrjKXmnz1szZqJ1u++mRNfu4w5uhMuA5rIcGMsNqu6fpi6n4Z/j1A/O5D0scwRjNtgG/TZ9v1z
325rQFgI5xMKyRKupDthNUgPR3shNKoZbi8PQxS8JbR4lVa2pCfrvo1rtPaEtCg0xovoLpDeQdY5
MXXmAfIc/NgEdPhXBD454NHDtV/FnjD0bi1qGSP/n/3PMbddzvE5jOscGaSrBn09ieFa1MT835u8
s6aBbgp21h1FE6wBt6+yW4lh6FCi0in/AA4aw+fK3zhbWd8YE1av1mpmVz9QHsel+aDmoZlzHDV+
LciN+cLhy4zV5FXzT6MUH1YlgaM1KlnWUeeCDqWToApQUFKjYGZojJFOcgK+yf190OkF+F1DgfvH
nR9rk0DHgumBRWT0HEfAi9Z02vD7iBa+i0NLfPYVBuCGNVUVoU0RGUNKD5PtSScvRJ5A14DOnBew
GnminN3ZKUWcgThvEZKWrxDABmy2qXeZJ1am1TargCp1pb/8Xz9Y7OwK7N1gdDkD2cqn+PvMxI1n
n1qSMOCuV6Sv/zgFtm16RDryKh0FucVtuHVJKlrgFpKu7nHZz5MZ8Nizw22RtSbkuhYFhDvKjpEP
CO6qReTnypf9n4HpAMAQu/zhYvCBtR6kvDfHUU9bhnwAqLQxhASOIgEF+MuQTgsPaoA/KPRGMj56
YPMX6ydMf2XfVDpfXAaOAuwNWZlZMTybqXexIcLlODBj1bEGCqoDdkkn6+htQMOK64tU/vs2HUuR
0Jqopzjy01ZA/hBO5iR0JQTPxJdReSyfVuz0aZGDfghGmc/kUCz0+QAFLs1VOdkgIL9Z6C5EdQ13
lGoks2ZYUsNpSGD36bKqJPrYrIqqYdVzAYHc35Qi1h/ISfBXmcAV4HD5HKwfdP/RUJcc9Lx5A/3G
Dk1qtrOxSNb7/MAhVcET79tvqh1eSV1xTmL5etQwwZYFkvR31Wlla0TVOc7yaiyHnYBKz6yFskxW
VApJZ70H37i5VY28Waaxn8pFnIlB4G7L+E4Dvvjd8CuG2mtRB+3t8ZnH+P7s1XoDtI09hYqkaZOY
qpmGFwsZEUp+xgkraovjkU4fwUMRnxyQ7v6UFCAvJ9dmzNntsmONt++KlEWCN8CI3RbMeCPFB3SF
LPZuyNoDCXBRSeI7geqeQjTJOlBiN8E8vUkLbDL3FtkFFS8MI8dt+w1dniwiYS8AJZZz7SuLpnF9
tOnh7R3cMcqYon0rc3/XQFwn7D5sy4fdsMqOC2cpFrQcRFzELw00wac3cQA2fWSPiBO8bDtePv0X
JZQ5kY3U0UEfrZ2ioTEi/FpNFXjLNNKY+Qbk0FfmXtn4U2Ti9Y4r/aWPJ3kVA4JTaiWuCqhx7nSF
oaV1y82SojUaqcFOV9cV0QszjlkAYhU2Nbbk1WBkFWcYs0/4wgkbjwyiSPlPYtDn1S+QQLAfWbHm
4qqMEWXxZeurjnuM6dG1hzKTfigC2OokbUW3H6m6xKU/R+7C/rm9HzcPHJAzfPXjO/TKwTTYopw/
OESNbAbD3DNO7WAuT54netIvbCd+ZiRHj839AegvKxyW7ycuvVbRN05KQU0DUS0ajaLW29Pe8by/
UlhrOSlezdC90DPZdz6q7L4QN3PKtvVpIEbOFVcNvgXABTHEhLpQQKb/jv8QExxbYYvpC4Oe4cNA
XhKSxZERdttpxHQuYHiYPfVSZcdcoYJUNq6KZMnleRGDgGjbyvmCSj4yLZd+2CM/NuuKmcGPUTgc
sDxR9ChpWoPTHmugtsusdpY7sf2s2/HvKiXDoRcmUcJSqKzYljZkiVIAH9waOzi+j3j3SoTEXz5B
dODfbwpQyEVJu5LSXV8pzJ1lqG4sAQSB0a1J9BXTKKn7aRyXPSWlXmHxf1CWh6Q7ms4Ean6gPwJa
GoLx2I1amfANixzi4iwyK0kqym08Kr9qb46pF/H/SyySGu6tQLE+/te8FQ+gEOVqqY44CeEjTLIv
w6BCrMyLX5N8YpKCdwNrZPX7TMQtpDVnxmjbiBuYQtFaCJXqNzRlS72PsreBMY8YmGeTDUnMMcmt
pNOorBH+I8TqmXWZFtL1hpoOcU8mwAI69T+mOYbX52ivHxWcEJoMDDU//nfMRkwrPzid2c6F5FVi
kbMX7tF5gbdPWVJzKYNMcD+w507ttV6hYz4wROgrDzndJ7dW5h3TSDz02l04KUGgp+qewQhrH0xY
/CEpkPnnu3wKuit6FSMM3PAx2SjCuB8Qz4ogXPkvC0JXZjUB3hRHYnAy2SZyJQsfGmKlIdIvH2EP
xlFMBOsgKxbiSxP5enkaIbpOIvQWZ5apo+Bo6NLwN42FZV7SQh28urY7Yxqh6qXGEGJMMo8Ys38s
k4/2RSgo5xHsg4y4YEefKURqLNyJYqS0+PzmkWe1RVL40NuSfI9zw5iCrOQdeghAuBNuEKIjt2dF
tBuAkQ5/orqDm4TB7ybxR9JYjVGuiiTdnuk4N9OpbhE3WBzNUP0angfSABkzb4DBFCk+OB7JjTX5
nLoBgadU2wY3SVdnbmJzg72NDsaJhhIKt/DyQJyyLEHJqkBYLCAitYsUXb5XmsdRI8drQFVZju0e
BxoXHdBQPTquSDtAGQ5kOHotIZx3tj+1CQjBQluiwMT3nkC0YLa66rVJc0ww3/RySP/AhOgLjVND
+uJ1+0bpyd3o0ha1wsPJyOYViLDIvkjbl6PMcoHwXdnLv0GtnaGoBVgA1OYAW7yn5gj842mTwgCC
LSdKhV44knwWu3mjwg/ml9ow27lDa4FOjeV9J3xQqtp4ODweUHeDjv8hFggfnezWlFJ+ZD/VGQRX
MTCk7S6KoC8xec3f5ZJ+aoPM8oYnUJkmb5431mGi+l7q5bx1tStOmW9PYalgb1m6YoQREJKsG7SB
VU2AWbHUPdHYLwFnpm5d4thad8C/2fVVgWP+zNjTi9Cxy94KQvMzxCp3iWDWGkg/yeKXSoB4WfQz
4msRmppGoIlOjnVV+e19w9noNb1aR/jRJfZIaL6wtN02yevreAMt358oRRhudj7cLcXXFgjQXEQd
0PPzuv5Vh4fEKXSs5VaX9PtlTj1hjCHX7+ebcA2txyJJ9LLSbaZCPHNqJA+qmlVpAKnci6fNAiT5
7VryTF6sbB5KWhtVte7cTQsAt5eOE2TN6mBwDwDxb70ny40bWy4jfnuAFe3O7otcK6mm2SQSxk8g
xvUsMY8/hR5PxkM/+pByMw3WTV+yjksF9bu1T+2zj6/FGxnoepfD05/YwcirPPBfO40xK4SDW0At
44Ief47ahMV6XdOINw/TLhn860m7fERwqNBjlBlZCmBgEpgAZRykdxWeSjpLuOwH9jox2eUgaTvu
Iixl4Uta/oNTEpunUV3NK5fYC+nlEOCUw2iiaPsdZm6mfBbpogwHbRE0wzz0rrFtbk/g+UMhl0+O
CEOE8qP+QoJ//PikplPAcxZ8XTDVQwZyFecpsxLs5QJBjzeZLH04taaj08UNA3GY8JrnOrvGkEYd
H95XcgjQk/AP9nNZGsTxWAYRwa6MBK2QArhgQKPdtfBil0y6POhFcwJ17H2on1M8LzFtOA5F1egt
wYFkvXZR2cp4oeNAJvzYGRo8rtTzdLwRiZtM0Ex7dsvBNSGcbuoM2nVWj09i54kosyBSt1OzlU5E
H90640QpqyEteN+e00mjyXkRrGvyhOZ8VrasR1pUcSnYnnMt7BeIFto0uh3Zo/sfphBr7d3/XFHG
L46rZxJpaWcIQnB+XcdNfutklz0EKA60fK2sJ7hR/0M348EsjzWnvL+Q8hjbyALLMaqzX3M2gz5t
PKLxbRJsDQNS9jHxgLIJ2OGXsLVRBzkEoft6zTYpeNs/0xO0yPi22xKNH5gYtH/n/CY9u7FdKpH2
EyIcUAZMeCYSVTheVL/ax2n6iVzQoE0PLVxAFIkeu47mwa18wXCeaUyscY3ZZyq0PFfwOzLHj4+G
rLxIrfgEh4SEY0X5ooI7fMCYsTBMhX941sUCOWffD5Eh+VCKjKFqoX1P0yRWObHnd9ht4B4QSYvy
fRM8khZTMWlvMiFRmESSk1UPRTRmHgiIyd6TeDHxfQoqg7l37ccmjWzzg9Tnxio/+R2qscL/wCe7
I1v66Zw/doX0wM9t+1NMSac1d6R98XcIsm7VJEgDJUkC0xLkDkd5QzBsPQD2hzSqnZzIvGuAXGU2
TjMn1N7ORzqAHwvjt719Y1h2wnkAG+CYShk6mcKNXM9xy8MAsApJhqR+LqVDSFbKvEeieq3MHglB
+Ij4Vt4KbMJfty4xfz/PyZiC/LtOIf+v8KkW+8bduBaJ8/r1H54UPXSI2qFavQvzPc2ER/0XGccg
azlp/6KxJ1y56DOnHN5XeYoKYRyrQA1AQMmsDpjlydNFzhsoUKNJ7gfP2VshLHf3W2js2C9erTjw
1szb7rUH1tCXwoCBV5aXWgdH7isvZEk0KeTG+3iwbjnkN9b9hChrPJCAxwIt10jSmc+tVrJvYRNy
azYySugXPIeZdvc4gkLWe3uyEwz0HdVsEVUSkNSVcgH/C/5kLvMtC8YpEKzg3kvCZQf9knC7iFaN
UtKTTTfp2CEQoOeVqQMNF7HaKOp2dXvW8mSrdoP30g99Z+o/GArmG5q78Aj10P2otGJYPDicDr1k
jtmKDBxpQk+9yS5sMfbKKhDcuh+sSfiq5x3qTvZ28huqJywS72dIuG2YjQidVLQ1PFmAWGgZYD7z
bvOhfxJI1k5nkgRlDEZgDtrTW5bpuEqwcXhxah3K5jSom/CxC6DdZJ334sNkLXGoSofFTjlNeLf6
IoopgQRLOEmoJwtfY5DygFaH9fg8VahQvtrxMU9mRzCyziK/LFgCu08Yuw/iBPR5b6Rq8FF6OKt7
/qJofXBFEHGkQNFm7r/QLuQOtsj9TsrbFfU8oLe0MJpJex4mfdf/igfh6vEpEgOE+cz1AwJu4yOp
Kstvms9iunpelLz+90dGrq1nMT7BBtdxVzCCVQRCgF2LooSdOwTWJgDCtM/151lCsIS94f9rQCmV
xHnQiiHKCC3dG+ZPRYacHhESosVaYEsXJBuYTyf+RQH8pZxGfvNS4obrg6RnbV5DmdpzMdpIGUja
paWSdgHMeDyurMNTcLJUX6yi4lEuNiR0TkUqmCKPdG6ZLK+wUJJO59NyUtdrisnM1P+tBtWwl0Hy
ONZFqcLEXfsWr5dMr9RDxsCrn05JOxRM4nQtkJgpQ1BOJ1QfTvr7otGqgLjoEN7hOUvY5jmQg0K7
VI3CXm+N4d9EsN7SRqEKr1UZyrsQJVHR2eaUPvVUAqyNacy0SI887LTHV9+043vJejvc4xiNCQJn
wL/HRBH90fBv27n4C795QcQ/Y/os23g5anShZ1VYlaR4rGxqE5cupVOQYaRvFn86P2RHRHSodZ5l
jvc/jhXlRAsl37r+fSsWNPzeM0ZxAq0CtqvRKw+Magzwe2wo0Z0uUJciUedfIDUM9rliMSsVyGOs
UPYTWgJZqfcasrLuzMCSvSRL0ayjg7dv7Md3GRv+A3hUTa5QGivM0bzL88A0vCzghFgImmT4v60d
V966dXdBAe4/fobsEM1XfgFxP8Kpw+SmHL9ZjY8PePfblcZe77MF+H8vgXlsMXXOlT/rjA0SOU/x
U3+ecMNKPGqcgDkEscfIPQkadEjxcIOygndDI8b/4qRHeN9zvnzCK+kUI0Yc1E+SkFvFLopE/D7i
RLF8iIPvkZVa7g+ul934LAA0KzZliqP/ZleuNOlFqdyvZjZEPPqOato98ssd681JD9EUgM1iU9Kh
FvMAjeHedjS+lN3WDfJIMKzVbqVgj6ARpTZjCfjoLnBqmiG7AvXc53E6kzZhWJlYJBct4akrBLiW
HXnCdlV1MqC88eH4hMvBCEn748LE4M/snuKh0oHWtCWh0j4PJrKrpyD8nKtEGH31KWhUNxxJSqoH
gxzCZ9scruDEpzk5BQKgP4a4/5z52tuxFwT4b62R8Fh7swkSRgYIDju3mxoeR2jOr6f4IxOl9EJz
farUR8sUfYjcoXQVRnoxIQ/egJhjlhEsgZAwJOKYrkWKSK6o2ocDTkXRXYX1EIQUfDF5NKN9eRjr
+Z6TEKeW4N4HKR1sjr1PW0MOZNyAjC2E8SzFeo9yMrgT0/U8Anc9p4/d2lMno7wVMhk86MC4FZuh
8N6bn/Ts4YuzcM+SdbA/+gWrrtmrDsQAMjg3Gn5OFlFaOvGPfvd4k2654mmxt6vpi/rAOja9NhN2
HJeUQaHWSOcK+FKSBYWbKLNFFtYLmsTHHrO5v28rSKCkc9IwvSuBMTJHh3myxMIBnqE4o1Rdz5Xc
DCf+47XQsJzPJMn0FFuZnAFIVmZIzbwGZTIqJ32i0+KF935HlC8RBd6CPXI7OIZISeYPQVJBF1/k
segq8TxWGBgBSJ2S/DhOp2XtkD1O4ygnKAm5Ma4F91TTO5rXl9rGXEUSnPMmrY4jQ1YGDElot7+c
KELfu7JkMiZKfm6eqxoJDZ3mL0yBk7/bTTrFTn0raJXfA8yyd1b8KyMaM4AJkbSqK3pGTlrZ+xKW
oX3UzHxPz/pRLc5GoYnwwT5MAX5yME8fdAdDtCfT+OP7120ZAuddjhCHtYgAUferuVucrtUz63dU
c1EUPDtHnNX2LKWH1NVkEYTVSqC15/XKJUJzcHwQoxDqCf+wzlevrJGXdp/u9gucjFdUS2BSol+Z
oRXRWB/8yc9cFjDPcu0YQM1adU3SXrps83Jd4HQrSBcl7LeI1HtNGk854mPwl0KeCZmHlH/3jMqq
u26BC93+qx8XDSE+w/VjRvlsD7E5TceLQEgtIb+4XiN/0DOs5kUtLqqm2anqtJLxPs7MXnY+Co9s
XY0LNI+rxFAOPaZMNuR0RL6NpghmY/ajqQuuPm5nnyi+fcd8VwN4t4g6aPK23Gr0No4vAn6o90WY
qfAZdWt8EDOEjYpVeCK4TctfFKCpuA+GlmirXy+9h42umATNhm9ils6cEG43qe2JVS3gJMtTwvKH
Ls2c4FSsglDQyO0LXKSaJQou32ru1T12qt4KXQkULeBXN9ap50fNT1K9aob64W2hyv9dPXAiYx0q
G0vZ10MHYww9jBoycAXn3GekIz1VRcoKwa9MAv8ieotS9hNI8eG7B+T0kRErWv1tZaeGDYz+9XPy
bpQ7Gr30Tog1g+H+gAycEIQjt7LX4nEes5ESJ4uyP92gSDE1CHIShPh8R/czXey/dggWPTRgSn36
O8MNT/S8rguIOVtX/OWfH0HEYAYmEHOqZqYKl2qxIbm8wyQeMl9y01mEpFK41g1vDAJncFbC2BZx
mAol6+Jl3KhZjbHSQFcJxzLlj6+89pTG4wudHCu4SEU9JUzbJ6nDxKEverjdChy6NQRwi80CauQr
ixzIoHA9929pXUUnz06lA4bDi6u3Yc42rgIAhnZ5xTvoeHbdfBZ6BIjXc9urm1lD3WwZ86nWIVG3
hI5hdWaC3bcsdwr1o9kpSUyFRKwsMX6MnPvx/r+7K5AondvcEdYnMNhHPTtk7WmZIIHzrQA8qQFE
4Til7jzGaIsAffe+FaNWimBbCd49SgEkRNmsKSuMfKxpGZ1CVUYfXI86IOIkqgS4WZnuzQ6+cfUO
wg9BizJEefak747oVS4+ymBbc869bmFFUjNX8DtSZjLOlt9Ib+V7N+E4wzzpKaOcUL0K/kD0h7v4
Pqxpb602ZubzqjgaQf21HCTOiKcYZpT1JBLNZsBk0T8ziSmil4m7YUirW0kwpgG9jBHe1fbf53KT
XGHFUW2UcR7NKfbuV9hsuTI1Uc3K1iQY/bkg5k/rLMOtweNft3TdHPuiUTYr7OdmpDxquxVYcHRE
ALBgZp5zQPsi3LGdaN85h/XxI3YodPiM0oV9XuMt1Nei1CGyGNFAgTlPRpDgY35MALV/1KpuJ0kM
JZXBJzHt020voiuh2YQuDWUWNjWntZoKSwCAAVKHtOhWi8JEZwqTdwWU3y/7LcJTrrTWJzKirNjP
EznabTikIJjCpA1XOywy3VtVBM0jYxjIe8vXIb3UyHqp/LZyu/aiR5Jj5otLaxEXbOJmN+BOpwhT
Gb1nGoJDVGWvP8WAtJFU0RHYO4bg6xZFcO19q3ymjtcjp05I3rdKFD31DsqlXPaSwjvD4HqGrkcG
bqS6bICizGheGlNZ72n8RmEIyMDYadpNUvuikMKlD9N8yB5vb3sMBM+3WSDD/auCTIFtmUdIITsW
/BqYPTCt2l+T+BOa7YPr+Bo7VNK/WU89KVUSd2qPpvEB3vMJH/Xs0SWnQk64mXSk+gYf1vjGI66y
qMghxCBUFQPXCoGgSo3tIBsqEV9p9DHCuNvkdvq5UoknNCL5EbOgcv5CK0El+HUYT9IR6d2puMCt
zI9J13cyK/Rm5T68d3j1n0nq6VsMM+SF90jmujluxC7m0oC4uzxIns/9y3Hg/vWM8jnlFPXFbXcS
gw3vai63w0Bk7oik+wzfw7jTxecMVo0H8BmsNC0w0UlbC2/rQOwetHCoPWPd5pH11QA6hbWPyMfQ
DKTeAkI1j/SFZQS5O63FRHN17NYruSpiqdAoafCITOGNRavENbV4kzbX9L+RL0yQmlMbR/007XBz
unA1L14176wsurCNkNqG7QdLJVfjrf9bYATbAWq1lMVDgil/l9lCwjE2ldsB+ZYHNvVtOtDLAj1W
6yvMVvs/Hb953jkdUA1Q1pNVzvnRv/7KOV62E4N914ODBPRd5hbTIGKMh/guIFveA5w7Y2fAsfd4
Bfj5rnFCjMe0xx8ml+y8UST8afJtgvmkB5VbHTtKG5w1fxOGeWC6BjhkncS7SGZqMDqi2aOohboM
jRmbH7OPul+BwS0e2D+V7d/fkOWQfEtPjr/uS9b8NtXXWJynMnA+CYcT2PQyeEZpNKoVHLdTTBzQ
NCcPOt5L9326uBAXYejBy/2V2Qr5H86dWbLPCsNxhh2AZGtE6F0Ff7ZhFydo0qKUAqo6gBXomJGX
h+HVPBY/HJq8bz/ZARKRl5ctnByPRo+3frxpkm+AtrLIa7Py67w6u38UKkNXBPnpGNU73yyMgnjx
HPHFdN9Om1ARRBG9Z3L51hrw/0lnoK/OEm4YbP2AQyHrjFlO/3DkWktpJ+cc6Cl0+qhBDA8KYAy5
GGO0iW8U+QWqII3lFLqnq2RwZq4m5+EybpF+61bt2u7ry0uJkUfGRbIDdDit/dc2BQuNhP+h4GHf
1kEoq6gzcHIANrxFnn/D8mkXULfHwMLAeYd6Vg8ke6plFV/GGq7l+uNJNsBhPPLuoRFst3m/06dq
PMdzhLE5T2Ir/tF3Ol56bxkcf5x+vkPTQ3Gngnpg+JihMgq2GMEnhVszWP8wnqHbsUvK/8n+EDf8
a5y0LMCsmg44hRskxzJnl/YEx1C3BK9H9OGjKGmSGQVC6XHFDmk399kOvMR76T2VDh3gXAHTQnat
rwmr0dHPDNb4Su5a7HIr0x1W3Eg5hpyKBGAsuXQf6pjf40UDbbTm2cCUQz7/LG1s53+1VZnlouiu
eiwSoLGhMQqAMQBDNAR4QQWD3NFut6tUrf0XEW8kiMFlJTy9ueq0t6STHGfeJsIZp8oz0F0/llKd
aAw/uOzqRaQMBSUUKyNoK1Xgz9OZJcQ6bL8UYwAsakwQtwAk6C1Lfb/11iIEP6PrTSm+YCPMxEeB
+A/VGUfaup811fJFFY8dIo9jXAtsCgJ0oJUdumcvHDM/mfWMjkBbwpHXlJLkYS7x9SpUZ4RdTZIS
eYGIAp4Z4hJtWim2AvG7N+TytRNH4GV6j2sbgrRTJuLJOLY3hqT/hKqVRUnYV3ANAY8Ge8sPsrFY
tO7T3QIrL8HeocdpFDHJb562QD+mXY9INuR8HE3qzAsTgMIXQiLW3rzM1Kpj27DYzkJNqaY9Cjzb
NwmChycUE8JyfHeTOYrdOe5DIuxIOLqemAV5pdJasj3GXWL4Nq8d+jffDSzcnEMGtB6QvHRzwOwF
8EwgPp8FOkr7RS+Atd3kGkoi9nacSxKHe2Kx2gMV5RNgHdnP2avjQPRw+m9gr3cmrELWuXo1g/sD
Gx3pqxuwcjRXDhsJrPsOSpRPTFjq/zdxJ1IFwTUzW3vIwyb+znGSdOuYuofvJ3RetcXmUtMltBbq
Mwj/MQLlBe7Y/3SizCXJJJnqfHywbHlITGYFOYxX30hIzk9dr34HdnL/9Gt14B1vij6zaEKmKglA
vYVTKbh5VmXz2F+Fxh42+gGl/K9kM9Wn/TpxBqtlEkls+dsDy7BCNeASX+mcfL6ROczBL/aVuSte
iK6AHa6tcje5We2S7wEELrfbzJ7pYg68IxQfysKf/kYIjsWF+zw+pe6pAAnSFulXKKfbrdy+fdZ4
m6+dsL1U2EWs/91zYIPu71LPPTzq3jgLWB9r2ctU15Te1lLYsG3vyB7/Y34xt0KDhgKd212Va/3I
zJhHP6Y7JyoBM3LyCnLWNyh61UU7o14yBO+nGJnNON5fLRM94J+c6h1yhReF83/ey7rm3ZrMxK8f
s7HE4gtB28e3YfHub/M3M6DnpVCTI8fmH12JipQTqowfsCcarVbRAgvD+t4207Tzx4UwLI9RVafC
YBmBzSdaasqfpoN008mPjF1IIwE7mCejqaKJliPi8vg3tdG4XrkAqqG+RI57nBGWa5BQfXycCX6f
qEaPtpk5NkU3yXmbyzs5q91VJkTmmgSKv6l6LzQbtbvZEvm9p6384BXijNjtQVZOFjI3ulSp/bgg
jutMJHFn/u+qViRE9vNpqM1+I/TWOpjwB/WJK3qX5t62xbdOy3KOwr80grOiWGG0iKNE42gCsMm2
DyHy1GH2P0QfIh0nbdvB8LlRApYh2zN1Z6eiHkMtUlZVteWyJIliM81wojsP8RrBsXqbgTinx1u8
WlqEBId5iRdaaPGMej333ip/1Me4yHWX8bEJD8yuPrnieQG+Ply6ox7n7vZgb5ArYFtdLPPAkZGu
ccb3GCo4s9UIsy+YV8QJk2boiWWg+8MVu4/d85GsAgWSzQ1qLEfEQsgJ+TG0J+2cY6R1nw0Z7cV2
MRxoUuz31J9haXIY/iOquxcPgT1k1nBg7SxkjoWcakLUoOG6qig7X/7HBXQGFFyNjEZrkjdlaK9I
KvbTgfCK8336SE1/80NULFhCmjU9XWZdqlhJwya9db5hP0D2u2Px9GpFst5bi+UAiL/vZjiqqy0c
ZMkWbH03Ly/MdEfOxMq1wckrEVaB893SM/v2WmwmAlX6SMEZR9EXuY/NiHlzE09AEveEoUKxM0vk
LBL+oXvKhOV5W1RVfjVe5qqCrADCTwlR6YETUySS6ykJkzwH8qM7QSFgiiTQrOM2zEaPf8/M5mPx
ba3RVqs27aSogIooyCPXvClq6Ry6rh7F/lJD+glJZCUHkCSMIKTke1D1/RpnkJXJcWoTpsf+AMAb
DZQ9ii4RAXmuQkLQFlxKQDmvwuCsWkL5IeUcWwm0zBu0J5eiPCuh2/z3wZzcHu5N5bsPXCb/5LYR
VPXPjhppJdxnMXkHX8x1PBSemtsELEVBjVIixvixYlmui6VeUK+bSyC7QJg9xPSQr2xCt5E4qOu4
e/v1qp9hnEnmbDsbDWpV6JZRcBamb4Ob6vJ2rXNRKKTJ2aUj1xyKE6p/sXyRnsRdcW+kHPekG4iu
Denn8xkSfPhSEpopp57XaowLTXg2Zqiy3LsBGeoaOMaaGMdiXkFPL11+dpcTOfqhLt/y2ISg8UOC
m8VIwRH7HGppahyeUiaHRlChrY7Y/jLhPs7/zYg/WgljJEpZzNfcgjswTN3tDDzU5trSX4RoKlfD
HRZ/rv0CUU+0ukohM2P1UImKc9Mm9OEAs2hJwrsLXTBV7llCONw7sseUG56a9y5YP+RBwRMphEmi
FhELO4fP3dw0dc69S0p6ZgexusxOs1Xz2adXefiH4o5/aHR2nUCnQ+Q/Zj0z31B7qBjndxCgyTeL
T94aMPkiH/0kG82bqqLzPw73RJiGLN6ozQ6zZpGSIQwS4A/9P5FQUS5gKdZTukddiX1i/5ZnCnAW
85jUO/w2Oa129LS/lkg1li0+B2xnWnKUcxjC3QwedjjGNbKVEJ76/+Mzpgm98ghN+qgzip+hfdI+
IzNcn6ShnuK3mEH8Br1HZmrihpKUP3cJkH4XDMbmL10iKQ98Cj69En0SLyCi+PAtQ61uiVK1FwKc
dXBjr8+SCVtgULeQIyBzUkVL8SzknHVOZZ6qD4hYsslMbPtbof+HO0b1Pp8J0xhtzcwoG4S9rG1v
ghAz3+jCsv1UF3fs4JhJOCTI7e+Dp09NyakqX1AJBTFOq8t14zgeuYCNaVzSdlUyL9TYtKuclikB
k+6+02vXDd0B4YztfMcncjQg4Ct0t3a7PkxkPHRm1RtmFnf9FdG96Z3Lxa+RY/Ie+OvgeJm67XZe
EtLph9hDZ5TsL+WWrdNhJT6mgZ3R/wLlCbFoKaL+odoo86oZvTgzeclEE4Q5bAr9flduchPWB/qp
rLDFk4n2tVIH9+LpHjSChMkqKUUC1245Mq/pLz7pd8hHxHMhmxJQcGk3hqbKXsLMUCYdtjTPDaN+
jlv6JpZIDbbw8i5iBiu0sTx0Pp0SKeOZMnQbE6l51hfUCCNgAF7dtwcIzKMUwNvlqcuBW9TA0c4s
f1KwnNbHyQSvGBugNmXqM0Piq8l5tYgSrEmnNUIt2IQ3lTIDdCg72gJqvQIW1MObODAKN8T1QSyg
TsEp2Ha1lOJVfDhx0uOslvRYbvkfEd9tcsmAB4nvdo5A4rVAPxn3HAYLpatjsOb3luwHBoCsDFV0
BTlIsEkkYi2J1DXQtnlUjEBc+DImkbLRBj3GytZ1vE6NTtalIUAn9y4lONm3VbTg/hDT8LO7kazz
0tjuCmUIvu/fxYblssUgBWeXLRB77z9e7j8bwhiKXNlOouH1bSLxbiDCVYte6mcrVX6wa9T111Xl
iLL0sAMVjrhTr1C4DftiJ/Pff3C6MHrCMCJC8nQQeq8nX9oDZk6+J+0MtCD2/w4oPdIe+cbFRyoF
t+AtDFC4howDf4QRQV7pfBo5h5vhYMQxq1183kJtKPjVsxTeEliT2pbIvgaZzBOb03v3LlDKRdk+
nefZHQGF9KtCM/uX1IRTiWm3sWKDkM5bqOdTc0jQFAqtu3/3rD+LdouQ6jygb9pcSeMGZEHQhcLP
O2rjvWuuMb2ZDw6lMp43DC8tBprE/35D867ze2NyFvQcgzjsWHqu+aLeyuxBFc0YbZYo2lZ3RN5a
WM3T0g79nS+U4nKO8+nQOMDwLvHXg2dIY0nM5E8GG68CVqq/dtzfaI2lw0ZV59C8SLkdpQTiAEsX
V29bA4e51O7wur0KPX0ij6TYxzD3ZBifzo/RrolXdhqy94sCAMvsBC8wCqvd4wGEv/oJ7/zBiNOD
3Ll9T7wUgJkjiaHNBp5MgRbEj7Ln+q3x2KtiFjdxK235jPMZbG4DWBKWdDoIEZ4Hs7apjERY1i6K
V6agdRX1Bvag0np8GaANkQpC5JpNRrrbweXt4CQQNePhBgZmRozWK8ViAx/sWeMOo4HN1m+7AaJ0
HhP8o4uMqUdXdeDmOWT7I7mfNAVtxyhnzEJCkW8i5LrVq3/Z2LjfhorMdgv73hYVovKYS7zECtL7
DNosV+baOwGV190nh7c5t0sEPPZPREwQt3BOyTA5qVeB1er8xEvsdWtV91uTHUgnjcRZJ3E+6RvE
+3E1mW+HkPUI377e0U1rrfXdQeENtxiWPtGj6o4p5yGZxiCrQXFVm52EhJO40qspfLMZ5nVIGFFv
R6RHQe+JouA+gXopeKM6AyreSPOh1umLUgdIUqEo3HBxui15eHq5cPYtZr1Xmg+E+CT6l3rUH/00
sD/QUZhFmpC8GR96DYIM2PTWGQAq3XXfO9pc9WmklM3eWEMkjM6ETmKUdilbfiOC+5N0WJtf89zy
a3meCu9rKvqAmBLaolFG1tlddeHLIGTCd1k+6ERCgFFop/hOciqX1OHW0CbfrMvOfgQwwri5Y99I
bsUL88mYcg/AWJ97kGuUgb16+caaZDg02f19Lp3Y7P3M22LLoKnO2m4skD+SAUBfGsCDup/uSKYu
UHgf0LrsI8N/h9n65QggTbf+TfvSpuZfcJA8EgIbdvG3O1n/mK1qXRBj6SlJA7hlsGm2t4Zh7pCe
OdJkFdnIhu3AEnsmzQQmFjwMqB3kMcj5T5pZokdMvG5ewtjtFyKJWwfpIVYnU0BamLaHpzkcRmpi
glIfgkF7rvgLvYknKLi6GRxXcNLhqPclbHTcIzt1DgspLELX0xAT9oQDgcc3IOS/TWVs+XpL0sXS
5xxd/Zcnnt/QmTlG+3of/9AhJVryX2iFdEcQSQXN9C6xOQZiJyHPA7ENyRgQD9FB3WnJKTrHnw5a
e9O82P5DXFXoGLGpMii/UfwI1/IIKuSiJ8E7IBA5igN09jzEeRxInNK98wqNLssgmU6FPXxLSV8K
fplGZfJkwdJCUkrwaA/YfgpWIqx1Vn/YiVCD6aHY1jXjJH76j4t1roF6wW5AjEsGHH/qg45xlnUE
p0lBz4h4pbcLpYNKsxxVUw4rKJaPC7y70AKVyLfC69kNb3W6NCsrF5phFMt6ZHoiEfOMbEQzYMkY
gWWi/NB1NcVMMNQFKXPN3YXhoylNYlj4bmAWJ23vSyATX4492FzCilAefptCTaPjRyaQnBGryQnd
J/KcfZQ2XuwU0pH55j6gVoz3BPYHNDNPby2zW2zFK8c4Hzb3XFKJAM8pzzf7uSa4GkY3TOn75TeJ
7vZdsuXrc2jZYosg/tADdCacYuyuDi7M3Vx8m0S6z5fBZcjot3bVh6Xhgl3bJtCHvuWwpKD3qzt8
UHY436hnZ2Vls2+Qawxpr63J/vmuYheNBE4H7UBk1XzdVKD4mkuMoLIuTeD/k4pDaFX+CiTYLEpS
X2wBCcsgied7qcCXDd8hKZpX1evd1iIkWjs6f3RzyPpGCmrEbsSI9sMur5gzxLtB+ZIc9w44XZnr
RC2eU9mGEQ38dHUXBzE9uq1Hte1rDDeHOcyZZmK827UPXVXtOxryuTKC7LuF0/XynqZlMuigUhWx
FALzoDZNxadbWlLJfqwLJjZK4WvAY5fvBqpLxD0W/J+b5/fPiCxzpdzkBCWK6mAT17n9v9/g5/g2
rAVSjWpnG0Kx961AciOPedOur9i8pgx5UDb7yvWuoYO9SWEKTCwWzo3M+nMc8gRMGQajYcccJGn4
yE64bZMxgNhIsoaJChy/+IN05VBr+s/jy5iIVGffsVm8384cgDkgfjAwGFNjpHm4+MP4ObOuIaY1
QkHUusEjcfQxfDA6OaV22qI2+HXA5LiqsatLfXUOs9FarjrGtICTpRVb43/TNibqrVz5duxfctBd
rfJPZ0TCPILL7UXG+LugBleWZOkFoOsvM2moOHzD5SxmgdjajgpV2TBmNsfXZFjZbQxnBEJkFhft
g6DeXOa9Up0ULJpU1uhGkP0DXmDd2eCC6F9ij0sxEq/+k85HLDg6AMzXhAKbYFWYnX+hmq1ZAGvq
60s7RhOodMVSVZL+dxKMxkOGvIIzdGD+3v0ffBaVSgxjULC/owkbZYkBi3q+oHvf7zY2eupd9LJ1
6g7lW+IzDkts8hV+RXBm3RPnmYxaiDIxdguZ4yLvrXEGcyx/s4WjJHc2AVGIjvI4BRGXUYqH6z/P
SjZP30feQnl/AVLNI4y3LJ5MV7jWMaAnrumMDRqpF+xVTk/mcA7B1iINY1T3haE82ljDU49ZgbKJ
D25+ugdkOdA+1q4cLfWaXhgmmUIXE9drJLjBomL42vXztKi/iFL2CIOuJjHLhIa9OrKvQ8PTxygI
N6aMgOaBzUtoxwGA+7BVsLH/3HJ2ats1wci1ogorMz0ljE2Q+amQjfGK0Sfgce70k1y9tmH6nACj
i70U6axeiypSP0JlXCaLwW6FCEYa9MnOyuFI1URCx23AG5YwGPpfgXR8v9PrpLkvVq4v92eHg6Ft
1cAa4dYsBIr24+eOOjHYhLijfODYfoUJLa1hQ0MpYIwsBvRefSj2NKeEPLFx6EBvlbmZVtEi0tLG
RaaexA8D8pTpwbdWcOgjZ46Cj4L2M2FdQg0vpyyVsWASAd6654ocsJAYcG3N0aSdjo92cmjVY179
hFY/gn37umo9wIw7/LaB14ju69K+sWp2fwedyfj3mUivK8CDtkqcjVIyMbe835Ay59pVu2cDh529
N9W8Mj2s/C0DASW1/OO15MEX3Yvk1+PWRR5v9rz13WS0I7TwiwmRpygc/cpkTDp+laA5hUjVexDD
8GX5Wlzvy9tZ7sYoOVmaYyT0IHIYC6Qo+JqbTaxIAE11NAzoa7uNNvRfHnf2a2hdk8kM0ovbm82E
DgNVn0/piLCOM7YtOLDzW3VCi0p3jJ5nOTqBWXyZdvy4SDpj5WrIIODScFDzwVzKf8pNc8Y6PzH9
5FK6DytyMs0Op69WN02IAA7tlLZ42ljLrvAlLR1PS3FQIvrKE72qI8W+G6H8r4C9VHmFSlEjN0Tk
BNkVtWExXrrUk+vpK6rE6S3E/TPZUm4QXpKAhMx+CUY6pjN3kkWSOKMV9vasd4SKiBxFcErb82o8
wFJjXvDGDzQefhCE/GIJAV0oGrQ4aF//e7T94KbCoRGtCTU3YCqVGKm7xryd0pG+LwS/rgiWbCTu
BHfN9Gfv4NYpNJrK5ULzAShyK2ojtXZGgZA4gV0lQOV6ZdDoPeMus6q1CENUYoaS9yRShjwTHi1h
k8y/mdcqA/HxY3Rdg9FYL3CTazyu9ohP3VIo097EeMDchk1l6s0VC2mygAJQW6SjtDucPewGnMgp
HOT/+e7zrwF3HdRE8ape1PglBPuzdPb0V7gPNI2c/ZZru+PGxiz1NpAyDviwk1lnfecxEM110PEH
Y1WALLGE+b5qXUAhHY+KcgJVIPrz6CxRwhzsrRIMRuMx1wXfk73gV/IkE0Yl8U3ESKq4xdKEmUG9
8gF713IT6rpYg3KrxgDof0L55AbvMHvYSLMleR11A1TxWG45hnO9k+QshNtlAlzEyNFuLGLZGJpb
6V+p8LgzsG2tiHKkEdES6BTZ1Ox66IBeBzysci+BGuG3qPxNMfdApbh0CoeOM9MV3FOIhzE3IJdK
W0gp+VPMMNkCxC5MS6U0shLH+e4BQqbOnerGIc7FAUSeOcy6pzk+nturEEgQfkHSHrLdSMNRrO59
ONYHVZVaSzxAFTcCks6m52gW3EOTZUPUTe5/uy4KsB7AdRsVvi+4HjGKnW4ujyg77IOt+rjnykjc
B2BhiK2ZoB7Ttxs69VmjO4ylGI68xSZ0fzcp6FIO/ZDE83q7az13NDQTW/zOOKlOWtj/LerCo5XU
fBldD5d4t7erJIMFo9cTzCwulfk0fMbT9VriPmTRJrCrTtJXAmV7ywRbuXsMzjfWJPMS544BYUnY
87bu6EZBADxpQj+nFV5/ePwSB3oqLuIHjDRWeHek824NC0t4Ebr0Ce9ksmGVspkMwHYCSgU5D2e3
U5KB/5dV1tqFX5OL8alcRt1dqGK1kYW00eZN/3VQVjjXBvTJ44r+fVi7ETozfI9OT1rra52JckpS
6Th+HMpjJeEpLCBxlhV9aEkZY/cW9UQBob+MYmS/ccg92y9s+0iKkdoE0CgnmPVEHtX+DaamkN/h
ILzkoRXiFJef4ndRoFJAOwKJ04q18c+vjAKfTNj6Y5en/MrrsBnT6z6i5EwKEC7Wo8gvBZY9OVJC
5RTu+UNvtkbPLJM6n87961cwdEIa0s2zJP+MnsON3m6z16pbFUhvcOuTNGYZ2lTmX3wf36rxvNEu
uLxVcDZkJItaZH+rBt0u3/mJ9KysmGIRt9v2w4l4BQlIkmx2z/LLaWzmHAqeXxYFTUQ86pz2d+iO
AbubicSFM/FGx5HCydBR6yc+6tpwGd5ovIq4hP6Sb7WcuuLa3dH3qzsFaKPxV754RYo7DHAgzjaV
cE2SLAoTDaICfsUdDZt/v/j6UCSVbEBHXKezPSk86nmNecAJcyJtUgbyWyMt69kHB7TFNvmSvrvK
fo4+pqBQQcE8B1JekKVhP+DJKGaxcczHSh/fz8Avsaa6QfyDOORkZ0UbJ3F1XbOHI90kIQ2r0Gx2
hT3QkoTTiNNCj7t/LvILyA4zhQGHyeB6X0pj3QXRkk3x2JruSYKc3PG1+9z1nVGh/YN2jC7bOci1
251xrCItgh2mTw2OUQ/7GycPAJyr2UdgkJ5U9jqTXj1fLdMcUchm2Lthie4N0rYgNO12iFSKj0Ni
eib7Cf4czRKGdfg0s1NKKm77bfFgjgIKfgEDLXEbG8pnqlr2Ly5r3hyVmJU7DG6cSvMDFXFJ0+ga
cm5txpU4UywI+SkRQBj3TBBijhZN1eGFOmuNqVlsuLSEg9fWyxZaf8tvZ7P7EaxGzxZH59CXm7dm
IHBRLfgjACRmk7bsndABHC7wdyYvK49jMxtS3F6A0mLMFyJ/KnMWiwocyq35JXAASnc+yBcIQrBW
/Cf9oqHXMKpUKzv+DXgTLt7yr2k+bWNNdAeneNwiF0bX563WWF6+GGUDs7lDFI3T9bwo0y2Y9xwn
NtbfDzcQg+Nk2ZwQgJPfBIl6r63MDQCT4WcAVqklmM1yVOE44EcsDP42ILB0MtJIF6Xy2k4J0Mao
pAFCSvTP2pgWaL0nnVkFO2n0G7U2ivQ4MSkY8RJSCud1bhivN0R8Exj9+Dt6JEWtIpPjcWbrLIzC
arA3lk+tloLnnpqHR5ETMdKM6o7//qIaqiG4zL7GzewEG0MmIBrQJOu1NB3HUQp/i7phko0bGeki
1yaMgA/FFESHges+LDZAVgMoeRPkYvLkT7EP1IMloSnM5OBjkM/JsMEtymChum10oge90lsOnNg8
tWJ9tdqovU74F82EMV6U54yAv8iawpFEmdMj9cNxPprWBXN0c5pwBO+vn1Qa1efpC3d7gKayxP+6
ISI8Q1eD09MjNVhrjZjK8l8i4McBm8/ryTllKWUwkz0gebvvg0auSNoXvcQ3uxdfYkdhXIenidUm
jiDANaaJQYUN4Ub0IaUHMoRDSA5pVRM7UoZsNxSOBeT2UBvOUN2pvAQvJhEGEVDOlg3EvkNYmffn
M3crh0s6Esu9QtjWeTVb6FwxvN2VFTu0J1bOioopFGLCAEkGSuquK2Mbyf5P3aqwY6FlYU99LEKR
1+baFbneYOszIrwrJUlbCI251BgcQF4lIBO/6q3IZhcp8LoqZM9nkI3VnJ1DpqxcpJzZvlhvZRC5
1Pb7uCp8UV0mFwpkh1zHNMwFv7K+Pq53C8hMqXizTyR3JrvgNv839E0D7IrPajFDyyd8qiViGOH1
Hue4peZZOzp16MR5xJSv+t6w4D4G9DQayQ28hchJAa50WOxevsqkYyr8xVrQobbmRdJIJXtkUgmu
XN9dV6RnR2lQslKdKuv2Ywcl8/bjGM2rnBC8CmmTapFKZOwPVO8tsVlB9O75x3GW2GrYCnDYr4Le
4a0kc+ie/QVE41tyrdvhuiL3GVcfbQo4nHPdA2kGj68fTj5hGP/LlyxfqOZhGITGdvnbPBwWGJ8O
AfCVtHvW8htph0vaL92CjOCYx2atP034UTwgaSZUur6Kuw7UhjpTsf1Fb4vykQP5UQ7twP/sJJ9M
/JWRI3/Gx95SkPWUReenBqnXIsVSnNJG46oXeoMYWpHeGH+l1FpZd0WMAh2FxdynQrSax7+sHIWC
qdZcfJ8dZ7embSxR8usvHbPGhjheeQUFZDJ+GMzaEmZEtDEaykCCCwjAuqbt6v/XGRyTnLLhg9fz
mpeFKnt+ek1kcEyKTG2GUrlo5U/1luC4LsmBgeGUA0S1FQjZYIHwZTnfOrAnAt28IE8436tQ2poX
uUO1t0cLNHTuGwHUd8/exjXwAZyYBcFPtIbzB+o39Sgg11AwFTlyp9PWfJiKoYQdz21+wDO5C1f4
ppaUFYZfth5c1XSn0XmP/z45XwG8MO+E4jBdbfezuFopl/COHsbX5mZdjQc1it6xkcHeLB0vruOV
1YBSN46WLgjFsyX8/k0YCIcbYt3bycXgFmVRaUWJGVsgNQDtaDHMKyqXd0eCv+XNw2IF4dnhBOHo
2mpAhtn/b9OUoXdWe0JMKEjeE3XJgmJT0udSxvLGgozvS25cKBFihfXibSXFJ6p7eQtV/oO4hKNK
sGCLlY3qj79TFPUm8gzUPdquh+OueX8NXmMbvZ0fu+adH07kMFmQVFGQiicoPUNB9FDz/mYOxBnh
ySbm3HyZvGoM/nUS1U3OvOA9Sp0LQtyD5/V+Fh63We4VcKlDRAQiPZ/gMYzF81bcRaxiF1Va61jI
gUbEOf8jYJxE5lfaEZpCefFUyjHopvgEZw3fTcdQYpEI8jAf5yhDfuaLSq1szA8BTQePcZVt9F7U
VJGin+8vUr14yYH+EZTyKqiuX4b9DaFsymmdZcCBZEjrOxIvic1iJv/iGGRbEHhdLrE2HlurmBHy
3vmvhs5PPNKwzc4tapFhC9CPUOtuN7Yr0v2igd7c+CDcU3ilhUMTeIVaUmMpbU33doqSRFbJdLzA
hoLa418a98yy0T/hBOVpeAbwJZZ7p/Ew3P0tnEbpmJypeB6i0Es6VpB1cwA97mnwnQZDpyROCSzM
hu6H4OTJ4NiAhG9EPbRp2WZgMFPGTfukwCGMQkap5NbPcwDMJinDqxJSLVEouw0DvCsmAw04KlSz
H+nrRXk5jDv8OeB8107mvDtmsk0tgpW2WvYhADP2/PqMLlk2gAoNl/+WvcooJHt1fx6AT3Y0Z7+g
en453rIrqSOLojUEc/kZ1MxmZy7oiTGc4Icc3BhjU4UC7C4WXOvnC/wWZGnBgy7DseKXDFppI0+M
PhcFGjwt8aG+0hnUCBiaMPjWYxPgXkul4KpQikp+S6F5+bTJMUC1egrODHKFZTyouEbQ3GudsRpR
2R6LCI82906VT1mXV/JY4KumsbuHK9kyZ70cVicYdwsgV5QDawLVr8QELVDmHEzt9tpmKzuLH50h
G8oN/uiufoDqBbpmK+es490NUmrujjGsOAVgWhcuDrWAmw9nnfc+1uNbhfULIHoClTBvg0x/xFY2
rNE7eMdSQz2+zsp8IxMp8ex9SN6x//IWbCbGeM0TmIXZxAQEuJ6vUytnqIBJaB1Fx+qcboaRDGox
zJPtOQp3F/xdmXjWVemsgnsDbpXq2Uu1WOy9xAVW9S90p9LmPX/Oyjb6/FBtt1J3V899X063Tvd+
8fGgSLwXMlB0uoN1+sNuUtKRXHlL7K0+ge05g5J4IUaiPyAKKpDUdlPEQO7+dUbV8YRf5N/mDzM6
YHkAQ0aC1AM77vy2xE8qppMQGqZxlUXR3mAmEG0D9F7iHXR1p+MgCP2xDUEgyMelX9sohPcaoxXK
p6EdPzKAH1HuDtSBTW9h+FEcFgKWzMIyYj4xFRvF4Gc7bxVEmOL5lS28gTnyRNeM+yFVEt2x3AQK
Gn+S9wYd81SL/upSa60/g9mGFtDdGoqMCNNeschtNzVh2zi3ToHwV2EKe14XU0vMKsgRoew8uFfP
y5mxc2TuJMlDcZq+0mjTQYe4g4KB193/7z0cL6nqsOqpe4MrJtI1hs2wY3nNC5uOfs1VL7S3djFO
H95B1LHX+fsPwVHEv733Redz82XtZ+hgvQLv7vDMoa7LP5IeH+Q8bJwKwC0f4+vHpQAMgnzzTH5W
P1Oy61OipdHZPWuRnZuIvDFkNLprkreV4v2Hn3M2GYg91q/X2rTezXmWd+ppFq3kUA72KJC7YVW6
ofsnHFl95DgDjvJ5Xt/aUNjzx8yF4QHShpib7DdPBk1yykPP7BDjjLO7FFIH1b/AnSEepzSEZB88
ytNs3m5veHfhozzZpTVP1GxOjB1TJkRfh6EZVw1sTN5ADxLhkiO5rjPleEC8hv/TQ6vr9b8ljZw2
Ps4BJSjmRSVKyJBO6a2M4dHXCSbXHSE4sH58zNJVkBTLIHIxnk24678YTM0c2aoQIrBFuAinzlWP
DyTpsDKJekrGGVqrhu4OrpV5IcIte8YydIXIHEJZC23seL3Ltot8uZgDUhJ+NP7vbP5Wqpr7eTR0
zrVaHTSyaWqrtWlxg/OMw8F/PdeI0okFYUsSK9hFcKloN2srL5HUkH4I78x05y9sKiIorm5A1yFW
jFFUWV+7Z05ur8TYRrlIG/p+0A7HxHijHLs0rxYDUhQg6qHYmhqGDzqQjsDfFXyiS5hpxvmJnYxk
OBikx/DlfbvqxYe+Ml5tR5nqC/xEdsS+vNjvF6bmw1vZukomcGWoqpN473TmxvOXvk1Ov6jOhWK2
Xr2q/YYlynb2vZ9/lkXIYTPaNotsdbWRKTyfRCkHpXTdgSPWhCg06NIUpqbfc9Q4HUMb6wtHOq0D
2/rvMaxuf6EYuA9veHJ2RB3XcKLsm8g1W4XovxN4YhrxX3r7fGjVjwBly+h+1oqY+uGtwJHgoWOh
YCVdx+PIxY/sDg8D7v3bttp93mD4fBAncRJuhN1ioEZ2t2XY3nAjFJ7bSKHB3VgbsoOk4c3bRMsZ
Ek4QViFyS/x/cZwqwPIYa9rIt+fkNuGhjmlXe1PmMPMOUo/Y6WEdFTt9YLTqcLELYhurhdN1n1he
F73GHCabsuOjlaVgh4PMermim4ghSDJa/u92oK/ANR734oImJ9LzGlSmVsQMSjHonsxr4A/7+iwu
tvOZvNKhs1rvsUhCHzBrfyHpBZpWiQEPBjM/9PXhuhQXnIJClr5hVhU6ore8FZAwk7lsBTnwNp1P
OEP80ZwikuMS5CHrruqiBvPeFaq6V7WwqF8QQX+M2ufv6VV339f/PH/LqtBdJgMl7Nvx3nloyO2+
Nq6VWrgjo0cmDNiSo9didl6/BdIZQQiHPWPT61aUQJ1nL/9Mt9fYtC8Ktt0g+Qo4ygbFcdKbUVKG
xE4JgK7tHAH8SjG0ASBUjrt3VRENqoLmwpEoJwj0qLlV8LxU0F24l3F9n73I4mtlx0RhLOU9FfqZ
3DIpV73npj5BM+WDVILwMDLocpVLCDDgqkZJ/OSaJlogZ5At7rwkx85TU+0RpY7ZkAaz4IIXVbf1
mA3VGMuwmHNoSkT5hvQBJmg49+DH1DLKqQUxz6Wuutma5+s7aJ3MoGcnC56rii3+FjBhk83tpHiU
sDQJrVgs4jG+Z4WsuWHqodNEPOcz/GCtkzGP83ojWpuOz6PdYVtlfahtr4rIjt2geS7JlZH7LoYD
EfGHyM27fGx4xp2MnuEoqIxQiTplKyZ/GHL9NK9D08FBnfFW/RbQiitV/PwaP6aUTxf1xXe/dO4u
eClKdghloodcsnN8hZPe5zzo523X8Y3LYeBztXZW10PpVTj3DHOnvJCOG9r8QMEX1Ezfw1CJAV8V
dpLXQEV0bYQNT6cFpYjfJPPUgZbDe72MzIA5611GE8O/Kt4PXokST0FuMj1pbIiR570idNo9hFOI
/kATEVke0tbiSsPbn7nO0RGq2QT4PoBq2T2XO0gUwj8VoacG3BhT9gcVAeZypCzYrTX3C/KqdHUc
+Ba8iwTXKfLs213AMZYtb3BLaCpTgInhvnbv9wb8MZlnY0hgamTEZr+Nq7KxYIO5vMaBS3yd7ljC
WYvC2VccT08MBmEaVuHs4m0E4+NODgNNZYk59IC5hfyrDVZFmYAns7skuBgI6lk8bCLWj/buB9/t
Bi4YfoEFL7tDmZcMNR+F0Si8VDc50zI/+P+jce0vo4aJFpoOd600rnR3NTb/hUIiZMkMHZ5cha7o
cAgMvuzqPH98bbeq5Iz30oGTmpoPJTDjr+gha+NkdRJdJAaiaAk5mahi+/Ow2eFJt1UZRakCoHuJ
uFpiuHvxRYgPK+rj+xiAtC0tuugk2HYciaaEIkftxPB+faifUUNv7XiwkQZtWR2Ykkr7eZkKOzH8
ZcAfBGq82jX+fbZOl0EOhdLTczCRhevXxe5H07KSS/0J80fdjj+20HnMrXgtFmUtv2ekZ6NQ0sYc
0dY+hR/2CC+KFAphLPu4EhdJiFkjP4p/L0G2e/Y07td7vkerJM6YdgHaldQKUp3zKw8orjqpJVZG
D/5yMwgeWGuJojD3l/0fD7R/YVwzngy7l2c99IeFPYs3YATwuZCBqKhqBjepALDsdJ9cobQnOXkG
ha7eXhhGg05XMZwuUtuiX11FasZ7K5MFS84QCUIJOfsr98zs0JPe/jemnSWWU45Glj90LHXNPUzQ
MVcIEwS2oYC1k9AsNkE/z8UBZAwSn7JrRyzLcPgjsCyTopUigdrpGhbzQFkXdHKcJdHNWyLqxVGX
YD/veREJ4746mKSyLBRvqtnWYhMsBVUKJwVUdjB/FKX1Donyf8HHlfPaM7nTrSHXJhAdunoHUroA
OO5FW3CZxlp0eeLIB0xIoHdrEaCkz+/RjazCBh6RHQBFoR7L5GxSBoT8Vn+yGtq8YZ2MYPgi7+EC
5qsmyMO0z/Wg3hFuC0qGK0sXt4Hihn6Z5apL37iPhJf/Cxw7xSc0C9QycA5I88ZatG8wW3hYsN8S
DXRVGf4jXV3lENuyrrvCEdifHFrI182vyUXW2B4Q56I9sGO5CghKrhW+8EFp6U+Vliol8Ma5j26+
zI/nzBjSUiYdnFlH3wgUS6pSZqBgcXPg/5ehuTg4X/mr/BJqKC2279oew+VTldIOVfsLCC1mzpUH
2yegmsxdgap1PckygWAb6Y8p+HjCw4ADhzaXKflzkgrQSaN92A/0w4W0xRg2/kGeuOQY8VV0bq0a
eyc61N7OJKFNrL0Um7Cn2jN1x70Nr3e7NRWhFfc8GWfv5/6xEfxvRPgo4FN6WmkRajxd9Ubr5X81
b3sdU2meNO6LX5rQ6kRH2MDYiLbOrGDZYSd8dfkRQDeOVv1obpOI/vNAgemIHLpFdBByBjlaXwkC
qfM4+HtuB+WmM37d8jYUm+Vxc9+8+bzhUND0zO+VSYA6CvYqlJjIdFCM8lbgQ6JmazN/7oIRHUJS
reF7f3fqlhpjmUAZBDJINn4kSqD6DJLVDvMWHG7Kzvs9UZjWFvGCuVNcQtJ6DQ94E3jdFjP0OUUI
t69NL3ceE2+uKfnSnulJwfF52fUk7kaouidK+uIsna8akLDgM5BHwHe4ZI6tszpmPr2XCjZS56b/
5d4QDgY4rtFufEaj/CIXe3cn0taOuOO9r/QTaKlXbP/xKIdl+xf1fyZbD+xlhw/wVmeqmWBic4GC
gNQ2OvRaPQOuAnkrnR4vgm9bPuyrYKPvtI4T07Vzb/4BbAbImo/5diiJ6JvJgNkpj8bvf5nwxK/D
+T+kEr10530P0EhMSZJv0EAENBJQLYmU4dJOuyHLQI74D28OI51En9hhlwSBldsO7mpNTOAKBWX6
ggb5vjVxkr4CzQabV0ZwH8CVYTb4ITmkK9tadc5ibmueLcR5CG839LzoNzYS8hyWjpViUwu3Qolt
RCtLa6iH/8vqp9jPOPXwFvR3EXaOc7loiqUuKRAvwqVDn2ouI4ufO2furJjoM7WaiyJajwdBiuKZ
FCSq5YnxqDx8xuNe+01uxUZmhimdz5T8Usq+J7ToatiFo+y/36z0Ho8TbkaontYqfJclhOtTvV6n
ZvPBKKhJjrOEcS+/n7zqfkikP7SuqH9HT/l1chfnvUYgupczNqW2rGOMd9aer/GdU5LS0SRP+MCQ
YD//zwuu46NXLqX0dTpUDPxHtFJaV6RAfN9I7xKrf6EZopd0fuA2updAWK4XgNbrjPhvrqSzYjZd
mKdkPaCFph6+uZ3kEkHlzZd7zESTdE9HzJL37/8hNG6DxQ/WeuVxcFJrZ5mjC5DyOPJsOAM3wff+
FCbOjHD6j6DiTkWiKvXvwHVF7ksg763EPDxPcoak0ZcAJeRT4gmUTizgk5OtVEdCkJJwPUI1L0OZ
78w0tXpwytLYNJA3oHAn0WO+yFTnFD1PXjU6kncXq9iPxMJeIvn2OKgHI5fNYFbMQIWjvr7AgB6g
8UeOspG3hCwzb8FIAduYE0CEdGcsMLC2lRlV4v/6kt35+QK/XGfBHBzaxDXuT11/HXG7j8BC9dfV
2QeoZPzqA51QtrciIEfgfNOLcNwc1+MSIfvJL5vIhFC2/vK7mmESwb0ePqe9nmtEIhjyZbJrX04B
MGwqrLbSwuaCLFOTTTcQekMyxcTBsBrw5dxRIJ+Ru+z5Um2gKsbvfu8O5fHVdhDUkBSYnUEil5To
xt4zR4waHrkU1LdJyAXQG15buSSYi3akezZOEKGbixxSVwoOEqWe7J6uqFlZES/hK5+itKn/1Odk
oXoiFTQkxksIs/OcG4aFRGTd2Wf5VqGmbwzbHlVhK/jUHYUAOCYxkHZELeJvojaM7NxRTML9dGRZ
fRRKXNQ1ZN/YrGm5tBS4FoieJVTYvU34fdfXlo8Z5R+bF2aXd5U2o5ZS4dkveOxnLPPJ5iWn5D8B
jvpBTjjrGIG82Jw4XCsRbdvoFcxyQgv43fYxKhaUNzwjiZ5gxI8LuYvjizt4SizSI7I6AIvaX30R
dTouq4+N2otMJyCE2z8iHzHSAsTHSr2PUETwOzCMRsHlIsoKsPgTZCO0WCsSNQOarAagx8tDkCou
q9Xqlnv/ugXCLFqkaIjfOfNJjmncflSUg1k3xvTNFJTrgblkWZ/Jnt7+7pEZSLlTiLykdSLbK1Cu
JVZBjFHT0rfByrWZgXkv538zJTJo3VK8MiA/yqto1kV41fX0Ri+FXojXpYakjLi864CiAeeisk7o
Q0cZqQ0Olroz+uVHLpJGKPW4wNEV5ef0JLenKLrd/SjQFUCU5hcLOtMyCdxnoU8klbDiwmAFFoCJ
bq7rTfuqLY9GhZg9WTZw3p8qnKtEFyOqe45IZH5o9ptpK7WDHTRE6SW6rg7i8QEZGTAb6s2JZqtW
Od1oRboE599J7w8tkiv/aUxX/BxUX/JGK78fD2xkW5W2k2N5jA2WxfqHol2AAnnpDEvyuI0ptDDW
TbjT2Ogjvexu636TiPYHRCzs7QJDkt96PWa6ggtgAnMR/min656zOEeR6mrQt+7PEoQejkF/rVVT
99HJMBzsnWL0csm0H5jb5fow/mjW4FqrHvu+i142kYQp2Jrc0ZvR9b+DXMELNK1yTVVPyLhTx8pA
oHFf0c6slnHgzSbJcv7UM9lV3OHhBghB5sz1iF7kkjPA601zhF6fod2M5IPlRlPSXoEhqihNbLUs
BixI6T5a5XhyCh+J3rPXaXSO5O4ORyoVtTWtxIziYVshIqmlsjnt+0LnkOg++0JSuNYdddeXzifX
yU49gGJiTVXvNnKtPlNZV5TLCgg7/TnkD1KnbtIdN/SG6PaIgrHIdl/3jUFp7B469zF5C7KWeLsV
5ZYUfLzREWldxHV32HupHrcODKfH00XBERh6z4Kfnl4YC2earyzMn6TAPys87TCxbtRQhtMWkv4p
1kgNxS1Hjx4jhSfe5MKstaJWs6Ak65MGNwoXeCf+bKULXyqWvVq9QoaJyR37L+Yq8vY1u93dscNO
I32+aqOUk7R0YW7MK98RDC17HY4Z7pecYGNwXUoyks0FN6ntxf3hDy2fmDasfC8rtcGOcXgKXwm6
nnZrxBJcOmPBIa2RPvwfoQvr/E2MN5QWXPyfeMqDoRo53EboxYHzLysjUxDXNUyzM/t/5dD0dtvr
Kc6d0e3ep2U/zj3B/IXYCr9J+5RYBnY+c2TCXppHTXVb2rV0JejEY57PzIMZQDkPrDyEO3pPIeuV
k7ZGZyTHJxiQMLt3tb1Cc1w/iX9yf0MdD09zR88BN9oE6okCFFEvUq9KvN/ZraZsZ8kdirRsTrsK
wS7jXxrHTP1wxzsNQKOFFY5nFPlikkpdenhAEWsX2gz6hVHiEEj2i6hnLD/PZEu3P3lo32ZLQ71V
3NQ5ITfEhsIgxpoy6FZ0g9cc593ufnkPuhw9BA1at9mPyPdO8eYpdxam11OFWdtmPl3SRQBblvuE
jGOATvieeFZH99SNizG6w21MeaTheSu8HxrrV2LwadHU+drvqQvOLGWnFlib8w888Re2f9vgAte3
TZLdENk1eeVniFvtCr/ytBL69vyejVgVxdUJuk7C55f3u/Gl23YAQjzsclhOaiyGIjBExyyemdPy
1PcQkwV6aoce31RDpzI/wOWW5WNqVNAn9oQBnPN5IW3t0SlYeL5vPU30cDj5Sjxdm5kYcYn8sCwz
XLGNhpq2fRSqos5X6A7QwpWFLox8PdmvB1NvR37EN97bj7BAso8r2sig890RlGiKFiud535wrkGD
zbHAyevff6CTIHODlDd6vnIcA7Vw3K/BLIYYqsU2UTlUHyYeSB+ZTtF4HaQPU5HDLkswodgLf6qT
kTcPTl1zKwugdQek4++T2V91QbbliNoELeMaC3PkH5K+a1qs+TTxpifAsUgTQyMv+UCt59yNN+tx
p0DM2ol+LFPNsp+I1vRUr+EHKamxLNyYaLmRN+L42Z4r8CXzKt4ImyO1oFPyh1Lgs1D2o6R4HoyQ
GTyH1y+kLWNBsWygNnzSzB4EtWd82Z/MpXzEoItArOWr2wQ2DxDyZMXVV86RQeIjzz62Vk2pouHc
IMiMSEVp/p9k9zZ3n6aqod9T143+WPTWUjmD+HuNnuEN0sUvPJK3Fm/y07nHsmL8o5C9Qcjj5XFy
an3vng/HiInJePIZ4CQLADq0dHqHZcZ3S1XFst1Jx+wMLBwdx5ADpn2yPmsPFRFpoclH4+IMAWwK
QudnPC2MvaM6wy7cpXEsH0DH8N/8AHMvsC1JBgD2qPReWeVxgSW6JdNVBZOmekAKtzsBomoelCy/
34f3AJkhzfdWOHqrVANe+bkCv4s1rYTYuxVNiW9Q1NijOTPMcmAX/xZpMdPWNMWH32csOL0ubrKn
zV6Xc+7avftYDyuZHStXkaZdsnWVAO63AaI8vKtnz2/hUbfLSbEvZdoE+jukZWSQ8wmJU7vRGBYy
gvv9XW17sOnsq0gLPzsHz7T2qjicYmEY8iaJmLlCfcCtb5mEDN8yF37zEx2GSQ0DeLjsb2untmYe
WuRLTSIoTCxrhwbckjOrkV8ZQ5P7Cl8vnRzr9Yd+cd1EMLK6QTGQCCpEWUJRpoFkwBp2VXGQOX5x
s5DLi175o3zY5NjYRoP+qTjwho5yMZn79dlis96aneVX6dME2RDHi0rCVKZdKf4t/rWvkvqXlUzC
OQjHdLKKLbDPbuvbq8GDBADbFro19aRHwPVDGTw6r1UpvyzHN7LGkXKGi2zA4f7FDS3lr1X1Ug8/
9ycF0ZCqBdG4pyRD8s0rPEJmOiqrFumI/YTaYvjCWuP9u9CsDIJ8pmNiHBUXDuXd2Tu2TitbZPFN
qu3MKfSE4sOhiYqkg16muf06V8gEaaB/5JW0cK6spsEobHXdjApPrEpbilteVLDdgptsTYbt3Dkb
llB5bkbguCF6QHDzK1IHDkjAUA+YPneFE2z7wBVc0AeXU/Fy/vGX5WUtgUwwttND3Yw3GsWZcNyp
hkMr+iRzua2Vr+xaRWgPr4U4LSrxyVujxWRMhmukVO25m5tf3fsrRJRtGeVW/A87U0O4wvl3JSu2
QgkxESIyRUBzuOQdHc55pIzKzOiHIVoH0FPapSkmUcRrPCLyjWnlnUJATvgtGJCeC4jkZEwf6JbQ
QJMnbaXUhffg3QRsDBE1vtgJbfIkgZSwykbgbSzBsUQhFFejkp7emAMp5+mslQFzisyHYH4bwb0+
O2eNEXMOUKDjkab6wJd3NUvWVJHjZhrFk4M6X5Gkqj1LEXEAWLpCEkqEu0tCUrfe16Qu59q95nwu
ar1x7WxiCL4EAd4JSvADpSR415nBlncQ0U0Cn3tOZqfQi5ClldxSZWzTivtjbZXD4+09DmadTgj1
1H08BS3xrcN2B8MvW05Wt8Vb1Gs30wY02+q0zRcjsxrGPm/YIDo5MfsIFb7+m03ygbEJ5bOE1oPt
RFTGlmPjYFfyd4DB6Cl6IYmnokBZHA5JB6WtpRpeyXAe4SEU1kSbukbwMS4heEIHy9uRznRWLIap
7SiRZizYhd5glOBOdFibQLV4GZHSXuwTLodbWYT0NhK64ShyAiYDLENagRDalBVbq1x0Ah7j2Kci
6GqPphgA68Vnvp8pKg/EL5ScZmtoHQmievO97a6vYR4gbvRJ5HXmbauUJxt4sBO67+AnxJYx/Upa
XnUdb65ueQOeHjZlZaec05PAizC2RCwI+7H/5UDfJnOjdbhG52yKRD+FWPNYiY5+Hh/NOfq30Knh
WWzsEXXLAH2lMB82WSzzCf7ypA8fl/ph2QnC1xBEmPlmfYJqid8U5LxaFZoktFeYxY6KFaQZHI7t
XaXyr1203AfIDq66uajkIVZggaF7Imgsk8LSBcbkQhQyJKsn/DoWPUQZ4F8iub15nBNowSXfVqDd
nceBBDdzFLAshDQkfoOdHSe+Klz02BPu8Kp4x10icRzYQXA5frHJLweDWdFYOfRz/+cR3BenJXsA
XGzs776S1bpciP+ziSJjQcKfkwshfS4TbUZT4wfq0de3XfRhXIh4c4NxQS3zkmQBnltjARiQpPHv
1SDCO7P6BLOqMyb+Lrq/ADrJf3efaz7gyiaUHPtKRe8Rl76Md77knnCURHtoy3n+9rl92wEF8ROq
Fhr84gWh6pm5EvWTZvT+lciyryMDee/wcLI8QesnewxjROB+gD/bj6SQwyGk0K7mD1zOzLmEmmjg
DfwEyUlgbAhVhMnHZB/tBmOZHgFK4guAGg0oR8hyF8Jd2rSte55PoxfOmB+PEFDt+uijAPxgXBjg
QibHyJw5qlnE2LA81QFLY4i1kgur347EqtkCUoh05ETxKLCtVZw8MqeMyIcIiuWQirPtB9uRryxF
evwE7tSMurNudjH2c4P9uEE9JofX/nxv3cG6tYijrE984yJvp6683RrjKKybrCrsCySVvJbOmZkC
FwQq+ExhjTJ3lwK7ySCo4cxGgSLfP5V9R7GM/Cvcy5idPZv+NsBffLyTY67m26dcRJwhIPAFYT8v
pchfNpNsrUrx+UKYIWrLhGxkdDFfXMHOezi5xkgGwuRrfR7UZkzFKvCgsGkcnmCvRX6Fl/Yucewv
s8whvAbAZReAe+njBy2khU1nQB40JzBX1+3B1AKS3zyMzsA3AH2XqMEwPcz+xACOJVLS6WAdHbvH
cqgLIaOYCmVywS+KhSXROdSvzimUXxyLZCTQNaYtjtAd97zP41+7fFJKnWckT2GQ5z8BT4dkdy3d
FiTEZEWGHNftAp29Mx9THJ5lRZl+1zaXfus3x9sgbuJ/VqjFis9XCA/rCGDJ8JKevwLjrCMcxrRL
+aZsBslzry68pshu35ZRCvqqUPds6QB11QO8nP0pZxvzNmuONAUw2+l5e+uHQlgQnY8fwv/bsitC
LWO1K16Aau1vAsTec0cqY8cQBRK/tzhMzDAd2XGrO8IDhukVH8koS1Kx6PT5c9dRQPq3IVDAxRFf
ogrG/HViZ2Y/Tn3pldp5afX/r2IDXljStKIzaU1Xvsmn2uElrkKyBvVErJOs/S13HZC8orY8VC6H
y2oEhFc6/OUqA44UXzvO90Jwfm699lhyd/zainBy6ig+Sw034mEZYICEQpxBwe31gmmDgrXZO7TD
Q5Gd6aDvAjYY85Ovkj0f3lQAfjGX6KioJnmAU52xL6Rqgk5YSyTVn43NO2+Tmiz5FGu7yql2+wFq
Bbs/jPXJkv93NCjd2pHYpYg4+kYhQzmAwQ9fxTTducAx8ik9IGmqsdQXIqoypGm5fLJVv2uAHIiJ
LcQxInwDD4QN0/uoQvj6gtyGtY979zHkxrQRPINiHRGImhYt2M6Qr4T3Grx4adxNDZefotbcKBCT
zARChsMjhz33r1+/1wR7Kt91ec+6xGZrkJhtUSPj/00VyDaGOZ9UQ3SoW6cJZHX/aBkCXf2Kpq8W
U5Rwiy6dQKSquBpCkjzUnlXovnREfeWuOSxAjCsb2eAmIkW8H2QIlDZqC3+Oe3NLXRFy9xjEySCS
3ru/N4Yp9H6X240ITZQtaiyItyYNffVjYcdHbPuKRn3vR27Zvbv5+Hp+1SD9Yj8Rw7roB7yfWtXp
JZVDSuDvMeRRkTprCOi7w78Cg/h6d8d628x2J07EKXfkEo1ySVz9ic0xb2pPSZmqs7/gcwNjowIK
KpOCv7qvHtJWU0aWmSshfgz4QZk0e9jiOyAVJg5qxAcAxl4XjCGa6tajGkc8HOqmfQtbKw3xNJWK
cRnbcYXr2eB3FokOFi2C3S6F6ZM/yzbza8Kyhze94z1KQOhZN84TVakv92J2PUUX/QLC/LDU4DMe
cNMncDQOSNfTwZbcec/gfeZATnhwRq79fGKqEUFlH9ti58jIC5uuY7w7xPwBeroUX4RpqsX2hTNH
bRUyflriBv24Mvsr5uJnnQjQ5sawzFccNlNmIMeMNDxwsNGDek5QHkC5cIQJ8r2yhoqu+HAzh0pV
iQSuQ8/0E7qzYcKS8+s60eKqwPWXvQYJzQMlS7aaw5vFkQHGsoMSrNPlXrSQwqOf2Xyjg3ATB45K
z0ziQDSRIt08SLk9Z6JySPETfSN6cgROkgG4w+b2lT9bnqK0j7fSdXHaPfEg8/T4HUxzSB3QoaqR
MxdJl/qKxP9VkjNuFbbPzn/ZnyyZ4ZpPczP/ifnNuNTKcwvP2q9fz1hR3NlLE6Atq/ze88YeqTuk
0X/3vCvI7skSjh+moa2PQkeLRcURqjH0KvzJ9J5t7dY6V5hQFMrQEzMbCgUglw8BAxbrxyCCVupE
KPKoW2q14X3t/th3nKEqfwu3LxVXfYUTW6LKLArr75YptJijoORrWubYutAc5L7GgdQrUduRgBat
mAXEyaEoRWxMIBZMGjBM+SwmhEpoF5EE5vFz0h4YtwcSHTrpD1WeZL/EaCVLgLLvw+OhmnnFeBdp
3ktLGHobNTO813M61Hyl7fIu/Jcm+GiFdpMII+XhFEDSPmBvDfNG2Bk1zYc01zB4AEUxcDPnEHiI
rpR4wdOVtNRGR8OHhkloMUABoxtj9/HyJN3Wej7k6TywxL6OXW5acn2TxcFhy8gPGCc8mEUkFUoc
Xl0XnPd32ar1xqChxzHyDAO2gxrbtDVq0+hzLLbIwndMTchtWx2XKfP2ZhA2XE0145XD8qVeXqJY
J5+cq/qSafzS381HogtARCfwD0/dFa6hc0SSeYJ3GVR9Z9L2y9BiEf6DcT6pDOGM/bLprwJoijBf
s5uDSwBsbpqevUbyix/F9o0WNyuUGUoFJ4X+BcohWW3Jx+jmfmtEMWQicP9gmUHdLG2duJBeog7s
gV8wnOJP2l/h/LGozLCg/KbGwIVDgjJBnf+mxQajZTGeKv+KnER+vZ0wE8ShJgms7j+wBZG6WiI8
hpXiONrWRvBylmCAHixvTvTMu8FJG+VXWz4m7D9tT4T0C5/2kNVwuYN/5ulspNlxegwEUaOmG6oU
68qqitfDZ4ZlxSIC27I7U1oprFRp9+f3j4v0WbeLYmFpGzAij82pJ27/oKgodmhirfm32fe3km39
amkthxVFvZfqq5au5+wZYUyYj4E2zFJNKssM52W4Hx4L+GIrz3aQVFwvjJH2FvF+O+2Ww0pMpz4N
mZCfpF7fYSs8unUyaiDmHVkpLchJAL8FLRna2hMuN08nBjfcC7ePQ9UXn06mwCkHLGZXuhqMXUnL
OIXIpHIvf9aBp0R3S0jzomwNxts9gMNMYvSION08w79ys8tYBIcgRAU9fITfsKPcw3B2aCvcmyHS
ViEZ3uObIiKeUd3f6b+bI0bo/Vg49PNDI3zwNtUYbBUi9Mb2Kr9Q+hixGF0UwzBwyYhjQ2qo7/Yd
6//gYM7Y24Y4SWyeDdYRjNUYPQXxhSefDYnMOiRplRRwKv9Lf8xmr+p5Rz1ZAO7tz72QEwvHBBU1
sKyxfqei8y6N+AhcSOHKzcXj7GtcPtzxza8R6BfqETEHubT9SwTLXB+LboqEeY45JddT1exSVu0y
j3bk2bPZGvwDRCM506S0rULyugUqsfRrJXmqT2qB2OswWt1FL+SV/3B3cHgMnKlWuGTFM0KkA2ap
9JvNL47wQXZXjXhWdx8gIY60yF6alWoxS4Ly8EluOt2E/ec3yNdIg7U1VXrn5aEnVEG1Gjteho4/
fW7+c03APZZiLQgrpyB6pjiWxKFSYI7MBb97OMOMv0sJFX+lk7TBzpV9jSEmYKRC/KBhldrUEO2I
xWpyhiEIGd6PlQuU/ONiqqVuggJthsS/okKUiq+FeoQM0d3jFJ/3Al4ui0u6GhrnKfsAOgjKdqXK
V7sKNfDAq/nVXbSQitL5/+rpBJjM+4hK9mdS/FoQCysPnumvEP+G3AjKsfYp2Rch1ayVrAR4lngo
4C4+I8AfFuS5qK+c6hDe8L4IPKV7CK6mHAU3M+3DpZIyUzLIr/q4BqhxRLFhK8pTRFV4xDyvp1cq
yTAT/8AluzewjlrOHKkp8AB9k6FSgETHhM26MrLCKtWKVVoLYuRevydCM0vGnMwx3mbLrGRwE/nd
jHlkWFjgD73OXjccg0a7JlqPvz49xbad7OR7Gij+jneIlGiLnv7bWMaELNU4BpeNR3jqQWYdMCn7
xDdMAMWuIXmG+pvW9WkEDWJHPGUyTYG6rCqJm51ii2o5sNpu7JLuexQZbd5NeLoEA5L83hKWzSqf
c5gt6wWven93NnGHfqjMj6IvGZqsTwExfkvhpDPRwR0ffgT8Qg8g5O1pAW3c2J7SHKtG1Oia9C2w
7VQvwIF9d9pP+OTu8sVphlIsDXGv3htbU1ZHHQExUck+iDMDqtpy/PPRFOzUAoODL83ZyeC1T6eY
YZeqXs6koptBuQohCK4p2nqS7aEfRG+Z+16m70p91yodKeXYMuID1a4xZDddnrOmbq8n22xW9Qtk
ktxzryxnKW+NAAeey8K6YPI76PjdSIr1WRHls3JbcHejTKqwFtKpTL1zxi+uhjarfxDJwRKA7iW5
on2cYqUuGWLOzugxZ9PVyGWhupQT8sC/YBYat6KValCKUnF3ZvWEYQJ0Igm0r/mM5irowgfuWwEG
TfE6StZtrWuMkeb+Z6OzCIzU2+urjCaRJ789K7GNU5upO9vMMbqJgmTdXhYE16QdK637oBSWL1vL
qkfptEkvWwrxPqNarUBF3/lbUqjDn1AwO0UDPme5f0lEgBK7NYsgm9fP9tGKwAbPUy+h9M6Rn4Pn
0FwtajA3l96yO2O4euL/hVyJEv5ciEksndWCaWIiICG2uiNacdmnd9Zj5GVP2McHpy1vPVwBoT0R
F7DiWr6zDIcvCrREad0IjAIxLDIcKfoWbpJgO8Ftz9RLGrRjaOnJFheCu5+tfmbCMtGXbNR7nyZj
beZkhvbg75f6sKlGiFTRgcX9xmgA8ew8XSQwP3AHs/9iVHGoUEgg19s2M39OeTh/vycgiq5LSBc1
RwhOWrJ3vgf5gjWMqozEc6STqX5uDm+sgcG4NOTgyZmGTh2v8VIwi/buUlAzM93xEa4meq5v9U86
lIozpu5/79bYB1kz+tPgrIS9lNlPYoW0jZ6z0biMS+OC8s709/5eI0GGZlo3XBD+3rNi8m0fKeaU
srPaGzZzv2D+1hwOYpmTitlD6kkQO/eD3Od6JHbtIL/kvVgf8ERbGFFD3AcfYUtLaCKEC4OEHm6G
KDO/2EhakFuNNqIWDSfVNOvgsUuPU0tXADnjWz493oQhs27eL7RgOA6ZaTrU74MaemgKK3EcP6Yl
GicooQ50bLVDqMmaOKaT6/vNSFHBUEcFPceImaCTJs4OfwAm99kvQfQtv3zrFDUXXlbu6Pho+c9Y
bjci8heSHAdaTJAH3z5G8npsARtoQNUGfs22YAvuPKf5/pdf2UahX18HCLt0XEJ6/nPsmA/Pjg9r
U9MQcJ08UEJUp11iRU/q9W70ysIgb68YNVAKmnqp1lVK1nK9UpZl9jkAu/CisZeh8rS21LCErmEK
zuBFYvdX+bYOGhn6CJEdhOsIpaT/PytEC5TmNtEXxtjMWVSc4nxBEARnA+IasGhRd3KKhLvgIFck
EDOZsZCqOaDOJKT+fJnclfeBV6Igcyajfafq/oniRI2VjPGzXk5xRHW2t49GQafrBovNcmZu17qA
Ob67E92+4aJy82dmr7NE8IIT9DnEmct/92pLI0aN4bZadaw9wxM0Bs1iInAR/N7PSkyzMFH280k6
2De6yxDgAdL5vIX73KEsKCFHQVIov2RJZvhMqvBZld0rzas3Z1IU+L7zcOc5E9H0+gvwuS2bsJMK
4g7QIWoLu1K7gnTzWxYvgVkcveh5ZnBNHFNFoXpupUOuxYuL9UJwa6THzucEEP12DXlv9JvTioZM
z93MHsD8Y2fu61fxkLRvgidhTq1L66NoxnhtFoHyabVsmID9Wc5n465zyXsILncIIOO4gVEAAZrE
Db2mXyIxtfTbild3V6ozdGuRMVlGChJgjGWezwBRQ1d8sZ2zDaMjqeZrf1IzQc5MMks74zyuGhNL
KuYGMm18Q5i35CboBMaApzNMgCwTHu3ZqyBU8z/FfK3aT1SMrSfWa9rxjF1ldMtO9hM/IWu8qXtX
YkAWcQ6+rf7E95SzK7UDjAsTSDqUhHjhoGdw9YUTho9sKxaw0uY9VGrCXwKAA2pjEIPJ6bvlEh8I
f96+QHUnc1dTDGJir8gMwCMFApulHUz6pMblGBZaeLr7+f5sbQyY7h3VoWmwOIcY4qikQPk9LGni
AidJ+IlzLgwvjJZ3UY6QL4yNs2qexLWcMFUb2gUr/WFM3z/1/07AZAuwqM/ehaMwub6qgNTnCWZd
lEqzrBnwl9knisuVQPwvgLUZrQ1fyOUSjzb6McAarxQ7z8vv4WWpXwvxBRUN6wBr1FVoiDVGT8UW
fIMienxtSW2PIHbzhBWz3oUO41oZXYhf/Dl4K95m1sUDlv/MPjJVXKhdUdwLefwQW0Zfff6nssAF
1SgBDUMd3bnOuWS507UNI+LlDHLb0tJXGiNAqorLOt7owoUefUMMdj5yAN5ZNJUNo93NmIcN3EgJ
Kv2De/5Frf1p5J3WddUup9k+4Ovszp6L0YBI3gng4C3Nyjo5d2tf+qni1b/E0R3uOX9IBMX4UDME
tjG6QZ75s09sBDZMOJgs2X6eg4aulav7zX942o1YS2/p3DHlM4NgvMUhYsQz7e+rQs/N7jZ/3Cib
J+ieS3aDezRLUTMUko7w+4Il1ReQmAf9FLBXDrOt3ZWuUKKJC79JH1R1Qr+6QbPhMFMrDwD/awWV
9XyuwtoziUVOzZkLqznAv2PqGqHdyN/cRMfO+r75ab+i6Ux5UGQh+qFkbLPzMLuWPWuG1xMX0oPd
1kMslEPzsNsgtC7Frgvn/IERgFuoYIu4NrgwkN0K52wGsd6hXy3WULg1U+Nt6KK3iw73tSnUG8dW
WUsfTkHIVVUWJ7KIhpwZZT7cDqxoXSDnyiiDj+/AjttJlhvVzscyF17P4kDJ2Uw3lDNqMKOOxF5/
L6QGnks2IG4c3wFcuVnuQoyT4CGPeyOZGfFX8MX0H9wepI89kCEAiyJHsgQrx8U2VnNx22FdEvHr
ffUPzQ7jte3QeRg1enOwZAAuj8bZngE+bwcdfiZ0COQhlC1i6g9GT5N8WHlq+Ifa7OORsWidlpjj
ZN57BtMGlVletyBaTy77ruYYrx2jXTIVWo8O6486S+fkFNVrGfmK9qdBZVptdoOf9dj26sag9NEl
G5vftQRaIishnJO1ZLDadDUXOaeg1KKlK4H11kAAaselJfixg05M+dWBlYGcvbOhaVG7ZqDM5Gje
m8KGXInpyeyJ5eTmuT6u3rFZeJyQG3HeZIS+Lh4a5JmtUtWdwIAUsGj22sRB5y95UIsvVsaDygYm
4m/1Z6SvxAJrIpPD8ldq4rX/vctlGvdTSnmBOOupQqbAfZGSs8YC4WpeOwjfknt8s8O/6Jti/SsJ
ob0lbNdbUpybcaKPR8wqv7UiSNTZRIaFAbdRw/cTddgm3TqhXiriExO80CRIWLPPnXg/JzJINweG
0Uq+qmY6Hio4i9H3a9FIsHMOHahyUvll/rCsjWJ804qbP9+kVUUNHAmdrR5U9oY5HoR1tnBYKOWT
KFrJf3k6m8LN4DtZLIe4FXTha9dHsOPvYVz0wtHuiLUuIR7g6AMWTHnFIRIC6ICaqgIidNrhmW3A
PMJAIT8AggTomfT3cAEJ9gb1C1P4ctgnhwuOcbEJ1L8kD5egp2UI26Y9v4YEXjeARq5T7Og5OVwk
sskIzZhj2Y82YdZT5w0Ud+ZQ7E5A3HH8W7RwzR2MdBqcEGouEz1WDQx7toKpU7dGCmNMMSKSGlzA
BlH733d74I11U392QZ+EWZyCNHgro/Xoeo2LgxJuNzvnG4/Fc0MJY9jla39c2NbCTkQ2ufxdrgXP
FfyQAZIyMOdv7WpKyJ5GNG7PURxqEh8JYlAmx0QxGsm/aXHV0YA8xzDnSp9W0NJZQvgtqgBikMC2
Jfb0EPq3bZ69+PEdQ6esy3Gvl7gx2BdmMrBnXYtcw8hwQ4/pn6bxJH4ZpRZsSgQfw3tRapRs3zcC
+QCVgBmWXW3nEzolTOHcoD7NVl3qfItoBKiWOQ4z3OM8/hK0gy+WPNOR8tFQD1W+cnUM/f150fYw
7ho7FW1SPGBNJAf2SfXAk//v2S335puTc6xm15o74K75cr64ri8kPOLBsaMd8oS6+dRxs9u+nhi5
tOEF5MBijW7fJe6Ob76rQuLaTia3eAOZqGvym2mk1hfaafb5CuiZ2uCesQ1+yKQA9neOBtRXPq0y
IPJ7AwbOgVy7iOhSChjE8kZKJM0M7/LgBezFHzE4ga1CH7OUaIwOi3GWIRexDcDN9cbeMxJgEqVw
Ntn0J4fX3E7un6cHthOIcYnujs/UbZNNIpob6X0sqee7fP6x2qPijfab1syf1vejQ4+gR7Xqo8R5
jBikIaBI+A4mS2xJsaIaLJx3Q0lmVB6Q1XbFiPAAV5zY19BngUvKbW8sRdiFoTIdTdysfzxm1Wno
C4O/w24eMCgDrxleitCJCxCUN2fSRrFp0YPOGKKkxF556zwzRNV6h3uFYEOKFSH4QMc96KzTp1is
vCb+D0uZ3IlpX00NE1bxlEfGEn+iEhSPjsfBEmw1+wTZ7HUjsdjFeh/Ahy8rxVyKYZguN2Pj0k2o
hFFWfUkNVTCXDvqvL5ZpLqo+qtrtA89GtTcViV18Bww04zFMoYlYQgXYrVRjqMbjHR91azoCw22J
o5sFEj/tIYYSTT1OVPujegqeOkBxcxgDAH5aM95b/xt6hy5AdcqvpU6lxUAZFZxCSxnAQp3KWyMK
gqkpXEWmCLYY/hzsJSfUa+eMe+N7U5SHVeMojyekpAwkFZzxLKDAz+WDIhx5ij1Rz2ms5MVZgqYJ
/NJt74+CUC5UVbX8mHtVDYV8R5RR+GF4T3ObT+NzJJrF5dPvNz0NU/3jH89Ep/HQfDkZkWh9BcFE
dLoVSuhLr4yIPmsYES30fC8ACNTc3VSlZcQD6P67phWsL+7EwYNn1WCSVVzvRpdgGOoXnlTQMSAZ
Tf1p253svPn9+aeV+crxwXSOrEG6aqWcafwuepkij/h181MY3YHv/o1qiWBkEPX8cqOppD44fCR/
8pr8OxXjk6GPXtBSAzf6KfeZDJzNf4lD7eWLWF3T4L7pjY2se675AjX6YQfJmnODltIuEYGdvarN
a7ZnxT4mlDbHazTZ4Asg8p9eryHDeLGMoVBcDHoJ1aDFWSkZd9TMEs9GoWLtDVLwi1jfJAYFVmZl
V5/EE/8wwy3rIWYPhjZxI0KxWiY/uNcbsZ3oKiOe/NeqyAtZHncOZRie6mNBwSxm5EFhA4Q1YCcm
Sx20c/nG+ypZkOsiAs5pMQrbWZT3UC4/nzhoKULYNSg5YF4BBmfB4QfXg2sX2358CuWOX9t4tslr
D29YDFjcwbF66sGxJX4JwvHfcfuRv43R4emskK3KTp1Cze6XDWJu+dhPsMrL8Ojlp4FmDN4bl+sJ
+6Njdx4h6Dxfkk6faWyFGj14M/eB1dl7AwDWY/zSH7s7deC8h5PtMLFsGiHR6t3fudFtD4wWxRNV
Z8egah0Y9X+0qpXIn6MryA9muQLwGkbqjkwlcr4Zkpp3wp65X6l4QUDOJ0l5OpNwEg5VXJllqFF9
8N8ZzcfONF3iwf+wn5c+lLh3LJy/U4lEGH2SMz8tAxMOGRv5TAFcOdWjneyeZoJJ6cmEuhlEyu+J
6j6AKrz/zShCh5AXunlkKuVkkxSzp5gFxbtYlq3EuEMDWjPUVn79NjgMfjsG4twxU0ljwvT35F1W
D6jueqNis9LJH2s6E5c2HBQu6/8/9oma0/LRcb91j+kpUBCzFcgynQkxITlT5WALt2XTidSbBzO/
SmHIKXlxFiy6ZIANx1jlK2k4iiyOL7lJ8xm7XzOG0TCDeuvbWFQjpLD5ImIFR2lJ7M9vy08Sovsi
hlox8UZEBGhxyJzkkXylhLti+tA9qODjmQ4bJv5zakyn0y9z3srA8/z8CnsTBsWL8UM8tOznacaQ
wpinQdUH7NXa98E6gsSGOeomXvGl+OKQRV+PWgrzjV7hfbiXMmIzuqTqIUf4TCMWPrFJMIUmVC8Y
+iVF+pGFxyhwT+YQqtZYp+MKcxYQp5gePqePhEqveqBrEeV9V6oM4xYAm8waaXZ4dcb6O0q2PADs
5YZqRo0Am9b8hoerZ1n/hpTCBBzJ640QhdreQUTCDjp8QIWp/Md2+Xk8lmVPmeuULIgLlZu61EkY
NECquAHVqioda9YuDQkHOMmeCzLQQVARYUA0WjHwnBKKu26eo2cIOPjwA552NmTVorIoQrT6AuMs
0VYXHD4PKi5+pWi2oB/FOCY4Gr0zvi8ZaHOVpQxsjFnwdHbkflfhv0tx/wqCrUEVqDom8jINSa2w
ym5/Atuz4yFZlwowDMoGh4BEOqcUXYY183qvJmgWL0MUVl6cUCicw2z+tn73/BGzQOLnplVPjL8w
4N0E/re7feSVLRhDrdmBjHiPOHy5pjbEzPpZhGiT3JxeuJsMoczbiJClNfZreLwinIAfkIJA245O
/UXYrGHBbnvrzyq/jn5Ix6xUiS4fiB741U1e9vkW0B9gv44gIKjjAqnYQ4sZLtfipqPdNT9BikCh
7fishmb92wJpjKORHwyvOqHuIifIaKJvGC6j/U2k2UbQlOucA6qXJEKFdRw7oGlDXPJueNT3TwlG
fFOWl+mkQv8KV3nFYWVRjgcDLejDgtpudYbhtThxC9YO72uS5Ke9UNTPcONopzl2I78E7wY8iNTT
1683w0f+X7S8xJqy4QCvyHcrvPO70oKNkIV3V/+mvTRexl1d6uhgxM+gJOtwstRJLm/qyk1it+TM
i4D+jx/dCEZLBdCl0bvZDsm/6SGvHry++CR3PS9eIx7qwdA0Mmpw1RThZZzeLJ14OKB3kcvHjaxc
iREA1956nTYmel7tGpN3A+kVSvRfzjYHTPFv9QGTEsm3ju5LtWqR6y4dV58frFTmr+wleciNAudy
r1SyAM0/OtXdSSaDyIt4qbX0hxQzSyhhlT3owmb+HsW9MDdgJf06dz/tde0J0RHi8lEROoWxlsAk
RfElf9P/M4xYVEHRd7OwcWaaatvLTeYe5qda4ZQnUCmIGhODlQlKwgJCo9U7k1XvKR2txGGn/Wcl
j0dSWLGMDrGYDzFB/gUaK7jWjUy5I3Xo+r930pDptSWV8kfa+FSD/IWCTbsXtw2NYcGRKeihBkqk
v2+izyIDUJ7ldErKtFvvaWrshfvlPrGfif745Y9/istX7SXlkhH6o3iipt/E/m5lcoPlQGzXT3jV
C2qsxOuJiU1IoHiqTr1e1rrQqe41nlWyYnwdy/4eIfcdl3wDloiWCagusJXCcim13lvdHa5REYoT
vhP0Zr5Jv9hWhY47jcm/tuq5krsgxkMAsz0+QQkoztL2UbFCyrmdy/n3TfF4MsZ3jrBwF+ur3C7e
XSFxhC5EH0sgcegR8afR+1pcB96b6ctj6s5bg876pKAUrHWEnUan/KaORRoD3QjSWD1QRFL2sP1Y
tEo6uSJVsCwy0s0NOmODPMUJ2ppmK+6YO1+wy0sVvgxwzY27gIo1EYrzhCobI3H8Dy/ex/fyiET1
uAuHJitWrOlxfudgalMfgxlq1QP69isVrk4uK6BohANKO8ngR4wITXJof+zn7vVVKG+0GEM6BD8C
/zUggZ+IJFt85F8le3cf2BKULPc/1dSBduRV9B8peH1jfDj/FjiXW630vWU9ujwSIpgzV1qsx0s2
+RXepjskDwVwSYnqoGDkk15sTW15YL0lm0B/a+dMoCAdCrDwGBhEjmzqV2GqEU9ABBoCAR60oPtD
T8pOloFkNS6sYDNWs+2s/C0sCMT10r/+Z3POfv/HWGIZLWPFD4VFperplw/fikSSAEr9vQnYWUpB
JD4cVklxv98fIYacENYLNpYiGiljD0+g0FxupVhocZxjv9hew4cic3dFyAHd+8Pvcvnm+NOPDeFZ
LvnFef7hs/+g0SMcm0DiDYpTOR9iUghub0UDtQfIQmaodwzVI0H8OtlCRTLX5swkfBWImgAu801i
pnRr1xcezZISGO7ni8vJczRQPr+OLCJOxydgbMmZAkBxzifHgZXSKH+sU7lCzT2oGwLmBTDCdWMN
VYs0i6nCw5mf3qp5c/RC61V+Ia2jpXe8OeE99duhUdnQWU3i4iJF0jH+nZGT/IIKMq9NQ9En81zH
Vh8F0hqGA+51qEaO7hqTUu7jsK3gY7OxNc0aDORGMDtY6N6ZtvtNn0LqBUeulT8KFiljzQRs8pOE
BIlNisn5VjPfFlqweO2seHKCkWegrPSxf/kQwvgQj0J9ZKwtsLp6vZiVXEu0W5GTuwQvqxA0Qp+3
AkkynIzMrcdXJgjiDEtuekB6CLy9RzLZlWyoWLA0LdvnCrAL7YxPq+M+EReZg45v6JqMU7rTULv3
OMMNmmmCMX/fxa+gtHzpcZ1fJ4/sbPyNOnwIKF5sIf/UXkj+xBlG9OfJXiBGefR+SZgcR5ccuiYj
NhkGdllw8HPUlvrpwMW7G/KEH3uBiU4zIxD4rK3rbWXz2KNagsi7qys2prsSprUH7WVWSt7gAuC8
N6eGd4uKgIToyeT8gcWH7fUN9i9+AjVbu3thea1TCf0gTBVkTmfX4KxsTb3odvvvA1PF+pRs0bFQ
Q+Ro3DcSrtTqDe2pyNvgX2vzTKoBqtzQd4ZoxfyfCNNt+vaRTzJbFp64EUCjMr+GIwEJum20B0og
KOnPGYWIUfHUv/yy6kve4PASxPqF3U6rLfBn5GDwLPh8pimAsqmFk3sZ03QCAVOz7js3tcXsNXP1
wMW04IH3XSNToYrmHGlj28k3Wz/1O2BKrnRhEcA9KggYW8X5sEtTfmsZX6h4uXMXp+fbX+nDjKSY
uhHcQmCmjG0AEajWyogYmrEeGjAgDHkE4R8aRPPqA/px99NM7P59ik1wWMep7iEBrTR9QRz24T75
N6liBJhIHx0keX8l16yJJ4Bj16Bwb5cSilrMd4kBy9gtlVfcrvxdPrS0SC1ZLF2cPR9B2ezPyBrP
ZQpWYtHit4kXvdSdlG1hW2oQBv1vbpaVSNLKCKd88YHOFLH6QmmNgAIV+b6O+9/6bt9bg3ejgitt
WvGa2YCvUtCl4DfK1JWNzJg18lKdex5QjqkOQCDZVgSiKkpIdZKcdSWPaa5MNmX5+XvX4RZ+IafX
Xm6iWtmVkz/IeoLHNdTJ1r58QmAK7VPlvOINbD5NkaaPTOugr0D91CaTZimHBdt33ST16G9t3svP
58a/3eezv4z7k80Rw/1UiBhryGzNGFfPRmVA4+na7K1P8ttsV8tSjsAR6o/Jc77WNsw9W2UMB2kO
mcQyvQ56GiWh3sP8Avtsp2ReTWAIkhcvopiTu/+48tyVr2ZxQhk1ZLZZ1KAzO9/zMy/mizDKIDI1
xpPePoR1KnDQHXdMXKqkhlHDlq9AMrh0wP0E2uFpjh8aNG3kZfWqQRODdjZSjgrEM8vQftMawoRb
ZXz+yC9S2hU+vTB2iaHAQ/ujPfhyCOGXxcK7kNEtG4w+BkDKOZHgQK6PiW86VCx7DxUSmkCg9+En
5O++al2aizcGB5e2ZtNnsrAWxgYFAE1gXdlJhgfkaEuS5snYXYT3NMHcQiNliVSq9mmUQTUkrgKL
Nl7d9O+dD+Xo5mdRLffrgane1dHoue8t2m+fb4y28m1GMu28Qc4LC4FbI94s0tt480VL3C8I0HLc
UwkW+Vrz5HU8Kb9Iy7OYUxHmARgCpaYG76Ev3gPeZzDWwbmQWPXTwmSxGTkGZTxTYYDEhl08pBkz
YkUpVUQLVto1jzex7ICSs7Q3i2VJXYV8dUcGqsXadtdGTY6lr/HZulLGhN9jwrjX+kLGVpHKPyUN
Y6ZYMSLfZeuqmLl++h4wqbN71cYEfvQ8BKNzSp87yApwOavn6tHkCs3Db/OrC9zq7De8xdO8fMYX
EJExRDlmX3vE3/GvAjo1IMXDBP0ytBvagO0znyalyRIjhZqdnEw/l5c48vX5qD+xFNgbQlEOwSqn
CPfC6/xEaSG7dYwmGQjMoo/NxzufkXpLLULEqJD2G5QKDK8iRjLvfbxRew4iXJM9Vln7We4kr/ny
5kEJR0ivGfh5fxvYGPZIbp0a53IO356QPOdMmqEOZJPMcBx3/mxO/RZeQFLJImjw3qMF9KWcNt5f
/TKbUr1SjzGcmLfkaZVeBEz01HlLhyi+y/RcP6yaaoZpaxjrV3c9mxliEZTOfTwvjf7ogGhIj7ff
kzJlaeKwOp1Yuj8EIvUSFqqhludAhYtG3LDO0jlow5/7NqaFJjRTN26Jle4cqnT/+3yWDsvvMTax
bHwFu9ZgLl8GJ6AMIa+A4zufT/0/OOIyu2tzsxGp1EGT8HEcqTtSgs7Aa00E9eniRURKN4wcca+4
545ZZif4VBHrNLsmjaTs+ZsXu0kp+cAHIhzYXcGy0HD3bhuiYOqZw91SiI4mwIYkPrdYjBGTsWN8
/6eNqysbkjt9rKjkusAxJl1tjcL92FFQa7aq9l4Th0+Zfg5MomgVGaAzRHGTDwEEunwY9ib3DHDn
VPufv7pf9PAf23uANN92mCkUSTGGTR4efC3loeKd+oi1rlFbSCZlLwx+94t/nhw7BUyA0Qu9OT9W
XonKmWRRdtgeGty52r43YfrqztBbDiLPjrjX/T19oNmxev8C7yJU5aKWqZdWR9ceUzAFQLYgnOj6
1aBXob/hd2tpA9Vq9rmvpRSwFu7DjAKonXBpcZmKFAL1e1ME9fSnzl257uhAcl7qOBbg9Xraoivq
hhrjIHIK2s5fUq8r7ZclniRZZ+aT4x6CvhB6k9+ExEVtgww+FV6A3Wg6acCv7hGv4y2EozRO32qL
PX0cggCAQ3LOVWHh2ydTKuPmIxDYV261hnDBYtD65wcz1LWHNPKxkiGgo60jlZT6J+3/RU629gNX
xLgFjZxkmsWVBcw2vHvnPQK2t1nFeGZbavsWr7j7rCmgbAcfhnj/leQLswURT5UEjiPuv0c6CKU8
rfkSwQ1HvVUWE50SD1s+S2vEo7TkE8wnmji3E0oWF18exfZuwpuUaiHGFh7HXVzYOG5QsGs3i0qX
AAAfnJo9xblMfvzgSFitYK8ZuJW8j6SFjNJz9IwAkO9HF3le1Krh5dWwq06cI09xsRq/Ajp4cZbC
um+72sTqz9MWdgotzY5beWWxcjknjoD3FZzr8B4+xUHcOwIGsLKaqJX97iW/vfvhCZ8hwP+H7BvW
nMwl7Gv1dv4m47rGNNN01WVyOLn23FaAQLo9B1GIGA4D3GOYS7oxGaIpXrGzXFZpiaWVsiyAu3GQ
O+ngMPMNRoMiXKz7vVqx02wJP52+Li/z2Bm6SFLEyTK+FGPHnnAf73Eki/MBYx+btTwFEeT5chQk
7dKEQ31fgq6IIyxrvYg19SKMADUMqlOJVnh6eyMnk4NNxAsyvQ5sA0QZa5P7ELEpib5a1dg6V41C
B9462AyvOT1FIQS0LBEtTBuFvc1lh+/rtWpxgHZ56HjmkUbO25MMbVYiCFoZj4y30CAVNpb9eEGL
0od9mAHXGvW4QxTr9iD6Qme+Pk/MDJUuWOVV4vcADwGWrNTOCRbVz5oDASllkyDNnuPtqS1glf8u
RBVagMVY4fomSnTFSj4Te1+fCVTkWIlZt2zQmSQc1M2udk+rpNJDvaazNfVbr8HJvHto5rOxsOgd
EsyUcv4STxbmOUlpKg4EUSy4UgVzN/bH1fOc/gH+eItJ3w0KrojxKMbeGASLV0hQvjenMWcVvGG0
KhksNWBeU6wTg+evxkf93CVc1qyEBUssgOZuKhCeIrPDIcvMnVptItYaGLKW8ef5QFebn3oGBLh5
5VT0tvD0b18qcZ06XBgULGlhzLHQ55XysIcp07kDaJDzc6lFzbTpctkB3kcM1O2LL80D0238R2i7
O1BKSL004Yt3lr+D9qe8fwR9PdxUaNQt6XOdNXgFxORQnNigAESjnIkv7cnS8LrF90rIh6hK8gs9
zPqvba8KipoOIyjgxJnskKBZJJ6NAvpLeHTsLCpAZRwI9BYNeJkIdO5eKwvi8sLksyBBHscnmlmP
HH3MOyb+Mt4TQDhKRiW3oPN/AWs/zZP+BDNwEjGiSY7l2lF+jqpqcIsWeBjgMOOMwFyJk8sKLYoN
JJbymR/W02K0rNLokaRx5h+t1i7UfdIhm7+O0nFlqKpOWZxITvEgBUIOYUFy3LKS9ch+uDqa7jKR
cGUhGdBXQ5BPoL+WOkl8BYXN49Fr551oyOsyxIPyRyYOx8lFBlrqT3Md92ObPv+bY5itZgqRPAmT
gpo6g5txQQlf/sE9osvUSLpRPOfDdDoerZso31XAo1RJAAMUUOpT1azbRhs+g+x6UGoUqXgbc1r1
xZ9RKWMMdro3zZkhCXH9yu6h5DDhZoJILDNxKRvQyYRDmsvi8yPlHAMPslmjFTRwfC+G05EKiXX3
+EMOvIB8AicOYSgUAPgg2LgeRgv+iylD7N+qthiptYdMibuzeER1RkbnrJamrBPk47mtQPKyJTId
QjzDmtTsmHEHR6l6CcrSuiKVYJ1Rzr1Rja4h3TOX9Iz7yiftkZfzRD2Nm/aj6jTGDmNBnM53nRl7
CyLljsSdDTyoIUnm7q13pzx+4jg5zK22p3RgdMhCpzxeSC6/rBsVfaJbxL0CRfUa7EoEqRgSPXDQ
ZZB+Tp4dEZ0GsOxeSPBVme1SKLb5AAtbvJQ0FOxznCUICQELKiEnn6SXFJRBGxghZO15HSE/Sd6l
+uvmIHqGGcLh9RHWuLJrDUD1TDLNy/hdMju9+aRtGBL/nfokTbFs+QPxbvV+hTAQkeBcsb2Opwlg
9ykw+YhHDGusPZBxKlVROrCOPsczY+WZ+UVlEhyGfWtFJYMiLEjPlEevlKghcyEi4T2nHdM2F0/4
gu4QMtoPBFENgiRzMUvDHKK9mh8ZInDmaq9UOE9rP5j9jbtykWR2keogeoS6UhM8QYnyaIO6W5Fb
m4LXU/4ar3fAmZES99fcztQ8/nGFG6BVNkH0yywJ07AEuVAvLnv6KRXpeHO4WK4PpSp8tV4MM5Ic
EPS3bBkEhlsRM4Pothw0JeXqmukWuH2civwXCF8D5TInuF7bNbgoEYPvSsETlDr7dH/oPJ/f6mMO
C8CG0RYEbAUQUObWTP5DEZqV/4jDbW9rkIt+UaW8Jnni5bphHhXNY3Pq4NqOH0c8QevG9nxDK69e
wDNrDgQrKbSnaVul5klCunWisZwDdoFoRYsPrgMVNaHQPSDuhy3Ftjn9FsKhMJWWRV1zX81/hBzV
thyme/o/H4cenCkVLRlCZ9ObJk2pocSxS7xN9zLt0vqahCCG56JS8yaSzTSUKwctbFAr+p7nc137
+KeoJNfbefvQgwm/kDYoL1t3h7VoRGv/1QpHsQ2GuscxadbG9Q28dggh+FmqMbG7j4pCuQywQoM4
Z1oabVrv4k+CqEk2C5gvWaR+I7kkfLWjbm9bOjZtIXZda0WGp5yu4UQ3iMi/QLmQq2Vb6ue0erSA
4VPL2bksrb3IUj05sQbSPyvUY7vdtJTp4DitBwGOU8N5yYp+YS7okUVdAIzONvi8WIbth1rK3mwm
Ob0OXqoXi88YH7T0tfmHbRc1ediS5OhR8dB6IZPZ7JEzTnPro3MXtPrHOJV19qt0I19yJy/pnOoR
6XCki65ZMltUQIextrgTGUaW2GM3AuH2YUqby0o7IO+e1Y6nND+ViKCLXWnFmiCLVbQxdgFFe3JF
WpCvyhwqSyoWvb5gPNUWZJvmDAQDabHvaJuD/VcClbsCaZlM5PAl348SgMHm3U8htKrvzzEixslm
uAJgcAwlCxgxsRyCBsSgyawy3YBHDmKRpEZi5L6Ewm4RpHf3mpUeddG8Fz04X7NYiaRuvCCzQPTu
zhTvmB0/lFC8adlocYshNTpl30d64NQx1grvOhkVfkL4J3s1gyZGIXhhxZydCjvFH8TIRRo8Sg3J
wgXXAgWpuSB/2/DYMt+JxWrZuBzKZnzN9/rQU9SxVBVKxOfY6iGnQmBJzfwqmVLV2gY4o7OeBfXe
k8j0jxxYye1DLzsgIgOa7xPgaKR1au6VBqXS0BCCT2sWq0hRoLAEwTKJb6EJuaJM7iplk2T9lDFU
eHCHmZn4D3YjxU0owCSa80kC1PaR/49usQsBQ9RauONawxrUh38Dyc8KiRXLv1rmeMlTg8JPUHh1
ywmoCyYTzRIDQH8b41hebCyjvz2GivEZrO4I7jRDrXA9eoQwMGwmBWO5CL0oD4JHfKZjdcdQhVZW
ZQZ6NgfLLu7MyKTShTdR9G3mMDDlqR3w5y5j83wyPtGMkmObnwceZdNzxLueVRGwvgVCRwLH1HZL
HDgoOPTUmN0B61KFEgeWVHynG6g5ZJIj+lK2eX6mxPXxUczwjtmX/FTIUhGL3UPMafejxBoY88d4
NvGCotrST5CamX5pi+vGOStGM/WL4kB92cSn+Xq4IHXUDGSCKEiqrfg5nzX/LD0q0bjwOyPr3V/U
CfpSh1/xBMVePzoaBmEWzoUrW5HKVUUR8z1fQXcoCosQami1Y4/AmLhkEKL9bgvVTm82zu6n/AGK
6NXceypU1rxcokFR2PqXL6KVcRFxGwuI3xJRprYXslzrfoZstLwX/v+Ihor0CXGyvfcvZUIQx2tb
11vi6RMb2Mth/5D7uzileMBvxgwvPZCWHBtrhx0aX8Uk68hITeOCYX3vp+ugaAfd7VRWTdfX09vy
yLSwn4XEzABtCFyJUvG9pUXg96rqV4+hJn4pX+oVN3/ddxfvITBg7TKQTJ89z7J9N1yZlGpoHJ+v
PZcJe6sEBLVLaPCIf/yjhTUJdw68Nh1OrPusjItAQWp8yTB6DyWs/MWL+kujlQubdpqxzfhmi0yl
jPlzVVb9T+YwY6MVUVbHGTFelbHAACp7EXYoWnAqlVtWmQYYLAPqQ1JWoqVIBXYg04A5Wrdaln/k
vxSgOuQ8Apn/sweMotaNtk7K4k0rPEQ3UqFtYuzUZ4DM3t4aNsuqT9d0FlgZ7Myg8dGGdzRJVEGd
xD0FpTHlkgSzXFhPGLMdAcDfcjO/R2euhmXoMMflHTQjuWLhnSG1UQ5rCjvJLcx6ma3MEnPHbqBf
oAp6vIPi1UZA7JRnGEPKT6UoGnPMUpg2GRsyzGZsEbjcRZVzAAfy+m/gFksBklJ81EN2aFl6Iggf
gOeP/xhxKMfCNnamb4hzHcvMfKalYsSmty/3IN7YEAUEBT7G9mxHru2Qgv9Ww58huKjrFF6FkTs4
/gIGxmc/AlGCDtbvf8+CCYg3auyFcQ4G/XxpmexP4GeoQTbtdb/4O1/b+fMHrQrdi8JghoIzOmb0
F0u6EWRvEues4m2CZDiVIDIwRhHecXGvQrKuPiBpFZ7R+lPp4qwDbGeJEfUG0zLkjYGrxWpYqASj
TKdDE+8zCLKiR5kJvOM5Dfehnn9YGWfiP5i5jV1qXayRzhzjVTrKKKl4MChm9Gwkn37zt/4Kp9lG
s75ExH3kQKlie1rXDlOmV2yygqi5X24mlwy5wjY6f3ojz88P7BTXr8ezhJp+rEnPEhRVBDIh2OqN
CAsmJmfWAcgB4F6m+V757njLCVneY+Z7F6S9FNWITDE8+F0aLAZAgBttGqbOrhLWOezWIhBFvA+1
YfYKmYuWyHXwEOjkTQYCjsPUPDytwr7znfYse64QT2R42vyOjOgNtkI37EiGAF7DEWE8eMq08R8g
B50iqf4XmtEK2su+VN3mDM284gWtXaLfQ8G/AeTvKxKoFNlwh2XwQJCGbdiw0ITgp2ZV2iYyJk4O
Vc0XF2sRZ4CKdpneC9X5gasFsQZBmnx6Cbr8bPDiN805+kCV7aHenr/z9BGx1k7SSkHe0lCtoKrN
ZQe1dbjpCW9YHGcXF9VRS1vL8Uw0Ls6Ocy1sAK0/quAGsbxKO1iSkGGtO1ZKO7LQ+vrn2kf8T+rI
K4daWyxRGtbdN0ilFZOhJkY1uaRCvLbvoybCSr4HqkHfXe9BC1ULXrsuX3dUsz6uI3YYm0b9qAb8
+P1oZNRhI68XPqtbRzcNPtkmqIFa8EXDTmjmG3K42vBXsqV3LkWghTNQn6pP4Kti1O8QgPFbNZKN
vT92mcwgD7BtnWIv/Wy0kInSllHGqqKPiBUThNp8Abqj2Phzbs0yuoRS9EhQpgc3kMnwdfFwDiqr
Xksebj2/1wi2ijgbazil/QUh2sVcbxm1+fyHqMoUN0eEDHLwO/qYVJO85XloMfYPneD2jeR+9xWH
veRLNEmgOiHxRfXpm4Bz1rp5ok69XIqLFeBf6U+vjjBTExGKEGZhbAZ1LAsmoNWCyQagpM9pTuil
g+Pzc2xf1tXLamfeSHPT/POowCsQeY3YGpw6wWNORKWglp52iEf3xXK2J3+mPVmnY5iS2CjWlNYc
RmcfQbj9RAbaPa88hGvz0H/4I3XbwfV3Zva3aGe4n6zNQeESfSOHrPTHShvlPpIuE4NcE1eBKffH
RqGgkfEzfIFzmNFiVEY46FIc2SsKneQy1t04SXCmXJrkVDvbOWtT+vWlUXItNOlJqlGEB18BOWSi
hAz84GQLaqsYIj6FHq1UrZ9iuqTXJLZ0qQODLiATZBdS4NR5oDef0VCDT8zyGseejaSLQAvkCW4w
oBkwSW8EmIXgEMSu5NZuUWG/BCNcUCPHjoqIRur4CJvpyknzHU/qO4r1baLbJP2WdIXFiBeCCYdh
2pF3G/FvSXvGGE8alGWfoOfjWU3s04inL4X17mvp//0YDLwkQi76G+p3ljoXwEvjzKI9NUhC4cd/
7s/yFqZmTiOToeE5SjMfL224HhwrzWpoGjxgZ2IpHI/Xyx9YQv1v7iMQqW95RxUzPD9JNmeq3ICn
SKDK5/rLM5wdwYM10SxMV3Fm1Zkz3HyrUblX0njYFTxcKey12Ad46c8wIfrrVB6Gl4wyxheYbpU0
LjWptbMenYWhFJ+a/tN9drytLDO6isIVVZDyH+5FTcRkzq/HN81OveIU6m62MEml620ZsDPCf9RE
lUSbAyIhqzJqOoUzNE7gmN38QCyVgwJxh7ioXlELfgFRI+82XGd3LRPG08hZ63DjcgC1MyGGs+yS
/EEViUuVRCOxb1e1Ii1NQsSLYR/CZkyeZcjVo9VCIWhepEe4K4lmoHXVbAgvxlZTzxZSpqD1pK+f
LSMx6cnHbT6HOCclcrdwLZsmS0hdzpIB8WsPrJ1xnW+KSUMZLxvXp0/2bfvUCU4yQXtwMu6NUjer
Ugg20lYDsF+stOBp1URt/Mz02nqvOowGYK+dwLpBModrk4KcwXhxh4SN91GRQ0ESCPbk4NAf3O7U
Nyb45qaNUJuyg7WTBOOGeiEOu0Gn3zmOYE1UlmQXY2E04HC6N54zZAf7qTrJLBuiAY9+nhYSZSKu
pR4Vqkm1n+zmgQW3DtEM9aFJ4Dhx1mzNq3IwQNENkhIHw0ch+6QcuWs1XMnOR1kc9rp3QIcE0smR
omRbC2sSlWsveqmVcRrPdMxXxX86uobVHKnofFxiPZZfuc2Qr7gIpkKzHzelW7jCmJMZRBbW3+Ee
H2Em2HwPKfZcVEnmJ23zDRh3cTRa3DGdAaKRJ4siOaDBMcGXfiGC0dYOLt8NZof+CwxpW34CHRtn
/qLyALSiPxHO1x9f0HPEEhLAyVz6gGG73yGGf3GvFw641lQH+UpPOZWyedmJcPtX6wrKI3ppon8D
CkMAFJ1hMbXohMeCuQqelK7l2jC2JpglwuByGUmWYNi4KAbxiS0Cx7AFrw6Y5gopsDaUMmB+9i+X
RiCct+a8a0XSsy1rqFnGHGsqCbit8hIR/AfqywsadnIbRs4si4MIh0hN0IkH+avXB+5zIsr4BDG/
UVVR6AVkgZHyUCB7v6j6QKCGeee8TpqYYO+JAh3tWR9PtNFifZKNpb3jfclsoemccm75LpGS/7Jm
ikcx01azqmlCV7RVa+ohyrmrpT0esxCDOrP6NZXUNDReaBiwpNdySygdmQQ5+N+Hsg++tuYHEtLn
E/NYklf8c0IGaDkORUuKjSeKrdQVzWW2bpLWsfO+o1Yl2W9L/dL4o8Oa3rzbOHBQDJrCPXc/0uYn
HAjAQoB0cLxh4rfTw/pYlVVx6bbGBJAO3ZgYZbvfdf3xawEtOjfw+TTYM/ybFQk9Sphmc7A3U0Pj
eVIXT/uaYDKRPCJR2NbFzhUcpEJHAy6ynfrcF2JjEu4RtOJRLuI7qDw+X3PdwniCpLwTKPrPnrS3
E0f4o5j7lCguHl+UnJ7QVMR0wBcZ2vPleCDzljPRpDG2R2KuM0jn6Hh2kYHsMCIun13gdSAqWKM0
78PhInEYx9LK+qE77gg8OvRupNm4myVJ+peWeb9N1F0f+TcATLisBtA1YQwS09gFCr1+kPR7W0x1
EhhTBZhXGVXzHdVbzQhOnYRvNKwtkyzmUIAKcSULJqjSCi0SHj73/ithnyi4lTC9ytoMXxyZle5U
noqyHkmlJJyP178X9QeMymjh+CVIA8ljd9bZU3Tp0w8fOQAp/RXGRjSYlaa8mRvxe6u6ECtzh1E+
QRzRosp5l/6EtXsc0jc3KsYvudkBMywTtmki5zRtaGMeOVegFv2c7g7Dssspvse1et2teunDKXXZ
k1oMVQmEUvWrGWPJpER/o0DcfhNfVuDzgYG6xTzymraudUteEMOGqpHeySNXsHybyBGA2OD5HbCs
ScauH7dqNuR2GnQN5G86qUIMhKOCcyLkUdN6tnDDJ1ggwf0/rftQK5OkiJTVURoT0K6qKvmxyp7s
KQemlqqbzLcaYe1gQGsjGAJJv72yJMh6f8uItiqDWbzKFrGDtP7vTEEm8ouQ4mWFQWzV6u9bsps3
zpwsysJuJxiWmS7CyFjWMZTluX3UetnLtirkFGIxdVyYRtF0j37ANHlcpuAg8usHZBkv0O9esC9L
mEQKy6gEhkavoWMjuEB2SuljY73xpBMaVFRKaldF6jvugLI0zEu7ffp111X5EbBZ8OnOK7xZuH8Y
RbykGnTjaxIXsnhZF4Uah974weOrAnPQgAPen1QWDYiTlM2o1Iejg1x3NMYsbf+hrCAMS1xSh10K
D1huf6MTeh+cQ+RE6adrLIboQXvb/2uD0WusLci3IvFHKPbxuAsV6SHo2bANV6RlVpH9qusXWIHN
V+p+sRAdFbVNJImL3IcNyKTX0e/aSlg8v/EiJJtI7vhrWnPD4jHo6eDSxCnLlpOSxxBOBApvki3m
5g2N1QSrtOMrYUwYarUTvvI9HGw0QcxjStEbx3wPipcIhvnlIIw3n/XN0dUkH4+xxQKdVdWbaUPL
irUhETu+oJ46IA7nsDj3lLpRE25tcfBw1xBf/WNwdpHImkJgPPp2c8d2SPm84yE8JyqKLNtWkxB1
73hPZxkK2UdKiGalWENZ8jsk6K16f/EEyCn/ePdxFqj02UaxJAZmopFp16vgLldTz/GEN4QiAWa/
l/cWsjwlazH1CjHJSqGf4UtMOaxej8YJGTYxHYMPGrAT2P+s49arxMlLoyahVoZHDpvjr6eR2TuL
FUEvbqrly7cfR4GtZTMl3Y7QbdiPTNrwzbZK3xSGSIbwBU7w0Ytw21dmfFv6MGNiXGJioDt/zrUP
WclxgXQhvXynQOykr37AjVuxhEO2Pd+ljCGxWbMfR5tbWSpFHevPCe+Mg719hz+rJe7joQ7BgSJB
5mtK+A++dsjm5wqqeY/IjtSbA4N+PO23xk3QuB57L1YBqYadmGiin2W1riK43uJETfaOQYYPTF5Y
uICzvElEaYthEWQtADvj9VHxWqTF1ZrZPlnDs9aWqm/3YvKD99abkjHXWJ+A7oSG+Hx5z5bzW2Ko
dahl6KNTkZV5W5Zj7SvC0vLQRSo1GJiy1uhPW9FpMnFTeGyCdAetQHkMHME0/ijfTMFbibIeOn7s
b7SzO0e3JdT7rlEB4ifmwKiHVWgG1kv02Y2VtWHBBkKUdVpCPNAnrvmPilBrqqJPlfznQEdhhCkz
tyOYkxYkF6d8fn2FNm6Bjc0xpWEhiAT4CjSKjxbcCkltfoBz3ux2qWan5VzKkXSwMkS/MQs4wdvH
7UzslxiUBL3w0hDZlDkUoW/ZASmVu6ZKko33Hl4x5KAHJzXgct5HJa+dc5w2yaHi3l+98dUuia9e
eNVql9pFFByJl6G8Xn7Tyj1ueRCtbYorBTzxzw2lKrNGDcO6ktwI4dePnLCHbOi0c+UxHLZU5Ca/
xxc2We933rkYshUM4+CiD30oELtA2yFfbJoP4qunYL0pkIw6D2L+X59mrzO/CbUIkUqfifhhPux6
sSbm9AwKQIMI/b7tImy9lPICU8m6G5Ybdhid3E4XsCM6K28aaKFLi4KcVb/ruC7fW/ae7uaKe8De
o13Y6RrTZiE2wi56Jk/mE2K1I1Bn1zIMBN47C9TsjjDYEIAfsqjvSYQMt+WQMAUfQqX72B4So+zW
PodRLY3VI5l2oMR3Kvrc72xHSMqMjxR+JBMpYLkizL/kQMN4xhF1tBdOX9qt43Xv6RRiRdEjwc+u
1MCHto0I6Qp04rONs6DRV7kGJBxXF0Ee6KyCsIc+E0WXbJa+iQFvdNTz4fSygVKnDigxiag5vawx
RLBrFM4X54VAlUDhwp4T++NHB/Yh5U4vS8ZIASN9N/Gt3Ts9oWi/r3kFGvhKe06RaKNPpCdQPRet
kC36jHoErvyuiFTZ9li1XQpjYYRYab7gnz7KWvrDYcE+2tRfVPNo/dEdRVqEhHqPNrk5M4pj2+TE
X1O/k5fk5A3UGAE3rCk/bQIyt0qapHmdIeSt4aFWq1FuyrndLAaxiOnDa1VJONyYa+09EuW6cZML
/tuEhJn+brdwnAKnY3RgsKGAm3FrSLM04vA8teZIW6CURElsfzgkTEIho9GKBVhBG91ieSILLmPR
NDHC5ZGZQ+ITBAcpdRvo197FoXgRINQvvTsF/8EwNRVTYIwanDmaYQrVNdv0CBoARwZm52V16SKI
KCmnnbli+4HJAUPW1gqCqSGg00/jfvgtoKOKsmMCZ9LVyDsRY8gRoWxvxS6bIMYvh6iVWES372KY
0eksWli7+PypQTz20uRhiqMdHMAflIDz5oEeXdL1B4fNzqfAG74l0AF4re4r+8H73BueNvOyS/an
2lj6etBfI511Ty72cJauVXCp+0lO8BDPH/gQ7E5aQ7WlBOnkt72UPlYvzUnxc7iORDESM4g62Cqt
nBroearbE1cmlyYmWnejlnnfhyVfkEwqPyC2tPbYSTSTHGfTaqI3/DBnA6h1ogdH3wcm5n63khe+
5gGqDRzTL9ggCdI6hZUo+372ujNUQgJGL3S7FtA8PMtlYyoUG4e3BDdhYKKQYKTLZyviOAXAcWHd
KItSIUsTYVSYy5C/LMXt6xZDKySYZwOWjWiP0scOfPdaunk399TEAgwaRdQR3HklboF2dybIowij
GbmH3ZBI+b55sNsRUOo9JrYV/7ThClbPkiJPNAoPIbTAkFZJC0tqec6Uf1+l8L/KzwJYv4cxZwi1
FgTzQYKZeney3NgXU7H0+9j67yPUmmo1bJjoRi5xPnV1G1oupWvurZiYIJdv7iSa82C54c4cvTSk
cALJ4+5mdd9bUPcwJP/xqAlP1d0XNl/LtXPBgqGmR00AYdxXkDJDjyBR2sRhKtMyUQT19tfRNc9F
Vo7zprnTKQakZFEeDNI8HiVVODPJayF+4XPUmmi1lawhya3Kj0mCrvmOfr7e16rxM2Oyo72ECo6z
6qs0atAfbvIv70JVzmu2emfcj9WtPBPTjrBikZnkoQJ+6UjB4hBxWCdmkrPulPE2vbnw4NkVKBq8
iNzUj3k+Ro7fU0IqrGQ8MuU4rBS8VBEKCz7x4zQeawaordyReA8aASa347SVpKvMMX46bCqMyr7N
5gPo2wZFn/lGuNV3pSJzeBKq9xIVavY63N264iP9JsT4aNXTSXUFZDRtQG2ijsd++Yk/jOpOFt6R
Qwyp3OabwLNaRWZ9UM/k0ep86UVSMHlnotxHm2d0Sz+Oljp457CZtXNdxPqRFW4/23ByVY7iyov7
IMhFkwqKl90T1ut5neSnuor+d921kG88G2wV3Qhv18PFMrGe/qfv1spT2eIOOUb54AhsH+7e9Icl
jlrkPGk1Puuy3J4FYTLgOsuxw+lAv5UiLoG96/wy2vcnsrTfpdpDHyAP4qCRKg3toxt2KC0yL0eG
/FW5gevwdNI0f/cQTbUeiSZi6qw5wEK+AtWsGeYkE0RfBdb9jA6O8FUfk8PlZyLztHlUORdUQ4aF
K4yfOfMTj//WPBYf4X8zhR1OMSxmrBlnSRJkQbPlfEsGU74+u2hPn43fEWM5fF/nas1ndmW5MuzX
O1SFEkH3mrhbvGP+i6iT/w2KQqETQPwQIKQSQrnOhGtXstJfauW6mynNOXNKPimXP/QsWLCliBzL
1Dg9bFPN7jwVXBKjwuTOPV2AVFSbRE5WUpubcfd8ZUyV6m9cv6XI3YVr5cEBcerX+zomGZIk1RWb
r0nr7QRUQJYPG6XSXgC2EUt8i5xPxZzirLJBGQF1Kc86AcXGaYrkj1O78o1QLDgYs38BO0U2ButC
ZKzeocfA2CdEsGw4ktsXVahVegLUyOChEViN2AYryWyvIzpMIMlVAFwpAPvhj75pOHEUdYc73dlm
ZkBfbX0rN2P511liJxalmj82a2Ko96wjFk+TEmhFX8+U7Tu2bjtaWO41evlt0q8QrkfByhy59qss
hfUXks642d/Y6gs1+vzAF0YG5g5N/q0JW25023wOnHJtPrcFmjtCAk3oG6jPBZeLvmmrUsJtnpJ8
gFyCwu7zF7MjDWxRRHpZr8E72I/rHSKF6BLKawMWGWQBZhrT3b++PAiWf5XFFunOVCOlhvB+aLte
8DX7wXVilJ30GjWnaq5Cd2e/cX/3VmCBAl+6D+2AfII+9JgZsacHcbdZnMvrv3w+mmyqc/kRc1WJ
pPGBA6qA4hBfSLUdLOyPXWXU0UTmZduz8RYhpmPOYEhzDftUoLu6wAzlmms9fwyg83740QoJAbdI
E4FP7iyfAALBJnZ64+tr5E05fXR3oZqMMjypcaUXQi4aNo4PTyV6jEHPWc+c7lUOS+AAnZr73ulu
K8VgG/8AHGwA3YH9vUR7lZAx4WXASnKhgc+C1AQdAXay/IpuXxpqmVe+QuP61sRIJOPoIUfOHXyQ
g2z+mb19nRg7P3hSe66QMWk9ogkP3/r13mXgPus5J3BWGhxT09A3tVErq+S9m8RENCO282sTEPdI
3c/GkYGOlPWic550veGK8+HAg9wkPMk4f7rJV7CXEQxbhojOYNk3OVksDusxC95RXlVQVEHD8QqY
lv03W0oRv1m9A/h3nrzP0MWswuwTMRttNh04Uk6Vqz6S9hxV6NS9sal0FyV6miJkZyRfxWvTHoAd
8B3goAZehFmTVeJMqffOHVhe8gW0n9y2i1UwJkIcjaAx9Zpj5+2H+4czWV6mNmwQPnUsiJ+SbSd/
upxnDaWwR9mBXJI1WiPQMFe+bnA6tP+FTVdj5CZX5Ipw07iCszFZEBT2lJqP5hcxS6SXR4szyzaK
F2gf0McWX03AkLMOWJBT+6Wc7u1WSpk1lEhYFJdS1nE8RcIxY1rhRyjfEXen3o8Y6oZGwDUcrpXZ
RAqYngem/SFz61zg7AxqQVBmafpIn43L5RXrtssSlz7vxTFkgR27PvCmyyfHzbmy7h85Zf8Vd0tY
aqFs/4DGiqfElOTYOmJoxZwohTg9Qh5WOTdcF3JvaaiPpwVz205/DlI1ws41Njq7lKocdjBdCALc
+aD1M34eQqWadm49Bsjpp5OHHhQX7zR9xuJ+fWoIbutkLvqHnMcxifq8H7Px9tAUMdAGdkB6xh4+
sCeAB8pZdr4dmPZ1v9DJEhCOrTzs78vj5xFrRkNev5XZJdNX6eIHwri9z87x6fk9LPNHShYEyUEf
SUlUHMYDyY7P60bpaVYNi1Fl/axz0eLZwxDh2loQrWi3W8shMxX6c642WUYyWPCAddngRYlwE6Cd
bo6OCRUkqGTjUqoqG2Ejxx/fiOQi6WCXy9C+yL5S/uxAF3cOyj76ihuRajdewnaRVVqexRFLS+9O
upv6NxP0lWN2Z3WcWlArrb98Mbs7n0jdMZQLTVpSj5gHpyNsDQaRT0At2xhog3la6D/UBmkJVoZ6
Q512/7h+is6gnNDqOCANYwUZUHNkm5vVzwFOJ0ALdcZd3h86oZCERe6Ibw1vAnUfqdxSDgvHKZ8X
kd5TLO7X02pF2XDBEEFR2xTzk7vOGJ7co2twt42H2l4I/NheP8WisUle0Yz4hJ28kEQqLf8jbfrc
C98pxdsw8GhwNygP581QDoXcy3/DLzCBqziXjkLKYWGUbmy2yVc9FbrYM4o1R7gq3hfz4NKDVcFd
8zPxr4CCfnUlp+8GxsR9LxbmSshsx5Sjm2W7g7tiOfsmlMnFGqgT5Thy/DUmrIz98x7ZPjb/+3yo
eE/DUielc20p1Wm0A/SakMBPdT8ZjdNvJfHM57xM24EtOwdyatPyGm78F0+hzP1BSzgB8LT0vl8X
dOjIIKxdtISBHYL94ta/a6x0PkJ/G0GNy3o5S3X4lf9TpHchd9IL3WwyjJduR3lrDrbqlGEGrFf9
7OoYqDAOY1hxuGTazhf5L7EbyiQNEXMrmS9B1IAcsRk0/m1GSlyWX0YUQe3ElFDIJFSx8aUrXT72
rc7Hq6eATmNVBcDmzeDV2Lihqt87TvbvWamJWpW66ohHDlhJk9pBeswXEG8LDdmxtPBdw52e6Zjn
AH2RySlhv1d7E3Qw0L1THL7Bo3zJ5YwJpGtpY2t/jjhSXohGbCGir0KlzxX8F3/IzYCiXb7axq8v
CyDBuwt+mF1RK3WpZ2CQIvCLq8CrWLVcfhxAWN1zuLVRs/JOHBxykuNjWYjvgNYxWLY674Tf6Zh3
e1xOcUr0OiDxgBsMlM13vXxDRj41RF8sBLk3/lstqTRhZSZffFP5KjT54hi/WtBy/LXH+pyheNar
YKuvpp/V68mTMCDpOkJ5/luErX4oWra0InOK5jIrYUYydCescvXObWFqg3lN5qQyeneT7FUzhg4B
g3DESqu6Rs9fUfNwS1aT23AT0QtSMTLMOCErP2fO8KfmtL1dGTeueu/2HBSGeH8V2rbHasSBWD8D
HB8c89ak106Ja/7kJIiwm4SWRKtu3bE8VEJQyKirK3mMPf2BaTCjywuypJhAN+t3MxlnPP1qKrKC
nI3XLVgxnbwptQNHKCLtQ7QAB4aaEmuoVqSGdKBpn6Wb+INCYZAWuK6VOv2YuWpe7cUnFHIUd/q8
LE4uVG4QHQ3T2WZ3HzkWqQoT1zKEFtmpnPCK5IoEKZmvM1RF8EB5ldKUSO6/UmX1qHo7Rsa/fWF8
smaG4//WGBbvNFP1G8vv+peHOxFFbjCXtNL8IX5Oxv7FhUwyxzW50g1eHp/mWWioRBgagAmwPOGx
x1KX4NPC8dlQ7ay23Gh2+LMKa6pBjUZ35l6Lb50E2vH61CFhxyIw+J2Kjhg4DyKpASr2VowKgcp6
ITehwzHKaEOa+Jmk2oMSbQh7VN2zGNw8RWGfW9oMzVBHeMC77meiWDuNa7DCek79MmyNyMUt2dEz
g6IyYVoojDygMhoHRNtaIvOzKnf9ApYVP9R7fE9zzr1hPDae92Ysg43g9nfAb0BX22fbbyAh2VPN
mIcQCEoPRUnYtFc6SNOSRycIR7dAAaD2WPzPPwpioseFSk3fhyFwGy3fHa6xQMQ6DyL4p7JWRQ+C
KJiYPF/poISygebrxN7NT9yXbPI/pptaOw7b61vWl7DArG20xB7aYVL1Wduivh16C5FBzgI19S+s
I2rxCCnUvWlWOMNXud2MCX0fcqvNQc8Jk6xB4wqqP/zF+9zE4aK4shUnlU59/fttxDlki5IY+PSz
Vxjfq9VIpyr8YP9cqiKKYCZQG9Ni+Crgd90r1lKtGQ9LVBMuueGgBga+GSnJyl2HQFN+DEjE9K4a
jV1B9X9GEu84yzkd+T4JIjpH4LSfVrRz44QDV9zJ62KpFJeXrYyjjOxx3LHmQGi7viD0Acielgmo
bHp7zQdsBzwqRCcvo0S12LjG3id3hWU/ysvZgb5PJi1E3m9pLFkFjc3YX4Wd2/Ae1NAHdWDiwv+v
ZqeRseU4s0a5B9jjg+holG0g06XnoEzAIlmHm54V723c+fn1aWNqORJOCEMX+ASFJkYLhBx/oxQf
cD0ErEJsUfEu+UTu8w3RM8TeE8R/RpTVV4bdXU5iNaeBKTFU9BcS0VYh0D8cbZnmhYrVrOglIECG
+1PL4noCDytWOXgZYiFgm4E29AFWgIEiSuTTcmIknGDLQsdVSW90GHbuzMdJsIjSz/Xa110rDWuT
UqtDiksKu6I8q7Cq68LMDuqwIThbBsPV2CZaFsy6sWxE2sgaN7HSClU/S74fXS0e8OLHdlaSOaOf
q3ZBa69OlFUSejT92eOQZ55EgM/+WBUZVLL488AZ7kQZmD8Yl14PqtqwXWYdSGjVQH5Rw65CWrka
1NdocU44Gk3CXMjiAirDp1AluCcmY2dolOZfAlQU7Eb8HuYn6DAuw5Ze0bIlOKnk/WOWOKu4cLuz
IG3m/JDrYKUGx4ylJRcvSYwVZ69EWd+st4hU96vDCw7HS2ckeOJjxY4318WsMVxBSXLxbFu1Q1Dd
Rn7ElgS/D2vWz99Qu7mnxRgNB7Sy+IQwWK9iKvPLhJDti4MHJbOZeEJMCEjP6IMq9nyqjKIxzzdX
6JtvmSqrVF0i4/YLC31g9BPvemeask80WIQt+h2P/s4GVf575bJ7SMsAdyFybGwWhGKhC+0UFtmd
jdhwxaVeaZvKiEILqsL9IKZJmIn63JDYM9iIyCIvbZTlTMrUMRMZC/WYyNN6ZaCJGcWkQDSqclID
wS2mp9EUd86Hs2LcT/Py6SB1PvYzILFUu49NN4QSBmY0O9zSb/p3iIpXwvAUc1VYBK8Vz11RkDK3
xpX/CmlMcUVS+TMpPmPG9Zkhl3wmGVSDGeGNsrotn6HQrP0q8KWljbq42CsdB8bqttujNVM+ojmY
LJW6mnN//c3Jtlcq2q+dCvSOke2T2Sn4Bp1rrA5T0qrOwBhcE9cH12wGJqNf7FcVneGfYozToguU
l/V0jtUhfiQjkZVFudp+j+ilgQLwO9e+CcaPqbgGzO7dyBHiEiVL2GfBwp522/FpMed/2uGLr386
xIiJ8AnGdkZJ58D6CE59mKIXOwwqbH2iQGHMcaCCtcLdnYmPAtauN3NJXAOCStg4LyFQC+gX6AGi
RfU0XEPXiYFCN9rXjMPwOv0EDWXBJZHB56ee7rZ4s8QK1MMvPzyUahEjXqyBJ9oMBmEJdpntvbY4
h13NWf3eI3a4eut2hmyLcDG7D85Y0gGIUMCAu6SBqoA0jZq3m/EMsWLSrlpHXhYMPNftfrlTqKdc
+v+beyCCk2zfibL09dAgwAq1hULNiuCN4hXlo403nOocA0pafay1597gcZxG2e8437X0DrHTu8W8
hrKRMWLaV2PRtsfROzzTZGRhMy3kBfd4dBMnZKL7loD06sS0Ea519/LalAjEGc68p5Eeio/Y01RM
iz0iuQcREOrih6yu2bymh3t/+NzpGT0a60xicTKg29fBz9d497fb3FwPmM/xqF1sHzV9uAUKL63W
zN1/7vyR3O4N6gG2BnXB/yIg7woJG/A6z35CAycyfqdHPtkkwx/EEilQi+S8/5rZWKDBiDn2liHZ
cDw11XXgzkXaXCwy0l32NvwYaEwBHZDLxkQ0V79UY2PijC1JIsDnJuNCigHY4De+tqcg+sXsnGwA
QXQJfEKPwtpZuX2svGYtinMnJcPi2Bzx4sO1ukxuxrJ0J67laZsAo4Oq6QkT6QtaCUxfT8fTrg/N
ENkEb+gJIaWFwtomnRM3yOTBaPoQ97X+YUCvKcIc1Uk3PE4/1j5KYkej13ZpYSHu6taqodnrB6VV
7/PPS75ql6iVsJKzCTlMzoTuT8cKqu2vCpXsMEYBNxahgjJqLlWQWdfs8qxWTdZRs79UkboZn+R8
SnmpdZUHFVrfkgUTqQumL/rQxnR4ePc8VPNR7qKXGnanzIGecA/hMzzeKrLaTKQ0PNAHnXT5hLWq
kJSywAMx5dcolWRo93CqLuLepcQYwCP33Vzpm48dv856co5fTcNDIgkS8IkplqPAjH+1nqOPtEaU
TC46cOoNNUgZDekWdYzmY7WwR+h9jMOC6lazRZ9fYrWNp7Sd0DSEzznrHs8FYJTd0evTE6e1IR+X
3eeJC3AZhhLXPwt84I/BrAee/8E6Ywlk6GylaD6rfzYdyhkRSPjO+7sYKZP+3iBGDme9Si0EuFNl
0p1bLPF/sDgTmt2cdpwoH7xqhZDcnXJUb7TSnW032NkXg3SHthMlMLmISAUxhzGUfXPCHpDxjEmD
uFfSju+nOnwtYZNraq9cNIjk9pLpzmhI/S3OAT2gCKcef525YUKRFxL9s5xuTeOiWHSVDZj/DuIe
xLSCD2NsPZ7CyasgfCJcLIUhnbgqCL7x/xyWoWBpJCvDz9Tjv7GFg5+NIlWA5IOhq7HKZINab6nq
Ea9yMKeTwAEWyfzMoohFaf9Ix5pMcz5niSJT2kE0do1H8CSNghT6xR17+uyWUSCySQuDVflZQ8SV
gDLvQ83Yh8JoFh2Hx3DoBc+Jeuaw5qae7hxFGFxXxXGZ9/kwXc6KCtjghmA8jhIvlRDVfbLBz45u
2LNOIiGvT4BplPgvcTPxwSutAe5kbz3sM1tkADv6FfkkVnMVuZeYUkzJ6IEPzgeCVz5S7HUPGAXN
gmJkyoBysXSnmdMg/ud8HSJolcM9RFnixu7fGEfaz5rZFR/R4+8tfgtscwaWYbtXHj0WotgtCPTR
6rvmWaCKGvVIxBohizEu19t+1e0R+dmyOd5m/7HN/fkAqQjWGMDa8jBILMq3lv6eSvbtQTZekpk5
8KhaY26lsxSrhJgvu7iURYB2a77wvYA87nGmxoVWMh7C8fuI+haHG8c7ujknoiOFgpMYL+kCdU+W
fFs4uXdnO7H1bQzHzVe10Kn3ViOQOEAnQ8Lqk21U4jvk9p6iikw9/UPrsnZ5oTiY7L+T09oTLZKk
B8rvzbR9kzBn5lTRo2IJFc0V2krImy61zKMB/fKU4IQGcwi+rLYfpIUsNV0h1nrAoLFMnroOayvw
k3WolIBo/RKiXQhmQSwtRPxWln2fKXMmgy7nx6evjCbpglA/AkElZx6puHjtOHV4GcxrWsKpR368
0oMgnq4bj6tYVnL5x/nXJHNou6TtlO6gM8pvqxKCYP894jSlNb8MaJIB47gXe9C0sny74FV71sh8
VJe341wYNZzxVNYx1FrldUpUQvYNjUgTYmykYM7iycin2lUlrqeLyQhtf6xqBv1I17RWeXyAW7lv
I6xXG2ElXY5JrEdYLpCZ2iGTB42sk0XsfHl08TwmlFfxtPXabgaRLAFqqkZnQk/yMYTe1E1BbnAR
4siMXjrshwF2sLG93yizwYGybfymZGLetkCend0bROhguHaw34DsdON0Sq5zlOi+dHXHpT9QhhTe
XW3ZtzgRFeYJ1d2e70xR9kcnZ7FeQhItnGwQoueW0ryghuEQ8OZxksDoYViSjcKvc2X1i+7Qf3l1
Xm3cMYSm4lEMdvnK3nekV/eWp2/oE2wzU4xuHNl6KcnnGca+UUx3fWQ+zBJVywkMSkudCqBkIjhS
B+IEiMDhfpv3aM9T8QvDh6hsuEY4JnFzlwG2h+5XjaL3LxiwNE9+P0l1XtpQdKEHTWxEFBDYFQ2u
54h/Ib9cf0ohPiUra+OL/7A2FanJJmwu6J0hYrHocKPUyUDbOSW8prON3K5Ug9mPeCREEjPd0XkK
tRLMdBGbtAnH57V6i6J/eGSL/CXrzr5uEzfhULeZSlBattf+iLRWNaXfevgh8xWe/B80zHuu4Ujr
KoLc+zTNLnFD3RHkZCNAHq63sTuVtNpFCPk23GuuCycSkKTAymrumRyG9FigvqmhhLQXezeb0xSw
ytyyeG5a93Y2SHZm5N4DcoQPpeWGMccIf1CkTrnLbphNOh0gdjsUa6AuoDD7Q6t2693gwiVcYxOT
OFMKtjQaHR1uwwmJW42Mv6OWBU9RurjdjLOcxwOYSLcNDDSWhzjE0O1YddwjXH0gXAIBqj/y2lcg
4Af01KruvKhkqaLqd6yZIfHOP8gMPhBaCiIjYy5sgVmzM53SS7fxQy/xpc704F4LN4ameEaOoYGA
bPpRZsBHX8bPGH7UpXk5buEg92XWWp1Px0p0TK/sLh2i7eStlz2xgk0ig8fSDWIDYlFXV7+TGGRE
qquXIBgPWvbjnuW34y7KNJXrupgfb6EQ4bTlMZCWAjO4oVKoxRKKw/5M8zBwgQK9a/oVDOgsnCdd
fIQfbUSOdr2wnklRCknzQszx/cjXtuIabI73ew3V20sYW9/ou66rCuXfAzZLhjYTzERDQGBGGTuT
+7Pd35W4XD8+W4hLBKftHNBy3IIzwzGwtbtk1zF4LDnbqDfXk1/EEdKtfWJVO8RFnwc0zqGohieU
abbExuu0Y/HMIJQAROBHt4Gube74kWsTf8AkBvH5biCoqFfzOUFIk2x1oTZA5NAVPitjtyx31Ukl
SvUmMVOdHWPU5VuftudghYiUG5I8F1W1ksMkHDMkcT4ExmG29LHgsUDxAKS9DMzNwZErX/c+RNsr
BYVcjhHzYhRc7tMfYZcK3x3bUu29tw1LDjcoNyynO61Rqj3IGRiw0gsqlyI35KmTLTiClqXpMRaM
cXRV6aQXoHWHZiH3W5EL748//2dS0MPmSQq/BpWCufkz1BkjLZVqYnY8qderGWW6O1kp2YU3RC7n
Y51MXwEQRpRo8tfyfyirpH3VQ3k7aQUKzkvcjCnp9jOaueptZCZtlvuGEgfFzo2fyk7nqD8l+Ed8
CICsy6aQUp/BAu9Wm9opzcrKbtMEBXTzSgDTqvNPMEmo45Z9SrW1l/vhbJXhqudEM+jJs5mfGX+1
8K0X1pR6brX4IdYCK+GGpnPRA/AcfLSC0hoyyFzH4epeKDO7JMds2bNmbzhsqAHbk9kkqUd/66Vc
cC0y/+RXt6RUc5Gl8YblLCYX6wa1qddwN82/edezRIAm+oTR70KjnQY3vnHFZANQ/e0gDxx5mFvi
AGtnd0SdLzNFyoH1INMetTT2kG9u4q9ZFfgj84rBUgYswY3F5iwlWQNrQAYILIZYS24qv6IB/W8x
+82M9bn3wCd7dLdwoXF6/yA6RGXjmt7dQPJPZNCsDC0r2RsBkwpYJ59njwRbCuFjlK86EWZ46OP4
r6e3j2YwMKVD1JuXUMi2mt522gW936Gt/o4sVVTa7DJDcKz9lpSfCy50Q/saYG4IQWZHxSeqCnYV
UcQ1IM4Q4GfsorwOuqZR3WvtUow2Zu4hi/GERxlLkVRXy8JPlu9mM8N80tcSg5OmCdrJk7a/rAoP
1DtYL0hHHxJQmje9GX3T6s+bbe66ZWtEvVHZE81XGT48xlTqSilfQ+YoPAV141YgrLe/VlUWIgJV
QaNUpjno0g/0AHb+MfAvMkwVnQfbtgyoHpIAq1gG/KPB89CPzivk+LrTAc8ZcVXQcTqxca4iz825
q3IWPa+2rpcrd2ZwV0W04Uo40TRWFJXCP9DaYXa8kUwONdSJtdWPZ6tUsjwSM0BmQeSnZgxUsnjc
KzT5tVo5OJaX+xI19R4JeXF+y/zERWgj0uzbrQjY0RXrAzkTHVX58bAy+SUHKtjI6l4FzBNbJrDj
D82+fjgE02Ez05BB5v6TRbsp3OvmJuuZuIi8Dzz09F4B+Ou2E9zGkPRl9McJkydCPStfmTbI6KiZ
5MT7hnf068o4JqlaTjUjx+uKgo8m4a3ja1jZ4Ezhg3j8Yi5my5Znmja/VzKoHVF1Xf5FZxO3DYTl
+hCm5OL2z8yNqg36Sk98cgh12e63LFHhCHZST+tVzBXp5n5IxG3FqgtTPi1UviBf8ZzjuN5H1iyY
AP4q/CaAKiybjW0OXjvZmnOIuKllkZTG8aQFeGgbH8GYIfsgGxtf7VJfgXzETZ5Uq4l9h2lvJv6q
K44+BWR7DadDgou0LeNvRCQYUy5moV4aKEADrAFyoyclBueEOKoFklIqcAf/LK+rQmRsJT1upMFq
/KkEPs33tJ+cFofXPdXaI8MlR/tz4FkYdFOgy7f+4N/qKjDR6Kobkxi5pR+xWknyU9ONmyuKysIk
UzmiMHwoH9le/IkQtruzR1l2Pw578j5derMoAgf5ND+qMUFJuFuGDBArsb/daq1cYf/CXKCk1bD8
fKnUsxOmUkyXz79qGHX6o2HiVTQX4L9BsvKjkYC9NP5NFFlAQ8onYBRhQtm6JQgZebCaTPOHvvhI
mnPVuEqd3gC5mBD9YdyiTHOJr2CxMcUBONrCxq7zrwzmtDyBO9vPz6+EizCAONN6NWoktcILngy1
+IFPkCAFqjWNJCzh1AsSi2jcQ5AGC+mCWOQFQ3jEJxHcGEkCEuYPzuXJATfG1gWnlrJyoiy0E/zd
asZRSDx5bSEbp+MzG38kxmD1sIF5UHYpickbTQoCLukbcz5493lV3oxOXaJpaw10A7sO7rGO+1z7
Y9p5VZNf3Pw38NbEs9DRgSeVvwGjsA04bA3kKdWyzUU0y0lEXf2MrNT//khMSCokrchO7LWNJOud
NRe2y5ekwt5U3M6P6GhSvCo39TwkluGkLdVwlqogCkkELgCtaX7+OoZhTs7ufseIqNTwOY3g8gcf
jd3pnzNFBy4HoN2OFwkcFoUjkFQV4suN0KYYw1ljbLi6+x5hoD19zoPm3ovpW09mTxVFBvTsXa6b
KlmgCF1Tu8mVjx6Cf1lC23VDwZN6l8iDny/JSbXIRrY9S7+eaOUibOGxBlW9bV6t4W98tbqBAhvp
byd+loDXonYAQNFA+eLs/00qR3VO1mV/7KtesVQlCVRJJPGHM4yTOMB772wEiSX+5LkN8yaZccgM
/CgWvDXdqcgWH1GA2wAybKOJiplPggdh7M90KoGk9VtWyIppxvQOufRtPpSCn4w08EODCl1agGfR
EonXYxcHIhya6wGpJaO/aZ2YbCkMjmZqADOU4vJH4A2/OtkEwR2v+z+nIGZMFGa2y8t6KX9pviJa
yHMndPIRNHl4bzHUsTl9er/pWX/LcpwuAN7AmyJLI2IErEqclTqGwppfHhSZJrkA/JqzRN3gB63S
/y5kyja41Eojx/hxL6LFtmC55zWLXO6pb9dnmmy/zPBz9Uv7ZhXwQhFVBJwjb1pBwlA4OlIBNa7B
K8DsWDIt2HUMec1OdD7FAvvrISqsOomQJjWUYSx2bcEvy0qANxY0qC7g3DseeuXK/1jWZoDXe/Aa
9VIdLwsERP4hpgnZ6xpDtTI3jTwteppXn4oHaJbPh9nsDb6EhP3fBPfqsZfwjEHcZuK+swqI9e2y
JlKiMm55SSB5rO6yhmVoAcVlPSYtBWI899XQSkOaNaWed/Rvde9NkKuHIAY17u1hahGkXH3+QKWm
kzjq2ivlPolOWt4haexBxW5iJ0f90Zv0tN6N5jWA4aG9YY+jXZKy6ROjZdIlTGjqDkBVurfmQD3N
gaM8ho8kV57cBiUmh9jthnHMtQlOEANgSkFmWc2jBusu/rN6Ccu2YHt8WBKBjNaHTLWv6M0+enti
rM74oelUGgBM93S7xReQ7z20rTS2HWyAb5EOgT1nBPQMX5x97xNB+W7xZoi49ll/5bQqMOz3xaYo
WDn/E2xeTVe+HFsIUISQlUk5zuuevEIzuXKWQT7h4mYZKANbwRrAgPr0CYpE4PAuCnMpX1K8c5mD
57D675xHkNjak9WJ501z1zuH3dPRmy65KEgMbcQIWdheRLBzBteLVVQLV34Hlcpc0FaZBys55BIT
OlHbgXnG8wkEqyita2JVFzEFsGS8rpSvoYOXXCQmma3zMpU548c7MoM5eBlA972FpcyMXGHpD3Jc
qvU4BjxeX8sToibaK3BnvWt5gz2ebIlPGy+VDKyiuFznpNWDVUE7VIpq80F8GV9zTqou5lqL3zkP
iHzhytiTLu1ovuYJzlcyYR9qOzAz/yOau8GO5eTHi0uyljF5gj/9sEvYutqESGTWuem5jZhQpyMR
t8Y3M8cejbT9zHhS2zVKvXV8JzF+/2dp4HsPTa6Ox27ZDDlNrDEAup49dsH2tly1KunVKP/+8V3g
KSZ//srKpbQy6KI7dmRrFIsG6g4oAlYcCbP4dRxK1hTpVrNP5SwZC2hKXDs5/1wNgqxgOGRAP6Fh
aOgwHHXZCaT/HgJ4h7lW+cm6l+XdlFHIvmKLBQ0Ee2V0yvwGlQix+BelmR7N/Mw4b40E8z9Nu7A2
iVQb9YsyukhUoYJ4ZdGszevnND0DkLS+E76l8JbfmqFzFECMnIoN/n0o2GULEVO9rxbkngSBlu35
idIvixBAnhUHY8pbdpvNcxkCVZH6m+kDm0TQmmTzPLMDIE5YE2PbdrYlGOPMwpItOg2hXnMWX2bq
je5S3XdzQzNXXnZE120e4H+YJZhj0nfwZ5JNpk+kbC4m2ur1nyPkLQ+UaXGsEEliw3Sx1IQ3sBZ9
vlp6rJKKxcB7NpcURhsjJtbH2+t23rtus9/bhDkb6U4MG6Kfk32DizTnsRLckIs6WzdZkLeeihW7
D6JHT0vk1PHm56Scszm/+jNc2bBCv6Gdvn5sTL509s0Of7Nij1nkwHuaWpDhYzY5VErC0LmtfE1H
LOv0nEAQhi65eDbl//kp//1/qpzX4JNOhVmFdmRRGu79MpwvGsJ7chpbkw+eGN3tqi+P0idR4Z7d
k3M25aTEsJq4l/VZ6/XtbqbX/4rczjLByoDEHOjomfp+J66+TjFHVHoYDxi/Iu6xyQNs9EiRK9Yk
GHaoJaP+lpMm5HM2AhMHCIqC8dTqZ4P2WgM6hXNCm4bLH3APnQwS2aIbilREBf/Ojai+3yZvV4r8
3vWbqUgFxVWF6Ku+GHGTIqnz2nUL5WMBVcbHwzRzLzITKJk4y3G74Nn69qRMVAQGttkRtrDqu3vJ
a7kwGPT+lC2OgV5IJ+liRDYhU/Spa8vr0y6piEUBhG8rDBop9DJuav5ai9XUfvWLKTwdz9dgSCDp
Oz/ia3J4q6ukACl3/UWu2D800LuySLIVa3tpYDZ4FefGPdS48yN9Djjl7GPOi9xM5/7FDmP7oeB5
Dkj6wjfgpAnYqt1f/QVfxHVhuB/6i+TCwoA5167Pip/yZM6MOjFBBJ1aqGjRQUni4Yq3ACYuIFw6
WhpG8YHD4B3IXbUPU4tgZekAOu6zf7fPlVOkTCDcDV54UVJE7q7xQQ05Hw1Uxq8d8ZFAJ77RnOPq
oxow9BlycwHFrvSz2tRltXy8sxWTugNDePXxMkXIv5EeslTHbidJAOmL+hQakU4ihlKz3jWVg3tf
AFMJr2PfdYaN9Y56e8HllSuN7IkIAVG3Rs31rfFQpCtlBR6YTyPU+EkMnyl8EutrDU9CwS6WNXtp
Tvd4XTAZE6aGpdqtIyS6Jeuwrqk3of4AsNRQPUb6Lj1/zHyml8LOAwPEc7Z0J2cThfKVz+JuUNnl
IEn+7nzqrSSauWrJm4frUeGJsKDeqCRi2w5Cg1HRLUI9tuuRGwYE7FGLPTD1C6Ch0H8di9jk+ikj
DptiiEcNR9UcrVE1ATyHYYvU7E9j59VPG+GI9yAmogTAA3owGi/QF7COTJ7S5rE8yPLI6g5hK/Re
wsfmVv+TVDHNYTSc6dQgki2cRVd7zXHBMHhQuSuFn9l8hejAh62bgF8RPYw53f4WiErnT+BTpIRG
MnECeRymgZP0A8ZY1cbwuYrPrPe/CXdUvlK1TL6DGtRwJtImAoNF30hlTwFmXfAeiHBJOyyMbeok
wCkO4N7/jrP2VY0xGz4/K2pW0AsCbY+lxwz6vJU1VRrOtkpDb+y1Mtq9k93cTR/h69EqFhLgbPCl
2JfKuUKpBpObNyrLMjKf7LRf7jRFDhuffG9ej2UBtDQ4sYFxCiSKNL7FhVvEfFFBEuQ1504nWF+n
pDkg0eSP5ZzfNFRudGpksfVghSGuPmKad0avJzzhfGAH9T4mmPUDhj77XLsuuA2AnKD6U6xusiwM
o+7jRVq0KFvZg+DEHfNEGaRJHH0+C5VtxN8GPv6T2PJuiz0et9hhjRQaLXfReBzRR/EHnMpajgB6
SPXzvde45BUWxhPTPg9am8Bh/EPJy3Dp/nG/ckOBOMHA64GzVD9OcNDMRA02QDDe2sW5qcsdqyms
gSL4QLD1Yt0aMSMaCCkrxr8fPHvrF/CVjxFEKJswtITqWHWhMyoKDOsh8YbCpG1wG9X4dHeWZTo1
DmVdRvi7sTxjcOTcQRnlFSSkT7G6XlVPgj7/FTb3TBY/CMvt7CNI/2eRw1P1RRNLy14NdrpZCVkk
/OzpZZbF7j/iCxvmzeAnNseYCIzS1OsUaFEs+/M13wvPEuS64AUxGmrhz2VkMgniUEXr1Vq/t7Ec
RMBXxQhUln99B0qnC55nacoyoi3pQNHv/0i6jyWyAvQ4t2IVuClUtx83+jxtimm1qojUMD1SwOeM
RWqnFUsMpj47CJ2RnpjMs9GC65JA/S3AvCgjfNzZ/P5n5N9dEDA9/7+VlB2b6hRYQv5AbBlG+bag
dwSzgdwZsyT8kYuhgDCUeKg7cHGlv/6s7+wR0PtNiX+vBtAzGFIPj6nh1bgzGsUjR6peIzZFtAlf
qTOxoVDXlDOap32dL2UgKMNeG8hOkSigI1aXb2uscH7z2knhxdK4aIiK6haW6DG6Ehroa4ihbJ1r
q7u1T8VomLuGoLHHGSGMUnUiKbhnOvRj/vS91V8po2t+zwlSZw394CDnnUv5gES19FPM2LrxfkZB
kCd/MXd3av2Hjd6TCa9ZXCYC8Ss9Zsvb/753nFCG8HjdxU2iXgUjSZCrsvLUYWm5cJX0PcykXnY0
UbwQrfWqV5qL1CVsKBsP6M7cULsC7pbKukHO6ppVmGSbVR7ulIGE1CAAzLjc3tec5/Ul3+sF1AcN
IY5UXpgC+q/PFU4CPAX+DLRCX6QuFUt+U++fv/vzYR6Aq7HIy02TjqfqakQAFkcfZVGP1stC+OUo
C+l9ExahWzqTx6+6DdqEBbVoSYXMljSK7MA77DJ8Uj19TpAAgxVt/3Yp+9i/RHTVe+Icr43WSAXz
OcJ0gfz+V0nM0/HztNmurEo9NNuHcqK/LD7qEIz7CbEB/CFremvGFgKSvRcMcJrdACFyW+tvWjkz
cI7cEfa2zvlTmBtoADqZGul99PAGyI+zot+zpBRUiKp+8ulSmEkrPIWjP+fJjzOQoVjqAjaqQTOC
cdJ5vb15M4LgIVCLh+eru0/lSoRF+zE/9TbHB4CH3N9kSwhEpmjtkTQyyIb3D9ObTN9SKKpbslWz
khbpIyXqIu0ULMAJBIxw8lv8ClunVxV7GSm9QpZmucHFObrmiUhiFq+XLZBLeteqCC+ITlHlQEZH
FVRGJcNZFSPvg5kND8syLAF/9qb4MTB8OeImMnNrB0ovyvDNYuIk27j3GHyRwCN1l6rjFuXbH4Ty
ns9rrYRCLQS2q7VYT+BGRrUj3W/ZDTTfsrTc1+LhacQASylJUQz9Hx/U9mwIW8VkzBJNMAXz4fUe
fyKunlD5fr82z2DoBzIs/9KBBmgMgiYE2MafGLobwSTupWtBkTVtKRtj2v0kKsAFrKrB0JT4zYpr
vDrQ2cFHd87PkMsJKbK99Iuw/WeijZ0R8DKpv5LGl6pC0CsXMYcOH1Dxoxu7qJgZJFUPu3/un5UP
zY6IbnyPG7+/EbXCX+RKmqv7VJ2RDiekHZTOGfNILn6wnapsxclLIQAE234HKz7LbHOiIc3MgwRr
3mfQy8l3B70PP3ITXhu+m/lRmWSIlr+hfjper/Vai/VgZqQoMTzhdUA5nDXyjgJ96rw2jNvTRWuC
6NjhVGSAieigCbFkHx19wCBn3TvZpjVqKkWAQRwE5BSmWtnPrjYvbd8g9PhNCz/OR/nbUaNwJyhP
2C4FT8wmSAVbXSuLao5Kj0OFZOEZWwJfB805NJGEFBqfV2V5owfBDufaFzZD/25AlzDwhD18L5Ty
iH2fja1pSpXCyD18MgtjfggNRKm8DSj7TTSiSrOPbE46iV47xhPEUC+fCblmYWSayR4js/+opU9F
gOSWddWHIvgqDRJbG0sncrSm0q7WCaWyoUdPmv7FPOLqfUrCCwEW1awabSFCtC3G/Jj1PWPIPhpt
joc0k+RVnl99OIhrsdTPMuSXUl19M5UANiw4VqqrtRhZgqxqaqyWJ52YBuUcQph+lkisQcj79kCX
Nugp/+4Yx1rJu7L5IaHhfJmoeUZLEjVWIDsUTOyHR+QjFf4y2gFoP1ZtKVxu+joj5+StcAD4nsIb
gK6xTCewCmuWzLRSB8164XfgWf/n02UYFZa8uG1pOtAqwNlwkwQgQCPPAS7dZQ7zfhD4Pr8escvj
SYSESZms+Pu5zUoIe9VGy/DtjsN6DNxoCq69FnMU60rP5wYStokb4R9D1t503SYkdbLqc7afCOsm
QSCJzK4FONheZBritxaB29hhtLveZXzkcagLT8P/Vcy+cmh7KQnFegbHCgHYaxnvTG9LvXnNLY06
N3m2iCzNCouT9VDgAwxYSho3ySx9HM9bjsxy8HdhJy+uzarjNpvgDK40E8AMsIsq4DXPMqLhbD1B
R34sc4MLRYNX9uxJztHJYxiBsSQysegNMsBi2of3UAbW7yUkCK+jt3zODBeLCdxdI2E6hyMP/3em
h77JH8WOJcIFwALBAZouzD72txr2Vbj4Efa4/3dMUTK3beVIyuKkZBLdYNugCJaS5IWScXCHe+yy
h7B6Aol89o/cw0JMsgQyiNte8N6jgNvXYHFLEyjwQm5rmS/ixp9hkVuZIk6EwNkyOtKeZDHWErqp
xyDvCITORrM1AJ8bDjm73583qQ1P//43hBo0mdabxK1j76dEz5YYcNtHA5en6G6K/mMMF5IM5DM1
CPETKCyvt7NaDCevC6MqIZ1jut+R7sHCp03EVDlQHSz1a1arTw1k0fWGGd2ZcUclXq0My4mjixpY
GZSOHYvX2aNj/+lfZ9tvjEwQpth4peXAJxikQXeVU/STM8OuOKoZzszhNkcxZI/yMDMY0QBXbnt7
ThRKrcAFNqpCm5Uz3CphUQvMX6mowhTYduBW2uFFoJhmLixFoDMOtCa+NkHRe4ovRiE7ijRQjNz6
4Fy7iww+On8yhCb+gQof2Aah/wcpC66RWapn9rmqLjo1SSGCUP1LBlzQdIcYt6WRA8nQVfjbG3Pc
Ybjeojmb3FWxgfJTds756ENVnoXCE4lfqMSepER49/zJbtIsxvLzHGkVy3rptC6sNORnpVuvjOBJ
oHJf36NgMIwncXGv51Zse9+AIQuy8WQnCoRUpLjjDM2di1hBzMgA2CruOIctOBm1kyPI+ehkwqdm
mmSM1ram2zFLjqDO9suZ1WXiNVQNxkKfoZfnbzdYJ4E7ov9jk6rq7NIHuULONSVU4OWHbuUBnwbA
CenXHmHyOBHj21b6GnZufAbECne9VYcDfdWRfkP30ri2eKvo1QCMQCBLaYakhLYo+UOLzujqY5ZH
HT9jEVpWOC9eSAnXObdr1MPfhVs+WOQ3GlYSzzkc5e8Beh+Bk5Ftn8GPY/AHyJp2BmqumGsDmWnX
2PBZogCAlG66DgUne6+8Z6RjXSCmTYV5Ah1WF3jTdsUf9GD9/jVmvawc1uzx8IrwTA2bN8nanb3I
G6QrTII1yIY4/gFjkSThfiSCcjF2pk+8v17rua+VVV8L/FBlUooe3o4/wMP9DHPIoyTeEahy1+KE
PdCdj3k2988gdzgMif4l48fSWWQYiFT89DA8shTFA3ecHCteM6Au46WndlUQs+3OCA2onZAJvtIk
N1gVJZl/wV4QtZTVQsUvw7j1O6HM9dW4WPWDOgaDvu/y+3YSr1yqPoSkCSLKAow9D+w1VqNyJxjt
mU4C97s7P8PWgOiQ+dBvffM2HsIEfVikiTDlh9LGhWHp2CzBUa9xehh724HHfaULVfs2uAmuoHRl
Q+Q9GQdS9HUFhjOVhTfeznNmtKq1xsnzwfTpOpMM6oR81T1Bu6tn0sW/7HmzxNPfZNRQDlIhonx1
2WSKIisVm75xdJAsbdWfpga9WvQ25J49L4R81MNkKC8nKUWOL3VQwUW7dyNWuOw6XDShdzBpTHlD
1Rh+OfbJ0pidBaF5Wz+FuG46qe85y8f3lOptIdYIm67xHRPvn+v61wq3JA+x3HfZqyPkKSez7fLJ
eRigHalR8JbPoKzk0iG3jfanPl6ak66dVJWpogfF661/wxnS7ZJOBTgQLLTFa9s/KeYHJF56Z0iR
ibRVOS8PVh6dqTGjTc+/Q42IeHqokuzkrgYH+NUsWfx2nOwypP1Z8IrSn14HcuX1lc+aEj5qsJX7
kB/hVgkIZ+oYNv+sve4499uQkxpvML6fPXSWgjc6Qs7KPEy8JDy9O+1PWmQnwRPFza7iF4m5BubT
yMCqCeDOXib3wJorEFdqGH7G5bvMC0V94MD/t+mJBCyPhcnU9jpF/rwS5uo2JpMN4EisooEKX9bB
YzKlTXtQ12gZC9GIOCrw2toW/AqHVxh4pOOYIovZ168r9gxPPJjQgXUMdLsZZxfKxzXwh9I9r/UK
FeErqocae1haPtVZSypeEFuPF8CXy74O/npRKgkH+YO2tj/aNGWWWrgy7cy2c8GXLUN6kyCbTWj0
M+T8l2nyX4AoY+x3qWFnbvgHu4xImctraASernu+LxDWSkcMzbf6Ch1KYfiGGK2cL1PgiM2ZCjAx
GqfCJwW6vjOOhWYbDr41PDg6uz1tnh5AAIKd5eZP0oMD7VMYGj6VfS92IyqZoD0Ru2rwb2JMSKCm
2ruG9HSLADmaQYAyHIPX6/3jXy6IAnqGopy5jrZyh0+c4HqEyWsmyDFT+BVrmTDkoebULMdhcxH5
jAUbWg974O/VzpcLKAUwaBXDilGZhjZsIRcin5XvXe9B5PW8pS/CBTNKVli1gR2ao1yyCgPhr2yl
ySEJ9NrQq8KImcsouF3Z2x5DwuW82IeFWHUegogUVUitBRQ3hNYdodhMIVStC2A/op3r5zX/Q/WJ
kh13d0v0neJRzf2OgD4oIgO5oFpbbyi0s6hBhy3ppC6O2m9AJaltD/R9RAjEHPjJ+06n6x9fpP9A
RgASOKN4STpPtGhLR2rpomiVd33+9UwAQfJiFHPBCiW7rrglQ/ka1DYYBbGGuy1BgHSffpOXUJpN
sczoKn08slaBxJSiG5OAU8W1AgNCKD9KKrq6xNNfiU/GspQ/nhewX4hnohIUSuJPnvuUOdb43aLH
a+24I0zPUZ86qrN1cZboHZZim3n3o6JlNhcnNpZ0EnBJWkw4fW0ZDcP+mTWiziK1rFCKv+MzBsSo
6jE7WoTNZtRxzqtJ8WYHv+L5RbRb7nJ5bMcxzQxFnQr20hAXoEqZMVW3pNDNBg0UDYSvK9H+lEp4
jKAxhLvElot/tWPYwh805UMMP37guEcO649w7OUQg0MwNgmMvC5BuaNgNzp+eTFIWOZfcsXLDmQi
LTBf4v8l/Y0EpVLs11K3nSQe97c9Gao9yTzm6hhC7AgsB/8WIgizQ13FNexHmwxEdIRXu3K7R0Or
rXE3fEZD5P6uE5w812d9NoBLJOOghqeT1/fguavaRjTcgeBpJTUC8U5Ms2rDK8Qd6VMTjhJxFkIf
12rvvC88w5tP01vYpg2D3b/Br8vLUcJy6c1H4gvZoLZFiS8ZKYvkKaLTRwt59oKLcwpa9fqLkzsO
uiz3PK4eR8Ne24f0kJmmqVjdHAFcl1586awvJBkthdkUtbnqCnWd71tDREpO7l2lysL0/SrP08aS
oE35ZoW5t/El2HSkrmkDY4sUuJitJSrp4o7FFRpdMETc9qPg6MytNmuzGwddYofjIg2i+BPfetjJ
LmVCI5Ows9W98qTrpCqImGG+Y3gPN8Ej8zCLPQZm0xNUGExnGwglsOZn7qhtYGadlJSRHvDqn9zh
AzVtjBuu1Qva4H55NSCi3VSHaArBopOlL7rBC129gRFym6h43BMkhwr4FhnGXXYjVZw4SXSnixUi
77eTMAWEe8f8qXWobMFTb8VJWENG5wefVbvTTLsQQxLQ80fvXe5Lt/09Aog1eNtTCRAeQQxOKOYT
ck9zj7BcBNrizHCo7RYec0DqhkTME3YwkGwFLaRrX7na8ZAay7O+f0zqKuCBLH1ylrd9bINCqaGe
Cv+gqCY4+u/ynnBf8vwxqOx02DtaTJ/8UNBaZEUdyue5/rSy/4lDTOC2uEMP2fvw0U2JoODtjHUP
0UwfK0TpKw4arLPxW39+exo/J/b+5j13KYIJ0MQHKH5FF8caUKh8S8xJRwUAfaZz9XDlgHpX5eqs
vVbk2QV35QLMLKWp5ft5kFuXxU8NKQyeHJrfxoksRMqD/heqvYMHf7XGIEBw0MdXpPLG2/0JkYeb
tKV3ar5NZYO5rRwRBYO/HaJ56cdY7o9zkJNVeDUaMnextXLLwRN5JfFQLCTLaPOo/RenH99qAt7e
2ESO/Evmxhbyq0L/jZhkmncUKeZrQxArj/cnJfutdAcdCleUtl2ku7873iFNNNBk1afkOAE8nUG2
wLhFYw0NxxPpsA5zgim0aVc92vDsgXmiBrgHtpVR1bQsBDcrPMDi38IdnCJJ6Ebk0x72NILQCZMI
4JeN4KxPXGIMEcxq8c3AVW3ttz0BXeYsczpvf0wUnggoWcaLINgv6sY5zKmVrfM1/aVSFqV4hXsF
h30eZDhj/qsLDghxwcMMkc9WH2VTJE2NMVBLv060zBpobYqIQQPCewZKZbyUApeixpJFqdkPqbCU
5pkAGMUFzVjfDysOhYFzfvI7YUiwC4oaufhLw87gsSnaTbFW7pa2l/Ur1Ebwx4BHrVvr3080nmGC
yVCn5oDBBWnHB08Ipm3huQnonc3U5GD03dir/L7wtios0uqbAAODRNvgBVg617TheX3pusEZMOXU
ezHlQ/y1KBx823V/blBFDlbD13lFzfZyhEeEPaiXH09O9WijgCRKingpeSXVuH1IidNF0DU5Sh0n
5R/BUyC7H6KdEMLJ2OMS82RWm6krrCo3cNmRch9CjkZX7ElxDcZ2ZnYxOzrqIDSWf7CPJ9OIsQms
V2PekUIGxUEPSwVTcV/BuWo5w7G0aKkeqjRZH/+K+5jrER1h438TN3CMO0VsbZTU7NkXnunMdeEH
f5OkAr5d6YCs8TmMH0WgCPvfTdF/Qk8hqGSj7unHgdHRt6r0fs2ZSz+UMsuJk9hv5BUue45x7Bg+
83dPbi4MiuXCx2RFSk2JswNGFhv47v1c1CUWiWNYlF0++8403tzdC9qkOQFQslZxYEL6TpIP/Eza
DAp0KqvVzlh7QlHmwKqQZ1QOs3QH2Hjz9rO/LZGS1jvIteeD3kLvI1vJQkuwyKhhU3f9KbtcS98t
HAavZBYoFBKI4YyCK2kZBVqMh/mZMr6yK1tLBrAxrbK3WULRLXi+fhfVh2bU54Ps1i4BKMeI0nlp
4mcfUMI6yfNX3ePDbDKi9543z+Twh8kynKUPnRCzDylaLk75PjfTTJes3DBEvfj7KvqwE2RA08WN
9RtUY7Dbt6qWktNzg0mSAOdJv3VWADdGSSIEqNN7AAGY4AOAsGMYrUrZscRn+wIAAAAABFla
--000000000000f65438061de2e060
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--000000000000f65438061de2e060--
