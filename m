Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551ECC4707C
	for <lttng-dev@archiver.kernel.org>; Sat, 13 Jan 2024 03:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705117727;
	bh=ejA3hhASlXiqsxXd44fVOGe8hxSdEjTM/MzYf4kLDaA=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RrNiZG4j8zjhezIPXbPLSI0fBJ/3xaf4darZBfTpYV3LjLvxOZ//LRnxl51zHduod
	 0f8Dd6tMQ70I2acf06VowLsAT3ChfG0yrH6fZcKMuL9l0mRZQhvjLhSnZLpDssJcpQ
	 UMVwBmE/gsFLE9y/7JQtu/avbRbruuiK4+rql21ai+Jm/729jAwBZlunyMj0XF8m4/
	 /jpVTTKxkMkydZmX6CyWP9I8gFZAQHBLZCijy3o5TV8FRBlxwv7b1zQd7tdliwLh4x
	 /eUqn9kAWz1TUkKVfWCBLQqj9cbRmX++/ZEaMmzAgRlwq9TaSDa/yCFwlv2EDKQr6+
	 1diZFetJbl2sg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TBksV4nH4z1MMQ;
	Fri, 12 Jan 2024 22:48:46 -0500 (EST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by lists.lttng.org (Postfix) with ESMTPS id 4TBksT4bmyz1M9j
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jan 2024 22:48:45 -0500 (EST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a29058bb2ceso773372666b.0
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jan 2024 19:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705117724; x=1705722524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f+fKZvhwNWP3EBP549m7dpHo7ejPBsCt9XsF+CZ8eiE=;
 b=DvAsin4nU5PXV5tUFE7IqzY+uLbZXcErkS9AMtunwVNKbT86ozNTEjsbTwSWpQbdB9
 y9QYs3sirpj7mTOFLz9SEQVun2dFPeMMYhz6bMRziQFbOCkVor/1G0X3f9+G282YnKbn
 Tkz/zvmnGuGeJegNQeflUBqCe/sqlmwMaE3p+hP+zKNPsbwaLYcyz6jfCc8uqPbEfSpl
 PTfQ9y4DmCb+F0yWEnzRqqYbYlZ8Y5mqirHMj38CakvnTNZ0zQB9BTeXRBNbPZyge/+X
 JSETqtGVp+/yFQjKPQcgaVmgky/fhflpdVSlBRQryZw+FsK8kj4EW5dSi9GNJofw56+R
 ydgA==
X-Gm-Message-State: AOJu0YzpzPBIPcRuNaKpBla762TtoRE9DyOaZLLe6hsoY2qQP0y4XcFE
 Odpnz3y+d2+UpkP96cjJdFuZugk2PrWVW/+8Rjo=
X-Google-Smtp-Source: AGHT+IGyVq9vTliQX2F6RmWw4mzlOPXmLK+bPSA4J90m7iwv1hfGOa1E2L46oFzsa8gFS1mRt1QqeBr+/X8zmw+8/JM=
X-Received: by 2002:a17:906:b343:b0:a28:c0c2:2d56 with SMTP id
 cd3-20020a170906b34300b00a28c0c22d56mr675453ejb.226.1705117723807; Fri, 12
 Jan 2024 19:48:43 -0800 (PST)
MIME-Version: 1.0
References: <CACJEY861mX+FerESW6O6pTU7CzadHGDSBF9HktNrXr_fGp-Hcw@mail.gmail.com>
 <0797f455-b051-405f-9814-294e6867241c@efficios.com>
 <CACJEY847OEguyrq2WYxKMLQ4sSf59fdFYKZZe4ZR16Wsaajeqw@mail.gmail.com>
 <98730be3-4268-4641-9e3f-418b08f12895@efficios.com>
 <CACJEY84WKMRK9zCkx8ztFoqnKMdNOSWdoV_e5Se3F2uqX170Pg@mail.gmail.com>
 <56d74293-502b-46c9-82d2-85947195d566@efficios.com>
 <CACJEY858fCWUc5yZJQyct+9ASHOb9jigjwtNfWQ9dP7qB3H=tg@mail.gmail.com>
In-Reply-To: <CACJEY858fCWUc5yZJQyct+9ASHOb9jigjwtNfWQ9dP7qB3H=tg@mail.gmail.com>
Date: Fri, 12 Jan 2024 22:48:31 -0500
Message-ID: <CACJEY84DuPueojD0LK++zd1kdFxFMTiVkH71BxGjCcuKo+eSLw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2296450865840197942=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2296450865840197942==
Content-Type: multipart/alternative; boundary="0000000000003a55b9060ecba800"

--0000000000003a55b9060ecba800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kienan,

I just figured out what I did wrong. After I rebuilt the system the day
before and installed lttng-modules-dkms from Ubuntu officially, the
building of kernel modules failed (I can send you the crash and make.log
for you to look at). I then added Ubuntu: LTTng Stable 2.13 PPA, and
installation passed. With that, what installed are mix/mismatch of kms and
binary of the partially installed kms from Ubuntu official and from stable
2.13 ppa. That caused the problem. I now removed everything and reinstalled
everything from stable 2.13 ppa, everything works.

Thank you for helping me through this.

Best,
Yonghong

On Fri, Jan 12, 2024 at 10:04=E2=80=AFPM Yonghong Yan <yanyh15@gmail.com> w=
rote:

> Hi Kienan,
>
> Thank you. I tried and unfortunately, there is no debuginfo in the
> https://debuginfod.ubuntu.com repo. I tried https://debuginfod.debian.net=
/
> as well. No debug info. If you have a debug info file and can send to me,=
 I
> can use it in gdb to see the backtrace.
>
> Best,
> Yonghong
>
> *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ export DEBUGINFOD_URLS=
=3D"
> https://debuginfod.ubuntu.com"
>
> *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ gdb
> /usr/bin/lttng-sessiond
> core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.10=
470.2023109
>
>
> *GNU gdb (Ubuntu 12.1-0ubuntu1~22.04) 12.1*
>
> Copyright (C) 2022 Free Software Foundation, Inc.
>
> License GPLv3+: GNU GPL version 3 or later <
> http://gnu.org/licenses/gpl.html>
>
> This is free software: you are free to change and redistribute it.
>
> There is NO WARRANTY, to the extent permitted by law.
>
> Type "show copying" and "show warranty" for details.
>
> This GDB was configured as "x86_64-linux-gnu".
>
> Type "show configuration" for configuration details.
>
> For bug reporting instructions, please see:
>
> <https://www.gnu.org/software/gdb/bugs/>.
>
> Find the GDB manual and other documentation resources online at:
>
>     <http://www.gnu.org/software/gdb/documentation/>.
>
>
> For help, type "help".
>
> Type "apropos word" to search for commands related to "word"...
>
> Reading symbols from /usr/bin/lttng-sessiond...
>
>
> This GDB supports auto-downloading debuginfo from the following URLs:
>
> https://debuginfod.ubuntu.com
>
> Enable debuginfod for this session? (y or [n]) y
>
> Debuginfod has been enabled.
>
> To make this setting permanent, add 'set debuginfod enabled on' to
> .gdbinit.
>
> (No debugging symbols found in /usr/bin/lttng-sessiond)
>
> [New LWP 10479]
>
> [New LWP 10470]
>
> [New LWP 10476]
>
> [New LWP 10475]
>
> [New LWP 10472]
>
> [New LWP 10478]
>
> [New LWP 10480]
>
> [New LWP 10473]
>
> [New LWP 10477]
>
> [New LWP 10482]
>
> [New LWP 10542]
>
> [New LWP 10533]
>
> [New LWP 10484]
>
> [New LWP 10474]
>
> [New LWP 10481]
>
> [New LWP 10483]
>
> Downloading 0.19 MB separate debug info for
> /lib/x86_64-linux-gnu/libkmod.so.2
>
> Downloading 0.89 MB separate debug info for
> /lib/x86_64-linux-gnu/liblttng-ctl.so.0
>
>
> Downloading 0.05 MB separate debug info for
> /lib/x86_64-linux-gnu/liburcu.so.8
>
>
> Downloading 0.01 MB separate debug info for
> /home/yyan7/.cache/debuginfod_client/55485e3e07dd2ab7e3510c9f90e8e8607f07=
d0c2/debuginfo
>
> Downloading 0.03 MB separate debug info for
> /lib/x86_64-linux-gnu/liburcu-common.so.8
>
> Downloading 0.07 MB separate debug info for
> /lib/x86_64-linux-gnu/liburcu-cds.so.8
>
> Downloading 2.45 MB separate debug info for
> /lib/x86_64-linux-gnu/libxml2.so.2
>
>
> Downloading 1.73 MB separate debug info for
> /lib/x86_64-linux-gnu/libzstd.so.1
>
>
> Downloading 0.30 MB separate debug info for
> /lib/x86_64-linux-gnu/liblzma.so.5
>
>
> Downloading 4.95 MB separate debug info for
> /lib/x86_64-linux-gnu/libcrypto.so.3
>
>
> Downloading 3.06 MB separate debug info for
> /lib/x86_64-linux-gnu/libicuuc.so.70
>
>
> Downloading 0.08 MB separate debug info for
> /home/yyan7/.cache/debuginfod_client/bef3ff1d70aadd68aab07d858a759360c8b9=
19ae/debuginfo
>
>
> Downloading 0.07 MB separate debug info for
> /lib/x86_64-linux-gnu/libnuma.so.1
>
>
> Downloading 0.00 MB separate debug info for
> /lib/x86_64-linux-gnu/libicudata.so.70
>
>
> Downloading 5.99 MB separate debug info for
> /lib/x86_64-linux-gnu/libstdc++.so.6
>
> Downloading 0.18 MB separate debug info for
> /lib/x86_64-linux-gnu/libgcc_s.so.1
>
>
> Downloading 0.03 MB separate debug info for system-supplied DSO at
> 0x7ffdabeee000
>
> [Thread debugging using libthread_db enabled]
>
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1"=
.
>
> --Type <RET> for more, q to quit, c to continue without paging--
>
> Core was generated by `lttng-sessiond -vvv --verbose-consumer -b'.
>
> Program terminated with signal SIGABRT, Aborted.
>
> #0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D1406=
14729455104)
> at ./nptl/pthread_kill.c:44
>
> Download failed: Invalid argument.  Continuing without source file
> ./nptl/./nptl/pthread_kill.c.
>
> 44 ./nptl/pthread_kill.c: No such file or directory.
>
> [Current thread is 1 (Thread 0x7fe36affd600 (LWP 10479))]
>
> (gdb) bt
>
> #0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D1406=
14729455104)
> at ./nptl/pthread_kill.c:44
>
> #1  __pthread_kill_internal (signo=3D6, threadid=3D140614729455104) at
> ./nptl/pthread_kill.c:78
>
> #2  __GI___pthread_kill (threadid=3D140614729455104, signo=3Dsigno@entry=
=3D6)
> at ./nptl/pthread_kill.c:89
>
> #3  0x00007fe37d842476 in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/posix/raise.c:26
>
> #4  0x00007fe37d8287f3 in __GI_abort () at ./stdlib/abort.c:79
>
> #5  0x00007fe37d82871b in __assert_fail_base (fmt=3D0x7fe37d9dd130
> "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
>
>     assertion=3D0x56371cd9a9ab "buf", file=3D0x56371cda20e7 "unix.c", lin=
e=3D185,
> function=3D<optimized out>) at ./assert/assert.c:92
>
> #6  0x00007fe37d839e96 in __GI___assert_fail (assertion=3D0x56371cd9a9ab
> "buf", file=3D0x56371cda20e7 "unix.c", line=3D185,
>
>     function=3D0x56371cdc8830 "lttcomm_recv_unix_sock") at ./assert/asser=
t.c
> :101
>
> #7  0x000056371cd561be in ?? ()
>
> #8  0x000056371ccea96f in ?? ()
>
> #9  0x000056371ccef7eb in ?? ()
>
> #10 0x000056371ccf3b4c in ?? ()
>
> #11 0x000056371cce0ab7 in ?? ()
>
> #12 0x00007fe37d894ac3 in start_thread (arg=3D<optimized out>) at
> ./nptl/pthread_create.c:442
>
> #13 0x00007fe37d926850 in clone3 () at
> ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
>
> (gdb)
>
> #0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D1406=
14729455104)
> at ./nptl/pthread_kill.c:44
>
> #1  __pthread_kill_internal (signo=3D6, threadid=3D140614729455104) at
> ./nptl/pthread_kill.c:78
>
> #2  __GI___pthread_kill (threadid=3D140614729455104, signo=3Dsigno@entry=
=3D6)
> at ./nptl/pthread_kill.c:89
>
> #3  0x00007fe37d842476 in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/posix/raise.c:26
>
> #4  0x00007fe37d8287f3 in __GI_abort () at ./stdlib/abort.c:79
>
> #5  0x00007fe37d82871b in __assert_fail_base (fmt=3D0x7fe37d9dd130
> "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
>
>     assertion=3D0x56371cd9a9ab "buf", file=3D0x56371cda20e7 "unix.c", lin=
e=3D185,
> function=3D<optimized out>) at ./assert/assert.c:92
>
> #6  0x00007fe37d839e96 in __GI___assert_fail (assertion=3D0x56371cd9a9ab
> "buf", file=3D0x56371cda20e7 "unix.c", line=3D185,
>
>     function=3D0x56371cdc8830 "lttcomm_recv_unix_sock") at ./assert/asser=
t.c
> :101
>
> #7  0x000056371cd561be in ?? ()
>
> #8  0x000056371ccea96f in ?? ()
>
> #9  0x000056371ccef7eb in ?? ()
>
> #10 0x000056371ccf3b4c in ?? ()
>
> #11 0x000056371cce0ab7 in ?? ()
>
> #12 0x00007fe37d894ac3 in start_thread (arg=3D<optimized out>) at
> ./nptl/pthread_create.c:442
>
> #13 0x00007fe37d926850 in clone3 () at
> ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
>
> On Fri, Jan 12, 2024 at 3:58=E2=80=AFPM Kienan Stewart <kstewart@efficios=
.com>
> wrote:
>
>> Hi Yonghong,
>>
>> thanks for the extra info. As you say without the symbol resolution the
>> backtrace isn't super useful.
>>
>> Based on the build-id in the file info for lttng-sessiond, it looks like
>> you might be using the lttng/stable-2.13 ppa.
>>
>> In that case, you could try using debuginfod with gdb to automatically
>> download the symbols. See
>> https://ubuntu.com/server/docs/service-debuginfod for the instructions
>> enabling the symbol download from Ubuntu's debuginfod server.
>>
>> thanks,
>> kienan
>>
>> On 1/12/24 15:38, Yonghong Yan wrote:
>> > Coredump is about 124MB and I am copying the backtrace of the coredump=
,
>> > see below. Unfortunately, the sessiond is stripped and no debugging
>> > info, so not able to see the the call stack that lead to the dump.
>> guess
>> > I need to build the lttng with debugging info and to get the symbol an=
d
>> > informed backtrace.
>> >
>> >  From the log itself, it is asserted aat >      > DBG1 -
>> > 00:24:25.241138386 [Client management]: Setting relayd for
>> >>      > session auto-20240112-002417 (in cmd_setup_relayd() at
>> cmd.c:1004)
>> >>      >
>> >>      > lttng-sessiond: unix.c:185: lttcomm_recv_unix_sock: Assertion
>> >>     `buf' failed.
>> >
>> > *yyan7@CCI13SZWP3LWS*:*/var/log*$ tail apport.log
>> >
>> >
>> > ERROR: apport (pid 3787) Fri Jan 12 10:52:37 2024: debug: session gdbu=
s
>> > call:
>> >
>> > ERROR: apport (pid 3787) Fri Jan 12 10:52:37 2024: this executable
>> > already crashed 2 times, ignoring
>> >
>> > ERROR: apport (pid 10543) Fri Jan 12 15:18:07 2024: called for pid
>> > 10470, signal 6, core limit 18446744073709551615, dump mode 1
>> >
>> > ERROR: apport (pid 10543) Fri Jan 12 15:18:07 2024: ignoring
>> implausibly
>> > big core limit, treating as unlimited
>> >
>> > ERROR: apport (pid 10543) Fri Jan 12 15:18:07 2024: executable:
>> > /usr/bin/lttng-sessiond (command line "lttng-sessiond -vvv
>> > --verbose-consumer -b")
>> >
>> > ERROR: apport (pid 10543) Fri Jan 12 15:18:08 2024: debug: session
>> gdbus
>> > call: (true,)
>> >
>> >
>> > ERROR: apport (pid 10543) Fri Jan 12 15:18:08 2024: writing core dump
>> to
>> >
>> core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1=
0470.2023109
>> (limit: -1)
>> >
>> > ERROR: apport (pid 10543) Fri Jan 12 15:18:08 2024: this executable
>> > already crashed 2 times, ignoring
>> >
>> > *yyan7@CCI13SZWP3LWS*:*/var/log*$ cd /var/lib/apport/coredump
>> >
>> > *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ ls
>> >
>> >
>> core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1=
0470.2023109
>> >
>> > *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ file
>> >
>> core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1=
0470.2023109
>> >
>> >
>> core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1=
0470.2023109:
>> ELF 64-bit LSB core file, x86-64, version 1 (SYSV), SVR4-style, from
>> 'lttng-sessiond -vvv --verbose-consumer -b', real uid: 1000, effective u=
id:
>> 1000, real gid: 1000, effective gid: 1000, execfn:
>> '/usr/bin/lttng-sessiond', platform: 'x86_64'
>> >
>> > *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ du -h
>> >
>> core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1=
0470.2023109
>> >
>> >
>> 124Mcore._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da=
8d.10470.2023109
>> >
>> > *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ gdb
>> > /usr/bin/lttng-sessiond
>> >
>> core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d.1=
0470.2023109
>> >
>> > *GNU gdb (Ubuntu 12.1-0ubuntu1~22.04) 12.1*
>> >
>> > Copyright (C) 2022 Free Software Foundation, Inc.
>> >
>> > License GPLv3+: GNU GPL version 3 or later
>> > <http://gnu.org/licenses/gpl.html <http://gnu.org/licenses/gpl.html>>
>> >
>> > This is free software: you are free to change and redistribute it.
>> >
>> > There is NO WARRANTY, to the extent permitted by law.
>> >
>> > Type "show copying" and "show warranty" for details.
>> >
>> > This GDB was configured as "x86_64-linux-gnu".
>> >
>> > Type "show configuration" for configuration details.
>> >
>> > For bug reporting instructions, please see:
>> >
>> > <https://www.gnu.org/software/gdb/bugs/
>> > <https://www.gnu.org/software/gdb/bugs/>>.
>> >
>> > Find the GDB manual and other documentation resources online at:
>> >
>> > <http://www.gnu.org/software/gdb/documentation/
>> > <http://www.gnu.org/software/gdb/documentation/>>.
>> >
>> >
>> > For help, type "help".
>> >
>> > Type "apropos word" to search for commands related to "word"...
>> >
>> > Reading symbols from /usr/bin/lttng-sessiond...
>> >
>> > (No debugging symbols found in /usr/bin/lttng-sessiond)
>> >
>> > [New LWP 10479]
>> >
>> > [New LWP 10470]
>> >
>> > [New LWP 10476]
>> >
>> > [New LWP 10475]
>> >
>> > [New LWP 10472]
>> >
>> > [New LWP 10478]
>> >
>> > [New LWP 10480]
>> >
>> > [New LWP 10473]
>> >
>> > [New LWP 10477]
>> >
>> > [New LWP 10482]
>> >
>> > [New LWP 10542]
>> >
>> > [New LWP 10533]
>> >
>> > [New LWP 10484]
>> >
>> > [New LWP 10474]
>> >
>> > [New LWP 10481]
>> >
>> > [New LWP 10483]
>> >
>> > [Thread debugging using libthread_db enabled]
>> >
>> > Using host libthread_db library
>> "/lib/x86_64-linux-gnu/libthread_db.so.1".
>> >
>> > --Type <RET> for more, q to quit, c to continue without paging--
>> >
>> > Core was generated by `lttng-sessiond -vvv --verbose-consumer -b'.
>> >
>> > Program terminated with signal SIGABRT, Aborted.
>> >
>> > #0__pthread_kill_implementation(no_tid=3D0, signo=3D6,
>> > threadid=3D140614729455104) at ./nptl/pthread_kill.c:44
>> >
>> > 44./nptl/pthread_kill.c: No such file or directory.
>> >
>> > [Current thread is 1 (Thread 0x7fe36affd600 (LWP 10479))]
>> >
>> > (gdb) bt
>> >
>> > #0__pthread_kill_implementation(no_tid=3D0, signo=3D6,
>> > threadid=3D140614729455104) at ./nptl/pthread_kill.c:44
>> >
>> > #1__pthread_kill_internal(signo=3D6, threadid=3D140614729455104) at
>> > ./nptl/pthread_kill.c:78
>> >
>> > #2__GI___pthread_kill(threadid=3D140614729455104, signo=3Dsigno@entry=
=3D6)
>> at
>> > ./nptl/pthread_kill.c:89
>> >
>> > #30x00007fe37d842476in __GI_raise(sig=3Dsig@entry=3D6) at
>> > ../sysdeps/posix/raise.c:26
>> >
>> > #40x00007fe37d8287f3in __GI_abort() at ./stdlib/abort.c:79
>> >
>> > #50x00007fe37d82871bin __assert_fail_base(fmt=3D0x7fe37d9dd130
>> "%s%s%s:%u:
>> > %s%sAssertion `%s' failed.\n%n",
>> >
>> > assertion=3D0x56371cd9a9ab "buf", file=3D0x56371cda20e7 "unix.c", line=
=3D185,
>> > function=3D<optimized out>) at ./assert/assert.c:92
>> >
>> > #60x00007fe37d839e96in __GI___assert_fail(assertion=3D0x56371cd9a9ab
>> > "buf", file=3D0x56371cda20e7 "unix.c", line=3D185,
>> >
>> > function=3D0x56371cdc8830 "lttcomm_recv_unix_sock") at
>> ./assert/assert.c:101
>> >
>> > #70x000056371cd561bein ??()
>> >
>> > #80x000056371ccea96fin ??()
>> >
>> > #90x000056371ccef7ebin ??()
>> >
>> > #10 0x000056371ccf3b4cin ??()
>> >
>> > #11 0x000056371cce0ab7in ??()
>> >
>> > #12 0x00007fe37d894ac3in start_thread(arg=3D<optimized out>) at
>> > ./nptl/pthread_create.c:442
>> >
>> > #13 0x00007fe37d926850in clone3() at
>> > ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
>> >
>> > (gdb) quit
>> >
>> > *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ file
>> > /usr/bin/lttng-sessiond
>> >
>> > /usr/bin/lttng-sessiond: ELF 64-bit LSB pie executable, x86-64, versio=
n
>> > 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2,
>> > BuildID[sha1]=3D71b82210085b068b86d1252ed4f7403917af7cea, for GNU/Linu=
x
>> > 3.2.0, stripped
>> >
>> > *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$
>> >
>> >
>> > On Fri, Jan 12, 2024 at 2:31=E2=80=AFPM Kienan Stewart <kstewart@effic=
ios.com
>> > <mailto:kstewart@efficios.com>> wrote:
>> >
>> >     Hi Yonghong,
>> >
>> >     thanks for the additional information. Would you be willing and
>> able to
>> >     share a coredump and/or backtrace of the crash?
>> >
>> >     I was still unable to reproduce the issue using the commands you
>> >     provided, but am interested in understanding what is happening her=
e.
>> >
>> >     Are there any configuration options other than LTTNG_UST_DEBUG=3D1
>> set in
>> >     your environment?
>> >
>> >     Are you using urcu/lttng from packages (if so, which repo), or bui=
lt
>> >     from source?
>> >
>> >     The test case I am using now:
>> >
>> >     ```
>> >     # As root
>> >     $ lttng-sessiond -b
>> >
>> >     # As a non-root user which is not a member of the tracing group
>> >     $ export LTTNG_UST_DEBUG=3D1
>> >     $ lttng-relayd -v -b
>> >     $ lttng-sessiond -vvv --verbose-consumer -b
>> >     $ lttng create
>> >     $ lttng enable-event -u -a
>> >     ```
>> >
>> >     thanks,
>> >     kienan
>> >
>> >     P.S. In the future, could you keep the lttng-dev in CC? thanks!
>> >
>> >     On 1/12/24 10:36, Yonghong Yan wrote:
>> >      > Hi Kienan,
>> >      >
>> >      > Thank you for checking.  It might be just my setting problem. I
>> will
>> >      > just send it to you before we are sure it is an issue of lttng
>> >      >
>> >      > Below is the output and steps I followed the guideline. Since I
>> >     started
>> >      > the relayd and sessiond in the same terminal, the verbose msg a=
re
>> >     mixed
>> >      > together. I can regenerate it using two separate terminals. It =
is
>> >     a Dell
>> >      > Precision Tower box and it worked well yesterday. But I rebuilt
>> the
>> >      > system yesterday (because of NVIDIA GPU driver issue), and it
>> >     then have
>> >      > this issue.
>> >      >
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$ uname -a
>> >      >
>> >      > Linux CCI13SZWP3LWS 6.5.0-14-generic #14~22.04.1-Ubuntu SMP
>> >      > PREEMPT_DYNAMIC Mon Nov 20 18:15:30 UTC 2 x86_64 x86_64 x86_64
>> >     GNU/Linux
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$ cat /etc/lsb-release
>> >      >
>> >      > DISTRIB_ID=3DUbuntu
>> >      >
>> >      > DISTRIB_RELEASE=3D22.04
>> >      >
>> >      > DISTRIB_CODENAME=3Djammy
>> >      >
>> >      > DISTRIB_DESCRIPTION=3D"Ubuntu 22.04.3 LTS"
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$ lttng --version
>> >      >
>> >      > lttng (LTTng Trace Control) 2.13.10 - Nordicit=C3=A9
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$ lsmod | grep lttng
>> >      >
>> >      > *lttng*_probe_writeback614400
>> >      >
>> >      > *lttng*_probe_workqueue204800
>> >      >
>> >      > *lttng*_probe_vmscan 450560
>> >      >
>> >      > *lttng*_probe_udp122880
>> >      >
>> >      > *lttng*_probe_timer327680
>> >      >
>> >      > *lttng*_probe_sunrpc 204800
>> >      >
>> >      > *lttng*_probe_statedump573440
>> >      >
>> >      > *lttng*_probe_sock 163840
>> >      >
>> >      > *lttng*_probe_skb163840
>> >      >
>> >      > *lttng*_probe_signal 163840
>> >      >
>> >      > *lttng*_probe_scsi 204800
>> >      >
>> >      > *lttng*_probe_sched450560
>> >      >
>> >      > *lttng*_probe_regulator204800
>> >      >
>> >      > *lttng*_probe_rcu122880
>> >      >
>> >      > *lttng*_probe_printk 122880
>> >      >
>> >      > *lttng*_probe_power204800
>> >      >
>> >      > *lttng*_probe_net327680
>> >      >
>> >      > *lttng*_probe_napi 122880
>> >      >
>> >      > *lttng*_probe_module 204800
>> >      >
>> >      > *lttng*_probe_kvm368640
>> >      >
>> >      > *lttng*_probe_jbd2 327680
>> >      >
>> >      > *lttng*_probe_irq163840
>> >      >
>> >      > *lttng*_probe_gpio 122880
>> >      >
>> >      > *lttng*_probe_block409600
>> >      >
>> >      > *lttng*_probe_asoc 368640
>> >      >
>> >      > *lttng*_counter_client_percpu_32_modular122880
>> >      >
>> >      > *lttng*_counter_client_percpu_64_modular122881
>> >      >
>> >      > *lttng*_counter163842
>> >      >
>> >
>>  *lttng*_counter_client_percpu_64_modular,*lttng*_counter_client_percpu_=
32_modular
>> >      >
>> >      > *lttng*_ring_buffer_event_notifier_client204802
>> >      >
>> >      > *lttng*_ring_buffer_metadata_mmap_client204800
>> >      >
>> >      > *lttng*_ring_buffer_client_mmap_overwrite245760
>> >      >
>> >      > *lttng*_ring_buffer_client_mmap_discard245760
>> >      >
>> >      > *lttng*_ring_buffer_metadata_client204800
>> >      >
>> >      > *lttng*_ring_buffer_client_overwrite245760
>> >      >
>> >      > *lttng*_ring_buffer_client_discard245760
>> >      >
>> >      > *lttng*_tracer 303513637
>> >      >
>> >
>>  *lttng*_probe_udp,*lttng*_probe_scsi,*lttng*_probe_sched,*lttng*_probe_=
net,*lttng*_probe_vmscan,*lttng*_probe_writeback,*lttng*_probe_power,*lttng=
*_probe_rcu,*lttng*_probe_module,*lttng*_ring_buffer_client_mmap_overwrite,=
*lttng*_probe_statedump,*lttng*_ring_buffer_client_discard,*lttng*_probe_pr=
intk,*lttng*_probe_sock,*lttng*_probe_asoc,*lttng*_counter_client_percpu_64=
_modular,*lttng*_probe_irq,*lttng*_ring_buffer_client_mmap_discard,*lttng*_=
probe_kvm,*lttng*_probe_timer,*lttng*_ring_buffer_event_notifier_client,*lt=
tng*_counter_client_percpu_32_modular,*lttng*_probe_workqueue,*lttng*_probe=
_jbd2,*lttng*_probe_signal,*lttng*_probe_skb,*lttng*_probe_block,*lttng*_pr=
obe_napi,*lttng*_ring_buffer_metadata_client,*lttng*_ring_buffer_metadata_m=
map_client,*lttng*_probe_gpio,*lttng*_ring_buffer_client_overwrite,*lttng*_=
probe_regulator,*lttng*_probe_sunrpc
>> >      >
>> >      > *lttng*_statedump 7536641 *lttng*_tracer
>> >      >
>> >      > *lttng*_wrapper163847
>> >      >
>> >
>>  *lttng*_statedump,*lttng*_probe_writeback,*lttng*_ring_buffer_client_mm=
ap_overwrite,*lttng*_ring_buffer_client_discard,*lttng*_tracer,*lttng*_ring=
_buffer_client_mmap_discard,*lttng*_ring_buffer_client_overwrite
>> >      >
>> >      > *lttng*_uprobes163841 *lttng*_tracer
>> >      >
>> >      > *lttng*_clock122885
>> >      >
>> >
>>  *lttng*_ring_buffer_client_mmap_overwrite,*lttng*_ring_buffer_client_di=
scard,*lttng*_tracer,*lttng*_ring_buffer_client_mmap_discard,*lttng*_ring_b=
uffer_client_overwrite
>> >      >
>> >      > *lttng*_kprobes163841 *lttng*_tracer
>> >      >
>> >      > *lttng*_lib_ring_buffer942088
>> >      >
>> >
>>  *lttng*_ring_buffer_client_mmap_overwrite,*lttng*_ring_buffer_client_di=
scard,*lttng*_tracer,*lttng*_ring_buffer_client_mmap_discard,*lttng*_ring_b=
uffer_event_notifier_client,*lttng*_ring_buffer_metadata_client,*lttng*_rin=
g_buffer_metadata_mmap_client,*lttng*_ring_buffer_client_overwrite
>> >      >
>> >      > *lttng*_kretprobes 163841 *lttng*_tracer
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$ export LTTNG_UST_DEBUG=3D1
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$ lttng-relayd -v -b
>> >      >
>> >      > DBG1 - 10:24:56.244818657 [3495/3495]: File descriptor count
>> >     limits are
>> >      > 1024 (soft) and 1048576 (hard) (in set_fd_pool_size() at
>> main.c:481)
>> >      >
>> >      > DBG1 - 10:24:56.244870031 [3495/3495]: Signal handler set for
>> >     SIGTERM,
>> >      > SIGUSR1, SIGPIPE and SIGINT (in set_signal_handler() at
>> main.c:872)
>> >      >
>> >      > DBG1 - 10:24:56.244877662 [3495/3495]: LTTng-relayd 2.13.10 -
>> >     Nordicit=C3=A9
>> >      > (in relayd_config_log() at main.c:206)
>> >      >
>> >      > DBG1 - 10:24:56.244885255 [3495/3495]: Clear command allowed (i=
n
>> >     main()
>> >      > at main.c:4294)
>> >      >
>> >      > DBG1 - 10:24:56.245867168 [3496/3496]: Unlinked file pool creat=
ed
>> >     at:
>> >      > /home/yyan7/lttng-traces//.unlinked (in
>> >      > lttng_unlinked_file_pool_create() at inode.c:268)
>> >      >
>> >      > DBG1 - 10:24:56.245903674 [3496/3496]: File descriptor tracker
>> >     created
>> >      > with a limit of 1014 simultaneously-opened FDs (in
>> >     fd_tracker_create()
>> >      > at fd-tracker.c:400)
>> >      >
>> >      > DBG1 - 10:24:56.245925508 [3496/3496]: Health check time delta =
in
>> >      > seconds set to 20 (in health_init() at health.c:62)
>> >      >
>> >      > DBG1 - 10:24:56.245998123 [3496/3496]: TCP inet operation timeo=
ut
>> >     set to
>> >      > 216 sec (in lttcomm_inet_init() at inet.c:545)
>> >      >
>> >      > DBG1 - 10:24:56.246177304 [3496/3498]: [thread] Manage health
>> check
>> >      > started (in thread_manage_health() at health-relayd.c:273)
>> >      >
>> >      > DBG1 - 10:24:56.246222966 [3496/3499]: [thread] Relay dispatche=
r
>> >     started
>> >      > (in relay_thread_dispatcher() at main.c:1291)
>> >      >
>> >      > DBG1 - 10:24:56.246259512 [3496/3499]: Futex n to 1 prepare don=
e
>> (in
>> >      > futex_nto1_prepare() at futex.c:67)
>> >      >
>> >      > DBG1 - 10:24:56.246266232 [3496/3496]: epoll set max size is
>> >     7225299 (in
>> >      > compat_epoll_set_max_size() at poll.c:350)
>> >      >
>> >      > DBG1 - 10:24:56.246272226 [3496/3499]: Woken up but nothing in
>> >     the relay
>> >      > command queue (in relay_thread_dispatcher() at main.c:1318)
>> >      >
>> >      > DBG1 - 10:24:56.246224883 [3496/3500]: [thread] Relay worker
>> >     started (in
>> >      > relay_thread_worker() at main.c:3913)
>> >      >
>> >      > DBG1 - 10:24:56.246332173 [3496/3501]: [thread] Relay listener
>> >     started
>> >      > (in relay_thread_listener() at main.c:1089)
>> >      >
>> >      > DBG1 - 10:24:56.246489021 [3496/3498]: Health check ready (in
>> >      > thread_manage_health() at health-relayd.c:364)
>> >      >
>> >      > DBG1 - 10:24:56.246530206 [3496/3501]: Listening on Control
>> listener
>> >      > socket 13 (in relay_socket_create() at main.c:1033)
>> >      >
>> >      > DBG1 - 10:24:56.246595589 [3496/3501]: Listening on Data listen=
er
>> >     socket
>> >      > 14 (in relay_socket_create() at main.c:1033)
>> >      >
>> >      > DBG1 - 10:24:56.246623642 [3496/3501]: Listener accepting
>> >     connections
>> >      > (in relay_thread_listener() at main.c:1136)
>> >      >
>> >      > DBG1 - 10:24:56.246619116 [3496/3502]: [thread] Live viewer rel=
ay
>> >      > dispatcher started (in thread_dispatcher() at live.c:849)
>> >      >
>> >      > DBG1 - 10:24:56.246652489 [3496/3502]: Futex n to 1 prepare don=
e
>> (in
>> >      > futex_nto1_prepare() at futex.c:67)
>> >      >
>> >      > DBG1 - 10:24:56.246662832 [3496/3502]: Woken up but nothing in
>> the
>> >      > live-viewer relay command queue (in thread_dispatcher() at
>> >     live.c:876)
>> >      >
>> >      > DBG1 - 10:24:56.246681238 [3496/3503]: [thread] Live viewer rel=
ay
>> >     worker
>> >      > started (in thread_worker() at live.c:2451)
>> >      >
>> >      > DBG1 - 10:24:56.246694646 [3496/3504]: [thread] Relay live
>> listener
>> >      > started (in thread_listener() at live.c:686)
>> >      >
>> >      > DBG1 - 10:24:56.246845536 [3496/3504]: Listening on Live listen=
er
>> >     socket
>> >      > 16 (in init_socket() at live.c:650)
>> >      >
>> >      > DBG1 - 10:24:56.246891901 [3496/3504]: Listener accepting live
>> >     viewers
>> >      > connections (in thread_listener() at live.c:720)
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$ lttng-sessiond -vvv
>> --verbose-consumer -b
>> >      >
>> >      > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
>> >      > "relay-metadata-mmap" init
>> >      >
>> >      > (in lttng_ring_buffer_metadata_client_init() at
>> >      > ../../src/common/ringbuffer-clients/metadata-template.h:364)
>> >      >
>> >      > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
>> >      > "relay-overwrite-mmap" init
>> >      >
>> >      > (in lttng_ring_buffer_client_overwrite_init() at
>> >      > ../../src/common/ringbuffer-clients/template.h:826)
>> >      >
>> >      > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
>> >      > "relay-overwrite-rt-mmap" init
>> >      >
>> >      > (in lttng_ring_buffer_client_overwrite_rt_init() at
>> >      > ../../src/common/ringbuffer-clients/template.h:826)
>> >      >
>> >      > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
>> >      > "relay-discard-mmap" init
>> >      >
>> >      > (in lttng_ring_buffer_client_discard_init() at
>> >      > ../../src/common/ringbuffer-clients/template.h:826)
>> >      >
>> >      > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
>> >      > "relay-discard-rt-mmap" init
>> >      >
>> >      > (in lttng_ring_buffer_client_discard_rt_init() at
>> >      > ../../src/common/ringbuffer-clients/template.h:826)
>> >      >
>> >      > DBG1 - 10:25:05.693401139 [Main]: [sessiond configuration]
>> >      >
>> >      > DBG1 - 10:25:05.693458872 [Main]: version2.13.10
>> >      >
>> >      > DBG1 - 10:25:05.693469176 [Main]: verbose: 3
>> >      >
>> >      > DBG1 - 10:25:05.693476719 [Main]: verbose consumer:1
>> >      >
>> >      > DBG1 - 10:25:05.693486867 [Main]: quiet mode:False
>> >      >
>> >      > DBG1 - 10:25:05.693493268 [Main]: agent_tcp_port:[5345, 5354]
>> >      >
>> >      > DBG1 - 10:25:05.693501264 [Main]: application socket timeout:5
>> >      >
>> >      > DBG1 - 10:25:05.693506511 [Main]: no-kernel: False
>> >      >
>> >      > DBG1 - 10:25:05.693511705 [Main]: background:True
>> >      >
>> >      > DBG1 - 10:25:05.693517223 [Main]: daemonize: False
>> >      >
>> >      > DBG1 - 10:25:05.693522427 [Main]: signal parent on start:False
>> >      >
>> >      > DBG1 - 10:25:05.693527446 [Main]: tracing group name:tracing
>> >      >
>> >      > DBG1 - 10:25:05.693535560 [Main]: kmod_probe_list: None
>> >      >
>> >      > DBG1 - 10:25:05.693545390 [Main]: kmod_extra_probe_list: None
>> >      >
>> >      > DBG1 - 10:25:05.693550476 [Main]: rundir:/home/yyan7/.lttng
>> >      >
>> >      > DBG1 - 10:25:05.693558977 [Main]: application socket path:
>> >      > /home/yyan7/.lttng/lttng-ust-sock-8
>> >      >
>> >      > DBG1 - 10:25:05.693564632 [Main]: client socket
>> >      > path:/home/yyan7/.lttng/client-lttng-sessiond
>> >      >
>> >      > DBG1 - 10:25:05.693573771 [Main]: wait shm path:
>> >     /lttng-ust-wait-8-1000
>> >      >
>> >      > DBG1 - 10:25:05.693581196 [Main]: health socket
>> >      > path:/home/yyan7/.lttng/sessiond-health
>> >      >
>> >      > DBG1 - 10:25:05.693592417 [Main]: LTTNG_UST_CLOCK_PLUGIN:None
>> >      >
>> >      > DBG1 - 10:25:05.693599715 [Main]: pid file path:
>> >      > /home/yyan7/.lttng/lttng-sessiond.pid
>> >      >
>> >      > DBG1 - 10:25:05.693611177 [Main]: lock file
>> >      > path:/home/yyan7/.lttng/lttng-sessiond.lck
>> >      >
>> >      > DBG1 - 10:25:05.693618666 [Main]: session load path: None
>> >      >
>> >      > DBG1 - 10:25:05.693625291 [Main]: agent port file
>> >      > path:/home/yyan7/.lttng/agent.port
>> >      >
>> >      > DBG1 - 10:25:05.693632721 [Main]: consumerd32
>> >      > path:/home/yyan7/.lttng/ustconsumerd32
>> >      >
>> >      > DBG1 - 10:25:05.693640982 [Main]: consumerd32 bin path:Unknown
>> >      >
>> >      > DBG1 - 10:25:05.693648470 [Main]: consumerd32 lib dir: Unknown
>> >      >
>> >      > DBG1 - 10:25:05.693653601 [Main]: consumerd32 err unix sock
>> >      > path:/home/yyan7/.lttng/ustconsumerd32/error
>> >      >
>> >      > DBG1 - 10:25:05.693660355 [Main]: consumerd32 cmd unix sock
>> >      > path:/home/yyan7/.lttng/ustconsumerd32/command
>> >      >
>> >      > DBG1 - 10:25:05.693668191 [Main]: consumerd64
>> >      > path:/home/yyan7/.lttng/ustconsumerd64
>> >      >
>> >      > DBG1 - 10:25:05.693673539 [Main]: consumerd64 bin
>> >      > path:/usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consumerd
>> >      >
>> >      > DBG1 - 10:25:05.693682080 [Main]: consumerd64 lib dir:
>> >      > /usr/lib/x86_64-linux-gnu
>> >      >
>> >      > DBG1 - 10:25:05.693689246 [Main]: consumerd64 err unix sock
>> >      > path:/home/yyan7/.lttng/ustconsumerd64/error
>> >      >
>> >      > DBG1 - 10:25:05.693697419 [Main]: consumerd64 cmd unix sock
>> >      > path:/home/yyan7/.lttng/ustconsumerd64/command
>> >      >
>> >      > DBG1 - 10:25:05.693706980 [Main]: kconsumerd path:
>> >      > /home/yyan7/.lttng/kconsumerd
>> >      >
>> >      > DBG1 - 10:25:05.693714339 [Main]: kconsumerd err unix sock path=
:
>> >      > /home/yyan7/.lttng/kconsumerd/error
>> >      >
>> >      > DBG1 - 10:25:05.693724836 [Main]: kconsumerd cmd unix sock path=
:
>> >      > /home/yyan7/.lttng/kconsumerd/command
>> >      >
>> >      > DBG1 - 10:25:05.693736058 [Main]: Starting lttng-sessiond
>> >      > {0e76c943-cc93-414c-81d5-259bf7e8d0e4} (in sessiond_uuid_log() =
at
>> >      > main.c:1437)
>> >      >
>> >      > DBG3 - 10:25:05.693744764 [Main]: Creating LTTng run directory:
>> >      > /home/yyan7/.lttng (in create_lttng_rundir() at main.c:1069)
>> >      >
>> >      > DBG1 - 10:25:05.696358185 [Main]: Resetting run_as worker signa=
l
>> >      > handlers to default (in reset_sighandler() at runas.c:1377)
>> >      >
>> >      > DBG1 - 10:25:05.696480798 [Main]: run_as signal handler set for
>> >     SIGTERM
>> >      > and SIGINT (in set_worker_sighandlers() at runas.c:1438)
>> >      >
>> >      > DBG1 - 10:25:05.697495897 [Main]: Health check time delta in
>> >     seconds set
>> >      > to 20 (in health_init() at health.c:62)
>> >      >
>> >      > DBG1 - 10:25:05.697824357 [HT cleanup]: Entering thread entry
>> >     point (in
>> >      > launch_thread() at thread.c:65)
>> >      >
>> >      > DBG1 - 10:25:05.697915191 [HT cleanup]: startup. (in
>> >     thread_ht_cleanup()
>> >      > at ht-cleanup.c:98)
>> >      >
>> >      > DBG1 - 10:25:05.697964263 [HT cleanup]: epoll set max size is
>> >     7225299
>> >      > (in compat_epoll_set_max_size() at poll.c:350)
>> >      >
>> >      > DBG3 - 10:25:05.698012958 [Main]: Created hashtable size 4 at
>> >      > 0x5627de049140 of type ULONG (in lttng_ht_new() at
>> hashtable.c:152)
>> >      >
>> >      > DBG3 - 10:25:05.698041846 [Main]: Created hashtable size 4 at
>> >      > 0x5627de049470 of type ULONG (in lttng_ht_new() at
>> hashtable.c:152)
>> >      >
>> >      > DBG3 - 10:25:05.698056225 [Main]: Created hashtable size 4 at
>> >      > 0x5627de04bcd0 of type ULONG (in lttng_ht_new() at
>> hashtable.c:152)
>> >      >
>> >      > DBG3 - 10:25:05.698065318 [HT cleanup]: Polling. (in
>> >     thread_ht_cleanup()
>> >      > at ht-cleanup.c:122)
>> >      >
>> >      > DBG3 - 10:25:05.698087629 [Main]: Created hashtable size 16 at
>> >      > 0x5627de04cf80 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG3 - 10:25:05.698104568 [Main]: Created hashtable size 16 at
>> >      > 0x5627de04e230 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG3 - 10:25:05.698117477 [Main]: Created hashtable size 16 at
>> >      > 0x5627de04f630 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG3 - 10:25:05.698127087 [Main]: Created hashtable size 4 at
>> >      > 0x5627de050a50 of type ULONG (in lttng_ht_new() at
>> hashtable.c:152)
>> >      >
>> >      > DBG3 - 10:25:05.698142843 [Main]: Created hashtable size 4 at
>> >      > 0x5627de051d90 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG2 - 10:25:05.698158685 [Main]: Creating consumer directory:
>> >      > /home/yyan7/.lttng/ustconsumerd64 (in set_consumer_sockets() at
>> >     main.c:1111)
>> >      >
>> >      > DBG2 - 10:25:05.698296819 [Main]: Creating consumer directory:
>> >      > /home/yyan7/.lttng/ustconsumerd32 (in set_consumer_sockets() at
>> >     main.c:1111)
>> >      >
>> >      > DBG3 - 10:25:05.698395187 [Main]: Created hashtable size 4 at
>> >      > 0x5627de0530d0 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG3 - 10:25:05.698404718 [Main]: Global buffer per UID registr=
y
>> >      > initialized (in buffer_reg_init_uid_registry() at
>> >     buffer-registry.c:90)
>> >      >
>> >      > DBG3 - 10:25:05.698427501 [Main]: Created hashtable size 4 at
>> >      > 0x5627de054410 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG3 - 10:25:05.698435763 [Main]: Global buffer per PID registr=
y
>> >      > initialized (in buffer_reg_init_pid_registry() at
>> >     buffer-registry.c:219)
>> >      >
>> >      > DBG1 - 10:25:05.698444533 [Main]: Command subsystem initialized
>> (in
>> >      > cmd_init() at cmd.c:6090)
>> >      >
>> >      > DBG1 - 10:25:05.698503908 [Main]: '3506' written in file
>> >      > /home/yyan7/.lttng/lttng-sessiond.pid (in
>> utils_create_pid_file() at
>> >      > utils.c:257)
>> >      >
>> >      > DBG1 - 10:25:05.698588286 [Main]: TCP inet operation timeout se=
t
>> >     to 216
>> >      > sec (in lttcomm_inet_init() at inet.c:545)
>> >      >
>> >      > DBG1 - 10:25:05.698688270 [Main]: Waiting for health management
>> >     thread
>> >      > to be ready (in wait_until_thread_is_ready() at health.c:35)
>> >      >
>> >      > DBG1 - 10:25:05.698771494 [Health management]: Entering thread
>> entry
>> >      > point (in launch_thread() at thread.c:65)
>> >      >
>> >      > DBG1 - 10:25:05.698803482 [Health management]: [thread] Manage
>> >     health
>> >      > check started (in thread_manage_health() at health.c:65)
>> >      >
>> >      > DBG1 - 10:25:05.698964797 [Health management]: Marking health
>> >     management
>> >      > thread as ready (in mark_thread_as_ready() at health.c:28)
>> >      >
>> >      > DBG1 - 10:25:05.698981598 [Health management]: Health check rea=
dy
>> >     (in
>> >      > thread_manage_health() at health.c:136)
>> >      >
>> >      > DBG1 - 10:25:05.698991179 [Main]: Health management thread is
>> >     ready (in
>> >      > wait_until_thread_is_ready() at health.c:37)
>> >      >
>> >      > DBG1 - 10:25:05.699062770 [Main]: Waiting for notification thre=
ad
>> >     to be
>> >      > ready (in wait_until_thread_is_ready() at
>> notification-thread.c:414)
>> >      >
>> >      > DBG1 - 10:25:05.699151645 [Notification]: Entering thread entry
>> >     point
>> >      > (in launch_thread() at thread.c:65)
>> >      >
>> >      > DBG1 - 10:25:05.699184431 [Notification]: Started notification
>> >     thread
>> >      > (in thread_notification() at notification-thread.c:642)
>> >      >
>> >      > DBG1 - 10:25:05.699255526 [Notification]: Creating notification
>> >     channel
>> >      > UNIX socket at /home/yyan7/.lttng/sessiond-notification (in
>> >      > notification_channel_socket_create() at
>> notification-thread.c:223)
>> >      >
>> >      > DBG1 - 10:25:05.699357295 [Notification]: Notification channel
>> UNIX
>> >      > socket created (fd =3D 29) (in
>> notification_channel_socket_create() at
>> >      > notification-thread.c:258)
>> >      >
>> >      > DBG1 - 10:25:05.699387109 [Notification]: Listening on
>> notification
>> >      > channel socket (in init_thread_state() at
>> notification-thread.c:442)
>> >      >
>> >      > DBG1 - 10:25:05.699561257 [Notification]: Marking notification
>> >     thread as
>> >      > ready (in mark_thread_as_ready() at notification-thread.c:407)
>> >      >
>> >      > DBG1 - 10:25:05.699576135 [Notification]: Entering poll wait (i=
n
>> >      > thread_notification() at notification-thread.c:668)
>> >      >
>> >      > DBG1 - 10:25:05.699592002 [Main]: Notification thread is ready
>> (in
>> >      > wait_until_thread_is_ready() at notification-thread.c:416)
>> >      >
>> >      > DBG1 - 10:25:05.699600050 [Action Executor]: Entering thread
>> >     entry point
>> >      > (in launch_thread() at thread.c:65)
>> >      >
>> >      > DBG1 - 10:25:05.699632561 [Action Executor]: Entering work
>> execution
>> >      > loop (in action_executor_thread() at action-executor.c:761)
>> >      >
>> >      > DBG1 - 10:25:05.699643395 [Action Executor]: No work items
>> enqueued,
>> >      > entering wait (in action_executor_thread() at
>> action-executor.c:770)
>> >      >
>> >      > DBG1 - 10:25:05.699750672 [Timer]: Entering thread entry point
>> (in
>> >      > launch_thread() at thread.c:65)
>> >      >
>> >      > DBG1 - 10:25:05.699770466 [Rotation]: Entering thread entry poi=
nt
>> >     (in
>> >      > launch_thread() at thread.c:65)
>> >      >
>> >      > DBG1 - 10:25:05.699793428 [Main]: Created client socket (fd =3D=
 35)
