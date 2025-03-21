Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4A9C36000
	for <lttng-dev@archiver.kernel.org>; Fri, 21 Mar 2025 12:53:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZK2SF4v6yz1455
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1742561615;
	b=olsd805blf8sOqWY34iohVeOWEpUhCWnUTf3ubBZhZ/2Hgxg5i6rfnzSZtyrwniAEhTM
	 lCTipHoYmgHUe4QuMC2sjYoae6++8tn7n5ZPryWeYCFT+MUj7bE61m9xpM2r+stQMVFGL
	 oGd1wPoD/LYn+GgMJrV4nvHjb53IloGGZPr0h3aD1afReasfD0eTTGdM6RYDet91p6qwk
	 T74SOF/8OU9wupZ8XOyl6llWNn3/J7ZQ97yyi+IqcHwEmGvuPqqyR8BgCUIWRbir91iGw
	 I2qaCXdtAAnyG5Lie3apgiUEpmwr2IXfsF4WTvGWZ4rnOfbbZ7M1ObTC/31hDZHN6zw==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1742561615;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=9fAb0fPshTzmrf89EH6BBmflcjHQ6draDnMMYEfiwRQ=;
	b=Cww3GcuW4K4aLmdeZTvYEa/+vRYfI9W7qDjD/P068YnrSObR2270ZH7FRBZLZkNJ4kNM
	 61avHijc7kcReueTf0J21OdCKx2nZG0kd9s8eKdrZj4YJq9r6VTjCL8ql1uERJJVOcNCs
	 88ZGl/77ftyRa9pW2c2a62dczxuCVkaUgczjEnQ487TUBRBacX8sZGbGOUqWsW7mvRKs0
	 RdKYgq+cOww4Df4jl164QVMyDdlapOm7hMJDLUv8wig5A14syy3pPbF158uzkwY3CJwdC
	 iflvm4D/sIIM65mRq+xieJhYm4H+MDHK1xng5KeCuDwYvVpb7pUFJWfptvkDFkTLbZA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZK2SF4v6yz1455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1742561615;
	bh=9fAb0fPshTzmrf89EH6BBmflcjHQ6draDnMMYEfiwRQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=k23+4u4S6hQinN7+YvZ85pmM5TlJxAIe/kmq6Hp6sP502Cmaj8LGJ+UCVwEF8RphM
	 HEKtJm4CU00UeNYUM3+2TIeS/f+ZO1TYV5rkBa6kiK+aQzzOYu6rJLhJ4aAT+VumiT
	 Q78/TBdpQpl7nuCCizLTUWULLi/B/2o4hsgnm7yXw6CZCdedIhywi5JoZKkrWg9Nb4
	 CiIrcdgT8ojqq48bJxZWZ4hgQd6IPuKYLxWevED+V1Pmy7N2+u90R5cs47zCFpnXaY
	 dmvyEqvodynGvSwqX26wRqPlwPKug2DHaOaQNDknDmOwTpacxBEnmQVJa7l0oTBMHc
	 V6AtLrJ3u+LSQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZK2SF4v6yz1455;
	Fri, 21 Mar 2025 08:53:33 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZK2SD1JdHz144s
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZK2SD1JdHz144s
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZK2SD1JdHz144s
 for <lttng-dev@lists.lttng.org>; Fri, 21 Mar 2025 08:53:31 -0400 (EDT)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-301493f45aeso3191783a91.1
 for <lttng-dev@lists.lttng.org>; Fri, 21 Mar 2025 05:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742561611; x=1743166411;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qykdTWrI8WGBoA/CZClW4Bu44hoHYAQiVpP9gujB6+w=;
 b=B69c0u+oHut/2FjjyqfsC68SUahOfSKV+j0FJdo3VkQLqLfJVIXKH1hnrBL5wS34kX
 osdSrEnME5jOZliTTOw9WgotXJp+aeH5X8CrTaKgrNbmX+T8WRWxLUXG9en9Bot5F+aa
 dXul/pA/zvIsE+sxNDOrKOg0HtsyExsv+J3430J8F8zZHa3rYfOIL6pJSLAC4O2jUAUd
 HOMEzXT/4ZIzHP5dB7JXM5JWyRVx89On6atwHwRz/T9gvcQReD2Y4RTFneb3F3lAL5GF
 7YJIwUB5K7R5a5fBMJDgb2DvkowBpBj/2yRibH0n+jqfnCiwVPEK6K/sOd31chlD6z0p
 nxpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaHNwNcFOGsficdIbIKJ3AMRBMcNTMtSVDXiVJzajqqgv/Z4o7Iedu/P8VwxKE3eWD82ZuVHFfl7Q=@lists.lttng.org
X-Gm-Message-State: AOJu0YzVyHU1o9KZsX4Y0AUfvh6Hmz1SH25Uc8wk0YF0+PaVx0nLqXAq
 C5V+XGqsJ2WX6zx6zvHnSX9mAOpw7T5K8QvujB1En77kNdoFvd+lG8VzxYfDisn0i/AV/JSSbEp
 6CjuYmzf2ntjvcRS7amT+dnpuWqJ8XfD6xMA=
X-Gm-Gg: ASbGnctLwcnbIuHZCP95Hua8QAKX/bWqQLfHypudM1JStEkNUpsdpSTsWrsS4Zgmaqx
 ELMn5n+I1GrIbxD6ojb4l8B+9fuEc6INWJkOiValqaGr2DxqXJUVqA4YRLzX6ZpAelvwzg+pVsw
 RrZp81zjKQUgC/Er3rqzmKjqH9tcnt5V8E0Q7EouV09CBfJ1baIFi2A0SKq2c=
X-Google-Smtp-Source: AGHT+IGaNDKG8NxqH5pVzlIw6kKNmClSde/BDw7IOHsXuJp8+vASYfkzhwSnpoaUU6WL4uZJJsbHEVdWIEmDXcwEaEY=
X-Received: by 2002:a17:90b:2647:b0:2f8:49ad:4079 with SMTP id
 98e67ed59e1d1-3030fe6e164mr4661319a91.6.1742561609979; Fri, 21 Mar 2025
 05:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <mailman.58.1741790192.282.lttng-dev@lists.lttng.org>
 <CAE9Jrzj_A8AwR80s-2_Wnv+vSpgqp4m6jKmJAAVg5VP4SKASEA@mail.gmail.com>
 <605bbc18-bb08-4a72-b470-fc0c34e67acd@efficios.com>
In-Reply-To: <605bbc18-bb08-4a72-b470-fc0c34e67acd@efficios.com>
Date: Fri, 21 Mar 2025 18:22:52 +0530
X-Gm-Features: AQ5f1JrHA6f4d7qEUj0jHYoZ-HPJio_E4fvHfEHr_DhpXjx37q2J5I3__wImc_k
Message-ID: <CAE9JrzgEisZUcV4ek+bUJriXj3=8ufMYDyHxWYaYVAV5OHor4w@mail.gmail.com>
Subject: Re: lttng-dev Digest, Vol 203, Issue 7
To: Kienan Stewart <kstewart@efficios.com>, lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="000000000000c31f030630d9bd43"
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
From: Gour DEV via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Gour DEV <lakshyagour10@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000c31f030630d9bd43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Kienan for digging this and explaining the behaviour,

Looks like this option is not present in the version I am using v2.13.5 and
the MAP_POPULATE is enabled by default there
/* memory_map: mmap */
memory_map =3D mmap(NULL, memory_map_size, PROT_READ | PROT_WRITE,
 MAP_SHARED | LTTNG_MAP_POPULATE, shmfd, 0);

I have updated to the master branch and have verified by setting the
LTTNG_UST_MAP_POPULATE_POLICY=3Dnone, and saw that now the RSS consumption =
is
not very high now.

I think using LTTNG_UST_MAP_POPULATE_POLICY=3Dcpu_possible is better becaus=
e
here I will definitely know how much amount of memory lttng will use at
start only, and allocate memory accordingly to my servers.


Also, I thought using --buffers-global
<https://lttng.org/man/1/lttng-enable-channel/v2.8/#doc-opt--buffers-global=
>
would
be better for me as I could know how much memory will be required but looks
like that option is only available for kernel tracking, it would be very
good if this option could be available for user buffering also, but that
could come later.


But again, thanks for the help Kienan.

Regards
Lakshya.






On Fri, Mar 21, 2025 at 2:21=E2=80=AFAM Kienan Stewart <kstewart@efficios.c=
om>
wrote:

