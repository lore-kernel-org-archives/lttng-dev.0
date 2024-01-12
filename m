Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCD2C4707C
	for <lttng-dev@archiver.kernel.org>; Fri, 12 Jan 2024 20:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705091917;
	bh=DKQJWjZM/8XbUg5NOkHBD15+UBPmUoyW/40t65LrIBA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DBvgzCLZJmBTt05/IHERM5hNs2ANJq6sFmVnkceO+dUJmrxboGuALkmsYrhybVC/O
	 +Z2YPd/BxEBEKj8LIvvtXPKkJVi832QTya/d/XeJVYPB9pWdOtWXaaVyd7aiM5fKB6
	 75vLhH3MVxnQk79DS6RenS0kce2wlZhQ5NGh+qOWvofsLanjmlzuspi3BNjvKlCDgd
	 qn410B3Zzg8Fc0R2grQ9C6AqqiBwcJ+TB/Y/+lk1GdepDPs259T13jPWnilowF0wfg
	 cNr6HLiyRKSTGRggms24oWLpTBvnyk9wsgYJX5SYnYDOmE9PqJ8k2fLuXcoEhci7TE
	 jHP+gCL7yAQJw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TBYK93W71z1LwF;
	Fri, 12 Jan 2024 15:38:37 -0500 (EST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by lists.lttng.org (Postfix) with ESMTPS id 4TBYK837sBz1LwD
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jan 2024 15:38:36 -0500 (EST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55817a12ad8so4576080a12.2
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jan 2024 12:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705091915; x=1705696715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Crfe8rbKmYiu/GjNORo4OQ29a0urWRC1Frin5epkXdM=;
 b=b8VEFdEBLKJL+I0aE0minhTOIr2iJ66+wIqGmW+aBbrEEwGr6MqrGCdoiSt37UyCQP
 A/e1YFPzkIefcO4ufrK2QqaV7OmUx87JopSclQGndNwE075+7TFU/wjTed7dEiBzGRLx
 WLqaW1XdDal0Bi7wrRVEJ6XXxDNg0CFrxVkxBIZaaqfayPZEa9OuZE4q/CM/sFd02aCa
 MuzQOFIKQi/mK3aUVD0UAU3JHZo6TYnM6FF3Nj1+mB9gs6yH28cWCYc+p4zCQ3u0oBt7
 OFFHISwhGgQETr2burMnp8RepPRPx+fzxIUdD6skKsEkxdESgLOv4bZgXrhTk/YZFj+j
 Ku8w==
X-Gm-Message-State: AOJu0YxI3/bDI2adQumTmEejvHHBPm9m56lwoE/KlWVs+E/cCWQw81vX
 OyADy1sbJnSw9wRawXfGIgXBM7fQVoB76bBtnuk=
X-Google-Smtp-Source: AGHT+IH7KgSKesHbOKs5pDvOl+TuzRSXJr7s6JRgXOv4RaJpjUEerDf8KQ2KZJ5T+V9FzlrYtVCLG6GvbspHSPZCojk=
X-Received: by 2002:a05:6402:14d8:b0:558:cce3:4ddd with SMTP id
 f24-20020a05640214d800b00558cce34dddmr608356edx.78.1705091914452; Fri, 12 Jan
 2024 12:38:34 -0800 (PST)
MIME-Version: 1.0
References: <CACJEY861mX+FerESW6O6pTU7CzadHGDSBF9HktNrXr_fGp-Hcw@mail.gmail.com>
 <0797f455-b051-405f-9814-294e6867241c@efficios.com>
 <CACJEY847OEguyrq2WYxKMLQ4sSf59fdFYKZZe4ZR16Wsaajeqw@mail.gmail.com>
 <98730be3-4268-4641-9e3f-418b08f12895@efficios.com>
In-Reply-To: <98730be3-4268-4641-9e3f-418b08f12895@efficios.com>
Date: Fri, 12 Jan 2024 15:38:22 -0500
Message-ID: <CACJEY84WKMRK9zCkx8ztFoqnKMdNOSWdoV_e5Se3F2uqX170Pg@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] LTTng sessiond daemon Assertion `buf' failed and
 killed
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
From: Yonghong Yan via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Yonghong Yan <yanyh15@gmail.com>
Content-Type: multipart/mixed; boundary="===============3368377853117047982=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3368377853117047982==
Content-Type: multipart/alternative; boundary="000000000000ded3dc060ec5a542"

--000000000000ded3dc060ec5a542
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Coredump is about 124MB and I am copying the backtrace of the coredump, see
below. Unfortunately, the sessiond is stripped and no debugging info, so
not able to see the the call stack that lead to the dump. guess I need to
build the lttng with debugging info and to get the symbol and informed
backtrace.

From the log itself, it is asserted aat >      > DBG1 - 00:24:25.241138386
[Client management]: Setting relayd for
>      > session auto-20240112-002417 (in cmd_setup_relayd() at cmd.c:1004)
>      >
>      > lttng-sessiond: unix.c:185: lttcomm_recv_unix_sock: Assertion
>     `buf' failed.

*yyan7@CCI13SZWP3LWS*:*/var/log*$ tail apport.log


ERROR: apport (pid 3787) Fri Jan 12 10:52:37 2024: debug: session gdbus
call:

ERROR: apport (pid 3787) Fri Jan 12 10:52:37 2024: this executable already
crashed 2 times, ignoring

ERROR: apport (pid 10543) Fri Jan 12 15:18:07 2024: called for pid 10470,
signal 6, core limit 18446744073709551615, dump mode 1

ERROR: apport (pid 10543) Fri Jan 12 15:18:07 2024: ignoring implausibly
big core limit, treating as unlimited

ERROR: apport (pid 10543) Fri Jan 12 15:18:07 2024: executable:
/usr/bin/lttng-sessiond (command line "lttng-sessiond -vvv
--verbose-consumer -b")

ERROR: apport (pid 10543) Fri Jan 12 15:18:08 2024: debug: session gdbus
call: (true,)


ERROR: apport (pid 10543) Fri Jan 12 15:18:08 2024: writing core dump to
core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1047=
0.2023109
(limit: -1)

ERROR: apport (pid 10543) Fri Jan 12 15:18:08 2024: this executable already
crashed 2 times, ignoring

*yyan7@CCI13SZWP3LWS*:*/var/log*$ cd /var/lib/apport/coredump

*yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ ls

core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1047=
0.2023109

*yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ file
core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1047=
0.2023109


core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1047=
0.2023109:
ELF 64-bit LSB core file, x86-64, version 1 (SYSV), SVR4-style, from
'lttng-sessiond -vvv --verbose-consumer -b', real uid: 1000, effective uid:
1000, real gid: 1000, effective gid: 1000, execfn:
'/usr/bin/lttng-sessiond', platform: 'x86_64'

*yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ du -h
core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1047=
0.2023109


124M
core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1047=
0.2023109

*yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ gdb
/usr/bin/lttng-sessiond
core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1047=
0.2023109


*GNU gdb (Ubuntu 12.1-0ubuntu1~22.04) 12.1*

Copyright (C) 2022 Free Software Foundation, Inc.

License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l
>

This is free software: you are free to change and redistribute it.

There is NO WARRANTY, to the extent permitted by law.

Type "show copying" and "show warranty" for details.

This GDB was configured as "x86_64-linux-gnu".

Type "show configuration" for configuration details.

For bug reporting instructions, please see:

<https://www.gnu.org/software/gdb/bugs/>.

Find the GDB manual and other documentation resources online at:

    <http://www.gnu.org/software/gdb/documentation/>.


For help, type "help".

Type "apropos word" to search for commands related to "word"...

Reading symbols from /usr/bin/lttng-sessiond...

(No debugging symbols found in /usr/bin/lttng-sessiond)

[New LWP 10479]

[New LWP 10470]

[New LWP 10476]

[New LWP 10475]

[New LWP 10472]

[New LWP 10478]

[New LWP 10480]

[New LWP 10473]

[New LWP 10477]

[New LWP 10482]

[New LWP 10542]

[New LWP 10533]

[New LWP 10484]

[New LWP 10474]

[New LWP 10481]

[New LWP 10483]

[Thread debugging using libthread_db enabled]

Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

--Type <RET> for more, q to quit, c to continue without paging--

Core was generated by `lttng-sessiond -vvv --verbose-consumer -b'.

Program terminated with signal SIGABRT, Aborted.

#0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D140614=
729455104)
at ./nptl/pthread_kill.c:44

44 ./nptl/pthread_kill.c: No such file or directory.

[Current thread is 1 (Thread 0x7fe36affd600 (LWP 10479))]

(gdb) bt

#0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D140614=
729455104)
at ./nptl/pthread_kill.c:44

#1  __pthread_kill_internal (signo=3D6, threadid=3D140614729455104) at
./nptl/pthread_kill.c:78

#2  __GI___pthread_kill (threadid=3D140614729455104, signo=3Dsigno@entry=3D=
6) at
./nptl/pthread_kill.c:89

#3  0x00007fe37d842476 in __GI_raise (sig=3Dsig@entry=3D6) at
../sysdeps/posix/raise.c:26

#4  0x00007fe37d8287f3 in __GI_abort () at ./stdlib/abort.c:79

#5  0x00007fe37d82871b in __assert_fail_base (fmt=3D0x7fe37d9dd130
"%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",

    assertion=3D0x56371cd9a9ab "buf", file=3D0x56371cda20e7 "unix.c", line=
=3D185,
function=3D<optimized out>) at ./assert/assert.c:92

#6  0x00007fe37d839e96 in __GI___assert_fail (assertion=3D0x56371cd9a9ab
"buf", file=3D0x56371cda20e7 "unix.c", line=3D185,

    function=3D0x56371cdc8830 "lttcomm_recv_unix_sock") at ./assert/assert.=
c
:101

#7  0x000056371cd561be in ?? ()

#8  0x000056371ccea96f in ?? ()

#9  0x000056371ccef7eb in ?? ()

#10 0x000056371ccf3b4c in ?? ()

#11 0x000056371cce0ab7 in ?? ()

#12 0x00007fe37d894ac3 in start_thread (arg=3D<optimized out>) at
./nptl/pthread_create.c:442

#13 0x00007fe37d926850 in clone3 () at
../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

(gdb) quit

*yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ file
/usr/bin/lttng-sessiond

/usr/bin/lttng-sessiond: ELF 64-bit LSB pie executable, x86-64, version 1
(SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2,
BuildID[sha1]=3D71b82210085b068b86d1252ed4f7403917af7cea, for GNU/Linux
3.2.0, stripped

*yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$

On Fri, Jan 12, 2024 at 2:31=E2=80=AFPM Kienan Stewart <kstewart@efficios.c=
om>
wrote:

> Hi Yonghong,
>
> thanks for the additional information. Would you be willing and able to
> share a coredump and/or backtrace of the crash?
>
> I was still unable to reproduce the issue using the commands you
> provided, but am interested in understanding what is happening here.
>
> Are there any configuration options other than LTTNG_UST_DEBUG=3D1 set in
> your environment?
>
> Are you using urcu/lttng from packages (if so, which repo), or built
> from source?
>
> The test case I am using now:
>
> ```
> # As root
> $ lttng-sessiond -b
>
> # As a non-root user which is not a member of the tracing group
> $ export LTTNG_UST_DEBUG=3D1
> $ lttng-relayd -v -b
> $ lttng-sessiond -vvv --verbose-consumer -b
> $ lttng create
> $ lttng enable-event -u -a
> ```
>
> thanks,
> kienan
>
> P.S. In the future, could you keep the lttng-dev in CC? thanks!
>
> On 1/12/24 10:36, Yonghong Yan wrote:
> > Hi Kienan,
> >
> > Thank you for checking.  It might be just my setting problem. I will
> > just send it to you before we are sure it is an issue of lttng
> >
> > Below is the output and steps I followed the guideline. Since I started
> > the relayd and sessiond in the same terminal, the verbose msg are mixed
> > together. I can regenerate it using two separate terminals. It is a Del=
l
> > Precision Tower box and it worked well yesterday. But I rebuilt the
> > system yesterday (because of NVIDIA GPU driver issue), and it then have
> > this issue.
> >
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$ uname -a
> >
> > Linux CCI13SZWP3LWS 6.5.0-14-generic #14~22.04.1-Ubuntu SMP
> > PREEMPT_DYNAMIC Mon Nov 20 18:15:30 UTC 2 x86_64 x86_64 x86_64 GNU/Linu=
x
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$ cat /etc/lsb-release
> >
> > DISTRIB_ID=3DUbuntu
> >
> > DISTRIB_RELEASE=3D22.04
> >
> > DISTRIB_CODENAME=3Djammy
> >
> > DISTRIB_DESCRIPTION=3D"Ubuntu 22.04.3 LTS"
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$ lttng --version
> >
> > lttng (LTTng Trace Control) 2.13.10 - Nordicit=C3=A9
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$ lsmod | grep lttng
> >
> > *lttng*_probe_writeback614400
> >
> > *lttng*_probe_workqueue204800
> >
> > *lttng*_probe_vmscan 450560
> >
> > *lttng*_probe_udp122880
> >
> > *lttng*_probe_timer327680
> >
> > *lttng*_probe_sunrpc 204800
> >
> > *lttng*_probe_statedump573440
> >
> > *lttng*_probe_sock 163840
> >
> > *lttng*_probe_skb163840
> >
> > *lttng*_probe_signal 163840
> >
> > *lttng*_probe_scsi 204800
> >
> > *lttng*_probe_sched450560
> >
> > *lttng*_probe_regulator204800
> >
> > *lttng*_probe_rcu122880
> >
> > *lttng*_probe_printk 122880
> >
> > *lttng*_probe_power204800
> >
> > *lttng*_probe_net327680
> >
> > *lttng*_probe_napi 122880
> >
> > *lttng*_probe_module 204800
> >
> > *lttng*_probe_kvm368640
> >
> > *lttng*_probe_jbd2 327680
> >
> > *lttng*_probe_irq163840
> >
> > *lttng*_probe_gpio 122880
> >
> > *lttng*_probe_block409600
> >
> > *lttng*_probe_asoc 368640
> >
> > *lttng*_counter_client_percpu_32_modular122880
> >
> > *lttng*_counter_client_percpu_64_modular122881
> >
> > *lttng*_counter163842
> >
> *lttng*_counter_client_percpu_64_modular,*lttng*_counter_client_percpu_32=
_modular
> >
> > *lttng*_ring_buffer_event_notifier_client204802
> >
> > *lttng*_ring_buffer_metadata_mmap_client204800
> >
> > *lttng*_ring_buffer_client_mmap_overwrite245760
> >
> > *lttng*_ring_buffer_client_mmap_discard245760
> >
> > *lttng*_ring_buffer_metadata_client204800
> >
> > *lttng*_ring_buffer_client_overwrite245760
> >
> > *lttng*_ring_buffer_client_discard245760
> >
> > *lttng*_tracer 303513637
> >
> *lttng*_probe_udp,*lttng*_probe_scsi,*lttng*_probe_sched,*lttng*_probe_ne=
t,*lttng*_probe_vmscan,*lttng*_probe_writeback,*lttng*_probe_power,*lttng*_=
probe_rcu,*lttng*_probe_module,*lttng*_ring_buffer_client_mmap_overwrite,*l=
ttng*_probe_statedump,*lttng*_ring_buffer_client_discard,*lttng*_probe_prin=
tk,*lttng*_probe_sock,*lttng*_probe_asoc,*lttng*_counter_client_percpu_64_m=
odular,*lttng*_probe_irq,*lttng*_ring_buffer_client_mmap_discard,*lttng*_pr=
obe_kvm,*lttng*_probe_timer,*lttng*_ring_buffer_event_notifier_client,*lttn=
g*_counter_client_percpu_32_modular,*lttng*_probe_workqueue,*lttng*_probe_j=
bd2,*lttng*_probe_signal,*lttng*_probe_skb,*lttng*_probe_block,*lttng*_prob=
e_napi,*lttng*_ring_buffer_metadata_client,*lttng*_ring_buffer_metadata_mma=
p_client,*lttng*_probe_gpio,*lttng*_ring_buffer_client_overwrite,*lttng*_pr=
obe_regulator,*lttng*_probe_sunrpc
> >
> > *lttng*_statedump 7536641 *lttng*_tracer
> >
> > *lttng*_wrapper163847
> >
> *lttng*_statedump,*lttng*_probe_writeback,*lttng*_ring_buffer_client_mmap=
_overwrite,*lttng*_ring_buffer_client_discard,*lttng*_tracer,*lttng*_ring_b=
uffer_client_mmap_discard,*lttng*_ring_buffer_client_overwrite
> >
> > *lttng*_uprobes163841 *lttng*_tracer
> >
> > *lttng*_clock122885
> >
> *lttng*_ring_buffer_client_mmap_overwrite,*lttng*_ring_buffer_client_disc=
ard,*lttng*_tracer,*lttng*_ring_buffer_client_mmap_discard,*lttng*_ring_buf=
fer_client_overwrite
> >
> > *lttng*_kprobes163841 *lttng*_tracer
> >
> > *lttng*_lib_ring_buffer942088
> >
> *lttng*_ring_buffer_client_mmap_overwrite,*lttng*_ring_buffer_client_disc=
ard,*lttng*_tracer,*lttng*_ring_buffer_client_mmap_discard,*lttng*_ring_buf=
fer_event_notifier_client,*lttng*_ring_buffer_metadata_client,*lttng*_ring_=
buffer_metadata_mmap_client,*lttng*_ring_buffer_client_overwrite
> >
> > *lttng*_kretprobes 163841 *lttng*_tracer
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$ export LTTNG_UST_DEBUG=3D1
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$ lttng-relayd -v -b
> >
> > DBG1 - 10:24:56.244818657 [3495/3495]: File descriptor count limits are
> > 1024 (soft) and 1048576 (hard) (in set_fd_pool_size() at main.c:481)
> >
> > DBG1 - 10:24:56.244870031 [3495/3495]: Signal handler set for SIGTERM,
> > SIGUSR1, SIGPIPE and SIGINT (in set_signal_handler() at main.c:872)
> >
> > DBG1 - 10:24:56.244877662 [3495/3495]: LTTng-relayd 2.13.10 - Nordicit=
=C3=A9
> > (in relayd_config_log() at main.c:206)
> >
> > DBG1 - 10:24:56.244885255 [3495/3495]: Clear command allowed (in main()
> > at main.c:4294)
> >
> > DBG1 - 10:24:56.245867168 [3496/3496]: Unlinked file pool created at:
> > /home/yyan7/lttng-traces//.unlinked (in
> > lttng_unlinked_file_pool_create() at inode.c:268)
> >
> > DBG1 - 10:24:56.245903674 [3496/3496]: File descriptor tracker created
> > with a limit of 1014 simultaneously-opened FDs (in fd_tracker_create()
> > at fd-tracker.c:400)
> >
> > DBG1 - 10:24:56.245925508 [3496/3496]: Health check time delta in
> > seconds set to 20 (in health_init() at health.c:62)
> >
> > DBG1 - 10:24:56.245998123 [3496/3496]: TCP inet operation timeout set t=
o
> > 216 sec (in lttcomm_inet_init() at inet.c:545)
> >
> > DBG1 - 10:24:56.246177304 [3496/3498]: [thread] Manage health check
> > started (in thread_manage_health() at health-relayd.c:273)
> >
> > DBG1 - 10:24:56.246222966 [3496/3499]: [thread] Relay dispatcher starte=
d
> > (in relay_thread_dispatcher() at main.c:1291)
> >
> > DBG1 - 10:24:56.246259512 [3496/3499]: Futex n to 1 prepare done (in
> > futex_nto1_prepare() at futex.c:67)
> >
> > DBG1 - 10:24:56.246266232 [3496/3496]: epoll set max size is 7225299 (i=
n
> > compat_epoll_set_max_size() at poll.c:350)
> >
> > DBG1 - 10:24:56.246272226 [3496/3499]: Woken up but nothing in the rela=
y
> > command queue (in relay_thread_dispatcher() at main.c:1318)
> >
> > DBG1 - 10:24:56.246224883 [3496/3500]: [thread] Relay worker started (i=
n
> > relay_thread_worker() at main.c:3913)
> >
> > DBG1 - 10:24:56.246332173 [3496/3501]: [thread] Relay listener started
> > (in relay_thread_listener() at main.c:1089)
> >
> > DBG1 - 10:24:56.246489021 [3496/3498]: Health check ready (in
> > thread_manage_health() at health-relayd.c:364)
> >
> > DBG1 - 10:24:56.246530206 [3496/3501]: Listening on Control listener
> > socket 13 (in relay_socket_create() at main.c:1033)
> >
> > DBG1 - 10:24:56.246595589 [3496/3501]: Listening on Data listener socke=
t
> > 14 (in relay_socket_create() at main.c:1033)
> >
> > DBG1 - 10:24:56.246623642 [3496/3501]: Listener accepting connections
> > (in relay_thread_listener() at main.c:1136)
> >
> > DBG1 - 10:24:56.246619116 [3496/3502]: [thread] Live viewer relay
> > dispatcher started (in thread_dispatcher() at live.c:849)
> >
> > DBG1 - 10:24:56.246652489 [3496/3502]: Futex n to 1 prepare done (in
> > futex_nto1_prepare() at futex.c:67)
> >
> > DBG1 - 10:24:56.246662832 [3496/3502]: Woken up but nothing in the
> > live-viewer relay command queue (in thread_dispatcher() at live.c:876)
> >
> > DBG1 - 10:24:56.246681238 [3496/3503]: [thread] Live viewer relay worke=
r
> > started (in thread_worker() at live.c:2451)
> >
> > DBG1 - 10:24:56.246694646 [3496/3504]: [thread] Relay live listener
> > started (in thread_listener() at live.c:686)
> >
> > DBG1 - 10:24:56.246845536 [3496/3504]: Listening on Live listener socke=
t
> > 16 (in init_socket() at live.c:650)
> >
> > DBG1 - 10:24:56.246891901 [3496/3504]: Listener accepting live viewers
> > connections (in thread_listener() at live.c:720)
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$ lttng-sessiond -vvv --verbose-consumer -b
> >
> > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
> > "relay-metadata-mmap" init
> >
> > (in lttng_ring_buffer_metadata_client_init() at
> > ../../src/common/ringbuffer-clients/metadata-template.h:364)
> >
> > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
> > "relay-overwrite-mmap" init
> >
> > (in lttng_ring_buffer_client_overwrite_init() at
> > ../../src/common/ringbuffer-clients/template.h:826)
> >
> > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
> > "relay-overwrite-rt-mmap" init
> >
> > (in lttng_ring_buffer_client_overwrite_rt_init() at
> > ../../src/common/ringbuffer-clients/template.h:826)
> >
> > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
> > "relay-discard-mmap" init
> >
> > (in lttng_ring_buffer_client_discard_init() at
> > ../../src/common/ringbuffer-clients/template.h:826)
> >
> > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
> > "relay-discard-rt-mmap" init
> >
> > (in lttng_ring_buffer_client_discard_rt_init() at
> > ../../src/common/ringbuffer-clients/template.h:826)
> >
> > DBG1 - 10:25:05.693401139 [Main]: [sessiond configuration]
> >
> > DBG1 - 10:25:05.693458872 [Main]: version2.13.10
> >
> > DBG1 - 10:25:05.693469176 [Main]: verbose: 3
> >
> > DBG1 - 10:25:05.693476719 [Main]: verbose consumer:1
> >
> > DBG1 - 10:25:05.693486867 [Main]: quiet mode:False
> >
> > DBG1 - 10:25:05.693493268 [Main]: agent_tcp_port:[5345, 5354]
> >
> > DBG1 - 10:25:05.693501264 [Main]: application socket timeout:5
> >
> > DBG1 - 10:25:05.693506511 [Main]: no-kernel: False
> >
> > DBG1 - 10:25:05.693511705 [Main]: background:True
> >
> > DBG1 - 10:25:05.693517223 [Main]: daemonize: False
> >
> > DBG1 - 10:25:05.693522427 [Main]: signal parent on start:False
> >
> > DBG1 - 10:25:05.693527446 [Main]: tracing group name:tracing
> >
> > DBG1 - 10:25:05.693535560 [Main]: kmod_probe_list: None
> >
> > DBG1 - 10:25:05.693545390 [Main]: kmod_extra_probe_list: None
> >
> > DBG1 - 10:25:05.693550476 [Main]: rundir:/home/yyan7/.lttng
> >
> > DBG1 - 10:25:05.693558977 [Main]: application socket path:
> > /home/yyan7/.lttng/lttng-ust-sock-8
> >
> > DBG1 - 10:25:05.693564632 [Main]: client socket
> > path:/home/yyan7/.lttng/client-lttng-sessiond
> >
> > DBG1 - 10:25:05.693573771 [Main]: wait shm path: /lttng-ust-wait-8-1000
> >
> > DBG1 - 10:25:05.693581196 [Main]: health socket
> > path:/home/yyan7/.lttng/sessiond-health
> >
> > DBG1 - 10:25:05.693592417 [Main]: LTTNG_UST_CLOCK_PLUGIN:None
> >
> > DBG1 - 10:25:05.693599715 [Main]: pid file path:
> > /home/yyan7/.lttng/lttng-sessiond.pid
> >
> > DBG1 - 10:25:05.693611177 [Main]: lock file
> > path:/home/yyan7/.lttng/lttng-sessiond.lck
> >
> > DBG1 - 10:25:05.693618666 [Main]: session load path: None
> >
> > DBG1 - 10:25:05.693625291 [Main]: agent port file
> > path:/home/yyan7/.lttng/agent.port
> >
> > DBG1 - 10:25:05.693632721 [Main]: consumerd32
> > path:/home/yyan7/.lttng/ustconsumerd32
> >
> > DBG1 - 10:25:05.693640982 [Main]: consumerd32 bin path:Unknown
> >
> > DBG1 - 10:25:05.693648470 [Main]: consumerd32 lib dir: Unknown
> >
> > DBG1 - 10:25:05.693653601 [Main]: consumerd32 err unix sock
> > path:/home/yyan7/.lttng/ustconsumerd32/error
> >
> > DBG1 - 10:25:05.693660355 [Main]: consumerd32 cmd unix sock
> > path:/home/yyan7/.lttng/ustconsumerd32/command
> >
> > DBG1 - 10:25:05.693668191 [Main]: consumerd64
> > path:/home/yyan7/.lttng/ustconsumerd64
> >
> > DBG1 - 10:25:05.693673539 [Main]: consumerd64 bin
> > path:/usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consumerd
> >
> > DBG1 - 10:25:05.693682080 [Main]: consumerd64 lib dir:
> > /usr/lib/x86_64-linux-gnu
> >
> > DBG1 - 10:25:05.693689246 [Main]: consumerd64 err unix sock
> > path:/home/yyan7/.lttng/ustconsumerd64/error
> >
> > DBG1 - 10:25:05.693697419 [Main]: consumerd64 cmd unix sock
> > path:/home/yyan7/.lttng/ustconsumerd64/command
> >
> > DBG1 - 10:25:05.693706980 [Main]: kconsumerd path:
> > /home/yyan7/.lttng/kconsumerd
> >
> > DBG1 - 10:25:05.693714339 [Main]: kconsumerd err unix sock path:
> > /home/yyan7/.lttng/kconsumerd/error
> >
> > DBG1 - 10:25:05.693724836 [Main]: kconsumerd cmd unix sock path:
> > /home/yyan7/.lttng/kconsumerd/command
> >
> > DBG1 - 10:25:05.693736058 [Main]: Starting lttng-sessiond
> > {0e76c943-cc93-414c-81d5-259bf7e8d0e4} (in sessiond_uuid_log() at
> > main.c:1437)
> >
> > DBG3 - 10:25:05.693744764 [Main]: Creating LTTng run directory:
> > /home/yyan7/.lttng (in create_lttng_rundir() at main.c:1069)
> >
> > DBG1 - 10:25:05.696358185 [Main]: Resetting run_as worker signal
> > handlers to default (in reset_sighandler() at runas.c:1377)
> >
> > DBG1 - 10:25:05.696480798 [Main]: run_as signal handler set for SIGTERM
> > and SIGINT (in set_worker_sighandlers() at runas.c:1438)
> >
> > DBG1 - 10:25:05.697495897 [Main]: Health check time delta in seconds se=
t
> > to 20 (in health_init() at health.c:62)
> >
> > DBG1 - 10:25:05.697824357 [HT cleanup]: Entering thread entry point (in
> > launch_thread() at thread.c:65)
> >
> > DBG1 - 10:25:05.697915191 [HT cleanup]: startup. (in thread_ht_cleanup(=
)
> > at ht-cleanup.c:98)
> >
> > DBG1 - 10:25:05.697964263 [HT cleanup]: epoll set max size is 7225299
> > (in compat_epoll_set_max_size() at poll.c:350)
> >
> > DBG3 - 10:25:05.698012958 [Main]: Created hashtable size 4 at
> > 0x5627de049140 of type ULONG (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:25:05.698041846 [Main]: Created hashtable size 4 at
> > 0x5627de049470 of type ULONG (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:25:05.698056225 [Main]: Created hashtable size 4 at
> > 0x5627de04bcd0 of type ULONG (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:25:05.698065318 [HT cleanup]: Polling. (in thread_ht_cleanup(=
)
> > at ht-cleanup.c:122)
> >
> > DBG3 - 10:25:05.698087629 [Main]: Created hashtable size 16 at
> > 0x5627de04cf80 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:25:05.698104568 [Main]: Created hashtable size 16 at
> > 0x5627de04e230 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:25:05.698117477 [Main]: Created hashtable size 16 at
> > 0x5627de04f630 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:25:05.698127087 [Main]: Created hashtable size 4 at
> > 0x5627de050a50 of type ULONG (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:25:05.698142843 [Main]: Created hashtable size 4 at
> > 0x5627de051d90 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG2 - 10:25:05.698158685 [Main]: Creating consumer directory:
> > /home/yyan7/.lttng/ustconsumerd64 (in set_consumer_sockets() at
> main.c:1111)
> >
> > DBG2 - 10:25:05.698296819 [Main]: Creating consumer directory:
> > /home/yyan7/.lttng/ustconsumerd32 (in set_consumer_sockets() at
> main.c:1111)
> >
> > DBG3 - 10:25:05.698395187 [Main]: Created hashtable size 4 at
> > 0x5627de0530d0 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:25:05.698404718 [Main]: Global buffer per UID registry
> > initialized (in buffer_reg_init_uid_registry() at buffer-registry.c:90)
> >
> > DBG3 - 10:25:05.698427501 [Main]: Created hashtable size 4 at
> > 0x5627de054410 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:25:05.698435763 [Main]: Global buffer per PID registry
> > initialized (in buffer_reg_init_pid_registry() at buffer-registry.c:219=
)
> >
> > DBG1 - 10:25:05.698444533 [Main]: Command subsystem initialized (in
> > cmd_init() at cmd.c:6090)
> >
> > DBG1 - 10:25:05.698503908 [Main]: '3506' written in file
> > /home/yyan7/.lttng/lttng-sessiond.pid (in utils_create_pid_file() at
> > utils.c:257)
> >
> > DBG1 - 10:25:05.698588286 [Main]: TCP inet operation timeout set to 216
> > sec (in lttcomm_inet_init() at inet.c:545)
> >
> > DBG1 - 10:25:05.698688270 [Main]: Waiting for health management thread
> > to be ready (in wait_until_thread_is_ready() at health.c:35)
> >
> > DBG1 - 10:25:05.698771494 [Health management]: Entering thread entry
> > point (in launch_thread() at thread.c:65)
> >
> > DBG1 - 10:25:05.698803482 [Health management]: [thread] Manage health
> > check started (in thread_manage_health() at health.c:65)
> >
> > DBG1 - 10:25:05.698964797 [Health management]: Marking health managemen=
t
> > thread as ready (in mark_thread_as_ready() at health.c:28)
> >
> > DBG1 - 10:25:05.698981598 [Health management]: Health check ready (in
> > thread_manage_health() at health.c:136)
> >
> > DBG1 - 10:25:05.698991179 [Main]: Health management thread is ready (in
> > wait_until_thread_is_ready() at health.c:37)
> >
> > DBG1 - 10:25:05.699062770 [Main]: Waiting for notification thread to be
> > ready (in wait_until_thread_is_ready() at notification-thread.c:414)
> >
> > DBG1 - 10:25:05.699151645 [Notification]: Entering thread entry point
> > (in launch_thread() at thread.c:65)
> >
> > DBG1 - 10:25:05.699184431 [Notification]: Started notification thread
> > (in thread_notification() at notification-thread.c:642)
> >
> > DBG1 - 10:25:05.699255526 [Notification]: Creating notification channel
> > UNIX socket at /home/yyan7/.lttng/sessiond-notification (in
> > notification_channel_socket_create() at notification-thread.c:223)
> >
> > DBG1 - 10:25:05.699357295 [Notification]: Notification channel UNIX
> > socket created (fd =3D 29) (in notification_channel_socket_create() at
> > notification-thread.c:258)
> >
> > DBG1 - 10:25:05.699387109 [Notification]: Listening on notification
> > channel socket (in init_thread_state() at notification-thread.c:442)
> >
> > DBG1 - 10:25:05.699561257 [Notification]: Marking notification thread a=
s
> > ready (in mark_thread_as_ready() at notification-thread.c:407)
> >
> > DBG1 - 10:25:05.699576135 [Notification]: Entering poll wait (in
> > thread_notification() at notification-thread.c:668)
> >
> > DBG1 - 10:25:05.699592002 [Main]: Notification thread is ready (in
> > wait_until_thread_is_ready() at notification-thread.c:416)
> >
> > DBG1 - 10:25:05.699600050 [Action Executor]: Entering thread entry poin=
t
> > (in launch_thread() at thread.c:65)
> >
> > DBG1 - 10:25:05.699632561 [Action Executor]: Entering work execution
> > loop (in action_executor_thread() at action-executor.c:761)
> >
> > DBG1 - 10:25:05.699643395 [Action Executor]: No work items enqueued,
> > entering wait (in action_executor_thread() at action-executor.c:770)
> >
> > DBG1 - 10:25:05.699750672 [Timer]: Entering thread entry point (in
> > launch_thread() at thread.c:65)
> >
> > DBG1 - 10:25:05.699770466 [Rotation]: Entering thread entry point (in
> > launch_thread() at thread.c:65)
> >
> > DBG1 - 10:25:05.699793428 [Main]: Created client socket (fd =3D 35) (in
> > create_client_sock() at client.c:2435)
> >
> > DBG1 - 10:25:05.699796906 [Rotation]: Started rotation thread (in
> > thread_rotation() at rotation-thread.c:840)
> >
> > DBG1 - 10:25:05.699868561 [Main]: Waiting for client thread to be ready
> > (in wait_thread_status() at client.c:65)
> >
> > DBG1 - 10:25:05.699906378 [Client management]: Entering thread entry
> > point (in launch_thread() at thread.c:65)
> >
> > DBG1 - 10:25:05.699943442 [Client management]: [thread] Manage client
> > started (in thread_manage_clients() at client.c:2468)
> >
> > DBG1 - 10:25:05.700053570 [Client management]: Marking client thread's
> > state as running (in set_thread_status() at client.c:58)
> >
> > DBG1 - 10:25:05.700067760 [Client management]: Accepting client command
> > ... (in thread_manage_clients() at client.c:2534)
> >
> > DBG1 - 10:25:05.700076510 [Main]: Client thread is ready (in
> > wait_thread_status() at client.c:68)
> >
> > DBG1 - 10:25:05.700180769 [UST registration dispatch]: Entering thread
> > entry point (in launch_thread() at thread.c:65)
> >
> > DBG3 - 10:25:05.700197002 [Main]: Session daemon application socket
> > created (fd =3D 41)(in create_application_socket() at register.c:71)
> >
> > DBG1 - 10:25:05.700203416 [UST registration dispatch]: [thread] Dispatc=
h
> > UST command started (in thread_dispatch_ust_registration() at
> > dispatch.c:250)
> >
> > DBG1 - 10:25:05.700205198 [Notification]: Poll wait returned (1) (in
> > thread_notification() at notification-thread.c:670)
> >
> > DBG1 - 10:25:05.700255843 [Notification]: Handling fd (29) activity (1)
> > (in thread_notification() at notification-thread.c:694)
> >
> > DBG1 - 10:25:05.700269799 [Notification]: Handling new notification
> > channel client connection (in
> > handle_notification_thread_client_connect() at
> > notification-thread-events.c:3351)
> >
> > DBG1 - 10:25:05.700262016 [Main]: Waiting for application registration
> > thread to be ready (in wait_thread_status() at register.c:131)
> >
> > DBG1 - 10:25:05.700236776 [UST registration dispatch]: Futex n to 1
> > prepare done (in futex_nto1_prepare() at futex.c:67)
> >
> > DBG1 - 10:25:05.700308063 [Notification]: Client socket (fd =3D 42) set=
 as
> > non-blocking (in socket_set_non_blocking() at
> > notification-thread-events.c:3319)
> >
> > DBG1 - 10:25:05.700319396 [UST registration dispatch]: Woken up but
> > nothing in the UST command queue (in thread_dispatch_ust_registration()
> > at dispatch.c:279)
> >
> > DBG1 - 10:25:05.700326116 [Notification]: Added new notification channe=
l
> > client socket (42) to poll set (in
> > handle_notification_thread_client_connect() at
> > notification-thread-events.c:3404)
> >
> > DBG1 - 10:25:05.700372936 [Notification]: Entering poll wait (in
> > thread_notification() at notification-thread.c:668)
> >
> > DBG1 - 10:25:05.700383798 [Notification]: Poll wait returned (1) (in
> > thread_notification() at notification-thread.c:670)
> >
> > DBG1 - 10:25:05.700391774 [Notification]: Handling fd (42) activity (1)
> > (in thread_notification() at notification-thread.c:694)
> >
> > DBG1 - 10:25:05.700405519 [Notification]: Entering poll wait (in
> > thread_notification() at notification-thread.c:668)
> >
> > DBG1 - 10:25:05.700416164 [Notification]: Poll wait returned (1) (in
> > thread_notification() at notification-thread.c:670)
> >
> > DBG1 - 10:25:05.700424451 [Notification]: Handling fd (42) activity (1)
> > (in thread_notification() at notification-thread.c:694)
> >
> > DBG1 - 10:25:05.700439076 [Notification]: Received handshake from
> > client: uid =3D 1000, gid =3D 1000, protocol version =3D 1.1, client is
> > sessiond =3D true (in client_handle_message_handshake() at
> > notification-thread-events.c:3879)
> >
> > DBG1 - 10:25:05.700450858 [Notification]: Send command reply (0) (in
> > client_send_command_reply() at notification-thread-events.c:3755)
> >
> > DBG1 - 10:25:05.700460524 [Notification]: Flushing client (socket fd =
=3D
> > 42) outgoing queue (in client_flush_outgoing_queue() at
> > notification-thread-events.c:3644)
> >
> > DBG1 - 10:25:05.700475786 [Notification]: Entering poll wait (in
> > thread_notification() at notification-thread.c:668)
> >
> > DBG1 - 10:25:05.700505488 [Rotation]: Entering poll wait (in
> > thread_rotation() at rotation-thread.c:864)
> >
> > DBG1 - 10:25:05.700506992 [UST application registration]: Entering
> > thread entry point (in launch_thread() at thread.c:65)
> >
> > DBG1 - 10:25:05.700529647 [UST application registration]: [thread]
> > Manage application registration started (in
> > thread_application_registration() at register.c:168)
> >
> > DBG1 - 10:25:05.700597995 [UST application registration]: Marking
> > application registration thread's state as running (in
> > set_thread_status() at register.c:124)
> >
> > DBG1 - 10:25:05.700609984 [UST application registration]: Accepting
> > application registration (in thread_application_registration() at
> > register.c:207)
> >
> > DBG1 - 10:25:05.700616363 [Main]: Application registration thread is
> > ready (in wait_thread_status() at register.c:134)
> >
> > DBG1 - 10:25:05.700627641 [Main]: Notifying applications of session
> > daemon state: 1 (in notify_ust_apps() at register.c:91)
> >
> > DBG1 - 10:25:05.700659113 [Main]: Wait shared memory file descriptor
> > created successfully: path =3D '/lttng-ust-wait-8-1000', mmap_size =3D =
4096,
> > global =3D false, fd =3D 45 (in get_wait_shm() at shm.c:133)
> >
> > DBG1 - 10:25:05.700688620 [Main]: Futex wait update active 1 (in
> > futex_wait_update() at futex.c:55)
> >
> > DBG1 - 10:25:05.700795964 [UST application management]: Entering thread
> > entry point (in launch_thread() at thread.c:65)
> >
> > DBG1 - 10:25:05.700824549 [UST application management]: [thread] Manage
> > application started (in thread_application_management() at
> manage-apps.c:52)
> >
> > DBG1 - 10:25:05.700848435 [Application notification]: Entering thread
> > entry point (in launch_thread() at thread.c:65)
> >
> > DBG1 - 10:25:05.700866212 [Application notification]: [ust-thread]
> > Manage application notify command (in thread_application_notification()
> > at notify-apps.c:39)
> >
> > DBG1 - 10:25:05.700913055 [Main]: Waiting for agent management thread t=
o
> > be ready (in wait_until_thread_is_ready() at agent-thread.c:348)
> >
> > DBG1 - 10:25:05.700936679 [Agent management]: Entering thread entry
> > point (in launch_thread() at thread.c:65)
> >
> > DBG3 - 10:25:05.700952021 [Application notification]: [ust-thread]
> > Manage notify polling (in thread_application_notification() at
> > notify-apps.c:74)
> >
> > DBG1 - 10:25:05.700964639 [UST application management]: Apps thread
> > polling (in thread_application_management() at manage-apps.c:88)
> >
> > DBG1 - 10:25:05.700955328 [Agent management]: Manage agent application
> > registration. (in thread_agent_management() at agent-thread.c:366)
> >
> > DBG3 - 10:25:05.701062072 [Agent management]: URI string:
> > tcp://localhost (in uri_parse() at uri.c:298)
> >
> > DBG2 - 10:25:05.701282226 [Agent management]: IP address resolved to
> > 127.0.0.1 (in set_ip_address() at uri.c:155)
> >
> > DBG3 - 10:25:05.701292578 [Agent management]: URI dtype: 1, proto: 1,
> > host: localhost, subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:51=
0)
> >
> > DBG3 - 10:25:05.701314205 [Agent management]: Trying to bind on port
> > 5345 (in init_tcp_socket() at agent-thread.c:140)
> >
> > DBG1 - 10:25:05.701330622 [Agent management]: Failed to bind to port
> > 5345 since it is already in use (in init_tcp_socket() at
> agent-thread.c:148)
> >
> > DBG3 - 10:25:05.701338804 [Agent management]: Trying to bind on port
> > 5346 (in init_tcp_socket() at agent-thread.c:140)
> >
> > DBG1 - 10:25:05.701351367 [Agent management]: Listening on TCP port 534=
6
> > and socket 54 (in init_tcp_socket() at agent-thread.c:177)
> >
> > DBG1 - 10:25:05.701413970 [Agent management]: '5346' written in file
> > /home/yyan7/.lttng/agent.port (in utils_create_pid_file() at utils.c:25=
7)
> >
> > DBG1 - 10:25:05.701452432 [Agent management]: Marking agent management
> > thread as ready (in mark_thread_as_ready() at agent-thread.c:341)
> >
> > DBG3 - 10:25:05.701466232 [Agent management]: Manage agent polling (in
> > thread_agent_management() at agent-thread.c:421)
> >
> > DBG1 - 10:25:05.701544565 [Main]: Agent management thread is ready (in
> > wait_until_thread_is_ready() at agent-thread.c:350)
> >
> > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
> > "relay-discard-rt-mmap" exit
> >
> > (in lttng_ring_buffer_client_discard_rt_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
> > "relay-discard-mmap" exit
> >
> > (in lttng_ring_buffer_client_discard_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
> > "relay-overwrite-rt-mmap" exit
> >
> > (in lttng_ring_buffer_client_overwrite_rt_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
> > "relay-overwrite-mmap" exit
> >
> > (in lttng_ring_buffer_client_overwrite_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
> > "relay-metadata-mmap" exit
> >
> > (in lttng_ring_buffer_metadata_client_exit() at
> > ../../src/common/ringbuffer-clients/metadata-template.h:371)
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$ ps -ef | grep lttng
> >
> > root 760 10 09:40 ?00:00:00 /usr/bin/*lttng*-sessiond
> >
> > root 808 7600 09:40 ?00:00:00 /usr/bin/*lttng*-sessiond
> >
> > yyan7 3496 10 10:24 ?00:00:00 *lttng*-relayd -v -b
> >
> > yyan7 3506 10 10:25 ?00:00:00 *lttng*-sessiond -vvv --verbose-consumer =
-b
> >
> > yyan7 350735060 10:25 ?00:00:00 *lttng*-sessiond -vvv --verbose-consume=
r
> -b
> >
> > yyan7 352229970 10:25 pts/000:00:00 grep --color=3Dauto *lttng*
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$ lttng create
> >
> > DBG1 - 10:25:35.436359096 [Client management]: Wait for client response
> > (in thread_manage_clients() at client.c:2576)
> >
> > DBG1 - 10:25:35.436403534 [Client management]: Receiving data from
> > client ... (in thread_manage_clients() at client.c:2604)
> >
> > DBG1 - 10:25:35.436419086 [Client management]: Incomplete recv() from
> > client... continuing (in thread_manage_clients() at client.c:2608)
> >
> > DBG1 - 10:25:35.436438855 [Client management]: Accepting client command
> > ... (in thread_manage_clients() at client.c:2534)
> >
> > DBG1 - 10:25:35.436458714 [Client management]: Wait for client response
> > (in thread_manage_clients() at client.c:2576)
> >
> > DBG1 - 10:25:35.436480694 [Client management]: Receiving data from
> > client ... (in thread_manage_clients() at client.c:2604)
> >
> > DBG1 - 10:25:35.436493760 [Client management]: Incomplete recv() from
> > client... continuing (in thread_manage_clients() at client.c:2608)
> >
> > DBG1 - 10:25:35.436514391 [Client management]: Accepting client command
> > ... (in thread_manage_clients() at client.c:2534)
> >
> > DBG1 - 10:25:35.436522846 [Client management]: Wait for client response
> > (in thread_manage_clients() at client.c:2576)
> >
> > DBG1 - 10:25:35.436539198 [Client management]: Receiving data from
> > client ... (in thread_manage_clients() at client.c:2604)
> >
> > DBG1 - 10:25:35.436561992 [Client management]: Processing client comman=
d
> > 'LTTNG_CREATE_SESSION_EXT' (49) (in process_client_msg() at
> client.c:1016)
> >
> > DBG3 - 10:25:35.436644534 [Client management]: Created hashtable size 4
> > at 0x7fd67c0090b0 of type ULONG (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG2 - 10:25:35.436670494 [Client management]: Trying to find session b=
y
> > name auto-20240112-102535 (in session_find_by_name() at session.c:1143)
> >
> > DBG1 - 10:25:35.436679003 [Client management]: Generated session name
> > "auto-20240112-102535" (in session_create() at session.c:1300)
> >
> > DBG3 - 10:25:35.436693861 [Client management]: Created hashtable size 4
> > at 0x7fd67c00a3f0 of type ULONG (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG1 - 10:25:35.436702475 [Client management]: Allocating
> > ltt_sessions_ht_by_id (in ltt_sessions_ht_alloc() at session.c:306)
> >
> > DBG3 - 10:25:35.436719034 [Client management]: Created hashtable size 4
> > at 0x7fd67c00b730 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG1 - 10:25:35.436727024 [Client management]: Allocating
> > ltt_sessions_ht_by_name (in ltt_sessions_ht_alloc() at session.c:314)
> >
> > DBG3 - 10:25:35.436739320 [Client management]: Created hashtable size 4
> > at 0x7fd67c00ca70 of type STRING (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG1 - 10:25:35.436750021 [Client management]: Tracing session
> > auto-20240112-102535 created with ID 0 by uid =3D 1000, gid =3D 1000 (i=
n
> > session_create() at session.c:1348)
> >
> > DBG3 - 10:25:35.436761891 [Client management]: URI string:
> > file:///home/yyan7/lttng-traces/auto-20240112-102535 (in uri_parse() at
> > uri.c:298)
> >
> > DBG3 - 10:25:35.436786010 [Client management]: URI file destination:
> > /home/yyan7/lttng-traces/auto-20240112-102535 (in uri_parse() at
> uri.c:335)
> >
> > DBG3 - 10:25:35.436794369 [Client management]: URI dtype: 3, proto: 0,
> > host: , subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:510)
> >
> > DBG2 - 10:25:35.436815787 [Client management]: Setting trace directory
> > path from URI to /home/yyan7/lttng-traces/auto-20240112-102535 (in
> > add_uri_to_consumer() at cmd.c:719)
> >
> > DBG1 - 10:25:35.436861339 [Client management]: Sending response (size:
> > 8262, retcode: Success (10)) (in thread_manage_clients() at
> client.c:2683)
> >
> > DBG1 - 10:25:35.436885647 [Client management]: Accepting client command
> > ... (in thread_manage_clients() at client.c:2534)
> >
> > DBG1 - 10:25:35.437011410 [Client management]: Wait for client response
> > (in thread_manage_clients() at client.c:2576)
> >
> > DBG1 - 10:25:35.437037211 [Client management]: Receiving data from
> > client ... (in thread_manage_clients() at client.c:2604)
> >
> > DBG1 - 10:25:35.437050433 [Client management]: Incomplete recv() from
> > client... continuing (in thread_manage_clients() at client.c:2608)
> >
> > DBG1 - 10:25:35.437065744 [Client management]: Accepting client command
> > ... (in thread_manage_clients() at client.c:2534)
> >
> > DBG1 - 10:25:35.437074955 [Client management]: Wait for client response
> > (in thread_manage_clients() at client.c:2576)
> >
> > DBG1 - 10:25:35.437088320 [Client management]: Receiving data from
> > client ... (in thread_manage_clients() at client.c:2604)
> >
> > DBG1 - 10:25:35.437107173 [Client management]: Processing client comman=
d
> > 'LTTNG_LIST_SESSIONS' (13) (in process_client_msg() at client.c:1016)
> >
> > DBG1 - 10:25:35.437120952 [Client management]: Counting number of
> > available session for UID 1000 (in lttng_sessions_count() at
> client.c:596)
> >
> > DBG1 - 10:25:35.437130882 [Client management]: Getting all available
> > session for UID 1000 GID 1000 (in cmd_list_lttng_sessions() at
> cmd.c:3947)
> >
> > DBG1 - 10:25:35.437141977 [Client management]: Sending response (size:
> > 4409, retcode: Success (10)) (in thread_manage_clients() at
> client.c:2683)
> >
> > DBG1 - 10:25:35.437163179 [Client management]: Accepting client command
> > ... (in thread_manage_clients() at client.c:2534)
> >
> > Session auto-20240112-102535 created.
> >
> > Traces will be output to /home/yyan7/lttng-traces/auto-20240112-102535
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$ lttng enable-event -u -all
> >
> > Error: Only one domain must be specified.
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$ lttng enable-event -u -a
> >
> > DBG1 - 10:26:09.048651842 [Client management]: Wait for client response
> > (in thread_manage_clients() at client.c:2576)
> >
> > DBG1 - 10:26:09.048698882 [Client management]: Receiving data from
> > client ... (in thread_manage_clients() at client.c:2604)
> >
> > DBG1 - 10:26:09.048730037 [Client management]: Processing client comman=
d
> > 'LTTNG_ENABLE_EVENT' (6) (in process_client_msg() at client.c:1016)
> >
> > DBG1 - 10:26:09.048742929 [Client management]: Getting session
> > auto-20240112-102535 by name (in process_client_msg() at client.c:1133)
> >
> > DBG2 - 10:26:09.048752328 [Client management]: Trying to find session b=
y
> > name auto-20240112-102535 (in session_find_by_name() at session.c:1143)
> >
> > DBG1 - 10:26:09.048762009 [Client management]: Creating UST session (in
> > create_ust_session() at client.c:510)
> >
> > DBG3 - 10:26:09.048777715 [Client management]: Created hashtable size 4
> > at 0x7fd67c00ffd0 of type STRING (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:26:09.048801459 [Client management]: Created hashtable size 4
> > at 0x7fd67c011310 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:26:09.048877638 [Client management]: Created hashtable size 4
> > at 0x7fd67c020120 of type ULONG (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG2 - 10:26:09.048886268 [Client management]: UST trace session create
> > successful (in trace_ust_create_session() at trace-ust.c:324)
> >
> > DBG3 - 10:26:09.048894968 [Client management]: Copying tracing session
> > consumer output in UST session (in copy_session_consumer() at
> client.c:454)
> >
> > DBG3 - 10:26:09.048930287 [Client management]: Created hashtable size 4
> > at 0x7fd67c0213d0 of type ULONG (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:26:09.048944965 [Client management]: Copy session consumer
> > subdir ust (in copy_session_consumer() at client.c:476)
> >
> > DBG1 - 10:26:09.048955915 [Client management]: Spawning consumerd (in
> > spawn_consumerd() at client.c:204)
> >
> > DBG3 - 10:26:09.048988740 [HT cleanup]: Returning from poll on 2 fds.
> > (in thread_ht_cleanup() at ht-cleanup.c:125)
> >
> > DBG2 - 10:26:09.049819491 [Client management]: Consumer pid 3526 (in
> > start_consumerd() at client.c:390)
> >
> > DBG2 - 10:26:09.049855514 [Client management]: Spawning consumer contro=
l
> > thread (in start_consumerd() at client.c:393)
> >
> > DBG1 - 10:26:09.049986094 [Client management]: Waiting for consumer
> > management thread to be ready (in wait_until_thread_is_ready() at
> > manage-consumer.c:46)
> >
> > DBG1 - 10:26:09.050081839 [Consumer management]: Entering thread entry
> > point (in launch_thread() at thread.c:65)
> >
> > DBG1 - 10:26:09.050074834 [Client management]: Using 64-bit UST consume=
r
> > at: /usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consumerd (in
> > spawn_consumerd() at client.c:284)
> >
> > DBG1 - 10:26:09.050117556 [Consumer management]: [thread] Manage
> > consumer started (in thread_consumer_management() at
> manage-consumer.c:65)
> >
> > DBG3 - 10:26:09.050103089 [HT cleanup]: Polling. (in thread_ht_cleanup(=
)
> > at ht-cleanup.c:122)
> >
> > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
> > "relay-metadata-mmap" init
> >
> > (in lttng_ring_buffer_metadata_client_init() at
> > ../../src/common/ringbuffer-clients/metadata-template.h:364)
> >
> > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
> > "relay-overwrite-mmap" init
> >
> > (in lttng_ring_buffer_client_overwrite_init() at
> > ../../src/common/ringbuffer-clients/template.h:826)
> >
> > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
> > "relay-overwrite-rt-mmap" init
> >
> > (in lttng_ring_buffer_client_overwrite_rt_init() at
> > ../../src/common/ringbuffer-clients/template.h:826)
> >
> > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
> > "relay-discard-mmap" init
> >
> > (in lttng_ring_buffer_client_discard_init() at
> > ../../src/common/ringbuffer-clients/template.h:826)
> >
> > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
> > "relay-discard-rt-mmap" init
> >
> > (in lttng_ring_buffer_client_discard_rt_init() at
> > ../../src/common/ringbuffer-clients/template.h:826)
> >
> > DBG1 - 10:26:09.054724418 [3526/3526]: Health check time delta in
> > seconds set to 20 (in health_init() at health.c:62)
> >
> > DBG3 - 10:26:09.054993129 [3526/3526]: Created hashtable size 4 at
> > 0x561838919540 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:26:09.055012947 [3526/3526]: Created hashtable size 4 at
> > 0x561838919870 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:26:09.055026387 [3526/3526]: Created hashtable size 4 at
> > 0x561838919ba0 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:26:09.055038707 [3526/3526]: Created hashtable size 4 at
> > 0x561838919ed0 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:26:09.055052418 [3526/3526]: Created hashtable size 4 at
> > 0x56183891eb00 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:26:09.055070118 [3526/3526]: Created hashtable size 4 at
> > 0x56183891fe40 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG3 - 10:26:09.055079438 [3526/3526]: Created hashtable size 4 at
> > 0x561838921180 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG1 - 10:26:09.055131986 [3526/3526]: TCP inet operation timeout set t=
o
> > 216 sec (in lttcomm_inet_init() at inet.c:545)
> >
> > DBG1 - 10:26:09.055169397 [3526/3526]: Connecting to error socket
> > /home/yyan7/.lttng/ustconsumerd64/error (in main() at
> lttng-consumerd.c:477)
> >
> > DBG2 - 10:26:09.055307314 [Consumer management]: Receiving code from
> > consumer err_sock (in thread_consumer_management() at
> manage-consumer.c:162)
> >
> > DBG1 - 10:26:09.055374257 [3526/3530]: [thread] Manage health check
> > started (in thread_manage_health() at health-consumerd.c:157)
> >
> > DBG1 - 10:26:09.055528236 [3526/3530]: epoll set max size is 7225299 (i=
n
> > compat_epoll_set_max_size() at poll.c:350)
> >
> > DBG1 - 10:26:09.055617358 [3526/3530]: Health check ready (in
> > thread_manage_health() at health-consumerd.c:237)
> >
> > DBG1 - 10:26:09.155778508 [3526/3533]: Thread metadata poll started (in
> > consumer_thread_metadata_poll() at consumer.c:2344)
> >
> > DBG3 - 10:26:09.155827680 [3526/3532]: Created hashtable size 4 at
> > 0x7fb838000b90 of type U64 (in lttng_ht_new() at hashtable.c:152)
> >
> > DBG1 - 10:26:09.155854441 [3526/3532]: Thread channel poll started (in
> > consumer_thread_channel_poll() at consumer.c:2938)
> >
> > DBG1 - 10:26:09.155873849 [3526/3532]: Channel main loop started (in
> > consumer_thread_channel_poll() at consumer.c:2953)
> >
> > DBG1 - 10:26:09.155884744 [3526/3532]: Channel poll wait (in
> > consumer_thread_channel_poll() at consumer.c:2958)
> >
> > DBG1 - 10:26:09.155910091 [3526/3533]: Metadata main loop started (in
> > consumer_thread_metadata_poll() at consumer.c:2360)
> >
> > DBG1 - 10:26:09.155915209 [3526/3535]: Creating command socket
> > /home/yyan7/.lttng/ustconsumerd64/command (in
> > consumer_thread_sessiond_poll() at consumer.c:3201)
> >
> > DBG1 - 10:26:09.155927055 [3526/3533]: Metadata poll wait (in
> > consumer_thread_metadata_poll() at consumer.c:2366)
> >
> > DBG1 - 10:26:09.155902292 [3526/3534]: Updating poll fd array (in
> > update_poll_array() at consumer.c:1176)
> >
> > DBG1 - 10:26:09.155992208 [3526/3534]: polling on 2 fd (in
> > consumer_thread_data_poll() at consumer.c:2627)
> >
> > DBG1 - 10:26:09.156028520 [3526/3535]: Sending ready command to
> > lttng-sessiond (in consumer_thread_sessiond_poll() at consumer.c:3214)
> >
> > DBG1 - 10:26:09.156117370 [3526/3535]: Connection on client_socket (in
> > consumer_thread_sessiond_poll() at consumer.c:3236)
> >
> > DBG1 - 10:26:09.156118051 [Consumer management]: Consumer command socke=
t
> > ready (fd: 61) (in thread_consumer_management() at manage-consumer.c:20=
4)
> >
> > DBG1 - 10:26:09.156134055 [Consumer management]: Consumer metadata
> > socket ready (fd: 62) (in thread_consumer_management() at
> > manage-consumer.c:205)
> >
> > DBG1 - 10:26:09.156140605 [3526/3535]: Metadata connection on
> > client_socket (in set_metadata_socket() at consumer.c:3162)
> >
> > DBG1 - 10:26:09.156159591 [Consumer management]: Sending consumer
> > initialization command (in consumer_init() at consumer.c:1791)
> >
> > DBG1 - 10:26:09.156197563 [3526/3535]: Incoming command on sock (in
> > consumer_thread_sessiond_poll() at consumer.c:3282)
> >
> > DBG1 - 10:26:09.156239708 [3526/3535]: Received session daemon UUID:
> > 0e76c943-cc93-414c-81d5-259bf7e8d0e4 (in lttng_consumer_init_command()
> > at consumer.c:4711)
> >
> > DBG1 - 10:26:09.156260388 [3526/3535]: Received command on sock (in
> > consumer_thread_sessiond_poll() at consumer.c:3298)
> >
> > DBG3 - 10:26:09.156271768 [Consumer management]: Sending
> > SET_CHANNEL_MONITOR_PIPE command to consumer (in consumer_send_pipe() a=
t
> > consumer.c:1230)
> >
> > DBG1 - 10:26:09.156298833 [3526/3535]: Incoming command on sock (in
> > consumer_thread_sessiond_poll() at consumer.c:3282)
> >
> > DBG3 - 10:26:09.156339394 [Consumer management]: Sending channel monito=
r
> > pipe 16 to consumer on socket 61 (in consumer_send_pipe() at
> > consumer.c:1236)
> >
> > DBG1 - 10:26:09.156373728 [3526/3535]: Received channel monitor pipe
> > (27) (in lttng_ustconsumer_recv_cmd() at ust-consumer.c:2017)
> >
> > DBG1 - 10:26:09.156385429 [3526/3535]: Channel monitor pipe set as
> > non-blocking (in lttng_ustconsumer_recv_cmd() at ust-consumer.c:2040)
> >
> > DBG1 - 10:26:09.156398125 [3526/3535]: Received command on sock (in
> > consumer_thread_sessiond_poll() at consumer.c:3298)
> >
> > DBG2 - 10:26:09.156408026 [Consumer management]: channel monitor pipe
> > successfully sent (in consumer_send_pipe() at consumer.c:1244)
> >
> > DBG1 - 10:26:09.156521209 [Consumer management]: Marking consumer
> > management thread as ready (in mark_thread_as_ready() at
> > manage-consumer.c:31)
> >
> > DBG1 - 10:26:09.156618144 [Client management]: Consumer management
> > thread is ready (in wait_until_thread_is_ready() at manage-consumer.c:4=
8)
> >
> > DBG3 - 10:26:09.156649336 [Client management]: Consumer socket created
> > (fd: 61) and added to output (in consumer_create_socket() at
> consumer.c:351)
> >
> > *DBG1 - 10:26:09.156661610 [Client management]: Setting relayd for
> > session auto-20240112-102535 (in cmd_setup_relayd() at cmd.c:1004)*
> >
> > *lttng-sessiond: unix.c:185: lttcomm_recv_unix_sock: Assertion `buf'
> > failed.*
> >
> > DBG1 - 10:26:10.269878943 [3526/3535]: Incoming command on sock (in
> > consumer_thread_sessiond_poll() at consumer.c:3282)
> >
> > DBG1 - 10:26:10.269909824 [3526/3535]: Consumer received unexpected
> > message size 0 (expects 12690) (in lttng_ustconsumer_recv_cmd() at
> > ust-consumer.c:1401)
> >
> > DBG1 - 10:26:10.269918771 [3526/3535]: Communication interrupted on
> > command socket (in consumer_thread_sessiond_poll() at consumer.c:3289)
> >
> > DBG1 - 10:26:10.269924634 [3526/3535]: Consumer thread sessiond poll
> > exiting (in consumer_thread_sessiond_poll() at consumer.c:3304)
> >
> > Error: Events: No session daemon is available (channel channel0, sessio=
n
> > auto-20240112-102535)
> >
> > DBG1 - 10:26:10.269945294 [3526/3535]: UST consumer closing all metadat=
a
> > streams (in lttng_ustconsumer_close_all_metadata() at
> ust-consumer.c:3278)
> >
> > DBG1 - 10:26:10.270034860 [3526/3534]: poll num_rdy : 1 (in
> > consumer_thread_data_poll() at consumer.c:2634)
> >
> > DBG1 - 10:26:10.270051195 [3526/3532]: Channel poll return from wait
> > with 1 fd(s) (in consumer_thread_channel_poll() at consumer.c:2961)
> >
> > DBG1 - 10:26:10.270085710 [3526/3532]: Channel event caught in thread
> > (in consumer_thread_channel_poll() at consumer.c:2964)
> >
> > DBG1 - 10:26:10.270066746 [3526/3534]: consumer_data_pipe wake up (in
> > consumer_thread_data_poll() at consumer.c:2664)
> >
> > DBG1 - 10:26:10.270051357 [3526/3530]: Health check thread dying (in
> > thread_manage_health() at health-consumerd.c:334)
> >
> > DBG1 - 10:26:10.270114085 [3526/3532]: Channel poll wait (in
> > consumer_thread_channel_poll() at consumer.c:2958)
> >
> > DBG1 - 10:26:10.270151938 [3526/3532]: Channel poll return from wait
> > with 0 fd(s) (in consumer_thread_channel_poll() at consumer.c:2961)
> >
> > DBG1 - 10:26:10.270163529 [3526/3532]: Channel event caught in thread
> > (in consumer_thread_channel_poll() at consumer.c:2964)
> >
> > DBG1 - 10:26:10.270115093 [3526/3534]: Consumer delete flagged data
> > stream (in validate_endpoint_status_data_stream() at consumer.c:2274)
> >
> > DBG1 - 10:26:10.270187345 [3526/3534]: polling thread exiting (in
> > consumer_thread_data_poll() at consumer.c:2806)
> >
> > DBG1 - 10:26:10.270226737 [3526/3533]: Metadata poll return from wait
> > with 1 fd(s) (in consumer_thread_metadata_poll() at consumer.c:2368)
> >
> > DBG1 - 10:26:10.270255651 [3526/3533]: Metadata event caught in thread
> > (in consumer_thread_metadata_poll() at consumer.c:2371)
> >
> > DBG1 - 10:26:10.270264901 [3526/3533]: Metadata thread pipe hung up (in
> > consumer_thread_metadata_poll() at consumer.c:2426)
> >
> > DBG1 - 10:26:10.270270628 [3526/3532]: Channel poll thread exiting (in
> > consumer_thread_channel_poll() at consumer.c:3140)
> >
> > DBG1 - 10:26:10.270284048 [3526/3533]: Metadata poll wait (in
> > consumer_thread_metadata_poll() at consumer.c:2366)
> >
> > DBG1 - 10:26:10.270292833 [3526/3533]: Metadata poll return from wait
> > with 0 fd(s) (in consumer_thread_metadata_poll() at consumer.c:2368)
> >
> > DBG1 - 10:26:10.270300375 [3526/3533]: Metadata event caught in thread
> > (in consumer_thread_metadata_poll() at consumer.c:2371)
> >
> > DBG1 - 10:26:10.270310033 [3526/3533]: Metadata poll thread exiting (in
> > consumer_thread_metadata_poll() at consumer.c:2521)
> >
> > DBG1 - 10:26:10.270463392 [3526/3526]: Releasing trace chunk registry t=
o
> > all trace chunks (in lttng_trace_chunk_registry_put_each_chunk() at
> > trace-chunk.c:2221)
> >
> > DBG1 - 10:26:10.270476593 [3526/3526]: Released reference to 0 trace
> > chunks in lttng_trace_chunk_registry_put_each_chunk() (in
> > lttng_trace_chunk_registry_put_each_chunk() at trace-chunk.c:2254)
> >
> > DBG1 - 10:26:10.270667263 [3526/3526]: Consumer destroying it. Closing
> > everything. (in lttng_consumer_destroy() at consumer.c:1546)
> >
> > DBG1 - 10:26:10.270812838 [3526/3526]: Destroying run_as worker (in
> > run_as_destroy_worker_no_lock() at runas.c:1576)
> >
> > DBG1 - 10:26:10.270818934 [3526/3526]: Closing run_as worker socket (in
> > run_as_destroy_worker_no_lock() at runas.c:1581)
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$ libringbuffer-clients[3528/3528]: LTT : ltt
> > ring buffer client "relay-discard-rt-mmap" exit
> >
> > (in lttng_ring_buffer_client_discard_rt_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3528/3528]: LTT : ltt ring buffer client
> > "relay-discard-mmap" exit
> >
> > (in lttng_ring_buffer_client_discard_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3528/3528]: LTT : ltt ring buffer client
> > "relay-overwrite-rt-mmap" exit
> >
> > (in lttng_ring_buffer_client_overwrite_rt_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3528/3528]: LTT : ltt ring buffer client
> > "relay-overwrite-mmap" exit
> >
> > (in lttng_ring_buffer_client_overwrite_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3528/3528]: LTT : ltt ring buffer client
> > "relay-metadata-mmap" exit
> >
> > (in lttng_ring_buffer_metadata_client_exit() at
> > ../../src/common/ringbuffer-clients/metadata-template.h:371)
> >
> > DBG1 - 10:26:10.271345058 [3526/3526]: lttng-runas terminated with
> > status code 0 (in run_as_destroy_worker_no_lock() at runas.c:1601)
> >
> > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
> > "relay-discard-rt-mmap" exit
> >
> > (in lttng_ring_buffer_client_discard_rt_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
> > "relay-discard-mmap" exit
> >
> > (in lttng_ring_buffer_client_discard_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
> > "relay-overwrite-rt-mmap" exit
> >
> > (in lttng_ring_buffer_client_overwrite_rt_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
> > "relay-overwrite-mmap" exit
> >
> > (in lttng_ring_buffer_client_overwrite_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
> > "relay-metadata-mmap" exit
> >
> > (in lttng_ring_buffer_metadata_client_exit() at
> > ../../src/common/ringbuffer-clients/metadata-template.h:371)
> >
> > DBG1 - 10:26:10.271715039 [Run-as worker]: run_as worker exiting (ret =
=3D
> > 0) (in run_as_create_worker_no_lock() at runas.c:1526)
> >
> > libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client
> > "relay-discard-rt-mmap" exit
> >
> > (in lttng_ring_buffer_client_discard_rt_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client
> > "relay-discard-mmap" exit
> >
> > (in lttng_ring_buffer_client_discard_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client
> > "relay-overwrite-rt-mmap" exit
> >
> > (in lttng_ring_buffer_client_overwrite_rt_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client
> > "relay-overwrite-mmap" exit
> >
> > (in lttng_ring_buffer_client_overwrite_exit() at
> > ../../src/common/ringbuffer-clients/template.h:833)
> >
> > libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client
> > "relay-metadata-mmap" exit
> >
> > (in lttng_ring_buffer_metadata_client_exit() at
> > ../../src/common/ringbuffer-clients/metadata-template.h:371)
> >
> >
> > *yyan7@CCI13SZWP3LWS*:*~*$
> >
> >
> >
> > On Fri, Jan 12, 2024 at 10:01=E2=80=AFAM Kienan Stewart <kstewart@effic=
ios.com
> > <mailto:kstewart@efficios.com>> wrote:
> >
> >     Hi Yonghong,
> >
> >     in a brief test I'm unable to reproduce the error you see by runnin=
g
> >     the
> >     following commands on an Ubuntu 22.04 installation with lttng-tools
> >     2.13.10, lttng-ust 2.13.6, urcu stable-0.12, and babeltrace
> stable-2.0.
> >     ```
> >     $ uname -r -v
> >     6.5.0-14-generic #14~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Mon Nov 20
> >     18:15:30 UTC 2
> >
> >     $ lttng-relayd -v -b
> >     $ lttng-sessiond -v -b
> >     $ lttng create
> >     $ lttng enable-event -u --all
> >     ```
> >
> >     Could you please review the bug reporting guidelines at
> >     https://lttng.org/community/ <https://lttng.org/community/> and
> >     elaborate on the steps taken to
> >     reproduce the issue?
> >
> >     thanks,
> >     kienan
> >
> >     On 1/12/24 08:12, Yonghong Yan via lttng-dev wrote:
> >      > I am not sure whether this is my setting problem or a bug with a
> >      > more recent kernel. lttng-sessiond was killed when I tried to
> >     "enable
> >      > event" after a session was created. See below part of the verbos=
e
> >     output
> >      > of the sessiond. It is observed on Ubuntu 22.04, kernel
> >     6.5.0-14-generic
> >      > #14~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC, lttng (LTTng Trace
> Control)
> >      > 2.13.10 - Nordicit=C3=A9.
> >      >
> >      >
> >      > The same version of LTTng works on another Ubuntu 22.04 machine,
> but
> >      > with kernel 6.2.0-33-generic. Any suggestion on what I should tr=
y?
> >      >
> >      >
> >      > Thank you
> >      >
> >      > Yonghong
> >      >
> >      >
> >      >
> >      > c:1016)
> >      >
> >      > DBG1 - 00:24:25.134138433 [Client management]: Getting session
> >      > auto-20240112-002417 by name (in process_client_msg() at
> >     client.c:1133)
> >      >
> >      > DBG1 - 00:24:25.134148894 [Client management]: Creating UST
> >     session (in
> >      > create_ust_session() at client.c:510)
> >      >
> >      > DBG1 - 00:24:25.134267958 [Client management]: Spawning consumer=
d
> >     (in
> >      > spawn_consumerd() at client.c:204)
> >      >
> >      > DBG1 - 00:24:25.135155823 [Client management]: Waiting for
> consumer
> >      > management thread to be ready (in wait_until_thread_is_ready() a=
t
> >      > manage-consumer.c:46)
> >      >
> >      > DBG1 - 00:24:25.135247552 [Consumer management]: Entering thread
> >     entry
> >      > point (in launch_thread() at thread.c:65)
> >      >
> >      > DBG1 - 00:24:25.135293542 [Consumer management]: [thread] Manage
> >      > consumer started (in thread_consumer_management() at
> >     manage-consumer.c:65)
> >      >
> >      > DBG1 - 00:24:25.135335776 [Client management]: Using 64-bit UST
> >     consumer
> >      > at: /usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consumerd (in
> >      > spawn_consumerd() at client.c:284)
> >      >
> >      > DBG1 - 00:24:25.240725883 [Consumer management]: Consumer comman=
d
> >     socket
> >      > ready (fd: 61) (in thread_consumer_management() at
> >     manage-consumer.c:204)
> >      >
> >      > DBG1 - 00:24:25.240746802 [Consumer management]: Consumer metada=
ta
> >      > socket ready (fd: 62) (in thread_consumer_management() at
> >      > manage-consumer.c:205)
> >      >
> >      > DBG1 - 00:24:25.240775318 [Consumer management]: Sending consume=
r
> >      > initialization command (in consumer_init() at consumer.c:1791)
> >      >
> >      > DBG1 - 00:24:25.241066762 [Consumer management]: Marking consume=
r
> >      > management thread as ready (in mark_thread_as_ready() at
> >      > manage-consumer.c:31)
> >      >
> >      > DBG1 - 00:24:25.241100481 [Client management]: Consumer manageme=
nt
> >      > thread is ready (in wait_until_thread_is_ready() at
> >     manage-consumer.c:48)
> >      >
> >      > DBG1 - 00:24:25.241138386 [Client management]: Setting relayd fo=
r
> >      > session auto-20240112-002417 (in cmd_setup_relayd() at cmd.c:100=
4)
> >      >
> >      > lttng-sessiond: unix.c:185: lttcomm_recv_unix_sock: Assertion
> >     `buf' failed.
> >      >
> >      > Error: Events: No session daemon is available (channel channel0,
> >     session
> >      > auto-20240112-002417)
> >      >
> >      > [1]+Aborted (core dumped) lttng-sessiond --verbose
> >      >
> >      > DBG1 - 00:24:26.357769106 [Run-as worker]: run_as worker exiting
> >     (ret =3D
> >      > 0) (in run_as_create_worker_no_lock() at runas.c:1526)
> >      >
> >      >
> >      >
> >      > _______________________________________________
> >      > lttng-dev mailing list
> >      > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >      > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >     <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
> >
>

--000000000000ded3dc060ec5a542
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Coredump is about 124MB and I am copying =
the backtrace of the coredump, see below. Unfortunately, the sessiond is st=
ripped and no debugging info, so not able to see the the call stack that le=
ad to the dump. guess I need to build the lttng with debugging info and to =
get the symbol and informed backtrace.=C2=A0</div><div dir=3D"ltr"><br></di=
v><div dir=3D"ltr">From the log itself, it is asserted aat=C2=A0<span style=
=3D"color:rgb(80,0,80)">&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.24113=
8386 [Client management]: Setting relayd for</span><br style=3D"color:rgb(8=
0,0,80)"><span style=3D"color:rgb(80,0,80)">&gt;=C2=A0 =C2=A0 =C2=A0 &gt; s=
ession auto-20240112-002417 (in cmd_setup_relayd() at cmd.c:1004)</span><br=
 style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">&gt;=C2=A0=
 =C2=A0 =C2=A0 &gt;</span><br style=3D"color:rgb(80,0,80)"><span style=3D"c=
olor:rgb(80,0,80)">&gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng-sessiond: unix.c:185=
: lttcomm_recv_unix_sock: Assertion</span><br style=3D"color:rgb(80,0,80)">=
<span style=3D"color:rgb(80,0,80)">&gt;=C2=A0 =C2=A0 =C2=A0`buf&#39; failed=
.</span><br><div><br></div><div>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s5" style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)"><b>yya=
n7@CCI13SZWP3LWS</b></span><span class=3D"gmail-s1" style=3D"font-variant-l=
igatures:no-common-ligatures">:</span><span class=3D"gmail-s3" style=3D"fon=
t-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)"><b>/var/log</=
b></span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common=
-ligatures">$ tail apport.log<span class=3D"gmail-Apple-converted-space">=
=C2=A0</span></span></p>
<p class=3D"gmail-p3" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0);min-height:20px"><span class=3D"=
gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures"></span><br><=
/p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">ERROR: apport (pid 3787) Fr=
i Jan 12 10:52:37 2024: debug: session gdbus call:<span class=3D"gmail-Appl=
e-converted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">ERROR: apport (pid 3787) Fr=
i Jan 12 10:52:37 2024: this executable already crashed 2 times, ignoring</=
span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">ERROR: apport (pid 10543) F=
ri Jan 12 15:18:07 2024: called for pid 10470, signal 6, core limit 1844674=
4073709551615, dump mode 1</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">ERROR: apport (pid 10543) F=
ri Jan 12 15:18:07 2024: ignoring implausibly big core limit, treating as u=
nlimited</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">ERROR: apport (pid 10543) F=
ri Jan 12 15:18:07 2024: executable: /usr/bin/lttng-sessiond (command line =
&quot;lttng-sessiond -vvv --verbose-consumer -b&quot;)</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">ERROR: apport (pid 10543) F=
ri Jan 12 15:18:08 2024: debug: session gdbus call: (true,)</span></p>
<p class=3D"gmail-p3" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0);min-height:20px"><span class=3D"=
gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures"></span><br><=
/p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">ERROR: apport (pid 10543) F=
ri Jan 12 15:18:08 2024: writing core dump to core._usr_bin_lttng-sessiond.=
1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.10470.2023109 (limit: -1)</span><=
/p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">ERROR: apport (pid 10543) F=
ri Jan 12 15:18:08 2024: this executable already crashed 2 times, ignoring<=
/span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s5" style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)"><b>yya=
n7@CCI13SZWP3LWS</b></span><span class=3D"gmail-s1" style=3D"font-variant-l=
igatures:no-common-ligatures">:</span><span class=3D"gmail-s3" style=3D"fon=
t-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)"><b>/var/log</=
b></span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common=
-ligatures">$ cd /var/lib/apport/coredump</span></p>
<p class=3D"gmail-p4" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(64,11,217)"><span class=3D"gmail-s5" st=
yle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)"><b>=
yyan7@CCI13SZWP3LWS</b></span><span class=3D"gmail-s2" style=3D"font-varian=
t-ligatures:no-common-ligatures;color:rgb(0,0,0)">:</span><span class=3D"gm=
ail-s1" style=3D"font-variant-ligatures:no-common-ligatures"><b>/var/lib/ap=
port/coredump</b></span><span class=3D"gmail-s2" style=3D"font-variant-liga=
tures:no-common-ligatures;color:rgb(0,0,0)">$ ls</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">core._usr_bin_lttng-session=
d.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.10470.2023109</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s5" style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)"><b>yya=
n7@CCI13SZWP3LWS</b></span><span class=3D"gmail-s1" style=3D"font-variant-l=
igatures:no-common-ligatures">:</span><span class=3D"gmail-s3" style=3D"fon=
t-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)"><b>/var/lib/a=
pport/coredump</b></span><span class=3D"gmail-s1" style=3D"font-variant-lig=
atures:no-common-ligatures">$ file core._usr_bin_lttng-sessiond.1000.8f22fa=
a6-512c-49ca-9089-8b3f0801da8d.10470.2023109<span class=3D"gmail-Apple-conv=
erted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">core._usr_bin_lttng-session=
d.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.10470.2023109: ELF 64-bit LSB c=
ore file, x86-64, version 1 (SYSV), SVR4-style, from &#39;lttng-sessiond -v=
vv --verbose-consumer -b&#39;, real uid: 1000, effective uid: 1000, real gi=
d: 1000, effective gid: 1000, execfn: &#39;/usr/bin/lttng-sessiond&#39;, pl=
atform: &#39;x86_64&#39;</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s5" style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)"><b>yya=
n7@CCI13SZWP3LWS</b></span><span class=3D"gmail-s1" style=3D"font-variant-l=
igatures:no-common-ligatures">:</span><span class=3D"gmail-s3" style=3D"fon=
t-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)"><b>/var/lib/a=
pport/coredump</b></span><span class=3D"gmail-s1" style=3D"font-variant-lig=
atures:no-common-ligatures">$ du -h core._usr_bin_lttng-sessiond.1000.8f22f=
aa6-512c-49ca-9089-8b3f0801da8d.10470.2023109<span class=3D"gmail-Apple-con=
verted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">124M<span class=3D"gmail-Ap=
ple-tab-span" style=3D"white-space:pre">	</span>core._usr_bin_lttng-session=
d.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.10470.2023109</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s5" style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)"><b>yya=
n7@CCI13SZWP3LWS</b></span><span class=3D"gmail-s1" style=3D"font-variant-l=
igatures:no-common-ligatures">:</span><span class=3D"gmail-s3" style=3D"fon=
t-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)"><b>/var/lib/a=
pport/coredump</b></span><span class=3D"gmail-s1" style=3D"font-variant-lig=
atures:no-common-ligatures">$ gdb /usr/bin/lttng-sessiond core._usr_bin_ltt=
ng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.10470.2023109<span cl=
ass=3D"gmail-Apple-converted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p5" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(200,20,201)"><span class=3D"gmail-s1" s=
tyle=3D"font-variant-ligatures:no-common-ligatures"><b>GNU gdb (Ubuntu 12.1=
-0ubuntu1~22.04) 12.1</b></span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">Copyright (C) 2022 Free Sof=
tware Foundation, Inc.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">License GPLv3+: GNU GPL ver=
sion 3 or later &lt;<a href=3D"http://gnu.org/licenses/gpl.html">http://gnu=
.org/licenses/gpl.html</a>&gt;</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">This is free software: you =
are free to change and redistribute it.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">There is NO WARRANTY, to th=
e extent permitted by law.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">Type &quot;show copying&quo=
t; and &quot;show warranty&quot; for details.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">This GDB was configured as =
&quot;x86_64-linux-gnu&quot;.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">Type &quot;show configurati=
on&quot; for configuration details.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">For bug reporting instructi=
ons, please see:</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">&lt;<a href=3D"https://www.=
gnu.org/software/gdb/bugs/">https://www.gnu.org/software/gdb/bugs/</a>&gt;.=
</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">Find the GDB manual and oth=
er documentation resources online at:</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-=
converted-space">=C2=A0 =C2=A0 </span>&lt;<a href=3D"http://www.gnu.org/sof=
tware/gdb/documentation/">http://www.gnu.org/software/gdb/documentation/</a=
>&gt;.</span></p>
<p class=3D"gmail-p3" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0);min-height:20px"><span class=3D"=
gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures"></span><br><=
/p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">For help, type &quot;help&q=
uot;.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">Type &quot;apropos word&quo=
t; to search for commands related to &quot;word&quot;...</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">Reading symbols from </span=
><span class=3D"gmail-s5" style=3D"font-variant-ligatures:no-common-ligatur=
es;color:rgb(47,180,29)">/usr/bin/lttng-sessiond</span><span class=3D"gmail=
-s1" style=3D"font-variant-ligatures:no-common-ligatures">...</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">(No debugging symbols found=
 in </span><span class=3D"gmail-s5" style=3D"font-variant-ligatures:no-comm=
on-ligatures;color:rgb(47,180,29)">/usr/bin/lttng-sessiond</span><span clas=
s=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">)</span=
></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10479]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10470]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10476]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10475]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10472]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10478]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10480]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10473]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10477]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10482]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10542]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10533]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10484]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10474]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10481]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[New LWP 10483]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[Thread debugging using lib=
thread_db enabled]</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(47,180,29)"><span class=3D"gmail-s2" st=
yle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)">Using h=
ost libthread_db library &quot;</span><span class=3D"gmail-s1" style=3D"fon=
t-variant-ligatures:no-common-ligatures">/lib/x86_64-linux-gnu/libthread_db=
.so.1</span><span class=3D"gmail-s2" style=3D"font-variant-ligatures:no-com=
mon-ligatures;color:rgb(0,0,0)">&quot;.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">--Type &lt;RET&gt; for more=
, q to quit, c to continue without paging--</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">Core was generated by `lttn=
g-sessiond -vvv --verbose-consumer -b&#39;.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">Program terminated with sig=
nal SIGABRT, Aborted.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">#0<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span></span><span class=3D"gmail-s6" style=3D"f=
ont-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">__pthread_=
kill_implementation</span><span class=3D"gmail-s1" style=3D"font-variant-li=
gatures:no-common-ligatures"> (</span><span class=3D"gmail-s7" style=3D"fon=
t-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">no_tid</span=
><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatur=
es">=3D0, </span><span class=3D"gmail-s7" style=3D"font-variant-ligatures:n=
o-common-ligatures;color:rgb(46,174,187)">signo</span><span class=3D"gmail-=
s1" style=3D"font-variant-ligatures:no-common-ligatures">=3D6, </span><span=
 class=3D"gmail-s7" style=3D"font-variant-ligatures:no-common-ligatures;col=