>> >     (in
>> >      > create_client_sock() at client.c:2435)
>> >      >
>> >      > DBG1 - 10:25:05.699796906 [Rotation]: Started rotation thread (=
in
>> >      > thread_rotation() at rotation-thread.c:840)
>> >      >
>> >      > DBG1 - 10:25:05.699868561 [Main]: Waiting for client thread to =
be
>> >     ready
>> >      > (in wait_thread_status() at client.c:65)
>> >      >
>> >      > DBG1 - 10:25:05.699906378 [Client management]: Entering thread
>> entry
>> >      > point (in launch_thread() at thread.c:65)
>> >      >
>> >      > DBG1 - 10:25:05.699943442 [Client management]: [thread] Manage
>> >     client
>> >      > started (in thread_manage_clients() at client.c:2468)
>> >      >
>> >      > DBG1 - 10:25:05.700053570 [Client management]: Marking client
>> >     thread's
>> >      > state as running (in set_thread_status() at client.c:58)
>> >      >
>> >      > DBG1 - 10:25:05.700067760 [Client management]: Accepting client
>> >     command
>> >      > ... (in thread_manage_clients() at client.c:2534)
>> >      >
>> >      > DBG1 - 10:25:05.700076510 [Main]: Client thread is ready (in
>> >      > wait_thread_status() at client.c:68)
>> >      >
>> >      > DBG1 - 10:25:05.700180769 [UST registration dispatch]: Entering
>> >     thread
>> >      > entry point (in launch_thread() at thread.c:65)
>> >      >
>> >      > DBG3 - 10:25:05.700197002 [Main]: Session daemon application
>> socket
>> >      > created (fd =3D 41)(in create_application_socket() at
>> register.c:71)
>> >      >
>> >      > DBG1 - 10:25:05.700203416 [UST registration dispatch]: [thread]
>> >     Dispatch
>> >      > UST command started (in thread_dispatch_ust_registration() at
>> >      > dispatch.c:250)
>> >      >
>> >      > DBG1 - 10:25:05.700205198 [Notification]: Poll wait returned (1=
)
>> (in
>> >      > thread_notification() at notification-thread.c:670)
>> >      >
>> >      > DBG1 - 10:25:05.700255843 [Notification]: Handling fd (29)
>> >     activity (1)
>> >      > (in thread_notification() at notification-thread.c:694)
>> >      >
>> >      > DBG1 - 10:25:05.700269799 [Notification]: Handling new
>> notification
>> >      > channel client connection (in
>> >      > handle_notification_thread_client_connect() at
>> >      > notification-thread-events.c:3351)
>> >      >
>> >      > DBG1 - 10:25:05.700262016 [Main]: Waiting for application
>> >     registration
>> >      > thread to be ready (in wait_thread_status() at register.c:131)
>> >      >
>> >      > DBG1 - 10:25:05.700236776 [UST registration dispatch]: Futex n
>> to 1
>> >      > prepare done (in futex_nto1_prepare() at futex.c:67)
>> >      >
>> >      > DBG1 - 10:25:05.700308063 [Notification]: Client socket (fd =3D=
 42)