> Hi Lakshya,
>
> I did some digging around. What you are seeing is the result of the
> switching to MAP_POPULATE by default in LTTng-UST 2.12[1] in commit
> 4d4838b ("Use MAP_POPULATE to reduce pagefault when available").
>
> The purpose of this change is to avoid taking page faults which tracing,
> reducing first-event in a page latency.
>
> In the master branch, this feature has been made configurable for users
> who don't want to pre-populate the pages and would rather take page
> faults while tracing[2].
>
> Here is an example from LTTng master with map populate per possible CPU:
>
> ```
> export LTTNG_UST_MAP_POPULATE_POLICY=3Dcpu_possible
>
> # Create session, channels, start tracing, and run test app
> # top -n1 -b | grep -E '(MiB|COMMAND|lttng)'
> MiB Mem :  32768.0 total,  21883.7 free,   1456.0 used,   9428.3
> buff/cache
>
> MiB Swap:      0.0 total,      0.0 free,      0.0 used.  31312.0 avail
> Mem
>
>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
> COMMAND
>
>   301117 debian    20   0  880176   2760   2760 S   0.0   0.0   0:00.04
> lttng-sessiond
>
>   301118 debian    20   0   43856   1376   1376 S   0.0   0.0   0:00.01
> lttng-runas
>
>   301133 debian    20   0  718616 263456 263456 S   0.0   0.8   0:00.17
> lttng-consumerd
>
>   301135 debian    20   0    6996      0      0 S   0.0   0.0   0:00.05
> lttng-runas
>
> # cat /proc/$(pgrep lttng-sessiond)/statm
> lttng-sessiond: 220044 690 690 345 0 29900 0
>
>
>
> # pmap $(pgrep lttng-sessiond) | grep total
>
>   total           880176K
>
> # smem -P lttng-sessiond
>
>
>    PID User     Command                         Swap      USS      PSS
>     RSS
>
> 301118 debian   lttng-sessiond --daemonize         0      344      881
>    2236
>
> 301117 debian   lttng-sessiond --daemonize         0     5676     6683
>    9276
>
> 301201 debian   /usr/bin/python3 /usr/bin/s        0     8636    10086
>   12936
>
>
> # /proc/PID/statm for lttng-consumerd
>
>
>
> lttng-consumerd: 1749 0 0 129 0 130 0
>
> # pmap lttng-consumerd-pid | grep total
> total kB            6996    1700     472
>
>
>
> # smem -P lttng-consumerd
>    PID User     Command                         Swap      USS      PSS
>     RSS
>
> 301135 debian   lttng-consumerd  -u --consu        0      280      563
>    1700
>
> 301211 debian   /usr/bin/python3 /usr/bin/s        0    10048    11501
>   14404
>
> 301133 debian   lttng-consumerd  -u --consu        0   262376   263177
> 265480
>
> # smem -m | grep -i ust
>
> /dev/shm/lttng-ust-wait-8-1000               1        4        4
> /dev/shm/shm-ust-consumer-301133             1   260756   260756
> ```
>
> When using the none policy:
>
> ```
> # export LTTNG_UST_MAP_POPULATE_POLICY=3Dnone
> # as above
>
> Running test app UID 0
>
>
> procs -----------memory---------- ---swap-- -----io---- -system--
> ------cpu-----
>
>   r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy
> id wa st
>
>   1  0      0  21875      0   9434    0    0    39   636 1105 2496  0  1
> 99  0  0
>
> MiB Mem :  32768.0 total,  21875.0 free,   1458.2 used,   9434.7
> buff/cache
>
> MiB Swap:      0.0 total,      0.0 free,      0.0 used.  31309.8 avail
> Mem
>
>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
> COMMAND
>
>   301616 debian    20   0  880176   2756   2756 S   0.0   0.0   0:00.04
> lttng-sessiond
>
>   301617 debian    20   0   43856   1392   1392 S   0.0   0.0   0:00.01
> lttng-runas
>
>   301632 debian    20   0  718612   5416   5416 S   0.0   0.0   0:00.17
> lttng-consumerd
>
>   301634 debian    20   0    6992      0      0 S   0.0   0.0   0:00.05
> lttng-runas
>
> lttng-sessiond: 220044 689 689 345 0 29900 0
>
>
>   total           880176K
>
>
>    PID User     Command                         Swap      USS      PSS
>     RSS
> 301617 debian   lttng-sessiond --daemonize         0      344      862
>    2188
> 301616 debian   lttng-sessiond --daemonize         0     5784     6759
>    9328
> 301700 debian   /usr/bin/python3 /usr/bin/s        0     8632    10079
>   12928
>
> lttng-consumerd: 1748 0 0 129 0 129 0
> total kB            6992    1580     468
>    PID User     Command                         Swap      USS      PSS
>     RSS
> 301634 debian   lttng-consumerd  -u --consu        0      276      536
>    1580
> 301632 debian   lttng-consumerd  -u --consu        0     5672     6433
>    8652
> 301710 debian   /usr/bin/python3 /usr/bin/s        0     9996    11449
>   14328
>
> /dev/shm/lttng-ust-wait-8-1000               1        4        4
> /dev/shm/shm-ust-consumer-301632             1     4048     4048
> ```
>
> thanks,
> kienan
>
> [1]:
>
> https://github.com/lttng/lttng-ust/commit/4d4838bad480d48424bddc686f5ad00=
89e28ac94
> [2]:
>
> https://github.com/lttng/lttng-ust/commit/97572c0438845cee953ebd3e39615f7=
8bfa405a7
>
> On 3/17/25 2:29 AM, Gour DEV wrote:
> > Hi, Kienan
> >
> > Sorry for the late reply.
> >
> > Looks like in buster the memory is allocated by lttng-consumerd reserve=
d
> >
> > I buster, the rss is less than the VIRT
> > root@localhost:~#  COLUMNS=3D500 top  -b -n 1 | grep lttng
> >   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
> COMMAND
> >   4095 root      20   0 1003188  31256   4660 S   0.0   0.1   0:03.81
> > lttng-sessiond
> >   4096 root      20   0   44260    796      0 S   0.0   0.0   0:00.01
> > lttng-runas
> >   4440 root      20   0 5236020  10224   8756 S   0.0   0.0   2:56.25
> > lttng-consumerd -- here the VIRT is much more higher than RSS
> >   4443 root      20   0   48048    540      0 S   0.0   0.0   0:00.12
> > lttng-runas
> >
> >
> >
> > In bookworm the VIRT and RES are nearly the same only.
> > root@edgecore-40XKE-j2-101-32:~# COLUMNS=3D500 top  -b -n 1 | grep lttn=
g
> >   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
> COMMAND
> >     4382 root      20   0 1098824  42600   8436 S   0.0   0.1   0:08.87
> > lttng-sessiond
> >     4403 root      20   0   48928   2116    996 S   0.0   0.0   0:00.00
> > lttng-runas
> >     5171 root      20   0 9879764   8.9g   8.9g S   0.0  28.7 108:23.53
> > lttng-consumerd -- here the VRIT is nearly equal to RSS
> >     5173 root      20   0    3680   1028    680 S   0.0   0.0   0:00.88
> > lttng-runas
> >
> >
> > Looks like lttng consumerd is allocating and reserving those pages, whe=
n
> > any instrumented application starts.
> >
> > I am attaching the lttng status output in the mail, please do tell me i=
f
> > you need any more information regarding this.
> >
> >
> > These is how we used to create the lttng channels and enable event whic=
h
> is
> > same in both buster and bookworm, (number of channels might differ)
> >
> > def enable_channel(channels, session, subbuf_size, subbuf_num):
> > for c in channels:
> > call(['lttng', 'enable-channel', '-u', c, '-s', session, '--subbuf-size=
',
> > str(subbuf_size), '--num-subbuf', str(subbuf_num),],
> > stdout=3Ddevnull, stderr=3Dsubprocess.STDOUT)
> >
> >
> > def enable_events(traces, session):
> > for t in traces:
> > if 'log-level-only' in t:
> > log_opt =3D '--loglevel-only=3D' + t['log-level-only']
> > elif 'log-level' in t:
> > log_opt =3D '--loglevel=3D' + t['log-level']
> > else:
> > log_opt =3D ''
> >
> > else:
> > call(['lttng', 'enable-event', '-u', t['name'], '-c', t['channel'],
> > '-s', session], stdout=3Ddevnull, stderr=3Dsubprocess.STDOUT)
> >
> >
> > Thank You.
> > Lakshya
> >
> >
> >
> >
> > On Wed, Mar 12, 2025 at 8:06=E2=80=AFPM <lttng-dev-request@lists.lttng.=
org>
> wrote:
> >
> >> Send lttng-dev mailing list submissions to
> >>          lttng-dev@lists.lttng.org
> >>
> >> To subscribe or unsubscribe via the World Wide Web, visit
> >>          https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >> or, via email, send a message with subject or body 'help' to
> >>          lttng-dev-request@lists.lttng.org
> >>
> >> You can reach the person managing the list at
> >>          lttng-dev-owner@lists.lttng.org
> >>
> >> When replying, please edit your Subject line so it is more specific
> >> than "Re: Contents of lttng-dev digest..."
> >>
> >>
> >> Today's Topics:
> >>
> >>     1. Re: Memory Consumption High After Upgrading to 2.13 from 2.10
> >>        (Kienan Stewart)
> >>     2. Re: Memory Consumption High After Upgrading to 2.13 from 2.10
> >>        (Gour DEV)
> >>     3. Re: Memory Consumption High After Upgrading to 2.13 from 2.10
> >>        (Kienan Stewart)
> >>
> >>
> >> ----------------------------------------------------------------------
> >>
> >> Message: 1
> >> Date: Tue, 11 Mar 2025 14:55:21 -0400
> >> From: Kienan Stewart <kstewart@efficios.com>
> >> To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
> >> Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
> >> Message-ID: <38dab5ef-f106-4e57-9e36-b4b30015c019@efficios.com>
> >> Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed
> >>
> >> Hi Lakshya,
> >>
> >> On 3/11/25 12:25 PM, Gour DEV wrote:
> >>   > Hi, Kienan
> >>   >
> >>   > here is the requested output
> >>   >
> >>   > root@localhost:~# top -b -n 1 | grep  lttng
> >>   >     4841 root      20   0   11.5g  11.0g  11.0g S   5.9  35.4
>  8:39.93
> >>   > lttng-c+
> >>   >     4824 root      20   0 1098824  26456   5380 S   0.0   0.1
>  0:07.25
> >>   > lttng-s+
> >>   >     4825 root      20   0   48872   2188   1012 S   0.0   0.0
>  0:00.00
> >>   > lttng-r+
> >>   >     4843 root      20   0    3680   1160    816 S   0.0   0.0
>  0:00.23
> >>
> >> This top output for `localhost` seems very different than the output f=
or
> >> `localhost` in your previous message.
> >>
> >>
> >>   > lttng-r+
> >>   > root@localhost:~# nrpco
> >>   > bash: nrpco: command not found
> >>   > root@localhost:~# nproc
> >>   > 16
> >>   > root@localhost:~# cat /sys/devices/system/cpu/possible
> >>   > 0-15
> >>   >
> >>
> >> You indicated the bookworm machine has 32 cores, this is showing 16. I=
f
> >> you're comparing a 16 core machine to a 32 core machine, it is very
> >> normal that the memory usage is higher on the 32 core machine.
> >>
> >>   >
> >>   > Most of the process are running as asorcs user but some are runnin=
g
> >> as root.
> >>
> >> So you have two users with instrumented applications.
> >>
> >>
> >> Given the discrepancies in the information provided I'm finding it a b=
it
> >> hard to understand what you're looking at.
> >>
> >>
> >> In general, a channel's shared memory footprint can be estimated
> with[1]:
> >>
> >>     (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) =
*
> >> (nUIDs or nPIDs)
> >>
> >> Note that the sub-buffer sizes you are using get rounded to the neares=
t
> >> larger power of 2. See [2].
> >>
> >> thanks,
> >> kienan
> >>
> >> [1]: https://lttng.org/docs/v2.13/#doc-channel-buffering-schemes
> >> [2]:
> >>
> https://lttng.org/man/1/lttng-enable-channel/v2.13/#doc-opt--subbuf-size
> >>
> >>
> >> ------------------------------
> >>
> >> Message: 2
> >> Date: Wed, 12 Mar 2025 14:49:07 +0530
> >> From: Gour DEV <lakshyagour10@gmail.com>
> >> To: Kienan Stewart <kstewart@efficios.com>
> >> Cc: lttng-dev@lists.lttng.org
> >> Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
> >> Message-ID:
> >>          <CAE9Jrzg7qsabhPiO-0=3DB1DY3bVo-3FYu2tiJR2Bmb=3D
> >> nqOHNZMw@mail.gmail.com>
> >> Content-Type: text/plain; charset=3D"utf-8"
> >>
> >> Hi, Kienan
> >>
> >> I am attaching an screen recording of the behaviour I am seeing in thi=
s
> >> mail. The behaviour is same irrespective of the device i use, sorry fo=
r
> >> miscommunication in the npocs output (I assumed it was 32), but other
> than
> >> that all outputs are same (except the hostname as there are multiple
> >> devices with same lttng config but this memory cosumption is seen on a=
ll
> >> the devices).
> >>
> >> I had few question
> >>
> >> 1. Does lltng allocated all the memory it needs and mark it as dirty i=
n
> ram
> >> when any process which links/uses lttng-ust runs? (here i tried with o=
ne
> >> process but it is same for any of my process)
> >> 2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
> >> (nUIDs or nPIDs)
> >>
> >> How do we calculate uid in the system is it all uids in the system? is
> it
> >> equal to `cat /etc/passwd | wc -l` ?
> >>
> >> I will put my calculations according to the above estimate based on al=
l
> the
> >> channel i am creating
> >>
> >> (4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are equal
> to
> >> `cat /etc/passwd | wc -l`)B =3D 7.998046875 GB approx [this is based o=
n
> the
> >> start_lttng.py please do correct me if am wrong here.]
> >>
> >> But since there are only two users which uses lttng i think the correc=
t
> >> estimate would be
> >> (4194304*4 + 262144*4 + 16384*4) * (16) * (2)B =3D 546MB
> >>
> >> Please do correct me If I am wrong calculations here.
> >>
> >> Now, there are a few things here, according to my output lttng is usin=
g
> 11G
> >> which is much more higher than the what is configured.
> >>
> >> I am attaching the lttng status and the file which is uses to create t=
he
> >> lttng sessions.
> >>
> >>
> >>
> >> Thank You.
> >>
> >>
> >>
> >>
> https://drive.google.com/file/d/1tS_ZWEsXDpHZXfWzZHXmWcT0igiIOIaa/view?us=
p=3Dsharing
> >> -- recording of the behaviour which is seen
> >>
> >>
> https://drive.google.com/file/d/1PrU31oyEw1n9tKETlUtmNGO50s6ywx7p/view?us=
p=3Dsharing
> >> -- the file which is used to create lttng sessions
> >>
> >>
> >> On Wed, Mar 12, 2025 at 12:25?AM Kienan Stewart <kstewart@efficios.com=
>
> >> wrote:
> >>
> >>> Hi Lakshya,
> >>>
> >>> On 3/11/25 12:25 PM, Gour DEV wrote:
> >>>   > Hi, Kienan
> >>>   >
> >>>   > here is the requested output
> >>>   >
> >>>   > root@localhost:~# top -b -n 1 | grep  lttng
> >>>   >     4841 root      20   0   11.5g  11.0g  11.0g S   5.9  35.4
> >>   8:39.93
> >>>   > lttng-c+
> >>>   >     4824 root      20   0 1098824  26456   5380 S   0.0   0.1
> >>   0:07.25
> >>>   > lttng-s+
> >>>   >     4825 root      20   0   48872   2188   1012 S   0.0   0.0
> >>   0:00.00
> >>>   > lttng-r+
> >>>   >     4843 root      20   0    3680   1160    816 S   0.0   0.0
> >>   0:00.23
> >>>
> >>> This top output for `localhost` seems very different than the output
> for
> >>> `localhost` in your previous message.
> >>>
> >>>
> >>>   > lttng-r+
> >>>   > root@localhost:~# nrpco
> >>>   > bash: nrpco: command not found
> >>>   > root@localhost:~# nproc
> >>>   > 16
> >>>   > root@localhost:~# cat /sys/devices/system/cpu/possible
> >>>   > 0-15
> >>>   >
> >>>
> >>> You indicated the bookworm machine has 32 cores, this is showing 16. =
If
> >>> you're comparing a 16 core machine to a 32 core machine, it is very
> >>> normal that the memory usage is higher on the 32 core machine.
> >>>
> >>>   >
> >>>   > Most of the process are running as asorcs user but some are runni=
ng
> >>> as root.
> >>>
> >>> So you have two users with instrumented applications.
> >>>
> >>>
> >>> Given the discrepancies in the information provided I'm finding it a
> bit
> >>> hard to understand what you're looking at.
> >>>
> >>>
> >>> In general, a channel's shared memory footprint can be estimated
> with[1]:
> >>>
> >>>     (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled)=
 *
