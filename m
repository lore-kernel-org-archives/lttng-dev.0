Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FB4C3DA42
	for <lttng-dev@archiver.kernel.org>; Thu, 11 Jul 2024 01:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1720662838;
	bh=13FA/Z5zLcpoTl/OZeJtmborQxIvnhJ1kkuMsAl5Cmw=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=irZOZ1QbpuIEwveBDTTp5KPG/rqzPQOm6RdCFqdjMyh2BwhsAW+YTjWp60XbD/9Se
	 is61SrJdUVBHm7Pyt99oCsHsvM3oF44paHp34rZL1JPxJP9pjFS7yA4ERQeFWXyUO6
	 V8X7OoddcFjiereT1NXPavfHqVd92u05wVM1dpr9jDeGVIapoTPQ5utOiD2g4qGMgY
	 6YEc1fGIthWLWLjwnH8RVuOFXQFFUvpUP3n/K9kV0TJZRHmknKyns02KcNimuUFkaH
	 u8lVQrQXzbBZuxyWjPWjpz7dP3cDgx1X8+NFreWJNsPdbgcIlk0YxZhOi/Yjab2gnV
	 SlmOj/tSEed6w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WKHny14SxzBHH;
	Wed, 10 Jul 2024 21:53:58 -0400 (EDT)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by lists.lttng.org (Postfix) with ESMTPS id 4WKHnw6X4rzBKD
 for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2024 21:53:56 -0400 (EDT)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c1a4192d55so312501a91.2
 for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2024 18:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720662835; x=1721267635;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MzVPsC3pRTstJ3u8YpsGerzSQnAJasCCCgtyUzmEeaY=;
 b=nAxXputjL/q9KJZQt1BQEA376ATKL6DXu+69VRX/SE4FA355hTMx59S3OiUMutxBiV
 4VHHTaPsrMUkzGeasqU6uzJe+1kcgBOyU/v22GnTbxofLICRx/cz9EtutRe5WvnBvkCc
 wJV9cJHRfLx0p7HVJOu/DlMVEItyJhlaDm1+YVUB7AbR+IMLJyAKPwkcmgzh94e2CznS
 eaWBxgzQ0DWf0e/q69WV0f5nMVT/bh6gzEU2otYwnK9xTWWsQVNr8zsshz9QVcbMLab1
 04sL4fxjfVorUuZWB5rm8P76FZxKc8UR4O19DIBQQbaZ8z9x9SRj8E//ag+Lv6hHmBQJ
 2TSg==
X-Gm-Message-State: AOJu0YxSz8j/xSDcKinO/Cg3rzLWNxxdb9TduRRVE14pHalojPjQBOfM
 zYIVrwZcvP26OCrbw4vWU+BDsMkkjCRi3v6pcRBH/zmr5EiKEAEUk5FxLsFBhvSskcjAsMU1TFk
 MRisfseKv4ozsuOTOGCWHwxNMAbxKOKC9
X-Google-Smtp-Source: AGHT+IGz038Rp7QtF5j87rO9T8jzQi9uNfz1j7DNRPNkenbB/vXHwzpdFfK7Bv5mr0SAhL0vllcnD2J48Uxe2dTXrVM=
X-Received: by 2002:a17:90a:c386:b0:2c2:deec:8cfb with SMTP id
 98e67ed59e1d1-2ca35be1a22mr5854283a91.6.1720662834859; Wed, 10 Jul 2024
 18:53:54 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 21:53:43 -0400
Message-ID: <CAFZh4h_wh01sjAar-QqHsQ=KY4zLjmpmXuJc83OeYue7YyYW3A@mail.gmail.com>
To: lttng-dev@lists.lttng.org, yocto@yoctoproject.org
Subject: [lttng-dev] Using lttng-ust 2.13.6 from Yocto Kirkstone and getting
 weird segfault saying strlen_asimd.S can't be found.
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
Content-Type: multipart/mixed; boundary="===============8605111398632138295=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8605111398632138295==
Content-Type: multipart/alternative; boundary="0000000000000cd9d1061cef097c"

--0000000000000cd9d1061cef097c
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm getting a weird segfault when I compile in a lttng-ust tracepoint into
my application.

I'm able to run the lttng-ust hello_world example just fine on my platform
which one would think should prove everything out, but when I use the exact
same hello world trace provider and link it into my multi-threadded app and
simply call:

lttng_ust_tracepoint(hello_world, my_first_tracepoint, 23,
            "hi there!");

I get a segfault.

Background.  I'm on aarch64 platform (imx8mm-lpddr4-evk) with sdk (gcc 11.4
glibc 2.35) and rootfs generated from Yocto Kirkstone 4.0.18.  Built
lttng-tools (2.13.9) and lttng-ust (2.13.6) from yocto recipe.  Built
out-of-tree kernel modules for lttng-modules (2.13.9) and I'm on kernel
6.1.38.