>> >     set as
>> >      > non-blocking (in socket_set_non_blocking() at
>> >      > notification-thread-events.c:3319)
>> >      >
>> >      > DBG1 - 10:25:05.700319396 [UST registration dispatch]: Woken up
>> but
>> >      > nothing in the UST command queue (in
>> >     thread_dispatch_ust_registration()
>> >      > at dispatch.c:279)
>> >      >
>> >      > DBG1 - 10:25:05.700326116 [Notification]: Added new notificatio=
n
>> >     channel
>> >      > client socket (42) to poll set (in
>> >      > handle_notification_thread_client_connect() at
>> >      > notification-thread-events.c:3404)
>> >      >
>> >      > DBG1 - 10:25:05.700372936 [Notification]: Entering poll wait (i=
n
>> >      > thread_notification() at notification-thread.c:668)
>> >      >
>> >      > DBG1 - 10:25:05.700383798 [Notification]: Poll wait returned (1=
)
>> (in
>> >      > thread_notification() at notification-thread.c:670)
>> >      >
>> >      > DBG1 - 10:25:05.700391774 [Notification]: Handling fd (42)
>> >     activity (1)
>> >      > (in thread_notification() at notification-thread.c:694)
>> >      >
>> >      > DBG1 - 10:25:05.700405519 [Notification]: Entering poll wait (i=
n
>> >      > thread_notification() at notification-thread.c:668)
>> >      >
>> >      > DBG1 - 10:25:05.700416164 [Notification]: Poll wait returned (1=
)
>> (in
>> >      > thread_notification() at notification-thread.c:670)
>> >      >
>> >      > DBG1 - 10:25:05.700424451 [Notification]: Handling fd (42)
>> >     activity (1)
>> >      > (in thread_notification() at notification-thread.c:694)
>> >      >
>> >      > DBG1 - 10:25:05.700439076 [Notification]: Received handshake fr=
om
>> >      > client: uid =3D 1000, gid =3D 1000, protocol version =3D 1.1, c=
lient is
>> >      > sessiond =3D true (in client_handle_message_handshake() at
>> >      > notification-thread-events.c:3879)
>> >      >
>> >      > DBG1 - 10:25:05.700450858 [Notification]: Send command reply (0=
)
>> (in
>> >      > client_send_command_reply() at notification-thread-events.c:375=
5)
>> >      >
>> >      > DBG1 - 10:25:05.700460524 [Notification]: Flushing client (sock=
et
>> >     fd =3D
>> >      > 42) outgoing queue (in client_flush_outgoing_queue() at
>> >      > notification-thread-events.c:3644)
>> >      >
>> >      > DBG1 - 10:25:05.700475786 [Notification]: Entering poll wait (i=
n
>> >      > thread_notification() at notification-thread.c:668)
>> >      >
>> >      > DBG1 - 10:25:05.700505488 [Rotation]: Entering poll wait (in
>> >      > thread_rotation() at rotation-thread.c:864)
>> >      >
>> >      > DBG1 - 10:25:05.700506992 [UST application registration]:
>> Entering
>> >      > thread entry point (in launch_thread() at thread.c:65)
>> >      >
>> >      > DBG1 - 10:25:05.700529647 [UST application registration]:
>> [thread]
>> >      > Manage application registration started (in
>> >      > thread_application_registration() at register.c:168)
>> >      >
>> >      > DBG1 - 10:25:05.700597995 [UST application registration]: Marki=
ng
>> >      > application registration thread's state as running (in
>> >      > set_thread_status() at register.c:124)
>> >      >
>> >      > DBG1 - 10:25:05.700609984 [UST application registration]:
>> Accepting
>> >      > application registration (in thread_application_registration() =
at
>> >      > register.c:207)
>> >      >
>> >      > DBG1 - 10:25:05.700616363 [Main]: Application registration
>> thread is
>> >      > ready (in wait_thread_status() at register.c:134)
>> >      >
>> >      > DBG1 - 10:25:05.700627641 [Main]: Notifying applications of
>> session
>> >      > daemon state: 1 (in notify_ust_apps() at register.c:91)
>> >      >
>> >      > DBG1 - 10:25:05.700659113 [Main]: Wait shared memory file
>> descriptor
>> >      > created successfully: path =3D '/lttng-ust-wait-8-1000', mmap_s=
ize
>> >     =3D 4096,
>> >      > global =3D false, fd =3D 45 (in get_wait_shm() at shm.c:133)
>> >      >
>> >      > DBG1 - 10:25:05.700688620 [Main]: Futex wait update active 1 (i=
n
>> >      > futex_wait_update() at futex.c:55)
>> >      >
>> >      > DBG1 - 10:25:05.700795964 [UST application management]: Enterin=
g
>> >     thread
>> >      > entry point (in launch_thread() at thread.c:65)
>> >      >
>> >      > DBG1 - 10:25:05.700824549 [UST application management]: [thread=
]
>> >     Manage
>> >      > application started (in thread_application_management() at
>> >     manage-apps.c:52)
>> >      >
>> >      > DBG1 - 10:25:05.700848435 [Application notification]: Entering
>> >     thread
>> >      > entry point (in launch_thread() at thread.c:65)
>> >      >
>> >      > DBG1 - 10:25:05.700866212 [Application notification]:
>> [ust-thread]
>> >      > Manage application notify command (in
>> >     thread_application_notification()
>> >      > at notify-apps.c:39)
>> >      >
>> >      > DBG1 - 10:25:05.700913055 [Main]: Waiting for agent management
>> >     thread to
>> >      > be ready (in wait_until_thread_is_ready() at agent-thread.c:348=
)
>> >      >
>> >      > DBG1 - 10:25:05.700936679 [Agent management]: Entering thread
>> entry
>> >      > point (in launch_thread() at thread.c:65)
>> >      >
>> >      > DBG3 - 10:25:05.700952021 [Application notification]:
>> [ust-thread]
>> >      > Manage notify polling (in thread_application_notification() at
>> >      > notify-apps.c:74)
>> >      >
>> >      > DBG1 - 10:25:05.700964639 [UST application management]: Apps
>> thread
>> >      > polling (in thread_application_management() at manage-apps.c:88=
)
>> >      >
>> >      > DBG1 - 10:25:05.700955328 [Agent management]: Manage agent
>> >     application
>> >      > registration. (in thread_agent_management() at
>> agent-thread.c:366)
>> >      >
>> >      > DBG3 - 10:25:05.701062072 [Agent management]: URI string:
>> >      > tcp://localhost (in uri_parse() at uri.c:298)
>> >      >
>> >      > DBG2 - 10:25:05.701282226 [Agent management]: IP address
>> resolved to
>> >      > 127.0.0.1 (in set_ip_address() at uri.c:155)
>> >      >
>> >      > DBG3 - 10:25:05.701292578 [Agent management]: URI dtype: 1,
>> >     proto: 1,
>> >      > host: localhost, subdir: , ctrl: 0, data: 0 (in uri_parse() at
>> >     uri.c:510)
>> >      >
>> >      > DBG3 - 10:25:05.701314205 [Agent management]: Trying to bind on
>> port
>> >      > 5345 (in init_tcp_socket() at agent-thread.c:140)
>> >      >
>> >      > DBG1 - 10:25:05.701330622 [Agent management]: Failed to bind to
>> port
>> >      > 5345 since it is already in use (in init_tcp_socket() at
>> >     agent-thread.c:148)
>> >      >
>> >      > DBG3 - 10:25:05.701338804 [Agent management]: Trying to bind on
>> port
>> >      > 5346 (in init_tcp_socket() at agent-thread.c:140)
>> >      >
>> >      > DBG1 - 10:25:05.701351367 [Agent management]: Listening on TCP
>> >     port 5346
>> >      > and socket 54 (in init_tcp_socket() at agent-thread.c:177)
>> >      >
>> >      > DBG1 - 10:25:05.701413970 [Agent management]: '5346' written in
>> file
>> >      > /home/yyan7/.lttng/agent.port (in utils_create_pid_file() at
>> >     utils.c:257)
>> >      >
>> >      > DBG1 - 10:25:05.701452432 [Agent management]: Marking agent
>> >     management
>> >      > thread as ready (in mark_thread_as_ready() at agent-thread.c:34=
1)
>> >      >
>> >      > DBG3 - 10:25:05.701466232 [Agent management]: Manage agent
>> >     polling (in
>> >      > thread_agent_management() at agent-thread.c:421)
>> >      >
>> >      > DBG1 - 10:25:05.701544565 [Main]: Agent management thread is
>> >     ready (in
>> >      > wait_until_thread_is_ready() at agent-thread.c:350)
>> >      >
>> >      > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
>> >      > "relay-discard-rt-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_discard_rt_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
>> >      > "relay-discard-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_discard_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
>> >      > "relay-overwrite-rt-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_overwrite_rt_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
>> >      > "relay-overwrite-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_overwrite_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3505/3505]: LTT : ltt ring buffer client
>> >      > "relay-metadata-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_metadata_client_exit() at
>> >      > ../../src/common/ringbuffer-clients/metadata-template.h:371)
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$ ps -ef | grep lttng
>> >      >
>> >      > root 760 10 09:40 ?00:00:00 /usr/bin/*lttng*-sessiond
>> >      >
>> >      > root 808 7600 09:40 ?00:00:00 /usr/bin/*lttng*-sessiond
>> >      >
>> >      > yyan7 3496 10 10:24 ?00:00:00 *lttng*-relayd -v -b
>> >      >
>> >      > yyan7 3506 10 10:25 ?00:00:00 *lttng*-sessiond -vvv
>> >     --verbose-consumer -b
>> >      >
>> >      > yyan7 350735060 10:25 ?00:00:00 *lttng*-sessiond -vvv
>> >     --verbose-consumer -b
>> >      >
>> >      > yyan7 352229970 10:25 pts/000:00:00 grep --color=3Dauto *lttng*
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$ lttng create
>> >      >
>> >      > DBG1 - 10:25:35.436359096 [Client management]: Wait for client
>> >     response
>> >      > (in thread_manage_clients() at client.c:2576)
>> >      >
>> >      > DBG1 - 10:25:35.436403534 [Client management]: Receiving data
>> from
>> >      > client ... (in thread_manage_clients() at client.c:2604)
>> >      >
>> >      > DBG1 - 10:25:35.436419086 [Client management]: Incomplete recv(=
)
>> >     from
>> >      > client... continuing (in thread_manage_clients() at
>> client.c:2608)
>> >      >
>> >      > DBG1 - 10:25:35.436438855 [Client management]: Accepting client
>> >     command
>> >      > ... (in thread_manage_clients() at client.c:2534)
>> >      >
>> >      > DBG1 - 10:25:35.436458714 [Client management]: Wait for client
>> >     response
>> >      > (in thread_manage_clients() at client.c:2576)
>> >      >
>> >      > DBG1 - 10:25:35.436480694 [Client management]: Receiving data
>> from
>> >      > client ... (in thread_manage_clients() at client.c:2604)
>> >      >
>> >      > DBG1 - 10:25:35.436493760 [Client management]: Incomplete recv(=
)
>> >     from
>> >      > client... continuing (in thread_manage_clients() at
>> client.c:2608)
>> >      >
>> >      > DBG1 - 10:25:35.436514391 [Client management]: Accepting client
>> >     command
>> >      > ... (in thread_manage_clients() at client.c:2534)
>> >      >
>> >      > DBG1 - 10:25:35.436522846 [Client management]: Wait for client
>> >     response
>> >      > (in thread_manage_clients() at client.c:2576)
>> >      >
>> >      > DBG1 - 10:25:35.436539198 [Client management]: Receiving data
>> from
>> >      > client ... (in thread_manage_clients() at client.c:2604)
>> >      >
>> >      > DBG1 - 10:25:35.436561992 [Client management]: Processing clien=
t
>> >     command
>> >      > 'LTTNG_CREATE_SESSION_EXT' (49) (in process_client_msg() at
>> >     client.c:1016)
>> >      >
>> >      > DBG3 - 10:25:35.436644534 [Client management]: Created hashtabl=
e
>> >     size 4
>> >      > at 0x7fd67c0090b0 of type ULONG (in lttng_ht_new() at
>> >     hashtable.c:152)
>> >      >
>> >      > DBG2 - 10:25:35.436670494 [Client management]: Trying to find
>> >     session by
>> >      > name auto-20240112-102535 (in session_find_by_name() at
>> >     session.c:1143)
>> >      >
>> >      > DBG1 - 10:25:35.436679003 [Client management]: Generated sessio=
n
>> >     name
>> >      > "auto-20240112-102535" (in session_create() at session.c:1300)
>> >      >
>> >      > DBG3 - 10:25:35.436693861 [Client management]: Created hashtabl=
e
>> >     size 4
>> >      > at 0x7fd67c00a3f0 of type ULONG (in lttng_ht_new() at
>> >     hashtable.c:152)
>> >      >
>> >      > DBG1 - 10:25:35.436702475 [Client management]: Allocating
>> >      > ltt_sessions_ht_by_id (in ltt_sessions_ht_alloc() at
>> session.c:306)
>> >      >
>> >      > DBG3 - 10:25:35.436719034 [Client management]: Created hashtabl=
e
>> >     size 4
>> >      > at 0x7fd67c00b730 of type U64 (in lttng_ht_new() at
>> hashtable.c:152)
>> >      >
>> >      > DBG1 - 10:25:35.436727024 [Client management]: Allocating
>> >      > ltt_sessions_ht_by_name (in ltt_sessions_ht_alloc() at
>> session.c:314)
>> >      >
>> >      > DBG3 - 10:25:35.436739320 [Client management]: Created hashtabl=
e
>> >     size 4
>> >      > at 0x7fd67c00ca70 of type STRING (in lttng_ht_new() at
>> >     hashtable.c:152)
>> >      >
>> >      > DBG1 - 10:25:35.436750021 [Client management]: Tracing session
>> >      > auto-20240112-102535 created with ID 0 by uid =3D 1000, gid =3D=
 1000
>> (in
>> >      > session_create() at session.c:1348)
>> >      >
>> >      > DBG3 - 10:25:35.436761891 [Client management]: URI string:
>> >      > file:///home/yyan7/lttng-traces/auto-20240112-102535 (in
>> >     uri_parse() at
>> >      > uri.c:298)
>> >      >
>> >      > DBG3 - 10:25:35.436786010 [Client management]: URI file
>> destination:
>> >      > /home/yyan7/lttng-traces/auto-20240112-102535 (in uri_parse() a=
t
>> >     uri.c:335)
>> >      >
>> >      > DBG3 - 10:25:35.436794369 [Client management]: URI dtype: 3,
>> >     proto: 0,
>> >      > host: , subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:510=
)
>> >      >
>> >      > DBG2 - 10:25:35.436815787 [Client management]: Setting trace
>> >     directory
>> >      > path from URI to /home/yyan7/lttng-traces/auto-20240112-102535
>> (in
>> >      > add_uri_to_consumer() at cmd.c:719)
>> >      >
>> >      > DBG1 - 10:25:35.436861339 [Client management]: Sending response
>> >     (size:
>> >      > 8262, retcode: Success (10)) (in thread_manage_clients() at
>> >     client.c:2683)
>> >      >
>> >      > DBG1 - 10:25:35.436885647 [Client management]: Accepting client
>> >     command
>> >      > ... (in thread_manage_clients() at client.c:2534)
>> >      >
>> >      > DBG1 - 10:25:35.437011410 [Client management]: Wait for client
>> >     response
>> >      > (in thread_manage_clients() at client.c:2576)
>> >      >
>> >      > DBG1 - 10:25:35.437037211 [Client management]: Receiving data
>> from
>> >      > client ... (in thread_manage_clients() at client.c:2604)
>> >      >
>> >      > DBG1 - 10:25:35.437050433 [Client management]: Incomplete recv(=
)
>> >     from
>> >      > client... continuing (in thread_manage_clients() at
>> client.c:2608)
>> >      >
>> >      > DBG1 - 10:25:35.437065744 [Client management]: Accepting client
>> >     command
>> >      > ... (in thread_manage_clients() at client.c:2534)
>> >      >
>> >      > DBG1 - 10:25:35.437074955 [Client management]: Wait for client
>> >     response
>> >      > (in thread_manage_clients() at client.c:2576)
>> >      >
>> >      > DBG1 - 10:25:35.437088320 [Client management]: Receiving data
>> from
>> >      > client ... (in thread_manage_clients() at client.c:2604)
>> >      >
>> >      > DBG1 - 10:25:35.437107173 [Client management]: Processing clien=
t
>> >     command
>> >      > 'LTTNG_LIST_SESSIONS' (13) (in process_client_msg() at
>> client.c:1016)
>> >      >
>> >      > DBG1 - 10:25:35.437120952 [Client management]: Counting number =
of
>> >      > available session for UID 1000 (in lttng_sessions_count() at
>> >     client.c:596)
>> >      >
>> >      > DBG1 - 10:25:35.437130882 [Client management]: Getting all
>> available
>> >      > session for UID 1000 GID 1000 (in cmd_list_lttng_sessions() at
>> >     cmd.c:3947)
>> >      >
>> >      > DBG1 - 10:25:35.437141977 [Client management]: Sending response
>> >     (size:
>> >      > 4409, retcode: Success (10)) (in thread_manage_clients() at
>> >     client.c:2683)
>> >      >
>> >      > DBG1 - 10:25:35.437163179 [Client management]: Accepting client
>> >     command
>> >      > ... (in thread_manage_clients() at client.c:2534)
>> >      >
>> >      > Session auto-20240112-102535 created.
>> >      >
>> >      > Traces will be output to
>> >     /home/yyan7/lttng-traces/auto-20240112-102535
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$ lttng enable-event -u -all
>> >      >
>> >      > Error: Only one domain must be specified.
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$ lttng enable-event -u -a
>> >      >
>> >      > DBG1 - 10:26:09.048651842 [Client management]: Wait for client
>> >     response
>> >      > (in thread_manage_clients() at client.c:2576)
>> >      >
>> >      > DBG1 - 10:26:09.048698882 [Client management]: Receiving data
>> from
>> >      > client ... (in thread_manage_clients() at client.c:2604)
>> >      >
>> >      > DBG1 - 10:26:09.048730037 [Client management]: Processing clien=
t
>> >     command
>> >      > 'LTTNG_ENABLE_EVENT' (6) (in process_client_msg() at
>> client.c:1016)
>> >      >
>> >      > DBG1 - 10:26:09.048742929 [Client management]: Getting session
>> >      > auto-20240112-102535 by name (in process_client_msg() at
>> >     client.c:1133)
>> >      >
>> >      > DBG2 - 10:26:09.048752328 [Client management]: Trying to find
>> >     session by
>> >      > name auto-20240112-102535 (in session_find_by_name() at
>> >     session.c:1143)
>> >      >
>> >      > DBG1 - 10:26:09.048762009 [Client management]: Creating UST
>> >     session (in
>> >      > create_ust_session() at client.c:510)
>> >      >
>> >      > DBG3 - 10:26:09.048777715 [Client management]: Created hashtabl=
e
>> >     size 4
>> >      > at 0x7fd67c00ffd0 of type STRING (in lttng_ht_new() at
>> >     hashtable.c:152)
>> >      >
>> >      > DBG3 - 10:26:09.048801459 [Client management]: Created hashtabl=
e
>> >     size 4
>> >      > at 0x7fd67c011310 of type U64 (in lttng_ht_new() at
>> hashtable.c:152)
>> >      >
>> >      > DBG3 - 10:26:09.048877638 [Client management]: Created hashtabl=
e
>> >     size 4
>> >      > at 0x7fd67c020120 of type ULONG (in lttng_ht_new() at
>> >     hashtable.c:152)
>> >      >
>> >      > DBG2 - 10:26:09.048886268 [Client management]: UST trace sessio=
n
>> >     create
>> >      > successful (in trace_ust_create_session() at trace-ust.c:324)
>> >      >
>> >      > DBG3 - 10:26:09.048894968 [Client management]: Copying tracing
>> >     session
>> >      > consumer output in UST session (in copy_session_consumer() at
>> >     client.c:454)
>> >      >
>> >      > DBG3 - 10:26:09.048930287 [Client management]: Created hashtabl=
e
>> >     size 4
>> >      > at 0x7fd67c0213d0 of type ULONG (in lttng_ht_new() at
>> >     hashtable.c:152)
>> >      >
>> >      > DBG3 - 10:26:09.048944965 [Client management]: Copy session
>> consumer
>> >      > subdir ust (in copy_session_consumer() at client.c:476)
>> >      >
>> >      > DBG1 - 10:26:09.048955915 [Client management]: Spawning consume=
rd
>> >     (in
>> >      > spawn_consumerd() at client.c:204)
>> >      >
>> >      > DBG3 - 10:26:09.048988740 [HT cleanup]: Returning from poll on =
2
>> >     fds.
>> >      > (in thread_ht_cleanup() at ht-cleanup.c:125)
>> >      >
>> >      > DBG2 - 10:26:09.049819491 [Client management]: Consumer pid 352=
6
>> (in
>> >      > start_consumerd() at client.c:390)
>> >      >
>> >      > DBG2 - 10:26:09.049855514 [Client management]: Spawning consume=
r
>> >     control
>> >      > thread (in start_consumerd() at client.c:393)
>> >      >
>> >      > DBG1 - 10:26:09.049986094 [Client management]: Waiting for
>> consumer
>> >      > management thread to be ready (in wait_until_thread_is_ready() =
at
>> >      > manage-consumer.c:46)
>> >      >
>> >      > DBG1 - 10:26:09.050081839 [Consumer management]: Entering threa=
d
>> >     entry
>> >      > point (in launch_thread() at thread.c:65)
>> >      >
>> >      > DBG1 - 10:26:09.050074834 [Client management]: Using 64-bit UST
>> >     consumer
>> >      > at: /usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consumerd (in
>> >      > spawn_consumerd() at client.c:284)
>> >      >
>> >      > DBG1 - 10:26:09.050117556 [Consumer management]: [thread] Manag=
e
>> >      > consumer started (in thread_consumer_management() at
>> >     manage-consumer.c:65)
>> >      >
>> >      > DBG3 - 10:26:09.050103089 [HT cleanup]: Polling. (in
>> >     thread_ht_cleanup()
>> >      > at ht-cleanup.c:122)
>> >      >
>> >      > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
>> >      > "relay-metadata-mmap" init
>> >      >
>> >      > (in lttng_ring_buffer_metadata_client_init() at
>> >      > ../../src/common/ringbuffer-clients/metadata-template.h:364)
>> >      >
>> >      > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
>> >      > "relay-overwrite-mmap" init
>> >      >
>> >      > (in lttng_ring_buffer_client_overwrite_init() at
>> >      > ../../src/common/ringbuffer-clients/template.h:826)
>> >      >
>> >      > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
>> >      > "relay-overwrite-rt-mmap" init
>> >      >
>> >      > (in lttng_ring_buffer_client_overwrite_rt_init() at
>> >      > ../../src/common/ringbuffer-clients/template.h:826)
>> >      >
>> >      > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
>> >      > "relay-discard-mmap" init
>> >      >
>> >      > (in lttng_ring_buffer_client_discard_init() at
>> >      > ../../src/common/ringbuffer-clients/template.h:826)
>> >      >
>> >      > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
>> >      > "relay-discard-rt-mmap" init
>> >      >
>> >      > (in lttng_ring_buffer_client_discard_rt_init() at
>> >      > ../../src/common/ringbuffer-clients/template.h:826)
>> >      >
>> >      > DBG1 - 10:26:09.054724418 [3526/3526]: Health check time delta =
in
>> >      > seconds set to 20 (in health_init() at health.c:62)
>> >      >
>> >      > DBG3 - 10:26:09.054993129 [3526/3526]: Created hashtable size 4
>> at
>> >      > 0x561838919540 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG3 - 10:26:09.055012947 [3526/3526]: Created hashtable size 4
>> at
>> >      > 0x561838919870 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG3 - 10:26:09.055026387 [3526/3526]: Created hashtable size 4
>> at
>> >      > 0x561838919ba0 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG3 - 10:26:09.055038707 [3526/3526]: Created hashtable size 4
>> at
>> >      > 0x561838919ed0 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG3 - 10:26:09.055052418 [3526/3526]: Created hashtable size 4
>> at
>> >      > 0x56183891eb00 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG3 - 10:26:09.055070118 [3526/3526]: Created hashtable size 4
>> at
>> >      > 0x56183891fe40 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG3 - 10:26:09.055079438 [3526/3526]: Created hashtable size 4
>> at
>> >      > 0x561838921180 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG1 - 10:26:09.055131986 [3526/3526]: TCP inet operation timeo=
ut
>> >     set to
>> >      > 216 sec (in lttcomm_inet_init() at inet.c:545)
>> >      >
>> >      > DBG1 - 10:26:09.055169397 [3526/3526]: Connecting to error sock=
et
>> >      > /home/yyan7/.lttng/ustconsumerd64/error (in main() at
>> >     lttng-consumerd.c:477)
>> >      >
>> >      > DBG2 - 10:26:09.055307314 [Consumer management]: Receiving code
>> from
>> >      > consumer err_sock (in thread_consumer_management() at
>> >     manage-consumer.c:162)
>> >      >
>> >      > DBG1 - 10:26:09.055374257 [3526/3530]: [thread] Manage health
>> check
>> >      > started (in thread_manage_health() at health-consumerd.c:157)
>> >      >
>> >      > DBG1 - 10:26:09.055528236 [3526/3530]: epoll set max size is
>> >     7225299 (in
>> >      > compat_epoll_set_max_size() at poll.c:350)
>> >      >
>> >      > DBG1 - 10:26:09.055617358 [3526/3530]: Health check ready (in
>> >      > thread_manage_health() at health-consumerd.c:237)
>> >      >
>> >      > DBG1 - 10:26:09.155778508 [3526/3533]: Thread metadata poll
>> >     started (in
>> >      > consumer_thread_metadata_poll() at consumer.c:2344)
>> >      >
>> >      > DBG3 - 10:26:09.155827680 [3526/3532]: Created hashtable size 4
>> at
>> >      > 0x7fb838000b90 of type U64 (in lttng_ht_new() at hashtable.c:15=
2)
>> >      >
>> >      > DBG1 - 10:26:09.155854441 [3526/3532]: Thread channel poll
>> >     started (in
>> >      > consumer_thread_channel_poll() at consumer.c:2938)
>> >      >
>> >      > DBG1 - 10:26:09.155873849 [3526/3532]: Channel main loop starte=
d
>> (in
>> >      > consumer_thread_channel_poll() at consumer.c:2953)
>> >      >
>> >      > DBG1 - 10:26:09.155884744 [3526/3532]: Channel poll wait (in
>> >      > consumer_thread_channel_poll() at consumer.c:2958)
>> >      >
>> >      > DBG1 - 10:26:09.155910091 [3526/3533]: Metadata main loop start=
ed
>> >     (in
>> >      > consumer_thread_metadata_poll() at consumer.c:2360)
>> >      >
>> >      > DBG1 - 10:26:09.155915209 [3526/3535]: Creating command socket
>> >      > /home/yyan7/.lttng/ustconsumerd64/command (in
>> >      > consumer_thread_sessiond_poll() at consumer.c:3201)
>> >      >
>> >      > DBG1 - 10:26:09.155927055 [3526/3533]: Metadata poll wait (in
>> >      > consumer_thread_metadata_poll() at consumer.c:2366)
>> >      >
>> >      > DBG1 - 10:26:09.155902292 [3526/3534]: Updating poll fd array (=
in
>> >      > update_poll_array() at consumer.c:1176)
>> >      >
>> >      > DBG1 - 10:26:09.155992208 [3526/3534]: polling on 2 fd (in
>> >      > consumer_thread_data_poll() at consumer.c:2627)
>> >      >
>> >      > DBG1 - 10:26:09.156028520 [3526/3535]: Sending ready command to
>> >      > lttng-sessiond (in consumer_thread_sessiond_poll() at
>> >     consumer.c:3214)
>> >      >
>> >      > DBG1 - 10:26:09.156117370 [3526/3535]: Connection on
>> >     client_socket (in
>> >      > consumer_thread_sessiond_poll() at consumer.c:3236)
>> >      >
>> >      > DBG1 - 10:26:09.156118051 [Consumer management]: Consumer comma=
nd
>> >     socket
>> >      > ready (fd: 61) (in thread_consumer_management() at
>> >     manage-consumer.c:204)
>> >      >
>> >      > DBG1 - 10:26:09.156134055 [Consumer management]: Consumer
>> metadata
>> >      > socket ready (fd: 62) (in thread_consumer_management() at
>> >      > manage-consumer.c:205)
>> >      >
>> >      > DBG1 - 10:26:09.156140605 [3526/3535]: Metadata connection on
>> >      > client_socket (in set_metadata_socket() at consumer.c:3162)
>> >      >
>> >      > DBG1 - 10:26:09.156159591 [Consumer management]: Sending consum=
er
>> >      > initialization command (in consumer_init() at consumer.c:1791)
>> >      >
>> >      > DBG1 - 10:26:09.156197563 [3526/3535]: Incoming command on sock
>> (in
>> >      > consumer_thread_sessiond_poll() at consumer.c:3282)
>> >      >
>> >      > DBG1 - 10:26:09.156239708 [3526/3535]: Received session daemon
>> UUID:
>> >      > 0e76c943-cc93-414c-81d5-259bf7e8d0e4 (in
>> >     lttng_consumer_init_command()
>> >      > at consumer.c:4711)
>> >      >
>> >      > DBG1 - 10:26:09.156260388 [3526/3535]: Received command on sock
>> (in
>> >      > consumer_thread_sessiond_poll() at consumer.c:3298)
>> >      >
>> >      > DBG3 - 10:26:09.156271768 [Consumer management]: Sending
>> >      > SET_CHANNEL_MONITOR_PIPE command to consumer (in
>> >     consumer_send_pipe() at
>> >      > consumer.c:1230)
>> >      >
>> >      > DBG1 - 10:26:09.156298833 [3526/3535]: Incoming command on sock
>> (in
>> >      > consumer_thread_sessiond_poll() at consumer.c:3282)
>> >      >
>> >      > DBG3 - 10:26:09.156339394 [Consumer management]: Sending channe=
l
>> >     monitor
>> >      > pipe 16 to consumer on socket 61 (in consumer_send_pipe() at
>> >      > consumer.c:1236)
>> >      >
>> >      > DBG1 - 10:26:09.156373728 [3526/3535]: Received channel monitor
>> pipe
>> >      > (27) (in lttng_ustconsumer_recv_cmd() at ust-consumer.c:2017)
>> >      >
>> >      > DBG1 - 10:26:09.156385429 [3526/3535]: Channel monitor pipe set
>> as
>> >      > non-blocking (in lttng_ustconsumer_recv_cmd() at
>> ust-consumer.c:2040)
>> >      >
>> >      > DBG1 - 10:26:09.156398125 [3526/3535]: Received command on sock
>> (in
>> >      > consumer_thread_sessiond_poll() at consumer.c:3298)
>> >      >
>> >      > DBG2 - 10:26:09.156408026 [Consumer management]: channel monito=
r
>> >     pipe
>> >      > successfully sent (in consumer_send_pipe() at consumer.c:1244)
>> >      >
>> >      > DBG1 - 10:26:09.156521209 [Consumer management]: Marking consum=
er
>> >      > management thread as ready (in mark_thread_as_ready() at
>> >      > manage-consumer.c:31)
>> >      >
>> >      > DBG1 - 10:26:09.156618144 [Client management]: Consumer
>> management
>> >      > thread is ready (in wait_until_thread_is_ready() at
>> >     manage-consumer.c:48)
>> >      >
>> >      > DBG3 - 10:26:09.156649336 [Client management]: Consumer socket
>> >     created
>> >      > (fd: 61) and added to output (in consumer_create_socket() at
>> >     consumer.c:351)
>> >      >
>> >      > *DBG1 - 10:26:09.156661610 [Client management]: Setting relayd
>> for
>> >      > session auto-20240112-102535 (in cmd_setup_relayd() at
>> cmd.c:1004)*
>> >      >
>> >      > *lttng-sessiond: unix.c:185: lttcomm_recv_unix_sock: Assertion
>> `buf'
>> >      > failed.*
>> >      >
>> >      > DBG1 - 10:26:10.269878943 [3526/3535]: Incoming command on sock
>> (in
>> >      > consumer_thread_sessiond_poll() at consumer.c:3282)
>> >      >
>> >      > DBG1 - 10:26:10.269909824 [3526/3535]: Consumer received
>> unexpected
>> >      > message size 0 (expects 12690) (in lttng_ustconsumer_recv_cmd()
>> at
>> >      > ust-consumer.c:1401)
>> >      >
>> >      > DBG1 - 10:26:10.269918771 [3526/3535]: Communication interrupte=
d
>> on
>> >      > command socket (in consumer_thread_sessiond_poll() at
>> >     consumer.c:3289)
>> >      >
>> >      > DBG1 - 10:26:10.269924634 [3526/3535]: Consumer thread sessiond
>> poll
>> >      > exiting (in consumer_thread_sessiond_poll() at consumer.c:3304)
>> >      >
>> >      > Error: Events: No session daemon is available (channel channel0=
,
>> >     session
>> >      > auto-20240112-102535)
>> >      >
>> >      > DBG1 - 10:26:10.269945294 [3526/3535]: UST consumer closing all
>> >     metadata
>> >      > streams (in lttng_ustconsumer_close_all_metadata() at
>> >     ust-consumer.c:3278)
>> >      >
>> >      > DBG1 - 10:26:10.270034860 [3526/3534]: poll num_rdy : 1 (in
>> >      > consumer_thread_data_poll() at consumer.c:2634)
>> >      >
>> >      > DBG1 - 10:26:10.270051195 [3526/3532]: Channel poll return from
>> wait
>> >      > with 1 fd(s) (in consumer_thread_channel_poll() at
>> consumer.c:2961)
>> >      >
>> >      > DBG1 - 10:26:10.270085710 [3526/3532]: Channel event caught in
>> >     thread
>> >      > (in consumer_thread_channel_poll() at consumer.c:2964)
>> >      >
>> >      > DBG1 - 10:26:10.270066746 [3526/3534]: consumer_data_pipe wake =
up
>> >     (in
>> >      > consumer_thread_data_poll() at consumer.c:2664)
>> >      >
>> >      > DBG1 - 10:26:10.270051357 [3526/3530]: Health check thread dyin=
g
>> (in
>> >      > thread_manage_health() at health-consumerd.c:334)
>> >      >
>> >      > DBG1 - 10:26:10.270114085 [3526/3532]: Channel poll wait (in
>> >      > consumer_thread_channel_poll() at consumer.c:2958)
>> >      >
>> >      > DBG1 - 10:26:10.270151938 [3526/3532]: Channel poll return from
>> wait
>> >      > with 0 fd(s) (in consumer_thread_channel_poll() at
>> consumer.c:2961)
>> >      >
>> >      > DBG1 - 10:26:10.270163529 [3526/3532]: Channel event caught in
>> >     thread
>> >      > (in consumer_thread_channel_poll() at consumer.c:2964)
>> >      >
>> >      > DBG1 - 10:26:10.270115093 [3526/3534]: Consumer delete flagged
>> data
>> >      > stream (in validate_endpoint_status_data_stream() at
>> consumer.c:2274)
>> >      >
>> >      > DBG1 - 10:26:10.270187345 [3526/3534]: polling thread exiting (=
in
>> >      > consumer_thread_data_poll() at consumer.c:2806)
>> >      >
>> >      > DBG1 - 10:26:10.270226737 [3526/3533]: Metadata poll return fro=
m
>> >     wait
>> >      > with 1 fd(s) (in consumer_thread_metadata_poll() at
>> consumer.c:2368)
>> >      >
>> >      > DBG1 - 10:26:10.270255651 [3526/3533]: Metadata event caught in
>> >     thread
>> >      > (in consumer_thread_metadata_poll() at consumer.c:2371)
>> >      >
>> >      > DBG1 - 10:26:10.270264901 [3526/3533]: Metadata thread pipe hun=
g
>> >     up (in
>> >      > consumer_thread_metadata_poll() at consumer.c:2426)
>> >      >
>> >      > DBG1 - 10:26:10.270270628 [3526/3532]: Channel poll thread
>> >     exiting (in
>> >      > consumer_thread_channel_poll() at consumer.c:3140)
>> >      >
>> >      > DBG1 - 10:26:10.270284048 [3526/3533]: Metadata poll wait (in
>> >      > consumer_thread_metadata_poll() at consumer.c:2366)
>> >      >
>> >      > DBG1 - 10:26:10.270292833 [3526/3533]: Metadata poll return fro=
m
>> >     wait
>> >      > with 0 fd(s) (in consumer_thread_metadata_poll() at
>> consumer.c:2368)
>> >      >
>> >      > DBG1 - 10:26:10.270300375 [3526/3533]: Metadata event caught in
>> >     thread
>> >      > (in consumer_thread_metadata_poll() at consumer.c:2371)
>> >      >
>> >      > DBG1 - 10:26:10.270310033 [3526/3533]: Metadata poll thread
>> >     exiting (in
>> >      > consumer_thread_metadata_poll() at consumer.c:2521)
>> >      >
>> >      > DBG1 - 10:26:10.270463392 [3526/3526]: Releasing trace chunk
>> >     registry to
>> >      > all trace chunks (in lttng_trace_chunk_registry_put_each_chunk(=
)
>> at
>> >      > trace-chunk.c:2221)
>> >      >
>> >      > DBG1 - 10:26:10.270476593 [3526/3526]: Released reference to 0
>> trace
>> >      > chunks in lttng_trace_chunk_registry_put_each_chunk() (in
>> >      > lttng_trace_chunk_registry_put_each_chunk() at
>> trace-chunk.c:2254)
>> >      >
>> >      > DBG1 - 10:26:10.270667263 [3526/3526]: Consumer destroying it.
>> >     Closing
>> >      > everything. (in lttng_consumer_destroy() at consumer.c:1546)
>> >      >
>> >      > DBG1 - 10:26:10.270812838 [3526/3526]: Destroying run_as worker
>> (in
>> >      > run_as_destroy_worker_no_lock() at runas.c:1576)
>> >      >
>> >      > DBG1 - 10:26:10.270818934 [3526/3526]: Closing run_as worker
>> >     socket (in
>> >      > run_as_destroy_worker_no_lock() at runas.c:1581)
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$ libringbuffer-clients[3528/3528]: LT=
T
>> >     : ltt
>> >      > ring buffer client "relay-discard-rt-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_discard_rt_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3528/3528]: LTT : ltt ring buffer client
>> >      > "relay-discard-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_discard_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3528/3528]: LTT : ltt ring buffer client
>> >      > "relay-overwrite-rt-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_overwrite_rt_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3528/3528]: LTT : ltt ring buffer client
>> >      > "relay-overwrite-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_overwrite_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3528/3528]: LTT : ltt ring buffer client
>> >      > "relay-metadata-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_metadata_client_exit() at
>> >      > ../../src/common/ringbuffer-clients/metadata-template.h:371)
>> >      >
>> >      > DBG1 - 10:26:10.271345058 [3526/3526]: lttng-runas terminated
>> with
>> >      > status code 0 (in run_as_destroy_worker_no_lock() at
>> runas.c:1601)
>> >      >
>> >      > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
>> >      > "relay-discard-rt-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_discard_rt_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
>> >      > "relay-discard-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_discard_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
>> >      > "relay-overwrite-rt-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_overwrite_rt_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
>> >      > "relay-overwrite-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_overwrite_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3526/3526]: LTT : ltt ring buffer client
>> >      > "relay-metadata-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_metadata_client_exit() at
>> >      > ../../src/common/ringbuffer-clients/metadata-template.h:371)
>> >      >
>> >      > DBG1 - 10:26:10.271715039 [Run-as worker]: run_as worker exitin=
g
>> >     (ret =3D
>> >      > 0) (in run_as_create_worker_no_lock() at runas.c:1526)
>> >      >
>> >      > libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client
>> >      > "relay-discard-rt-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_discard_rt_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client
>> >      > "relay-discard-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_discard_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client
>> >      > "relay-overwrite-rt-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_overwrite_rt_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client
>> >      > "relay-overwrite-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_client_overwrite_exit() at
>> >      > ../../src/common/ringbuffer-clients/template.h:833)
>> >      >
>> >      > libringbuffer-clients[3507/3507]: LTT : ltt ring buffer client
>> >      > "relay-metadata-mmap" exit
>> >      >
>> >      > (in lttng_ring_buffer_metadata_client_exit() at
>> >      > ../../src/common/ringbuffer-clients/metadata-template.h:371)
>> >      >
>> >      >
>> >      > *yyan7@CCI13SZWP3LWS*:*~*$
>> >      >
>> >      >
>> >      >
>> >      > On Fri, Jan 12, 2024 at 10:01=E2=80=AFAM Kienan Stewart
>> >     <kstewart@efficios.com <mailto:kstewart@efficios.com>
>> >      > <mailto:kstewart@efficios.com <mailto:kstewart@efficios.com>>>
>> wrote:
>> >      >
>> >      >     Hi Yonghong,
>> >      >
>> >      >     in a brief test I'm unable to reproduce the error you see b=
y
>> >     running
>> >      >     the
>> >      >     following commands on an Ubuntu 22.04 installation with
>> >     lttng-tools
>> >      >     2.13.10, lttng-ust 2.13.6, urcu stable-0.12, and babeltrace
>> >     stable-2.0.
>> >      >     ```
>> >      >     $ uname -r -v
>> >      >     6.5.0-14-generic #14~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Mon
>> >     Nov 20
>> >      >     18:15:30 UTC 2
>> >      >
>> >      >     $ lttng-relayd -v -b
>> >      >     $ lttng-sessiond -v -b
>> >      >     $ lttng create
>> >      >     $ lttng enable-event -u --all
>> >      >     ```
>> >      >
>> >      >     Could you please review the bug reporting guidelines at
>> >      > https://lttng.org/community/ <https://lttng.org/community/>
>> >     <https://lttng.org/community/ <https://lttng.org/community/>> and
>> >      >     elaborate on the steps taken to
>> >      >     reproduce the issue?
>> >      >
>> >      >     thanks,
>> >      >     kienan
>> >      >
>> >      >     On 1/12/24 08:12, Yonghong Yan via lttng-dev wrote:
>> >      >      > I am not sure whether this is my setting problem or a bu=
g
>> >     with a
>> >      >      > more recent kernel. lttng-sessiond was killed when I
>> tried to
>> >      >     "enable
>> >      >      > event" after a session was created. See below part of th=
e
>> >     verbose
>> >      >     output
>> >      >      > of the sessiond. It is observed on Ubuntu 22.04, kernel
>> >      >     6.5.0-14-generic
>> >      >      > #14~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC, lttng (LTTng Tra=
ce
>> >     Control)
>> >      >      > 2.13.10 - Nordicit=C3=A9.
>> >      >      >
>> >      >      >
>> >      >      > The same version of LTTng works on another Ubuntu 22.04
>> >     machine, but
>> >      >      > with kernel 6.2.0-33-generic. Any suggestion on what I
>> >     should try?
>> >      >      >
>> >      >      >
>> >      >      > Thank you
>> >      >      >
>> >      >      > Yonghong
>> >      >      >
>> >      >      >
>> >      >      >
>> >      >      > c:1016)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.134138433 [Client management]: Getting
>> session
>> >      >      > auto-20240112-002417 by name (in process_client_msg() at
>> >      >     client.c:1133)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.134148894 [Client management]: Creating
>> UST
>> >      >     session (in
>> >      >      > create_ust_session() at client.c:510)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.134267958 [Client management]: Spawning
>> >     consumerd
>> >      >     (in
>> >      >      > spawn_consumerd() at client.c:204)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.135155823 [Client management]: Waiting f=
or
>> >     consumer
>> >      >      > management thread to be ready (in
>> >     wait_until_thread_is_ready() at
>> >      >      > manage-consumer.c:46)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.135247552 [Consumer management]: Enterin=
g
>> >     thread
>> >      >     entry
>> >      >      > point (in launch_thread() at thread.c:65)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.135293542 [Consumer management]: [thread=
]
>> >     Manage
>> >      >      > consumer started (in thread_consumer_management() at
>> >      >     manage-consumer.c:65)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.135335776 [Client management]: Using
>> >     64-bit UST
>> >      >     consumer
>> >      >      > at:
>> >     /usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consumerd (in
>> >      >      > spawn_consumerd() at client.c:284)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.240725883 [Consumer management]: Consume=
r
>> >     command
>> >      >     socket
>> >      >      > ready (fd: 61) (in thread_consumer_management() at
>> >      >     manage-consumer.c:204)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.240746802 [Consumer management]: Consume=
r
>> >     metadata
>> >      >      > socket ready (fd: 62) (in thread_consumer_management() a=
t
>> >      >      > manage-consumer.c:205)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.240775318 [Consumer management]: Sending
>> >     consumer
>> >      >      > initialization command (in consumer_init() at
>> consumer.c:1791)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.241066762 [Consumer management]: Marking
>> >     consumer
>> >      >      > management thread as ready (in mark_thread_as_ready() at
>> >      >      > manage-consumer.c:31)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.241100481 [Client management]: Consumer
>> >     management
>> >      >      > thread is ready (in wait_until_thread_is_ready() at
>> >      >     manage-consumer.c:48)
>> >      >      >
>> >      >      > DBG1 - 00:24:25.241138386 [Client management]: Setting
>> >     relayd for
>> >      >      > session auto-20240112-002417 (in cmd_setup_relayd() at
>> >     cmd.c:1004)
>> >      >      >
>> >      >      > lttng-sessiond: unix.c:185: lttcomm_recv_unix_sock:
>> Assertion
>> >      >     `buf' failed.
>> >      >      >
>> >      >      > Error: Events: No session daemon is available (channel
>> >     channel0,
>> >      >     session
>> >      >      > auto-20240112-002417)
>> >      >      >
>> >      >      > [1]+Aborted (core dumped) lttng-sessiond --verbose
>> >      >      >
>> >      >      > DBG1 - 00:24:26.357769106 [Run-as worker]: run_as worker
>> >     exiting
>> >      >     (ret =3D
>> >      >      > 0) (in run_as_create_worker_no_lock() at runas.c:1526)
>> >      >      >
>> >      >      >
>> >      >      >
>> >      >      > _______________________________________________
>> >      >      > lttng-dev mailing list
>> >      >      > lttng-dev@lists.lttng.org
>> >     <mailto:lttng-dev@lists.lttng.org> <mailto:
>> lttng-dev@lists.lttng.org
>> >     <mailto:lttng-dev@lists.lttng.org>>
>> >      >      >
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >     <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
>> >      >     <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >     <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>>
>> >      >
>> >
>>
>

--0000000000003a55b9060ecba800
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Kienan,=C2=A0</div><div><br></div>I just figured o=
ut what I did wrong. After I rebuilt the system the day before and installe=
d lttng-modules-dkms from Ubuntu officially, the building of kernel modules=
 failed (I can send you the crash and make.log for you to look at). I then =
added=C2=A0Ubuntu: LTTng Stable 2.13 PPA, and installation passed. With tha=
t, what installed are mix/mismatch of kms and binary of the partially insta=
lled kms from Ubuntu official and from stable 2.13 ppa. That caused the pro=
blem. I now removed everything and reinstalled everything from stable 2.13 =
ppa, everything works.<br><div><br></div><div>Thank you for helping me thro=
ugh this.=C2=A0</div><div><br>Best,</div><div>Yonghong</div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 12,=
 2024 at 10:04=E2=80=AFPM Yonghong Yan &lt;<a href=3D"mailto:yanyh15@gmail.=
com">yanyh15@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Hi Kienan,=C2=A0<di=
v><br></div><div>Thank you. I tried and unfortunately, there is no debuginf=
o in the=C2=A0<a href=3D"https://debuginfod.ubuntu.com" target=3D"_blank">h=
ttps://debuginfod.ubuntu.com</a> repo. I tried=C2=A0<a href=3D"https://debu=
ginfod.debian.net/" target=3D"_blank">https://debuginfod.debian.net/</a> as=
 well. No debug info. If you have a debug info file and can send to me, I c=
an use it in gdb to see the backtrace.=C2=A0</div><div><br></div><div>Best,=
</div><div>Yonghong</div><div><br></div><div>





<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures;color:rgb(47,180,29)"><b>yyan7@CCI13SZWP3LWS</b></span><span style=
=3D"font-variant-ligatures:no-common-ligatures">:</span><span style=3D"font=
-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)"><b>/var/lib/ap=
port/coredump</b></span><span style=3D"font-variant-ligatures:no-common-lig=
atures">$ export DEBUGINFOD_URLS=3D&quot;<a href=3D"https://debuginfod.ubun=
tu.com" target=3D"_blank">https://debuginfod.ubuntu.com</a>&quot;</span></p=
>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures;color:rgb(47,180,29)"><b>yyan7@CCI13SZWP3LWS</b></span><span style=
=3D"font-variant-ligatures:no-common-ligatures">:</span><span style=3D"font=
-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)"><b>/var/lib/ap=
port/coredump</b></span><span style=3D"font-variant-ligatures:no-common-lig=
atures">$ gdb /usr/bin/lttng-sessiond core._usr_bin_lttng-sessiond.1000.8f2=
2faa6-512c-49ca-9089-8b3f0801da8d.10470.2023109<span>=C2=A0</span></span></=
p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(200,20,201)"><span style=3D"font-variant-ligatures:no-comm=
on-ligatures"><b>GNU gdb (Ubuntu 12.1-0ubuntu1~22.04) 12.1</b></span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Copyright (C) 2022 Free Software Foundation, Inc.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">License GPLv3+: GNU GPL version 3 or later &lt;<a href=3D"http://g=
nu.org/licenses/gpl.html" target=3D"_blank">http://gnu.org/licenses/gpl.htm=
l</a>&gt;</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">This is free software: you are free to change and redistribute it.=
</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">There is NO WARRANTY, to the extent permitted by law.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Type &quot;show copying&quot; and &quot;show warranty&quot; for de=
tails.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">This GDB was configured as &quot;x86_64-linux-gnu&quot;.</span></p=
>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Type &quot;show configuration&quot; for configuration details.</sp=
an></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">For bug reporting instructions, please see:</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">&lt;<a href=3D"https://www.gnu.org/software/gdb/bugs/" target=3D"_=
blank">https://www.gnu.org/software/gdb/bugs/</a>&gt;.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Find the GDB manual and other documentation resources online at:</=
span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures"><span>=C2=A0 =C2=A0 </span>&lt;<a href=3D"http://www.gnu.org/softw=
are/gdb/documentation/" target=3D"_blank">http://www.gnu.org/software/gdb/d=
ocumentation/</a>&gt;.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0);min-height:20px"><span style=3D"font-variant-ligatu=
res:no-common-ligatures"></span><br></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">For help, type &quot;help&quot;.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Type &quot;apropos word&quot; to search for commands related to &q=
uot;word&quot;...</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Reading symbols from </span><span style=3D"font-variant-ligatures:=
no-common-ligatures;color:rgb(47,180,29)">/usr/bin/lttng-sessiond</span><sp=
an style=3D"font-variant-ligatures:no-common-ligatures">...</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0);min-height:20px"><span style=3D"font-variant-ligatu=
res:no-common-ligatures"></span><br></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">This GDB supports auto-downloading debuginfo from the following UR=
Ls:</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures"><a href=3D"https://debuginfod.ubuntu.com" target=3D"_blank">https:=
//debuginfod.ubuntu.com</a></span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Enable debuginfod for this session? (y or [n]) y</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Debuginfod has been enabled.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">To make this setting permanent, add &#39;set debuginfod enabled on=
&#39; to .gdbinit.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">(No debugging symbols found in </span><span style=3D"font-variant-=
ligatures:no-common-ligatures;color:rgb(47,180,29)">/usr/bin/lttng-sessiond=
</span><span style=3D"font-variant-ligatures:no-common-ligatures">)</span><=
/p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10479]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10470]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10476]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10475]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10472]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10478]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10480]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10473]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10477]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10482]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10542]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10533]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10484]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10474]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10481]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[New LWP 10483]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 0.19 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/libkmod.so.2</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 0.89 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/liblttng-ctl.so.0</span><span style=3D"font-variant-ligatures:n=
o-common-ligatures"><span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span></span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 0.05 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/liburcu.so.8</span><span style=3D"font-variant-ligatures:no-com=
mon-ligatures"> <span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span></span=
></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(47,180,29)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">Downloading 0.01 MB separate debug info for <=
/span><span style=3D"font-variant-ligatures:no-common-ligatures">/home/yyan=
7/.cache/debuginfod_client/55485e3e07dd2ab7e3510c9f90e8e8607f07d0c2/debugin=
fo</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 0.03 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/liburcu-common.so.8</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 0.07 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/liburcu-cds.so.8</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 2.45 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/libxml2.so.2</span><span style=3D"font-variant-ligatures:no-com=
mon-ligatures"> <span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span></span=
></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 1.73 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/libzstd.so.1</span><span style=3D"font-variant-ligatures:no-com=
mon-ligatures"> <span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span></span=
></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 0.30 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/liblzma.so.5</span><span style=3D"font-variant-ligatures:no-com=
mon-ligatures"> <span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span></span=
></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 4.95 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/libcrypto.so.3</span><span style=3D"font-variant-ligatures:no-c=
ommon-ligatures"> <span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span></span></=
p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 3.06 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/libicuuc.so.70</span><span style=3D"font-variant-ligatures:no-c=
ommon-ligatures"> <span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span></span></=
p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(47,180,29)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">Downloading 0.08 MB separate debug info for <=
/span><span style=3D"font-variant-ligatures:no-common-ligatures">/home/yyan=
7/.cache/debuginfod_client/bef3ff1d70aadd68aab07d858a759360c8b919ae/debugin=
fo</span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rg=
b(0,0,0)"><span>=C2=A0</span></span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 0.07 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/libnuma.so.1</span><span style=3D"font-variant-ligatures:no-com=
mon-ligatures"> <span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span></span=
></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 0.00 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/libicudata.so.70</span><span style=3D"font-variant-ligatures:no=
-common-ligatures"> <span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span></span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 5.99 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/libstdc++.so.6</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 0.18 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">/lib/x86_6=
4-linux-gnu/libgcc_s.so.1</span><span style=3D"font-variant-ligatures:no-co=
mmon-ligatures"><span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span></span=
></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Downloading 0.03 MB separate debug info for </span><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">system-sup=
plied DSO at 0x7ffdabeee000</span><span style=3D"font-variant-ligatures:no-=
common-ligatures"><span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span></span></=
p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[Thread debugging using libthread_db enabled]</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(47,180,29)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">Using host libthread_db library &quot;</span>=
<span style=3D"font-variant-ligatures:no-common-ligatures">/lib/x86_64-linu=
x-gnu/libthread_db.so.1</span><span style=3D"font-variant-ligatures:no-comm=
on-ligatures;color:rgb(0,0,0)">&quot;.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">--Type &lt;RET&gt; for more, q to quit, c to continue without pagi=
ng--</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Core was generated by `lttng-sessiond -vvv --verbose-consumer -b&#=
39;.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Program terminated with signal SIGABRT, Aborted.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#0<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(159,160,28)">__pthread_kill_implementation</=
span><span style=3D"font-variant-ligatures:no-common-ligatures"> (</span><s=
pan style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,18=
7)">no_tid</span><span style=3D"font-variant-ligatures:no-common-ligatures"=
>=3D0, </span><span style=3D"font-variant-ligatures:no-common-ligatures;col=
or:rgb(46,174,187)">signo</span><span style=3D"font-variant-ligatures:no-co=
mmon-ligatures">=3D6, </span><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(46,174,187)">threadid</span><span style=3D"font-varia=
nt-ligatures:no-common-ligatures">=3D140614729455104) at </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">./nptl=
/pthread_kill.c</span><span style=3D"font-variant-ligatures:no-common-ligat=
ures">:44</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">Download failed: Invalid argument.<span>=C2=A0 </span>Continuing w=
ithout source file </span><span style=3D"font-variant-ligatures:no-common-l=
igatures;color:rgb(47,180,29)">./nptl/./nptl/pthread_kill.c</span><span sty=
le=3D"font-variant-ligatures:no-common-ligatures">.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">44<span style=3D"white-space:pre-wrap">	</span>./nptl/pthread_kill=
.c: No such file or directory.</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">[Current thread is 1 (Thread 0x7fe36affd600 (LWP 10479))]</span></=
p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">(gdb) bt</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#0<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(159,160,28)">__pthread_kill_implementation</=
span><span style=3D"font-variant-ligatures:no-common-ligatures"> (</span><s=
pan style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,18=
7)">no_tid</span><span style=3D"font-variant-ligatures:no-common-ligatures"=
>=3D0, </span><span style=3D"font-variant-ligatures:no-common-ligatures;col=
or:rgb(46,174,187)">signo</span><span style=3D"font-variant-ligatures:no-co=
mmon-ligatures">=3D6, </span><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(46,174,187)">threadid</span><span style=3D"font-varia=
nt-ligatures:no-common-ligatures">=3D140614729455104) at </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">./nptl=
/pthread_kill.c</span><span style=3D"font-variant-ligatures:no-common-ligat=
ures">:44</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#1<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(159,160,28)">__pthread_kill_internal</span><=
span style=3D"font-variant-ligatures:no-common-ligatures"> (</span><span st=
yle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">si=
gno</span><span style=3D"font-variant-ligatures:no-common-ligatures">=3D6, =
</span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(=
46,174,187)">threadid</span><span style=3D"font-variant-ligatures:no-common=
-ligatures">=3D140614729455104) at </span><span style=3D"font-variant-ligat=
ures:no-common-ligatures;color:rgb(47,180,29)">./nptl/pthread_kill.c</span>=
<span style=3D"font-variant-ligatures:no-common-ligatures">:78</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#2<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(159,160,28)">__GI___pthread_kill</span><span=
 style=3D"font-variant-ligatures:no-common-ligatures"> (</span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">threa=
did</span><span style=3D"font-variant-ligatures:no-common-ligatures">=3D140=
614729455104, </span><span style=3D"font-variant-ligatures:no-common-ligatu=
res;color:rgb(46,174,187)">signo=3Dsigno@entry</span><span style=3D"font-va=
riant-ligatures:no-common-ligatures">=3D6) at </span><span style=3D"font-va=
riant-ligatures:no-common-ligatures;color:rgb(47,180,29)">./nptl/pthread_ki=
ll.c</span><span style=3D"font-variant-ligatures:no-common-ligatures">:89</=
span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(47,180,29)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#3<span>=C2=A0 </span></span><span style=3D"f=
ont-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37=
d842476</span><span style=3D"font-variant-ligatures:no-common-ligatures;col=
or:rgb(0,0,0)"> in </span><span style=3D"font-variant-ligatures:no-common-l=
igatures;color:rgb(159,160,28)">__GI_raise</span><span style=3D"font-varian=
t-ligatures:no-common-ligatures;color:rgb(0,0,0)"> (</span><span style=3D"f=
ont-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">sig=3Dsig@=
entry</span><span style=3D"font-variant-ligatures:no-common-ligatures;color=
:rgb(0,0,0)">=3D6) at </span><span style=3D"font-variant-ligatures:no-commo=
n-ligatures">../sysdeps/posix/raise.c</span><span style=3D"font-variant-lig=
atures:no-common-ligatures;color:rgb(0,0,0)">:26</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#4<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37d8287f3</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures"> in </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">__GI_=
abort</span><span style=3D"font-variant-ligatures:no-common-ligatures"> () =
at </span><span style=3D"font-variant-ligatures:no-common-ligatures;color:r=
gb(47,180,29)">./stdlib/abort.c</span><span style=3D"font-variant-ligatures=
:no-common-ligatures">:79</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#5<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37d82871b</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures"> in </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">__ass=
ert_fail_base</span><span style=3D"font-variant-ligatures:no-common-ligatur=
es"> (</span><span style=3D"font-variant-ligatures:no-common-ligatures;colo=
r:rgb(46,174,187)">fmt</span><span style=3D"font-variant-ligatures:no-commo=
n-ligatures">=3D0x7fe37d9dd130 &quot;%s%s%s:%u: %s%sAssertion `%s&#39; fail=
ed.\n%n&quot;,<span>=C2=A0</span></span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures"><span>=C2=A0 =C2=A0 </span></span><span style=3D"font-variant-liga=
tures:no-common-ligatures;color:rgb(46,174,187)">assertion</span><span styl=
e=3D"font-variant-ligatures:no-common-ligatures">=3D0x56371cd9a9ab &quot;bu=
f&quot;, </span><span style=3D"font-variant-ligatures:no-common-ligatures;c=
olor:rgb(46,174,187)">file</span><span style=3D"font-variant-ligatures:no-c=
ommon-ligatures">=3D0x56371cda20e7 &quot;unix.c&quot;, </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">line<=
/span><span style=3D"font-variant-ligatures:no-common-ligatures">=3D185, </=
span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46=
,174,187)">function</span><span style=3D"font-variant-ligatures:no-common-l=
igatures">=3D&lt;optimized out&gt;) at </span><span style=3D"font-variant-l=
igatures:no-common-ligatures;color:rgb(47,180,29)">./assert/assert.c</span>=
<span style=3D"font-variant-ligatures:no-common-ligatures">:92</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#6<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37d839e96</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures"> in </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">__GI_=
__assert_fail</span><span style=3D"font-variant-ligatures:no-common-ligatur=
es"> (</span><span style=3D"font-variant-ligatures:no-common-ligatures;colo=
r:rgb(46,174,187)">assertion</span><span style=3D"font-variant-ligatures:no=
-common-ligatures">=3D0x56371cd9a9ab &quot;buf&quot;, </span><span style=3D=
"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">file</sp=
an><span style=3D"font-variant-ligatures:no-common-ligatures">=3D0x56371cda=
20e7 &quot;unix.c&quot;, </span><span style=3D"font-variant-ligatures:no-co=
mmon-ligatures;color:rgb(46,174,187)">line</span><span style=3D"font-varian=
t-ligatures:no-common-ligatures">=3D185,<span>=C2=A0</span></span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures"><span>=C2=A0 =C2=A0 </span></span><span style=3D"font-variant-liga=
tures:no-common-ligatures;color:rgb(46,174,187)">function</span><span style=
=3D"font-variant-ligatures:no-common-ligatures">=3D0x56371cdc8830 &quot;ltt=
comm_recv_unix_sock&quot;) at </span><span style=3D"font-variant-ligatures:=
no-common-ligatures;color:rgb(47,180,29)">./assert/assert.c</span><span sty=
le=3D"font-variant-ligatures:no-common-ligatures">:101</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(64,11,217)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#7<span>=C2=A0 </span></span><span style=3D"f=
ont-variant-ligatures:no-common-ligatures">0x000056371cd561be</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </=
span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(15=
9,160,28)">??</span><span style=3D"font-variant-ligatures:no-common-ligatur=
es;color:rgb(0,0,0)"> ()</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(64,11,217)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#8<span>=C2=A0 </span></span><span style=3D"f=
ont-variant-ligatures:no-common-ligatures">0x000056371ccea96f</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </=
span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(15=
9,160,28)">??</span><span style=3D"font-variant-ligatures:no-common-ligatur=
es;color:rgb(0,0,0)"> ()</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(64,11,217)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#9<span>=C2=A0 </span></span><span style=3D"f=
ont-variant-ligatures:no-common-ligatures">0x000056371ccef7eb</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </=
span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(15=
9,160,28)">??</span><span style=3D"font-variant-ligatures:no-common-ligatur=
es;color:rgb(0,0,0)"> ()</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(64,11,217)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#10 </span><span style=3D"font-variant-ligatu=
res:no-common-ligatures">0x000056371ccf3b4c</span><span style=3D"font-varia=
nt-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">??</s=
pan><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0=
,0)"> ()</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(64,11,217)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#11 </span><span style=3D"font-variant-ligatu=
res:no-common-ligatures">0x000056371cce0ab7</span><span style=3D"font-varia=
nt-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">??</s=
pan><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0=
,0)"> ()</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#12 </span><span style=3D"font-variant-ligatures:no-common-ligatur=
es;color:rgb(64,11,217)">0x00007fe37d894ac3</span><span style=3D"font-varia=
nt-ligatures:no-common-ligatures"> in </span><span style=3D"font-variant-li=
gatures:no-common-ligatures;color:rgb(159,160,28)">start_thread</span><span=
 style=3D"font-variant-ligatures:no-common-ligatures"> (</span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">arg</=
span><span style=3D"font-variant-ligatures:no-common-ligatures">=3D&lt;opti=
mized out&gt;) at </span><span style=3D"font-variant-ligatures:no-common-li=
gatures;color:rgb(47,180,29)">./nptl/pthread_create.c</span><span style=3D"=
font-variant-ligatures:no-common-ligatures">:442</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(47,180,29)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#13 </span><span style=3D"font-variant-ligatu=
res:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37d926850</span><spa=
n style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in=
 </span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb=
(159,160,28)">clone3</span><span style=3D"font-variant-ligatures:no-common-=
ligatures;color:rgb(0,0,0)"> () at </span><span style=3D"font-variant-ligat=
ures:no-common-ligatures">../sysdeps/unix/sysv/linux/x86_64/clone3.S</span>=
<span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)"=
>:81</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">(gdb)<span>=C2=A0</span></span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#0<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(159,160,28)">__pthread_kill_implementation</=
span><span style=3D"font-variant-ligatures:no-common-ligatures"> (</span><s=
pan style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,18=
7)">no_tid</span><span style=3D"font-variant-ligatures:no-common-ligatures"=
>=3D0, </span><span style=3D"font-variant-ligatures:no-common-ligatures;col=
or:rgb(46,174,187)">signo</span><span style=3D"font-variant-ligatures:no-co=
mmon-ligatures">=3D6, </span><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(46,174,187)">threadid</span><span style=3D"font-varia=
nt-ligatures:no-common-ligatures">=3D140614729455104) at </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)">./nptl=
/pthread_kill.c</span><span style=3D"font-variant-ligatures:no-common-ligat=
ures">:44</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#1<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(159,160,28)">__pthread_kill_internal</span><=
span style=3D"font-variant-ligatures:no-common-ligatures"> (</span><span st=
yle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">si=
gno</span><span style=3D"font-variant-ligatures:no-common-ligatures">=3D6, =
</span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(=
46,174,187)">threadid</span><span style=3D"font-variant-ligatures:no-common=
-ligatures">=3D140614729455104) at </span><span style=3D"font-variant-ligat=
ures:no-common-ligatures;color:rgb(47,180,29)">./nptl/pthread_kill.c</span>=
<span style=3D"font-variant-ligatures:no-common-ligatures">:78</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#2<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(159,160,28)">__GI___pthread_kill</span><span=
 style=3D"font-variant-ligatures:no-common-ligatures"> (</span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">threa=
did</span><span style=3D"font-variant-ligatures:no-common-ligatures">=3D140=
614729455104, </span><span style=3D"font-variant-ligatures:no-common-ligatu=
res;color:rgb(46,174,187)">signo=3Dsigno@entry</span><span style=3D"font-va=
riant-ligatures:no-common-ligatures">=3D6) at </span><span style=3D"font-va=
riant-ligatures:no-common-ligatures;color:rgb(47,180,29)">./nptl/pthread_ki=
ll.c</span><span style=3D"font-variant-ligatures:no-common-ligatures">:89</=
span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(47,180,29)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#3<span>=C2=A0 </span></span><span style=3D"f=
ont-variant-ligatures:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37=
d842476</span><span style=3D"font-variant-ligatures:no-common-ligatures;col=
or:rgb(0,0,0)"> in </span><span style=3D"font-variant-ligatures:no-common-l=
igatures;color:rgb(159,160,28)">__GI_raise</span><span style=3D"font-varian=
t-ligatures:no-common-ligatures;color:rgb(0,0,0)"> (</span><span style=3D"f=
ont-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">sig=3Dsig@=
entry</span><span style=3D"font-variant-ligatures:no-common-ligatures;color=
:rgb(0,0,0)">=3D6) at </span><span style=3D"font-variant-ligatures:no-commo=
n-ligatures">../sysdeps/posix/raise.c</span><span style=3D"font-variant-lig=
atures:no-common-ligatures;color:rgb(0,0,0)">:26</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#4<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37d8287f3</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures"> in </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">__GI_=
abort</span><span style=3D"font-variant-ligatures:no-common-ligatures"> () =
at </span><span style=3D"font-variant-ligatures:no-common-ligatures;color:r=
gb(47,180,29)">./stdlib/abort.c</span><span style=3D"font-variant-ligatures=
:no-common-ligatures">:79</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#5<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37d82871b</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures"> in </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">__ass=
ert_fail_base</span><span style=3D"font-variant-ligatures:no-common-ligatur=
es"> (</span><span style=3D"font-variant-ligatures:no-common-ligatures;colo=
r:rgb(46,174,187)">fmt</span><span style=3D"font-variant-ligatures:no-commo=
n-ligatures">=3D0x7fe37d9dd130 &quot;%s%s%s:%u: %s%sAssertion `%s&#39; fail=
ed.\n%n&quot;,<span>=C2=A0</span></span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures"><span>=C2=A0 =C2=A0 </span></span><span style=3D"font-variant-liga=
tures:no-common-ligatures;color:rgb(46,174,187)">assertion</span><span styl=
e=3D"font-variant-ligatures:no-common-ligatures">=3D0x56371cd9a9ab &quot;bu=
f&quot;, </span><span style=3D"font-variant-ligatures:no-common-ligatures;c=
olor:rgb(46,174,187)">file</span><span style=3D"font-variant-ligatures:no-c=
ommon-ligatures">=3D0x56371cda20e7 &quot;unix.c&quot;, </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">line<=
/span><span style=3D"font-variant-ligatures:no-common-ligatures">=3D185, </=
span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46=
,174,187)">function</span><span style=3D"font-variant-ligatures:no-common-l=
igatures">=3D&lt;optimized out&gt;) at </span><span style=3D"font-variant-l=
igatures:no-common-ligatures;color:rgb(47,180,29)">./assert/assert.c</span>=
<span style=3D"font-variant-ligatures:no-common-ligatures">:92</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#6<span>=C2=A0 </span></span><span style=3D"font-variant-ligatures=
:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37d839e96</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures"> in </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">__GI_=
__assert_fail</span><span style=3D"font-variant-ligatures:no-common-ligatur=
es"> (</span><span style=3D"font-variant-ligatures:no-common-ligatures;colo=
r:rgb(46,174,187)">assertion</span><span style=3D"font-variant-ligatures:no=
-common-ligatures">=3D0x56371cd9a9ab &quot;buf&quot;, </span><span style=3D=
"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">file</sp=
an><span style=3D"font-variant-ligatures:no-common-ligatures">=3D0x56371cda=
20e7 &quot;unix.c&quot;, </span><span style=3D"font-variant-ligatures:no-co=
mmon-ligatures;color:rgb(46,174,187)">line</span><span style=3D"font-varian=
t-ligatures:no-common-ligatures">=3D185,<span>=C2=A0</span></span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures"><span>=C2=A0 =C2=A0 </span></span><span style=3D"font-variant-liga=
tures:no-common-ligatures;color:rgb(46,174,187)">function</span><span style=
=3D"font-variant-ligatures:no-common-ligatures">=3D0x56371cdc8830 &quot;ltt=
comm_recv_unix_sock&quot;) at </span><span style=3D"font-variant-ligatures:=
no-common-ligatures;color:rgb(47,180,29)">./assert/assert.c</span><span sty=
le=3D"font-variant-ligatures:no-common-ligatures">:101</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(64,11,217)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#7<span>=C2=A0 </span></span><span style=3D"f=
ont-variant-ligatures:no-common-ligatures">0x000056371cd561be</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </=
span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(15=
9,160,28)">??</span><span style=3D"font-variant-ligatures:no-common-ligatur=
es;color:rgb(0,0,0)"> ()</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(64,11,217)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#8<span>=C2=A0 </span></span><span style=3D"f=
ont-variant-ligatures:no-common-ligatures">0x000056371ccea96f</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </=
span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(15=
9,160,28)">??</span><span style=3D"font-variant-ligatures:no-common-ligatur=
es;color:rgb(0,0,0)"> ()</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(64,11,217)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#9<span>=C2=A0 </span></span><span style=3D"f=
ont-variant-ligatures:no-common-ligatures">0x000056371ccef7eb</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </=
span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(15=
9,160,28)">??</span><span style=3D"font-variant-ligatures:no-common-ligatur=
es;color:rgb(0,0,0)"> ()</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(64,11,217)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#10 </span><span style=3D"font-variant-ligatu=
res:no-common-ligatures">0x000056371ccf3b4c</span><span style=3D"font-varia=
nt-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">??</s=
pan><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0=
,0)"> ()</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(64,11,217)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#11 </span><span style=3D"font-variant-ligatu=
res:no-common-ligatures">0x000056371cce0ab7</span><span style=3D"font-varia=
nt-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in </span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(159,160,28)">??</s=
pan><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0=
,0)"> ()</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">#12 </span><span style=3D"font-variant-ligatures:no-common-ligatur=
es;color:rgb(64,11,217)">0x00007fe37d894ac3</span><span style=3D"font-varia=
nt-ligatures:no-common-ligatures"> in </span><span style=3D"font-variant-li=
gatures:no-common-ligatures;color:rgb(159,160,28)">start_thread</span><span=
 style=3D"font-variant-ligatures:no-common-ligatures"> (</span><span style=
=3D"font-variant-ligatures:no-common-ligatures;color:rgb(46,174,187)">arg</=
span><span style=3D"font-variant-ligatures:no-common-ligatures">=3D&lt;opti=
mized out&gt;) at </span><span style=3D"font-variant-ligatures:no-common-li=
gatures;color:rgb(47,180,29)">./nptl/pthread_create.c</span><span style=3D"=
font-variant-ligatures:no-common-ligatures">:442</span></p>
<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:17px;line-height:normal;font-family=
:Menlo;color:rgb(47,180,29)"><span style=3D"font-variant-ligatures:no-commo=
n-ligatures;color:rgb(0,0,0)">#13 </span><span style=3D"font-variant-ligatu=
res:no-common-ligatures;color:rgb(64,11,217)">0x00007fe37d926850</span><spa=
n style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)"> in=
 </span><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb=
(159,160,28)">clone3</span><span style=3D"font-variant-ligatures:no-common-=
ligatures;color:rgb(0,0,0)"> () at </span><span style=3D"font-variant-ligat=
ures:no-common-ligatures">../sysdeps/unix/sysv/linux/x86_64/clone3.S</span>=
<span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(0,0,0)"=
>:81</span></p></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jan 12, 2024 at 3:58=E2=80=AFPM Kienan Stewart=
 &lt;<a href=3D"mailto:kstewart@efficios.com" target=3D"_blank">kstewart@ef=
ficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Yonghong,<br>
<br>
thanks for the extra info. As you say without the symbol resolution the <br=
>
backtrace isn&#39;t super useful.<br>
<br>
Based on the build-id in the file info for lttng-sessiond, it looks like <b=
r>
you might be using the lttng/stable-2.13 ppa.<br>
<br>
In that case, you could try using debuginfod with gdb to automatically <br>
download the symbols. See <br>
<a href=3D"https://ubuntu.com/server/docs/service-debuginfod" rel=3D"norefe=
rrer" target=3D"_blank">https://ubuntu.com/server/docs/service-debuginfod</=
a> for the instructions <br>
enabling the symbol download from Ubuntu&#39;s debuginfod server.<br>
<br>
thanks,<br>
kienan<br>
<br>
On 1/12/24 15:38, Yonghong Yan wrote:<br>
&gt; Coredump is about 124MB and I am copying the backtrace of the coredump=
, <br>
&gt; see below. Unfortunately, the sessiond is stripped and no debugging <b=
r>
&gt; info, so not able to see the the call stack that lead to the dump. gue=
ss <br>
&gt; I need to build the lttng with debugging info and to get the symbol an=
d <br>
&gt; informed backtrace.<br>
&gt; <br>
&gt;=C2=A0 From the log itself, it is asserted aat &gt;=C2=A0 =C2=A0 =C2=A0=
 &gt; DBG1 - <br>
&gt; 00:24:25.241138386 [Client management]: Setting relayd for<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; session auto-20240112-002417 (in cmd_setu=
p_relayd() at cmd.c:1004)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng-sessiond: unix.c:185: lttcomm_recv_=
unix_sock: Assertion<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0`buf&#39; failed.<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*/var/log*$ tail apport.log<br>
&gt; <br>
&gt; <br>
&gt; ERROR: apport (pid 3787) Fri Jan 12 10:52:37 2024: debug: session gdbu=
s <br>
&gt; call:<br>
&gt; <br>
&gt; ERROR: apport (pid 3787) Fri Jan 12 10:52:37 2024: this executable <br=
>
&gt; already crashed 2 times, ignoring<br>
&gt; <br>
&gt; ERROR: apport (pid 10543) Fri Jan 12 15:18:07 2024: called for pid <br=
>
&gt; 10470, signal 6, core limit 18446744073709551615, dump mode 1<br>
&gt; <br>
&gt; ERROR: apport (pid 10543) Fri Jan 12 15:18:07 2024: ignoring implausib=
ly <br>
&gt; big core limit, treating as unlimited<br>
&gt; <br>
&gt; ERROR: apport (pid 10543) Fri Jan 12 15:18:07 2024: executable: <br>
&gt; /usr/bin/lttng-sessiond (command line &quot;lttng-sessiond -vvv <br>
&gt; --verbose-consumer -b&quot;)<br>
&gt; <br>
&gt; ERROR: apport (pid 10543) Fri Jan 12 15:18:08 2024: debug: session gdb=
us <br>
&gt; call: (true,)<br>
&gt; <br>
&gt; <br>
&gt; ERROR: apport (pid 10543) Fri Jan 12 15:18:08 2024: writing core dump =
to <br>
&gt; core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d=
.10470.2023109 (limit: -1)<br>
&gt; <br>
&gt; ERROR: apport (pid 10543) Fri Jan 12 15:18:08 2024: this executable <b=
r>
&gt; already crashed 2 times, ignoring<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*/var/log*$ cd /var/lib/apport/coredump<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ ls<br>
&gt; <br>
&gt; core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d=
.10470.2023109<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ file <br>
&gt; core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d=
.10470.2023109<br>
&gt; <br>
&gt; core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d=
.10470.2023109: ELF 64-bit LSB core file, x86-64, version 1 (SYSV), SVR4-st=
yle, from &#39;lttng-sessiond -vvv --verbose-consumer -b&#39;, real uid: 10=
00, effective uid: 1000, real gid: 1000, effective gid: 1000, execfn: &#39;=
/usr/bin/lttng-sessiond&#39;, platform: &#39;x86_64&#39;<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ du -h <br>
&gt; core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d=
.10470.2023109<br>
&gt; <br>
&gt; 124Mcore._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801=
da8d.10470.2023109<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ gdb <br>
&gt; /usr/bin/lttng-sessiond <br>
&gt; core._usr_bin_lttng-sessiond.1000.8f22faa6-512c-49ca-9089-8b3f0801da8d=
.10470.2023109<br>
&gt; <br>
&gt; *GNU gdb (Ubuntu 12.1-0ubuntu1~22.04) 12.1*<br>
&gt; <br>
&gt; Copyright (C) 2022 Free Software Foundation, Inc.<br>
&gt; <br>
&gt; License GPLv3+: GNU GPL version 3 or later <br>
&gt; &lt;<a href=3D"http://gnu.org/licenses/gpl.html" rel=3D"noreferrer" ta=
rget=3D"_blank">http://gnu.org/licenses/gpl.html</a> &lt;<a href=3D"http://=
gnu.org/licenses/gpl.html" rel=3D"noreferrer" target=3D"_blank">http://gnu.=
org/licenses/gpl.html</a>&gt;&gt;<br>
&gt; <br>
&gt; This is free software: you are free to change and redistribute it.<br>
&gt; <br>
&gt; There is NO WARRANTY, to the extent permitted by law.<br>
&gt; <br>
&gt; Type &quot;show copying&quot; and &quot;show warranty&quot; for detail=
s.<br>
&gt; <br>
&gt; This GDB was configured as &quot;x86_64-linux-gnu&quot;.<br>
&gt; <br>
&gt; Type &quot;show configuration&quot; for configuration details.<br>
&gt; <br>
&gt; For bug reporting instructions, please see:<br>
&gt; <br>
&gt; &lt;<a href=3D"https://www.gnu.org/software/gdb/bugs/" rel=3D"noreferr=
er" target=3D"_blank">https://www.gnu.org/software/gdb/bugs/</a> <br>
&gt; &lt;<a href=3D"https://www.gnu.org/software/gdb/bugs/" rel=3D"noreferr=
er" target=3D"_blank">https://www.gnu.org/software/gdb/bugs/</a>&gt;&gt;.<b=
r>
&gt; <br>
&gt; Find the GDB manual and other documentation resources online at:<br>
&gt; <br>
&gt; &lt;<a href=3D"http://www.gnu.org/software/gdb/documentation/" rel=3D"=
noreferrer" target=3D"_blank">http://www.gnu.org/software/gdb/documentation=
/</a> <br>
&gt; &lt;<a href=3D"http://www.gnu.org/software/gdb/documentation/" rel=3D"=
noreferrer" target=3D"_blank">http://www.gnu.org/software/gdb/documentation=
/</a>&gt;&gt;.<br>
&gt; <br>
&gt; <br>
&gt; For help, type &quot;help&quot;.<br>
&gt; <br>
&gt; Type &quot;apropos word&quot; to search for commands related to &quot;=
word&quot;...<br>
&gt; <br>
&gt; Reading symbols from /usr/bin/lttng-sessiond...<br>
&gt; <br>
&gt; (No debugging symbols found in /usr/bin/lttng-sessiond)<br>
&gt; <br>
&gt; [New LWP 10479]<br>
&gt; <br>
&gt; [New LWP 10470]<br>
&gt; <br>
&gt; [New LWP 10476]<br>
&gt; <br>
&gt; [New LWP 10475]<br>
&gt; <br>
&gt; [New LWP 10472]<br>
&gt; <br>
&gt; [New LWP 10478]<br>
&gt; <br>
&gt; [New LWP 10480]<br>
&gt; <br>
&gt; [New LWP 10473]<br>
&gt; <br>
&gt; [New LWP 10477]<br>
&gt; <br>
&gt; [New LWP 10482]<br>
&gt; <br>
&gt; [New LWP 10542]<br>
&gt; <br>
&gt; [New LWP 10533]<br>
&gt; <br>
&gt; [New LWP 10484]<br>
&gt; <br>
&gt; [New LWP 10474]<br>
&gt; <br>
&gt; [New LWP 10481]<br>
&gt; <br>
&gt; [New LWP 10483]<br>
&gt; <br>
&gt; [Thread debugging using libthread_db enabled]<br>
&gt; <br>
&gt; Using host libthread_db library &quot;/lib/x86_64-linux-gnu/libthread_=
db.so.1&quot;.<br>
&gt; <br>
&gt; --Type &lt;RET&gt; for more, q to quit, c to continue without paging--=
<br>
&gt; <br>
&gt; Core was generated by `lttng-sessiond -vvv --verbose-consumer -b&#39;.=
<br>
&gt; <br>
&gt; Program terminated with signal SIGABRT, Aborted.<br>
&gt; <br>
&gt; #0__pthread_kill_implementation(no_tid=3D0, signo=3D6, <br>
&gt; threadid=3D140614729455104) at ./nptl/pthread_kill.c:44<br>
&gt; <br>
&gt; 44./nptl/pthread_kill.c: No such file or directory.<br>
&gt; <br>
&gt; [Current thread is 1 (Thread 0x7fe36affd600 (LWP 10479))]<br>
&gt; <br>
&gt; (gdb) bt<br>
&gt; <br>
&gt; #0__pthread_kill_implementation(no_tid=3D0, signo=3D6, <br>
&gt; threadid=3D140614729455104) at ./nptl/pthread_kill.c:44<br>
&gt; <br>
&gt; #1__pthread_kill_internal(signo=3D6, threadid=3D140614729455104) at <b=
r>
&gt; ./nptl/pthread_kill.c:78<br>
&gt; <br>
&gt; #2__GI___pthread_kill(threadid=3D140614729455104, signo=3Dsigno@entry=
=3D6) at <br>
&gt; ./nptl/pthread_kill.c:89<br>
&gt; <br>
&gt; #30x00007fe37d842476in __GI_raise(sig=3Dsig@entry=3D6) at <br>
&gt; ../sysdeps/posix/raise.c:26<br>
&gt; <br>
&gt; #40x00007fe37d8287f3in __GI_abort() at ./stdlib/abort.c:79<br>
&gt; <br>
&gt; #50x00007fe37d82871bin __assert_fail_base(fmt=3D0x7fe37d9dd130 &quot;%=
s%s%s:%u: <br>
&gt; %s%sAssertion `%s&#39; failed.\n%n&quot;,<br>
&gt; <br>
&gt; assertion=3D0x56371cd9a9ab &quot;buf&quot;, file=3D0x56371cda20e7 &quo=
t;unix.c&quot;, line=3D185, <br>
&gt; function=3D&lt;optimized out&gt;) at ./assert/assert.c:92<br>
&gt; <br>
&gt; #60x00007fe37d839e96in __GI___assert_fail(assertion=3D0x56371cd9a9ab <=
br>
&gt; &quot;buf&quot;, file=3D0x56371cda20e7 &quot;unix.c&quot;, line=3D185,=
<br>
&gt; <br>
&gt; function=3D0x56371cdc8830 &quot;lttcomm_recv_unix_sock&quot;) at ./ass=
ert/assert.c:101<br>
&gt; <br>
&gt; #70x000056371cd561bein ??()<br>
&gt; <br>
&gt; #80x000056371ccea96fin ??()<br>
&gt; <br>
&gt; #90x000056371ccef7ebin ??()<br>
&gt; <br>
&gt; #10 0x000056371ccf3b4cin ??()<br>
&gt; <br>
&gt; #11 0x000056371cce0ab7in ??()<br>
&gt; <br>
&gt; #12 0x00007fe37d894ac3in start_thread(arg=3D&lt;optimized out&gt;) at =
<br>
&gt; ./nptl/pthread_create.c:442<br>
&gt; <br>
&gt; #13 0x00007fe37d926850in clone3() at <br>
&gt; ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81<br>
&gt; <br>
&gt; (gdb) quit<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$ file <br>
&gt; /usr/bin/lttng-sessiond<br>
&gt; <br>
&gt; /usr/bin/lttng-sessiond: ELF 64-bit LSB pie executable, x86-64, versio=
n <br>
&gt; 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2,=
 <br>