> >>> (nUIDs or nPIDs)
> >>>
> >>> Note that the sub-buffer sizes you are using get rounded to the neare=
st
> >>> larger power of 2. See [2].
> >>>
> >>> thanks,
> >>> kienan
> >>>
> >>> [1]: https://lttng.org/docs/v2.13/#doc-channel-buffering-schemes
> >>> [2]:
> >>>
> https://lttng.org/man/1/lttng-enable-channel/v2.13/#doc-opt--subbuf-size
> >>>
> >> -------------- next part --------------
> >> An HTML attachment was scrubbed...
> >> URL: <
> >>
> https://lists.lttng.org/pipermail/lttng-dev/attachments/20250312/57f240d8=
/attachment-0001.htm
> >>>
> >>
> >> ------------------------------
> >>
> >> Message: 3
> >> Date: Wed, 12 Mar 2025 10:36:28 -0400
> >> From: Kienan Stewart <kstewart@efficios.com>
> >> To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
> >> Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
> >> Message-ID: <0f819583-ea8e-468e-9102-e1410d886a6f@efficios.com>
> >> Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed
> >>
> >> Hi Lakshya,
> >>
> >> On 3/12/25 5:03 AM, Gour DEV wrote:
> >>> Hi, Kienan
> >>>
> >>> I am attaching an screen recording of the behaviour I am seeing in th=
is
> >>> mail. The behaviour is same irrespective of the device i use, sorry f=
or
> >>> miscommunication in the npocs output (I assumed it was 32), but other
> >> than
> >>> that all outputs are same (except the hostname as there are multiple
> >>> devices with same lttng config but this memory cosumption is seen on
> all
> >>> the devices).
> >>>
> >>> I had few question
> >>>
> >>> 1. Does lltng allocated all the memory it needs and mark it as dirty =
in
> >> ram
> >>> when any process which links/uses lttng-ust runs? (here i tried with
> one
> >>> process but it is same for any of my process)
> >>
> >> I believe the shared memory for per-CPU data structures is allocated
> >> when an instrumented application connects. There is no pre-allocation
> >> for each possible UID on the system.
> >>
> >> You can run your instrumented applications with `LTTNG_UST_DEBUG=3D1` =
to
> >> see when the connection happens[1].
> >>
> >>> 2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) =
*
> >>> (nUIDs or nPIDs)
> >>>
> >>> How do we calculate uid in the system is it all uids in the system? i=
s
> it
> >>> equal to `cat /etc/passwd | wc -l` ?
> >>
> >> nUIDs is the number of distinct UIDs running instrumented applications=
.
> >>
> >>>
> >>> I will put my calculations according to the above estimate based on a=
ll
> >> the
> >>> channel i am creating
> >>>
> >>> (4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are equa=
l
> to
> >>> `cat /etc/passwd | wc -l`)B =3D 7.998046875 GB approx [this is based =
on
> the
> >>> start_lttng.py please do correct me if am wrong here.]
> >>>
> >>> But since there are only two users which uses lttng i think the corre=
ct
> >>> estimate would be
> >>> (4194304*4 + 262144*4 + 16384*4) * (16) * (2)B =3D 546MB
> >>
> >> The estimate I gave is per-channel.
> >>
> >> small channel: (0.015625 MiB * 4) * (16 + 1) =3D 1.0625 MiB per-channe=
l
> >> per-UID
> >> medium channel: (0.250 MiB * 4) * (16 + 1) =3D 17.0 MiB per-channel
> per-UID
> >> large channel: (4 MiB * 4) * (16 + 1) =3D 27 2MiB per-channel per-UID
> >>
> >> Now, you said you have 0 small channels, 6 medium channels, and 16 lar=
ge
> >> channels in your session. (Note: I see your script differs from these
> >> stated channel counts).
> >>
> >> small: 0 * 1.0625 MiB =3D 0 MiB per-UID
> >> medium: 6 * 17 MiB =3D 102 MiB per-UID
> >> large: 16 * 272 MiB =3D 4352 MiB per-UID
> >>
> >> And if you're running instrumented applications with 2 users:
> >>
> >> small: 0 MiB * 2 =3D 0 MiB with 2 UIDs
> >> medium: 102 MiB * 2 =3D 204 MiB with 2 UIDs
> >> large: 4352 MiB * 2 =3D 8704 MiB with 2 UIDs
> >>
> >> Now this is just an estimation for the per-CPU ring buffers only, and
> >> you numbers aren't hugely off so without analyzing your specific syste=
m
> >> it doesn't seem to be that strange to me.
> >>
> >> If I take the number of channels I see in your script, it becomes:
> >>
> >> small: 0 MiB with 2 UIDs
> >> medium: 136 MiB with 2 UIDs
> >> large: 7616 MiB with 2 UIDs
> >>
> >> total: 7.57 GiB with 2 UIDs
> >>
> >>>
> >>> Please do correct me If I am wrong calculations here.
> >>>
> >>> Now, there are a few things here, according to my output lttng is usi=
ng
> >> 11G
> >>> which is much more higher than the what is configured.
> >>>
> >>
> >> I have no idea what 'service start spyder' is doing. Maybe it's runnin=
g
> >> instrumented applications with an extra user that you didn't expect? I
> >> can't help you with that aspect of your system.
> >>
> >> The above estimated 7.57 GiB with 2 UIDs would be 11.35 GiB with 3 UID=
s
> >> so maybe?
> >>
> >> I'd recommend you read your verbose sessiond log so see which
> >> applications are connecting and with which UIDs.
> >>
> >>> I am attaching the lttng status and the file which is uses to create
> the
> >>> lttng sessions.
> >>>
> >>>
> >>>
> >>> Thank You.
> >>>
> >>
> >> In any case, the information you have given to date hasn't demonstrate=
d
> >> to me in a tangible manner that you are seeing a difference related to
> >> the version of LTTng being used.
> >>
> >> thanks,
> >> kienan
> >>
> >> [1]:
> https://lttng.org/man/3/lttng-ust/v2.13/#doc-_environment_variables
> >>
> >>
> >> ------------------------------
> >>
> >> Subject: Digest Footer
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>
> >>
> >> ------------------------------
> >>
> >> End of lttng-dev Digest, Vol 203, Issue 7
> >> *****************************************
> >>
> >
>
>

