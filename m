Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C55C282EC
	for <lttng-dev@archiver.kernel.org>; Mon, 17 Mar 2025 06:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1742193039;
	bh=tbeF+6Brjfs8I4vjkork3iVqi7Uvcktb7M/KwWBsGpk=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=CcvMO1kWHyWPbMlCapkaPLWlzUAm2x+SUT+MwbigPW8w87wGgog/byvqbjCM1EpUr
	 az6V7DGWm5u0ByykIyk7p+ra5GD1RlCX1/BoGt6fuPtBTQ2eLogS3GTyEOVO6gd55X
	 865F+F6lT4Q7217ujBHM1JjcMuofyKIVWgH62xValUBk01tt9Ma1zdMWZbZJ8KzsvM
	 m09WZ8hMNhqL03CgvMerD6DYQAHcgxhflp+EXdzuZ4kMZRLYtApu+DDF9M3wTE4AJb
	 zquWF0L2Pfm3AmVmr7MFYF3oy6hrcgjpQfB0Jv8oTlIwQTPguklS/SMK89BiR35n7t
	 b8n4yM7Dlm3SQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZGQ8G5Jmnz14bG;
	Mon, 17 Mar 2025 02:30:38 -0400 (EDT)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZGQ8F5PyVz14bD
 for <lttng-dev@lists.lttng.org>; Mon, 17 Mar 2025 02:30:37 -0400 (EDT)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so3530632a91.1
 for <lttng-dev@lists.lttng.org>; Sun, 16 Mar 2025 23:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742193036; x=1742797836;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vn1WjiJbHvTJex8hhnrypcsNctdk6Su9k3Vb0DIFqkU=;
 b=ALeMm+H9Ef4w1dav4kBkIRimMp/Fm7lIWVZsrZ3jk7aXVa689zxOgHTY3Y0TpWz8ef
 K53UDnv9vbW2qVDEktF5ghkFJB0DZzRmAsGZxDa9cVQokVT8n6nAKi3QVf9V1q/Ah+Bq
 0UGGxJm4q3TJo32T0NAH1Pd+0QvkLbg4HQ/ONySMXBv6AS+jgR97bC9LrxS/UHWL9KHg
 18GAVK81+fx5J9nm+HWoYmzatVShnqpJDMpWOt07FqOG7eNY+ELsc0OM3qAjjJXVlaka
 67fqXA+iJ6d0Ak7poARItk5JumKe5fCDSVkxGiH49ZQd+/OYGXFmkrWfNfzoL0DvEVhX
 x0GA==
X-Gm-Message-State: AOJu0Yz5fowD0Gt7amMKj1MLuTAQRpo8/2oVQjTmQ+2hOUknUTx0CBQR
 lGJYkP4EVP6117yvm55nB+qfr2odr9IGEDoOyGdUTmyuI+iZlBpxhbwOCgAdlWOrL184ktD1eC+
 zBNAnL30qI7VPelIaoA/zD2S8eh7XEQ5v7bM=
X-Gm-Gg: ASbGnctk92XSF1dEOr53n0PpNf++X0lr7bTF1oBCWMC+dNammy+wir08+yK1DWcujrn
 1o8hZ7+8NDNWPat4skbNrnKl9LFIJLfiRARS+/E0biQ6s/O6vr+ZEKKmORMx9EFmllH16H5TSVE
 hHj+l37MUyNZ3ClRMJRHUjnxGFxg==
X-Google-Smtp-Source: AGHT+IEp45SmcgzZCO3Tm8vBdqFT7MI0dFbIJpVUhHCeD6k/GkQbOGHNV5tCKm712W7i6aoWvTrL/gvvqJu6l2ObKy8=
X-Received: by 2002:a17:90b:56c4:b0:2ff:58a4:9db5 with SMTP id
 98e67ed59e1d1-30151d817b4mr13902802a91.30.1742193035955; Sun, 16 Mar 2025
 23:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <mailman.58.1741790192.282.lttng-dev@lists.lttng.org>
In-Reply-To: <mailman.58.1741790192.282.lttng-dev@lists.lttng.org>
Date: Mon, 17 Mar 2025 11:59:58 +0530
X-Gm-Features: AQ5f1Jqwlc-S8HTjOS_ppHEHmVflsmJUMkMIMHNduPaAIJXxJU2OTU-HscrzttA
Message-ID: <CAE9Jrzj_A8AwR80s-2_Wnv+vSpgqp4m6jKmJAAVg5VP4SKASEA@mail.gmail.com>
Subject: Re: lttng-dev Digest, Vol 203, Issue 7
To: lttng-dev@lists.lttng.org, Kienan Stewart <kstewart@efficios.com>
Content-Type: multipart/mixed; boundary="0000000000000a461d063083edbf"
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

--0000000000000a461d063083edbf
Content-Type: multipart/alternative; boundary="0000000000000a461c063083edbd"

--0000000000000a461c063083edbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Kienan

Sorry for the late reply.

Looks like in buster the memory is allocated by lttng-consumerd reserved

I buster, the rss is less than the VIRT
root@localhost:~#  COLUMNS=3D500 top  -b -n 1 | grep lttng
 PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
 4095 root      20   0 1003188  31256   4660 S   0.0   0.1   0:03.81
lttng-sessiond
 4096 root      20   0   44260    796      0 S   0.0   0.0   0:00.01
lttng-runas
 4440 root      20   0 5236020  10224   8756 S   0.0   0.0   2:56.25
lttng-consumerd -- here the VIRT is much more higher than RSS
 4443 root      20   0   48048    540      0 S   0.0   0.0   0:00.12
lttng-runas



In bookworm the VIRT and RES are nearly the same only.
root@edgecore-40XKE-j2-101-32:~# COLUMNS=3D500 top  -b -n 1 | grep lttng
 PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   4382 root      20   0 1098824  42600   8436 S   0.0   0.1   0:08.87
lttng-sessiond
   4403 root      20   0   48928   2116    996 S   0.0   0.0   0:00.00
lttng-runas
   5171 root      20   0 9879764   8.9g   8.9g S   0.0  28.7 108:23.53
lttng-consumerd -- here the VRIT is nearly equal to RSS
   5173 root      20   0    3680   1028    680 S   0.0   0.0   0:00.88
lttng-runas


Looks like lttng consumerd is allocating and reserving those pages, when
any instrumented application starts.

I am attaching the lttng status output in the mail, please do tell me if
you need any more information regarding this.


These is how we used to create the lttng channels and enable event which is
same in both buster and bookworm, (number of channels might differ)

def enable_channel(channels, session, subbuf_size, subbuf_num):
for c in channels:
call(['lttng', 'enable-channel', '-u', c, '-s', session, '--subbuf-size',
str(subbuf_size), '--num-subbuf', str(subbuf_num),],
stdout=3Ddevnull, stderr=3Dsubprocess.STDOUT)


def enable_events(traces, session):
for t in traces:
if 'log-level-only' in t:
log_opt =3D '--loglevel-only=3D' + t['log-level-only']
elif 'log-level' in t:
log_opt =3D '--loglevel=3D' + t['log-level']
else:
log_opt =3D ''

else:
call(['lttng', 'enable-event', '-u', t['name'], '-c', t['channel'],
'-s', session], stdout=3Ddevnull, stderr=3Dsubprocess.STDOUT)


Thank You.
Lakshya




On Wed, Mar 12, 2025 at 8:06=E2=80=AFPM <lttng-dev-request@lists.lttng.org>=
 wrote:

> Send lttng-dev mailing list submissions to
>         lttng-dev@lists.lttng.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> or, via email, send a message with subject or body 'help' to
>         lttng-dev-request@lists.lttng.org
>
> You can reach the person managing the list at
>         lttng-dev-owner@lists.lttng.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of lttng-dev digest..."
>
>
> Today's Topics:
>
>    1. Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>       (Kienan Stewart)
>    2. Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>       (Gour DEV)
>    3. Re: Memory Consumption High After Upgrading to 2.13 from 2.10
>       (Kienan Stewart)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 11 Mar 2025 14:55:21 -0400
> From: Kienan Stewart <kstewart@efficios.com>
> To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
> Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
> Message-ID: <38dab5ef-f106-4e57-9e36-b4b30015c019@efficios.com>
> Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed
>
> Hi Lakshya,
>
> On 3/11/25 12:25 PM, Gour DEV wrote:
>  > Hi, Kienan
>  >
>  > here is the requested output
>  >
>  > root@localhost:~# top -b -n 1 | grep  lttng
>  >     4841 root      20   0   11.5g  11.0g  11.0g S   5.9  35.4   8:39.9=
3
>  > lttng-c+
>  >     4824 root      20   0 1098824  26456   5380 S   0.0   0.1   0:07.2=
5
>  > lttng-s+
>  >     4825 root      20   0   48872   2188   1012 S   0.0   0.0   0:00.0=
0
>  > lttng-r+
>  >     4843 root      20   0    3680   1160    816 S   0.0   0.0   0:00.2=
3
>
> This top output for `localhost` seems very different than the output for
> `localhost` in your previous message.
>
>
>  > lttng-r+
>  > root@localhost:~# nrpco
>  > bash: nrpco: command not found
>  > root@localhost:~# nproc
>  > 16
>  > root@localhost:~# cat /sys/devices/system/cpu/possible
>  > 0-15
>  >
>
> You indicated the bookworm machine has 32 cores, this is showing 16. If
> you're comparing a 16 core machine to a 32 core machine, it is very
> normal that the memory usage is higher on the 32 core machine.
>
>  >
>  > Most of the process are running as asorcs user but some are running
> as root.
>
> So you have two users with instrumented applications.
>
>
> Given the discrepancies in the information provided I'm finding it a bit
> hard to understand what you're looking at.
>
>
> In general, a channel's shared memory footprint can be estimated with[1]:
>
>    (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
> (nUIDs or nPIDs)
>
> Note that the sub-buffer sizes you are using get rounded to the nearest
> larger power of 2. See [2].
>
> thanks,
> kienan
>
> [1]: https://lttng.org/docs/v2.13/#doc-channel-buffering-schemes
> [2]:
> https://lttng.org/man/1/lttng-enable-channel/v2.13/#doc-opt--subbuf-size
>
>
> ------------------------------
>
> Message: 2
> Date: Wed, 12 Mar 2025 14:49:07 +0530
> From: Gour DEV <lakshyagour10@gmail.com>
> To: Kienan Stewart <kstewart@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
> Message-ID:
>         <CAE9Jrzg7qsabhPiO-0=3DB1DY3bVo-3FYu2tiJR2Bmb=3D
> nqOHNZMw@mail.gmail.com>
> Content-Type: text/plain; charset=3D"utf-8"
>
> Hi, Kienan
>
> I am attaching an screen recording of the behaviour I am seeing in this
> mail. The behaviour is same irrespective of the device i use, sorry for
> miscommunication in the npocs output (I assumed it was 32), but other tha=
n
> that all outputs are same (except the hostname as there are multiple
> devices with same lttng config but this memory cosumption is seen on all
> the devices).
>
> I had few question
>
> 1. Does lltng allocated all the memory it needs and mark it as dirty in r=
am
> when any process which links/uses lttng-ust runs? (here i tried with one
> process but it is same for any of my process)
> 2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
> (nUIDs or nPIDs)
>
> How do we calculate uid in the system is it all uids in the system? is it
> equal to `cat /etc/passwd | wc -l` ?
>
> I will put my calculations according to the above estimate based on all t=
he
> channel i am creating
>
> (4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are equal to
> `cat /etc/passwd | wc -l`)B =3D 7.998046875 GB approx [this is based on t=
he
> start_lttng.py please do correct me if am wrong here.]
>
> But since there are only two users which uses lttng i think the correct
> estimate would be
> (4194304*4 + 262144*4 + 16384*4) * (16) * (2)B =3D 546MB
>
> Please do correct me If I am wrong calculations here.
>
> Now, there are a few things here, according to my output lttng is using 1=
1G
> which is much more higher than the what is configured.
>
> I am attaching the lttng status and the file which is uses to create the
> lttng sessions.
>
>
>
> Thank You.
>
>
>
> https://drive.google.com/file/d/1tS_ZWEsXDpHZXfWzZHXmWcT0igiIOIaa/view?us=
p=3Dsharing
> -- recording of the behaviour which is seen
>
> https://drive.google.com/file/d/1PrU31oyEw1n9tKETlUtmNGO50s6ywx7p/view?us=
p=3Dsharing
> -- the file which is used to create lttng sessions
>
>
> On Wed, Mar 12, 2025 at 12:25?AM Kienan Stewart <kstewart@efficios.com>
> wrote:
>
> > Hi Lakshya,
> >
> > On 3/11/25 12:25 PM, Gour DEV wrote:
> >  > Hi, Kienan
> >  >
> >  > here is the requested output
> >  >
> >  > root@localhost:~# top -b -n 1 | grep  lttng
> >  >     4841 root      20   0   11.5g  11.0g  11.0g S   5.9  35.4
>  8:39.93
> >  > lttng-c+
> >  >     4824 root      20   0 1098824  26456   5380 S   0.0   0.1
>  0:07.25
> >  > lttng-s+
> >  >     4825 root      20   0   48872   2188   1012 S   0.0   0.0
>  0:00.00
> >  > lttng-r+
> >  >     4843 root      20   0    3680   1160    816 S   0.0   0.0
>  0:00.23
> >
> > This top output for `localhost` seems very different than the output fo=
r
> > `localhost` in your previous message.
> >
> >
> >  > lttng-r+
> >  > root@localhost:~# nrpco
> >  > bash: nrpco: command not found
> >  > root@localhost:~# nproc
> >  > 16
> >  > root@localhost:~# cat /sys/devices/system/cpu/possible
> >  > 0-15
> >  >
> >
> > You indicated the bookworm machine has 32 cores, this is showing 16. If
> > you're comparing a 16 core machine to a 32 core machine, it is very
> > normal that the memory usage is higher on the 32 core machine.
> >
> >  >
> >  > Most of the process are running as asorcs user but some are running
> > as root.
> >
> > So you have two users with instrumented applications.
> >
> >
> > Given the discrepancies in the information provided I'm finding it a bi=
t
> > hard to understand what you're looking at.
> >
> >
> > In general, a channel's shared memory footprint can be estimated with[1=
]:
> >
> >    (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
> > (nUIDs or nPIDs)
> >
> > Note that the sub-buffer sizes you are using get rounded to the nearest
> > larger power of 2. See [2].
> >
> > thanks,
> > kienan
> >
> > [1]: https://lttng.org/docs/v2.13/#doc-channel-buffering-schemes
> > [2]:
> > https://lttng.org/man/1/lttng-enable-channel/v2.13/#doc-opt--subbuf-siz=
e
> >
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: <
> https://lists.lttng.org/pipermail/lttng-dev/attachments/20250312/57f240d8=
/attachment-0001.htm
> >
>
> ------------------------------
>
> Message: 3
> Date: Wed, 12 Mar 2025 10:36:28 -0400
> From: Kienan Stewart <kstewart@efficios.com>
> To: Gour DEV <lakshyagour10@gmail.com>, lttng-dev@lists.lttng.org
> Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
> Message-ID: <0f819583-ea8e-468e-9102-e1410d886a6f@efficios.com>
> Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed
>
> Hi Lakshya,
>
> On 3/12/25 5:03 AM, Gour DEV wrote:
> > Hi, Kienan
> >
> > I am attaching an screen recording of the behaviour I am seeing in this
> > mail. The behaviour is same irrespective of the device i use, sorry for
> > miscommunication in the npocs output (I assumed it was 32), but other
> than
> > that all outputs are same (except the hostname as there are multiple
> > devices with same lttng config but this memory cosumption is seen on al=
l
> > the devices).
> >
> > I had few question
> >
> > 1. Does lltng allocated all the memory it needs and mark it as dirty in
> ram
> > when any process which links/uses lttng-ust runs? (here i tried with on=
e
> > process but it is same for any of my process)
>
> I believe the shared memory for per-CPU data structures is allocated
> when an instrumented application connects. There is no pre-allocation
> for each possible UID on the system.
>
> You can run your instrumented applications with `LTTNG_UST_DEBUG=3D1` to
> see when the connection happens[1].
>
> > 2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
> > (nUIDs or nPIDs)
> >
> > How do we calculate uid in the system is it all uids in the system? is =
it
> > equal to `cat /etc/passwd | wc -l` ?
>
> nUIDs is the number of distinct UIDs running instrumented applications.
>
> >
> > I will put my calculations according to the above estimate based on all
> the
> > channel i am creating
> >
> > (4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are equal =
to
> > `cat /etc/passwd | wc -l`)B =3D 7.998046875 GB approx [this is based on=
 the
> > start_lttng.py please do correct me if am wrong here.]
> >
> > But since there are only two users which uses lttng i think the correct
> > estimate would be
> > (4194304*4 + 262144*4 + 16384*4) * (16) * (2)B =3D 546MB
>
> The estimate I gave is per-channel.
>
> small channel: (0.015625 MiB * 4) * (16 + 1) =3D 1.0625 MiB per-channel
> per-UID
> medium channel: (0.250 MiB * 4) * (16 + 1) =3D 17.0 MiB per-channel per-U=
ID
> large channel: (4 MiB * 4) * (16 + 1) =3D 27 2MiB per-channel per-UID
>
> Now, you said you have 0 small channels, 6 medium channels, and 16 large
> channels in your session. (Note: I see your script differs from these
> stated channel counts).
>
> small: 0 * 1.0625 MiB =3D 0 MiB per-UID
> medium: 6 * 17 MiB =3D 102 MiB per-UID
> large: 16 * 272 MiB =3D 4352 MiB per-UID
>
> And if you're running instrumented applications with 2 users:
>
> small: 0 MiB * 2 =3D 0 MiB with 2 UIDs
> medium: 102 MiB * 2 =3D 204 MiB with 2 UIDs
> large: 4352 MiB * 2 =3D 8704 MiB with 2 UIDs
>
> Now this is just an estimation for the per-CPU ring buffers only, and
> you numbers aren't hugely off so without analyzing your specific system
> it doesn't seem to be that strange to me.
>
> If I take the number of channels I see in your script, it becomes:
>
> small: 0 MiB with 2 UIDs
> medium: 136 MiB with 2 UIDs
> large: 7616 MiB with 2 UIDs
>
> total: 7.57 GiB with 2 UIDs
>
> >
> > Please do correct me If I am wrong calculations here.
> >
> > Now, there are a few things here, according to my output lttng is using
> 11G
> > which is much more higher than the what is configured.
> >
>
> I have no idea what 'service start spyder' is doing. Maybe it's running
> instrumented applications with an extra user that you didn't expect? I
> can't help you with that aspect of your system.
>
> The above estimated 7.57 GiB with 2 UIDs would be 11.35 GiB with 3 UIDs
> so maybe?
>
> I'd recommend you read your verbose sessiond log so see which
> applications are connecting and with which UIDs.
>
> > I am attaching the lttng status and the file which is uses to create th=
e
> > lttng sessions.
> >
> >
> >
> > Thank You.
> >
>
> In any case, the information you have given to date hasn't demonstrated
> to me in a tangible manner that you are seeing a difference related to
> the version of LTTng being used.
>
> thanks,
> kienan
>
> [1]: https://lttng.org/man/3/lttng-ust/v2.13/#doc-_environment_variables
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> ------------------------------
>
> End of lttng-dev Digest, Vol 203, Issue 7
> *****************************************
>

--0000000000000a461c063083edbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi, Kienan <br><br></div>Sorry for the late repl=
y.<br><br></div><div>Looks like in buster the memory is allocated by lttng-=
consumerd reserved<br><br>I buster, the rss is less than the VIRT<br>root@l=
ocalhost:~# =C2=A0COLUMNS=3D500 top =C2=A0-b -n 1 | grep lttng<br>=C2=A0PID=
 USER =C2=A0 =C2=A0 =C2=A0PR =C2=A0NI =C2=A0 =C2=A0VIRT =C2=A0 =C2=A0RES =
=C2=A0 =C2=A0SHR S =C2=A0%CPU =C2=A0%MEM =C2=A0 =C2=A0 TIME+ COMMAND<br>=C2=
=A04095 root =C2=A0 =C2=A0 =C2=A020 =C2=A0 0 1003188 =C2=A031256 =C2=A0 466=
0 S =C2=A0 0.0 =C2=A0 0.1 =C2=A0 0:03.81 lttng-sessiond<br>=C2=A04096 root =
=C2=A0 =C2=A0 =C2=A020 =C2=A0 0 =C2=A0 44260 =C2=A0 =C2=A0796 =C2=A0 =C2=A0=
 =C2=A00 S =C2=A0 0.0 =C2=A0 0.0 =C2=A0 0:00.01 lttng-runas<br>=C2=A04440 r=
oot =C2=A0 =C2=A0 =C2=A020 =C2=A0 0 5236020 =C2=A010224 =C2=A0 8756 S =C2=
=A0 0.0 =C2=A0 0.0 =C2=A0 2:56.25 lttng-consumerd -- here the VIRT is much =
more higher than RSS<br>=C2=A04443 root =C2=A0 =C2=A0 =C2=A020 =C2=A0 0 =C2=
=A0 48048 =C2=A0 =C2=A0540 =C2=A0 =C2=A0 =C2=A00 S =C2=A0 0.0 =C2=A0 0.0 =
=C2=A0 0:00.12 lttng-runas<br><br><br><br>In bookworm the VIRT and RES are =
nearly the same only.<br>root@edgecore-40XKE-j2-101-32:~# COLUMNS=3D500 top=
 =C2=A0-b -n 1 | grep lttng<br>=C2=A0PID USER =C2=A0 =C2=A0 =C2=A0PR =C2=A0=
NI =C2=A0 =C2=A0VIRT =C2=A0 =C2=A0RES =C2=A0 =C2=A0SHR S =C2=A0%CPU =C2=A0%=
MEM =C2=A0 =C2=A0 TIME+ COMMAND<br>=C2=A0 =C2=A04382 root =C2=A0 =C2=A0 =C2=
=A020 =C2=A0 0 1098824 =C2=A042600 =C2=A0 8436 S =C2=A0 0.0 =C2=A0 0.1 =C2=
=A0 0:08.87 lttng-sessiond<br>=C2=A0 =C2=A04403 root =C2=A0 =C2=A0 =C2=A020=
 =C2=A0 0 =C2=A0 48928 =C2=A0 2116 =C2=A0 =C2=A0996 S =C2=A0 0.0 =C2=A0 0.0=
 =C2=A0 0:00.00 lttng-runas<br>=C2=A0 =C2=A05171 root =C2=A0 =C2=A0 =C2=A02=
0 =C2=A0 0 9879764 =C2=A0 8.9g =C2=A0 8.9g S =C2=A0 0.0 =C2=A028.7 108:23.5=
3 lttng-consumerd -- here the VRIT is nearly equal to RSS<br>=C2=A0 =C2=A05=
173 root =C2=A0 =C2=A0 =C2=A020 =C2=A0 0 =C2=A0 =C2=A03680 =C2=A0 1028 =C2=
=A0 =C2=A0680 S =C2=A0 0.0 =C2=A0 0.0 =C2=A0 0:00.88 lttng-runas</div><div>=
<br><br></div><div>Looks like lttng consumerd is allocating and reserving t=
hose pages, when any instrumented application starts.<br><br></div><div>I a=
m attaching the lttng status output in the mail, please do tell me if you n=
eed any more information regarding this.<br><br><br></div><div>These is how=
 we used to create the lttng channels and enable event which is same in bot=
h buster and bookworm, (number of channels might differ)<br><br><div style=
=3D"color:rgb(204,204,204);background-color:rgb(31,31,31);font-family:&quot=
;JetBrainsMono Nerd Font&quot;,Menlo,Monaco,&quot;Courier New&quot;,monospa=
ce;font-weight:normal;font-size:12px;line-height:18px;white-space:pre"><div=
><span style=3D"color:rgb(86,156,214)">def</span><span style=3D"color:rgb(2=
04,204,204)"> </span><span style=3D"color:rgb(220,220,170)">enable_channel<=
/span><span style=3D"color:rgb(204,204,204)">(</span><span style=3D"color:r=
gb(156,220,254)">channels</span><span style=3D"color:rgb(204,204,204)">, </=
span><span style=3D"color:rgb(156,220,254)">session</span><span style=3D"co=
lor:rgb(204,204,204)">, </span><span style=3D"color:rgb(156,220,254)">subbu=
f_size</span><span style=3D"color:rgb(204,204,204)">, </span><span style=3D=
"color:rgb(156,220,254)">subbuf_num</span><span style=3D"color:rgb(204,204,=
204)">):</span></div><div><span style=3D"color:rgb(204,204,204)">    </span=
><span style=3D"color:rgb(197,134,192)">for</span><span style=3D"color:rgb(=
204,204,204)"> c </span><span style=3D"color:rgb(197,134,192)">in</span><sp=
an style=3D"color:rgb(204,204,204)"> channels:</span></div><div><span style=
=3D"color:rgb(204,204,204)">        call([</span><span style=3D"color:rgb(2=
06,145,120)">&#39;lttng&#39;</span><span style=3D"color:rgb(204,204,204)">,=
 </span><span style=3D"color:rgb(206,145,120)">&#39;enable-channel&#39;</sp=
an><span style=3D"color:rgb(204,204,204)">, </span><span style=3D"color:rgb=
(206,145,120)">&#39;-u&#39;</span><span style=3D"color:rgb(204,204,204)">, =
c, </span><span style=3D"color:rgb(206,145,120)">&#39;-s&#39;</span><span s=
tyle=3D"color:rgb(204,204,204)">, session, </span><span style=3D"color:rgb(=
206,145,120)">&#39;--subbuf-size&#39;</span><span style=3D"color:rgb(204,20=
4,204)">,</span></div><div><span style=3D"color:rgb(204,204,204)">         =
    </span><span style=3D"color:rgb(78,201,176)">str</span><span style=3D"c=