or:rgb(46,174,187)">threadid</span><span class=3D"gmail-s1" style=3D"font-v=
ariant-ligatures:no-common-ligatures">=3D140614729455104) at </span><span c=
lass=3D"gmail-s5" style=3D"font-variant-ligatures:no-common-ligatures;color=
:rgb(47,180,29)">./nptl/pthread_kill.c</span><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">:44</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">44<span class=3D"gmail-Appl=
e-tab-span" style=3D"white-space:pre">	</span>./nptl/pthread_kill.c: No suc=
h file or directory.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">[Current thread is 1 (Threa=
d 0x7fe36affd600 (LWP 10479))]</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">(gdb) bt</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">#0<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span></span><span class=3D"gmail-s6" style=3D"f=
ont-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">__pthread_=
kill_implementation</span><span class=3D"gmail-s1" style=3D"font-variant-li=
gatures:no-common-ligatures"> (</span><span class=3D"gmail-s7" style=3D"fon=
t-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">no_tid</span=
><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatur=
es">=3D0, </span><span class=3D"gmail-s7" style=3D"font-variant-ligatures:n=
o-common-ligatures;color:rgb(46,174,187)">signo</span><span class=3D"gmail-=
s1" style=3D"font-variant-ligatures:no-common-ligatures">=3D6, </span><span=
 class=3D"gmail-s7" style=3D"font-variant-ligatures:no-common-ligatures;col=