--000000000000c31f030630d9bd43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks=C2=A0Kienan for digging this and explaining the beh=
aviour,<br><br>Looks like this option is not present in the version I am us=
ing v2.13.5 and the MAP_POPULATE is enabled by default there<br>/* memory_m=
ap: mmap */<br>	memory_map =3D mmap(NULL, memory_map_size, PROT_READ | PROT=
_WRITE,<br>			 =C2=A0MAP_SHARED | LTTNG_MAP_POPULATE, shmfd, 0);<br><br>I h=
ave updated to the master branch and have verified by setting the LTTNG_UST=
_MAP_POPULATE_POLICY=3Dnone, and saw that now the RSS consumption is not ve=
ry high now.<br><br>I think using LTTNG_UST_MAP_POPULATE_POLICY=3Dcpu_possi=
ble is better because here I will definitely=C2=A0know how much amount of m=
emory lttng will use at start only, and allocate memory=C2=A0accordingly to=
 my servers.<br><br><br>Also, I thought using=C2=A0<code class=3D"gmail-opt=
ion" style=3D"margin:0px 1px;padding:0px;border:0px;font-variant-numeric:in=
herit;font-variant-east-asian:inherit;font-variant-alternates:inherit;font-=
weight:700;font-stretch:inherit;font-size:12.96px;line-height:inherit;font-=
family:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Bitstream V=
era Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nimbus Mono L&quot;,&=
quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Console&quot;,&quot;Luc=
ida Sans Typewriter&quot;,&quot;Courier New&quot;,Courier,monospace;font-si=
ze-adjust:inherit;font-kerning:inherit;font-feature-settings:inherit;vertic=
al-align:baseline;background-color:rgb(253,253,253);color:rgb(25,25,25)"><a=
 href=3D"https://lttng.org/man/1/lttng-enable-channel/v2.8/#doc-opt--buffer=