olor:rgb(204,204,204)">(subbuf_size), </span><span style=3D"color:rgb(206,1=
45,120)">&#39;--num-subbuf&#39;</span><span style=3D"color:rgb(204,204,204)=
">, </span><span style=3D"color:rgb(78,201,176)">str</span><span style=3D"c=
olor:rgb(204,204,204)">(subbuf_num),],</span></div><div><span style=3D"colo=
r:rgb(204,204,204)">             </span><span style=3D"color:rgb(156,220,25=
4)">stdout</span><span style=3D"color:rgb(212,212,212)">=3D</span><span sty=
le=3D"color:rgb(204,204,204)">devnull, </span><span style=3D"color:rgb(156,=
220,254)">stderr</span><span style=3D"color:rgb(212,212,212)">=3D</span><sp=
an style=3D"color:rgb(204,204,204)">subprocess.STDOUT)</span></div><br><br>=
<div><span style=3D"color:rgb(86,156,214)">def</span><span style=3D"color:r=
gb(204,204,204)"> </span><span style=3D"color:rgb(220,220,170)">enable_even=
ts</span><span style=3D"color:rgb(204,204,204)">(</span><span style=3D"colo=
r:rgb(156,220,254)">traces</span><span style=3D"color:rgb(204,204,204)">, <=
/span><span style=3D"color:rgb(156,220,254)">session</span><span style=3D"c=
olor:rgb(204,204,204)">):</span></div><div><span style=3D"color:rgb(204,204=
,204)">    </span><span style=3D"color:rgb(197,134,192)">for</span><span st=
yle=3D"color:rgb(204,204,204)"> t </span><span style=3D"color:rgb(197,134,1=
92)">in</span><span style=3D"color:rgb(204,204,204)"> traces:</span></div><=
div><span style=3D"color:rgb(204,204,204)">        </span><span style=3D"co=
lor:rgb(197,134,192)">if</span><span style=3D"color:rgb(204,204,204)"> </sp=
an><span style=3D"color:rgb(206,145,120)">&#39;log-level-only&#39;</span><s=
pan style=3D"color:rgb(204,204,204)"> </span><span style=3D"color:rgb(86,15=
6,214)">in</span><span style=3D"color:rgb(204,204,204)"> t:</span></div><di=
v><span style=3D"color:rgb(204,204,204)">            log_opt </span><span s=
tyle=3D"color:rgb(212,212,212)">=3D</span><span style=3D"color:rgb(204,204,=
204)"> </span><span style=3D"color:rgb(206,145,120)">&#39;--loglevel-only=
=3D&#39;</span><span style=3D"color:rgb(204,204,204)"> </span><span style=
=3D"color:rgb(212,212,212)">+</span><span style=3D"color:rgb(204,204,204)">=
 t[</span><span style=3D"color:rgb(206,145,120)">&#39;log-level-only&#39;</=
span><span style=3D"color:rgb(204,204,204)">]</span></div><div><span style=
=3D"color:rgb(204,204,204)">        </span><span style=3D"color:rgb(197,134=
,192)">elif</span><span style=3D"color:rgb(204,204,204)"> </span><span styl=
e=3D"color:rgb(206,145,120)">&#39;log-level&#39;</span><span style=3D"color=
:rgb(204,204,204)"> </span><span style=3D"color:rgb(86,156,214)">in</span><=
span style=3D"color:rgb(204,204,204)"> t:</span></div><div><span style=3D"c=
olor:rgb(204,204,204)">            log_opt </span><span style=3D"color:rgb(=
212,212,212)">=3D</span><span style=3D"color:rgb(204,204,204)"> </span><spa=
n style=3D"color:rgb(206,145,120)">&#39;--loglevel=3D&#39;</span><span styl=
e=3D"color:rgb(204,204,204)"> </span><span style=3D"color:rgb(212,212,212)"=
>+</span><span style=3D"color:rgb(204,204,204)"> t[</span><span style=3D"co=
lor:rgb(206,145,120)">&#39;log-level&#39;</span><span style=3D"color:rgb(20=
4,204,204)">]</span></div><div><span style=3D"color:rgb(204,204,204)">     =
   </span><span style=3D"color:rgb(197,134,192)">else</span><span style=3D"=
color:rgb(204,204,204)">:</span></div><div><span style=3D"color:rgb(204,204=
,204)">            log_opt </span><span style=3D"color:rgb(212,212,212)">=
=3D</span><span style=3D"color:rgb(204,204,204)"> </span><span style=3D"col=
or:rgb(206,145,120)">&#39;&#39;</span></div><br><div><span style=3D"color:r=
gb(204,204,204)">        </span><span style=3D"color:rgb(197,134,192)">else=
</span><span style=3D"color:rgb(204,204,204)">:</span></div><div><span styl=
e=3D"color:rgb(204,204,204)">            call([</span><span style=3D"color:=
rgb(206,145,120)">&#39;lttng&#39;</span><span style=3D"color:rgb(204,204,20=
4)">, </span><span style=3D"color:rgb(206,145,120)">&#39;enable-event&#39;<=
/span><span style=3D"color:rgb(204,204,204)">, </span><span style=3D"color:=
rgb(206,145,120)">&#39;-u&#39;</span><span style=3D"color:rgb(204,204,204)"=
>, t[</span><span style=3D"color:rgb(206,145,120)">&#39;name&#39;</span><sp=
an style=3D"color:rgb(204,204,204)">], </span><span style=3D"color:rgb(206,=
145,120)">&#39;-c&#39;</span><span style=3D"color:rgb(204,204,204)">, t[</s=
pan><span style=3D"color:rgb(206,145,120)">&#39;channel&#39;</span><span st=
yle=3D"color:rgb(204,204,204)">],</span></div><div><span style=3D"color:rgb=
(204,204,204)">                  </span><span style=3D"color:rgb(206,145,12=
0)">&#39;-s&#39;</span><span style=3D"color:rgb(204,204,204)">, session], <=
/span><span style=3D"color:rgb(156,220,254)">stdout</span><span style=3D"co=
lor:rgb(212,212,212)">=3D</span><span style=3D"color:rgb(204,204,204)">devn=
ull, </span><span style=3D"color:rgb(156,220,254)">stderr</span><span style=
=3D"color:rgb(212,212,212)">=3D</span><span style=3D"color:rgb(204,204,204)=
">subprocess.STDOUT)</span></div></div><br></div><div><br></div><div>Thank =
You.</div><div>Lakshya</div><div><br></div><div><br><br></div></div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Wed, Mar 12, 2025 at 8:06=E2=80=AFPM &lt;<a href=3D"mailto:lttn=
g-dev-request@lists.lttng.org">lttng-dev-request@lists.lttng.org</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Send lttng-=
dev mailing list submissions to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev@lists.lttng.org" ta=
rget=3D"_blank">lttng-dev@lists.lttng.org</a><br>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
or, via email, send a message with subject or body &#39;help&#39; to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev-request@lists.lttng=
.org" target=3D"_blank">lttng-dev-request@lists.lttng.org</a><br>
<br>
You can reach the person managing the list at<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev-owner@lists.lttng.o=
rg" target=3D"_blank">lttng-dev-owner@lists.lttng.org</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of lttng-dev digest...&quot;<br>
<br>
<br>
Today&#39;s Topics:<br>
<br>
=C2=A0 =C2=A01. Re: Memory Consumption High After Upgrading to 2.13 from 2.=
10<br>
=C2=A0 =C2=A0 =C2=A0 (Kienan Stewart)<br>
=C2=A0 =C2=A02. Re: Memory Consumption High After Upgrading to 2.13 from 2.=
10<br>
=C2=A0 =C2=A0 =C2=A0 (Gour DEV)<br>
=C2=A0 =C2=A03. Re: Memory Consumption High After Upgrading to 2.13 from 2.=
10<br>
=C2=A0 =C2=A0 =C2=A0 (Kienan Stewart)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Tue, 11 Mar 2025 14:55:21 -0400<br>
From: Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com" target=3D=
"_blank">kstewart@efficios.com</a>&gt;<br>
To: Gour DEV &lt;<a href=3D"mailto:lakshyagour10@gmail.com" target=3D"_blan=
k">lakshyagour10@gmail.com</a>&gt;, <a href=3D"mailto:lttng-dev@lists.lttng=
.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br>
Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10<br>
Message-ID: &lt;<a href=3D"mailto:38dab5ef-f106-4e57-9e36-b4b30015c019@effi=
cios.com" target=3D"_blank">38dab5ef-f106-4e57-9e36-b4b30015c019@efficios.c=
om</a>&gt;<br>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed<br>
<br>
Hi Lakshya,<br>
<br>
On 3/11/25 12:25 PM, Gour DEV wrote:<br>
=C2=A0&gt; Hi, Kienan<br>
=C2=A0&gt;<br>
=C2=A0&gt; here is the requested output<br>
=C2=A0&gt;<br>
=C2=A0&gt; root@localhost:~# top -b -n 1 | grep=C2=A0 lttng<br>
=C2=A0&gt;=C2=A0 =C2=A0 =C2=A04841 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A0=
0=C2=A0 =C2=A011.5g=C2=A0 11.0g=C2=A0 11.0g S=C2=A0 =C2=A05.9=C2=A0 35.4=C2=
=A0 =C2=A08:39.93<br>
=C2=A0&gt; lttng-c+<br>
=C2=A0&gt;=C2=A0 =C2=A0 =C2=A04824 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A0=
0 1098824=C2=A0 26456=C2=A0 =C2=A05380 S=C2=A0 =C2=A00.0=C2=A0 =C2=A00.1=C2=
=A0 =C2=A00:07.25<br>
=C2=A0&gt; lttng-s+<br>
=C2=A0&gt;=C2=A0 =C2=A0 =C2=A04825 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A0=
0=C2=A0 =C2=A048872=C2=A0 =C2=A02188=C2=A0 =C2=A01012 S=C2=A0 =C2=A00.0=C2=
=A0 =C2=A00.0=C2=A0 =C2=A00:00.00<br>
=C2=A0&gt; lttng-r+<br>
=C2=A0&gt;=C2=A0 =C2=A0 =C2=A04843 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =C2=A0=
0=C2=A0 =C2=A0 3680=C2=A0 =C2=A01160=C2=A0 =C2=A0 816 S=C2=A0 =C2=A00.0=C2=
=A0 =C2=A00.0=C2=A0 =C2=A00:00.23<br>
<br>
This top output for `localhost` seems very different than the output for <b=
r>
`localhost` in your previous message.<br>
<br>
<br>
=C2=A0&gt; lttng-r+<br>
=C2=A0&gt; root@localhost:~# nrpco<br>
=C2=A0&gt; bash: nrpco: command not found<br>
=C2=A0&gt; root@localhost:~# nproc<br>
=C2=A0&gt; 16<br>
=C2=A0&gt; root@localhost:~# cat /sys/devices/system/cpu/possible<br>
=C2=A0&gt; 0-15<br>
=C2=A0&gt;<br>
<br>
You indicated the bookworm machine has 32 cores, this is showing 16. If <br=
>
you&#39;re comparing a 16 core machine to a 32 core machine, it is very <br=
>
normal that the memory usage is higher on the 32 core machine.<br>
<br>
=C2=A0&gt;<br>
=C2=A0&gt; Most of the process are running as asorcs user but some are runn=
ing <br>
as root.<br>
<br>
So you have two users with instrumented applications.<br>
<br>
<br>
Given the discrepancies in the information provided I&#39;m finding it a bi=
t <br>
hard to understand what you&#39;re looking at.<br>
<br>
<br>
In general, a channel&#39;s shared memory footprint can be estimated with[1=
]:<br>
<br>
=C2=A0 =C2=A0(nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabl=
ed) * <br>
(nUIDs or nPIDs)<br>
<br>
Note that the sub-buffer sizes you are using get rounded to the nearest <br=
>
larger power of 2. See [2].<br>
<br>
thanks,<br>
kienan<br>
<br>
[1]: <a href=3D"https://lttng.org/docs/v2.13/#doc-channel-buffering-schemes=
" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.13/#doc-ch=
annel-buffering-schemes</a><br>
[2]: <br>
<a href=3D"https://lttng.org/man/1/lttng-enable-channel/v2.13/#doc-opt--sub=
buf-size" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/man/1/lttn=
g-enable-channel/v2.13/#doc-opt--subbuf-size</a><br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Wed, 12 Mar 2025 14:49:07 +0530<br>
From: Gour DEV &lt;<a href=3D"mailto:lakshyagour10@gmail.com" target=3D"_bl=
ank">lakshyagour10@gmail.com</a>&gt;<br>
To: Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com" target=3D"_=
blank">kstewart@efficios.com</a>&gt;<br>
Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br>
Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;CAE9Jrzg7qsabhPiO-0=3DB1DY3bVo-3FYu2tiJR2Bm=
b=3D<a href=3D"mailto:nqOHNZMw@mail.gmail.com" target=3D"_blank">nqOHNZMw@m=
ail.gmail.com</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
<br>
Hi, Kienan<br>
<br>
I am attaching an screen recording of the behaviour I am seeing in this<br>
mail. The behaviour is same irrespective of the device i use, sorry for<br>
miscommunication in the npocs output (I assumed it was 32), but other than<=
br>
that all outputs are same (except the hostname as there are multiple<br>
devices with same lttng config but this memory cosumption is seen on all<br=
>
the devices).<br>
<br>
I had few question<br>
<br>
1. Does lltng allocated all the memory it needs and mark it as dirty in ram=
<br>
when any process which links/uses lttng-ust runs? (here i tried with one<br=
>
process but it is same for any of my process)<br>
2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *<br>
(nUIDs or nPIDs)<br>
<br>
How do we calculate uid in the system is it all uids in the system? is it<b=
r>
equal to `cat /etc/passwd | wc -l` ?<br>
<br>
I will put my calculations according to the above estimate based on all the=
<br>
channel i am creating<br>
<br>
(4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are equal to<b=
r>
`cat /etc/passwd | wc -l`)B =3D 7.998046875 GB approx [this is based on the=
<br>
start_lttng.py please do correct me if am wrong here.]<br>
<br>
But since there are only two users which uses lttng i think the correct<br>
estimate would be<br>
(4194304*4 + 262144*4 + 16384*4) * (16) * (2)B =3D 546MB<br>
<br>
Please do correct me If I am wrong calculations here.<br>
<br>
Now, there are a few things here, according to my output lttng is using 11G=
<br>
which is much more higher than the what is configured.<br>
<br>
I am attaching the lttng status and the file which is uses to create the<br=
>
lttng sessions.<br>
<br>
<br>
<br>
Thank You.<br>
<br>
<br>
<a href=3D"https://drive.google.com/file/d/1tS_ZWEsXDpHZXfWzZHXmWcT0igiIOIa=
a/view?usp=3Dsharing" rel=3D"noreferrer" target=3D"_blank">https://drive.go=
ogle.com/file/d/1tS_ZWEsXDpHZXfWzZHXmWcT0igiIOIaa/view?usp=3Dsharing</a><br=
>
-- recording of the behaviour which is seen<br>
<a href=3D"https://drive.google.com/file/d/1PrU31oyEw1n9tKETlUtmNGO50s6ywx7=
p/view?usp=3Dsharing" rel=3D"noreferrer" target=3D"_blank">https://drive.go=
ogle.com/file/d/1PrU31oyEw1n9tKETlUtmNGO50s6ywx7p/view?usp=3Dsharing</a><br=
>
-- the file which is used to create lttng sessions<br>
<br>
<br>
On Wed, Mar 12, 2025 at 12:25?AM Kienan Stewart &lt;<a href=3D"mailto:kstew=
art@efficios.com" target=3D"_blank">kstewart@efficios.com</a>&gt;<br>
wrote:<br>
<br>
&gt; Hi Lakshya,<br>
&gt;<br>
&gt; On 3/11/25 12:25 PM, Gour DEV wrote:<br>
&gt;=C2=A0 &gt; Hi, Kienan<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; here is the requested output<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; root@localhost:~# top -b -n 1 | grep=C2=A0 lttng<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A04841 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =
=C2=A00=C2=A0 =C2=A011.5g=C2=A0 11.0g=C2=A0 11.0g S=C2=A0 =C2=A05.9=C2=A0 3=
5.4=C2=A0 =C2=A08:39.93<br>
&gt;=C2=A0 &gt; lttng-c+<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A04824 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =
=C2=A00 1098824=C2=A0 26456=C2=A0 =C2=A05380 S=C2=A0 =C2=A00.0=C2=A0 =C2=A0=
0.1=C2=A0 =C2=A00:07.25<br>
&gt;=C2=A0 &gt; lttng-s+<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A04825 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =
=C2=A00=C2=A0 =C2=A048872=C2=A0 =C2=A02188=C2=A0 =C2=A01012 S=C2=A0 =C2=A00=
.0=C2=A0 =C2=A00.0=C2=A0 =C2=A00:00.00<br>
&gt;=C2=A0 &gt; lttng-r+<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A04843 root=C2=A0 =C2=A0 =C2=A0 20=C2=A0 =
=C2=A00=C2=A0 =C2=A0 3680=C2=A0 =C2=A01160=C2=A0 =C2=A0 816 S=C2=A0 =C2=A00=
.0=C2=A0 =C2=A00.0=C2=A0 =C2=A00:00.23<br>
&gt;<br>
&gt; This top output for `localhost` seems very different than the output f=
or<br>
&gt; `localhost` in your previous message.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 &gt; lttng-r+<br>
&gt;=C2=A0 &gt; root@localhost:~# nrpco<br>
&gt;=C2=A0 &gt; bash: nrpco: command not found<br>
&gt;=C2=A0 &gt; root@localhost:~# nproc<br>
&gt;=C2=A0 &gt; 16<br>
&gt;=C2=A0 &gt; root@localhost:~# cat /sys/devices/system/cpu/possible<br>
&gt;=C2=A0 &gt; 0-15<br>
&gt;=C2=A0 &gt;<br>
&gt;<br>
&gt; You indicated the bookworm machine has 32 cores, this is showing 16. I=
f<br>
&gt; you&#39;re comparing a 16 core machine to a 32 core machine, it is ver=
y<br>
&gt; normal that the memory usage is higher on the 32 core machine.<br>
&gt;<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; Most of the process are running as asorcs user but some are=
 running<br>