&gt; BuildID[sha1]=3D71b82210085b068b86d1252ed4f7403917af7cea, for GNU/Linu=
x <br>
&gt; 3.2.0, stripped<br>
&gt; <br>
&gt; *yyan7@CCI13SZWP3LWS*:*/var/lib/apport/coredump*$<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Jan 12, 2024 at 2:31=E2=80=AFPM Kienan Stewart &lt;<a href=3D"=
mailto:kstewart@efficios.com" target=3D"_blank">kstewart@efficios.com</a> <=
br>
&gt; &lt;mailto:<a href=3D"mailto:kstewart@efficios.com" target=3D"_blank">=
kstewart@efficios.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Yonghong,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0thanks for the additional information. Would you be=
 willing and able to<br>
&gt;=C2=A0 =C2=A0 =C2=A0share a coredump and/or backtrace of the crash?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I was still unable to reproduce the issue using the=
 commands you<br>
&gt;=C2=A0 =C2=A0 =C2=A0provided, but am interested in understanding what i=
s happening here.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Are there any configuration options other than LTTN=
G_UST_DEBUG=3D1 set in<br>
&gt;=C2=A0 =C2=A0 =C2=A0your environment?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Are you using urcu/lttng from packages (if so, whic=
h repo), or built<br>
&gt;=C2=A0 =C2=A0 =C2=A0from source?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The test case I am using now:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0```<br>
&gt;=C2=A0 =C2=A0 =C2=A0# As root<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ lttng-sessiond -b<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0# As a non-root user which is not a member of the t=
racing group<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ export LTTNG_UST_DEBUG=3D1<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ lttng-relayd -v -b<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ lttng-sessiond -vvv --verbose-consumer -b<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ lttng create<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ lttng enable-event -u -a<br>
&gt;=C2=A0 =C2=A0 =C2=A0```<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0kienan<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0P.S. In the future, could you keep the lttng-dev in=
 CC? thanks!<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 1/12/24 10:36, Yonghong Yan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi Kienan,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Thank you for checking.=C2=A0 It might be jus=