If I do a backtrace with gdb on the core this is what I see:

GNU gdb (GDB) 11.2
Copyright (C) 2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "aarch64-poky-linux".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
   <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./my_app...

warning: core file may not match specified executable file.
[New LWP 757]
[New LWP 759]
[New LWP 758]
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/libthread_db.so.1".
Core was generated by `./my_app'.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  __strlen_asimd () at ../sysdeps/aarch64/multiarch/strlen_asimd.S:96
96      ../sysdeps/aarch64/multiarch/strlen_asimd.S: No such file or
directory.
[Current thread is 1 (Thread 0xffffb8e2d040 (LWP 757))]
(gdb) bt
#0  __strlen_asimd () at ../sysdeps/aarch64/multiarch/strlen_asimd.S:96
#1  0x0000ffffb86c5330 in lttng_ust_tracepoint_module_register () from
/usr/lib/liblttng-ust-tracepoint.so.1
#2  0x0000aaaab4c8da18 in lttng_ust__tracepoints__ptrs_init () at
/opt/poky/4.0.18/sysroots/cortexa53-crypto-poky-linux/usr/include/lttng/tracepoint.h:629

#3  0x0000ffffb872b30c in call_init (env=<optimized out>,
argv=0xffffe2d66098, argc=1) at ../csu/libc-start.c:145
#4  __libc_start_main_impl (main=0xaaaab4bd94e0 <main>, argc=1,
argv=0xffffe2d66098, init=<optimized out>, fini=<optimized out>,
rtld_fini=<optimized out>, stack_end=<optimized out>) at
../csu/libc-start.c:376
#5  0x0000aaaab4bd9230 in _start () at ../sysdeps/aarch64/start.S:81
(gdb)

If I run valgrind, this is what I see:

==627== Memcheck, a memory error detector
==627== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==627== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info
==627== Command: ./my_app
==627==
LTTng-UST: Error while registering tracepoint probe.
==627==
==627== Process terminating with default action of signal 6 (SIGABRT)
==627==    at 0x6772278: __pthread_kill_implementation (pthread_kill.c:44)
==627==    by 0x672DD4F: raise (raise.c:26)
==627==    by 0x671AEE3: abort (abort.c:79)
==627==    by 0x2C572B: lttng_ust__events_init__hello_world
(ust-tracepoint-event.h:1221)
==627==    by 0x2C5B97: lttng_ust_constructor_hello_world
(ust-tracepoint-event.h:1239)
==627==    by 0x671B30B: call_init (libc-start.c:145)
==627==    by 0x671B30B: __libc_start_main@@GLIBC_2.34 (libc-start.c:376)
==627==    by 0x21122F: (below main) (start.S:81)
==627==
==627== HEAP SUMMARY:
==627==     in use at exit: 151,712 bytes in 90 blocks
==627==   total heap usage: 1,184 allocs, 1,094 frees, 202,570 bytes
allocated
==627==
==627== 48 bytes in 1 blocks are still reachable in loss record 1 of 17
==627==    at 0x618A790: calloc (vg_replace_malloc.c:1328)
==627==    by 0x68D50CB: lttng_ust_tracepoint_module_register (in
/usr/lib/liblttng-ust-tracepoint.so.1.0.0)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== 48 bytes in 1 blocks are still reachable in loss record 2 of 17
==627==    at 0x618A790: calloc (vg_replace_malloc.c:1328)
==627==    by 0x61E8143: lttng_ust_probe_register (in
/usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x61FD49B: ??? (in /usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== 48 bytes in 1 blocks are still reachable in loss record 3 of 17
==627==    at 0x618A790: calloc (vg_replace_malloc.c:1328)
==627==    by 0x61E8143: lttng_ust_probe_register (in
/usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x61DFF4F: ??? (in /usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== 48 bytes in 1 blocks are still reachable in loss record 4 of 17
==627==    at 0x618A790: calloc (vg_replace_malloc.c:1328)
==627==    by 0x61E8143: lttng_ust_probe_register (in
/usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x61E026F: ??? (in /usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== 48 bytes in 1 blocks are still reachable in loss record 5 of 17
==627==    at 0x618A790: calloc (vg_replace_malloc.c:1328)
==627==    by 0x61E8143: lttng_ust_probe_register (in
/usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x61E058F: ??? (in /usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== 48 bytes in 1 blocks are still reachable in loss record 6 of 17
==627==    at 0x618A790: calloc (vg_replace_malloc.c:1328)
==627==    by 0x68D50CB: lttng_ust_tracepoint_module_register (in
/usr/lib/liblttng-ust-tracepoint.so.1.0.0)
==627==    by 0x2C5A17: lttng_ust__tracepoints__ptrs_init
(tracepoint.h:629)
==627==    by 0x671B30B: call_init (libc-start.c:145)
==627==    by 0x671B30B: __libc_start_main@@GLIBC_2.34 (libc-start.c:376)
==627==    by 0x21122F: (below main) (start.S:81)
==627==
==627== 128 bytes in 1 blocks are still reachable in loss record 7 of 17
==627==    at 0x618551C: malloc (vg_replace_malloc.c:381)
==627==    by 0x68A388B: ??? (in /usr/lib/liblttng-ust-common.so.1.0.0)
==627==    by 0x68A2FBF: lttng_ust_common_ctor (in
/usr/lib/liblttng-ust-common.so.1.0.0)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== 200 bytes in 1 blocks are still reachable in loss record 8 of 17
==627==    at 0x618551C: malloc (vg_replace_malloc.c:381)
==627==    by 0x5929E37: malloc (rtld-malloc.h:56)
==627==    by 0x5929E37: add_to_global_resize (dl-open.c:152)
==627==    by 0x592AA8F: dl_open_worker_begin (dl-open.c:716)
==627==    by 0x681D877: _dl_catch_exception (dl-error-skeleton.c:208)
==627==    by 0x5929C77: dl_open_worker (dl-open.c:782)
==627==    by 0x681D877: _dl_catch_exception (dl-error-skeleton.c:208)
==627==    by 0x592A07B: _dl_open (dl-open.c:884)
==627==    by 0x676C467: dlopen_doit (dlopen.c:56)
==627==    by 0x681D877: _dl_catch_exception (dl-error-skeleton.c:208)
==627==    by 0x681D92F: _dl_catch_error (dl-error-skeleton.c:227)
==627==    by 0x676BF4F: _dlerror_run (dlerror.c:138)
==627==    by 0x676C52B: dlopen_implementation (dlopen.c:71)
==627==    by 0x676C52B: dlopen@@GLIBC_2.34 (dlopen.c:81)
==627==
==627== 240 bytes in 2 blocks are still reachable in loss record 9 of 17
==627==    at 0x618551C: malloc (vg_replace_malloc.c:381)
==627==    by 0x59214C7: malloc (rtld-malloc.h:56)
==627==    by 0x59214C7: _dl_map_object_deps (dl-deps.c:479)
==627==    by 0x592A50B: dl_open_worker_begin (dl-open.c:592)
==627==    by 0x681D877: _dl_catch_exception (dl-error-skeleton.c:208)
==627==    by 0x5929C77: dl_open_worker (dl-open.c:782)
==627==    by 0x681D877: _dl_catch_exception (dl-error-skeleton.c:208)
==627==    by 0x592A07B: _dl_open (dl-open.c:884)
==627==    by 0x676C467: dlopen_doit (dlopen.c:56)
==627==    by 0x681D877: _dl_catch_exception (dl-error-skeleton.c:208)
==627==    by 0x681D92F: _dl_catch_error (dl-error-skeleton.c:227)
==627==    by 0x676BF4F: _dlerror_run (dlerror.c:138)
==627==    by 0x676C52B: dlopen_implementation (dlopen.c:71)
==627==    by 0x676C52B: dlopen@@GLIBC_2.34 (dlopen.c:81)
==627==
==627== 292 bytes in 15 blocks are possibly lost in loss record 10 of 17
==627==    at 0x618551C: malloc (vg_replace_malloc.c:381)
==627==    by 0x6783993: strdup (strdup.c:42)
==627==    by 0x61FD92F: ??? (in /usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x681DA9F: dl_iterate_phdr (dl-iteratephdr.c:74)
==627==    by 0x61FE653: lttng_ust_dl_update (in
/usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x61DE83B: ??? (in /usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== 336 bytes in 1 blocks are possibly lost in loss record 11 of 17
==627==    at 0x618A790: calloc (vg_replace_malloc.c:1328)
==627==    by 0x592ECB7: calloc (rtld-malloc.h:44)
==627==    by 0x592ECB7: allocate_dtv (dl-tls.c:376)
==627==    by 0x592F723: _dl_allocate_tls (dl-tls.c:635)
==627==    by 0x677114F: allocate_stack (allocatestack.c:428)
==627==    by 0x677114F: pthread_create@@GLIBC_2.34 (pthread_create.c:647)
==627==    by 0x61DEF03: ??? (in /usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== 336 bytes in 1 blocks are possibly lost in loss record 12 of 17
==627==    at 0x618A790: calloc (vg_replace_malloc.c:1328)
==627==    by 0x592ECB7: calloc (rtld-malloc.h:44)
==627==    by 0x592ECB7: allocate_dtv (dl-tls.c:376)
==627==    by 0x592F723: _dl_allocate_tls (dl-tls.c:635)
==627==    by 0x677114F: allocate_stack (allocatestack.c:428)
==627==    by 0x677114F: pthread_create@@GLIBC_2.34 (pthread_create.c:647)
==627==    by 0x61DEEB7: ??? (in /usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== 340 bytes in 17 blocks are possibly lost in loss record 13 of 17
==627==    at 0x618A790: calloc (vg_replace_malloc.c:1328)
==627==    by 0x61FD94F: ??? (in /usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x681DA9F: dl_iterate_phdr (dl-iteratephdr.c:74)
==627==    by 0x61FE653: lttng_ust_dl_update (in
/usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x61DE83B: ??? (in /usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== 1,248 bytes in 26 blocks are still reachable in loss record 14 of
17
==627==    at 0x618A790: calloc (vg_replace_malloc.c:1328)
==627==    by 0x68D529F: lttng_ust_tracepoint_module_register (in
/usr/lib/liblttng-ust-tracepoint.so.1.0.0)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== 4,608 bytes in 2 blocks are possibly lost in loss record 15 of 17
==627==    at 0x618551C: malloc (vg_replace_malloc.c:381)
==627==    by 0x5922FFB: malloc (rtld-malloc.h:56)
==627==    by 0x5922FFB: _dlfo_mappings_segment_allocate
(dl-find_object.c:217)
==627==    by 0x5922FFB: _dl_find_object_update_1 (dl-find_object.c:671)
==627==    by 0x5922FFB: _dl_find_object_update (dl-find_object.c:805)
==627==    by 0x592A803: dl_open_worker_begin (dl-open.c:735)
==627==    by 0x681D877: _dl_catch_exception (dl-error-skeleton.c:208)
==627==    by 0x5929C77: dl_open_worker (dl-open.c:782)
==627==    by 0x681D877: _dl_catch_exception (dl-error-skeleton.c:208)
==627==    by 0x592A07B: _dl_open (dl-open.c:884)
==627==    by 0x676C467: dlopen_doit (dlopen.c:56)
==627==    by 0x681D877: _dl_catch_exception (dl-error-skeleton.c:208)
==627==    by 0x681D92F: _dl_catch_error (dl-error-skeleton.c:227)
==627==    by 0x676BF4F: _dlerror_run (dlerror.c:138)
==627==    by 0x676C52B: dlopen_implementation (dlopen.c:71)
==627==    by 0x676C52B: dlopen@@GLIBC_2.34 (dlopen.c:81)
==627==
==627== 70,992 bytes in 17 blocks are possibly lost in loss record 16 of 17
==627==    at 0x618A790: calloc (vg_replace_malloc.c:1328)
==627==    by 0x61FD91B: ??? (in /usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x681DA9F: dl_iterate_phdr (dl-iteratephdr.c:74)
==627==    by 0x61FE653: lttng_ust_dl_update (in
/usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x61DE83B: ??? (in /usr/lib/liblttng-ust.so.1.0.0)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== 72,704 bytes in 1 blocks are still reachable in loss record 17 of
17
==627==    at 0x618551C: malloc (vg_replace_malloc.c:381)
==627==    by 0x653E137: ??? (in /usr/lib/libstdc++.so.6.0.29)
==627==    by 0x5923653: call_init.part.0 (dl-init.c:74)
==627==    by 0x5923767: call_init (dl-init.c:29)
==627==    by 0x5923767: _dl_init (dl-init.c:121)
==627==    by 0x5935D37: ??? (in /lib/ld-linux-aarch64.so.1)
==627==
==627== LEAK SUMMARY:
==627==    definitely lost: 0 bytes in 0 blocks
==627==    indirectly lost: 0 bytes in 0 blocks
==627==      possibly lost: 76,904 bytes in 53 blocks
==627==    still reachable: 74,808 bytes in 37 blocks
==627==         suppressed: 0 bytes in 0 blocks
==627==
==627== For lists of detected and suppressed errors, rerun with: -s
==627== ERROR SUMMARY: 6 errors from 6 contexts (suppressed: 0 from 0)
Aborted

I'm sure I'm probably doing something wrong but I've tried static linking,
dynamic linking using LD_PRELOAD helpers like
LD_PRELOAD=liblttng-ust-pthread-wrapper.so.1:liblttng-ust-fd.so.1:liblttng-ust-fork.so.1
and I'm out of options that I know to try.

Looking for pointers on what else I can try and what I could be doing wrong.

I had this same segfault issue using Dunfell version of Yocto and earlier
versions of lttng (2.11) but never dug into it because was planning on
upgrading everything soon, so recently stepped up to newer versions of
everything to see if that solved the issue but apparently not.

Regards,

Brian

--0000000000000cd9d1061cef097c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I&#39;m getting a weird =
segfault when I compile in a lttng-ust tracepoint into my application.</div=
><div><br></div><div>I&#39;m able to run the lttng-ust hello_world example =
just fine on my platform which one would think should prove everything out,=
 but when I use the exact same hello world trace provider and link it into =
my multi-threadded app and simply call:=C2=A0 <br><pre class=3D"gmail-src">=
<span class=3D"gmail-n">lttng_ust_tracepoint</span><span class=3D"gmail-p">=
(</span><span class=3D"gmail-n">hello_world</span><span class=3D"gmail-p">,=
</span><span class=3D"gmail-w"> </span><span class=3D"gmail-n">my_first_tra=
cepoint</span><span class=3D"gmail-p">,</span><span class=3D"gmail-w"> </sp=
an><span class=3D"gmail-mi">23</span><span class=3D"gmail-p">,</span>
<span class=3D"gmail-w">                         </span><span class=3D"gmai=
l-s">&quot;hi there!&quot;</span><span class=3D"gmail-p">);</span></pre></d=
iv><div>I get a segfault.</div><div><br></div><div>Background.=C2=A0 I&#39;=
m on aarch64 platform (imx8mm-lpddr4-evk) with sdk (gcc 11.4 glibc 2.35) an=
d rootfs generated from Yocto Kirkstone 4.0.18.=C2=A0 Built lttng-tools (2.=
13.9) and lttng-ust (2.13.6) from yocto recipe.=C2=A0 Built out-of-tree ker=
nel modules for lttng-modules (2.13.9) and I&#39;m on kernel 6.1.38.</div><=
div><br></div><div>If I do a backtrace with gdb on the core this is what I =
see:</div><div><br></div><div><span style=3D"font-family:monospace"><span s=
tyle=3D"font-weight:bold;color:rgb(0,0,0);background-color:rgb(255,255,255)=
">GNU gdb (GDB) 11.2</span><span style=3D"color:rgb(0,0,0);background-color=
:rgb(255,255,255)">
</span><br>Copyright (C) 2022 Free Software Foundation, Inc.
<br>License GPLv3+: GNU GPL version 3 or later &lt;<a href=3D"http://gnu.or=
g/licenses/gpl.html">http://gnu.org/licenses/gpl.html</a>&gt;
<br>This is free software: you are free to change and redistribute it.
<br>There is NO WARRANTY, to the extent permitted by law.
<br>Type &quot;show copying&quot; and &quot;show warranty&quot; for details=
.
<br>This GDB was configured as &quot;aarch64-poky-linux&quot;.
<br>Type &quot;show configuration&quot; for configuration details.
<br>For bug reporting instructions, please see:
<br>&lt;<a href=3D"https://www.gnu.org/software/gdb/bugs/">https://www.gnu.=
org/software/gdb/bugs/</a>&gt;.
<br>Find the GDB manual and other documentation resources online at:
<br> =C2=A0=C2=A0=C2=A0&lt;<a href=3D"http://www.gnu.org/software/gdb/docum=
entation/">http://www.gnu.org/software/gdb/documentation/</a>&gt;.
<br>
<br>For help, type &quot;help&quot;.
<br>Type &quot;apropos word&quot; to search for commands related to &quot;w=
ord&quot;...
<br>Reading symbols from ./my_app...
<br>
<br>warning: core file may not match specified executable file.
<br>[New LWP 757]
<br>[New LWP 759]
<br>[New LWP 758]
<br>[Thread debugging using libthread_db enabled]
<br>Using host libthread_db library &quot;/lib/libthread_db.so.1&quot;.
<br>Core was generated by `./my_app&#39;.
<br>Program terminated with signal SIGSEGV, Segmentation fault.
<br>#0 =C2=A0__strlen_asimd () at ../sysdeps/aarch64/multiarch/strlen_asimd=
.S:96
<br>96 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0../sysdeps/aarch64/multiarch/strlen_as=
imd.S: No such file or directory.
<br>[Current thread is 1 (Thread 0xffffb8e2d040 (LWP 757))]
<br>(gdb) bt
<br>#0 =C2=A0__strlen_asimd () at ../sysdeps/aarch64/multiarch/strlen_asimd=
.S:96
<br>#1 =C2=A00x0000ffffb86c5330 in lttng_ust_tracepoint_module_register () =
from /usr/lib/liblttng-ust-tracepoint.so.1
<br>#2 =C2=A00x0000aaaab4c8da18 in lttng_ust__tracepoints__ptrs_init () at =
/opt/poky/4.0.18/sysroots/cortexa53-crypto-poky-linux/usr/include/lttng/tra=
cepoint.h:629
<br>#3 =C2=A00x0000ffffb872b30c in call_init (env=3D&lt;optimized out&gt;, =
argv=3D0xffffe2d66098, argc=3D1) at ../csu/libc-start.c:145
<br>#4 =C2=A0__libc_start_main_impl (main=3D0xaaaab4bd94e0 &lt;main&gt;, ar=
gc=3D1, argv=3D0xffffe2d66098, init=3D&lt;optimized out&gt;, fini=3D&lt;opt=
imized out&gt;, rtld_fini=3D&lt;optimized out&gt;, stack_end=3D&lt;optimize=
d out&gt;) at ../csu/libc-start.c:376
<br>#5 =C2=A00x0000aaaab4bd9230 in _start () at ../sysdeps/aarch64/start.S:=
81
<br>(gdb)<br></span></div><div><span style=3D"font-family:monospace"><br></=
span></div><div><span style=3D"font-family:monospace">If I run valgrind, th=
is is what I see:</span></div><div><span style=3D"font-family:monospace"><b=
r></span></div><div><span style=3D"font-family:monospace"><span style=3D"co=
lor:rgb(0,0,0);background-color:rgb(255,255,255)">=3D=3D627=3D=3D Memcheck,=
 a memory error detector