or:rgb(46,174,187)">threadid</span><span class=3D"gmail-s1" style=3D"font-v=
ariant-ligatures:no-common-ligatures">=3D140614729455104) at </span><span c=
lass=3D"gmail-s5" style=3D"font-variant-ligatures:no-common-ligatures;color=
:rgb(47,180,29)">./nptl/pthread_kill.c</span><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">:44</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">#1<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span></span><span class=3D"gmail-s6" style=3D"f=
ont-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">__pthread_=
kill_internal</span><span class=3D"gmail-s1" style=3D"font-variant-ligature=
s:no-common-ligatures"> (</span><span class=3D"gmail-s7" style=3D"font-vari=
ant-ligatures:no-common-ligatures;color:rgb(46,174,187)">signo</span><span =
class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">=3D=
6, </span><span class=3D"gmail-s7" style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(46,174,187)">threadid</span><span class=3D"gmail-s1" =
style=3D"font-variant-ligatures:no-common-ligatures">=3D140614729455104) at=
 </span><span class=3D"gmail-s5" style=3D"font-variant-ligatures:no-common-=
ligatures;color:rgb(47,180,29)">./nptl/pthread_kill.c</span><span class=3D"=
gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">:78</span></=
p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">#2<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span></span><span class=3D"gmail-s6" style=3D"f=
ont-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">__GI___pth=
read_kill</span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no=
-common-ligatures"> (</span><span class=3D"gmail-s7" style=3D"font-variant-=
ligatures:no-common-ligatures;color:rgb(46,174,187)">threadid</span><span c=
lass=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">=3D1=
40614729455104, </span><span class=3D"gmail-s7" style=3D"font-variant-ligat=
ures:no-common-ligatures;color:rgb(46,174,187)">signo=3Dsigno@entry</span><=
span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures=
">=3D6) at </span><span class=3D"gmail-s5" style=3D"font-variant-ligatures:=
no-common-ligatures;color:rgb(47,180,29)">./nptl/pthread_kill.c</span><span=
 class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">:8=