&gt; as root.<br>
&gt;<br>
&gt; So you have two users with instrumented applications.<br>
&gt;<br>
&gt;<br>
&gt; Given the discrepancies in the information provided I&#39;m finding it=
 a bit<br>
&gt; hard to understand what you&#39;re looking at.<br>
&gt;<br>
&gt;<br>
&gt; In general, a channel&#39;s shared memory footprint can be estimated w=
ith[1]:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is =
enabled) *<br>
&gt; (nUIDs or nPIDs)<br>
&gt;<br>
&gt; Note that the sub-buffer sizes you are using get rounded to the neares=
t<br>
&gt; larger power of 2. See [2].<br>
&gt;<br>
&gt; thanks,<br>
&gt; kienan<br>
&gt;<br>
&gt; [1]: <a href=3D"https://lttng.org/docs/v2.13/#doc-channel-buffering-sc=
hemes" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.13/#d=
oc-channel-buffering-schemes</a><br>
&gt; [2]:<br>
&gt; <a href=3D"https://lttng.org/man/1/lttng-enable-channel/v2.13/#doc-opt=
--subbuf-size" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/man/1=
/lttng-enable-channel/v2.13/#doc-opt--subbuf-size</a><br>
&gt;<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
URL: &lt;<a href=3D"https://lists.lttng.org/pipermail/lttng-dev/attachments=
/20250312/57f240d8/attachment-0001.htm" rel=3D"noreferrer" target=3D"_blank=
">https://lists.lttng.org/pipermail/lttng-dev/attachments/20250312/57f240d8=
/attachment-0001.htm</a>&gt;<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Wed, 12 Mar 2025 10:36:28 -0400<br>
From: Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com" target=3D=
"_blank">kstewart@efficios.com</a>&gt;<br>
To: Gour DEV &lt;<a href=3D"mailto:lakshyagour10@gmail.com" target=3D"_blan=
k">lakshyagour10@gmail.com</a>&gt;, <a href=3D"mailto:lttng-dev@lists.lttng=
.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br>
Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10<br>
Message-ID: &lt;<a href=3D"mailto:0f819583-ea8e-468e-9102-e1410d886a6f@effi=
cios.com" target=3D"_blank">0f819583-ea8e-468e-9102-e1410d886a6f@efficios.c=
om</a>&gt;<br>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed<br>
<br>
Hi Lakshya,<br>
<br>
On 3/12/25 5:03 AM, Gour DEV wrote:<br>
&gt; Hi, Kienan<br>
&gt; <br>
&gt; I am attaching an screen recording of the behaviour I am seeing in thi=
s<br>
&gt; mail. The behaviour is same irrespective of the device i use, sorry fo=
r<br>
&gt; miscommunication in the npocs output (I assumed it was 32), but other =
than<br>
&gt; that all outputs are same (except the hostname as there are multiple<b=
r>
&gt; devices with same lttng config but this memory cosumption is seen on a=
ll<br>
&gt; the devices).<br>
&gt; <br>
&gt; I had few question<br>
&gt; <br>
&gt; 1. Does lltng allocated all the memory it needs and mark it as dirty i=
n ram<br>
&gt; when any process which links/uses lttng-ust runs? (here i tried with o=
ne<br>
&gt; process but it is same for any of my process)<br>
<br>
I believe the shared memory for per-CPU data structures is allocated <br>
when an instrumented application connects. There is no pre-allocation <br>
for each possible UID on the system.<br>
<br>
You can run your instrumented applications with `LTTNG_UST_DEBUG=3D1` to <b=
r>
see when the connection happens[1].<br>
<br>
&gt; 2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *=
<br>
&gt; (nUIDs or nPIDs)<br>
&gt; <br>
&gt; How do we calculate uid in the system is it all uids in the system? is=
 it<br>
&gt; equal to `cat /etc/passwd | wc -l` ?<br>
<br>
nUIDs is the number of distinct UIDs running instrumented applications.<br>
<br>
&gt; <br>
&gt; I will put my calculations according to the above estimate based on al=
l the<br>
&gt; channel i am creating<br>
&gt; <br>
&gt; (4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are equal=
 to<br>
&gt; `cat /etc/passwd | wc -l`)B =3D 7.998046875 GB approx [this is based o=
n the<br>
&gt; start_lttng.py please do correct me if am wrong here.]<br>
&gt; <br>
&gt; But since there are only two users which uses lttng i think the correc=
t<br>
&gt; estimate would be<br>
&gt; (4194304*4 + 262144*4 + 16384*4) * (16) * (2)B =3D 546MB<br>
<br>
The estimate I gave is per-channel.<br>
<br>
small channel: (0.015625 MiB * 4) * (16 + 1) =3D 1.0625 MiB per-channel <br=
>
per-UID<br>
medium channel: (0.250 MiB * 4) * (16 + 1) =3D 17.0 MiB per-channel per-UID=
<br>
large channel: (4 MiB * 4) * (16 + 1) =3D 27 2MiB per-channel per-UID<br>
<br>
Now, you said you have 0 small channels, 6 medium channels, and 16 large <b=
r>
channels in your session. (Note: I see your script differs from these <br>
stated channel counts).<br>
<br>
small: 0 * 1.0625 MiB =3D 0 MiB per-UID<br>
medium: 6 * 17 MiB =3D 102 MiB per-UID<br>
large: 16 * 272 MiB =3D 4352 MiB per-UID<br>
<br>
And if you&#39;re running instrumented applications with 2 users:<br>
<br>
small: 0 MiB * 2 =3D 0 MiB with 2 UIDs<br>
medium: 102 MiB * 2 =3D 204 MiB with 2 UIDs<br>
large: 4352 MiB * 2 =3D 8704 MiB with 2 UIDs<br>
<br>
Now this is just an estimation for the per-CPU ring buffers only, and <br>
you numbers aren&#39;t hugely off so without analyzing your specific system=
 <br>
it doesn&#39;t seem to be that strange to me.<br>
<br>
If I take the number of channels I see in your script, it becomes:<br>
<br>
small: 0 MiB with 2 UIDs<br>
medium: 136 MiB with 2 UIDs<br>
large: 7616 MiB with 2 UIDs<br>
<br>
total: 7.57 GiB with 2 UIDs<br>
<br>
&gt; <br>
&gt; Please do correct me If I am wrong calculations here.<br>
&gt; <br>
&gt; Now, there are a few things here, according to my output lttng is usin=
g 11G<br>
&gt; which is much more higher than the what is configured.<br>
&gt; <br>
<br>
I have no idea what &#39;service start spyder&#39; is doing. Maybe it&#39;s=
 running <br>
instrumented applications with an extra user that you didn&#39;t expect? I =
<br>
can&#39;t help you with that aspect of your system.<br>
<br>
The above estimated 7.57 GiB with 2 UIDs would be 11.35 GiB with 3 UIDs <br=
>
so maybe?<br>
<br>
I&#39;d recommend you read your verbose sessiond log so see which <br>
applications are connecting and with which UIDs.<br>
<br>
&gt; I am attaching the lttng status and the file which is uses to create t=
he<br>
&gt; lttng sessions.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Thank You.<br>
&gt; <br>
<br>
In any case, the information you have given to date hasn&#39;t demonstrated=
 <br>
to me in a tangible manner that you are seeing a difference related to <br>
the version of LTTng being used.<br>
<br>
thanks,<br>
kienan<br>
<br>
[1]: <a href=3D"https://lttng.org/man/3/lttng-ust/v2.13/#doc-_environment_v=
ariables" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/man/3/lttn=
g-ust/v2.13/#doc-_environment_variables</a><br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
<br>
<br>
------------------------------<br>
<br>
End of lttng-dev Digest, Vol 203, Issue 7<br>
*****************************************<br>
</blockquote></div>

--0000000000000a461c063083edbd--

--0000000000000a461d063083edbf
Content-Type: application/octet-stream; name=lttng_status_bookwomr
Content-Disposition: attachment; filename=lttng_status_bookwomr
Content-Transfer-Encoding: base64
Content-ID: <f_m8cnu0c20>
X-Attachment-Id: f_m8cnu0c20