</span><br>=3D=3D627=3D=3D Copyright (C) 2002-2017, and GNU GPL&#39;d, by J=
ulian Seward et al.
<br>=3D=3D627=3D=3D Using Valgrind-3.18.1 and LibVEX; rerun with -h for cop=
yright info
<br>=3D=3D627=3D=3D Command: ./my_app
<br>=3D=3D627=3D=3D =C2=A0<br>LTTng-UST: Error while registering tracepoint=
 probe.
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D Process terminating with defa=
ult action of signal 6 (SIGABRT)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x6772278: __pthread_kill_implemen=
tation (pthread_kill.c:44)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x672DD4F: raise (raise.c:26)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x671AEE3: abort (abort.c:79)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x2C572B: lttng_ust__events_init__=
hello_world (ust-tracepoint-event.h:1221)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x2C5B97: lttng_ust_constructor_he=
llo_world (ust-tracepoint-event.h:1239)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x671B30B: call_init (libc-start.c=
:145)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x671B30B: __libc_start_main@@GLIB=
C_2.34 (libc-start.c:376)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x21122F: (below main) (start.S:81=
)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D HEAP SUMMARY:
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0=C2=A0in use at exit: 151,712 bytes i=
n 90 blocks
<br>=3D=3D627=3D=3D =C2=A0=C2=A0total heap usage: 1,184 allocs, 1,094 frees=
, 202,570 bytes allocated
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 48 bytes in 1 blocks are stil=
l reachable in loss record 1 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618A790: calloc (vg_replace_mall=
oc.c:1328)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x68D50CB: lttng_ust_tracepoint_mo=
dule_register (in /usr/lib/liblttng-ust-tracepoint.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 48 bytes in 1 blocks are stil=
l reachable in loss record 2 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618A790: calloc (vg_replace_mall=
oc.c:1328)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61E8143: lttng_ust_probe_registe=
r (in /usr/lib/liblttng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61FD49B: ??? (in /usr/lib/libltt=
ng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 48 bytes in 1 blocks are stil=
l reachable in loss record 3 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618A790: calloc (vg_replace_mall=
oc.c:1328)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61E8143: lttng_ust_probe_registe=
r (in /usr/lib/liblttng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61DFF4F: ??? (in /usr/lib/libltt=
ng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 48 bytes in 1 blocks are stil=
l reachable in loss record 4 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618A790: calloc (vg_replace_mall=
oc.c:1328)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61E8143: lttng_ust_probe_registe=
r (in /usr/lib/liblttng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61E026F: ??? (in /usr/lib/libltt=
ng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 48 bytes in 1 blocks are stil=
l reachable in loss record 5 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618A790: calloc (vg_replace_mall=
oc.c:1328)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61E8143: lttng_ust_probe_registe=
r (in /usr/lib/liblttng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61E058F: ??? (in /usr/lib/libltt=
ng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 48 bytes in 1 blocks are stil=
l reachable in loss record 6 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618A790: calloc (vg_replace_mall=
oc.c:1328)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x68D50CB: lttng_ust_tracepoint_mo=
dule_register (in /usr/lib/liblttng-ust-tracepoint.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x2C5A17: lttng_ust__tracepoints__=
ptrs_init (tracepoint.h:629)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x671B30B: call_init (libc-start.c=
:145)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x671B30B: __libc_start_main@@GLIB=
C_2.34 (libc-start.c:376)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x21122F: (below main) (start.S:81=
)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 128 bytes in 1 blocks are sti=
ll reachable in loss record 7 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618551C: malloc (vg_replace_mall=
oc.c:381)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x68A388B: ??? (in /usr/lib/libltt=
ng-ust-common.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x68A2FBF: lttng_ust_common_ctor (=
in /usr/lib/liblttng-ust-common.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 200 bytes in 1 blocks are sti=
ll reachable in loss record 8 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618551C: malloc (vg_replace_mall=
oc.c:381)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5929E37: malloc (rtld-malloc.h:5=
6)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5929E37: add_to_global_resize (d=
l-open.c:152)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x592AA8F: dl_open_worker_begin (d=
l-open.c:716)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681D877: _dl_catch_exception (dl=
-error-skeleton.c:208)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5929C77: dl_open_worker (dl-open=
.c:782)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681D877: _dl_catch_exception (dl=
-error-skeleton.c:208)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x592A07B: _dl_open (dl-open.c:884=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x676C467: dlopen_doit (dlopen.c:5=
6)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681D877: _dl_catch_exception (dl=
-error-skeleton.c:208)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681D92F: _dl_catch_error (dl-err=
or-skeleton.c:227)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x676BF4F: _dlerror_run (dlerror.c=
:138)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x676C52B: dlopen_implementation (=
dlopen.c:71)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x676C52B: dlopen@@GLIBC_2.34 (dlo=
pen.c:81)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 240 bytes in 2 blocks are sti=
ll reachable in loss record 9 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618551C: malloc (vg_replace_mall=
oc.c:381)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x59214C7: malloc (rtld-malloc.h:5=
6)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x59214C7: _dl_map_object_deps (dl=
-deps.c:479)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x592A50B: dl_open_worker_begin (d=
l-open.c:592)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681D877: _dl_catch_exception (dl=
-error-skeleton.c:208)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5929C77: dl_open_worker (dl-open=
.c:782)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681D877: _dl_catch_exception (dl=
-error-skeleton.c:208)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x592A07B: _dl_open (dl-open.c:884=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x676C467: dlopen_doit (dlopen.c:5=
6)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681D877: _dl_catch_exception (dl=
-error-skeleton.c:208)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681D92F: _dl_catch_error (dl-err=
or-skeleton.c:227)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x676BF4F: _dlerror_run (dlerror.c=
:138)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x676C52B: dlopen_implementation (=
dlopen.c:71)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x676C52B: dlopen@@GLIBC_2.34 (dlo=
pen.c:81)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 292 bytes in 15 blocks are po=
ssibly lost in loss record 10 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618551C: malloc (vg_replace_mall=
oc.c:381)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x6783993: strdup (strdup.c:42)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61FD92F: ??? (in /usr/lib/libltt=
ng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681DA9F: dl_iterate_phdr (dl-ite=
ratephdr.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61FE653: lttng_ust_dl_update (in=
 /usr/lib/liblttng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61DE83B: ??? (in /usr/lib/libltt=
ng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 336 bytes in 1 blocks are pos=
sibly lost in loss record 11 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618A790: calloc (vg_replace_mall=
oc.c:1328)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x592ECB7: calloc (rtld-malloc.h:4=
4)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x592ECB7: allocate_dtv (dl-tls.c:=
376)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x592F723: _dl_allocate_tls (dl-tl=
s.c:635)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x677114F: allocate_stack (allocat=
estack.c:428)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x677114F: pthread_create@@GLIBC_2=
.34 (pthread_create.c:647)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61DEF03: ??? (in /usr/lib/libltt=
ng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 336 bytes in 1 blocks are pos=
sibly lost in loss record 12 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618A790: calloc (vg_replace_mall=
oc.c:1328)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x592ECB7: calloc (rtld-malloc.h:4=
4)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x592ECB7: allocate_dtv (dl-tls.c:=
376)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x592F723: _dl_allocate_tls (dl-tl=
s.c:635)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x677114F: allocate_stack (allocat=
estack.c:428)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x677114F: pthread_create@@GLIBC_2=
.34 (pthread_create.c:647)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61DEEB7: ??? (in /usr/lib/libltt=
ng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 340 bytes in 17 blocks are po=
ssibly lost in loss record 13 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618A790: calloc (vg_replace_mall=
oc.c:1328)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61FD94F: ??? (in /usr/lib/libltt=
ng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681DA9F: dl_iterate_phdr (dl-ite=
ratephdr.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61FE653: lttng_ust_dl_update (in=
 /usr/lib/liblttng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61DE83B: ??? (in /usr/lib/libltt=
ng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 1,248 bytes in 26 blocks are =
still reachable in loss record 14 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618A790: calloc (vg_replace_mall=
oc.c:1328)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x68D529F: lttng_ust_tracepoint_mo=
dule_register (in /usr/lib/liblttng-ust-tracepoint.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 4,608 bytes in 2 blocks are p=
ossibly lost in loss record 15 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618551C: malloc (vg_replace_mall=
oc.c:381)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5922FFB: malloc (rtld-malloc.h:5=
6)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5922FFB: _dlfo_mappings_segment_=
allocate (dl-find_object.c:217)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5922FFB: _dl_find_object_update_=
1 (dl-find_object.c:671)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5922FFB: _dl_find_object_update =
(dl-find_object.c:805)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x592A803: dl_open_worker_begin (d=
l-open.c:735)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681D877: _dl_catch_exception (dl=
-error-skeleton.c:208)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5929C77: dl_open_worker (dl-open=
.c:782)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681D877: _dl_catch_exception (dl=
-error-skeleton.c:208)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x592A07B: _dl_open (dl-open.c:884=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x676C467: dlopen_doit (dlopen.c:5=
6)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681D877: _dl_catch_exception (dl=
-error-skeleton.c:208)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681D92F: _dl_catch_error (dl-err=
or-skeleton.c:227)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x676BF4F: _dlerror_run (dlerror.c=
:138)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x676C52B: dlopen_implementation (=
dlopen.c:71)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x676C52B: dlopen@@GLIBC_2.34 (dlo=
pen.c:81)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 70,992 bytes in 17 blocks are=
 possibly lost in loss record 16 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618A790: calloc (vg_replace_mall=
oc.c:1328)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61FD91B: ??? (in /usr/lib/libltt=
ng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x681DA9F: dl_iterate_phdr (dl-ite=
ratephdr.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61FE653: lttng_ust_dl_update (in=
 /usr/lib/liblttng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x61DE83B: ??? (in /usr/lib/libltt=
ng-ust.so.1.0.0)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D 72,704 bytes in 1 blocks are =
still reachable in loss record 17 of 17
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0at 0x618551C: malloc (vg_replace_mall=
oc.c:381)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x653E137: ??? (in /usr/lib/libstd=
c++.so.6.0.29)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923653: call_init.part.0 (dl-in=
it.c:74)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: call_init (dl-init.c:29=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5923767: _dl_init (dl-init.c:121=
)
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0by 0x5935D37: ??? (in /lib/ld-linux-a=
arch64.so.1)
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D LEAK SUMMARY:
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0definitely lost: 0 bytes in 0 blocks
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0indirectly lost: 0 bytes in 0 blocks
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0possibly lost: 76,904 byt=
es in 53 blocks
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0still reachable: 74,808 bytes in 37 b=
locks
<br>=3D=3D627=3D=3D =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0suppres=
sed: 0 bytes in 0 blocks
<br>=3D=3D627=3D=3D =C2=A0<br>=3D=3D627=3D=3D For lists of detected and sup=
pressed errors, rerun with: -s
<br>=3D=3D627=3D=3D ERROR SUMMARY: 6 errors from 6 contexts (suppressed: 0 =
from 0)
<br>Aborted<br>
<br></span></div><div><span style=3D"font-family:monospace">I&#39;m sure I&=
#39;m probably doing something wrong but I&#39;ve tried static linking, dyn=
amic linking using LD_PRELOAD helpers like </span><span style=3D"font-famil=
y:monospace"><span style=3D"color:rgb(0,0,0);background-color:rgb(255,255,2=
55)">LD_PRELOAD=3Dliblttng-ust-pthread-wrapper.so.1:liblttng-ust-fd.so.1:li=
blttng-ust-fork.so.1 and I&#39;m out of options that I know to try.</span><=
/span></div><div><span style=3D"font-family:monospace"><span style=3D"color=
:rgb(0,0,0);background-color:rgb(255,255,255)"><br></span></span></div><div=
><span style=3D"font-family:monospace"><span style=3D"color:rgb(0,0,0);back=
ground-color:rgb(255,255,255)">Looking for pointers on what else I can try =
and what I could be doing wrong.<br></span></span></div><div><span style=3D=
"font-family:monospace"><span style=3D"color:rgb(0,0,0);background-color:rg=
b(255,255,255)"><br></span></span></div><div><span style=3D"font-family:mon=
ospace"><span style=3D"color:rgb(0,0,0);background-color:rgb(255,255,255)">=
I had this same segfault issue using Dunfell version of Yocto and earlier v=
ersions of lttng (2.11) but never dug into it because was planning on upgra=
ding everything soon, so recently stepped up to newer versions of everythin=
g to see if that solved the issue but apparently not.<br></span></span></di=
v><div><span style=3D"font-family:monospace"><span style=3D"color:rgb(0,0,0=
);background-color:rgb(255,255,255)"><br></span></span></div><div><span sty=
le=3D"font-family:monospace"><span style=3D"color:rgb(0,0,0);background-col=
or:rgb(255,255,255)">Regards,</span></span></div><div><span style=3D"font-f=
amily:monospace"><span style=3D"color:rgb(0,0,0);background-color:rgb(255,2=
55,255)"><br></span></span></div><div><span style=3D"font-family:monospace"=
><span style=3D"color:rgb(0,0,0);background-color:rgb(255,255,255)">Brian</=
span></span></div><div><span style=3D"font-family:monospace"><span style=3D=
"color:rgb(0,0,0);background-color:rgb(255,255,255)"><br></span></span></di=
v></div>

--0000000000000cd9d1061cef097c--

--===============8605111398632138295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8605111398632138295==--