9</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(47,180,29)"><span class=3D"gmail-s2" st=
yle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)">#3<span=
 class=3D"gmail-Apple-converted-space">=C2=A0 </span></span><span class=3D"=
gmail-s3" style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(64,=
11,217)">0x00007fe37d842476</span><span class=3D"gmail-s2" style=3D"font-va=
riant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </span><span clas=
s=3D"gmail-s6" style=3D"font-variant-ligatures:no-common-ligatures;color:rg=
b(159,160,28)">__GI_raise</span><span class=3D"gmail-s2" style=3D"font-vari=
ant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> (</span><span class=3D=
"gmail-s7" style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46=
,174,187)">sig=3Dsig@entry</span><span class=3D"gmail-s2" style=3D"font-var=
iant-ligatures:no-common-ligatures;color:rgb(0,0,0)">=3D6) at </span><span =
class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">../=
sysdeps/posix/raise.c</span><span class=3D"gmail-s2" style=3D"font-variant-=
ligatures:no-common-ligatures;color:rgb(0,0,0)">:26</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">#4<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span></span><span class=3D"gmail-s3" style=3D"f=
ont-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37=
d8287f3</span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-c=
ommon-ligatures"> in </span><span class=3D"gmail-s6" style=3D"font-variant-=
ligatures:no-common-ligatures;color:rgb(159,160,28)">__GI_abort</span><span=
 class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures"> (=
) at </span><span class=3D"gmail-s5" style=3D"font-variant-ligatures:no-com=
mon-ligatures;color:rgb(47,180,29)">./stdlib/abort.c</span><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">:79</span></p=
>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">#5<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span></span><span class=3D"gmail-s3" style=3D"f=
ont-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37=
d82871b</span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-c=
ommon-ligatures"> in </span><span class=3D"gmail-s6" style=3D"font-variant-=
ligatures:no-common-ligatures;color:rgb(159,160,28)">__assert_fail_base</sp=
an><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligat=
ures"> (</span><span class=3D"gmail-s7" style=3D"font-variant-ligatures:no-=
common-ligatures;color:rgb(46,174,187)">fmt</span><span class=3D"gmail-s1" =
style=3D"font-variant-ligatures:no-common-ligatures">=3D0x7fe37d9dd130 &quo=
t;%s%s%s:%u: %s%sAssertion `%s&#39; failed.\n%n&quot;,<span class=3D"gmail-=
Apple-converted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-=
converted-space">=C2=A0 =C2=A0 </span></span><span class=3D"gmail-s7" style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">asser=
tion</span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-comm=
on-ligatures">=3D0x56371cd9a9ab &quot;buf&quot;, </span><span class=3D"gmai=
l-s7" style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,=
187)">file</span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:n=
o-common-ligatures">=3D0x56371cda20e7 &quot;unix.c&quot;, </span><span clas=
s=3D"gmail-s7" style=3D"font-variant-ligatures:no-common-ligatures;color:rg=
b(46,174,187)">line</span><span class=3D"gmail-s1" style=3D"font-variant-li=
gatures:no-common-ligatures">=3D185, </span><span class=3D"gmail-s7" style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">funct=
ion</span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-commo=
n-ligatures">=3D&lt;optimized out&gt;) at </span><span class=3D"gmail-s5" s=
tyle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">./=
assert/assert.c</span><span class=3D"gmail-s1" style=3D"font-variant-ligatu=
res:no-common-ligatures">:92</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">#6<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 </span></span><span class=3D"gmail-s3" style=3D"f=
ont-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37=
d839e96</span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-c=
ommon-ligatures"> in </span><span class=3D"gmail-s6" style=3D"font-variant-=
ligatures:no-common-ligatures;color:rgb(159,160,28)">__GI___assert_fail</sp=
an><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligat=
ures"> (</span><span class=3D"gmail-s7" style=3D"font-variant-ligatures:no-=
common-ligatures;color:rgb(46,174,187)">assertion</span><span class=3D"gmai=
l-s1" style=3D"font-variant-ligatures:no-common-ligatures">=3D0x56371cd9a9a=
b &quot;buf&quot;, </span><span class=3D"gmail-s7" style=3D"font-variant-li=
gatures:no-common-ligatures;color:rgb(46,174,187)">file</span><span class=
=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">=3D0x563=
71cda20e7 &quot;unix.c&quot;, </span><span class=3D"gmail-s7" style=3D"font=
-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">line</span><s=
pan class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures"=
>=3D185,<span class=3D"gmail-Apple-converted-space">=C2=A0</span></span></p=
>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-=
converted-space">=C2=A0 =C2=A0 </span></span><span class=3D"gmail-s7" style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">funct=
ion</span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-commo=
n-ligatures">=3D0x56371cdc8830 &quot;lttcomm_recv_unix_sock&quot;) at </spa=
n><span class=3D"gmail-s5" style=3D"font-variant-ligatures:no-common-ligatu=
res;color:rgb(47,180,29)">./assert/assert.c</span><span class=3D"gmail-s1" =
style=3D"font-variant-ligatures:no-common-ligatures">:101</span></p>
<p class=3D"gmail-p4" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(64,11,217)"><span class=3D"gmail-s2" st=
yle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)">#7<span=
 class=3D"gmail-Apple-converted-space">=C2=A0 </span></span><span class=3D"=
gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">0x000056371c=
d561be</span><span class=3D"gmail-s2" style=3D"font-variant-ligatures:no-co=
mmon-ligatures;color:rgb(0,0,0)"> in </span><span class=3D"gmail-s6" style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">??</s=
pan><span class=3D"gmail-s2" style=3D"font-variant-ligatures:no-common-liga=
tures;color:rgb(0,0,0)"> ()</span></p>
<p class=3D"gmail-p4" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(64,11,217)"><span class=3D"gmail-s2" st=
yle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)">#8<span=
 class=3D"gmail-Apple-converted-space">=C2=A0 </span></span><span class=3D"=
gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">0x000056371c=
cea96f</span><span class=3D"gmail-s2" style=3D"font-variant-ligatures:no-co=
mmon-ligatures;color:rgb(0,0,0)"> in </span><span class=3D"gmail-s6" style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">??</s=
pan><span class=3D"gmail-s2" style=3D"font-variant-ligatures:no-common-liga=
tures;color:rgb(0,0,0)"> ()</span></p>
<p class=3D"gmail-p4" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(64,11,217)"><span class=3D"gmail-s2" st=
yle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)">#9<span=
 class=3D"gmail-Apple-converted-space">=C2=A0 </span></span><span class=3D"=
gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">0x000056371c=
cef7eb</span><span class=3D"gmail-s2" style=3D"font-variant-ligatures:no-co=
mmon-ligatures;color:rgb(0,0,0)"> in </span><span class=3D"gmail-s6" style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">??</s=
pan><span class=3D"gmail-s2" style=3D"font-variant-ligatures:no-common-liga=
tures;color:rgb(0,0,0)"> ()</span></p>
<p class=3D"gmail-p4" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(64,11,217)"><span class=3D"gmail-s2" st=
yle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)">#10 </s=
pan><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-liga=
tures">0x000056371ccf3b4c</span><span class=3D"gmail-s2" style=3D"font-vari=
ant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </span><span class=
=3D"gmail-s6" style=3D"font-variant-ligatures:no-common-ligatures;color:rgb=
(159,160,28)">??</span><span class=3D"gmail-s2" style=3D"font-variant-ligat=
ures:no-common-ligatures;color:rgb(0,0,0)"> ()</span></p>
<p class=3D"gmail-p4" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(64,11,217)"><span class=3D"gmail-s2" st=
yle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)">#11 </s=
pan><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-liga=
tures">0x000056371cce0ab7</span><span class=3D"gmail-s2" style=3D"font-vari=
ant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </span><span class=
=3D"gmail-s6" style=3D"font-variant-ligatures:no-common-ligatures;color:rgb=
(159,160,28)">??</span><span class=3D"gmail-s2" style=3D"font-variant-ligat=
ures:no-common-ligatures;color:rgb(0,0,0)"> ()</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">#12 </span><span class=3D"g=
mail-s3" style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(64,1=
1,217)">0x00007fe37d894ac3</span><span class=3D"gmail-s1" style=3D"font-var=
iant-ligatures:no-common-ligatures"> in </span><span class=3D"gmail-s6" sty=
le=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">sta=
rt_thread</span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no=
-common-ligatures"> (</span><span class=3D"gmail-s7" style=3D"font-variant-=
ligatures:no-common-ligatures;color:rgb(46,174,187)">arg</span><span class=
=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">=3D&lt;o=
ptimized out&gt;) at </span><span class=3D"gmail-s5" style=3D"font-variant-=
ligatures:no-common-ligatures;color:rgb(47,180,29)">./nptl/pthread_create.c=
</span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-l=
igatures">:442</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(47,180,29)"><span class=3D"gmail-s2" st=
yle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)">#13 </s=
pan><span class=3D"gmail-s3" style=3D"font-variant-ligatures:no-common-liga=
tures;color:rgb(64,11,217)">0x00007fe37d926850</span><span class=3D"gmail-s=
2" style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> i=
n </span><span class=3D"gmail-s6" style=3D"font-variant-ligatures:no-common=
-ligatures;color:rgb(159,160,28)">clone3</span><span class=3D"gmail-s2" sty=
le=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> () at <=
/span><span class=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-li=
gatures">../sysdeps/unix/sysv/linux/x86_64/clone3.S</span><span class=3D"gm=
ail-s2" style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0=
)">:81</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">(gdb) quit</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s5" style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)"><b>yya=
n7@CCI13SZWP3LWS</b></span><span class=3D"gmail-s1" style=3D"font-variant-l=
igatures:no-common-ligatures">:</span><span class=3D"gmail-s3" style=3D"fon=
t-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)"><b>/var/lib/a=
pport/coredump</b></span><span class=3D"gmail-s1" style=3D"font-variant-lig=
atures:no-common-ligatures">$ file /usr/bin/lttng-sessiond<span class=3D"gm=
ail-Apple-converted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">/usr/bin/lttng-sessiond: EL=
F 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, =
interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=3D71b82210085b068b86=
d1252ed4f7403917af7cea, for GNU/Linux 3.2.0, stripped</span></p>
<p class=3D"gmail-p4" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:17px;line-height=
:normal;font-family:Menlo;color:rgb(64,11,217)"><span class=3D"gmail-s5" st=
yle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)"><b>=
yyan7@CCI13SZWP3LWS</b></span><span class=3D"gmail-s2" style=3D"font-varian=
t-ligatures:no-common-ligatures;color:rgb(0,0,0)">:</span><span class=3D"gm=
ail-s1" style=3D"font-variant-ligatures:no-common-ligatures"><b>/var/lib/ap=
port/coredump</b></span><span class=3D"gmail-s2" style=3D"font-variant-liga=
tures:no-common-ligatures;color:rgb(0,0,0)">$<span class=3D"gmail-Apple-con=
verted-space">=C2=A0</span></span></p></div></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 12, 2024 at 2=
:31=E2=80=AFPM Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com">=
kstewart@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Hi Yonghong,<br>
<br>
thanks for the additional information. Would you be willing and able to <br=
>
share a coredump and/or backtrace of the crash?<br>
<br>
I was still unable to reproduce the issue using the commands you <br>
provided, but am interested in understanding what is happening here.<br>
<br>
Are there any configuration options other than LTTNG_UST_DEBUG=3D1 set in <=
br>
your environment?<br>
<br>
Are you using urcu/lttng from packages (if so, which repo), or built <br>
from source?<br>
<br>
The test case I am using now:<br>
<br>
```<br>
# As root<br>
$ lttng-sessiond -b<br>
<br>
# As a non-root user which is not a member of the tracing group<br>
$ export LTTNG_UST_DEBUG=3D1<br>
$ lttng-relayd -v -b<br>
$ lttng-sessiond -vvv --verbose-consumer -b<br>
$ lttng create<br>
$ lttng enable-event -u -a<br>
```<br>
<br>
thanks,<br>
kienan<br>
<br>
P.S. In the future, could you keep the lttng-dev in CC? thanks!<br>
<br>
On 1/12/24 10:36, Yonghong Yan wrote:<br>
&gt; Hi Kienan,<br>
&gt; <br>
&gt; Thank you for checking.=C2=A0 It might be just my setting problem. I w=
ill <br>
&gt; just send it to you before we are sure it is an issue of lttng<br>
&gt; <br>
&gt; Below is the output and steps I followed the=C2=A0guideline. Since I s=
tarted <br>
&gt; the relayd and sessiond in the same terminal, the verbose msg are mixe=
d <br>
&gt; together. I can regenerate it using two separate terminals. It is a De=
ll <br>
&gt; Precision Tower box and it worked well yesterday. But I rebuilt the <b=
r>
&gt; system yesterday (because of NVIDIA GPU driver issue), and it then hav=
e <br>
&gt; this issue.<br>
&gt; <br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$ uname -a<br>
&gt; <br>
&gt; Linux CCI13SZWP3LWS 6.5.0-14-generic #14~22.04.1-Ubuntu SMP <br>
&gt; PREEMPT_DYNAMIC Mon Nov 20 18:15:30 UTC 2 x86_64 x86_64 x86_64 GNU/Lin=
ux<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$ cat /etc/lsb-release<br>
&gt; <br>
&gt; DISTRIB_ID=3DUbuntu<br>
&gt; <br>
&gt; DISTRIB_RELEASE=3D22.04<br>
&gt; <br>
&gt; DISTRIB_CODENAME=3Djammy<br>
&gt; <br>
&gt; DISTRIB_DESCRIPTION=3D&quot;Ubuntu 22.04.3 LTS&quot;<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$ lttng --version<br>
&gt; <br>
&gt; lttng (LTTng Trace Control) 2.13.10 - Nordicit=C3=A9<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$ lsmod | grep lttng<br>
&gt; <br>
&gt; *lttng*_probe_writeback614400<br>
&gt; <br>
&gt; *lttng*_probe_workqueue204800<br>
&gt; <br>
&gt; *lttng*_probe_vmscan 450560<br>
&gt; <br>
&gt; *lttng*_probe_udp122880<br>
&gt; <br>
&gt; *lttng*_probe_timer327680<br>
&gt; <br>
&gt; *lttng*_probe_sunrpc 204800<br>
&gt; <br>
&gt; *lttng*_probe_statedump573440<br>
&gt; <br>
&gt; *lttng*_probe_sock 163840<br>
&gt; <br>
&gt; *lttng*_probe_skb163840<br>
&gt; <br>
&gt; *lttng*_probe_signal 163840<br>
&gt; <br>
&gt; *lttng*_probe_scsi 204800<br>
&gt; <br>
&gt; *lttng*_probe_sched450560<br>
&gt; <br>
&gt; *lttng*_probe_regulator204800<br>
&gt; <br>
&gt; *lttng*_probe_rcu122880<br>
&gt; <br>
&gt; *lttng*_probe_printk 122880<br>
&gt; <br>
&gt; *lttng*_probe_power204800<br>
&gt; <br>
&gt; *lttng*_probe_net327680<br>
&gt; <br>
&gt; *lttng*_probe_napi 122880<br>
&gt; <br>
&gt; *lttng*_probe_module 204800<br>
&gt; <br>
&gt; *lttng*_probe_kvm368640<br>
&gt; <br>
&gt; *lttng*_probe_jbd2 327680<br>
&gt; <br>
&gt; *lttng*_probe_irq163840<br>
&gt; <br>
&gt; *lttng*_probe_gpio 122880<br>
&gt; <br>
&gt; *lttng*_probe_block409600<br>
&gt; <br>
&gt; *lttng*_probe_asoc 368640<br>
&gt; <br>
&gt; *lttng*_counter_client_percpu_32_modular122880<br>
&gt; <br>
&gt; *lttng*_counter_client_percpu_64_modular122881<br>
&gt; <br>
&gt; *lttng*_counter163842 <br>
&gt; *lttng*_counter_client_percpu_64_modular,*lttng*_counter_client_percpu=
_32_modular<br>
&gt; <br>
&gt; *lttng*_ring_buffer_event_notifier_client204802<br>
&gt; <br>
&gt; *lttng*_ring_buffer_metadata_mmap_client204800<br>
&gt; <br>
&gt; *lttng*_ring_buffer_client_mmap_overwrite245760<br>
&gt; <br>
&gt; *lttng*_ring_buffer_client_mmap_discard245760<br>
&gt; <br>
&gt; *lttng*_ring_buffer_metadata_client204800<br>
&gt; <br>
&gt; *lttng*_ring_buffer_client_overwrite245760<br>
&gt; <br>
&gt; *lttng*_ring_buffer_client_discard245760<br>
&gt; <br>
&gt; *lttng*_tracer 303513637 <br>
&gt; *lttng*_probe_udp,*lttng*_probe_scsi,*lttng*_probe_sched,*lttng*_probe=
_net,*lttng*_probe_vmscan,*lttng*_probe_writeback,*lttng*_probe_power,*lttn=
g*_probe_rcu,*lttng*_probe_module,*lttng*_ring_buffer_client_mmap_overwrite=
,*lttng*_probe_statedump,*lttng*_ring_buffer_client_discard,*lttng*_probe_p=
rintk,*lttng*_probe_sock,*lttng*_probe_asoc,*lttng*_counter_client_percpu_6=
4_modular,*lttng*_probe_irq,*lttng*_ring_buffer_client_mmap_discard,*lttng*=
_probe_kvm,*lttng*_probe_timer,*lttng*_ring_buffer_event_notifier_client,*l=
ttng*_counter_client_percpu_32_modular,*lttng*_probe_workqueue,*lttng*_prob=
e_jbd2,*lttng*_probe_signal,*lttng*_probe_skb,*lttng*_probe_block,*lttng*_p=
robe_napi,*lttng*_ring_buffer_metadata_client,*lttng*_ring_buffer_metadata_=
mmap_client,*lttng*_probe_gpio,*lttng*_ring_buffer_client_overwrite,*lttng*=
_probe_regulator,*lttng*_probe_sunrpc<br>
&gt; <br>
&gt; *lttng*_statedump 7536641 *lttng*_tracer<br>
&gt; <br>
&gt; *lttng*_wrapper163847 <br>
&gt; *lttng*_statedump,*lttng*_probe_writeback,*lttng*_ring_buffer_client_m=
map_overwrite,*lttng*_ring_buffer_client_discard,*lttng*_tracer,*lttng*_rin=
g_buffer_client_mmap_discard,*lttng*_ring_buffer_client_overwrite<br>
&gt; <br>
&gt; *lttng*_uprobes163841 *lttng*_tracer<br>
&gt; <br>
&gt; *lttng*_clock122885 <br>
&gt; *lttng*_ring_buffer_client_mmap_overwrite,*lttng*_ring_buffer_client_d=
iscard,*lttng*_tracer,*lttng*_ring_buffer_client_mmap_discard,*lttng*_ring_=
buffer_client_overwrite<br>
&gt; <br>
&gt; *lttng*_kprobes163841 *lttng*_tracer<br>
&gt; <br>
&gt; *lttng*_lib_ring_buffer942088 <br>
&gt; *lttng*_ring_buffer_client_mmap_overwrite,*lttng*_ring_buffer_client_d=
iscard,*lttng*_tracer,*lttng*_ring_buffer_client_mmap_discard,*lttng*_ring_=
buffer_event_notifier_client,*lttng*_ring_buffer_metadata_client,*lttng*_ri=
ng_buffer_metadata_mmap_client,*lttng*_ring_buffer_client_overwrite<br>
&gt; <br>
&gt; *lttng*_kretprobes 163841 *lttng*_tracer<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$ export LTTNG_UST_DEBUG=3D1<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$ lttng-relayd -v -b<br>
&gt; <br>
&gt; DBG1 - 10:24:56.244818657 [3495/3495]: File descriptor count limits ar=
e <br>
&gt; 1024 (soft) and 1048576 (hard) (in set_fd_pool_size() at main.c:481)<b=
r>
&gt; <br>
&gt; DBG1 - 10:24:56.244870031 [3495/3495]: Signal handler set for SIGTERM,=
 <br>
&gt; SIGUSR1, SIGPIPE and SIGINT (in set_signal_handler() at main.c:872)<br=
>
&gt; <br>
&gt; DBG1 - 10:24:56.244877662 [3495/3495]: LTTng-relayd 2.13.10 - Nordicit=
=C3=A9 <br>
&gt; (in relayd_config_log() at main.c:206)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.244885255 [3495/3495]: Clear command allowed (in main(=
) <br>
&gt; at main.c:4294)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.245867168 [3496/3496]: Unlinked file pool created at: =
<br>
&gt; /home/yyan7/lttng-traces//.unlinked (in <br>
&gt; lttng_unlinked_file_pool_create() at inode.c:268)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.245903674 [3496/3496]: File descriptor tracker created=
 <br>
&gt; with a limit of 1014 simultaneously-opened FDs (in fd_tracker_create()=
 <br>
&gt; at fd-tracker.c:400)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.245925508 [3496/3496]: Health check time delta in <br>
&gt; seconds set to 20 (in health_init() at health.c:62)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.245998123 [3496/3496]: TCP inet operation timeout set =
to <br>
&gt; 216 sec (in lttcomm_inet_init() at inet.c:545)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246177304 [3496/3498]: [thread] Manage health check <b=
r>
&gt; started (in thread_manage_health() at health-relayd.c:273)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246222966 [3496/3499]: [thread] Relay dispatcher start=
ed <br>
&gt; (in relay_thread_dispatcher() at main.c:1291)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246259512 [3496/3499]: Futex n to 1 prepare done (in <=
br>
&gt; futex_nto1_prepare() at futex.c:67)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246266232 [3496/3496]: epoll set max size is 7225299 (=
in <br>
&gt; compat_epoll_set_max_size() at poll.c:350)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246272226 [3496/3499]: Woken up but nothing in the rel=
ay <br>
&gt; command queue (in relay_thread_dispatcher() at main.c:1318)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246224883 [3496/3500]: [thread] Relay worker started (=
in <br>
&gt; relay_thread_worker() at main.c:3913)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246332173 [3496/3501]: [thread] Relay listener started=
 <br>
&gt; (in relay_thread_listener() at main.c:1089)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246489021 [3496/3498]: Health check ready (in <br>
&gt; thread_manage_health() at health-relayd.c:364)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246530206 [3496/3501]: Listening on Control listener <=
br>
&gt; socket 13 (in relay_socket_create() at main.c:1033)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246595589 [3496/3501]: Listening on Data listener sock=
et <br>
&gt; 14 (in relay_socket_create() at main.c:1033)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246623642 [3496/3501]: Listener accepting connections =
<br>
&gt; (in relay_thread_listener() at main.c:1136)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246619116 [3496/3502]: [thread] Live viewer relay <br>
&gt; dispatcher started (in thread_dispatcher() at live.c:849)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246652489 [3496/3502]: Futex n to 1 prepare done (in <=
br>
&gt; futex_nto1_prepare() at futex.c:67)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246662832 [3496/3502]: Woken up but nothing in the <br=
>
&gt; live-viewer relay command queue (in thread_dispatcher() at live.c:876)=
<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246681238 [3496/3503]: [thread] Live viewer relay work=
er <br>
&gt; started (in thread_worker() at live.c:2451)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246694646 [3496/3504]: [thread] Relay live listener <b=
r>
&gt; started (in thread_listener() at live.c:686)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246845536 [3496/3504]: Listening on Live listener sock=
et <br>
&gt; 16 (in init_socket() at live.c:650)<br>
&gt; <br>
&gt; DBG1 - 10:24:56.246891901 [3496/3504]: Listener accepting live viewers=
 <br>
&gt; connections (in thread_listener() at live.c:720)<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$ lttng-sessiond -vvv --verbose-consumer -b<b=
r>
&gt; <br>
&gt; libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-metadata-mmap&quot; init<br>
&gt; <br>
&gt; (in lttng_ring_buffer_metadata_client_init() at <br>
&gt; ../../src/common/ringbuffer-clients/metadata-template.h:364)<br>
&gt; <br>
&gt; libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-overwrite-mmap&quot; init<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_overwrite_init() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:826)<br>
&gt; <br>
&gt; libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-overwrite-rt-mmap&quot; init<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_overwrite_rt_init() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:826)<br>
&gt; <br>
&gt; libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-discard-mmap&quot; init<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_discard_init() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:826)<br>
&gt; <br>
&gt; libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-discard-rt-mmap&quot; init<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_discard_rt_init() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:826)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693401139 [Main]: [sessiond configuration]<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693458872 [Main]: version2.13.10<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693469176 [Main]: verbose: 3<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693476719 [Main]: verbose consumer:1<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693486867 [Main]: quiet mode:False<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693493268 [Main]: agent_tcp_port:[5345, 5354]<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693501264 [Main]: application socket timeout:5<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693506511 [Main]: no-kernel: False<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693511705 [Main]: background:True<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693517223 [Main]: daemonize: False<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693522427 [Main]: signal parent on start:False<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693527446 [Main]: tracing group name:tracing<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693535560 [Main]: kmod_probe_list: None<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693545390 [Main]: kmod_extra_probe_list: None<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693550476 [Main]: rundir:/home/yyan7/.lttng<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693558977 [Main]: application socket path: <br>
&gt; /home/yyan7/.lttng/lttng-ust-sock-8<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693564632 [Main]: client socket <br>
&gt; path:/home/yyan7/.lttng/client-lttng-sessiond<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693573771 [Main]: wait shm path: /lttng-ust-wait-8-100=
0<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693581196 [Main]: health socket <br>
&gt; path:/home/yyan7/.lttng/sessiond-health<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693592417 [Main]: LTTNG_UST_CLOCK_PLUGIN:None<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693599715 [Main]: pid file path: <br>
&gt; /home/yyan7/.lttng/lttng-sessiond.pid<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693611177 [Main]: lock file <br>
&gt; path:/home/yyan7/.lttng/lttng-sessiond.lck<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693618666 [Main]: session load path: None<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693625291 [Main]: agent port file <br>
&gt; path:/home/yyan7/.lttng/agent.port<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693632721 [Main]: consumerd32 <br>
&gt; path:/home/yyan7/.lttng/ustconsumerd32<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693640982 [Main]: consumerd32 bin path:Unknown<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693648470 [Main]: consumerd32 lib dir: Unknown<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693653601 [Main]: consumerd32 err unix sock <br>
&gt; path:/home/yyan7/.lttng/ustconsumerd32/error<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693660355 [Main]: consumerd32 cmd unix sock <br>
&gt; path:/home/yyan7/.lttng/ustconsumerd32/command<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693668191 [Main]: consumerd64 <br>
&gt; path:/home/yyan7/.lttng/ustconsumerd64<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693673539 [Main]: consumerd64 bin <br>
&gt; path:/usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consumerd<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693682080 [Main]: consumerd64 lib dir: <br>
&gt; /usr/lib/x86_64-linux-gnu<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693689246 [Main]: consumerd64 err unix sock <br>
&gt; path:/home/yyan7/.lttng/ustconsumerd64/error<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693697419 [Main]: consumerd64 cmd unix sock <br>
&gt; path:/home/yyan7/.lttng/ustconsumerd64/command<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693706980 [Main]: kconsumerd path: <br>
&gt; /home/yyan7/.lttng/kconsumerd<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693714339 [Main]: kconsumerd err unix sock path: <br>
&gt; /home/yyan7/.lttng/kconsumerd/error<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693724836 [Main]: kconsumerd cmd unix sock path: <br>
&gt; /home/yyan7/.lttng/kconsumerd/command<br>
&gt; <br>
&gt; DBG1 - 10:25:05.693736058 [Main]: Starting lttng-sessiond <br>
&gt; {0e76c943-cc93-414c-81d5-259bf7e8d0e4} (in sessiond_uuid_log() at <br>
&gt; main.c:1437)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.693744764 [Main]: Creating LTTng run directory: <br>
&gt; /home/yyan7/.lttng (in create_lttng_rundir() at main.c:1069)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.696358185 [Main]: Resetting run_as worker signal <br>
&gt; handlers to default (in reset_sighandler() at runas.c:1377)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.696480798 [Main]: run_as signal handler set for SIGTER=
M <br>
&gt; and SIGINT (in set_worker_sighandlers() at runas.c:1438)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.697495897 [Main]: Health check time delta in seconds s=
et <br>
&gt; to 20 (in health_init() at health.c:62)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.697824357 [HT cleanup]: Entering thread entry point (i=
n <br>
&gt; launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.697915191 [HT cleanup]: startup. (in thread_ht_cleanup=
() <br>
&gt; at ht-cleanup.c:98)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.697964263 [HT cleanup]: epoll set max size is 7225299 =
<br>
&gt; (in compat_epoll_set_max_size() at poll.c:350)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.698012958 [Main]: Created hashtable size 4 at <br>
&gt; 0x5627de049140 of type ULONG (in lttng_ht_new() at hashtable.c:152)<br=
>
&gt; <br>
&gt; DBG3 - 10:25:05.698041846 [Main]: Created hashtable size 4 at <br>
&gt; 0x5627de049470 of type ULONG (in lttng_ht_new() at hashtable.c:152)<br=
>
&gt; <br>
&gt; DBG3 - 10:25:05.698056225 [Main]: Created hashtable size 4 at <br>
&gt; 0x5627de04bcd0 of type ULONG (in lttng_ht_new() at hashtable.c:152)<br=
>
&gt; <br>
&gt; DBG3 - 10:25:05.698065318 [HT cleanup]: Polling. (in thread_ht_cleanup=
() <br>
&gt; at ht-cleanup.c:122)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.698087629 [Main]: Created hashtable size 16 at <br>
&gt; 0x5627de04cf80 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.698104568 [Main]: Created hashtable size 16 at <br>
&gt; 0x5627de04e230 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.698117477 [Main]: Created hashtable size 16 at <br>
&gt; 0x5627de04f630 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.698127087 [Main]: Created hashtable size 4 at <br>
&gt; 0x5627de050a50 of type ULONG (in lttng_ht_new() at hashtable.c:152)<br=
>
&gt; <br>
&gt; DBG3 - 10:25:05.698142843 [Main]: Created hashtable size 4 at <br>
&gt; 0x5627de051d90 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG2 - 10:25:05.698158685 [Main]: Creating consumer directory: <br>
&gt; /home/yyan7/.lttng/ustconsumerd64 (in set_consumer_sockets() at main.c=
:1111)<br>
&gt; <br>
&gt; DBG2 - 10:25:05.698296819 [Main]: Creating consumer directory: <br>
&gt; /home/yyan7/.lttng/ustconsumerd32 (in set_consumer_sockets() at main.c=
:1111)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.698395187 [Main]: Created hashtable size 4 at <br>
&gt; 0x5627de0530d0 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.698404718 [Main]: Global buffer per UID registry <br>
&gt; initialized (in buffer_reg_init_uid_registry() at buffer-registry.c:90=
)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.698427501 [Main]: Created hashtable size 4 at <br>
&gt; 0x5627de054410 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.698435763 [Main]: Global buffer per PID registry <br>
&gt; initialized (in buffer_reg_init_pid_registry() at buffer-registry.c:21=
9)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.698444533 [Main]: Command subsystem initialized (in <b=
r>
&gt; cmd_init() at cmd.c:6090)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.698503908 [Main]: &#39;3506&#39; written in file <br>
&gt; /home/yyan7/.lttng/lttng-sessiond.pid (in utils_create_pid_file() at <=
br>
&gt; utils.c:257)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.698588286 [Main]: TCP inet operation timeout set to 21=
6 <br>
&gt; sec (in lttcomm_inet_init() at inet.c:545)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.698688270 [Main]: Waiting for health management thread=
 <br>
&gt; to be ready (in wait_until_thread_is_ready() at health.c:35)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.698771494 [Health management]: Entering thread entry <=
br>
&gt; point (in launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.698803482 [Health management]: [thread] Manage health =
<br>
&gt; check started (in thread_manage_health() at health.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.698964797 [Health management]: Marking health manageme=
nt <br>
&gt; thread as ready (in mark_thread_as_ready() at health.c:28)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.698981598 [Health management]: Health check ready (in =
<br>
&gt; thread_manage_health() at health.c:136)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.698991179 [Main]: Health management thread is ready (i=
n <br>
&gt; wait_until_thread_is_ready() at health.c:37)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699062770 [Main]: Waiting for notification thread to b=
e <br>
&gt; ready (in wait_until_thread_is_ready() at notification-thread.c:414)<b=
r>
&gt; <br>
&gt; DBG1 - 10:25:05.699151645 [Notification]: Entering thread entry point =
<br>
&gt; (in launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699184431 [Notification]: Started notification thread =
<br>
&gt; (in thread_notification() at notification-thread.c:642)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699255526 [Notification]: Creating notification channe=
l <br>
&gt; UNIX socket at /home/yyan7/.lttng/sessiond-notification (in <br>
&gt; notification_channel_socket_create() at notification-thread.c:223)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699357295 [Notification]: Notification channel UNIX <b=
r>
&gt; socket created (fd =3D 29) (in notification_channel_socket_create() at=
 <br>
&gt; notification-thread.c:258)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699387109 [Notification]: Listening on notification <b=
r>
&gt; channel socket (in init_thread_state() at notification-thread.c:442)<b=
r>
&gt; <br>
&gt; DBG1 - 10:25:05.699561257 [Notification]: Marking notification thread =
as <br>
&gt; ready (in mark_thread_as_ready() at notification-thread.c:407)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699576135 [Notification]: Entering poll wait (in <br>
&gt; thread_notification() at notification-thread.c:668)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699592002 [Main]: Notification thread is ready (in <br=
>
&gt; wait_until_thread_is_ready() at notification-thread.c:416)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699600050 [Action Executor]: Entering thread entry poi=
nt <br>
&gt; (in launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699632561 [Action Executor]: Entering work execution <=
br>
&gt; loop (in action_executor_thread() at action-executor.c:761)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699643395 [Action Executor]: No work items enqueued, <=
br>
&gt; entering wait (in action_executor_thread() at action-executor.c:770)<b=
r>
&gt; <br>
&gt; DBG1 - 10:25:05.699750672 [Timer]: Entering thread entry point (in <br=
>
&gt; launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699770466 [Rotation]: Entering thread entry point (in =
<br>
&gt; launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699793428 [Main]: Created client socket (fd =3D 35) (i=
n <br>
&gt; create_client_sock() at client.c:2435)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699796906 [Rotation]: Started rotation thread (in <br>
&gt; thread_rotation() at rotation-thread.c:840)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699868561 [Main]: Waiting for client thread to be read=
y <br>
&gt; (in wait_thread_status() at client.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699906378 [Client management]: Entering thread entry <=
br>
&gt; point (in launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.699943442 [Client management]: [thread] Manage client =
<br>
&gt; started (in thread_manage_clients() at client.c:2468)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700053570 [Client management]: Marking client thread&#=
39;s <br>
&gt; state as running (in set_thread_status() at client.c:58)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700067760 [Client management]: Accepting client comman=
d <br>
&gt; ... (in thread_manage_clients() at client.c:2534)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700076510 [Main]: Client thread is ready (in <br>
&gt; wait_thread_status() at client.c:68)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700180769 [UST registration dispatch]: Entering thread=
 <br>
&gt; entry point (in launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.700197002 [Main]: Session daemon application socket <b=
r>
&gt; created (fd =3D 41)(in create_application_socket() at register.c:71)<b=
r>
&gt; <br>
&gt; DBG1 - 10:25:05.700203416 [UST registration dispatch]: [thread] Dispat=
ch <br>
&gt; UST command started (in thread_dispatch_ust_registration() at <br>
&gt; dispatch.c:250)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700205198 [Notification]: Poll wait returned (1) (in <=
br>
&gt; thread_notification() at notification-thread.c:670)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700255843 [Notification]: Handling fd (29) activity (1=
) <br>
&gt; (in thread_notification() at notification-thread.c:694)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700269799 [Notification]: Handling new notification <b=
r>
&gt; channel client connection (in <br>
&gt; handle_notification_thread_client_connect() at <br>
&gt; notification-thread-events.c:3351)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700262016 [Main]: Waiting for application registration=
 <br>
&gt; thread to be ready (in wait_thread_status() at register.c:131)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700236776 [UST registration dispatch]: Futex n to 1 <b=
r>
&gt; prepare done (in futex_nto1_prepare() at futex.c:67)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700308063 [Notification]: Client socket (fd =3D 42) se=
t as <br>
&gt; non-blocking (in socket_set_non_blocking() at <br>
&gt; notification-thread-events.c:3319)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700319396 [UST registration dispatch]: Woken up but <b=
r>
&gt; nothing in the UST command queue (in thread_dispatch_ust_registration(=
) <br>
&gt; at dispatch.c:279)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700326116 [Notification]: Added new notification chann=
el <br>
&gt; client socket (42) to poll set (in <br>
&gt; handle_notification_thread_client_connect() at <br>
&gt; notification-thread-events.c:3404)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700372936 [Notification]: Entering poll wait (in <br>
&gt; thread_notification() at notification-thread.c:668)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700383798 [Notification]: Poll wait returned (1) (in <=
br>
&gt; thread_notification() at notification-thread.c:670)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700391774 [Notification]: Handling fd (42) activity (1=
) <br>
&gt; (in thread_notification() at notification-thread.c:694)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700405519 [Notification]: Entering poll wait (in <br>
&gt; thread_notification() at notification-thread.c:668)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700416164 [Notification]: Poll wait returned (1) (in <=
br>
&gt; thread_notification() at notification-thread.c:670)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700424451 [Notification]: Handling fd (42) activity (1=
) <br>
&gt; (in thread_notification() at notification-thread.c:694)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700439076 [Notification]: Received handshake from <br>
&gt; client: uid =3D 1000, gid =3D 1000, protocol version =3D 1.1, client i=
s <br>
&gt; sessiond =3D true (in client_handle_message_handshake() at <br>
&gt; notification-thread-events.c:3879)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700450858 [Notification]: Send command reply (0) (in <=
br>
&gt; client_send_command_reply() at notification-thread-events.c:3755)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700460524 [Notification]: Flushing client (socket fd =
=3D <br>
&gt; 42) outgoing queue (in client_flush_outgoing_queue() at <br>
&gt; notification-thread-events.c:3644)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700475786 [Notification]: Entering poll wait (in <br>
&gt; thread_notification() at notification-thread.c:668)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700505488 [Rotation]: Entering poll wait (in <br>
&gt; thread_rotation() at rotation-thread.c:864)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700506992 [UST application registration]: Entering <br=
>
&gt; thread entry point (in launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700529647 [UST application registration]: [thread] <br=
>
&gt; Manage application registration started (in <br>
&gt; thread_application_registration() at register.c:168)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700597995 [UST application registration]: Marking <br>
&gt; application registration thread&#39;s state as running (in <br>
&gt; set_thread_status() at register.c:124)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700609984 [UST application registration]: Accepting <b=
r>
&gt; application registration (in thread_application_registration() at <br>
&gt; register.c:207)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700616363 [Main]: Application registration thread is <=
br>
&gt; ready (in wait_thread_status() at register.c:134)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700627641 [Main]: Notifying applications of session <b=
r>
&gt; daemon state: 1 (in notify_ust_apps() at register.c:91)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700659113 [Main]: Wait shared memory file descriptor <=
br>
&gt; created successfully: path =3D &#39;/lttng-ust-wait-8-1000&#39;, mmap_=
size =3D 4096, <br>
&gt; global =3D false, fd =3D 45 (in get_wait_shm() at shm.c:133)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700688620 [Main]: Futex wait update active 1 (in <br>
&gt; futex_wait_update() at futex.c:55)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700795964 [UST application management]: Entering threa=
d <br>
&gt; entry point (in launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700824549 [UST application management]: [thread] Manag=
e <br>
&gt; application started (in thread_application_management() at manage-apps=
.c:52)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700848435 [Application notification]: Entering thread =
<br>
&gt; entry point (in launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700866212 [Application notification]: [ust-thread] <br=
>
&gt; Manage application notify command (in thread_application_notification(=
) <br>
&gt; at notify-apps.c:39)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700913055 [Main]: Waiting for agent management thread =
to <br>
&gt; be ready (in wait_until_thread_is_ready() at agent-thread.c:348)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700936679 [Agent management]: Entering thread entry <b=
r>
&gt; point (in launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.700952021 [Application notification]: [ust-thread] <br=
>
&gt; Manage notify polling (in thread_application_notification() at <br>
&gt; notify-apps.c:74)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700964639 [UST application management]: Apps thread <b=
r>
&gt; polling (in thread_application_management() at manage-apps.c:88)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.700955328 [Agent management]: Manage agent application=
 <br>
&gt; registration. (in thread_agent_management() at agent-thread.c:366)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.701062072 [Agent management]: URI string: <br>
&gt; tcp://localhost (in uri_parse() at uri.c:298)<br>
&gt; <br>
&gt; DBG2 - 10:25:05.701282226 [Agent management]: IP address resolved to <=
br>
&gt; 127.0.0.1 (in set_ip_address() at uri.c:155)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.701292578 [Agent management]: URI dtype: 1, proto: 1, =
<br>
&gt; host: localhost, subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:5=
10)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.701314205 [Agent management]: Trying to bind on port <=
br>
&gt; 5345 (in init_tcp_socket() at agent-thread.c:140)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.701330622 [Agent management]: Failed to bind to port <=
br>
&gt; 5345 since it is already in use (in init_tcp_socket() at agent-thread.=
c:148)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.701338804 [Agent management]: Trying to bind on port <=
br>
&gt; 5346 (in init_tcp_socket() at agent-thread.c:140)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.701351367 [Agent management]: Listening on TCP port 53=
46 <br>
&gt; and socket 54 (in init_tcp_socket() at agent-thread.c:177)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.701413970 [Agent management]: &#39;5346&#39; written i=
n file <br>
&gt; /home/yyan7/.lttng/agent.port (in utils_create_pid_file() at utils.c:2=
57)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.701452432 [Agent management]: Marking agent management=
 <br>
&gt; thread as ready (in mark_thread_as_ready() at agent-thread.c:341)<br>
&gt; <br>
&gt; DBG3 - 10:25:05.701466232 [Agent management]: Manage agent polling (in=
 <br>
&gt; thread_agent_management() at agent-thread.c:421)<br>
&gt; <br>
&gt; DBG1 - 10:25:05.701544565 [Main]: Agent management thread is ready (in=
 <br>
&gt; wait_until_thread_is_ready() at agent-thread.c:350)<br>
&gt; <br>
&gt; libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-discard-rt-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_discard_rt_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-discard-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_discard_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-overwrite-rt-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_overwrite_rt_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-overwrite-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_overwrite_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-metadata-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_metadata_client_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/metadata-template.h:371)<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$ ps -ef | grep lttng<br>
&gt; <br>
&gt; root 760 10 09:40 ?00:00:00 /usr/bin/*lttng*-sessiond<br>
&gt; <br>
&gt; root 808 7600 09:40 ?00:00:00 /usr/bin/*lttng*-sessiond<br>
&gt; <br>
&gt; yyan7 3496 10 10:24 ?00:00:00 *lttng*-relayd -v -b<br>
&gt; <br>
&gt; yyan7 3506 10 10:25 ?00:00:00 *lttng*-sessiond -vvv --verbose-consumer=
 -b<br>
&gt; <br>
&gt; yyan7 350735060 10:25 ?00:00:00 *lttng*-sessiond -vvv --verbose-consum=
er -b<br>
&gt; <br>
&gt; yyan7 352229970 10:25 pts/000:00:00 grep --color=3Dauto *lttng*<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$ lttng create<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436359096 [Client management]: Wait for client respons=
e <br>
&gt; (in thread_manage_clients() at client.c:2576)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436403534 [Client management]: Receiving data from <br=
>
&gt; client ... (in thread_manage_clients() at client.c:2604)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436419086 [Client management]: Incomplete recv() from =
<br>
&gt; client... continuing (in thread_manage_clients() at client.c:2608)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436438855 [Client management]: Accepting client comman=
d <br>
&gt; ... (in thread_manage_clients() at client.c:2534)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436458714 [Client management]: Wait for client respons=
e <br>
&gt; (in thread_manage_clients() at client.c:2576)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436480694 [Client management]: Receiving data from <br=
>
&gt; client ... (in thread_manage_clients() at client.c:2604)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436493760 [Client management]: Incomplete recv() from =
<br>
&gt; client... continuing (in thread_manage_clients() at client.c:2608)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436514391 [Client management]: Accepting client comman=
d <br>
&gt; ... (in thread_manage_clients() at client.c:2534)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436522846 [Client management]: Wait for client respons=
e <br>
&gt; (in thread_manage_clients() at client.c:2576)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436539198 [Client management]: Receiving data from <br=
>
&gt; client ... (in thread_manage_clients() at client.c:2604)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436561992 [Client management]: Processing client comma=
nd <br>
&gt; &#39;LTTNG_CREATE_SESSION_EXT&#39; (49) (in process_client_msg() at cl=
ient.c:1016)<br>
&gt; <br>
&gt; DBG3 - 10:25:35.436644534 [Client management]: Created hashtable size =
4 <br>
&gt; at 0x7fd67c0090b0 of type ULONG (in lttng_ht_new() at hashtable.c:152)=
<br>
&gt; <br>
&gt; DBG2 - 10:25:35.436670494 [Client management]: Trying to find session =
by <br>
&gt; name auto-20240112-102535 (in session_find_by_name() at session.c:1143=
)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436679003 [Client management]: Generated session name =
<br>
&gt; &quot;auto-20240112-102535&quot; (in session_create() at session.c:130=
0)<br>
&gt; <br>
&gt; DBG3 - 10:25:35.436693861 [Client management]: Created hashtable size =
4 <br>
&gt; at 0x7fd67c00a3f0 of type ULONG (in lttng_ht_new() at hashtable.c:152)=
<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436702475 [Client management]: Allocating <br>
&gt; ltt_sessions_ht_by_id (in ltt_sessions_ht_alloc() at session.c:306)<br=
>
&gt; <br>
&gt; DBG3 - 10:25:35.436719034 [Client management]: Created hashtable size =
4 <br>
&gt; at 0x7fd67c00b730 of type U64 (in lttng_ht_new() at hashtable.c:152)<b=
r>
&gt; <br>
&gt; DBG1 - 10:25:35.436727024 [Client management]: Allocating <br>
&gt; ltt_sessions_ht_by_name (in ltt_sessions_ht_alloc() at session.c:314)<=
br>
&gt; <br>
&gt; DBG3 - 10:25:35.436739320 [Client management]: Created hashtable size =
4 <br>
&gt; at 0x7fd67c00ca70 of type STRING (in lttng_ht_new() at hashtable.c:152=
)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436750021 [Client management]: Tracing session <br>
&gt; auto-20240112-102535 created with ID 0 by uid =3D 1000, gid =3D 1000 (=
in <br>
&gt; session_create() at session.c:1348)<br>
&gt; <br>
&gt; DBG3 - 10:25:35.436761891 [Client management]: URI string: <br>
&gt; file:///home/yyan7/lttng-traces/auto-20240112-102535 (in uri_parse() a=
t <br>
&gt; uri.c:298)<br>
&gt; <br>
&gt; DBG3 - 10:25:35.436786010 [Client management]: URI file destination: <=
br>
&gt; /home/yyan7/lttng-traces/auto-20240112-102535 (in uri_parse() at uri.c=
:335)<br>
&gt; <br>
&gt; DBG3 - 10:25:35.436794369 [Client management]: URI dtype: 3, proto: 0,=
 <br>
&gt; host: , subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:510)<br>
&gt; <br>
&gt; DBG2 - 10:25:35.436815787 [Client management]: Setting trace directory=
 <br>
&gt; path from URI to /home/yyan7/lttng-traces/auto-20240112-102535 (in <br=
>
&gt; add_uri_to_consumer() at cmd.c:719)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436861339 [Client management]: Sending response (size:=
 <br>
&gt; 8262, retcode: Success (10)) (in thread_manage_clients() at client.c:2=
683)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.436885647 [Client management]: Accepting client comman=
d <br>
&gt; ... (in thread_manage_clients() at client.c:2534)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.437011410 [Client management]: Wait for client respons=
e <br>
&gt; (in thread_manage_clients() at client.c:2576)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.437037211 [Client management]: Receiving data from <br=
>
&gt; client ... (in thread_manage_clients() at client.c:2604)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.437050433 [Client management]: Incomplete recv() from =
<br>
&gt; client... continuing (in thread_manage_clients() at client.c:2608)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.437065744 [Client management]: Accepting client comman=
d <br>
&gt; ... (in thread_manage_clients() at client.c:2534)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.437074955 [Client management]: Wait for client respons=
e <br>
&gt; (in thread_manage_clients() at client.c:2576)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.437088320 [Client management]: Receiving data from <br=
>
&gt; client ... (in thread_manage_clients() at client.c:2604)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.437107173 [Client management]: Processing client comma=
nd <br>
&gt; &#39;LTTNG_LIST_SESSIONS&#39; (13) (in process_client_msg() at client.=
c:1016)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.437120952 [Client management]: Counting number of <br>
&gt; available session for UID 1000 (in lttng_sessions_count() at client.c:=
596)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.437130882 [Client management]: Getting all available <=
br>
&gt; session for UID 1000 GID 1000 (in cmd_list_lttng_sessions() at cmd.c:3=
947)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.437141977 [Client management]: Sending response (size:=
 <br>
&gt; 4409, retcode: Success (10)) (in thread_manage_clients() at client.c:2=
683)<br>
&gt; <br>
&gt; DBG1 - 10:25:35.437163179 [Client management]: Accepting client comman=
d <br>
&gt; ... (in thread_manage_clients() at client.c:2534)<br>
&gt; <br>
&gt; Session auto-20240112-102535 created.<br>
&gt; <br>
&gt; Traces will be output to /home/yyan7/lttng-traces/auto-20240112-102535=
<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$ lttng enable-event -u -all<br>
&gt; <br>
&gt; Error: Only one domain must be specified.<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$ lttng enable-event -u -a<br>
&gt; <br>
&gt; DBG1 - 10:26:09.048651842 [Client management]: Wait for client respons=
e <br>
&gt; (in thread_manage_clients() at client.c:2576)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.048698882 [Client management]: Receiving data from <br=
>
&gt; client ... (in thread_manage_clients() at client.c:2604)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.048730037 [Client management]: Processing client comma=
nd <br>
&gt; &#39;LTTNG_ENABLE_EVENT&#39; (6) (in process_client_msg() at client.c:=
1016)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.048742929 [Client management]: Getting session <br>
&gt; auto-20240112-102535 by name (in process_client_msg() at client.c:1133=
)<br>
&gt; <br>
&gt; DBG2 - 10:26:09.048752328 [Client management]: Trying to find session =
by <br>
&gt; name auto-20240112-102535 (in session_find_by_name() at session.c:1143=
)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.048762009 [Client management]: Creating UST session (i=
n <br>
&gt; create_ust_session() at client.c:510)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.048777715 [Client management]: Created hashtable size =
4 <br>
&gt; at 0x7fd67c00ffd0 of type STRING (in lttng_ht_new() at hashtable.c:152=
)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.048801459 [Client management]: Created hashtable size =
4 <br>
&gt; at 0x7fd67c011310 of type U64 (in lttng_ht_new() at hashtable.c:152)<b=
r>
&gt; <br>
&gt; DBG3 - 10:26:09.048877638 [Client management]: Created hashtable size =
4 <br>
&gt; at 0x7fd67c020120 of type ULONG (in lttng_ht_new() at hashtable.c:152)=
<br>
&gt; <br>
&gt; DBG2 - 10:26:09.048886268 [Client management]: UST trace session creat=
e <br>
&gt; successful (in trace_ust_create_session() at trace-ust.c:324)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.048894968 [Client management]: Copying tracing session=
 <br>
&gt; consumer output in UST session (in copy_session_consumer() at client.c=
:454)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.048930287 [Client management]: Created hashtable size =
4 <br>
&gt; at 0x7fd67c0213d0 of type ULONG (in lttng_ht_new() at hashtable.c:152)=
<br>
&gt; <br>
&gt; DBG3 - 10:26:09.048944965 [Client management]: Copy session consumer <=
br>
&gt; subdir ust (in copy_session_consumer() at client.c:476)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.048955915 [Client management]: Spawning consumerd (in =
<br>
&gt; spawn_consumerd() at client.c:204)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.048988740 [HT cleanup]: Returning from poll on 2 fds. =
<br>
&gt; (in thread_ht_cleanup() at ht-cleanup.c:125)<br>
&gt; <br>
&gt; DBG2 - 10:26:09.049819491 [Client management]: Consumer pid 3526 (in <=
br>
&gt; start_consumerd() at client.c:390)<br>
&gt; <br>
&gt; DBG2 - 10:26:09.049855514 [Client management]: Spawning consumer contr=
ol <br>
&gt; thread (in start_consumerd() at client.c:393)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.049986094 [Client management]: Waiting for consumer <b=
r>
&gt; management thread to be ready (in wait_until_thread_is_ready() at <br>
&gt; manage-consumer.c:46)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.050081839 [Consumer management]: Entering thread entry=
 <br>
&gt; point (in launch_thread() at thread.c:65)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.050074834 [Client management]: Using 64-bit UST consum=
er <br>
&gt; at: /usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consumerd (in <br>
&gt; spawn_consumerd() at client.c:284)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.050117556 [Consumer management]: [thread] Manage <br>
&gt; consumer started (in thread_consumer_management() at manage-consumer.c=
:65)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.050103089 [HT cleanup]: Polling. (in thread_ht_cleanup=
() <br>
&gt; at ht-cleanup.c:122)<br>
&gt; <br>
&gt; libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-metadata-mmap&quot; init<br>
&gt; <br>
&gt; (in lttng_ring_buffer_metadata_client_init() at <br>
&gt; ../../src/common/ringbuffer-clients/metadata-template.h:364)<br>
&gt; <br>
&gt; libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-overwrite-mmap&quot; init<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_overwrite_init() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:826)<br>
&gt; <br>
&gt; libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-overwrite-rt-mmap&quot; init<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_overwrite_rt_init() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:826)<br>
&gt; <br>
&gt; libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-discard-mmap&quot; init<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_discard_init() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:826)<br>
&gt; <br>
&gt; libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-discard-rt-mmap&quot; init<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_discard_rt_init() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:826)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.054724418 [3526/3526]: Health check time delta in <br>
&gt; seconds set to 20 (in health_init() at health.c:62)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.054993129 [3526/3526]: Created hashtable size 4 at <br=
>
&gt; 0x561838919540 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.055012947 [3526/3526]: Created hashtable size 4 at <br=
>
&gt; 0x561838919870 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.055026387 [3526/3526]: Created hashtable size 4 at <br=
>
&gt; 0x561838919ba0 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.055038707 [3526/3526]: Created hashtable size 4 at <br=
>
&gt; 0x561838919ed0 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.055052418 [3526/3526]: Created hashtable size 4 at <br=
>
&gt; 0x56183891eb00 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.055070118 [3526/3526]: Created hashtable size 4 at <br=
>
&gt; 0x56183891fe40 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.055079438 [3526/3526]: Created hashtable size 4 at <br=
>
&gt; 0x561838921180 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.055131986 [3526/3526]: TCP inet operation timeout set =
to <br>
&gt; 216 sec (in lttcomm_inet_init() at inet.c:545)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.055169397 [3526/3526]: Connecting to error socket <br>
&gt; /home/yyan7/.lttng/ustconsumerd64/error (in main() at lttng-consumerd.=
c:477)<br>
&gt; <br>
&gt; DBG2 - 10:26:09.055307314 [Consumer management]: Receiving code from <=
br>
&gt; consumer err_sock (in thread_consumer_management() at manage-consumer.=
c:162)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.055374257 [3526/3530]: [thread] Manage health check <b=
r>
&gt; started (in thread_manage_health() at health-consumerd.c:157)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.055528236 [3526/3530]: epoll set max size is 7225299 (=
in <br>
&gt; compat_epoll_set_max_size() at poll.c:350)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.055617358 [3526/3530]: Health check ready (in <br>
&gt; thread_manage_health() at health-consumerd.c:237)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.155778508 [3526/3533]: Thread metadata poll started (i=
n <br>
&gt; consumer_thread_metadata_poll() at consumer.c:2344)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.155827680 [3526/3532]: Created hashtable size 4 at <br=
>
&gt; 0x7fb838000b90 of type U64 (in lttng_ht_new() at hashtable.c:152)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.155854441 [3526/3532]: Thread channel poll started (in=
 <br>
&gt; consumer_thread_channel_poll() at consumer.c:2938)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.155873849 [3526/3532]: Channel main loop started (in <=
br>
&gt; consumer_thread_channel_poll() at consumer.c:2953)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.155884744 [3526/3532]: Channel poll wait (in <br>
&gt; consumer_thread_channel_poll() at consumer.c:2958)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.155910091 [3526/3533]: Metadata main loop started (in =
<br>
&gt; consumer_thread_metadata_poll() at consumer.c:2360)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.155915209 [3526/3535]: Creating command socket <br>
&gt; /home/yyan7/.lttng/ustconsumerd64/command (in <br>
&gt; consumer_thread_sessiond_poll() at consumer.c:3201)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.155927055 [3526/3533]: Metadata poll wait (in <br>
&gt; consumer_thread_metadata_poll() at consumer.c:2366)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.155902292 [3526/3534]: Updating poll fd array (in <br>
&gt; update_poll_array() at consumer.c:1176)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.155992208 [3526/3534]: polling on 2 fd (in <br>
&gt; consumer_thread_data_poll() at consumer.c:2627)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156028520 [3526/3535]: Sending ready command to <br>
&gt; lttng-sessiond (in consumer_thread_sessiond_poll() at consumer.c:3214)=
<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156117370 [3526/3535]: Connection on client_socket (in=
 <br>
&gt; consumer_thread_sessiond_poll() at consumer.c:3236)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156118051 [Consumer management]: Consumer command sock=
et <br>
&gt; ready (fd: 61) (in thread_consumer_management() at manage-consumer.c:2=
04)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156134055 [Consumer management]: Consumer metadata <br=
>
&gt; socket ready (fd: 62) (in thread_consumer_management() at <br>
&gt; manage-consumer.c:205)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156140605 [3526/3535]: Metadata connection on <br>
&gt; client_socket (in set_metadata_socket() at consumer.c:3162)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156159591 [Consumer management]: Sending consumer <br>
&gt; initialization command (in consumer_init() at consumer.c:1791)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156197563 [3526/3535]: Incoming command on sock (in <b=
r>
&gt; consumer_thread_sessiond_poll() at consumer.c:3282)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156239708 [3526/3535]: Received session daemon UUID: <=
br>
&gt; 0e76c943-cc93-414c-81d5-259bf7e8d0e4 (in lttng_consumer_init_command()=
 <br>
&gt; at consumer.c:4711)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156260388 [3526/3535]: Received command on sock (in <b=
r>
&gt; consumer_thread_sessiond_poll() at consumer.c:3298)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.156271768 [Consumer management]: Sending <br>
&gt; SET_CHANNEL_MONITOR_PIPE command to consumer (in consumer_send_pipe() =
at <br>
&gt; consumer.c:1230)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156298833 [3526/3535]: Incoming command on sock (in <b=
r>
&gt; consumer_thread_sessiond_poll() at consumer.c:3282)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.156339394 [Consumer management]: Sending channel monit=
or <br>
&gt; pipe 16 to consumer on socket 61 (in consumer_send_pipe() at <br>
&gt; consumer.c:1236)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156373728 [3526/3535]: Received channel monitor pipe <=
br>
&gt; (27) (in lttng_ustconsumer_recv_cmd() at ust-consumer.c:2017)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156385429 [3526/3535]: Channel monitor pipe set as <br=
>
&gt; non-blocking (in lttng_ustconsumer_recv_cmd() at ust-consumer.c:2040)<=
br>
&gt; <br>
&gt; DBG1 - 10:26:09.156398125 [3526/3535]: Received command on sock (in <b=
r>
&gt; consumer_thread_sessiond_poll() at consumer.c:3298)<br>
&gt; <br>
&gt; DBG2 - 10:26:09.156408026 [Consumer management]: channel monitor pipe =
<br>
&gt; successfully sent (in consumer_send_pipe() at consumer.c:1244)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156521209 [Consumer management]: Marking consumer <br>
&gt; management thread as ready (in mark_thread_as_ready() at <br>
&gt; manage-consumer.c:31)<br>
&gt; <br>
&gt; DBG1 - 10:26:09.156618144 [Client management]: Consumer management <br=
>
&gt; thread is ready (in wait_until_thread_is_ready() at manage-consumer.c:=
48)<br>
&gt; <br>
&gt; DBG3 - 10:26:09.156649336 [Client management]: Consumer socket created=
 <br>
&gt; (fd: 61) and added to output (in consumer_create_socket() at consumer.=
c:351)<br>
&gt; <br>
&gt; *DBG1 - 10:26:09.156661610 [Client management]: Setting relayd for <br=
>
&gt; session auto-20240112-102535 (in cmd_setup_relayd() at cmd.c:1004)*<br=
>
&gt; <br>
&gt; *lttng-sessiond: unix.c:185: lttcomm_recv_unix_sock: Assertion `buf&#3=
9; <br>
&gt; failed.*<br>
&gt; <br>
&gt; DBG1 - 10:26:10.269878943 [3526/3535]: Incoming command on sock (in <b=
r>
&gt; consumer_thread_sessiond_poll() at consumer.c:3282)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.269909824 [3526/3535]: Consumer received unexpected <b=
r>
&gt; message size 0 (expects 12690) (in lttng_ustconsumer_recv_cmd() at <br=
>
&gt; ust-consumer.c:1401)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.269918771 [3526/3535]: Communication interrupted on <b=
r>
&gt; command socket (in consumer_thread_sessiond_poll() at consumer.c:3289)=
<br>
&gt; <br>
&gt; DBG1 - 10:26:10.269924634 [3526/3535]: Consumer thread sessiond poll <=
br>
&gt; exiting (in consumer_thread_sessiond_poll() at consumer.c:3304)<br>
&gt; <br>
&gt; Error: Events: No session daemon is available (channel channel0, sessi=
on <br>
&gt; auto-20240112-102535)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.269945294 [3526/3535]: UST consumer closing all metada=
ta <br>
&gt; streams (in lttng_ustconsumer_close_all_metadata() at ust-consumer.c:3=
278)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270034860 [3526/3534]: poll num_rdy : 1 (in <br>
&gt; consumer_thread_data_poll() at consumer.c:2634)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270051195 [3526/3532]: Channel poll return from wait <=
br>
&gt; with 1 fd(s) (in consumer_thread_channel_poll() at consumer.c:2961)<br=
>
&gt; <br>
&gt; DBG1 - 10:26:10.270085710 [3526/3532]: Channel event caught in thread =
<br>
&gt; (in consumer_thread_channel_poll() at consumer.c:2964)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270066746 [3526/3534]: consumer_data_pipe wake up (in =
<br>
&gt; consumer_thread_data_poll() at consumer.c:2664)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270051357 [3526/3530]: Health check thread dying (in <=
br>
&gt; thread_manage_health() at health-consumerd.c:334)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270114085 [3526/3532]: Channel poll wait (in <br>
&gt; consumer_thread_channel_poll() at consumer.c:2958)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270151938 [3526/3532]: Channel poll return from wait <=
br>
&gt; with 0 fd(s) (in consumer_thread_channel_poll() at consumer.c:2961)<br=
>
&gt; <br>
&gt; DBG1 - 10:26:10.270163529 [3526/3532]: Channel event caught in thread =
<br>
&gt; (in consumer_thread_channel_poll() at consumer.c:2964)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270115093 [3526/3534]: Consumer delete flagged data <b=
r>
&gt; stream (in validate_endpoint_status_data_stream() at consumer.c:2274)<=
br>
&gt; <br>
&gt; DBG1 - 10:26:10.270187345 [3526/3534]: polling thread exiting (in <br>
&gt; consumer_thread_data_poll() at consumer.c:2806)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270226737 [3526/3533]: Metadata poll return from wait =
<br>
&gt; with 1 fd(s) (in consumer_thread_metadata_poll() at consumer.c:2368)<b=
r>
&gt; <br>
&gt; DBG1 - 10:26:10.270255651 [3526/3533]: Metadata event caught in thread=
 <br>