UmVjb3JkaW5nIHNlc3Npb24gZGVmYXVsdDogW2FjdGl2ZSBzbmFwc2hvdF0KPT09IERvbWFpbjog
VXNlciBzcGFjZSA9PT0KCkJ1ZmZlcmluZyBzY2hlbWU6IHBlci11c2VyCgpUcmFja2VkIHByb2Nl
c3MgYXR0cmlidXRlcwogIFZpcnR1YWwgcHJvY2VzcyBJRHM6ICBhbGwKICBWaXJ0dWFsIHVzZXIg
SURzOiAgICAgYWxsCiAgVmlydHVhbCBncm91cCBJRHM6ICAgIGFsbAoKQ2hhbm5lbHM6Ci0tLS0t
LS0tLS0tLS0KLSBsMnJpYi1hbGw6IFtlbmFibGVkXQoKICAgIEF0dHJpYnV0ZXM6CiAgICAgIEV2
ZW50LWxvc3MgbW9kZTogIG92ZXJ3cml0ZQogICAgICBTdWItYnVmZmVyIHNpemU6ICA0MTk0MzA0
IGJ5dGVzCiAgICAgIFN1Yi1idWZmZXIgY291bnQ6IDQKICAgICAgU3dpdGNoIHRpbWVyOiAgICAg
aW5hY3RpdmUKICAgICAgUmVhZCB0aW1lcjogICAgICAgaW5hY3RpdmUKICAgICAgTW9uaXRvciB0
aW1lcjogICAgMTAwMDAwMCB1cwogICAgICBUcmFjZSBmaWxlIGNvdW50OiAxIHBlciBzdHJlYW0K
ICAgICAgVHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVkCiAgICAgIE91dHB1dCBtb2RlOiAgICAg
IG1tYXAKCiAgICBTdGF0aXN0aWNzOgogICAgICBOb25lCgogICAgUmVjb3JkaW5nIGV2ZW50IHJ1
bGVzOgogICAgICBsMnJpYiogKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0
eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KCi0gYmdwLWVycm9yOiBbZW5hYmxlZF0KCiAgICBB
dHRyaWJ1dGVzOgogICAgICBFdmVudC1sb3NzIG1vZGU6ICBvdmVyd3JpdGUKICAgICAgU3ViLWJ1
ZmZlciBzaXplOiAgNDE5NDMwNCBieXRlcwogICAgICBTdWItYnVmZmVyIGNvdW50OiA0CiAgICAg
IFN3aXRjaCB0aW1lcjogICAgIGluYWN0aXZlCiAgICAgIFJlYWQgdGltZXI6ICAgICAgIGluYWN0
aXZlCiAgICAgIE1vbml0b3IgdGltZXI6ICAgIDEwMDAwMDAgdXMKICAgICAgVHJhY2UgZmlsZSBj
b3VudDogMSBwZXIgc3RyZWFtCiAgICAgIFRyYWNlIGZpbGUgc2l6ZTogIHVubGltaXRlZAogICAg
ICBPdXRwdXQgbW9kZTogICAgICBtbWFwCgogICAgU3RhdGlzdGljczoKICAgICAgTm9uZQoKICAg
IFJlY29yZGluZyBldmVudCBydWxlczoKICAgICAgYmdwOmJncF9lcnJvciAobG9nbGV2ZWwgPD0g
VFJBQ0VfRVJSICgzKSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQoKLSBmaWItZXZlbnQ6
IFtlbmFibGVkXQoKICAgIEF0dHJpYnV0ZXM6CiAgICAgIEV2ZW50LWxvc3MgbW9kZTogIG92ZXJ3
cml0ZQogICAgICBTdWItYnVmZmVyIHNpemU6ICA0MTk0MzA0IGJ5dGVzCiAgICAgIFN1Yi1idWZm
ZXIgY291bnQ6IDQKICAgICAgU3dpdGNoIHRpbWVyOiAgICAgaW5hY3RpdmUKICAgICAgUmVhZCB0
aW1lcjogICAgICAgaW5hY3RpdmUKICAgICAgTW9uaXRvciB0aW1lcjogICAgMTAwMDAwMCB1cwog
ICAgICBUcmFjZSBmaWxlIGNvdW50OiAxIHBlciBzdHJlYW0KICAgICAgVHJhY2UgZmlsZSBzaXpl
OiAgdW5saW1pdGVkCiAgICAgIE91dHB1dCBtb2RlOiAgICAgIG1tYXAKCiAgICBTdGF0aXN0aWNz
OgogICAgICBOb25lCgogICAgUmVjb3JkaW5nIGV2ZW50IHJ1bGVzOgogICAgICBmaWIqIChsb2ds
ZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJs
ZWRdCgotIHN0cC1hbGw6IFtlbmFibGVkXQoKICAgIEF0dHJpYnV0ZXM6CiAgICAgIEV2ZW50LWxv
c3MgbW9kZTogIG92ZXJ3cml0ZQogICAgICBTdWItYnVmZmVyIHNpemU6ICA0MTk0MzA0IGJ5dGVz
CiAgICAgIFN1Yi1idWZmZXIgY291bnQ6IDQKICAgICAgU3dpdGNoIHRpbWVyOiAgICAgaW5hY3Rp
dmUKICAgICAgUmVhZCB0aW1lcjogICAgICAgaW5hY3RpdmUKICAgICAgTW9uaXRvciB0aW1lcjog
ICAgMTAwMDAwMCB1cwogICAgICBUcmFjZSBmaWxlIGNvdW50OiAxIHBlciBzdHJlYW0KICAgICAg
VHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVkCiAgICAgIE91dHB1dCBtb2RlOiAgICAgIG1tYXAK
CiAgICBTdGF0aXN0aWNzOgogICAgICBOb25lCgogICAgUmVjb3JkaW5nIGV2ZW50IHJ1bGVzOgog
ICAgICBzdHAqIChsb2dsZXZlbCA8PSBUUkFDRV9ERUJVR19MSU5FICgxMykpICh0eXBlOiB0cmFj
ZXBvaW50KSBbZW5hYmxlZF0KCi0gbWFjLWV2ZW50OiBbZW5hYmxlZF0KCiAgICBBdHRyaWJ1dGVz
OgogICAgICBFdmVudC1sb3NzIG1vZGU6ICBvdmVyd3JpdGUKICAgICAgU3ViLWJ1ZmZlciBzaXpl
OiAgMjYyMTQ0IGJ5dGVzCiAgICAgIFN1Yi1idWZmZXIgY291bnQ6IDQKICAgICAgU3dpdGNoIHRp
bWVyOiAgICAgaW5hY3RpdmUKICAgICAgUmVhZCB0aW1lcjogICAgICAgaW5hY3RpdmUKICAgICAg
TW9uaXRvciB0aW1lcjogICAgMTAwMDAwMCB1cwogICAgICBUcmFjZSBmaWxlIGNvdW50OiAxIHBl
ciBzdHJlYW0KICAgICAgVHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVkCiAgICAgIE91dHB1dCBt
b2RlOiAgICAgIG1tYXAKCiAgICBTdGF0aXN0aWNzOgogICAgICBOb25lCgogICAgUmVjb3JkaW5n
IGV2ZW50IHJ1bGVzOgogICAgICBtYWMqIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0g
KDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCgotIGZpYi1pbmZvOiBbZW5hYmxlZF0K
CiAgICBBdHRyaWJ1dGVzOgogICAgICBFdmVudC1sb3NzIG1vZGU6ICBvdmVyd3JpdGUKICAgICAg
U3ViLWJ1ZmZlciBzaXplOiAgMjYyMTQ0IGJ5dGVzCiAgICAgIFN1Yi1idWZmZXIgY291bnQ6IDQK
ICAgICAgU3dpdGNoIHRpbWVyOiAgICAgaW5hY3RpdmUKICAgICAgUmVhZCB0aW1lcjogICAgICAg
aW5hY3RpdmUKICAgICAgTW9uaXRvciB0aW1lcjogICAgMTAwMDAwMCB1cwogICAgICBUcmFjZSBm
aWxlIGNvdW50OiAxIHBlciBzdHJlYW0KICAgICAgVHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVk
CiAgICAgIE91dHB1dCBtb2RlOiAgICAgIG1tYXAKCiAgICBTdGF0aXN0aWNzOgogICAgICBOb25l
CgogICAgUmVjb3JkaW5nIGV2ZW50IHJ1bGVzOgogICAgICBmaWIqIChsb2dsZXZlbCA9PSBUUkFD
RV9ERUJVR19QUk9DRVNTICg5KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQoKLSBkcGFs
LWV2ZW50OiBbZW5hYmxlZF0KCiAgICBBdHRyaWJ1dGVzOgogICAgICBFdmVudC1sb3NzIG1vZGU6
ICBvdmVyd3JpdGUKICAgICAgU3ViLWJ1ZmZlciBzaXplOiAgNDE5NDMwNCBieXRlcwogICAgICBT
dWItYnVmZmVyIGNvdW50OiA0CiAgICAgIFN3aXRjaCB0aW1lcjogICAgIGluYWN0aXZlCiAgICAg
IFJlYWQgdGltZXI6ICAgICAgIGluYWN0aXZlCiAgICAgIE1vbml0b3IgdGltZXI6ICAgIDEwMDAw
MDAgdXMKICAgICAgVHJhY2UgZmlsZSBjb3VudDogMSBwZXIgc3RyZWFtCiAgICAgIFRyYWNlIGZp
bGUgc2l6ZTogIHVubGltaXRlZAogICAgICBPdXRwdXQgbW9kZTogICAgICBtbWFwCgogICAgU3Rh
dGlzdGljczoKICAgICAgTm9uZQoKICAgIFJlY29yZGluZyBldmVudCBydWxlczoKICAgICAgYmNt
KiAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQp
IFtlbmFibGVkXQogICAgICBseGsqIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcp
KSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGRwYWwqIChsb2dsZXZlbCA9PSBU
UkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCgotIGJn
cC1ldmVudHM6IFtlbmFibGVkXQoKICAgIEF0dHJpYnV0ZXM6CiAgICAgIEV2ZW50LWxvc3MgbW9k
ZTogIG92ZXJ3cml0ZQogICAgICBTdWItYnVmZmVyIHNpemU6ICA0MTk0MzA0IGJ5dGVzCiAgICAg
IFN1Yi1idWZmZXIgY291bnQ6IDQKICAgICAgU3dpdGNoIHRpbWVyOiAgICAgaW5hY3RpdmUKICAg
ICAgUmVhZCB0aW1lcjogICAgICAgaW5hY3RpdmUKICAgICAgTW9uaXRvciB0aW1lcjogICAgMTAw
MDAwMCB1cwogICAgICBUcmFjZSBmaWxlIGNvdW50OiAxIHBlciBzdHJlYW0KICAgICAgVHJhY2Ug
ZmlsZSBzaXplOiAgdW5saW1pdGVkCiAgICAgIE91dHB1dCBtb2RlOiAgICAgIG1tYXAKCiAgICBT
dGF0aXN0aWNzOgogICAgICBOb25lCgogICAgUmVjb3JkaW5nIGV2ZW50IHJ1bGVzOgogICAgICBi
Z3A6YmdwX2V2X2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlw
ZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGJncDpiZ3BfbmV0bGlua19kZWJ1ZyAobG9n
bGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFi
bGVkXQogICAgICBiZ3A6YmdwX3dhcm4gKGxvZ2xldmVsIDw9IFRSQUNFX1dBUk5JTkcgKDQpKSAo
dHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGJncDpiZ3BfaW5mbyAobG9nbGV2ZWwg
PD0gVFJBQ0VfSU5GTyAoNikpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgYmdw
OmJncF9jbGVhbnVwX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAo
dHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGJncDpiZ3BfbmJyX2RlYnVnIChsb2ds
ZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJs
ZWRdCiAgICAgIGJncDpiZ3BfaGFfZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RF
TSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgYmdwOmJncF9uZXh0aG9w
X2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vw
b2ludCkgW2VuYWJsZWRdCiAgICAgIGJncDpiZ3BfbmJyYWxsX2RlYnVnIChsb2dsZXZlbCA9PSBU
UkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAg
IGJncDpiZ3BfbGFiZWxfZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykp
ICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgYmdwOmJncF9kZWJ1ZyAobG9nbGV2
ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVk
XQoKLSBsZHAtYWxsOiBbZW5hYmxlZF0KCiAgICBBdHRyaWJ1dGVzOgogICAgICBFdmVudC1sb3Nz
IG1vZGU6ICBvdmVyd3JpdGUKICAgICAgU3ViLWJ1ZmZlciBzaXplOiAgNDE5NDMwNCBieXRlcwog
ICAgICBTdWItYnVmZmVyIGNvdW50OiA0CiAgICAgIFN3aXRjaCB0aW1lcjogICAgIGluYWN0aXZl
CiAgICAgIFJlYWQgdGltZXI6ICAgICAgIGluYWN0aXZlCiAgICAgIE1vbml0b3IgdGltZXI6ICAg
IDEwMDAwMDAgdXMKICAgICAgVHJhY2UgZmlsZSBjb3VudDogMSBwZXIgc3RyZWFtCiAgICAgIFRy
YWNlIGZpbGUgc2l6ZTogIHVubGltaXRlZAogICAgICBPdXRwdXQgbW9kZTogICAgICBtbWFwCgog
ICAgU3RhdGlzdGljczoKICAgICAgTm9uZQoKICAgIFJlY29yZGluZyBldmVudCBydWxlczoKICAg
ICAgbGRwKiAobG9nbGV2ZWwgPD0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNl
cG9pbnQpIFtlbmFibGVkXQoKLSByaWItZXJyb3I6IFtlbmFibGVkXQoKICAgIEF0dHJpYnV0ZXM6
CiAgICAgIEV2ZW50LWxvc3MgbW9kZTogIG92ZXJ3cml0ZQogICAgICBTdWItYnVmZmVyIHNpemU6
ICA0MTk0MzA0IGJ5dGVzCiAgICAgIFN1Yi1idWZmZXIgY291bnQ6IDQKICAgICAgU3dpdGNoIHRp
bWVyOiAgICAgaW5hY3RpdmUKICAgICAgUmVhZCB0aW1lcjogICAgICAgaW5hY3RpdmUKICAgICAg
TW9uaXRvciB0aW1lcjogICAgMTAwMDAwMCB1cwogICAgICBUcmFjZSBmaWxlIGNvdW50OiAxIHBl
ciBzdHJlYW0KICAgICAgVHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVkCiAgICAgIE91dHB1dCBt
b2RlOiAgICAgIG1tYXAKCiAgICBTdGF0aXN0aWNzOgogICAgICBOb25lCgogICAgUmVjb3JkaW5n
IGV2ZW50IHJ1bGVzOgogICAgICByaWI6cmliX2Vycm9yIChsb2dsZXZlbCA8PSBUUkFDRV9FUlIg
KDMpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCgotIG90aGVyLWVycm9yOiBbZW5hYmxl
ZF0KCiAgICBBdHRyaWJ1dGVzOgogICAgICBFdmVudC1sb3NzIG1vZGU6ICBvdmVyd3JpdGUKICAg
ICAgU3ViLWJ1ZmZlciBzaXplOiAgNDE5NDMwNCBieXRlcwogICAgICBTdWItYnVmZmVyIGNvdW50
OiA0CiAgICAgIFN3aXRjaCB0aW1lcjogICAgIGluYWN0aXZlCiAgICAgIFJlYWQgdGltZXI6ICAg
ICAgIGluYWN0aXZlCiAgICAgIE1vbml0b3IgdGltZXI6ICAgIDEwMDAwMDAgdXMKICAgICAgVHJh
Y2UgZmlsZSBjb3VudDogMSBwZXIgc3RyZWFtCiAgICAgIFRyYWNlIGZpbGUgc2l6ZTogIHVubGlt
aXRlZAogICAgICBPdXRwdXQgbW9kZTogICAgICBtbWFwCgogICAgU3RhdGlzdGljczoKICAgICAg
Tm9uZQoKICAgIFJlY29yZGluZyBldmVudCBydWxlczoKICAgICAgbWJyb2tlciogKGxvZ2xldmVs
IDw9IFRSQUNFX0VSUiAoMykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAga2Vy
bmVsX3NwaWVsOmVycm9yIChsb2dsZXZlbCA8PSBUUkFDRV9FUlIgKDMpKSAodHlwZTogdHJhY2Vw
b2ludCkgW2VuYWJsZWRdCiAgICAgIGlmbWdyOmlmbWdyX2Vycm9yIChsb2dsZXZlbCA8PSBUUkFD
RV9FUlIgKDMpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIHZycnA6ZXJyb3Ig
KGxvZ2xldmVsIDw9IFRSQUNFX0VSUiAoMykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0K
ICAgICAgYWRqOmFkal9lcnJvciAobG9nbGV2ZWwgPD0gVFJBQ0VfRVJSICgzKSkgKHR5cGU6IHRy
YWNlcG9pbnQpIFtlbmFibGVkXQoKLSBtYWMtZXJyOiBbZW5hYmxlZF0KCiAgICBBdHRyaWJ1dGVz
OgogICAgICBFdmVudC1sb3NzIG1vZGU6ICBvdmVyd3JpdGUKICAgICAgU3ViLWJ1ZmZlciBzaXpl
OiAgMjYyMTQ0IGJ5dGVzCiAgICAgIFN1Yi1idWZmZXIgY291bnQ6IDQKICAgICAgU3dpdGNoIHRp
bWVyOiAgICAgaW5hY3RpdmUKICAgICAgUmVhZCB0aW1lcjogICAgICAgaW5hY3RpdmUKICAgICAg
TW9uaXRvciB0aW1lcjogICAgMTAwMDAwMCB1cwogICAgICBUcmFjZSBmaWxlIGNvdW50OiAxIHBl
ciBzdHJlYW0KICAgICAgVHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVkCiAgICAgIE91dHB1dCBt
b2RlOiAgICAgIG1tYXAKCiAgICBTdGF0aXN0aWNzOgogICAgICBOb25lCgogICAgUmVjb3JkaW5n
IGV2ZW50IHJ1bGVzOgogICAgICBtYWMqIChsb2dsZXZlbCA8PSBUUkFDRV9FUlIgKDMpKSAodHlw
ZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCgotIG90aGVyLWV2ZW50OiBbZW5hYmxlZF0KCiAgICBB
dHRyaWJ1dGVzOgogICAgICBFdmVudC1sb3NzIG1vZGU6ICBvdmVyd3JpdGUKICAgICAgU3ViLWJ1
ZmZlciBzaXplOiAgNDE5NDMwNCBieXRlcwogICAgICBTdWItYnVmZmVyIGNvdW50OiA0CiAgICAg
IFN3aXRjaCB0aW1lcjogICAgIGluYWN0aXZlCiAgICAgIFJlYWQgdGltZXI6ICAgICAgIGluYWN0
aXZlCiAgICAgIE1vbml0b3IgdGltZXI6ICAgIDEwMDAwMDAgdXMKICAgICAgVHJhY2UgZmlsZSBj
b3VudDogMSBwZXIgc3RyZWFtCiAgICAgIFRyYWNlIGZpbGUgc2l6ZTogIHVubGltaXRlZAogICAg
ICBPdXRwdXQgbW9kZTogICAgICBtbWFwCgogICAgU3RhdGlzdGljczoKICAgICAgTm9uZQoKICAg
IFJlY29yZGluZyBldmVudCBydWxlczoKICAgICAgbWJyb2tlciogKGxvZ2xldmVsID09IFRSQUNF
X0RFQlVHX01PRFVMRSAoMTApKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGRy
YSogKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX01PRFVMRSAoMTApKSAodHlwZTogdHJhY2Vwb2lu
dCkgW2VuYWJsZWRdCiAgICAgIHZycnA6ZHBhbF9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVC
VUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBhZGo6bmxf
ZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBv
aW50KSBbZW5hYmxlZF0KICAgICAgdnJycDpldl9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVC
VUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBpZm1ncjpz
dGFydHVwX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTog
dHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIHJhZCogKGxvZ2xldmVsID09IFRSQUNFX0RFQlVH
X01PRFVMRSAoMTApKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGtlcm5lbF9z
cGllbDp3YXJuIChsb2dsZXZlbCA8PSBUUkFDRV9XQVJOSU5HICg0KSkgKHR5cGU6IHRyYWNlcG9p
bnQpIFtlbmFibGVkXQogICAgICBrZXJuZWxfc3BpZWw6ZGVidWcgKGxvZ2xldmVsIDw9IFRSQUNF
X0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgbXBy
b3h5KiAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfTU9EVUxFICgxMCkpICh0eXBlOiB0cmFjZXBv
aW50KSBbZW5hYmxlZF0KICAgICAgdnJycDppbnRmX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9E
RUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGlmbWdy
OmlmbWdyX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTog
dHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGFkajphZGpfaXB2NiAobG9nbGV2ZWwgPT0gVFJB
Q0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBh
ZGo6YWRqX2lwdjQgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0
cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgaWZtZ3I6aWZfc3RhdGUgKGxvZ2xldmVsID09IFRS
QUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAg
YWRqOnN0YXJ0dXBfZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0
eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KCi0gYmdwLXVwZGF0ZXM6IFtlbmFibGVkXQoKICAg
IEF0dHJpYnV0ZXM6CiAgICAgIEV2ZW50LWxvc3MgbW9kZTogIG92ZXJ3cml0ZQogICAgICBTdWIt
YnVmZmVyIHNpemU6ICA0MTk0MzA0IGJ5dGVzCiAgICAgIFN1Yi1idWZmZXIgY291bnQ6IDQKICAg
ICAgU3dpdGNoIHRpbWVyOiAgICAgaW5hY3RpdmUKICAgICAgUmVhZCB0aW1lcjogICAgICAgaW5h
Y3RpdmUKICAgICAgTW9uaXRvciB0aW1lcjogICAgMTAwMDAwMCB1cwogICAgICBUcmFjZSBmaWxl
IGNvdW50OiAxIHBlciBzdHJlYW0KICAgICAgVHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVkCiAg
ICAgIE91dHB1dCBtb2RlOiAgICAgIG1tYXAKCiAgICBTdGF0aXN0aWNzOgogICAgICBOb25lCgog
ICAgUmVjb3JkaW5nIGV2ZW50IHJ1bGVzOgogICAgICBiZ3A6YmdwX3Jwb2xfZGVidWcgKGxvZ2xl
dmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxl
ZF0KICAgICAgYmdwOmJncF9ubHJpX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNU
RU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGJncDpiZ3BfYXR0cnNf
ZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBv
aW50KSBbZW5hYmxlZF0KICAgICAgYmdwOmJncF9yaWJfZGVidWcgKGxvZ2xldmVsID09IFRSQUNF
X0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgYmdw
OmJncF90dW5uZWxfZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0
eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgYmdwOmJncF9pbXBvcnRfZGVidWcgKGxv
Z2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5h
YmxlZF0KICAgICAgYmdwOmJncF91cGRhdGVpbl9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVC
VUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBiZ3A6Ymdw
X3VwZGF0ZW91dF9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5
cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBiZ3A6YmdwX2V4cG9ydF9kZWJ1ZyAobG9n
bGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFi
bGVkXQoKLSBkcGFsLWVycm9yOiBbZW5hYmxlZF0KCiAgICBBdHRyaWJ1dGVzOgogICAgICBFdmVu
dC1sb3NzIG1vZGU6ICBvdmVyd3JpdGUKICAgICAgU3ViLWJ1ZmZlciBzaXplOiAgNDE5NDMwNCBi
eXRlcwogICAgICBTdWItYnVmZmVyIGNvdW50OiA0CiAgICAgIFN3aXRjaCB0aW1lcjogICAgIGlu
YWN0aXZlCiAgICAgIFJlYWQgdGltZXI6ICAgICAgIGluYWN0aXZlCiAgICAgIE1vbml0b3IgdGlt
ZXI6ICAgIDEwMDAwMDAgdXMKICAgICAgVHJhY2UgZmlsZSBjb3VudDogMSBwZXIgc3RyZWFtCiAg
ICAgIFRyYWNlIGZpbGUgc2l6ZTogIHVubGltaXRlZAogICAgICBPdXRwdXQgbW9kZTogICAgICBt
bWFwCgogICAgU3RhdGlzdGljczoKICAgICAgTm9uZQoKICAgIFJlY29yZGluZyBldmVudCBydWxl
czoKICAgICAgYmNtKiAobG9nbGV2ZWwgPD0gVFJBQ0VfRVJSICgzKSkgKHR5cGU6IHRyYWNlcG9p
bnQpIFtlbmFibGVkXQogICAgICBseGsqIChsb2dsZXZlbCA8PSBUUkFDRV9FUlIgKDMpKSAodHlw
ZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGRwYWwqIChsb2dsZXZlbCA8PSBUUkFDRV9F
UlIgKDMpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCgotIGZpYi1lcnJvcjogW2VuYWJs
ZWRdCgogICAgQXR0cmlidXRlczoKICAgICAgRXZlbnQtbG9zcyBtb2RlOiAgb3ZlcndyaXRlCiAg
ICAgIFN1Yi1idWZmZXIgc2l6ZTogIDQxOTQzMDQgYnl0ZXMKICAgICAgU3ViLWJ1ZmZlciBjb3Vu
dDogNAogICAgICBTd2l0Y2ggdGltZXI6ICAgICBpbmFjdGl2ZQogICAgICBSZWFkIHRpbWVyOiAg
ICAgICBpbmFjdGl2ZQogICAgICBNb25pdG9yIHRpbWVyOiAgICAxMDAwMDAwIHVzCiAgICAgIFRy
YWNlIGZpbGUgY291bnQ6IDEgcGVyIHN0cmVhbQogICAgICBUcmFjZSBmaWxlIHNpemU6ICB1bmxp
bWl0ZWQKICAgICAgT3V0cHV0IG1vZGU6ICAgICAgbW1hcAoKICAgIFN0YXRpc3RpY3M6CiAgICAg
IE5vbmUKCiAgICBSZWNvcmRpbmcgZXZlbnQgcnVsZXM6CiAgICAgIGZpYiogKGxvZ2xldmVsIDw9
IFRSQUNFX0VSUiAoMykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KCi0gcmliLWV2ZW50
OiBbZW5hYmxlZF0KCiAgICBBdHRyaWJ1dGVzOgogICAgICBFdmVudC1sb3NzIG1vZGU6ICBvdmVy
d3JpdGUKICAgICAgU3ViLWJ1ZmZlciBzaXplOiAgNDE5NDMwNCBieXRlcwogICAgICBTdWItYnVm
ZmVyIGNvdW50OiA0CiAgICAgIFN3aXRjaCB0aW1lcjogICAgIGluYWN0aXZlCiAgICAgIFJlYWQg
dGltZXI6ICAgICAgIGluYWN0aXZlCiAgICAgIE1vbml0b3IgdGltZXI6ICAgIDEwMDAwMDAgdXMK
ICAgICAgVHJhY2UgZmlsZSBjb3VudDogMSBwZXIgc3RyZWFtCiAgICAgIFRyYWNlIGZpbGUgc2l6
ZTogIHVubGltaXRlZAogICAgICBPdXRwdXQgbW9kZTogICAgICBtbWFwCgogICAgU3RhdGlzdGlj
czoKICAgICAgTm9uZQoKICAgIFJlY29yZGluZyBldmVudCBydWxlczoKICAgICAgcmliOnJpYl90
dW5uZWxfdGVybWluYXRpb25fZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAo
NykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgcmliOnJpYl9zaWRfZGVidWcg
KGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBb
ZW5hYmxlZF0KICAgICAgcmliOnJpYl92Nl9pZ3Bfcm5oX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFD
RV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIHJp
YjpyaWJfNHY0cGF0aF9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkg
KHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICByaWI6cmliX3Y0X3RubF9kZWJ1ZyAo
bG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtl
bmFibGVkXQogICAgICByaWI6cmliX3Y0cnRfZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVH
X1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgcmliOnJpYl9p
bG1fZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFj
ZXBvaW50KSBbZW5hYmxlZF0KICAgICAgcmliOnJpYl9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0Vf
REVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICByaWI6
cmliX3Y2cnRfZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBl
OiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgcmliOnN0YXJ0dXBfZGVidWcgKGxvZ2xldmVs
ID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0K
ICAgICAgcmliOnJpYl92NF9pZ3Bfcm5oX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19T
WVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIHJpYl82djZwYXRo
X2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vw
b2ludCkgW2VuYWJsZWRdCiAgICAgIHJpYjpyaWJfdjZfdG5sX2RlYnVnIChsb2dsZXZlbCA9PSBU
UkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCgotIGwy
Zi1hbGw6IFtlbmFibGVkXQoKICAgIEF0dHJpYnV0ZXM6CiAgICAgIEV2ZW50LWxvc3MgbW9kZTog
IG92ZXJ3cml0ZQogICAgICBTdWItYnVmZmVyIHNpemU6ICAyNjIxNDQgYnl0ZXMKICAgICAgU3Vi
LWJ1ZmZlciBjb3VudDogNAogICAgICBTd2l0Y2ggdGltZXI6ICAgICBpbmFjdGl2ZQogICAgICBS
ZWFkIHRpbWVyOiAgICAgICBpbmFjdGl2ZQogICAgICBNb25pdG9yIHRpbWVyOiAgICAxMDAwMDAw
IHVzCiAgICAgIFRyYWNlIGZpbGUgY291bnQ6IDEgcGVyIHN0cmVhbQogICAgICBUcmFjZSBmaWxl
IHNpemU6ICB1bmxpbWl0ZWQKICAgICAgT3V0cHV0IG1vZGU6ICAgICAgbW1hcAoKICAgIFN0YXRp
c3RpY3M6CiAgICAgIE5vbmUKCiAgICBSZWNvcmRpbmcgZXZlbnQgcnVsZXM6CiAgICAgIGwyZiog
KGxvZ2xldmVsIDw9IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBb
ZW5hYmxlZF0=
--0000000000000a461d063083edbf
Content-Type: application/octet-stream; name=lttng_status_buster
Content-Disposition: attachment; filename=lttng_status_buster
Content-Transfer-Encoding: base64
Content-ID: <f_m8cnu0cc1>
X-Attachment-Id: f_m8cnu0cc1

