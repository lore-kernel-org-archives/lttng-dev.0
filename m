Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m228-58.mailgun.net (m228-58.mailgun.net [159.135.228.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20960CAC592
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Sep 2025 20:39:31 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1758314371; x=1758321571;
 h=Sender: Sender: Cc: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: Content-Type: To: To: Subject: Subject: Message-ID: Date: In-Reply-To: References: MIME-Version;
 bh=D/au3l3SsTE4kBsWX726dWZJmRK4R4qGJHVBoU0RNFU=;
 b=l7j0zlL80ECfvnUTEfl/IsuJfQnpxyzqhCTEe/XemLZFMWmIA9qJkOzS48+j+rPZul50cRH3PY/xE3Bq7+oanmbOSXWsD2sjWJG2/0/0Vxayah1BxPZcZBjiOcoRhafb0yI6iB+TU9Gah65lZc63nKOBQnaAnagmYQPVlmPODsQFjTSTXVtU0RFWBGtZtN/PvGm7ZIye9kjnRswpfSaTkEUSN9q49mopBokQG0CGTJjEFwO2+Fb+TQpJvBYiwQuzJXw4L5xhNYmA7fD/N4QFHthm9HwYcfnTWEhqUV5fxmqnkhfS/H1t4yTuh6sxjVtYiF3Tp8a+dYls6kQMEqLQwA==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 6a3b6843705e11b035febf048f86cc2bd0939e10c47de56260e482e3b58c1481 with SMTP id
 68cdbf83f11f6307584f7cf6 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Fri, 19 Sep 2025 20:39:31 GMT
X-Mailgun-Sending-Ip: 159.135.228.58
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cT49r6rDpz17Fy
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1758314370;
	b=SDyeC1wI64lBr/sgBC+t/Xe17PEtOlbLZRtC5urbQkuQ5VjoXLosFa8YezpTg3DBCsRq
	 BKXMVm1Bw4SdTnlsQABBWFoCikKL9b+h33sxRSacNt5F6ENqPCQVOzqpzBUBGiyd4vQG/
	 2Kg7pRGWXYNmcTNaAZIVs0eKvb1fYXNDmWVHEhItFdmAZUxPZ80Cf6tXHAeRcR8Tw8Dbt
	 /P2FTqQNGCkzLTDfq/4vajdH0aPt1KLhOuM/97thhcPuMqxVmhls9vgcu+5SnoNbCViLZ
	 +K8Sl5/Xm52un54dsr4JjZWNmsREnuJh5+HS7xlJnmq4AoiCd/lJiBkgQ+Q2aqZ+cKw==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1758314370;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=WGCJOwm284nhzDF5oEwTEx/Ii/YjcXuaq++cLg3nNm8=;
	b=aZHM3RYyO5RNo8uwawo76WtWxyJ9gB2AHo7Bd89M13gX1FI+EAqI9oimSCX4IsGU4E5m
	 wSdBy05k50+nfOGiYG0Zq6WJ/dybz4EC9uU8vBC21AUh8qaJULveaKp+SWuXnQ12Gvh7I
	 00ws35sIvkv+VGHrxatGuZZd6rKHacKD2NLind3UbW2VLbTrTXeUio2BewOSX0zFUtk+8
	 ocKS+/s5UqPDZozzZYVBjEUF6dYk6iveCM0t06fIaIBbg/4ji8kEgV88fzd3cR0WWl+eH
	 I8A5e8juzEe3nXZM9rzhrXdwSNwfUMXEoCJ/bTnKrnqaoxcUSMTbvoXC+leE2sxB4cQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cT49r6rDpz17Fy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1758314370;
	bh=WGCJOwm284nhzDF5oEwTEx/Ii/YjcXuaq++cLg3nNm8=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=lqUDVAyMS9qDl43uGRD98aFBtM79kg0pADxzJcNNd+3x63d/lB3YlNclW7GbcjptB
	 1Rb4h/viEFyEmG8snp0PQNCR4x851Ynke5J4tFOumhCIsWlTgG5dEHdLtRFTCIyXjl
	 9ZgpFAYgKGzZ2/chw4oZ3tLpt3nTLtYSSdOtHvH9O1ET2RH3MtekZvY5xqLIt9HcQ3
	 1ToUXfV1IjNCUpJS9cxiZObH8foSw5UkQcpZ6rcSBChhEDqluUUNMDi5U9Q/WFdsNJ
	 vTQ7rUyyYYVMa7/umZJ73CuXYjyZVjD1SxV12DCRSnLsR2j3WqnXTTMkpnYW1E4wmi
	 POCvh1c15Qq4g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cT49r6rDpz17Fy;
	Fri, 19 Sep 2025 16:39:28 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cT49p5SpNz17Fx
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cT49p5SpNz17Fx
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by lists.lttng.org (Postfix) with ESMTPS id 4cT49p5SpNz17Fx
 for <lttng-dev@lists.lttng.org>; Fri, 19 Sep 2025 16:39:26 -0400 (EDT)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-62fa0653cd1so3033532a12.0
 for <lttng-dev@lists.lttng.org>; Fri, 19 Sep 2025 13:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758314364; x=1758919164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D/au3l3SsTE4kBsWX726dWZJmRK4R4qGJHVBoU0RNFU=;
 b=wzIgjrRCsFsArb5MzsZarZKgnqHOkpAMArMVH31oiuzBh23lHvZyKl/Gn9Hngf+qa/
 fq23BYrrMCUz/IaPSG+UVcsXM1jgX2Afk4C6a6Hv95aKP320zN5hkNEOTH89hHFraXjV
 Zv4h0UcqZzyz4YeeHMKBxZ+Yrw6rJp1HXedQ+zoKEkzQpTKIvTt1fnXjHRxkOnHMqDvw
 rQ2UWyYCTS2B5emrdWLyFYRtRrp+FsALe+Vgkmo8BmdMTphq0H7pw72ydROVWoEXG4Rs
 xVWhapyySlN5I5agjZnCoMtPvO91tTvuPlPVGjh+gRGcoYpqAJVVNUJtEZY5CES2w41G
 dQ3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFJO9C14/1uTM8zDThyUE8txu37opoKWOE94mx0BacvsVoLXWDnjEJK6K/KPAPcRVrwMw+qHi2ktQ=@lists.lttng.org
X-Gm-Message-State: AOJu0Yxk0TUj/HmrcPLwt3bIo7tUJPvR0zIb1G4QgVvNAzLd6n3EMEbj
 JQ8ztHC3trvDNjgMaRtJx2tvWnNDizTJPaKjP0tli5Tb6wrZdG//B9ofpBa54PU3yQZGuI6xyov
 jl6hFRtf0kRpheyAO9tBnMrkR8YZbfszHbaC4rfg=
X-Gm-Gg: ASbGncsT0bD6ENqp7pUAcN4oIisyzsXvpF42pIUzykVfjfMixRuuf0fFjxtKM+ei/EL
 tFvNOliM7e6CXbDbnzlsFTd0ieFQoYXAGAqe/0ZQ/N2WYQzEg9CB2dd7EC9P79iXbTDu0NYOqjR
 RZ0vTXPvK0IWFp93QLLzjVzls/17ENac0eWetY5kVPHEBHRbteuue8fVB+XPqAs+j8jL6Lixt2r
 VJIxJ6K087WOWaD
X-Google-Smtp-Source: AGHT+IFkOe5xuC5WWjY1WoJq7ZulsWbsXtEVuXD+3FpXLYMMi2AbHsWeJHVsSltL2eDgPZpiV/JhFI6MSabjS6WAyM0=
X-Received: by 2002:a05:6402:3202:b0:62b:8a92:d2f0 with SMTP id
 4fb4d7f45d1cf-62fc0a7ba4cmr4035884a12.33.1758314363589; Fri, 19 Sep 2025
 13:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKGpciq6Cb6+hqsfn+_zPk+MqCg+b0M_Gc3jVxVvnEGcE8rdLw@mail.gmail.com>
 <CAKGpciqHpGqGJChLa8p4P4Xv7EyUPMxULHxeknOTyie8kHH6hg@mail.gmail.com>
 <3c49eadb-f310-46b2-984d-58a0c193cde9@efficios.com>
 <CAKGpcipt=fWJi9Y497C3vq03CXmPY6rXQqs8ZP9nDoTGdRKnAA@mail.gmail.com>
 <CAKGpcipfyp3Ds4J0OH96Mu4zVhCLJg8g6tqEnfcRscZ1T8EmVA@mail.gmail.com>
 <2f0dc1b4-3fcb-453c-aa42-4a1f85623300@paulmck-laptop>
 <CAKGpciq+ixOVGN7TXYaF336ZEL_mOejzic5BvaKbexwwn_aqOQ@mail.gmail.com>
 <BD1A29BD-2AD2-4092-B1A2-DFEFAE77AAEE@sury.org>
 <CAKGpcip6w2nVQ+vbtfFH1296xTi5HYX+68J8okecChsihejDQA@mail.gmail.com>
 <87y0qwwc6j.fsf@laura>
 <CAKGpcioZbhyTUqLmNSnpuPw=jbi6eZV6ubbFQtvFD6VKn3wKxA@mail.gmail.com>
 <87h5xg7p3u.fsf@laura>
 <CAKGpciqOVQRTP9kz7uwFFECGWMzFRFRsRujSDBrxFC24Y1A6NA@mail.gmail.com>
 <87bjnlrege.fsf@laura>
In-Reply-To: <87bjnlrege.fsf@laura>
Date: Fri, 19 Sep 2025 22:39:11 +0200
X-Gm-Features: AS18NWDfHTnaGOzGYRno-1AAc4ZIeULOsDULNOqkzB_ms5PB9WnIXHY6C-muEJw
Message-ID: <CAKGpcio7tO-G0JBazV1Xd52==uf9DCtxPfeUtne_QnNivCKacw@mail.gmail.com>
Subject: Re: URCU feature request?
To: Olivier Dion <odion@efficios.com>
Content-Type: multipart/alternative; boundary="0000000000000b9882063f2d7704"
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
From: Thobias Knudsen via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Thobias Knudsen <thobknu@gmail.com>
Cc: lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--0000000000000b9882063f2d7704
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>Since 0.15.0, we've introduce an annotation layer (not part of the
>public API), making TSAN compatible with URCU.  See
>`include/urcu/annotate.h' and the `CMM_SANITIZE_THREAD' macro.
>
>However, IIRC, you also need to compile URCU with the configuration
>option `--enable-compiler-atomic-builtins' so that atomic operations are
>implemented with the configured toolchain's builtin atomics.  I don't
>recall if this was strictly necessary.
>
>If you encounter false positives with TSAN, please send me a minimal
>reproducible example together with:
>
> - the toolchain you=E2=80=99re using
>
> - the version of URCU
>
> - the configuration flags you used
>
>I will be happy to have a look.

Sorry for the late answer. I had to find the time to fix some bugs to get
it all running before switching to urcu v0.15.0 and setting the flags and
macros for thread sanitizer support. Creating a minimum reproducible
example would take some time as I don't have any good idea of the
exact place where the thread sanitizer issues arise because they are
scattered all over tsm.c and test_tsm.c. If you have linux debian family
then you can clone my repo and run it:
https://github.com/ThobiasKnudsen/Logos. ./scripts/build.sh --debug --tsan
&& ./build/bin/test_tsm. I tried running with and without thread sanitizer
support and got the same issues. In the test_tsm when only one thread is
running, the thread sanitizer produces warnings still. I did find a place
where the thread sanitizer said there was a race and the write was within a
node not yet inserted into the cds_lfht. That seems like a false positive.
The read for the same case should be inside rcu_read_lock as everything
within lines 263 to 904 inside test_tsm.c is within a read section.

  Read of size 1 at 0x7b1400085ea1 by thread T6:
    #0 tsm_base_node_is_valid /Logos/src/tsm.c:721 (test_tsm+0xa548)
    #1 _tsm_tsm_type_is_valid /Logos/src/tsm.c:364 (test_tsm+0xb1bf)
    #2 tsm_node_is_valid /Logos/src/tsm.c:1553 (test_tsm+0x9984)
    #3 tsm_node_defer_free /Logos/src/tsm.c:1888 (test_tsm+0xb2fc)
    #4 stress_thread /Logos/src/tests/test_tsm.c:549 (test_tsm+0x46a6)

  Previous write of size 1 at 0x7b1400085ea1 by thread T9:
    #0 tsm_base_node_create /Logos/src/tsm.c:683 (test_tsm+0x6f2a)
    #1 stress_thread /Logos/src/tests/test_tsm.c:843 (test_tsm+0x5ce0)

>I don=E2=80=99t see why that would be a problem for the static-check algor=
ithm I
>described above.  If a pointer needs to be protected by a mutex for
>mutation, that falls outside the scope of RCU, as far as I know.

If I understand correctly the __rcu checks that reads are not done outside
read sections and unsafe writes are not done at all. If this is correct
then if you are using custom concurrency for __rcu protected data outside
the read section or unsafe writes is that allowed? Because if it's not that
would be a limitation for __rcu.

man. 8. sep. 2025 kl. 02:10 skrev Olivier Dion <odion@efficios.com>:

> On Sun, 07 Sep 2025, Thobias Knudsen <thobknu@gmail.com> wrote:
> >> It looks like you want runtime verification for the usage of the API.
> >> Did you know that URCU can now be compiled against ThreadSanitizer
> >> (TSAN)?  If a user misuses the API or makes incorrect assumptions abou=
t
> >> the guarantees offered by RCU, TSAN will most likely detect those
> >> issues.  Coupled with the other debug features we already have, this
> >> makes it very hard to not trigger an error path when the API is used
> >> incorrectly.
> >
> > Really?! I've used TSAN and got a bunch of false positives, I believe,
> but
> > maybe they're not false positives? How do you remove the false positive=
s,
> > or know that they're not false positives?
>
> Since 0.15.0, we've introduce an annotation layer (not part of the
> public API), making TSAN compatible with URCU.  See
> `include/urcu/annotate.h' and the `CMM_SANITIZE_THREAD' macro.
>
> However, IIRC, you also need to compile URCU with the configuration
> option `--enable-compiler-atomic-builtins' so that atomic operations are
> implemented with the configured toolchain's builtin atomics.  I don't
> recall if this was stricly necessary.
>
> If you encounter false positives with TSAN, please send me a minimal
> reproducible example together with:
>
>  - the toolchain you=E2=80=99re using
>
>  - the version of URCU
>
>  - the configuration flags you used
>
> I will be happy to have a look.
>
> >> Note that certain kind of errors could actually be flag at compile tim=
e
> >> with the proper tooling.  For example, the Linux kernel uses a `__rcu'
> >> attribute that Sparse can understand to flag improper use of
> >> RCU=E2=80=91protected pointers.  I=E2=80=99d be very open to exposing =
something similar
> >> (an attribute) for static checkers.
> >
> > wow thanks for the info! I knew compile time checks would be possible b=
ut
> > requiring compiler operability which is a higher hanging fruit for me.
>
> I don=E2=80=99t know the details of `__rcu' from the Linux kernel. I thin=
k it=E2=80=99s
> just a macro that expands to nothing by default, but Sparse treats it as
> an attribute.  I=E2=80=99m not sure exactly what checks Sparse performs w=
ith it,
> but I suspect it involves traversing the program=E2=80=99s control-flow g=
raph
> (CFG), ensuring that pointers marked with the `__rcu' qualifier are:
>
>   - obtained via rcu_dereference
>
>   - only dereferenced under RCU lock protection
>
> > Is '__rcu' compatible with custom concurrency? For example
> > rcu_dereference a pointer then locking a mutex inside the pointer then
> > unlock read then continue using the pointer?
>
> I don=E2=80=99t see why that would be a problem for the static-check algo=
rithm I
> described above.  If a pointer needs to be protected by a mutex for
> mutation, that falls outside the scope of RCU, as far as I know.
>
> > I cant come up with something usefull other than a language rework. Is
> > it much work making the __urcu attribute?
>
> I suppose not.  On top of my head, it would involve adding some pointer
> qualifier and function attributes to the primitives exposed by URCU.
> Users would also need to use the pointer qualifier when working with
> RCU-protected pointers.  The qualifier and the attributes would expand
> to nothing by default, letting static checkers defining them to internal
> values.  I suggest you read `Documentation/RCU/rcu_dereference.rst' in
> the Linux kernel tree if you are interested.
>
> In its current state, this would not be very useful because none of the
> major compilers provide static analysis for RCU.  However, implementing
> such analysis, as a plugin, wouldn=E2=80=99t be overly difficult for some=
one
> familiar with Clang or GCC, I suppose.
>
> [...]
>
> Thanks,
> Olivier
> --
> Olivier Dion
> EfficiOS Inc.
> https://www.efficios.com
>

--0000000000000b9882063f2d7704
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;Since 0.15.0, we&#39;ve introduce an annotation layer =
(not part of the<br>&gt;public API), making TSAN compatible with URCU.=C2=
=A0 See<br>&gt;`include/urcu/annotate.h&#39; and the `CMM_SANITIZE_THREAD&#=
39; macro.<br>&gt;<br>&gt;However, IIRC, you also need to compile URCU with=
 the configuration<br>&gt;option `--enable-compiler-atomic-builtins&#39; so=
 that atomic operations are<br>&gt;implemented with the configured toolchai=
n&#39;s builtin atomics.=C2=A0 I don&#39;t<br>&gt;recall if this was strict=
ly necessary.<br>&gt;<br>&gt;If you encounter false positives with TSAN, pl=
ease send me a minimal<br>&gt;reproducible example together with:<br>&gt;<b=
r>&gt; - the toolchain you=E2=80=99re using<br>&gt;<br>&gt; - the version o=
f URCU<br>&gt;<br>&gt; - the configuration flags you used<br>&gt;<br>&gt;I =
will be happy to have a look.<div><br></div><div>Sorry for the late answer.=
 I had to find the time to fix some bugs to get it all running before switc=
hing to urcu v0.15.0 and setting the flags and macros for thread sanitizer=
=C2=A0support. Creating a minimum reproducible example would take some time=
 as I don&#39;t have any good idea of the exact=C2=A0place where the thread=
 sanitizer issues arise=C2=A0because they are scattered all over tsm.c and =
test_tsm.c. If you have linux debian family then you can clone my repo and =
run it:=C2=A0<a href=3D"https://github.com/ThobiasKnudsen/Logos">https://gi=
thub.com/ThobiasKnudsen/Logos</a>. ./scripts/build.sh --debug --tsan &amp;&=
amp; ./build/bin/test_tsm. I tried running with and without thread sanitize=
r support and got the same issues. In the test_tsm when only one thread is =
running, the thread sanitizer produces warnings still. I did find a place w=
here the thread sanitizer said there=C2=A0was a race and the write was with=
in a node not yet inserted into the cds_lfht. That seems like a false posit=
ive. The read for the same case should be inside rcu_read_lock as everythin=
g within lines 263 to 904 inside test_tsm.c is within a read section.</div>=
<div><br></div><div>=C2=A0 Read of size 1 at 0x7b1400085ea1 by thread T6:<b=
r>=C2=A0 =C2=A0 #0 tsm_base_node_is_valid /Logos/src/tsm.c:721 (test_tsm+0x=
a548)<br>=C2=A0 =C2=A0 #1 _tsm_tsm_type_is_valid /Logos/src/tsm.c:364 (test=
_tsm+0xb1bf)<br>=C2=A0 =C2=A0 #2 tsm_node_is_valid /Logos/src/tsm.c:1553 (t=
est_tsm+0x9984)<br>=C2=A0 =C2=A0 #3 tsm_node_defer_free /Logos/src/tsm.c:18=
88 (test_tsm+0xb2fc)<br>=C2=A0 =C2=A0 #4 stress_thread /Logos/src/tests/tes=
t_tsm.c:549 (test_tsm+0x46a6)<br><br>=C2=A0 Previous write of size 1 at 0x7=
b1400085ea1 by thread T9:<br>=C2=A0 =C2=A0 #0 tsm_base_node_create /Logos/s=
rc/tsm.c:683 (test_tsm+0x6f2a)<br>=C2=A0 =C2=A0 #1 stress_thread /Logos/src=
/tests/test_tsm.c:843 (test_tsm+0x5ce0)<br></div><div><br></div><div>&gt;I =
don=E2=80=99t see why that would be a problem for the static-check algorith=
m I<br>&gt;described above.=C2=A0 If a pointer needs to be protected by a m=
utex for<br>&gt;mutation, that falls outside the scope of RCU, as far as I =
know.</div><div><br></div><div>If I understand correctly the __rcu checks t=
hat reads are not done outside read sections and unsafe writes are not done=
 at all. If this is correct then if you are using custom concurrency for __=
rcu protected data outside the read section or unsafe writes is that allowe=
d? Because if it&#39;s not that would be a limitation for __rcu.=C2=A0</div=
></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">man. 8. sep. 2025 kl. 02:10 skrev Olivier Dion &lt;<=
a href=3D"mailto:odion@efficios.com">odion@efficios.com</a>&gt;:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Sun, 07 Sep 2025, Thobi=
as Knudsen &lt;<a href=3D"mailto:thobknu@gmail.com" target=3D"_blank">thobk=
nu@gmail.com</a>&gt; wrote:<br>
&gt;&gt; It looks like you want runtime verification for the usage of the A=
PI.<br>
&gt;&gt; Did you know that URCU can now be compiled against ThreadSanitizer=
<br>
&gt;&gt; (TSAN)?=C2=A0 If a user misuses the API or makes incorrect assumpt=
ions about<br>
&gt;&gt; the guarantees offered by RCU, TSAN will most likely detect those<=
br>
&gt;&gt; issues.=C2=A0 Coupled with the other debug features we already hav=
e, this<br>
&gt;&gt; makes it very hard to not trigger an error path when the API is us=
ed<br>
&gt;&gt; incorrectly.<br>
&gt;<br>
&gt; Really?! I&#39;ve used TSAN and got a bunch of false positives, I beli=
eve, but<br>
&gt; maybe they&#39;re not false positives? How do you remove the false pos=
itives,<br>
&gt; or know that they&#39;re not false positives?<br>
<br>
Since 0.15.0, we&#39;ve introduce an annotation layer (not part of the<br>
public API), making TSAN compatible with URCU.=C2=A0 See<br>
`include/urcu/annotate.h&#39; and the `CMM_SANITIZE_THREAD&#39; macro.<br>
<br>
However, IIRC, you also need to compile URCU with the configuration<br>
option `--enable-compiler-atomic-builtins&#39; so that atomic operations ar=
e<br>
implemented with the configured toolchain&#39;s builtin atomics.=C2=A0 I do=
n&#39;t<br>
recall if this was stricly necessary.<br>
<br>
If you encounter false positives with TSAN, please send me a minimal<br>
reproducible example together with:<br>
<br>
=C2=A0- the toolchain you=E2=80=99re using<br>
<br>
=C2=A0- the version of URCU<br>
<br>
=C2=A0- the configuration flags you used<br>
<br>
I will be happy to have a look.<br>
<br>
&gt;&gt; Note that certain kind of errors could actually be flag at compile=
 time<br>
&gt;&gt; with the proper tooling.=C2=A0 For example, the Linux kernel uses =
a `__rcu&#39;<br>
&gt;&gt; attribute that Sparse can understand to flag improper use of<br>
&gt;&gt; RCU=E2=80=91protected pointers.=C2=A0 I=E2=80=99d be very open to =
exposing something similar<br>
&gt;&gt; (an attribute) for static checkers.<br>
&gt;<br>
&gt; wow thanks for the info! I knew compile time checks would be possible =
but<br>
&gt; requiring compiler operability which is a higher hanging fruit for me.=
 <br>
<br>
I don=E2=80=99t know the details of `__rcu&#39; from the Linux kernel. I th=
ink it=E2=80=99s<br>
just a macro that expands to nothing by default, but Sparse treats it as<br=
>
an attribute.=C2=A0 I=E2=80=99m not sure exactly what checks Sparse perform=
s with it,<br>
but I suspect it involves traversing the program=E2=80=99s control-flow gra=
ph<br>
(CFG), ensuring that pointers marked with the `__rcu&#39; qualifier are:<br=
>
<br>
=C2=A0 - obtained via rcu_dereference<br>
<br>
=C2=A0 - only dereferenced under RCU lock protection<br>
<br>
&gt; Is &#39;__rcu&#39; compatible with custom concurrency? For example<br>
&gt; rcu_dereference a pointer then locking a mutex inside the pointer then=
<br>
&gt; unlock read then continue using the pointer?<br>
<br>
I don=E2=80=99t see why that would be a problem for the static-check algori=
thm I<br>
described above.=C2=A0 If a pointer needs to be protected by a mutex for<br=
>
mutation, that falls outside the scope of RCU, as far as I know.<br>
<br>
&gt; I cant come up with something usefull other than a language rework. Is=
<br>
&gt; it much work making the __urcu attribute?<br>
<br>
I suppose not.=C2=A0 On top of my head, it would involve adding some pointe=
r<br>
qualifier and function attributes to the primitives exposed by URCU.<br>
Users would also need to use the pointer qualifier when working with<br>
RCU-protected pointers.=C2=A0 The qualifier and the attributes would expand=
<br>
to nothing by default, letting static checkers defining them to internal<br=
>
values.=C2=A0 I suggest you read `Documentation/RCU/rcu_dereference.rst&#39=
; in<br>
the Linux kernel tree if you are interested.<br>
<br>
In its current state, this would not be very useful because none of the<br>
major compilers provide static analysis for RCU.=C2=A0 However, implementin=
g<br>
such analysis, as a plugin, wouldn=E2=80=99t be overly difficult for someon=
e<br>
familiar with Clang or GCC, I suppose.<br>
<br>
[...]<br>
<br>
Thanks,<br>
Olivier<br>
-- <br>
Olivier Dion<br>
EfficiOS Inc.<br>
<a href=3D"https://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.efficios.com</a><br>
</blockquote></div>

--0000000000000b9882063f2d7704--