t my setting problem. I will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; just send it to you before we are sure it is =
an issue of lttng<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Below is the output and steps I followed the=
=C2=A0guideline. Since I<br>
&gt;=C2=A0 =C2=A0 =C2=A0started<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; the relayd and sessiond in the same terminal,=
 the verbose msg are<br>
&gt;=C2=A0 =C2=A0 =C2=A0mixed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; together. I can regenerate it using two separ=
ate terminals. It is<br>
&gt;=C2=A0 =C2=A0 =C2=A0a Dell<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Precision Tower box and it worked well yester=
day. But I rebuilt the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; system yesterday (because of NVIDIA GPU drive=
r issue), and it<br>
&gt;=C2=A0 =C2=A0 =C2=A0then have<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; this issue.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$ uname -a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Linux CCI13SZWP3LWS 6.5.0-14-generic #14~22.0=
4.1-Ubuntu SMP<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; PREEMPT_DYNAMIC Mon Nov 20 18:15:30 UTC 2 x86=
_64 x86_64 x86_64<br>
&gt;=C2=A0 =C2=A0 =C2=A0GNU/Linux<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$ cat /etc/lsb-relea=
se<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DISTRIB_ID=3DUbuntu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DISTRIB_RELEASE=3D22.04<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DISTRIB_CODENAME=3Djammy<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DISTRIB_DESCRIPTION=3D&quot;Ubuntu 22.04.3 LT=
S&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$ lttng --version<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng (LTTng Trace Control) 2.13.10 - Nordici=
t=C3=A9<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$ lsmod | grep lttng=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_writeback614400<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_workqueue204800<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_vmscan 450560<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_udp122880<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_timer327680<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_sunrpc 204800<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_statedump573440<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_sock 163840<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_skb163840<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_signal 163840<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_scsi 204800<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_sched450560<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_regulator204800<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_rcu122880<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_printk 122880<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_power204800<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_net327680<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_napi 122880<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_module 204800<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_kvm368640<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_jbd2 327680<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_irq163840<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_gpio 122880<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_block409600<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_probe_asoc 368640<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_counter_client_percpu_32_modular12288=
0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_counter_client_percpu_64_modular12288=
1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_counter163842<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0*lttng*_counter_client_percpu_64_modular,*lttng*_co=
unter_client_percpu_32_modular<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_ring_buffer_event_notifier_client2048=
02<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_ring_buffer_metadata_mmap_client20480=
0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_ring_buffer_client_mmap_overwrite2457=
60<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_ring_buffer_client_mmap_discard245760=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_ring_buffer_metadata_client204800<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_ring_buffer_client_overwrite245760<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_ring_buffer_client_discard245760<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_tracer 303513637<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0*lttng*_probe_udp,*lttng*_probe_scsi,*lttng*_probe_=
sched,*lttng*_probe_net,*lttng*_probe_vmscan,*lttng*_probe_writeback,*lttng=
*_probe_power,*lttng*_probe_rcu,*lttng*_probe_module,*lttng*_ring_buffer_cl=
ient_mmap_overwrite,*lttng*_probe_statedump,*lttng*_ring_buffer_client_disc=
ard,*lttng*_probe_printk,*lttng*_probe_sock,*lttng*_probe_asoc,*lttng*_coun=
ter_client_percpu_64_modular,*lttng*_probe_irq,*lttng*_ring_buffer_client_m=
map_discard,*lttng*_probe_kvm,*lttng*_probe_timer,*lttng*_ring_buffer_event=
_notifier_client,*lttng*_counter_client_percpu_32_modular,*lttng*_probe_wor=
kqueue,*lttng*_probe_jbd2,*lttng*_probe_signal,*lttng*_probe_skb,*lttng*_pr=
obe_block,*lttng*_probe_napi,*lttng*_ring_buffer_metadata_client,*lttng*_ri=
ng_buffer_metadata_mmap_client,*lttng*_probe_gpio,*lttng*_ring_buffer_clien=
t_overwrite,*lttng*_probe_regulator,*lttng*_probe_sunrpc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_statedump 7536641 *lttng*_tracer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_wrapper163847<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0*lttng*_statedump,*lttng*_probe_writeback,*lttng*_r=
ing_buffer_client_mmap_overwrite,*lttng*_ring_buffer_client_discard,*lttng*=
_tracer,*lttng*_ring_buffer_client_mmap_discard,*lttng*_ring_buffer_client_=
overwrite<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_uprobes163841 *lttng*_tracer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_clock122885<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0*lttng*_ring_buffer_client_mmap_overwrite,*lttng*_r=
ing_buffer_client_discard,*lttng*_tracer,*lttng*_ring_buffer_client_mmap_di=
scard,*lttng*_ring_buffer_client_overwrite<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_kprobes163841 *lttng*_tracer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_lib_ring_buffer942088<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0*lttng*_ring_buffer_client_mmap_overwrite,*lttng*_r=
ing_buffer_client_discard,*lttng*_tracer,*lttng*_ring_buffer_client_mmap_di=
scard,*lttng*_ring_buffer_event_notifier_client,*lttng*_ring_buffer_metadat=
a_client,*lttng*_ring_buffer_metadata_mmap_client,*lttng*_ring_buffer_clien=
t_overwrite<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng*_kretprobes 163841 *lttng*_tracer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$ export LTTNG_UST_D=
EBUG=3D1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$ lttng-relayd -v -b=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.244818657 [3495/3495]: File d=
escriptor count<br>
&gt;=C2=A0 =C2=A0 =C2=A0limits are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 1024 (soft) and 1048576 (hard) (in set_fd_poo=
l_size() at main.c:481)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.244870031 [3495/3495]: Signal=
 handler set for<br>