s-global" style=3D"margin:0px;padding:0px;text-decoration-line:none;border:=
0px;font:inherit;vertical-align:baseline;outline:0px;color:rgb(52,152,219)"=
>--buffers-global</a></code>=C2=A0would be better for me as I could know=C2=
=A0how much memory will be required but looks like that option is only avai=
lable for kernel tracking, it would be very good if this option could be av=
ailable for user buffering also, but that could come later.<br><br><br>But =
again, thanks for the help Kienan.<br><br>Regards<br>Lakshya.<br><br><br>=
=C2=A0<br><br><br></div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 21, 2025 at 2:21=E2=80=
=AFAM Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com">kstewart@=
efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Hi Lakshya,<br>
<br>
I did some digging around. What you are seeing is the result of the <br>
switching to MAP_POPULATE by default in LTTng-UST 2.12[1] in commit <br>
4d4838b (&quot;Use MAP_POPULATE to reduce pagefault when available&quot;).<=
br>
<br>
The purpose of this change is to avoid taking page faults which tracing, <b=
r>
reducing first-event in a page latency.<br>
<br>
In the master branch, this feature has been made configurable for users <br=
>
who don&#39;t want to pre-populate the pages and would rather take page <br=
>
faults while tracing[2].<br>
<br>
Here is an example from LTTng master with map populate per possible CPU:<br=
>
<br>
```<br>
export LTTNG_UST_MAP_POPULATE_POLICY=3Dcpu_possible<br>
<br>
# Create session, channels, start tracing, and run test app<br>
# top -n1 -b | grep -E &#39;(MiB|COMMAND|lttng)&#39;<br>
MiB Mem :=C2=A0 32768.0 total,=C2=A0 21883.7 free,=C2=A0 =C2=A01456.0 used,=
=C2=A0 =C2=A09428.3 <br>
buff/cache <br>
<br>
MiB Swap:=C2=A0 =C2=A0 =C2=A0 0.0 total,=C2=A0 =C2=A0 =C2=A0 0.0 free,=C2=
=A0 =C2=A0 =C2=A0 0.0 used.=C2=A0 31312.0 avail <br>
Mem <br>
<br>
=C2=A0 =C2=A0 =C2=A0PID USER=C2=A0 =C2=A0 =C2=A0 PR=C2=A0 NI=C2=A0 =C2=A0 V=
IRT=C2=A0 =C2=A0 RES=C2=A0 =C2=A0 SHR S=C2=A0 %CPU=C2=A0 %MEM=C2=A0 =C2=A0 =
=C2=A0TIME+ <br>
COMMAND <br>
<br>
=C2=A0 301117 debian=C2=A0 =C2=A0 20=C2=A0 =C2=A00=C2=A0 880176=C2=A0 =C2=
=A02760=C2=A0 =C2=A02760 S=C2=A0 =C2=A00.0=C2=A0 =C2=A00.0=C2=A0 =C2=A00:00=
.04 <br>
lttng-sessiond <br>
<br>
=C2=A0 301118 debian=C2=A0 =C2=A0 20=C2=A0 =C2=A00=C2=A0 =C2=A043856=C2=A0 =
=C2=A01376=C2=A0 =C2=A01376 S=C2=A0 =C2=A00.0=C2=A0 =C2=A00.0=C2=A0 =C2=A00=
:00.01 <br>
lttng-runas <br>
<br>
=C2=A0 301133 debian=C2=A0 =C2=A0 20=C2=A0 =C2=A00=C2=A0 718616 263456 2634=
56 S=C2=A0 =C2=A00.0=C2=A0 =C2=A00.8=C2=A0 =C2=A00:00.17 <br>
lttng-consumerd <br>
<br>
=C2=A0 301135 debian=C2=A0 =C2=A0 20=C2=A0 =C2=A00=C2=A0 =C2=A0 6996=C2=A0 =
=C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 0 S=C2=A0 =C2=A00.0=C2=A0 =C2=A00.0=C2=
=A0 =C2=A00:00.05 <br>
lttng-runas<br>
<br>
# cat /proc/$(pgrep lttng-sessiond)/statm<br>
lttng-sessiond: 220044 690 690 345 0 29900 0 <br>
<br>
<br>
<br>
# pmap $(pgrep lttng-sessiond) | grep total <br>
<br>
=C2=A0 total=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0880176K<br>
<br>
# smem -P lttng-sessiond <br>
<br>
<br>
=C2=A0 =C2=A0PID User=C2=A0 =C2=A0 =C2=A0Command=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Swap=C2=A0 =
=C2=A0 =C2=A0 USS=C2=A0 =C2=A0 =C2=A0 PSS <br>
=C2=A0 =C2=A0 RSS <br>
<br>
301118 debian=C2=A0 =C2=A0lttng-sessiond --daemonize=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0 344=C2=A0 =C2=A0 =C2=A0 881 <br>
=C2=A0 =C2=A02236 <br>
<br>
301117 debian=C2=A0 =C2=A0lttng-sessiond --daemonize=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A05676=C2=A0 =C2=A0 =C2=A06683 <br>
=C2=A0 =C2=A09276 <br>
<br>
301201 debian=C2=A0 =C2=A0/usr/bin/python3 /usr/bin/s=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0=C2=A0 =C2=A0 =C2=A08636=C2=A0 =C2=A0 10086 <br>
=C2=A0 12936 <br>
<br>
<br>
# /proc/PID/statm for lttng-consumerd <br>
<br>
<br>
<br>
lttng-consumerd: 1749 0 0 129 0 130 0<br>
<br>
# pmap lttng-consumerd-pid | grep total<br>
total kB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6996=C2=A0 =C2=A0 1700=C2=
=A0 =C2=A0 =C2=A0472 <br>
<br>
<br>
<br>
# smem -P lttng-consumerd<br>
=C2=A0 =C2=A0PID User=C2=A0 =C2=A0 =C2=A0Command=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Swap=C2=A0 =
=C2=A0 =C2=A0 USS=C2=A0 =C2=A0 =C2=A0 PSS <br>
=C2=A0 =C2=A0 RSS <br>
<br>
301135 debian=C2=A0 =C2=A0lttng-consumerd=C2=A0 -u --consu=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 280=C2=A0 =C2=A0 =C2=A0 563 <br>
=C2=A0 =C2=A01700 <br>
<br>
301211 debian=C2=A0 =C2=A0/usr/bin/python3 /usr/bin/s=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0=C2=A0 =C2=A0 10048=C2=A0 =C2=A0 11501 <br>
=C2=A0 14404 <br>
<br>
301133 debian=C2=A0 =C2=A0lttng-consumerd=C2=A0 -u --consu=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0=C2=A0 =C2=A0262376=C2=A0 =C2=A0263177 <br>
265480<br>
<br>
# smem -m | grep -i ust <br>
<br>
/dev/shm/lttng-ust-wait-8-1000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01=C2=A0 =C2=A0 =C2=A0 =C2=A0 4=C2=A0 =C2=A0 =C2=A0 =C2=A0 4<br>
/dev/shm/shm-ust-consumer-301133=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A01=C2=A0 =C2=A0260756=C2=A0 =C2=A0260756<br>
```<br>
<br>
When using the none policy:<br>
<br>
```<br>
# export LTTNG_UST_MAP_POPULATE_POLICY=3Dnone<br>
# as above<br>
<br>
Running test app UID 0 <br>
<br>
<br>
procs -----------memory---------- ---swap-- -----io---- -system-- <br>
------cpu----- <br>
<br>
=C2=A0 r=C2=A0 b=C2=A0 =C2=A0swpd=C2=A0 =C2=A0free=C2=A0 =C2=A0buff=C2=A0 c=
ache=C2=A0 =C2=A0si=C2=A0 =C2=A0so=C2=A0 =C2=A0 bi=C2=A0 =C2=A0 bo=C2=A0 =
=C2=A0in=C2=A0 =C2=A0cs us sy <br>
id wa st <br>
<br>
=C2=A0 1=C2=A0 0=C2=A0 =C2=A0 =C2=A0 0=C2=A0 21875=C2=A0 =C2=A0 =C2=A0 0=C2=
=A0 =C2=A09434=C2=A0 =C2=A0 0=C2=A0 =C2=A0 0=C2=A0 =C2=A0 39=C2=A0 =C2=A063=
6 1105 2496=C2=A0 0=C2=A0 1 <br>
99=C2=A0 0=C2=A0 0 <br>
<br>
MiB Mem :=C2=A0 32768.0 total,=C2=A0 21875.0 free,=C2=A0 =C2=A01458.2 used,=
=C2=A0 =C2=A09434.7 <br>
buff/cache <br>
<br>
MiB Swap:=C2=A0 =C2=A0 =C2=A0 0.0 total,=C2=A0 =C2=A0 =C2=A0 0.0 free,=C2=
=A0 =C2=A0 =C2=A0 0.0 used.=C2=A0 31309.8 avail <br>
Mem <br>
<br>
=C2=A0 =C2=A0 =C2=A0PID USER=C2=A0 =C2=A0 =C2=A0 PR=C2=A0 NI=C2=A0 =C2=A0 V=
IRT=C2=A0 =C2=A0 RES=C2=A0 =C2=A0 SHR S=C2=A0 %CPU=C2=A0 %MEM=C2=A0 =C2=A0 =
=C2=A0TIME+ <br>
COMMAND <br>
<br>
=C2=A0 301616 debian=C2=A0 =C2=A0 20=C2=A0 =C2=A00=C2=A0 880176=C2=A0 =C2=
=A02756=C2=A0 =C2=A02756 S=C2=A0 =C2=A00.0=C2=A0 =C2=A00.0=C2=A0 =C2=A00:00=
.04 <br>
lttng-sessiond <br>
<br>
=C2=A0 301617 debian=C2=A0 =C2=A0 20=C2=A0 =C2=A00=C2=A0 =C2=A043856=C2=A0 =
=C2=A01392=C2=A0 =C2=A01392 S=C2=A0 =C2=A00.0=C2=A0 =C2=A00.0=C2=A0 =C2=A00=
:00.01 <br>
lttng-runas <br>
<br>
=C2=A0 301632 debian=C2=A0 =C2=A0 20=C2=A0 =C2=A00=C2=A0 718612=C2=A0 =C2=
=A05416=C2=A0 =C2=A05416 S=C2=A0 =C2=A00.0=C2=A0 =C2=A00.0=C2=A0 =C2=A00:00=
.17 <br>
lttng-consumerd <br>
<br>
=C2=A0 301634 debian=C2=A0 =C2=A0 20=C2=A0 =C2=A00=C2=A0 =C2=A0 6992=C2=A0 =
=C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 0 S=C2=A0 =C2=A00.0=C2=A0 =C2=A00.0=C2=
=A0 =C2=A00:00.05 <br>
lttng-runas <br>
<br>
lttng-sessiond: 220044 689 689 345 0 29900 0 <br>
<br>
<br>
=C2=A0 total=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0880176K <br>
<br>
<br>
=C2=A0 =C2=A0PID User=C2=A0 =C2=A0 =C2=A0Command=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Swap=C2=A0 =
=C2=A0 =C2=A0 USS=C2=A0 =C2=A0 =C2=A0 PSS <br>
=C2=A0 =C2=A0 RSS<br>
301617 debian=C2=A0 =C2=A0lttng-sessiond --daemonize=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0 344=C2=A0 =C2=A0 =C2=A0 862 <br>
=C2=A0 =C2=A02188<br>
301616 debian=C2=A0 =C2=A0lttng-sessiond --daemonize=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A05784=C2=A0 =C2=A0 =C2=A06759 <br>
=C2=A0 =C2=A09328<br>
301700 debian=C2=A0 =C2=A0/usr/bin/python3 /usr/bin/s=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0=C2=A0 =C2=A0 =C2=A08632=C2=A0 =C2=A0 10079 <br>
=C2=A0 12928<br>
<br>
lttng-consumerd: 1748 0 0 129 0 129 0<br>
total kB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6992=C2=A0 =C2=A0 1580=C2=
=A0 =C2=A0 =C2=A0468<br>
=C2=A0 =C2=A0PID User=C2=A0 =C2=A0 =C2=A0Command=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Swap=C2=A0 =
=C2=A0 =C2=A0 USS=C2=A0 =C2=A0 =C2=A0 PSS <br>
=C2=A0 =C2=A0 RSS<br>
301634 debian=C2=A0 =C2=A0lttng-consumerd=C2=A0 -u --consu=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 276=C2=A0 =C2=A0 =C2=A0 536 <br>
=C2=A0 =C2=A01580<br>
301632 debian=C2=A0 =C2=A0lttng-consumerd=C2=A0 -u --consu=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A05672=C2=A0 =C2=A0 =C2=A06433 <br>
=C2=A0 =C2=A08652<br>
301710 debian=C2=A0 =C2=A0/usr/bin/python3 /usr/bin/s=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0=C2=A0 =C2=A0 =C2=A09996=C2=A0 =C2=A0 11449 <br>
=C2=A0 14328<br>
<br>
/dev/shm/lttng-ust-wait-8-1000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01=C2=A0 =C2=A0 =C2=A0 =C2=A0 4=C2=A0 =C2=A0 =C2=A0 =C2=A0 4<br>
/dev/shm/shm-ust-consumer-301632=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A01=C2=A0 =C2=A0 =C2=A04048=C2=A0 =C2=A0 =C2=A04048<br>
```<br>
<br>
thanks,<br>
kienan<br>
<br>
[1]: <br>
<a href=3D"https://github.com/lttng/lttng-ust/commit/4d4838bad480d48424bddc=
686f5ad0089e28ac94" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/lttng/lttng-ust/commit/4d4838bad480d48424bddc686f5ad0089e28ac94</a><br>
[2]: <br>
<a href=3D"https://github.com/lttng/lttng-ust/commit/97572c0438845cee953ebd=
3e39615f78bfa405a7" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/lttng/lttng-ust/commit/97572c0438845cee953ebd3e39615f78bfa405a7</a><br>
<br>
On 3/17/25 2:29 AM, Gour DEV wrote:<br>
&gt; Hi, Kienan<br>
&gt; <br>
&gt; Sorry for the late reply.<br>
&gt; <br>
&gt; Looks like in buster the memory is allocated by lttng-consumerd reserv=
ed<br>
&gt; <br>
&gt; I buster, the rss is less than the VIRT<br>
&gt; root@localhost:~#=C2=A0 COLUMNS=3D500 top=C2=A0 -b -n 1 | grep lttng<b=
r>
&gt;=C2=A0 =C2=A0PID USER=C2=A0 =C2=A0 =C2=A0 PR=C2=A0 NI=C2=A0 =C2=A0 VIRT=
=C2=A0 =C2=A0 RES=C2=A0 =C2=A0 SHR S=C2=A0 %CPU=C2=A0 %MEM=C2=A0 =C2=A0 =C2=
=A0TIME+ COMMAND<br>
&gt;=C2=A0 =C2=A04095 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A00 1003188=C2=
=A0 31256=C2=A0 =C2=A04660 S=C2=A0 =C2=A00.0=C2=A0 =C2=A00.1=C2=A0 =C2=A00:=
03.81<br>
&gt; lttng-sessiond<br>
&gt;=C2=A0 =C2=A04096 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A00=C2=A0 =C2=
=A044260=C2=A0 =C2=A0 796=C2=A0 =C2=A0 =C2=A0 0 S=C2=A0 =C2=A00.0=C2=A0 =C2=
=A00.0=C2=A0 =C2=A00:00.01<br>
&gt; lttng-runas<br>
&gt;=C2=A0 =C2=A04440 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A00 5236020=C2=
=A0 10224=C2=A0 =C2=A08756 S=C2=A0 =C2=A00.0=C2=A0 =C2=A00.0=C2=A0 =C2=A02:=
56.25<br>
&gt; lttng-consumerd -- here the VIRT is much more higher than RSS<br>
&gt;=C2=A0 =C2=A04443 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A00=C2=A0 =C2=
=A048048=C2=A0 =C2=A0 540=C2=A0 =C2=A0 =C2=A0 0 S=C2=A0 =C2=A00.0=C2=A0 =C2=
=A00.0=C2=A0 =C2=A00:00.12<br>
&gt; lttng-runas<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; In bookworm the VIRT and RES are nearly the same only.<br>
&gt; root@edgecore-40XKE-j2-101-32:~# COLUMNS=3D500 top=C2=A0 -b -n 1 | gre=
p lttng<br>
&gt;=C2=A0 =C2=A0PID USER=C2=A0 =C2=A0 =C2=A0 PR=C2=A0 NI=C2=A0 =C2=A0 VIRT=
=C2=A0 =C2=A0 RES=C2=A0 =C2=A0 SHR S=C2=A0 %CPU=C2=A0 %MEM=C2=A0 =C2=A0 =C2=
=A0TIME+ COMMAND<br>
&gt;=C2=A0 =C2=A0 =C2=A04382 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A00 1098=
824=C2=A0 42600=C2=A0 =C2=A08436 S=C2=A0 =C2=A00.0=C2=A0 =C2=A00.1=C2=A0 =
=C2=A00:08.87<br>
&gt; lttng-sessiond<br>
&gt;=C2=A0 =C2=A0 =C2=A04403 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A00=C2=
=A0 =C2=A048928=C2=A0 =C2=A02116=C2=A0 =C2=A0 996 S=C2=A0 =C2=A00.0=C2=A0 =
=C2=A00.0=C2=A0 =C2=A00:00.00<br>
&gt; lttng-runas<br>
&gt;=C2=A0 =C2=A0 =C2=A05171 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A00 9879=
764=C2=A0 =C2=A08.9g=C2=A0 =C2=A08.9g S=C2=A0 =C2=A00.0=C2=A0 28.7 108:23.5=
3<br>
&gt; lttng-consumerd -- here the VRIT is nearly equal to RSS<br>
&gt;=C2=A0 =C2=A0 =C2=A05173 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A00=C2=
=A0 =C2=A0 3680=C2=A0 =C2=A01028=C2=A0 =C2=A0 680 S=C2=A0 =C2=A00.0=C2=A0 =
=C2=A00.0=C2=A0 =C2=A00:00.88<br>
&gt; lttng-runas<br>
&gt; <br>
&gt; <br>
&gt; Looks like lttng consumerd is allocating and reserving those pages, wh=
en<br>
&gt; any instrumented application starts.<br>
&gt; <br>
&gt; I am attaching the lttng status output in the mail, please do tell me =
if<br>
&gt; you need any more information regarding this.<br>
&gt; <br>
&gt; <br>
&gt; These is how we used to create the lttng channels and enable event whi=
ch is<br>
&gt; same in both buster and bookworm, (number of channels might differ)<br=
>
&gt; <br>
&gt; def enable_channel(channels, session, subbuf_size, subbuf_num):<br>
&gt; for c in channels:<br>
&gt; call([&#39;lttng&#39;, &#39;enable-channel&#39;, &#39;-u&#39;, c, &#39=
;-s&#39;, session, &#39;--subbuf-size&#39;,<br>
&gt; str(subbuf_size), &#39;--num-subbuf&#39;, str(subbuf_num),],<br>
&gt; stdout=3Ddevnull, stderr=3Dsubprocess.STDOUT)<br>
&gt; <br>
&gt; <br>
&gt; def enable_events(traces, session):<br>
&gt; for t in traces:<br>
&gt; if &#39;log-level-only&#39; in t:<br>
&gt; log_opt =3D &#39;--loglevel-only=3D&#39; + t[&#39;log-level-only&#39;]=
<br>
&gt; elif &#39;log-level&#39; in t:<br>
&gt; log_opt =3D &#39;--loglevel=3D&#39; + t[&#39;log-level&#39;]<br>
&gt; else:<br>
&gt; log_opt =3D &#39;&#39;<br>
&gt; <br>
&gt; else:<br>
&gt; call([&#39;lttng&#39;, &#39;enable-event&#39;, &#39;-u&#39;, t[&#39;na=
me&#39;], &#39;-c&#39;, t[&#39;channel&#39;],<br>
&gt; &#39;-s&#39;, session], stdout=3Ddevnull, stderr=3Dsubprocess.STDOUT)<=
br>
&gt; <br>
&gt; <br>
&gt; Thank You.<br>
&gt; Lakshya<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On Wed, Mar 12, 2025 at 8:06=E2=80=AFPM &lt;<a href=3D"mailto:lttng-de=
v-request@lists.lttng.org" target=3D"_blank">lttng-dev-request@lists.lttng.=
org</a>&gt; wrote:<br>
&gt; <br>
&gt;&gt; Send lttng-dev mailing list submissions to<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev@list=
s.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br>
&gt;&gt;<br>
&gt;&gt; To subscribe or unsubscribe via the World Wide Web, visit<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.lttng.o=
rg/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank"=
>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt;&gt; or, via email, send a message with subject or body &#39;help&#39; =
to<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev-requ=
est@lists.lttng.org" target=3D"_blank">lttng-dev-request@lists.lttng.org</a=
><br>
&gt;&gt;<br>
&gt;&gt; You can reach the person managing the list at<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev-owne=
r@lists.lttng.org" target=3D"_blank">lttng-dev-owner@lists.lttng.org</a><br=
>
&gt;&gt;<br>
&gt;&gt; When replying, please edit your Subject line so it is more specifi=
c<br>
&gt;&gt; than &quot;Re: Contents of lttng-dev digest...&quot;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Today&#39;s Topics:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A01. Re: Memory Consumption High After Upgrading =
to 2.13 from 2.10<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 (Kienan Stewart)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A02. Re: Memory Consumption High After Upgrading =
to 2.13 from 2.10<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 (Gour DEV)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A03. Re: Memory Consumption High After Upgrading =
to 2.13 from 2.10<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 (Kienan Stewart)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ------------------------------------------------------------------=
----<br>
&gt;&gt;<br>
&gt;&gt; Message: 1<br>
&gt;&gt; Date: Tue, 11 Mar 2025 14:55:21 -0400<br>
&gt;&gt; From: Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com" =
target=3D"_blank">kstewart@efficios.com</a>&gt;<br>
&gt;&gt; To: Gour DEV &lt;<a href=3D"mailto:lakshyagour10@gmail.com" target=
=3D"_blank">lakshyagour10@gmail.com</a>&gt;, <a href=3D"mailto:lttng-dev@li=
sts.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br>
&gt;&gt; Subject: Re: Memory Consumption High After Upgrading to 2.13 from =
2.10<br>
&gt;&gt; Message-ID: &lt;<a href=3D"mailto:38dab5ef-f106-4e57-9e36-b4b30015=
c019@efficios.com" target=3D"_blank">38dab5ef-f106-4e57-9e36-b4b30015c019@e=
fficios.com</a>&gt;<br>
&gt;&gt; Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed<br>
&gt;&gt;<br>
&gt;&gt; Hi Lakshya,<br>
&gt;&gt;<br>
&gt;&gt; On 3/11/25 12:25 PM, Gour DEV wrote:<br>
&gt;&gt;=C2=A0 =C2=A0&gt; Hi, Kienan<br>
&gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0&gt; here is the requested output<br>
&gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0&gt; root@localhost:~# top -b -n 1 | grep=C2=A0 lttng<=
br>
&gt;&gt;=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A04841 root=C2=A0 =C2=A0 =C2=A0 =
20=C2=A0 =C2=A00=C2=A0 =C2=A011.5g=C2=A0 11.0g=C2=A0 11.0g S=C2=A0 =C2=A05.=
9=C2=A0 35.4=C2=A0 =C2=A08:39.93<br>
&gt;&gt;=C2=A0 =C2=A0&gt; lttng-c+<br>
&gt;&gt;=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A04824 root=C2=A0 =C2=A0 =C2=A0 =
20=C2=A0 =C2=A00 1098824=C2=A0 26456=C2=A0 =C2=A05380 S=C2=A0 =C2=A00.0=C2=
=A0 =C2=A00.1=C2=A0 =C2=A00:07.25<br>
&gt;&gt;=C2=A0 =C2=A0&gt; lttng-s+<br>
&gt;&gt;=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A04825 root=C2=A0 =C2=A0 =C2=A0 =
20=C2=A0 =C2=A00=C2=A0 =C2=A048872=C2=A0 =C2=A02188=C2=A0 =C2=A01012 S=C2=
=A0 =C2=A00.0=C2=A0 =C2=A00.0=C2=A0 =C2=A00:00.00<br>
&gt;&gt;=C2=A0 =C2=A0&gt; lttng-r+<br>
&gt;&gt;=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A04843 root=C2=A0 =C2=A0 =C2=A0 =
20=C2=A0 =C2=A00=C2=A0 =C2=A0 3680=C2=A0 =C2=A01160=C2=A0 =C2=A0 816 S=C2=
=A0 =C2=A00.0=C2=A0 =C2=A00.0=C2=A0 =C2=A00:00.23<br>
&gt;&gt;<br>
&gt;&gt; This top output for `localhost` seems very different than the outp=
ut for<br>
&gt;&gt; `localhost` in your previous message.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0&gt; lttng-r+<br>
&gt;&gt;=C2=A0 =C2=A0&gt; root@localhost:~# nrpco<br>
&gt;&gt;=C2=A0 =C2=A0&gt; bash: nrpco: command not found<br>
&gt;&gt;=C2=A0 =C2=A0&gt; root@localhost:~# nproc<br>
&gt;&gt;=C2=A0 =C2=A0&gt; 16<br>
&gt;&gt;=C2=A0 =C2=A0&gt; root@localhost:~# cat /sys/devices/system/cpu/pos=
sible<br>
&gt;&gt;=C2=A0 =C2=A0&gt; 0-15<br>
&gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;&gt;<br>
&gt;&gt; You indicated the bookworm machine has 32 cores, this is showing 1=
6. If<br>
&gt;&gt; you&#39;re comparing a 16 core machine to a 32 core machine, it is=
 very<br>
&gt;&gt; normal that the memory usage is higher on the 32 core machine.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0&gt; Most of the process are running as asorcs user bu=
t some are running<br>
&gt;&gt; as root.<br>
&gt;&gt;<br>
&gt;&gt; So you have two users with instrumented applications.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Given the discrepancies in the information provided I&#39;m findin=
g it a bit<br>
&gt;&gt; hard to understand what you&#39;re looking at.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; In general, a channel&#39;s shared memory footprint can be estimat=
ed with[1]:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0(nSubbuf * subbufSize) * (nCPUs + 1 iff snapsho=
t mode is enabled) *<br>
&gt;&gt; (nUIDs or nPIDs)<br>
&gt;&gt;<br>
&gt;&gt; Note that the sub-buffer sizes you are using get rounded to the ne=
arest<br>
&gt;&gt; larger power of 2. See [2].<br>
&gt;&gt;<br>
&gt;&gt; thanks,<br>
&gt;&gt; kienan<br>
&gt;&gt;<br>
&gt;&gt; [1]: <a href=3D"https://lttng.org/docs/v2.13/#doc-channel-bufferin=
g-schemes" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.1=
3/#doc-channel-buffering-schemes</a><br>
&gt;&gt; [2]:<br>
&gt;&gt; <a href=3D"https://lttng.org/man/1/lttng-enable-channel/v2.13/#doc=
-opt--subbuf-size" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/m=
an/1/lttng-enable-channel/v2.13/#doc-opt--subbuf-size</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ------------------------------<br>
&gt;&gt;<br>
&gt;&gt; Message: 2<br>
&gt;&gt; Date: Wed, 12 Mar 2025 14:49:07 +0530<br>
&gt;&gt; From: Gour DEV &lt;<a href=3D"mailto:lakshyagour10@gmail.com" targ=
et=3D"_blank">lakshyagour10@gmail.com</a>&gt;<br>
&gt;&gt; To: Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com" ta=
rget=3D"_blank">kstewart@efficios.com</a>&gt;<br>
&gt;&gt; Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank"=
>lttng-dev@lists.lttng.org</a><br>
&gt;&gt; Subject: Re: Memory Consumption High After Upgrading to 2.13 from =
2.10<br>
&gt;&gt; Message-ID:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;CAE9Jrzg7qsabhPiO-0=3DB1DY3b=
Vo-3FYu2tiJR2Bmb=3D<br>
&gt;&gt; <a href=3D"mailto:nqOHNZMw@mail.gmail.com" target=3D"_blank">nqOHN=
ZMw@mail.gmail.com</a>&gt;<br>
&gt;&gt; Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
&gt;&gt;<br>
&gt;&gt; Hi, Kienan<br>
&gt;&gt;<br>
&gt;&gt; I am attaching an screen recording of the behaviour I am seeing in=
 this<br>
&gt;&gt; mail. The behaviour is same irrespective of the device i use, sorr=
y for<br>
&gt;&gt; miscommunication in the npocs output (I assumed it was 32), but ot=
her than<br>
&gt;&gt; that all outputs are same (except the hostname as there are multip=
le<br>
&gt;&gt; devices with same lttng config but this memory cosumption is seen =
on all<br>
&gt;&gt; the devices).<br>
&gt;&gt;<br>
&gt;&gt; I had few question<br>
&gt;&gt;<br>
&gt;&gt; 1. Does lltng allocated all the memory it needs and mark it as dir=
ty in ram<br>
&gt;&gt; when any process which links/uses lttng-ust runs? (here i tried wi=
th one<br>
&gt;&gt; process but it is same for any of my process)<br>
&gt;&gt; 2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enable=
d) *<br>
&gt;&gt; (nUIDs or nPIDs)<br>
&gt;&gt;<br>
&gt;&gt; How do we calculate uid in the system is it all uids in the system=
? is it<br>
&gt;&gt; equal to `cat /etc/passwd | wc -l` ?<br>
&gt;&gt;<br>
&gt;&gt; I will put my calculations according to the above estimate based o=
n all the<br>
&gt;&gt; channel i am creating<br>
&gt;&gt;<br>
&gt;&gt; (4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are e=
qual to<br>
&gt;&gt; `cat /etc/passwd | wc -l`)B =3D 7.998046875 GB approx [this is bas=
ed on the<br>
&gt;&gt; start_lttng.py please do correct me if am wrong here.]<br>
&gt;&gt;<br>
&gt;&gt; But since there are only two users which uses lttng i think the co=
rrect<br>
&gt;&gt; estimate would be<br>
&gt;&gt; (4194304*4 + 262144*4 + 16384*4) * (16) * (2)B =3D 546MB<br>
&gt;&gt;<br>
&gt;&gt; Please do correct me If I am wrong calculations here.<br>
&gt;&gt;<br>
&gt;&gt; Now, there are a few things here, according to my output lttng is =
using 11G<br>
&gt;&gt; which is much more higher than the what is configured.<br>
&gt;&gt;<br>
&gt;&gt; I am attaching the lttng status and the file which is uses to crea=
te the<br>
&gt;&gt; lttng sessions.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thank You.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://drive.google.com/file/d/1tS_ZWEsXDpHZXfWzZHXmWc=
T0igiIOIaa/view?usp=3Dsharing" rel=3D"noreferrer" target=3D"_blank">https:/=
/drive.google.com/file/d/1tS_ZWEsXDpHZXfWzZHXmWcT0igiIOIaa/view?usp=3Dshari=
ng</a><br>
&gt;&gt; -- recording of the behaviour which is seen<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://drive.google.com/file/d/1PrU31oyEw1n9tKETlUtmNG=
O50s6ywx7p/view?usp=3Dsharing" rel=3D"noreferrer" target=3D"_blank">https:/=
/drive.google.com/file/d/1PrU31oyEw1n9tKETlUtmNGO50s6ywx7p/view?usp=3Dshari=
ng</a><br>
&gt;&gt; -- the file which is used to create lttng sessions<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Mar 12, 2025 at 12:25?AM Kienan Stewart &lt;<a href=3D"mai=
lto:kstewart@efficios.com" target=3D"_blank">kstewart@efficios.com</a>&gt;<=
br>
&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; Hi Lakshya,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 3/11/25 12:25 PM, Gour DEV wrote:<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; Hi, Kienan<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; here is the requested output<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; root@localhost:~# top -b -n 1 | grep=C2=A0 lt=
tng<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A04841 root=C2=A0 =C2=A0 =C2=
=A0 20=C2=A0 =C2=A00=C2=A0 =C2=A011.5g=C2=A0 11.0g=C2=A0 11.0g S=C2=A0 =C2=
=A05.9=C2=A0 35.4<br>
&gt;&gt;=C2=A0 =C2=A08:39.93<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; lttng-c+<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A04824 root=C2=A0 =C2=A0 =C2=
=A0 20=C2=A0 =C2=A00 1098824=C2=A0 26456=C2=A0 =C2=A05380 S=C2=A0 =C2=A00.0=
=C2=A0 =C2=A00.1<br>
&gt;&gt;=C2=A0 =C2=A00:07.25<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; lttng-s+<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A04825 root=C2=A0 =C2=A0 =C2=
=A0 20=C2=A0 =C2=A00=C2=A0 =C2=A048872=C2=A0 =C2=A02188=C2=A0 =C2=A01012 S=
=C2=A0 =C2=A00.0=C2=A0 =C2=A00.0<br>
&gt;&gt;=C2=A0 =C2=A00:00.00<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; lttng-r+<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A04843 root=C2=A0 =C2=A0 =C2=
=A0 20=C2=A0 =C2=A00=C2=A0 =C2=A0 3680=C2=A0 =C2=A01160=C2=A0 =C2=A0 816 S=
=C2=A0 =C2=A00.0=C2=A0 =C2=A00.0<br>
&gt;&gt;=C2=A0 =C2=A00:00.23<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This top output for `localhost` seems very different than the =
output for<br>
&gt;&gt;&gt; `localhost` in your previous message.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; lttng-r+<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; root@localhost:~# nrpco<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; bash: nrpco: command not found<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; root@localhost:~# nproc<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; 16<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; root@localhost:~# cat /sys/devices/system/cpu=
/possible<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; 0-15<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You indicated the bookworm machine has 32 cores, this is showi=
ng 16. If<br>
&gt;&gt;&gt; you&#39;re comparing a 16 core machine to a 32 core machine, i=
t is very<br>
&gt;&gt;&gt; normal that the memory usage is higher on the 32 core machine.=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0&gt; Most of the process are running as asorcs use=
r but some are running<br>
&gt;&gt;&gt; as root.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; So you have two users with instrumented applications.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Given the discrepancies in the information provided I&#39;m fi=
nding it a bit<br>
&gt;&gt;&gt; hard to understand what you&#39;re looking at.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; In general, a channel&#39;s shared memory footprint can be est=
imated with[1]:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0(nSubbuf * subbufSize) * (nCPUs + 1 iff sna=
pshot mode is enabled) *<br>
&gt;&gt;&gt; (nUIDs or nPIDs)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Note that the sub-buffer sizes you are using get rounded to th=
e nearest<br>
&gt;&gt;&gt; larger power of 2. See [2].<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; thanks,<br>
&gt;&gt;&gt; kienan<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [1]: <a href=3D"https://lttng.org/docs/v2.13/#doc-channel-buff=
ering-schemes" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/=
v2.13/#doc-channel-buffering-schemes</a><br>
&gt;&gt;&gt; [2]:<br>
&gt;&gt;&gt; <a href=3D"https://lttng.org/man/1/lttng-enable-channel/v2.13/=
#doc-opt--subbuf-size" rel=3D"noreferrer" target=3D"_blank">https://lttng.o=
rg/man/1/lttng-enable-channel/v2.13/#doc-opt--subbuf-size</a><br>
&gt;&gt;&gt;<br>
&gt;&gt; -------------- next part --------------<br>
&gt;&gt; An HTML attachment was scrubbed...<br>
&gt;&gt; URL: &lt;<br>
&gt;&gt; <a href=3D"https://lists.lttng.org/pipermail/lttng-dev/attachments=
/20250312/57f240d8/attachment-0001.htm" rel=3D"noreferrer" target=3D"_blank=
">https://lists.lttng.org/pipermail/lttng-dev/attachments/20250312/57f240d8=
/attachment-0001.htm</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ------------------------------<br>
&gt;&gt;<br>
&gt;&gt; Message: 3<br>
&gt;&gt; Date: Wed, 12 Mar 2025 10:36:28 -0400<br>
&gt;&gt; From: Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com" =
target=3D"_blank">kstewart@efficios.com</a>&gt;<br>
&gt;&gt; To: Gour DEV &lt;<a href=3D"mailto:lakshyagour10@gmail.com" target=
=3D"_blank">lakshyagour10@gmail.com</a>&gt;, <a href=3D"mailto:lttng-dev@li=
sts.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br>
&gt;&gt; Subject: Re: Memory Consumption High After Upgrading to 2.13 from =
2.10<br>
&gt;&gt; Message-ID: &lt;<a href=3D"mailto:0f819583-ea8e-468e-9102-e1410d88=
6a6f@efficios.com" target=3D"_blank">0f819583-ea8e-468e-9102-e1410d886a6f@e=
fficios.com</a>&gt;<br>
&gt;&gt; Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed<br>
&gt;&gt;<br>
&gt;&gt; Hi Lakshya,<br>
&gt;&gt;<br>
&gt;&gt; On 3/12/25 5:03 AM, Gour DEV wrote:<br>
&gt;&gt;&gt; Hi, Kienan<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I am attaching an screen recording of the behaviour I am seein=
g in this<br>
&gt;&gt;&gt; mail. The behaviour is same irrespective of the device i use, =
sorry for<br>
&gt;&gt;&gt; miscommunication in the npocs output (I assumed it was 32), bu=
t other<br>
&gt;&gt; than<br>
&gt;&gt;&gt; that all outputs are same (except the hostname as there are mu=
ltiple<br>
&gt;&gt;&gt; devices with same lttng config but this memory cosumption is s=
een on all<br>
&gt;&gt;&gt; the devices).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I had few question<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 1. Does lltng allocated all the memory it needs and mark it as=
 dirty in<br>
&gt;&gt; ram<br>
&gt;&gt;&gt; when any process which links/uses lttng-ust runs? (here i trie=
d with one<br>
&gt;&gt;&gt; process but it is same for any of my process)<br>
&gt;&gt;<br>
&gt;&gt; I believe the shared memory for per-CPU data structures is allocat=
ed<br>
&gt;&gt; when an instrumented application connects. There is no pre-allocat=
ion<br>
&gt;&gt; for each possible UID on the system.<br>
&gt;&gt;<br>
&gt;&gt; You can run your instrumented applications with `LTTNG_UST_DEBUG=
=3D1` to<br>
&gt;&gt; see when the connection happens[1].<br>
&gt;&gt;<br>
&gt;&gt;&gt; 2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is en=
abled) *<br>
&gt;&gt;&gt; (nUIDs or nPIDs)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; How do we calculate uid in the system is it all uids in the sy=
stem? is it<br>
&gt;&gt;&gt; equal to `cat /etc/passwd | wc -l` ?<br>
&gt;&gt;<br>
&gt;&gt; nUIDs is the number of distinct UIDs running instrumented applicat=
ions.<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I will put my calculations according to the above estimate bas=
ed on all<br>
&gt;&gt; the<br>
&gt;&gt;&gt; channel i am creating<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; (4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user a=
re equal to<br>
&gt;&gt;&gt; `cat /etc/passwd | wc -l`)B =3D 7.998046875 GB approx [this is=
 based on the<br>
&gt;&gt;&gt; start_lttng.py please do correct me if am wrong here.]<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; But since there are only two users which uses lttng i think th=
e correct<br>
&gt;&gt;&gt; estimate would be<br>
&gt;&gt;&gt; (4194304*4 + 262144*4 + 16384*4) * (16) * (2)B =3D 546MB<br>
&gt;&gt;<br>
&gt;&gt; The estimate I gave is per-channel.<br>
&gt;&gt;<br>
&gt;&gt; small channel: (0.015625 MiB * 4) * (16 + 1) =3D 1.0625 MiB per-ch=
annel<br>
&gt;&gt; per-UID<br>
&gt;&gt; medium channel: (0.250 MiB * 4) * (16 + 1) =3D 17.0 MiB per-channe=
l per-UID<br>
&gt;&gt; large channel: (4 MiB * 4) * (16 + 1) =3D 27 2MiB per-channel per-=
UID<br>
&gt;&gt;<br>
&gt;&gt; Now, you said you have 0 small channels, 6 medium channels, and 16=
 large<br>
&gt;&gt; channels in your session. (Note: I see your script differs from th=
ese<br>
&gt;&gt; stated channel counts).<br>
&gt;&gt;<br>
&gt;&gt; small: 0 * 1.0625 MiB =3D 0 MiB per-UID<br>
&gt;&gt; medium: 6 * 17 MiB =3D 102 MiB per-UID<br>
&gt;&gt; large: 16 * 272 MiB =3D 4352 MiB per-UID<br>
&gt;&gt;<br>
&gt;&gt; And if you&#39;re running instrumented applications with 2 users:<=
br>
&gt;&gt;<br>
&gt;&gt; small: 0 MiB * 2 =3D 0 MiB with 2 UIDs<br>
&gt;&gt; medium: 102 MiB * 2 =3D 204 MiB with 2 UIDs<br>
&gt;&gt; large: 4352 MiB * 2 =3D 8704 MiB with 2 UIDs<br>
&gt;&gt;<br>
&gt;&gt; Now this is just an estimation for the per-CPU ring buffers only, =
and<br>
&gt;&gt; you numbers aren&#39;t hugely off so without analyzing your specif=
ic system<br>
&gt;&gt; it doesn&#39;t seem to be that strange to me.<br>
&gt;&gt;<br>
&gt;&gt; If I take the number of channels I see in your script, it becomes:=
<br>
&gt;&gt;<br>
&gt;&gt; small: 0 MiB with 2 UIDs<br>
&gt;&gt; medium: 136 MiB with 2 UIDs<br>
&gt;&gt; large: 7616 MiB with 2 UIDs<br>
&gt;&gt;<br>
&gt;&gt; total: 7.57 GiB with 2 UIDs<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Please do correct me If I am wrong calculations here.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Now, there are a few things here, according to my output lttng=
 is using<br>
&gt;&gt; 11G<br>
&gt;&gt;&gt; which is much more higher than the what is configured.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I have no idea what &#39;service start spyder&#39; is doing. Maybe=
 it&#39;s running<br>
&gt;&gt; instrumented applications with an extra user that you didn&#39;t e=
xpect? I<br>
&gt;&gt; can&#39;t help you with that aspect of your system.<br>
&gt;&gt;<br>
&gt;&gt; The above estimated 7.57 GiB with 2 UIDs would be 11.35 GiB with 3=
 UIDs<br>
&gt;&gt; so maybe?<br>
&gt;&gt;<br>
&gt;&gt; I&#39;d recommend you read your verbose sessiond log so see which<=
br>
&gt;&gt; applications are connecting and with which UIDs.<br>
&gt;&gt;<br>
&gt;&gt;&gt; I am attaching the lttng status and the file which is uses to =
create the<br>
&gt;&gt;&gt; lttng sessions.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thank You.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; In any case, the information you have given to date hasn&#39;t dem=
onstrated<br>
&gt;&gt; to me in a tangible manner that you are seeing a difference relate=
d to<br>
&gt;&gt; the version of LTTng being used.<br>
&gt;&gt;<br>
&gt;&gt; thanks,<br>
&gt;&gt; kienan<br>
&gt;&gt;<br>
&gt;&gt; [1]: <a href=3D"https://lttng.org/man/3/lttng-ust/v2.13/#doc-_envi=
ronment_variables" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/m=
an/3/lttng-ust/v2.13/#doc-_environment_variables</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ------------------------------<br>
&gt;&gt;<br>
&gt;&gt; Subject: Digest Footer<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">ltt=
ng-dev@lists.lttng.org</a><br>
&gt;&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/m=
ailman/listinfo/lttng-dev</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ------------------------------<br>
&gt;&gt;<br>
&gt;&gt; End of lttng-dev Digest, Vol 203, Issue 7<br>
&gt;&gt; *****************************************<br>
&gt;&gt;<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000c31f030630d9bd43--