&gt; (in consumer_thread_metadata_poll() at consumer.c:2371)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270264901 [3526/3533]: Metadata thread pipe hung up (i=
n <br>
&gt; consumer_thread_metadata_poll() at consumer.c:2426)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270270628 [3526/3532]: Channel poll thread exiting (in=
 <br>
&gt; consumer_thread_channel_poll() at consumer.c:3140)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270284048 [3526/3533]: Metadata poll wait (in <br>
&gt; consumer_thread_metadata_poll() at consumer.c:2366)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270292833 [3526/3533]: Metadata poll return from wait =
<br>
&gt; with 0 fd(s) (in consumer_thread_metadata_poll() at consumer.c:2368)<b=
r>
&gt; <br>
&gt; DBG1 - 10:26:10.270300375 [3526/3533]: Metadata event caught in thread=
 <br>
&gt; (in consumer_thread_metadata_poll() at consumer.c:2371)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270310033 [3526/3533]: Metadata poll thread exiting (i=
n <br>
&gt; consumer_thread_metadata_poll() at consumer.c:2521)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270463392 [3526/3526]: Releasing trace chunk registry =
to <br>
&gt; all trace chunks (in lttng_trace_chunk_registry_put_each_chunk() at <b=
r>
&gt; trace-chunk.c:2221)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270476593 [3526/3526]: Released reference to 0 trace <=
br>
&gt; chunks in lttng_trace_chunk_registry_put_each_chunk() (in <br>
&gt; lttng_trace_chunk_registry_put_each_chunk() at trace-chunk.c:2254)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270667263 [3526/3526]: Consumer destroying it. Closing=
 <br>
