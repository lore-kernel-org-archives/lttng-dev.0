Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-10.mailgun.net (m43-10.mailgun.net [69.72.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BB4D41D66
	for <lttng-dev@archiver.kernel.org>; Thu, 11 Dec 2025 16:21:51 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1765470110; x=1765477310;
 h=Sender: Sender: Cc: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: Content-Type: To: To: Subject: Subject: Message-ID: Date: In-Reply-To: References: MIME-Version;
 bh=Xy7AOMakmNIjKBVdT2CNfGgTwVY5k4CMZ7CWxbTDC/k=;
 b=glJkuPSh+b5q+vrH9efjVsuDUkI+dUTu2fDkAXDeh568tPcUp67rGyYs0JpzvDlJDMYGGDAlGFgvACiChVu3EUwY+0yHcEr8zSytI27xtb5q2AtVL9deJfn2zJ0bxufCwq27eSaRnsLIOPVqcU3tZIR+F0BZO3Nymowrt0zxEnY+9iv6uoj+BDmbZE0Ss2r3u0t/eO/rDIw7CMVvwcTZai5wWwxQAFjsurFNFHA3ZDD5LBl4cl9ODA2o23ezdLpSKhktZkECxWi/iya2//pl6flZH2CpJnGUFJt3m5LpPBol9GIz4OL4aLnQh5TGDIGf7EThXhf+NJOXsC7kBIkDBg==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 0ef64692cb58f1c19aed6e05c4ec705d89eec772137b7312a133ac21fc6eff89 with SMTP id
 693aef9ea2359fc2d0d5b316 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 11 Dec 2025 16:21:50 GMT
X-Mailgun-Sending-Ip: 69.72.43.10
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dRyXG2k6Bz1x4R
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1765470110;
	b=qcY6S9I6L96SGWLNq32wIknkn3UOs/mTfCyiVQv3JjqlfqtV2MVf8q9qgRuCjyxLem4A
	 SObAtkMbaXKx5cE0Uy50E4qn22sNNnQC69BBnG5XGkCUAGLJMFMwOBh5MK90/gVwzvo8M
	 xSxAAo8eK9cAaHlz4Mo4DCuqpVCWuutllQFadOsnJ0tXaHRqwNa/DFYWMDVgjb1Qe/wa5
	 7Y/czDFcEoaw3nrRRVDyIA3y2e1QCnylwry5Bpc5GTAedds1ekp+hLx4HYOkvI1wjjT8u
	 hld9mTrMrsx1m2d7EhM/Tny5/kge+LEtqAzyY/zvIDhdtlvZiCByneRaBiUkmlcUd7Q==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1765470110;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=ylJAjhyV+umwtdVX9mmjXbl3PuaVdUlcVkqrTUmenF0=;
	b=Bc9SYC4zeOCr/1+u54WpKNFGcw3TNUBaMlltJclLgnCIfsktDCbqdWW5jdciLMrgffR9
	 tiiwJoS3pBsDx+zJFoianBeqHGFI0uQU8P25OGo+OXfldcq2FZn2QtBaEhd1JZnAxu9ya
	 COJZ55MuDmIOyqHkcVspA6jp5sGeAIrcvaqHrCa4hPeynEatJXtL1eVGRNBUkObCXD4TP
	 xMOrWoVAALD7d9z3JrQijWx4tzL6MJg+zy49GdieJTx5rX4ykLX1N/VLdImEEBWGSbo+F
	 XlsIh77R9J01n/tygVsK2BQnMwVJtM4lQCd6KFrugv2Ia4nFnl82SL6KsIXCAyyDoeQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dRyXG2k6Bz1x4R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1765470110;
	bh=ylJAjhyV+umwtdVX9mmjXbl3PuaVdUlcVkqrTUmenF0=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=B/dAt89rxu6nLHVY092vNgmE4v4rlsRNgvgspqXO8c1f3DXxuO4mUD9H4Qc9hFjdr
	 QHDlM/C/1SBCO7sucmKDEHRMHCV3X8CVoJda9ngOFBayelhyPWbS7jxA1u30RHNFtS
	 CZMRfpD3fNhSS41fvxaOn6NM1XI0MfBEJKY0VwwLk8mxMdBPrezyO/SxvdQyQaiLcH
	 RXKgXRBYpWcIKpZ/g1PdfEtfS8CXWgSFb1x8Juw6L+hbD9k5g69yfI5+Ejp28pm7B6
	 ZDDswORI8jq5GgqPPdYtDJHd/rAoy4HHb6FwPdo8yMic1qe+r7p/3U8+N4zyearu2h
	 vBAm2j+zCV+cA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dRyXG2k6Bz1x4R;
	Thu, 11 Dec 2025 11:21:50 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dRyXF1sMWz1x4C
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dRyXF1sMWz1x4C
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by lists.lttng.org (Postfix) with ESMTPS id 4dRyXF1sMWz1x4C
 for <lttng-dev@lists.lttng.org>; Thu, 11 Dec 2025 11:21:48 -0500 (EST)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3ec3cdcda4eso196722fac.1
 for <lttng-dev@lists.lttng.org>; Thu, 11 Dec 2025 08:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765470107; x=1766074907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xy7AOMakmNIjKBVdT2CNfGgTwVY5k4CMZ7CWxbTDC/k=;
 b=rn9SsloLOY0l5F8GpsoShU/p2z/SnunC54v9tNIoPKzALlHBOcKivgOgrRQMNSjzk9
 pf5IydY9S3ZPHj+8vEObmMhPldUGAl/lcTweUwe3oh7xx/W+7hQSQCBoriRUkCL1qz21
 8cVz5H2yEQrINj8ohnzjasL7pWYpuo51qGIv2rcRH4ZO6GOcn7vvqaFPKPEmNJ01h1ox
 +lwS02jE34vQgIjMWc9ttHeosOB+ZOTZdvR/93m2EGLPsyVrkvpk6cPuOERp7AZx6UtG
 KSPFan0grgPYSz801VxZZOnKnwvZJYn1aXH5i9F9Ry0sxroSv1sTcsTtSCSmjcx6TfU4
 /6Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX78wJRCGrMpGKOwEa3dtOxG2m6uAz2QsSBnbuMaus1BbDiHH3J6jTSrEHyY6vzUvJXWn59B1y3/gA=@lists.lttng.org
X-Gm-Message-State: AOJu0Yxx97eJ2CV+SQsnZJp9SPKUbRrPu/WRAbs66LU6OHDKe5jBQInQ
 eB87XBuy1meMAdZCh/QSyA3nVYbuy3GyJFfL8xPhPdCe2J3vskVge83K95DLfgQIjZfyMI2Mnmx
 c2Bb76avnhQgbJV6hlr32gITcSjz45P8hacIiUkXclw==
X-Gm-Gg: AY/fxX4jozMSgzdlfwc7N+cZH7jJOAEJWL41x4zZ4v6ZvPksTu4FyGI0rDixqfmzL7E
 hzsQS+ahosiMg7U22EC/gwc6lu8uDJa0LQExO9NyeYwlVBcUCusOwlG7Fr75JwfOvbg7ftHV+as
 d0EFdQWAsElpKMA1u4yqM3FIyi5rduUxRiG2k05oUVYTrYsTxe3vJd7z2Bf1HEpiie1i1HQgjIR
 DfpAZ58ognUG95sBechdggPb8lfM2dByxKlyQ/aqcadbtI/cOzmplu5n+Wjjqvu4toD7hEQvWoM
 JZtAZWzeSoiMjYQrkkYn34WEGQE=
X-Google-Smtp-Source: AGHT+IGKAkN7wmnOMcub9Nz9gHRL1irbM68wEWZdqpI9xveElohpgZjXtFQWlrwE+KRwaSp2PMVHpjWEGh6at5eM9cw=
X-Received: by 2002:a05:6820:1891:b0:659:9a49:8f2e with SMTP id
 006d021491bc7-65b2ad74c50mr3769468eaf.63.1765470106988; Thu, 11 Dec 2025
 08:21:46 -0800 (PST)
MIME-Version: 1.0
References: <CAOQX81f1zGCsnr3Ksjv0WoO-J4-OULanefNxzWdrxP8b4+aqJg@mail.gmail.com>
 <87a7e3d3-3ce2-4ded-acdf-bc7f152cdcec@efficios.com>
 <073db198-6792-4caa-81f5-ac65f5d76f1e@efficios.com>
 <CAOQX81e-dtfgLQ+xTt8kr-Qxc+hhiaW4vHF=S=RDVsMR0-TnLA@mail.gmail.com>
 <ad04c3c2-c0ac-4ed6-96e1-29c661e868f5@efficios.com>
In-Reply-To: <ad04c3c2-c0ac-4ed6-96e1-29c661e868f5@efficios.com>
Date: Thu, 11 Dec 2025 11:21:35 -0500
X-Gm-Features: AQt7F2rWgLZUTOyPHG-T4oEar2RgMuS_pcbTaICTAvQxig7VIPzpigOpFpgdePY
Message-ID: <CAOQX81d3NM5YV6gNCCNoA+VAReRu8oe55=vr-TOzBzcRWCHVKQ@mail.gmail.com>
Subject: Re: Question about LTTng Context
To: Michael Jeanson <mjeanson@efficios.com>
Content-Type: multipart/alternative; boundary="00000000000096c3360645af8af8"
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
From: Amir Najafi Zadeh via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Amir Najafi Zadeh <anajafizadeh@cs.stonybrook.edu>
Cc: lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--00000000000096c3360645af8af8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll try that too. Thanks for mentioning it.

Cheers,
Amir

On Thu, 11 Dec 2025, 11:14 Michael Jeanson, <mjeanson@efficios.com> wrote:

> On 12/11/25 10:51, Amir Najafi Zadeh wrote:
> > Michael, Kienan, Thank you both for your replies. As you mentioned the
> > cgroup namespace, it isn=E2=80=99t very helpful in some cases. Containe=
rs may
> > share the same cgroup namespace, and the container runtime often avoids
> > giving each container a private cgroup namespace for performance and
> > security reasons. Because of this, the cgroup namespace can=E2=80=99t b=
e used as
> > a reliable or unique label for filtering trace logs.
> >
> > In my case, with container-d you can inspect a container, find its PID,
> > and then check /proc/<pid>/ns/cgroup, but you=E2=80=99ll see that diffe=
rent
> > containers often have the same cgroup namespace ID (e.g., in the
> > following logs you can see the calico-node and kube-proxy containers
> > sharing a cgroup ns).
>
> If you want to track containers, the pid namespace is the one used by
> most container runtimes but I don't know specifically for container-d.
>
> >
> > ```
> > Name: calico-node  CID:
> > b5624afe31b005725f4ba53c7b6fe758f3c09fabf013085231ff8b97588f6ace  PID:
> > 2243  cgroup_ns_inode: 4026531835
> > Name: kube-proxy  CID:
> > 52f3c12def7a680f61a925ac92dd5ebd5eba6cad17d671efbfd1d40db7dff624  PID:
> > 1851  cgroup_ns_inode: 4026531835
> >    >> MATCH FOUND: shares ns with container:
> > b5624afe31b005725f4ba53c7b6fe758f3c09fabf013085231ff8b97588f6ace
> > (calico-node)
> > ```
> >
> > Thanks again for your answers. I hope this feature appears in a future
> > patch.
> >
> > Best,
> > Amir
> >
> > On Thu, Dec 11, 2025 at 9:57=E2=80=AFAM Michael Jeanson <mjeanson@effic=
ios.com
> > <mailto:mjeanson@efficios.com>> wrote:
> >
> >     On 12/11/25 09:30, Kienan Stewart via lttng-dev wrote:
> >      > Hi Amir,
> >      >
> >      > On 12/10/25 9:40 PM, Amir Najafi Zadeh via lttng-dev wrote:
> >      >> Hello everyone,
> >      >>
> >      >> I hope you=E2=80=99re doing well. My name is Amir, and I=E2=80=
=99m a PhD student
> in
> >      >> the Computer Science department at Stony Brook University, New
> York.
> >      >>
> >      >> I have a question about the LTTng context that I haven=E2=80=99=
t been
> >     able to
> >      >> find an answer for in the docs or man pages. Does LTTng support
> >     adding
> >      >> the cgroup ID or cgroup path as a context field? I want to
> >     filter my
> >      >> trace results based on cgroups.
> >      >>
> >      >
> >      > I think you're looking for the `cgroup_ns` context which adds th=
e
> >     inum
> >      > of the cgroup namespace as a context field.
> >
> >     This will give you the ID of the cgroup namespace but we don't have
> >     contexts for cgroups themselves. It's probably something we would
> like
> >     to have but there is no concrete plans on implementing this at the
> >     moment.
> >
> >      >
> >      >> If this isn=E2=80=99t supported, are there any plans to add it =
in future
> >      >> versions, such as 2.14?
> >      >>
> >      >> For reference, I=E2=80=99m currently using LTTng 2.13 on Ubuntu=
 24.04
> with
> >      >> kernel 6.8.0-87-generic.
> >      >>
> >      >> Cheers,
> >      >> Amir
> >      >> --
> >      >> *Amirhossein Najafizadeh*
> >      >> *PhD Student, Computer Science Department, Stony Brook
> >     University, N.Y.
> >      >> File systems and Storage Lab (FSL)
> >
>
>

--00000000000096c3360645af8af8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I&#39;ll try that too. Thanks for mentioning it.<div dir=
=3D"auto"><br></div><div dir=3D"auto">Cheers,</div><div dir=3D"auto">Amir</=
div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Thu, 11 Dec 2025, 11:14 Michael Jeanson, &lt;<=
a href=3D"mailto:mjeanson@efficios.com">mjeanson@efficios.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">On 12/11/25 10:51, Amir Najafi Za=
deh wrote:<br>
&gt; Michael, Kienan, Thank you both for your replies. As you mentioned the=
 <br>
&gt; cgroup namespace, it isn=E2=80=99t very helpful in some cases. Contain=
ers may <br>
&gt; share the same cgroup namespace, and the container runtime often avoid=
s <br>
&gt; giving each container a private cgroup namespace for performance and <=
br>
&gt; security reasons. Because of this, the cgroup namespace can=E2=80=99t =
be used as <br>
&gt; a reliable or unique label for filtering trace logs.<br>
&gt; <br>
&gt; In my case, with container-d you can inspect a container, find its PID=
, <br>
&gt; and then check /proc/&lt;pid&gt;/ns/cgroup, but you=E2=80=99ll see tha=
t different <br>
&gt; containers often have the same cgroup namespace ID (e.g., in the <br>
&gt; following logs you can see the calico-node and kube-proxy containers <=
br>
&gt; sharing a cgroup ns).<br>
<br>
If you want to track containers, the pid namespace is the one used by <br>
most container runtimes but I don&#39;t know specifically for container-d.<=
br>
<br>
&gt; <br>
&gt; ```<br>
&gt; Name: calico-node =C2=A0CID: <br>
&gt; b5624afe31b005725f4ba53c7b6fe758f3c09fabf013085231ff8b97588f6ace =C2=
=A0PID: <br>
&gt; 2243 =C2=A0cgroup_ns_inode: 4026531835<br>
&gt; Name: kube-proxy =C2=A0CID: <br>
&gt; 52f3c12def7a680f61a925ac92dd5ebd5eba6cad17d671efbfd1d40db7dff624 =C2=
=A0PID: <br>
&gt; 1851 =C2=A0cgroup_ns_inode: 4026531835<br>
&gt;=C2=A0 =C2=A0 &gt;&gt; MATCH FOUND: shares ns with container: <br>
&gt; b5624afe31b005725f4ba53c7b6fe758f3c09fabf013085231ff8b97588f6ace <br>
&gt; (calico-node)<br>
&gt; ```<br>
&gt; <br>
&gt; Thanks again for your answers. I hope this feature appears in a future=
 <br>
&gt; patch.<br>
&gt; <br>
&gt; Best,<br>
&gt; Amir<br>
&gt; <br>
&gt; On Thu, Dec 11, 2025 at 9:57=E2=80=AFAM Michael Jeanson &lt;<a href=3D=
"mailto:mjeanson@efficios.com" target=3D"_blank" rel=3D"noreferrer">mjeanso=
n@efficios.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:mjeanson@efficios.com" target=3D"_blank" =
rel=3D"noreferrer">mjeanson@efficios.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 12/11/25 09:30, Kienan Stewart via lttng-dev wro=
te:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi Amir,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On 12/10/25 9:40 PM, Amir Najafi Zadeh via lt=
tng-dev wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Hello everyone,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; I hope you=E2=80=99re doing well. My name=
 is Amir, and I=E2=80=99m a PhD student in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; the Computer Science department at Stony =
Brook University, New York.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; I have a question about the LTTng context=
 that I haven=E2=80=99t been<br>
&gt;=C2=A0 =C2=A0 =C2=A0able to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; find an answer for in the docs or man pag=
es. Does LTTng support<br>
&gt;=C2=A0 =C2=A0 =C2=A0adding<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; the cgroup ID or cgroup path as a context=
 field? I want to<br>
&gt;=C2=A0 =C2=A0 =C2=A0filter my<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; trace results based on cgroups.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I think you&#39;re looking for the `cgroup_ns=
` context which adds the<br>
&gt;=C2=A0 =C2=A0 =C2=A0inum<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; of the cgroup namespace as a context field.<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This will give you the ID of the cgroup namespace b=
ut we don&#39;t have<br>
&gt;=C2=A0 =C2=A0 =C2=A0contexts for cgroups themselves. It&#39;s probably =
something we would like<br>
&gt;=C2=A0 =C2=A0 =C2=A0to have but there is no concrete plans on implement=
ing this at the<br>
&gt;=C2=A0 =C2=A0 =C2=A0moment.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; If this isn=E2=80=99t supported, are ther=
e any plans to add it in future<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; versions, such as 2.14?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; For reference, I=E2=80=99m currently usin=
g LTTng 2.13 on Ubuntu 24.04 with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; kernel 6.8.0-87-generic.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Cheers,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Amir<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; *Amirhossein Najafizadeh*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; *PhD Student, Computer Science Department=
, Stony Brook<br>
&gt;=C2=A0 =C2=A0 =C2=A0University, N.Y.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; File systems and Storage Lab (FSL)<br>
&gt; <br>
<br>
</blockquote></div>

--00000000000096c3360645af8af8--
