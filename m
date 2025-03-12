Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA012C28B28
	for <lttng-dev@archiver.kernel.org>; Wed, 12 Mar 2025 09:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741771186;
	bh=wWMpYJXDG1c9123HYncvkGAWYk5OV6IVlwJEMVNJX8A=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MUGauYy+iSGtGMewZbe+kDwshyujy5D8kr5WbTXBZtSg/efmgEx657QL62MK8Ts/i
	 UlPq7VTJz2watBHp1akZr3KhYWkS2kgf9I6ZDOfNxE8Hcc/92+2yS0lEZUk1USe6X/
	 a9bg2Yt1+28Rhi2sQb4025OuA4nzb4skJBEND3X8+T5YpGTFqUCsHSGkhXOWOeLVN+
	 kafJGpjvx1+j5kRBCGzy26HDtCQLJPze8LUpB+Ho6MEOaTfEtUhFkfbpP1AaL20k54
	 i6jsjChaKmrnj8zWZBpKjiM0VzHXgRSHpCqyspaufX6Kxl59P+nQWJC6Z38qXlddf6
	 pNDbHD00oWVtQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZCQ7k10GMz2Bbs;
	Wed, 12 Mar 2025 05:19:46 -0400 (EDT)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZCQ7h5qxYz2Bbr
 for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2025 05:19:44 -0400 (EDT)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ff087762bbso9741284a91.3
 for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2025 02:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741771184; x=1742375984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4YrzzLnKJ1JFXOExEnIOhbSvExWe5DdzKEGtDALbzss=;
 b=EDVCgMZD/QuLpVbeJpnPTR7A1gRm3L0G+ujDmCQwOta/Px1Qjjzt7y5zHMER7Mo2oh
 gqlVzP76QbGeMBC1jYiReBheTjXXybmLnZW1JnZWOICUQH3SxVrfmWEVxp3pf06DbBhd
 PMv6+Du88AU+huLB4+5CBAZgrz7KPXnXloZEl0/9WrG/APlO3TBJjcWBhrye4TfNKI68
 SQ8a/gI2qLUCLINnF6Yf6OH64thBkZauSYgdzxd7r78l/lGDQ3+GGm2JoqQBW95icmlZ
 ctK/tdg+GIT1Z237Ke/5fVs5eDMdVrJuF4xWQ0dehH5u+K8T/D8aQi9k/ybrZAN6EmIO
 MUJw==
X-Gm-Message-State: AOJu0Yy74uifx00MEtV50U+xEJOSIeZEtma33Sfv67r0TKDyzKI0FpHB
 OCUYICEMgGDN/KpBpm3g3Xg/9d8KYs5wMmx6evMzR9bq/V8U3B/9RJEy5uTTVv46MPJ+OxvT56c
 sJ0BXrGNhzhDte3XK2mslE6Aq7bBDH9GbAOI=
X-Gm-Gg: ASbGncssvftiIrCocK0ZaxGXW53k+vTZlLGUr1ekQGpyX9+jl7PMe+l5ZTAAoKsvQx1
 7KXgdQChmDUDcH8ojtX8wmngRoL/bN7kJQK7Twhig4UG+83QnRo6awRfIdDWY/UBHTfwhnc0ZOm
 2xrWIA9WW/YL31KQ+PGHLAiOR8OQ==
X-Google-Smtp-Source: AGHT+IF9wcfyomx5lx17KjgKTILjy+yScv/rxiQgCXqtWCgAEMQESILgaJdxJ2EFMfpYoAEp6SKtYkqY7JAAVyPfosU=
X-Received: by 2002:a17:90b:3c0d:b0:2f5:88bb:118 with SMTP id
 98e67ed59e1d1-300ff351af9mr7888389a91.22.1741771183365; Wed, 12 Mar 2025
 02:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAE9JrziSBzHDOLjLzY=8FHPRWxm9+xq40Kzq8GUivb=u9V74wg@mail.gmail.com>
 <8a3a094c-3afc-49da-8764-8fec1179f7c0@efficios.com>
 <38dab5ef-f106-4e57-9e36-b4b30015c019@efficios.com>
In-Reply-To: <38dab5ef-f106-4e57-9e36-b4b30015c019@efficios.com>
Date: Wed, 12 Mar 2025 14:49:07 +0530
X-Gm-Features: AQ5f1JpIIs6kgcn8myysa9sfDQBM9gwU59MXzev8_aUWDr5dTR2xVp9xTmtCo3U
Message-ID: <CAE9Jrzg7qsabhPiO-0=B1DY3bVo-3FYu2tiJR2Bmb=nqOHNZMw@mail.gmail.com>
Subject: Re: Memory Consumption High After Upgrading to 2.13 from 2.10
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="000000000000aa24e1063021b40d"
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

--000000000000aa24e1063021b40d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Kienan

I am attaching an screen recording of the behaviour I am seeing in this
mail. The behaviour is same irrespective of the device i use, sorry for
miscommunication in the npocs output (I assumed it was 32), but other than
that all outputs are same (except the hostname as there are multiple
devices with same lttng config but this memory cosumption is seen on all
the devices).