&gt; everything. (in lttng_consumer_destroy() at consumer.c:1546)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270812838 [3526/3526]: Destroying run_as worker (in <b=
r>
&gt; run_as_destroy_worker_no_lock() at runas.c:1576)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.270818934 [3526/3526]: Closing run_as worker socket (i=
n <br>
&gt; run_as_destroy_worker_no_lock() at runas.c:1581)<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$ libringbuffer-clients[3528/3528]: LTT : ltt=
 <br>
&gt; ring buffer client &quot;relay-discard-rt-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_discard_rt_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3528/3528]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-discard-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_discard_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3528/3528]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-overwrite-rt-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_overwrite_rt_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3528/3528]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-overwrite-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_overwrite_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3528/3528]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-metadata-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_metadata_client_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/metadata-template.h:371)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.271345058 [3526/3526]: lttng-runas terminated with <br=
>
&gt; status code 0 (in run_as_destroy_worker_no_lock() at runas.c:1601)<br>
&gt; <br>
&gt; libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-discard-rt-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_discard_rt_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-discard-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_discard_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-overwrite-rt-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_overwrite_rt_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-overwrite-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_overwrite_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-metadata-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_metadata_client_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/metadata-template.h:371)<br>
&gt; <br>
&gt; DBG1 - 10:26:10.271715039 [Run-as worker]: run_as worker exiting (ret =
=3D <br>
&gt; 0) (in run_as_create_worker_no_lock() at runas.c:1526)<br>
&gt; <br>
&gt; libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-discard-rt-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_discard_rt_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-discard-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_discard_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-overwrite-rt-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_overwrite_rt_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-overwrite-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_client_overwrite_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/template.h:833)<br>
&gt; <br>
&gt; libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client <br>
&gt; &quot;relay-metadata-mmap&quot; exit<br>
&gt; <br>
&gt; (in lttng_ring_buffer_metadata_client_exit() at <br>
&gt; ../../src/common/ringbuffer-clients/metadata-template.h:371)<br>
&gt; <br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*~*$<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On Fri, Jan 12, 2024 at 10:01=E2=80=AFAM Kienan Stewart &lt;<a href=3D=
"mailto:kstewart@efficios.com" target=3D"_blank">kstewart@efficios.com</a> =
<br>
&gt; &lt;mailto:<a href=3D"mailto:kstewart@efficios.com" target=3D"_blank">=
kstewart@efficios.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Yonghong,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0in a brief test I&#39;m unable to reproduce the err=
or you see by running<br>
&gt;=C2=A0 =C2=A0 =C2=A0the<br>
&gt;=C2=A0 =C2=A0 =C2=A0following commands on an Ubuntu 22.04 installation =
with lttng-tools<br>
&gt;=C2=A0 =C2=A0 =C2=A02.13.10, lttng-ust 2.13.6, urcu stable-0.12, and ba=
beltrace stable-2.0.<br>
&gt;=C2=A0 =C2=A0 =C2=A0```<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ uname -r -v<br>
&gt;=C2=A0 =C2=A0 =C2=A06.5.0-14-generic #14~22.04.1-Ubuntu SMP PREEMPT_DYN=
AMIC Mon Nov 20<br>
&gt;=C2=A0 =C2=A0 =C2=A018:15:30 UTC 2<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0$ lttng-relayd -v -b<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ lttng-sessiond -v -b<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ lttng create<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ lttng enable-event -u --all<br>
&gt;=C2=A0 =C2=A0 =C2=A0```<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Could you please review the bug reporting guideline=
s at<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lttng.org/community/" rel=3D"nor=
eferrer" target=3D"_blank">https://lttng.org/community/</a> &lt;<a href=3D"=
https://lttng.org/community/" rel=3D"noreferrer" target=3D"_blank">https://=
lttng.org/community/</a>&gt; and<br>
&gt;=C2=A0 =C2=A0 =C2=A0elaborate on the steps taken to<br>
&gt;=C2=A0 =C2=A0 =C2=A0reproduce the issue?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0kienan<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 1/12/24 08:12, Yonghong Yan via lttng-dev wrote:=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I am not sure=C2=A0whether=C2=A0this is my se=
tting problem or a bug with a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; more=C2=A0recent=C2=A0kernel. lttng-sessiond =
was killed when I tried to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;enable<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; event&quot; after a session was created. See =
below part of the verbose<br>
&gt;=C2=A0 =C2=A0 =C2=A0output<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; of the sessiond. It is observed on Ubuntu 22.=
04, kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A06.5.0-14-generic<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; #14~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC, lttng=
 (LTTng Trace Control)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 2.13.10 - Nordicit=C3=A9.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; The same version of LTTng works on another Ub=