VHJhY2luZyBzZXNzaW9uIGRlZmF1bHQ6IFthY3RpdmUgc25hcHNob3RdCiAgICBUcmFjZSBwYXRo
OgoKPT09IERvbWFpbjogVVNUIGdsb2JhbCA9PT0KCkJ1ZmZlciB0eXBlOiBwZXIgVUlECgpDaGFu
bmVsczoKLS0tLS0tLS0tLS0tLQotIGZpYi1ldmVudDogW2VuYWJsZWRdCgogICAgQXR0cmlidXRl
czoKICAgICAgRXZlbnQtbG9zcyBtb2RlOiAgb3ZlcndyaXRlCiAgICAgIFN1Yi1idWZmZXIgc2l6
ZTogIDQxOTQzMDQgYnl0ZXMKICAgICAgU3ViLWJ1ZmZlciBjb3VudDogNAogICAgICBTd2l0Y2gg
dGltZXI6ICAgICBpbmFjdGl2ZQogICAgICBSZWFkIHRpbWVyOiAgICAgICBpbmFjdGl2ZQogICAg
ICBNb25pdG9yIHRpbWVyOiAgICAxMDAwMDAwIMK1cwogICAgICBUcmFjZSBmaWxlIGNvdW50OiAx
IHBlciBzdHJlYW0KICAgICAgVHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVkCiAgICAgIE91dHB1
dCBtb2RlOiAgICAgIG1tYXAKCiAgICBTdGF0aXN0aWNzOgogICAgICBOb25lCgogICAgRXZlbnQg
cnVsZXM6CiAgICAgIGZpYiogKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0
eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KCi0gZmliLWVycm9yOiBbZW5hYmxlZF0KCiAgICBB
dHRyaWJ1dGVzOgogICAgICBFdmVudC1sb3NzIG1vZGU6ICBvdmVyd3JpdGUKICAgICAgU3ViLWJ1
ZmZlciBzaXplOiAgNDE5NDMwNCBieXRlcwogICAgICBTdWItYnVmZmVyIGNvdW50OiA0CiAgICAg
IFN3aXRjaCB0aW1lcjogICAgIGluYWN0aXZlCiAgICAgIFJlYWQgdGltZXI6ICAgICAgIGluYWN0
aXZlCiAgICAgIE1vbml0b3IgdGltZXI6ICAgIDEwMDAwMDAgwrVzCiAgICAgIFRyYWNlIGZpbGUg
Y291bnQ6IDEgcGVyIHN0cmVhbQogICAgICBUcmFjZSBmaWxlIHNpemU6ICB1bmxpbWl0ZWQKICAg
ICAgT3V0cHV0IG1vZGU6ICAgICAgbW1hcAoKICAgIFN0YXRpc3RpY3M6CiAgICAgIE5vbmUKCiAg
ICBFdmVudCBydWxlczoKICAgICAgZmliKiAobG9nbGV2ZWwgPD0gVFJBQ0VfRVJSICgzKSkgKHR5
cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQoKLSBiZ3AtZXJyb3I6IFtlbmFibGVkXQoKICAgIEF0
dHJpYnV0ZXM6CiAgICAgIEV2ZW50LWxvc3MgbW9kZTogIG92ZXJ3cml0ZQogICAgICBTdWItYnVm
ZmVyIHNpemU6ICA0MTk0MzA0IGJ5dGVzCiAgICAgIFN1Yi1idWZmZXIgY291bnQ6IDQKICAgICAg
U3dpdGNoIHRpbWVyOiAgICAgaW5hY3RpdmUKICAgICAgUmVhZCB0aW1lcjogICAgICAgaW5hY3Rp
dmUKICAgICAgTW9uaXRvciB0aW1lcjogICAgMTAwMDAwMCDCtXMKICAgICAgVHJhY2UgZmlsZSBj
b3VudDogMSBwZXIgc3RyZWFtCiAgICAgIFRyYWNlIGZpbGUgc2l6ZTogIHVubGltaXRlZAogICAg
ICBPdXRwdXQgbW9kZTogICAgICBtbWFwCgogICAgU3RhdGlzdGljczoKICAgICAgTm9uZQoKICAg
IEV2ZW50IHJ1bGVzOgogICAgICBiZ3A6YmdwX2Vycm9yIChsb2dsZXZlbCA8PSBUUkFDRV9FUlIg
KDMpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCgotIGRwYWwtZXJyb3I6IFtlbmFibGVk
XQoKICAgIEF0dHJpYnV0ZXM6CiAgICAgIEV2ZW50LWxvc3MgbW9kZTogIG92ZXJ3cml0ZQogICAg
ICBTdWItYnVmZmVyIHNpemU6ICA0MTk0MzA0IGJ5dGVzCiAgICAgIFN1Yi1idWZmZXIgY291bnQ6
IDQKICAgICAgU3dpdGNoIHRpbWVyOiAgICAgaW5hY3RpdmUKICAgICAgUmVhZCB0aW1lcjogICAg
ICAgaW5hY3RpdmUKICAgICAgTW9uaXRvciB0aW1lcjogICAgMTAwMDAwMCDCtXMKICAgICAgVHJh
Y2UgZmlsZSBjb3VudDogMSBwZXIgc3RyZWFtCiAgICAgIFRyYWNlIGZpbGUgc2l6ZTogIHVubGlt
aXRlZAogICAgICBPdXRwdXQgbW9kZTogICAgICBtbWFwCgogICAgU3RhdGlzdGljczoKICAgICAg
Tm9uZQoKICAgIEV2ZW50IHJ1bGVzOgogICAgICBiY20qIChsb2dsZXZlbCA8PSBUUkFDRV9FUlIg
KDMpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGRwYWwqIChsb2dsZXZlbCA8
PSBUUkFDRV9FUlIgKDMpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGx4ayog
KGxvZ2xldmVsIDw9IFRSQUNFX0VSUiAoMykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0K
Ci0gbWFjLWVycjogW2VuYWJsZWRdCgogICAgQXR0cmlidXRlczoKICAgICAgRXZlbnQtbG9zcyBt
b2RlOiAgb3ZlcndyaXRlCiAgICAgIFN1Yi1idWZmZXIgc2l6ZTogIDI2MjE0NCBieXRlcwogICAg
ICBTdWItYnVmZmVyIGNvdW50OiA0CiAgICAgIFN3aXRjaCB0aW1lcjogICAgIGluYWN0aXZlCiAg
ICAgIFJlYWQgdGltZXI6ICAgICAgIGluYWN0aXZlCiAgICAgIE1vbml0b3IgdGltZXI6ICAgIDEw
MDAwMDAgwrVzCiAgICAgIFRyYWNlIGZpbGUgY291bnQ6IDEgcGVyIHN0cmVhbQogICAgICBUcmFj
ZSBmaWxlIHNpemU6ICB1bmxpbWl0ZWQKICAgICAgT3V0cHV0IG1vZGU6ICAgICAgbW1hcAoKICAg
IFN0YXRpc3RpY3M6CiAgICAgIE5vbmUKCiAgICBFdmVudCBydWxlczoKICAgICAgbWFjKiAobG9n
bGV2ZWwgPD0gVFJBQ0VfRVJSICgzKSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQoKLSBt
YWMtZXZlbnQ6IFtlbmFibGVkXQoKICAgIEF0dHJpYnV0ZXM6CiAgICAgIEV2ZW50LWxvc3MgbW9k
ZTogIG92ZXJ3cml0ZQogICAgICBTdWItYnVmZmVyIHNpemU6ICAyNjIxNDQgYnl0ZXMKICAgICAg
U3ViLWJ1ZmZlciBjb3VudDogNAogICAgICBTd2l0Y2ggdGltZXI6ICAgICBpbmFjdGl2ZQogICAg
ICBSZWFkIHRpbWVyOiAgICAgICBpbmFjdGl2ZQogICAgICBNb25pdG9yIHRpbWVyOiAgICAxMDAw
MDAwIMK1cwogICAgICBUcmFjZSBmaWxlIGNvdW50OiAxIHBlciBzdHJlYW0KICAgICAgVHJhY2Ug
ZmlsZSBzaXplOiAgdW5saW1pdGVkCiAgICAgIE91dHB1dCBtb2RlOiAgICAgIG1tYXAKCiAgICBT
dGF0aXN0aWNzOgogICAgICBOb25lCgogICAgRXZlbnQgcnVsZXM6CiAgICAgIG1hYyogKGxvZ2xl
dmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxl
ZF0KCi0gYmdwLWV2ZW50czogW2VuYWJsZWRdCgogICAgQXR0cmlidXRlczoKICAgICAgRXZlbnQt
bG9zcyBtb2RlOiAgb3ZlcndyaXRlCiAgICAgIFN1Yi1idWZmZXIgc2l6ZTogIDQxOTQzMDQgYnl0
ZXMKICAgICAgU3ViLWJ1ZmZlciBjb3VudDogNAogICAgICBTd2l0Y2ggdGltZXI6ICAgICBpbmFj
dGl2ZQogICAgICBSZWFkIHRpbWVyOiAgICAgICBpbmFjdGl2ZQogICAgICBNb25pdG9yIHRpbWVy
OiAgICAxMDAwMDAwIMK1cwogICAgICBUcmFjZSBmaWxlIGNvdW50OiAxIHBlciBzdHJlYW0KICAg
ICAgVHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVkCiAgICAgIE91dHB1dCBtb2RlOiAgICAgIG1t
YXAKCiAgICBTdGF0aXN0aWNzOgogICAgICBOb25lCgogICAgRXZlbnQgcnVsZXM6CiAgICAgIGJn
cDpiZ3BfbGFiZWxfZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0
eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgYmdwOmJncF9uZXRsaW5rX2RlYnVnIChs
b2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2Vu
YWJsZWRdCiAgICAgIGJncDpiZ3BfY2xlYW51cF9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVC
VUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBiZ3A6Ymdw
X25icmFsbF9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6
IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBiZ3A6YmdwX25leHRob3BfZGVidWcgKGxvZ2xl
dmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxl
ZF0KICAgICAgYmdwOmJncF9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3
KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBiZ3A6YmdwX2hhX2RlYnVnIChs
b2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2Vu
YWJsZWRdCiAgICAgIGJncDpiZ3BfZXZfZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZ
U1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgYmdwOmJncF9uYnJf
ZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBv
aW50KSBbZW5hYmxlZF0KICAgICAgYmdwOmJncF9pbmZvIChsb2dsZXZlbCA8PSBUUkFDRV9JTkZP
ICg2KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBiZ3A6YmdwX3dhcm4gKGxv
Z2xldmVsIDw9IFRSQUNFX1dBUk5JTkcgKDQpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRd
CgotIGZpYi1pbmZvOiBbZW5hYmxlZF0KCiAgICBBdHRyaWJ1dGVzOgogICAgICBFdmVudC1sb3Nz
IG1vZGU6ICBvdmVyd3JpdGUKICAgICAgU3ViLWJ1ZmZlciBzaXplOiAgMjYyMTQ0IGJ5dGVzCiAg
ICAgIFN1Yi1idWZmZXIgY291bnQ6IDQKICAgICAgU3dpdGNoIHRpbWVyOiAgICAgaW5hY3RpdmUK
ICAgICAgUmVhZCB0aW1lcjogICAgICAgaW5hY3RpdmUKICAgICAgTW9uaXRvciB0aW1lcjogICAg
MTAwMDAwMCDCtXMKICAgICAgVHJhY2UgZmlsZSBjb3VudDogMSBwZXIgc3RyZWFtCiAgICAgIFRy
YWNlIGZpbGUgc2l6ZTogIHVubGltaXRlZAogICAgICBPdXRwdXQgbW9kZTogICAgICBtbWFwCgog
ICAgU3RhdGlzdGljczoKICAgICAgTm9uZQoKICAgIEV2ZW50IHJ1bGVzOgogICAgICBmaWIqIChs
b2dsZXZlbCA9PSBUUkFDRV9ERUJVR19QUk9DRVNTICg5KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtl
bmFibGVkXQoKLSBzdHAtYWxsOiBbZW5hYmxlZF0KCiAgICBBdHRyaWJ1dGVzOgogICAgICBFdmVu
dC1sb3NzIG1vZGU6ICBvdmVyd3JpdGUKICAgICAgU3ViLWJ1ZmZlciBzaXplOiAgNDE5NDMwNCBi
eXRlcwogICAgICBTdWItYnVmZmVyIGNvdW50OiA0CiAgICAgIFN3aXRjaCB0aW1lcjogICAgIGlu
YWN0aXZlCiAgICAgIFJlYWQgdGltZXI6ICAgICAgIGluYWN0aXZlCiAgICAgIE1vbml0b3IgdGlt
ZXI6ICAgIDEwMDAwMDAgwrVzCiAgICAgIFRyYWNlIGZpbGUgY291bnQ6IDEgcGVyIHN0cmVhbQog
ICAgICBUcmFjZSBmaWxlIHNpemU6ICB1bmxpbWl0ZWQKICAgICAgT3V0cHV0IG1vZGU6ICAgICAg
bW1hcAoKICAgIFN0YXRpc3RpY3M6CiAgICAgIE5vbmUKCiAgICBFdmVudCBydWxlczoKICAgICAg
c3RwKiAobG9nbGV2ZWwgPD0gVFJBQ0VfREVCVUdfTElORSAoMTMpKSAodHlwZTogdHJhY2Vwb2lu
dCkgW2VuYWJsZWRdCgotIGRwYWwtZXZlbnQ6IFtlbmFibGVkXQoKICAgIEF0dHJpYnV0ZXM6CiAg
ICAgIEV2ZW50LWxvc3MgbW9kZTogIG92ZXJ3cml0ZQogICAgICBTdWItYnVmZmVyIHNpemU6ICA0
MTk0MzA0IGJ5dGVzCiAgICAgIFN1Yi1idWZmZXIgY291bnQ6IDQKICAgICAgU3dpdGNoIHRpbWVy
OiAgICAgaW5hY3RpdmUKICAgICAgUmVhZCB0aW1lcjogICAgICAgaW5hY3RpdmUKICAgICAgTW9u
aXRvciB0aW1lcjogICAgMTAwMDAwMCDCtXMKICAgICAgVHJhY2UgZmlsZSBjb3VudDogMSBwZXIg
c3RyZWFtCiAgICAgIFRyYWNlIGZpbGUgc2l6ZTogIHVubGltaXRlZAogICAgICBPdXRwdXQgbW9k
ZTogICAgICBtbWFwCgogICAgU3RhdGlzdGljczoKICAgICAgTm9uZQoKICAgIEV2ZW50IHJ1bGVz
OgogICAgICBiY20qIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTog
dHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGRwYWwqIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJV
R19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGx4ayogKGxv
Z2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5h
YmxlZF0KCi0gbGRwLWFsbDogW2VuYWJsZWRdCgogICAgQXR0cmlidXRlczoKICAgICAgRXZlbnQt
bG9zcyBtb2RlOiAgb3ZlcndyaXRlCiAgICAgIFN1Yi1idWZmZXIgc2l6ZTogIDQxOTQzMDQgYnl0
ZXMKICAgICAgU3ViLWJ1ZmZlciBjb3VudDogNAogICAgICBTd2l0Y2ggdGltZXI6ICAgICBpbmFj
dGl2ZQogICAgICBSZWFkIHRpbWVyOiAgICAgICBpbmFjdGl2ZQogICAgICBNb25pdG9yIHRpbWVy
OiAgICAxMDAwMDAwIMK1cwogICAgICBUcmFjZSBmaWxlIGNvdW50OiAxIHBlciBzdHJlYW0KICAg
ICAgVHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVkCiAgICAgIE91dHB1dCBtb2RlOiAgICAgIG1t
YXAKCiAgICBTdGF0aXN0aWNzOgogICAgICBOb25lCgogICAgRXZlbnQgcnVsZXM6CiAgICAgIGxk
cCogKGxvZ2xldmVsIDw9IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50
KSBbZW5hYmxlZF0KCi0gb3RoZXItZXZlbnQ6IFtlbmFibGVkXQoKICAgIEF0dHJpYnV0ZXM6CiAg
ICAgIEV2ZW50LWxvc3MgbW9kZTogIG92ZXJ3cml0ZQogICAgICBTdWItYnVmZmVyIHNpemU6ICA0
MTk0MzA0IGJ5dGVzCiAgICAgIFN1Yi1idWZmZXIgY291bnQ6IDQKICAgICAgU3dpdGNoIHRpbWVy
OiAgICAgaW5hY3RpdmUKICAgICAgUmVhZCB0aW1lcjogICAgICAgaW5hY3RpdmUKICAgICAgTW9u
aXRvciB0aW1lcjogICAgMTAwMDAwMCDCtXMKICAgICAgVHJhY2UgZmlsZSBjb3VudDogMSBwZXIg
c3RyZWFtCiAgICAgIFRyYWNlIGZpbGUgc2l6ZTogIHVubGltaXRlZAogICAgICBPdXRwdXQgbW9k
ZTogICAgICBtbWFwCgogICAgU3RhdGlzdGljczoKICAgICAgTm9uZQoKICAgIEV2ZW50IHJ1bGVz
OgogICAgICBrZXJuZWxfc3BpZWw6d2FybiAobG9nbGV2ZWwgPD0gVFJBQ0VfV0FSTklORyAoNCkp
ICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgYWRqOm5sX2RlYnVnIChsb2dsZXZl
bCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRd
CiAgICAgIHZycnA6ZHBhbF9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3
KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBhZGo6YWRqX2lwdjYgKGxvZ2xl
dmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxl
ZF0KICAgICAgdnJycDppbnRmX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0g
KDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGFkajpzdGFydHVwX2RlYnVn
IChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkg
W2VuYWJsZWRdCiAgICAgIGtlcm5lbF9zcGllbDpkZWJ1ZyAobG9nbGV2ZWwgPD0gVFJBQ0VfREVC
VUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBhZGo6YWRq
X2lwdjQgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBv
aW50KSBbZW5hYmxlZF0KICAgICAgcmFkKiAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfTU9EVUxF
ICgxMCkpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgZHJhKiAobG9nbGV2ZWwg
PT0gVFJBQ0VfREVCVUdfTU9EVUxFICgxMCkpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0K
ICAgICAgbWJyb2tlciogKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX01PRFVMRSAoMTApKSAodHlw
ZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGlmbWdyOnN0YXJ0dXBfZGVidWcgKGxvZ2xl
dmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxl
ZF0KICAgICAgbXByb3h5KiAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfTU9EVUxFICgxMCkpICh0
eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgaWZtZ3I6aWZtZ3JfZGVidWcgKGxvZ2xl
dmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxl
ZF0KICAgICAgaWZtZ3I6aWZfc3RhdGUgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAo
NykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgdnJycDpldl9kZWJ1ZyAobG9n
bGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFi
bGVkXQoKLSBvdGhlci1lcnJvcjogW2VuYWJsZWRdCgogICAgQXR0cmlidXRlczoKICAgICAgRXZl
bnQtbG9zcyBtb2RlOiAgb3ZlcndyaXRlCiAgICAgIFN1Yi1idWZmZXIgc2l6ZTogIDQxOTQzMDQg
Ynl0ZXMKICAgICAgU3ViLWJ1ZmZlciBjb3VudDogNAogICAgICBTd2l0Y2ggdGltZXI6ICAgICBp
bmFjdGl2ZQogICAgICBSZWFkIHRpbWVyOiAgICAgICBpbmFjdGl2ZQogICAgICBNb25pdG9yIHRp
bWVyOiAgICAxMDAwMDAwIMK1cwogICAgICBUcmFjZSBmaWxlIGNvdW50OiAxIHBlciBzdHJlYW0K
ICAgICAgVHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVkCiAgICAgIE91dHB1dCBtb2RlOiAgICAg
IG1tYXAKCiAgICBTdGF0aXN0aWNzOgogICAgICBOb25lCgogICAgRXZlbnQgcnVsZXM6CiAgICAg
IHZycnA6ZXJyb3IgKGxvZ2xldmVsIDw9IFRSQUNFX0VSUiAoMykpICh0eXBlOiB0cmFjZXBvaW50
KSBbZW5hYmxlZF0KICAgICAgbWJyb2tlciogKGxvZ2xldmVsIDw9IFRSQUNFX0VSUiAoMykpICh0
eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAga2VybmVsX3NwaWVsOmVycm9yIChsb2ds
ZXZlbCA8PSBUUkFDRV9FUlIgKDMpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAg
IGFkajphZGpfZXJyb3IgKGxvZ2xldmVsIDw9IFRSQUNFX0VSUiAoMykpICh0eXBlOiB0cmFjZXBv
aW50KSBbZW5hYmxlZF0KICAgICAgaWZtZ3I6aWZtZ3JfZXJyb3IgKGxvZ2xldmVsIDw9IFRSQUNF
X0VSUiAoMykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KCi0gcmliLWVycm9yOiBbZW5h
YmxlZF0KCiAgICBBdHRyaWJ1dGVzOgogICAgICBFdmVudC1sb3NzIG1vZGU6ICBvdmVyd3JpdGUK
ICAgICAgU3ViLWJ1ZmZlciBzaXplOiAgNDE5NDMwNCBieXRlcwogICAgICBTdWItYnVmZmVyIGNv
dW50OiA0CiAgICAgIFN3aXRjaCB0aW1lcjogICAgIGluYWN0aXZlCiAgICAgIFJlYWQgdGltZXI6
ICAgICAgIGluYWN0aXZlCiAgICAgIE1vbml0b3IgdGltZXI6ICAgIDEwMDAwMDAgwrVzCiAgICAg
IFRyYWNlIGZpbGUgY291bnQ6IDEgcGVyIHN0cmVhbQogICAgICBUcmFjZSBmaWxlIHNpemU6ICB1
bmxpbWl0ZWQKICAgICAgT3V0cHV0IG1vZGU6ICAgICAgbW1hcAoKICAgIFN0YXRpc3RpY3M6CiAg
ICAgIE5vbmUKCiAgICBFdmVudCBydWxlczoKICAgICAgcmliOnJpYl9lcnJvciAobG9nbGV2ZWwg
PD0gVFJBQ0VfRVJSICgzKSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQoKLSBsMnJpYi1h
bGw6IFtlbmFibGVkXQoKICAgIEF0dHJpYnV0ZXM6CiAgICAgIEV2ZW50LWxvc3MgbW9kZTogIG92
ZXJ3cml0ZQogICAgICBTdWItYnVmZmVyIHNpemU6ICA0MTk0MzA0IGJ5dGVzCiAgICAgIFN1Yi1i
dWZmZXIgY291bnQ6IDQKICAgICAgU3dpdGNoIHRpbWVyOiAgICAgaW5hY3RpdmUKICAgICAgUmVh
ZCB0aW1lcjogICAgICAgaW5hY3RpdmUKICAgICAgTW9uaXRvciB0aW1lcjogICAgMTAwMDAwMCDC
tXMKICAgICAgVHJhY2UgZmlsZSBjb3VudDogMSBwZXIgc3RyZWFtCiAgICAgIFRyYWNlIGZpbGUg
c2l6ZTogIHVubGltaXRlZAogICAgICBPdXRwdXQgbW9kZTogICAgICBtbWFwCgogICAgU3RhdGlz
dGljczoKICAgICAgTm9uZQoKICAgIEV2ZW50IHJ1bGVzOgogICAgICBsMnJpYiogKGxvZ2xldmVs
ID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0K
Ci0gbDJmLWFsbDogW2VuYWJsZWRdCgogICAgQXR0cmlidXRlczoKICAgICAgRXZlbnQtbG9zcyBt
b2RlOiAgb3ZlcndyaXRlCiAgICAgIFN1Yi1idWZmZXIgc2l6ZTogIDI2MjE0NCBieXRlcwogICAg
ICBTdWItYnVmZmVyIGNvdW50OiA0CiAgICAgIFN3aXRjaCB0aW1lcjogICAgIGluYWN0aXZlCiAg
ICAgIFJlYWQgdGltZXI6ICAgICAgIGluYWN0aXZlCiAgICAgIE1vbml0b3IgdGltZXI6ICAgIDEw
MDAwMDAgwrVzCiAgICAgIFRyYWNlIGZpbGUgY291bnQ6IDEgcGVyIHN0cmVhbQogICAgICBUcmFj
ZSBmaWxlIHNpemU6ICB1bmxpbWl0ZWQKICAgICAgT3V0cHV0IG1vZGU6ICAgICAgbW1hcAoKICAg
IFN0YXRpc3RpY3M6CiAgICAgIE5vbmUKCiAgICBFdmVudCBydWxlczoKICAgICAgbDJmKiAobG9n
bGV2ZWwgPD0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFi
bGVkXQoKLSBiZ3AtdXBkYXRlczogW2VuYWJsZWRdCgogICAgQXR0cmlidXRlczoKICAgICAgRXZl
bnQtbG9zcyBtb2RlOiAgb3ZlcndyaXRlCiAgICAgIFN1Yi1idWZmZXIgc2l6ZTogIDQxOTQzMDQg
Ynl0ZXMKICAgICAgU3ViLWJ1ZmZlciBjb3VudDogNAogICAgICBTd2l0Y2ggdGltZXI6ICAgICBp
bmFjdGl2ZQogICAgICBSZWFkIHRpbWVyOiAgICAgICBpbmFjdGl2ZQogICAgICBNb25pdG9yIHRp
bWVyOiAgICAxMDAwMDAwIMK1cwogICAgICBUcmFjZSBmaWxlIGNvdW50OiAxIHBlciBzdHJlYW0K
ICAgICAgVHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVkCiAgICAgIE91dHB1dCBtb2RlOiAgICAg
IG1tYXAKCiAgICBTdGF0aXN0aWNzOgogICAgICBOb25lCgogICAgRXZlbnQgcnVsZXM6CiAgICAg
IGJncDpiZ3BfcmliX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAo
dHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGJncDpiZ3BfcnBvbF9kZWJ1ZyAobG9n
bGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFi
bGVkXQogICAgICBiZ3A6YmdwX2V4cG9ydF9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdf
U1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBiZ3A6YmdwX3R1
bm5lbF9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRy
YWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBiZ3A6YmdwX3VwZGF0ZW91dF9kZWJ1ZyAobG9nbGV2
ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVk
XQogICAgICBiZ3A6YmdwX2F0dHJzX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNU
RU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIGJncDpiZ3BfbmxyaV9k
ZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9p
bnQpIFtlbmFibGVkXQogICAgICBiZ3A6YmdwX2ltcG9ydF9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJB
Q0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICBi
Z3A6YmdwX3VwZGF0ZWluX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcp
KSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCgotIHJpYi1ldmVudDogW2VuYWJsZWRdCgog
ICAgQXR0cmlidXRlczoKICAgICAgRXZlbnQtbG9zcyBtb2RlOiAgb3ZlcndyaXRlCiAgICAgIFN1
Yi1idWZmZXIgc2l6ZTogIDQxOTQzMDQgYnl0ZXMKICAgICAgU3ViLWJ1ZmZlciBjb3VudDogNAog
ICAgICBTd2l0Y2ggdGltZXI6ICAgICBpbmFjdGl2ZQogICAgICBSZWFkIHRpbWVyOiAgICAgICBp
bmFjdGl2ZQogICAgICBNb25pdG9yIHRpbWVyOiAgICAxMDAwMDAwIMK1cwogICAgICBUcmFjZSBm
aWxlIGNvdW50OiAxIHBlciBzdHJlYW0KICAgICAgVHJhY2UgZmlsZSBzaXplOiAgdW5saW1pdGVk
CiAgICAgIE91dHB1dCBtb2RlOiAgICAgIG1tYXAKCiAgICBTdGF0aXN0aWNzOgogICAgICBOb25l
CgogICAgRXZlbnQgcnVsZXM6CiAgICAgIHJpYjpyaWJfdjRfdG5sX2RlYnVnIChsb2dsZXZlbCA9
PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAg
ICAgIHJpYjpyaWJfZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0
eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgcmliOnJpYl9pbG1fZGVidWcgKGxvZ2xl
dmVsID09IFRSQUNFX0RFQlVHX1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxl
ZF0KICAgICAgcmliOnJpYl92Nl9pZ3Bfcm5oX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJV
R19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIHJpYjpyaWJf
djZfdG5sX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTog
dHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIHJpYjpzdGFydHVwX2RlYnVnIChsb2dsZXZlbCA9
PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTogdHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAg
ICAgIHJpYjpyaWJfdjZydF9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3
KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAgICByaWJfNnY2cGF0aF9kZWJ1ZyAo
bG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtl
bmFibGVkXQogICAgICByaWI6cmliX3Y0cnRfZGVidWcgKGxvZ2xldmVsID09IFRSQUNFX0RFQlVH
X1NZU1RFTSAoNykpICh0eXBlOiB0cmFjZXBvaW50KSBbZW5hYmxlZF0KICAgICAgcmliOnJpYl80
djRwYXRoX2RlYnVnIChsb2dsZXZlbCA9PSBUUkFDRV9ERUJVR19TWVNURU0gKDcpKSAodHlwZTog
dHJhY2Vwb2ludCkgW2VuYWJsZWRdCiAgICAgIHJpYjpyaWJfdjRfaWdwX3JuaF9kZWJ1ZyAobG9n
bGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFi
bGVkXQogICAgICByaWI6cmliX3R1bm5lbF90ZXJtaW5hdGlvbl9kZWJ1ZyAobG9nbGV2ZWwgPT0g
VFJBQ0VfREVCVUdfU1lTVEVNICg3KSkgKHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQogICAg
ICByaWI6cmliX3NpZF9kZWJ1ZyAobG9nbGV2ZWwgPT0gVFJBQ0VfREVCVUdfU1lTVEVNICg3KSkg
KHR5cGU6IHRyYWNlcG9pbnQpIFtlbmFibGVkXQo=
--0000000000000a461d063083edbf--