&gt;=C2=A0 =C2=A0 =C2=A0SIGTERM,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; SIGUSR1, SIGPIPE and SIGINT (in set_signal_ha=
ndler() at main.c:872)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.244877662 [3495/3495]: LTTng-=
relayd 2.13.10 -<br>
&gt;=C2=A0 =C2=A0 =C2=A0Nordicit=C3=A9<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in relayd_config_log() at main.c:206)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.244885255 [3495/3495]: Clear =
command allowed (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0main()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at main.c:4294)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.245867168 [3496/3496]: Unlink=
ed file pool created<br>
&gt;=C2=A0 =C2=A0 =C2=A0at:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/lttng-traces//.unlinked (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng_unlinked_file_pool_create() at inode.c:=
268)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.245903674 [3496/3496]: File d=
escriptor tracker<br>
&gt;=C2=A0 =C2=A0 =C2=A0created<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; with a limit of 1014 simultaneously-opened FD=
s (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0fd_tracker_create()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at fd-tracker.c:400)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.245925508 [3496/3496]: Health=
 check time delta in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; seconds set to 20 (in health_init() at health=
.c:62)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.245998123 [3496/3496]: TCP in=
et operation timeout<br>
&gt;=C2=A0 =C2=A0 =C2=A0set to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 216 sec (in lttcomm_inet_init() at inet.c:545=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246177304 [3496/3498]: [threa=
d] Manage health check<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; started (in thread_manage_health() at health-=
relayd.c:273)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246222966 [3496/3499]: [threa=
d] Relay dispatcher<br>
&gt;=C2=A0 =C2=A0 =C2=A0started<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in relay_thread_dispatcher() at main.c:1291)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246259512 [3496/3499]: Futex =
n to 1 prepare done (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; futex_nto1_prepare() at futex.c:67)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246266232 [3496/3496]: epoll =
set max size is<br>
&gt;=C2=A0 =C2=A0 =C2=A07225299 (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; compat_epoll_set_max_size() at poll.c:350)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246272226 [3496/3499]: Woken =
up but nothing in<br>
&gt;=C2=A0 =C2=A0 =C2=A0the relay<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; command queue (in relay_thread_dispatcher() a=
t main.c:1318)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246224883 [3496/3500]: [threa=
d] Relay worker<br>
&gt;=C2=A0 =C2=A0 =C2=A0started (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; relay_thread_worker() at main.c:3913)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246332173 [3496/3501]: [threa=
d] Relay listener<br>
&gt;=C2=A0 =C2=A0 =C2=A0started<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in relay_thread_listener() at main.c:1089)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246489021 [3496/3498]: Health=
 check ready (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_manage_health() at health-relayd.c:364=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246530206 [3496/3501]: Listen=
ing on Control listener<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; socket 13 (in relay_socket_create() at main.c=
:1033)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246595589 [3496/3501]: Listen=
ing on Data listener<br>
&gt;=C2=A0 =C2=A0 =C2=A0socket<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 14 (in relay_socket_create() at main.c:1033)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246623642 [3496/3501]: Listen=
er accepting<br>
&gt;=C2=A0 =C2=A0 =C2=A0connections<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in relay_thread_listener() at main.c:1136)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246619116 [3496/3502]: [threa=
d] Live viewer relay<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; dispatcher started (in thread_dispatcher() at=
 live.c:849)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246652489 [3496/3502]: Futex =