untu 22.04 machine, but<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; with kernel 6.2.0-33-generic. Any suggestion =
on what I should try?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Thank you<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Yonghong<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; c:1016)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.134138433 [Client management]=
: Getting session<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; auto-20240112-002417 by name (in process_clie=
nt_msg() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0client.c:1133)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.134148894 [Client management]=
: Creating UST<br>
&gt;=C2=A0 =C2=A0 =C2=A0session (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; create_ust_session() at client.c:510)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.134267958 [Client management]=
: Spawning consumerd<br>
&gt;=C2=A0 =C2=A0 =C2=A0(in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; spawn_consumerd() at client.c:204)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.135155823 [Client management]=
: Waiting for consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; management thread to be ready (in wait_until_=
thread_is_ready() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; manage-consumer.c:46)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.135247552 [Consumer managemen=
t]: Entering thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0entry<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; point (in launch_thread() at thread.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.135293542 [Consumer managemen=
t]: [thread] Manage<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer started (in thread_consumer_manageme=
nt() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0manage-consumer.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.135335776 [Client management]=
: Using 64-bit UST<br>
&gt;=C2=A0 =C2=A0 =C2=A0consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at: /usr/lib/x86_64-linux-gnu/lttng/libexec/l=
ttng-consumerd (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; spawn_consumerd() at client.c:284)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.240725883 [Consumer managemen=
t]: Consumer command<br>
&gt;=C2=A0 =C2=A0 =C2=A0socket<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ready (fd: 61) (in thread_consumer_management=
() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0manage-consumer.c:204)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.240746802 [Consumer managemen=
t]: Consumer metadata<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; socket ready (fd: 62) (in thread_consumer_man=
agement() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; manage-consumer.c:205)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.240775318 [Consumer managemen=
t]: Sending consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; initialization command (in consumer_init() at=
 consumer.c:1791)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.241066762 [Consumer managemen=
t]: Marking consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; management thread as ready (in mark_thread_as=
_ready() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; manage-consumer.c:31)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.241100481 [Client management]=
: Consumer management<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread is ready (in wait_until_thread_is_read=
y() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0manage-consumer.c:48)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.241138386 [Client management]=
: Setting relayd for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; session auto-20240112-002417 (in cmd_setup_re=
layd() at cmd.c:1004)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng-sessiond: unix.c:185: lttcomm_recv_unix=
_sock: Assertion<br>
&gt;=C2=A0 =C2=A0 =C2=A0`buf&#39; failed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Error: Events: No session daemon is available=
 (channel channel0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0session<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; auto-20240112-002417)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; [1]+Aborted (core dumped) lttng-sessiond --ve=
rbose<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:26.357769106 [Run-as worker]: ru=
n_as worker exiting<br>
&gt;=C2=A0 =C2=A0 =C2=A0(ret =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0) (in run_as_create_worker_no_lock() at runa=
s.c:1526)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; _____________________________________________=
__<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng-dev mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" =
target=3D"_blank">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailt=
o:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a=
>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://list=
s.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>&gt;<br>
&gt; <br>
</blockquote></div>

--000000000000ded3dc060ec5a542--

--===============3368377853117047982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3368377853117047982==--