I had few question

1. Does lltng allocated all the memory it needs and mark it as dirty in ram
when any process which links/uses lttng-ust runs? (here i tried with one
process but it is same for any of my process)
2. (nSubbuf * subbufSize) * (nCPUs + 1 iff snapshot mode is enabled) *
(nUIDs or nPIDs)

How do we calculate uid in the system is it all uids in the system? is it
equal to `cat /etc/passwd | wc -l` ?

I will put my calculations according to the above estimate based on all the
channel i am creating

(4194304*4 + 262144*4 + 16384*4) * (16) * (30 if number user are equal to
`cat /etc/passwd | wc -l`)B =3D 7.998046875 GB approx [this is based on the
start_lttng.py please do correct me if am wrong here.]

But since there are only two users which uses lttng i think the correct
estimate would be
(4194304*4 + 262144*4 + 16384*4) * (16) * (2)B =3D 546MB

Please do correct me If I am wrong calculations here.

Now, there are a few things here, according to my output lttng is using 11G
which is much more higher than the what is configured.

I am attaching the lttng status and the file which is uses to create the
lttng sessions.



Thank You.


https://drive.google.com/file/d/1tS_ZWEsXDpHZXfWzZHXmWcT0igiIOIaa/view?usp=
=3Dsharing
-- recording of the behaviour which is seen
https://drive.google.com/file/d/1PrU31oyEw1n9tKETlUtmNGO50s6ywx7p/view?usp=
=3Dsharing
-- the file which is used to create lttng sessions


On Wed, Mar 12, 2025 at 12:25=E2=80=AFAM Kienan Stewart <kstewart@efficios.=
com>
wrote:

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

--000000000000aa24e1063021b40d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, Kienan<br><br></div><div>I am attaching an screen=
 recording of=20
the behaviour I am seeing in this mail. The behaviour is same=20
irrespective of the device i use, sorry for miscommunication in the=20
npocs output (I assumed it was 32), but other than that all outputs are=20
same (except the hostname as there are multiple devices with same lttng=20
config but this memory cosumption is seen on all the devices).</div><div><b=
r></div><div>I had few question<br><br></div><div>1.
 Does lltng allocated all the memory it needs and mark it as dirty in=20
ram when any process which links/uses lttng-ust runs? (here i tried with
 one process but it is same for any of my process)<br>2. (nSubbuf * subbufS=
ize) * (nCPUs + 1 iff snapshot mode is enabled) * (nUIDs or nPIDs)<br><br><=
/div><div>How do we calculate uid in the system is it all uids in the syste=
m? is it equal to `cat /etc/passwd | wc -l` ?<br><br></div><div>I will put =
my calculations according to the above estimate based on all the channel i =
am creating</div><div><br></div><div>(<span id=3D"m_-5967291644094277896gma=
il-cwos">4194304</span>*4 + 262144*4 + 16384*4) * (16) * (30 if number user=
 are equal to `cat /etc/passwd | wc -l`)B =3D <span id=3D"m_-59672916440942=
77896gmail-cwos">7.998046875 GB approx [this is based on the start_lttng.py=
 please do correct me if am wrong here.]<br><br></span></div><div>But since=
 there are only two users which uses lttng i think the correct estimate wou=
ld be<br></div><div>(<span id=3D"m_-5967291644094277896gmail-cwos">4194304<=
/span>*4 + 262144*4 + 16384*4) * (16) * (2)B =3D <span id=3D"m_-59672916440=
94277896gmail-cwos">546MB <br><br></span></div><div><span id=3D"m_-59672916=
44094277896gmail-cwos">Please do correct me If I am wrong calculations here=
. <br></span></div><div><span id=3D"m_-5967291644094277896gmail-cwos"><br><=
/span></div><div>Now,
 there are a few things here, according to my output lttng is using 11G=20
which is much more higher than the what is configured.<br><br></div><div>I =
am attaching the lttng status and the file which is uses to create the lttn=
g sessions.<br><br></div><div><br></div><div><br></div><div>Thank You.<br><=
br><br><a href=3D"https://drive.google.com/file/d/1tS_ZWEsXDpHZXfWzZHXmWcT0=
igiIOIaa/view?usp=3Dsharing">https://drive.google.com/file/d/1tS_ZWEsXDpHZX=
fWzZHXmWcT0igiIOIaa/view?usp=3Dsharing</a> -- recording of the behaviour wh=
ich is seen<br><a href=3D"https://drive.google.com/file/d/1PrU31oyEw1n9tKET=
lUtmNGO50s6ywx7p/view?usp=3Dsharing">https://drive.google.com/file/d/1PrU31=
oyEw1n9tKETlUtmNGO50s6ywx7p/view?usp=3Dsharing</a> -- the file which is use=
d to create lttng sessions</div><br></div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 12, 2=
025 at 12:25=E2=80=AFAM Kienan Stewart &lt;<a href=3D"mailto:kstewart@effic=
ios.com">kstewart@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Hi Lakshya,<br>
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
</blockquote></div>

--000000000000aa24e1063021b40d--