n to 1 prepare done (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; futex_nto1_prepare() at futex.c:67)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246662832 [3496/3502]: Woken =
up but nothing in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; live-viewer relay command queue (in thread_di=
spatcher() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0live.c:876)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246681238 [3496/3503]: [threa=
d] Live viewer relay<br>
&gt;=C2=A0 =C2=A0 =C2=A0worker<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; started (in thread_worker() at live.c:2451)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246694646 [3496/3504]: [threa=
d] Relay live listener<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; started (in thread_listener() at live.c:686)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246845536 [3496/3504]: Listen=
ing on Live listener<br>
&gt;=C2=A0 =C2=A0 =C2=A0socket<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 16 (in init_socket() at live.c:650)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:24:56.246891901 [3496/3504]: Listen=
er accepting live<br>
&gt;=C2=A0 =C2=A0 =C2=A0viewers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; connections (in thread_listener() at live.c:7=
20)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$ lttng-sessiond -vv=
v --verbose-consumer -b<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3505/3505]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-metadata-mmap&quot; init<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_metadata_client_init() =
at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/metadata-=
template.h:364)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3505/3505]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-overwrite-mmap&quot; init<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_overwrite_init()=
 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:826)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3505/3505]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-overwrite-rt-mmap&quot; init<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_overwrite_rt_ini=
t() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:826)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3505/3505]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-discard-mmap&quot; init<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_discard_init() a=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:826)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3505/3505]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-discard-rt-mmap&quot; init<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_discard_rt_init(=
) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:826)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693401139 [Main]: [sessiond c=
onfiguration]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693458872 [Main]: version2.13=
.10<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693469176 [Main]: verbose: 3<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693476719 [Main]: verbose con=
sumer:1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693486867 [Main]: quiet mode:=
False<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693493268 [Main]: agent_tcp_p=
ort:[5345, 5354]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693501264 [Main]: application=
 socket timeout:5<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693506511 [Main]: no-kernel: =
False<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693511705 [Main]: background:=
True<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693517223 [Main]: daemonize: =
False<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693522427 [Main]: signal pare=
nt on start:False<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693527446 [Main]: tracing gro=
up name:tracing<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693535560 [Main]: kmod_probe_=
list: None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693545390 [Main]: kmod_extra_=
probe_list: None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693550476 [Main]: rundir:/hom=
e/yyan7/.lttng<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693558977 [Main]: application=
 socket path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/.lttng/lttng-ust-sock-8<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693564632 [Main]: client sock=
et<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; path:/home/yyan7/.lttng/client-lttng-sessiond=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693573771 [Main]: wait shm pa=
th:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/lttng-ust-wait-8-1000<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693581196 [Main]: health sock=
et<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; path:/home/yyan7/.lttng/sessiond-health<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693592417 [Main]: LTTNG_UST_C=
LOCK_PLUGIN:None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693599715 [Main]: pid file pa=
th:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/.lttng/lttng-sessiond.pid<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693611177 [Main]: lock file<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; path:/home/yyan7/.lttng/lttng-sessiond.lck<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693618666 [Main]: session loa=
d path: None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693625291 [Main]: agent port =
file<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; path:/home/yyan7/.lttng/agent.port<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693632721 [Main]: consumerd32=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; path:/home/yyan7/.lttng/ustconsumerd32<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693640982 [Main]: consumerd32=
 bin path:Unknown<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693648470 [Main]: consumerd32=
 lib dir: Unknown<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693653601 [Main]: consumerd32=
 err unix sock<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; path:/home/yyan7/.lttng/ustconsumerd32/error<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693660355 [Main]: consumerd32=
 cmd unix sock<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; path:/home/yyan7/.lttng/ustconsumerd32/comman=
d<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693668191 [Main]: consumerd64=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; path:/home/yyan7/.lttng/ustconsumerd64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693673539 [Main]: consumerd64=
 bin<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; path:/usr/lib/x86_64-linux-gnu/lttng/libexec/=
lttng-consumerd<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693682080 [Main]: consumerd64=
 lib dir:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /usr/lib/x86_64-linux-gnu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693689246 [Main]: consumerd64=
 err unix sock<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; path:/home/yyan7/.lttng/ustconsumerd64/error<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693697419 [Main]: consumerd64=
 cmd unix sock<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; path:/home/yyan7/.lttng/ustconsumerd64/comman=
d<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693706980 [Main]: kconsumerd =
path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/.lttng/kconsumerd<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693714339 [Main]: kconsumerd =
err unix sock path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/.lttng/kconsumerd/error<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693724836 [Main]: kconsumerd =
cmd unix sock path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/.lttng/kconsumerd/command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.693736058 [Main]: Starting lt=
tng-sessiond<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; {0e76c943-cc93-414c-81d5-259bf7e8d0e4} (in se=
ssiond_uuid_log() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; main.c:1437)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.693744764 [Main]: Creating LT=
Tng run directory:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/.lttng (in create_lttng_rundir() =
at main.c:1069)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.696358185 [Main]: Resetting r=
un_as worker signal<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; handlers to default (in reset_sighandler() at=
 runas.c:1377)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.696480798 [Main]: run_as sign=
al handler set for<br>
&gt;=C2=A0 =C2=A0 =C2=A0SIGTERM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; and SIGINT (in set_worker_sighandlers() at ru=
nas.c:1438)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.697495897 [Main]: Health chec=
k time delta in<br>
&gt;=C2=A0 =C2=A0 =C2=A0seconds set<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; to 20 (in health_init() at health.c:62)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.697824357 [HT cleanup]: Enter=
ing thread entry<br>
&gt;=C2=A0 =C2=A0 =C2=A0point (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; launch_thread() at thread.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.697915191 [HT cleanup]: start=
up. (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread_ht_cleanup()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at ht-cleanup.c:98)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.697964263 [HT cleanup]: epoll=
 set max size is<br>
&gt;=C2=A0 =C2=A0 =C2=A07225299<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in compat_epoll_set_max_size() at poll.c:350=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698012958 [Main]: Created has=
htable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x5627de049140 of type ULONG (in lttng_ht_new=
() at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698041846 [Main]: Created has=
htable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x5627de049470 of type ULONG (in lttng_ht_new=
() at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698056225 [Main]: Created has=
htable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x5627de04bcd0 of type ULONG (in lttng_ht_new=
() at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698065318 [HT cleanup]: Polli=
ng. (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread_ht_cleanup()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at ht-cleanup.c:122)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698087629 [Main]: Created has=
htable size 16 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x5627de04cf80 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698104568 [Main]: Created has=
htable size 16 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x5627de04e230 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698117477 [Main]: Created has=
htable size 16 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x5627de04f630 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698127087 [Main]: Created has=
htable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x5627de050a50 of type ULONG (in lttng_ht_new=
() at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698142843 [Main]: Created has=
htable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x5627de051d90 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG2 - 10:25:05.698158685 [Main]: Creating co=
nsumer directory:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/.lttng/ustconsumerd64 (in set_con=
sumer_sockets() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0main.c:1111)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG2 - 10:25:05.698296819 [Main]: Creating co=
nsumer directory:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/.lttng/ustconsumerd32 (in set_con=
sumer_sockets() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0main.c:1111)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698395187 [Main]: Created has=
htable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x5627de0530d0 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698404718 [Main]: Global buff=
er per UID registry<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; initialized (in buffer_reg_init_uid_registry(=
) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer-registry.c:90)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698427501 [Main]: Created has=
htable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x5627de054410 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.698435763 [Main]: Global buff=
er per PID registry<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; initialized (in buffer_reg_init_pid_registry(=
) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0buffer-registry.c:219)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.698444533 [Main]: Command sub=
system initialized (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; cmd_init() at cmd.c:6090)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.698503908 [Main]: &#39;3506&#=
39; written in file<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/.lttng/lttng-sessiond.pid (in uti=
ls_create_pid_file() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; utils.c:257)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.698588286 [Main]: TCP inet op=
eration timeout set<br>
&gt;=C2=A0 =C2=A0 =C2=A0to 216<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; sec (in lttcomm_inet_init() at inet.c:545)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.698688270 [Main]: Waiting for=
 health management<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; to be ready (in wait_until_thread_is_ready() =
at health.c:35)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.698771494 [Health management]=
: Entering thread entry<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; point (in launch_thread() at thread.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.698803482 [Health management]=
: [thread] Manage<br>
&gt;=C2=A0 =C2=A0 =C2=A0health<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; check started (in thread_manage_health() at h=
ealth.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.698964797 [Health management]=
: Marking health<br>
&gt;=C2=A0 =C2=A0 =C2=A0management<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread as ready (in mark_thread_as_ready() at=
 health.c:28)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.698981598 [Health management]=
: Health check ready<br>
&gt;=C2=A0 =C2=A0 =C2=A0(in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_manage_health() at health.c:136)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.698991179 [Main]: Health mana=
gement thread is<br>
&gt;=C2=A0 =C2=A0 =C2=A0ready (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; wait_until_thread_is_ready() at health.c:37)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699062770 [Main]: Waiting for=
 notification thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ready (in wait_until_thread_is_ready() at not=
ification-thread.c:414)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699151645 [Notification]: Ent=
ering thread entry<br>
&gt;=C2=A0 =C2=A0 =C2=A0point<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in launch_thread() at thread.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699184431 [Notification]: Sta=
rted notification<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in thread_notification() at notification-thr=
ead.c:642)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699255526 [Notification]: Cre=
ating notification<br>
&gt;=C2=A0 =C2=A0 =C2=A0channel<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; UNIX socket at /home/yyan7/.lttng/sessiond-no=
tification (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; notification_channel_socket_create() at notif=
ication-thread.c:223)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699357295 [Notification]: Not=
ification channel UNIX<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; socket created (fd =3D 29) (in notification_c=
hannel_socket_create() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; notification-thread.c:258)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699387109 [Notification]: Lis=
tening on notification<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; channel socket (in init_thread_state() at not=
ification-thread.c:442)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699561257 [Notification]: Mar=
king notification<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ready (in mark_thread_as_ready() at notificat=
ion-thread.c:407)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699576135 [Notification]: Ent=
ering poll wait (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_notification() at notification-thread.=
c:668)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699592002 [Main]: Notificatio=
n thread is ready (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; wait_until_thread_is_ready() at notification-=
thread.c:416)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699600050 [Action Executor]: =
Entering thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0entry point<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in launch_thread() at thread.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699632561 [Action Executor]: =
Entering work execution<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; loop (in action_executor_thread() at action-e=
xecutor.c:761)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699643395 [Action Executor]: =
No work items enqueued,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; entering wait (in action_executor_thread() at=
 action-executor.c:770)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699750672 [Timer]: Entering t=
hread entry point (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; launch_thread() at thread.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699770466 [Rotation]: Enterin=
g thread entry point<br>
&gt;=C2=A0 =C2=A0 =C2=A0(in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; launch_thread() at thread.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699793428 [Main]: Created cli=
ent socket (fd =3D 35)<br>
&gt;=C2=A0 =C2=A0 =C2=A0(in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; create_client_sock() at client.c:2435)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699796906 [Rotation]: Started=
 rotation thread (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_rotation() at rotation-thread.c:840)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699868561 [Main]: Waiting for=
 client thread to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0ready<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in wait_thread_status() at client.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699906378 [Client management]=
: Entering thread entry<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; point (in launch_thread() at thread.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.699943442 [Client management]=
: [thread] Manage<br>
&gt;=C2=A0 =C2=A0 =C2=A0client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; started (in thread_manage_clients() at client=
.c:2468)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700053570 [Client management]=
: Marking client<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; state as running (in set_thread_status() at c=
lient.c:58)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700067760 [Client management]=
: Accepting client<br>
&gt;=C2=A0 =C2=A0 =C2=A0command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ... (in thread_manage_clients() at client.c:2=
534)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700076510 [Main]: Client thre=
ad is ready (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; wait_thread_status() at client.c:68)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700180769 [UST registration d=
ispatch]: Entering<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; entry point (in launch_thread() at thread.c:6=
5)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.700197002 [Main]: Session dae=
mon application socket<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; created (fd =3D 41)(in create_application_soc=
ket() at register.c:71)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700203416 [UST registration d=
ispatch]: [thread]<br>
&gt;=C2=A0 =C2=A0 =C2=A0Dispatch<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; UST command started (in thread_dispatch_ust_r=
egistration() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; dispatch.c:250)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700205198 [Notification]: Pol=
l wait returned (1) (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_notification() at notification-thread.=
c:670)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700255843 [Notification]: Han=
dling fd (29)<br>
&gt;=C2=A0 =C2=A0 =C2=A0activity (1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in thread_notification() at notification-thr=
ead.c:694)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700269799 [Notification]: Han=
dling new notification<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; channel client connection (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; handle_notification_thread_client_connect() a=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; notification-thread-events.c:3351)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700262016 [Main]: Waiting for=
 application<br>
&gt;=C2=A0 =C2=A0 =C2=A0registration<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread to be ready (in wait_thread_status() a=
t register.c:131)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700236776 [UST registration d=
ispatch]: Futex n to 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; prepare done (in futex_nto1_prepare() at fute=
x.c:67)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700308063 [Notification]: Cli=
ent socket (fd =3D 42)<br>
&gt;=C2=A0 =C2=A0 =C2=A0set as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; non-blocking (in socket_set_non_blocking() at=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; notification-thread-events.c:3319)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700319396 [UST registration d=
ispatch]: Woken up but<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; nothing in the UST command queue (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread_dispatch_ust_registration()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at dispatch.c:279)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700326116 [Notification]: Add=
ed new notification<br>
&gt;=C2=A0 =C2=A0 =C2=A0channel<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client socket (42) to poll set (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; handle_notification_thread_client_connect() a=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; notification-thread-events.c:3404)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700372936 [Notification]: Ent=
ering poll wait (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_notification() at notification-thread.=
c:668)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700383798 [Notification]: Pol=
l wait returned (1) (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_notification() at notification-thread.=
c:670)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700391774 [Notification]: Han=
dling fd (42)<br>
&gt;=C2=A0 =C2=A0 =C2=A0activity (1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in thread_notification() at notification-thr=
ead.c:694)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700405519 [Notification]: Ent=
ering poll wait (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_notification() at notification-thread.=
c:668)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700416164 [Notification]: Pol=
l wait returned (1) (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_notification() at notification-thread.=
c:670)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700424451 [Notification]: Han=
dling fd (42)<br>
&gt;=C2=A0 =C2=A0 =C2=A0activity (1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in thread_notification() at notification-thr=
ead.c:694)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700439076 [Notification]: Rec=
eived handshake from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client: uid =3D 1000, gid =3D 1000, protocol =
version =3D 1.1, client is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; sessiond =3D true (in client_handle_message_h=
andshake() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; notification-thread-events.c:3879)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700450858 [Notification]: Sen=
d command reply (0) (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client_send_command_reply() at notification-t=
hread-events.c:3755)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700460524 [Notification]: Flu=
shing client (socket<br>
&gt;=C2=A0 =C2=A0 =C2=A0fd =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 42) outgoing queue (in client_flush_outgoing_=
queue() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; notification-thread-events.c:3644)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700475786 [Notification]: Ent=
ering poll wait (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_notification() at notification-thread.=
c:668)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700505488 [Rotation]: Enterin=
g poll wait (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_rotation() at rotation-thread.c:864)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700506992 [UST application re=
gistration]: Entering<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread entry point (in launch_thread() at thr=
ead.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700529647 [UST application re=
gistration]: [thread]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Manage application registration started (in<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_application_registration() at register=
.c:168)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700597995 [UST application re=
gistration]: Marking<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; application registration thread&#39;s state a=
s running (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; set_thread_status() at register.c:124)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700609984 [UST application re=
gistration]: Accepting<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; application registration (in thread_applicati=
on_registration() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; register.c:207)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700616363 [Main]: Application=
 registration thread is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ready (in wait_thread_status() at register.c:=
134)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700627641 [Main]: Notifying a=
pplications of session<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; daemon state: 1 (in notify_ust_apps() at regi=
ster.c:91)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700659113 [Main]: Wait shared=
 memory file descriptor<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; created successfully: path =3D &#39;/lttng-us=
t-wait-8-1000&#39;, mmap_size<br>
&gt;=C2=A0 =C2=A0 =C2=A0=3D 4096,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; global =3D false, fd =3D 45 (in get_wait_shm(=
) at shm.c:133)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700688620 [Main]: Futex wait =
update active 1 (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; futex_wait_update() at futex.c:55)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700795964 [UST application ma=
nagement]: Entering<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; entry point (in launch_thread() at thread.c:6=
5)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700824549 [UST application ma=
nagement]: [thread]<br>
&gt;=C2=A0 =C2=A0 =C2=A0Manage<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; application started (in thread_application_ma=
nagement() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0manage-apps.c:52)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700848435 [Application notifi=
cation]: Entering<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; entry point (in launch_thread() at thread.c:6=
5)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700866212 [Application notifi=
cation]: [ust-thread]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Manage application notify command (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread_application_notification()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at notify-apps.c:39)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700913055 [Main]: Waiting for=
 agent management<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; be ready (in wait_until_thread_is_ready() at =
agent-thread.c:348)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700936679 [Agent management]:=
 Entering thread entry<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; point (in launch_thread() at thread.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.700952021 [Application notifi=
cation]: [ust-thread]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Manage notify polling (in thread_application_=
notification() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; notify-apps.c:74)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700964639 [UST application ma=
nagement]: Apps thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; polling (in thread_application_management() a=
t manage-apps.c:88)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.700955328 [Agent management]:=
 Manage agent<br>
&gt;=C2=A0 =C2=A0 =C2=A0application<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; registration. (in thread_agent_management() a=
t agent-thread.c:366)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.701062072 [Agent management]:=
 URI string:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; tcp://localhost (in uri_parse() at uri.c:298)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG2 - 10:25:05.701282226 [Agent management]:=
 IP address resolved to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 127.0.0.1 (in set_ip_address() at uri.c:155)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.701292578 [Agent management]:=
 URI dtype: 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0proto: 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; host: localhost, subdir: , ctrl: 0, data: 0 (=
in uri_parse() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0uri.c:510)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.701314205 [Agent management]:=
 Trying to bind on port<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 5345 (in init_tcp_socket() at agent-thread.c:=
140)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.701330622 [Agent management]:=
 Failed to bind to port<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 5345 since it is already in use (in init_tcp_=
socket() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0agent-thread.c:148)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.701338804 [Agent management]:=
 Trying to bind on port<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 5346 (in init_tcp_socket() at agent-thread.c:=
140)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.701351367 [Agent management]:=
 Listening on TCP<br>
&gt;=C2=A0 =C2=A0 =C2=A0port 5346<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; and socket 54 (in init_tcp_socket() at agent-=
thread.c:177)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.701413970 [Agent management]:=
 &#39;5346&#39; written in file<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/.lttng/agent.port (in utils_creat=
e_pid_file() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0utils.c:257)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.701452432 [Agent management]:=
 Marking agent<br>
&gt;=C2=A0 =C2=A0 =C2=A0management<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread as ready (in mark_thread_as_ready() at=
 agent-thread.c:341)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:05.701466232 [Agent management]:=
 Manage agent<br>
&gt;=C2=A0 =C2=A0 =C2=A0polling (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_agent_management() at agent-thread.c:4=
21)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:05.701544565 [Main]: Agent manag=
ement thread is<br>
&gt;=C2=A0 =C2=A0 =C2=A0ready (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; wait_until_thread_is_ready() at agent-thread.=
c:350)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3505/3505]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-discard-rt-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_discard_rt_exit(=
) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3505/3505]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-discard-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_discard_exit() a=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3505/3505]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-overwrite-rt-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_overwrite_rt_exi=
t() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3505/3505]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-overwrite-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_overwrite_exit()=
 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3505/3505]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-metadata-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_metadata_client_exit() =
at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/metadata-=
template.h:371)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$ ps -ef | grep lttn=
g<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; root 760 10 09:40 ?00:00:00 /usr/bin/*lttng*-=
sessiond<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; root 808 7600 09:40 ?00:00:00 /usr/bin/*lttng=
*-sessiond<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; yyan7 3496 10 10:24 ?00:00:00 *lttng*-relayd =
-v -b<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; yyan7 3506 10 10:25 ?00:00:00 *lttng*-session=
d -vvv<br>
&gt;=C2=A0 =C2=A0 =C2=A0--verbose-consumer -b<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; yyan7 350735060 10:25 ?00:00:00 *lttng*-sessi=
ond -vvv<br>
&gt;=C2=A0 =C2=A0 =C2=A0--verbose-consumer -b<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; yyan7 352229970 10:25 pts/000:00:00 grep --co=
lor=3Dauto *lttng*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$ lttng create<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436359096 [Client management]=
: Wait for client<br>
&gt;=C2=A0 =C2=A0 =C2=A0response<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in thread_manage_clients() at client.c:2576)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436403534 [Client management]=
: Receiving data from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client ... (in thread_manage_clients() at cli=
ent.c:2604)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436419086 [Client management]=
: Incomplete recv()<br>
&gt;=C2=A0 =C2=A0 =C2=A0from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client... continuing (in thread_manage_client=
s() at client.c:2608)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436438855 [Client management]=
: Accepting client<br>
&gt;=C2=A0 =C2=A0 =C2=A0command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ... (in thread_manage_clients() at client.c:2=
534)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436458714 [Client management]=
: Wait for client<br>
&gt;=C2=A0 =C2=A0 =C2=A0response<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in thread_manage_clients() at client.c:2576)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436480694 [Client management]=
: Receiving data from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client ... (in thread_manage_clients() at cli=
ent.c:2604)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436493760 [Client management]=
: Incomplete recv()<br>
&gt;=C2=A0 =C2=A0 =C2=A0from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client... continuing (in thread_manage_client=
s() at client.c:2608)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436514391 [Client management]=
: Accepting client<br>
&gt;=C2=A0 =C2=A0 =C2=A0command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ... (in thread_manage_clients() at client.c:2=
534)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436522846 [Client management]=
: Wait for client<br>
&gt;=C2=A0 =C2=A0 =C2=A0response<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in thread_manage_clients() at client.c:2576)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436539198 [Client management]=
: Receiving data from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client ... (in thread_manage_clients() at cli=
ent.c:2604)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436561992 [Client management]=
: Processing client<br>
&gt;=C2=A0 =C2=A0 =C2=A0command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &#39;LTTNG_CREATE_SESSION_EXT&#39; (49) (in p=
rocess_client_msg() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0client.c:1016)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:35.436644534 [Client management]=
: Created hashtable<br>
&gt;=C2=A0 =C2=A0 =C2=A0size 4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at 0x7fd67c0090b0 of type ULONG (in lttng_ht_=
new() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG2 - 10:25:35.436670494 [Client management]=
: Trying to find<br>
&gt;=C2=A0 =C2=A0 =C2=A0session by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; name auto-20240112-102535 (in session_find_by=
_name() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0session.c:1143)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436679003 [Client management]=
: Generated session<br>
&gt;=C2=A0 =C2=A0 =C2=A0name<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;auto-20240112-102535&quot; (in session_=
create() at session.c:1300)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:35.436693861 [Client management]=
: Created hashtable<br>
&gt;=C2=A0 =C2=A0 =C2=A0size 4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at 0x7fd67c00a3f0 of type ULONG (in lttng_ht_=
new() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436702475 [Client management]=
: Allocating<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ltt_sessions_ht_by_id (in ltt_sessions_ht_all=
oc() at session.c:306)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:35.436719034 [Client management]=
: Created hashtable<br>
&gt;=C2=A0 =C2=A0 =C2=A0size 4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at 0x7fd67c00b730 of type U64 (in lttng_ht_ne=
w() at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436727024 [Client management]=
: Allocating<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ltt_sessions_ht_by_name (in ltt_sessions_ht_a=
lloc() at session.c:314)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:35.436739320 [Client management]=
: Created hashtable<br>
&gt;=C2=A0 =C2=A0 =C2=A0size 4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at 0x7fd67c00ca70 of type STRING (in lttng_ht=
_new() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436750021 [Client management]=
: Tracing session<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; auto-20240112-102535 created with ID 0 by uid=
 =3D 1000, gid =3D 1000 (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; session_create() at session.c:1348)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:35.436761891 [Client management]=
: URI string:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; file:///home/yyan7/lttng-traces/auto-20240112=
-102535 (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0uri_parse() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; uri.c:298)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:35.436786010 [Client management]=
: URI file destination:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/lttng-traces/auto-20240112-102535=
 (in uri_parse() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0uri.c:335)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:25:35.436794369 [Client management]=
: URI dtype: 3,<br>
&gt;=C2=A0 =C2=A0 =C2=A0proto: 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; host: , subdir: , ctrl: 0, data: 0 (in uri_pa=
rse() at uri.c:510)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG2 - 10:25:35.436815787 [Client management]=
: Setting trace<br>
&gt;=C2=A0 =C2=A0 =C2=A0directory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; path from URI to /home/yyan7/lttng-traces/aut=
o-20240112-102535 (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; add_uri_to_consumer() at cmd.c:719)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436861339 [Client management]=
: Sending response<br>
&gt;=C2=A0 =C2=A0 =C2=A0(size:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 8262, retcode: Success (10)) (in thread_manag=
e_clients() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0client.c:2683)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.436885647 [Client management]=
: Accepting client<br>
&gt;=C2=A0 =C2=A0 =C2=A0command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ... (in thread_manage_clients() at client.c:2=
534)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.437011410 [Client management]=
: Wait for client<br>
&gt;=C2=A0 =C2=A0 =C2=A0response<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in thread_manage_clients() at client.c:2576)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.437037211 [Client management]=
: Receiving data from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client ... (in thread_manage_clients() at cli=
ent.c:2604)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.437050433 [Client management]=
: Incomplete recv()<br>
&gt;=C2=A0 =C2=A0 =C2=A0from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client... continuing (in thread_manage_client=
s() at client.c:2608)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.437065744 [Client management]=
: Accepting client<br>
&gt;=C2=A0 =C2=A0 =C2=A0command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ... (in thread_manage_clients() at client.c:2=
534)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.437074955 [Client management]=
: Wait for client<br>
&gt;=C2=A0 =C2=A0 =C2=A0response<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in thread_manage_clients() at client.c:2576)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.437088320 [Client management]=
: Receiving data from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client ... (in thread_manage_clients() at cli=
ent.c:2604)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.437107173 [Client management]=
: Processing client<br>
&gt;=C2=A0 =C2=A0 =C2=A0command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &#39;LTTNG_LIST_SESSIONS&#39; (13) (in proces=
s_client_msg() at client.c:1016)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.437120952 [Client management]=
: Counting number of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; available session for UID 1000 (in lttng_sess=
ions_count() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0client.c:596)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.437130882 [Client management]=
: Getting all available<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; session for UID 1000 GID 1000 (in cmd_list_lt=
tng_sessions() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0cmd.c:3947)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.437141977 [Client management]=
: Sending response<br>
&gt;=C2=A0 =C2=A0 =C2=A0(size:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 4409, retcode: Success (10)) (in thread_manag=
e_clients() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0client.c:2683)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:25:35.437163179 [Client management]=
: Accepting client<br>
&gt;=C2=A0 =C2=A0 =C2=A0command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ... (in thread_manage_clients() at client.c:2=
534)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Session auto-20240112-102535 created.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Traces will be output to<br>
&gt;=C2=A0 =C2=A0 =C2=A0/home/yyan7/lttng-traces/auto-20240112-102535<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$ lttng enable-event=
 -u -all<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Error: Only one domain must be specified.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$ lttng enable-event=
 -u -a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.048651842 [Client management]=
: Wait for client<br>
&gt;=C2=A0 =C2=A0 =C2=A0response<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in thread_manage_clients() at client.c:2576)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.048698882 [Client management]=
: Receiving data from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client ... (in thread_manage_clients() at cli=
ent.c:2604)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.048730037 [Client management]=
: Processing client<br>
&gt;=C2=A0 =C2=A0 =C2=A0command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &#39;LTTNG_ENABLE_EVENT&#39; (6) (in process_=
client_msg() at client.c:1016)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.048742929 [Client management]=
: Getting session<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; auto-20240112-102535 by name (in process_clie=
nt_msg() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0client.c:1133)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG2 - 10:26:09.048752328 [Client management]=
: Trying to find<br>
&gt;=C2=A0 =C2=A0 =C2=A0session by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; name auto-20240112-102535 (in session_find_by=
_name() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0session.c:1143)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.048762009 [Client management]=
: Creating UST<br>
&gt;=C2=A0 =C2=A0 =C2=A0session (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; create_ust_session() at client.c:510)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.048777715 [Client management]=
: Created hashtable<br>
&gt;=C2=A0 =C2=A0 =C2=A0size 4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at 0x7fd67c00ffd0 of type STRING (in lttng_ht=
_new() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.048801459 [Client management]=
: Created hashtable<br>
&gt;=C2=A0 =C2=A0 =C2=A0size 4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at 0x7fd67c011310 of type U64 (in lttng_ht_ne=
w() at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.048877638 [Client management]=
: Created hashtable<br>
&gt;=C2=A0 =C2=A0 =C2=A0size 4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at 0x7fd67c020120 of type ULONG (in lttng_ht_=
new() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG2 - 10:26:09.048886268 [Client management]=
: UST trace session<br>
&gt;=C2=A0 =C2=A0 =C2=A0create<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; successful (in trace_ust_create_session() at =
trace-ust.c:324)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.048894968 [Client management]=
: Copying tracing<br>
&gt;=C2=A0 =C2=A0 =C2=A0session<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer output in UST session (in copy_sessi=
on_consumer() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0client.c:454)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.048930287 [Client management]=
: Created hashtable<br>
&gt;=C2=A0 =C2=A0 =C2=A0size 4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at 0x7fd67c0213d0 of type ULONG (in lttng_ht_=
new() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.048944965 [Client management]=
: Copy session consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; subdir ust (in copy_session_consumer() at cli=
ent.c:476)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.048955915 [Client management]=
: Spawning consumerd<br>
&gt;=C2=A0 =C2=A0 =C2=A0(in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; spawn_consumerd() at client.c:204)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.048988740 [HT cleanup]: Retur=
ning from poll on 2<br>
&gt;=C2=A0 =C2=A0 =C2=A0fds.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in thread_ht_cleanup() at ht-cleanup.c:125)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG2 - 10:26:09.049819491 [Client management]=
: Consumer pid 3526 (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; start_consumerd() at client.c:390)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG2 - 10:26:09.049855514 [Client management]=
: Spawning consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0control<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread (in start_consumerd() at client.c:393)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.049986094 [Client management]=
: Waiting for consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; management thread to be ready (in wait_until_=
thread_is_ready() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; manage-consumer.c:46)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.050081839 [Consumer managemen=
t]: Entering thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0entry<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; point (in launch_thread() at thread.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.050074834 [Client management]=
: Using 64-bit UST<br>
&gt;=C2=A0 =C2=A0 =C2=A0consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at: /usr/lib/x86_64-linux-gnu/lttng/libexec/l=
ttng-consumerd (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; spawn_consumerd() at client.c:284)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.050117556 [Consumer managemen=
t]: [thread] Manage<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer started (in thread_consumer_manageme=
nt() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0manage-consumer.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.050103089 [HT cleanup]: Polli=
ng. (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread_ht_cleanup()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at ht-cleanup.c:122)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3526/3526]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-metadata-mmap&quot; init<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_metadata_client_init() =
at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/metadata-=
template.h:364)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3526/3526]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-overwrite-mmap&quot; init<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_overwrite_init()=
 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:826)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3526/3526]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-overwrite-rt-mmap&quot; init<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_overwrite_rt_ini=
t() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:826)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3526/3526]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-discard-mmap&quot; init<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_discard_init() a=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:826)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3526/3526]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-discard-rt-mmap&quot; init<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_discard_rt_init(=
) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:826)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.054724418 [3526/3526]: Health=
 check time delta in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; seconds set to 20 (in health_init() at health=
.c:62)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.054993129 [3526/3526]: Create=
d hashtable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x561838919540 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.055012947 [3526/3526]: Create=
d hashtable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x561838919870 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.055026387 [3526/3526]: Create=
d hashtable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x561838919ba0 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.055038707 [3526/3526]: Create=
d hashtable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x561838919ed0 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.055052418 [3526/3526]: Create=
d hashtable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x56183891eb00 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.055070118 [3526/3526]: Create=
d hashtable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x56183891fe40 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.055079438 [3526/3526]: Create=
d hashtable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x561838921180 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.055131986 [3526/3526]: TCP in=
et operation timeout<br>
&gt;=C2=A0 =C2=A0 =C2=A0set to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 216 sec (in lttcomm_inet_init() at inet.c:545=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.055169397 [3526/3526]: Connec=
ting to error socket<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/.lttng/ustconsumerd64/error (in m=
ain() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0lttng-consumerd.c:477)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG2 - 10:26:09.055307314 [Consumer managemen=
t]: Receiving code from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer err_sock (in thread_consumer_managem=
ent() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0manage-consumer.c:162)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.055374257 [3526/3530]: [threa=
d] Manage health check<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; started (in thread_manage_health() at health-=
consumerd.c:157)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.055528236 [3526/3530]: epoll =
set max size is<br>
&gt;=C2=A0 =C2=A0 =C2=A07225299 (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; compat_epoll_set_max_size() at poll.c:350)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.055617358 [3526/3530]: Health=
 check ready (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_manage_health() at health-consumerd.c:=
237)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.155778508 [3526/3533]: Thread=
 metadata poll<br>
&gt;=C2=A0 =C2=A0 =C2=A0started (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_metadata_poll() at consumer.c=
:2344)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.155827680 [3526/3532]: Create=
d hashtable size 4 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0x7fb838000b90 of type U64 (in lttng_ht_new()=
 at hashtable.c:152)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.155854441 [3526/3532]: Thread=
 channel poll<br>
&gt;=C2=A0 =C2=A0 =C2=A0started (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_channel_poll() at consumer.c:=
2938)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.155873849 [3526/3532]: Channe=
l main loop started (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_channel_poll() at consumer.c:=
2953)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.155884744 [3526/3532]: Channe=
l poll wait (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_channel_poll() at consumer.c:=
2958)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.155910091 [3526/3533]: Metada=
ta main loop started<br>
&gt;=C2=A0 =C2=A0 =C2=A0(in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_metadata_poll() at consumer.c=
:2360)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.155915209 [3526/3535]: Creati=
ng command socket<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; /home/yyan7/.lttng/ustconsumerd64/command (in=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_sessiond_poll() at consumer.c=
:3201)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.155927055 [3526/3533]: Metada=
ta poll wait (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_metadata_poll() at consumer.c=
:2366)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.155902292 [3526/3534]: Updati=
ng poll fd array (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; update_poll_array() at consumer.c:1176)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.155992208 [3526/3534]: pollin=
g on 2 fd (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_data_poll() at consumer.c:262=
7)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156028520 [3526/3535]: Sendin=
g ready command to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng-sessiond (in consumer_thread_sessiond_p=
oll() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0consumer.c:3214)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156117370 [3526/3535]: Connec=
tion on<br>
&gt;=C2=A0 =C2=A0 =C2=A0client_socket (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_sessiond_poll() at consumer.c=
:3236)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156118051 [Consumer managemen=
t]: Consumer command<br>
&gt;=C2=A0 =C2=A0 =C2=A0socket<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ready (fd: 61) (in thread_consumer_management=
() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0manage-consumer.c:204)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156134055 [Consumer managemen=
t]: Consumer metadata<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; socket ready (fd: 62) (in thread_consumer_man=
agement() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; manage-consumer.c:205)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156140605 [3526/3535]: Metada=
ta connection on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; client_socket (in set_metadata_socket() at co=
nsumer.c:3162)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156159591 [Consumer managemen=
t]: Sending consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; initialization command (in consumer_init() at=
 consumer.c:1791)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156197563 [3526/3535]: Incomi=
ng command on sock (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_sessiond_poll() at consumer.c=
:3282)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156239708 [3526/3535]: Receiv=
ed session daemon UUID:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0e76c943-cc93-414c-81d5-259bf7e8d0e4 (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0lttng_consumer_init_command()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; at consumer.c:4711)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156260388 [3526/3535]: Receiv=
ed command on sock (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_sessiond_poll() at consumer.c=
:3298)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.156271768 [Consumer managemen=
t]: Sending<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; SET_CHANNEL_MONITOR_PIPE command to consumer =
(in<br>
&gt;=C2=A0 =C2=A0 =C2=A0consumer_send_pipe() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer.c:1230)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156298833 [3526/3535]: Incomi=
ng command on sock (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_sessiond_poll() at consumer.c=
:3282)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.156339394 [Consumer managemen=
t]: Sending channel<br>
&gt;=C2=A0 =C2=A0 =C2=A0monitor<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; pipe 16 to consumer on socket 61 (in consumer=
_send_pipe() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer.c:1236)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156373728 [3526/3535]: Receiv=
ed channel monitor pipe<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (27) (in lttng_ustconsumer_recv_cmd() at ust-=
consumer.c:2017)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156385429 [3526/3535]: Channe=
l monitor pipe set as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; non-blocking (in lttng_ustconsumer_recv_cmd()=
 at ust-consumer.c:2040)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156398125 [3526/3535]: Receiv=
ed command on sock (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_sessiond_poll() at consumer.c=
:3298)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG2 - 10:26:09.156408026 [Consumer managemen=
t]: channel monitor<br>
&gt;=C2=A0 =C2=A0 =C2=A0pipe<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; successfully sent (in consumer_send_pipe() at=
 consumer.c:1244)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156521209 [Consumer managemen=
t]: Marking consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; management thread as ready (in mark_thread_as=
_ready() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; manage-consumer.c:31)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:09.156618144 [Client management]=
: Consumer management<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread is ready (in wait_until_thread_is_read=
y() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0manage-consumer.c:48)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG3 - 10:26:09.156649336 [Client management]=
: Consumer socket<br>
&gt;=C2=A0 =C2=A0 =C2=A0created<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (fd: 61) and added to output (in consumer_cre=
ate_socket() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0consumer.c:351)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *DBG1 - 10:26:09.156661610 [Client management=
]: Setting relayd for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; session auto-20240112-102535 (in cmd_setup_re=
layd() at cmd.c:1004)*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *lttng-sessiond: unix.c:185: lttcomm_recv_uni=
x_sock: Assertion `buf&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; failed.*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.269878943 [3526/3535]: Incomi=
ng command on sock (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_sessiond_poll() at consumer.c=
:3282)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.269909824 [3526/3535]: Consum=
er received unexpected<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; message size 0 (expects 12690) (in lttng_ustc=
onsumer_recv_cmd() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ust-consumer.c:1401)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.269918771 [3526/3535]: Commun=
ication interrupted on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; command socket (in consumer_thread_sessiond_p=
oll() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0consumer.c:3289)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.269924634 [3526/3535]: Consum=
er thread sessiond poll<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; exiting (in consumer_thread_sessiond_poll() a=
t consumer.c:3304)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Error: Events: No session daemon is available=
 (channel channel0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0session<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; auto-20240112-102535)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.269945294 [3526/3535]: UST co=
nsumer closing all<br>
&gt;=C2=A0 =C2=A0 =C2=A0metadata<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; streams (in lttng_ustconsumer_close_all_metad=
ata() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0ust-consumer.c:3278)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270034860 [3526/3534]: poll n=
um_rdy : 1 (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_data_poll() at consumer.c:263=
4)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270051195 [3526/3532]: Channe=
l poll return from wait<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; with 1 fd(s) (in consumer_thread_channel_poll=
() at consumer.c:2961)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270085710 [3526/3532]: Channe=
l event caught in<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in consumer_thread_channel_poll() at consume=
r.c:2964)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270066746 [3526/3534]: consum=
er_data_pipe wake up<br>
&gt;=C2=A0 =C2=A0 =C2=A0(in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_data_poll() at consumer.c:266=
4)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270051357 [3526/3530]: Health=
 check thread dying (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread_manage_health() at health-consumerd.c:=
334)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270114085 [3526/3532]: Channe=
l poll wait (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_channel_poll() at consumer.c:=
2958)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270151938 [3526/3532]: Channe=
l poll return from wait<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; with 0 fd(s) (in consumer_thread_channel_poll=
() at consumer.c:2961)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270163529 [3526/3532]: Channe=
l event caught in<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in consumer_thread_channel_poll() at consume=
r.c:2964)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270115093 [3526/3534]: Consum=
er delete flagged data<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; stream (in validate_endpoint_status_data_stre=
am() at consumer.c:2274)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270187345 [3526/3534]: pollin=
g thread exiting (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_data_poll() at consumer.c:280=
6)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270226737 [3526/3533]: Metada=
ta poll return from<br>
&gt;=C2=A0 =C2=A0 =C2=A0wait<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; with 1 fd(s) (in consumer_thread_metadata_pol=
l() at consumer.c:2368)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270255651 [3526/3533]: Metada=
ta event caught in<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in consumer_thread_metadata_poll() at consum=
er.c:2371)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270264901 [3526/3533]: Metada=
ta thread pipe hung<br>
&gt;=C2=A0 =C2=A0 =C2=A0up (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_metadata_poll() at consumer.c=
:2426)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270270628 [3526/3532]: Channe=
l poll thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0exiting (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_channel_poll() at consumer.c:=
3140)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270284048 [3526/3533]: Metada=
ta poll wait (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_metadata_poll() at consumer.c=
:2366)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270292833 [3526/3533]: Metada=
ta poll return from<br>
&gt;=C2=A0 =C2=A0 =C2=A0wait<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; with 0 fd(s) (in consumer_thread_metadata_pol=
l() at consumer.c:2368)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270300375 [3526/3533]: Metada=
ta event caught in<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in consumer_thread_metadata_poll() at consum=
er.c:2371)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270310033 [3526/3533]: Metada=
ta poll thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0exiting (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer_thread_metadata_poll() at consumer.c=
:2521)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270463392 [3526/3526]: Releas=
ing trace chunk<br>
&gt;=C2=A0 =C2=A0 =C2=A0registry to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; all trace chunks (in lttng_trace_chunk_regist=
ry_put_each_chunk() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; trace-chunk.c:2221)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270476593 [3526/3526]: Releas=
ed reference to 0 trace<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; chunks in lttng_trace_chunk_registry_put_each=
_chunk() (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng_trace_chunk_registry_put_each_chunk() a=
t trace-chunk.c:2254)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270667263 [3526/3526]: Consum=
er destroying it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Closing<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; everything. (in lttng_consumer_destroy() at c=
onsumer.c:1546)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270812838 [3526/3526]: Destro=
ying run_as worker (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; run_as_destroy_worker_no_lock() at runas.c:15=
76)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.270818934 [3526/3526]: Closin=
g run_as worker<br>
&gt;=C2=A0 =C2=A0 =C2=A0socket (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; run_as_destroy_worker_no_lock() at runas.c:15=
81)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$ libringbuffer-clie=
nts[3528/3528]: LTT<br>
&gt;=C2=A0 =C2=A0 =C2=A0: ltt<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ring buffer client &quot;relay-discard-rt-mma=
p&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_discard_rt_exit(=
) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3528/3528]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-discard-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_discard_exit() a=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3528/3528]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-overwrite-rt-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_overwrite_rt_exi=
t() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3528/3528]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-overwrite-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_overwrite_exit()=
 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3528/3528]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-metadata-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_metadata_client_exit() =
at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/metadata-=
template.h:371)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.271345058 [3526/3526]: lttng-=
runas terminated with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; status code 0 (in run_as_destroy_worker_no_lo=
ck() at runas.c:1601)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3526/3526]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-discard-rt-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_discard_rt_exit(=
) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3526/3526]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-discard-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_discard_exit() a=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3526/3526]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-overwrite-rt-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_overwrite_rt_exi=
t() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3526/3526]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-overwrite-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_overwrite_exit()=
 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3526/3526]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-metadata-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_metadata_client_exit() =
at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/metadata-=
template.h:371)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 10:26:10.271715039 [Run-as worker]: ru=
n_as worker exiting<br>
&gt;=C2=A0 =C2=A0 =C2=A0(ret =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0) (in run_as_create_worker_no_lock() at runa=
s.c:1526)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3507/3507]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-discard-rt-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_discard_rt_exit(=
) at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3507/3507]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-discard-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_discard_exit() a=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3507/3507]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-overwrite-rt-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_overwrite_rt_exi=
t() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3507/3507]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-overwrite-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_client_overwrite_exit()=
 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/template.=
h:833)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libringbuffer-clients[3507/3507]: LTT : ltt r=
ing buffer client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;relay-metadata-mmap&quot; exit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (in lttng_ring_buffer_metadata_client_exit() =
at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ../../src/common/ringbuffer-clients/metadata-=
template.h:371)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; *yyan7@CCI13SZWP3LWS*:*~*$<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Fri, Jan 12, 2024 at 10:01=E2=80=AFAM Kien=
an Stewart<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:kstewart@efficios.com" target=
=3D"_blank">kstewart@efficios.com</a> &lt;mailto:<a href=3D"mailto:kstewart=
@efficios.com" target=3D"_blank">kstewart@efficios.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:kstewart@efficio=
s.com" target=3D"_blank">kstewart@efficios.com</a> &lt;mailto:<a href=3D"ma=
ilto:kstewart@efficios.com" target=3D"_blank">kstewart@efficios.com</a>&gt;=
&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Hi Yonghong,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0in a brief test I&#39;m un=
able to reproduce the error you see by<br>
&gt;=C2=A0 =C2=A0 =C2=A0running<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0following commands on an U=
buntu 22.04 installation with<br>
&gt;=C2=A0 =C2=A0 =C2=A0lttng-tools<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A02.13.10, lttng-ust 2.13.6,=
 urcu stable-0.12, and babeltrace<br>
&gt;=C2=A0 =C2=A0 =C2=A0stable-2.0.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0$ uname -r -v<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A06.5.0-14-generic #14~22.04=
.1-Ubuntu SMP PREEMPT_DYNAMIC Mon<br>
&gt;=C2=A0 =C2=A0 =C2=A0Nov 20<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A018:15:30 UTC 2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0$ lttng-relayd -v -b<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0$ lttng-sessiond -v -b<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0$ lttng create<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0$ lttng enable-event -u --=
all<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Could you please review th=
e bug reporting guidelines at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://lttng.org/community/" rel=
=3D"noreferrer" target=3D"_blank">https://lttng.org/community/</a> &lt;<a h=
ref=3D"https://lttng.org/community/" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lttng.org/community/</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lttng.org/community/" rel=3D=
"noreferrer" target=3D"_blank">https://lttng.org/community/</a> &lt;<a href=
=3D"https://lttng.org/community/" rel=3D"noreferrer" target=3D"_blank">http=
s://lttng.org/community/</a>&gt;&gt; and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0elaborate on the steps tak=
en to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0reproduce the issue?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0kienan<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On 1/12/24 08:12, Yonghong=
 Yan via lttng-dev wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; I am not sure=C2=A0w=
hether=C2=A0this is my setting problem or a bug<br>
&gt;=C2=A0 =C2=A0 =C2=A0with a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; more=C2=A0recent=C2=
=A0kernel. lttng-sessiond was killed when I tried to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&quot;enable<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; event&quot; after a =
session was created. See below part of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0verbose<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0output<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; of the sessiond. It =
is observed on Ubuntu 22.04, kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A06.5.0-14-generic<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; #14~22.04.1-Ubuntu S=
MP PREEMPT_DYNAMIC, lttng (LTTng Trace<br>
&gt;=C2=A0 =C2=A0 =C2=A0Control)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; 2.13.10 - Nordicit=
=C3=A9.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; The same version of =
LTTng works on another Ubuntu 22.04<br>
&gt;=C2=A0 =C2=A0 =C2=A0machine, but<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; with kernel 6.2.0-33=
-generic. Any suggestion on what I<br>
&gt;=C2=A0 =C2=A0 =C2=A0should try?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Thank you<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Yonghong<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; c:1016)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.1341=
38433 [Client management]: Getting session<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; auto-20240112-002417=
 by name (in process_client_msg() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0client.c:1133)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.1341=
48894 [Client management]: Creating UST<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0session (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; create_ust_session()=
 at client.c:510)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.1342=
67958 [Client management]: Spawning<br>
&gt;=C2=A0 =C2=A0 =C2=A0consumerd<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0(in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; spawn_consumerd() at=
 client.c:204)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.1351=
55823 [Client management]: Waiting for<br>
&gt;=C2=A0 =C2=A0 =C2=A0consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; management thread to=
 be ready (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0wait_until_thread_is_ready() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; manage-consumer.c:46=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.1352=
47552 [Consumer management]: Entering<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0entry<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; point (in launch_thr=
ead() at thread.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.1352=
93542 [Consumer management]: [thread]<br>
&gt;=C2=A0 =C2=A0 =C2=A0Manage<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; consumer started (in=
 thread_consumer_management() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0manage-consumer.c:65)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.1353=
35776 [Client management]: Using<br>
&gt;=C2=A0 =C2=A0 =C2=A064-bit UST<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; at:<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consu=
merd (in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; spawn_consumerd() at=
 client.c:284)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.2407=
25883 [Consumer management]: Consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0socket<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; ready (fd: 61) (in t=
hread_consumer_management() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0manage-consumer.c:204)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.2407=
46802 [Consumer management]: Consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0metadata<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; socket ready (fd: 62=
) (in thread_consumer_management() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; manage-consumer.c:20=
5)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.2407=
75318 [Consumer management]: Sending<br>
&gt;=C2=A0 =C2=A0 =C2=A0consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; initialization comma=
nd (in consumer_init() at consumer.c:1791)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.2410=
66762 [Consumer management]: Marking<br>
&gt;=C2=A0 =C2=A0 =C2=A0consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; management thread as=
 ready (in mark_thread_as_ready() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; manage-consumer.c:31=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.2411=
00481 [Client management]: Consumer<br>
&gt;=C2=A0 =C2=A0 =C2=A0management<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread is ready (in =
wait_until_thread_is_ready() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0manage-consumer.c:48)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:25.2411=
38386 [Client management]: Setting<br>
&gt;=C2=A0 =C2=A0 =C2=A0relayd for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; session auto-2024011=
2-002417 (in cmd_setup_relayd() at<br>
&gt;=C2=A0 =C2=A0 =C2=A0cmd.c:1004)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng-sessiond: unix=
.c:185: lttcomm_recv_unix_sock: Assertion<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0`buf&#39; failed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Error: Events: No se=
ssion daemon is available (channel<br>
&gt;=C2=A0 =C2=A0 =C2=A0channel0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0session<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; auto-20240112-002417=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; [1]+Aborted (core du=
mped) lttng-sessiond --verbose<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; DBG1 - 00:24:26.3577=
69106 [Run-as worker]: run_as worker<br>
&gt;=C2=A0 =C2=A0 =C2=A0exiting<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0(ret =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0) (in run_as_create=
_worker_no_lock() at runas.c:1526)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; ____________________=
___________________________<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; lttng-dev mailing li=
st<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"mailto:lt=
tng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:lttng-dev@lists.lttng.=
org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt; &lt;mailto:<a href=
=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.ltt=
ng.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:lttng-dev@lists.lttng.=
org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://l=
ists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" targe=
t=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lis=
ts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=
=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
</blockquote></div></div>
</blockquote></div>

--0000000000003a55b9060ecba800--

--===============2296450865840197942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2296450865840197942==--
