Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19577CA1013
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Sep 2025 18:09:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cHnYW1t4Zz1tfF
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1757009359;
	b=UhVhv0X4Kj7/g6IilISwtyqtRh+yflpE0OBiodc55ARRE1KUhZ/exSIdC+3Jqg4tk1Sm
	 VPOOZzlJdouffjdOXNQwbG+8ApgPNpXrUEim27wVbiMRJXzJ7tPY+LnCnktAxuyeb3Ngd
	 nlfh+iXHEiQ7P4L6H8sDKmDyw7joAhCmlNpvZWPuSqaAcFVwql14hGByRBqhQxMxzZIdj
	 WG/f88IUUT/rk3461kFvMBqj1B4knMQWA/DwBk/6LmyF+WXcxuWgHkYNYuDkvj1886aWV
	 Hf7U1kQMU0MFzk7/sJ5oHmCWvFydzVLrAEbLpEs05Duy2yu2EU2s/CPxDV1OnA//b8w==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1757009359;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=RChMLdq4mPQ3u1Cvdsd5rqitZV7fRNH3+tRKlSNF6kg=;
	b=iCdLKcCt4gRjkWuBuUvZWVL2XnZESvG5/9hBezAHe+nWsFIWx59VJzaxEqCItl/rQz/E
	 oMPvafmkO9LIkmqsgxfF2EUPtP6FZDaMmHtYJG65KhSQx3KpiBOpxSEDXPucirOMuSxoE
	 yAkEzn60fyoL5LxQLwqJWNzd1fJYVn65ZeNZzl99K6dYy5qhzU7lNk/yO/hLgv51JQ2lM
	 Nn1Kgc0Y/qup1w0POUfwvsQBEbLL8pE1kEjYpZIWWVz3OXOqGQ03Hci2MAW+2t82rxbo8
	 oD7fKXQTJlbjxpe07ADxxL0NOkNPUyszBb7e3SddHKN0WdKWH9xSpY6pA/2+MQ7KnPw==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cHnYW1t4Zz1tfF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1757009359;
	bh=RChMLdq4mPQ3u1Cvdsd5rqitZV7fRNH3+tRKlSNF6kg=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oSaMj42vnv45DUcSkQTQd3x1i53PEOdA48Kp0LBCMGxkQR7KPUbUeI79RnZSohSbh
	 Vz9yuYQS5y7PIBu18DkEyTqeewrNRThkHLzOdkyK4PZbg/mTDiSWiP1eRV8hbQKjKq
	 R+sNwoubXcdYCPhRMGCZyH5Z/sP1ggqLyzhKglePXyyLjScJb6qV9y/Me3lpK2TxI1
	 SUuPEVDj8lqh1UUGYFzEA2WDVJJ8Z16B/OKrukKoED0pHoqdGieSDsylwZy2rCbqt3
	 uz81N58TD74b+HMiZkr09zKEmSGUZ2z5hpVtR2qYBe0fXYffyLTUY8RHwVpjSKJq1n
	 JiQn2xmt1xKnw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cHnYW1t4Zz1tfF;
	Thu,  4 Sep 2025 14:09:19 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cHnYT3587z1tlr
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cHnYT3587z1tlr
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by lists.lttng.org (Postfix) with ESMTPS id 4cHnYT3587z1tlr
 for <lttng-dev@lists.lttng.org>; Thu,  4 Sep 2025 14:09:17 -0400 (EDT)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b0449b1b56eso217269366b.1
 for <lttng-dev@lists.lttng.org>; Thu, 04 Sep 2025 11:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757009356; x=1757614156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RTfAdCbxCWKiVTccYaS1D/6o+MX0i2e+bvo91KmjKmQ=;
 b=dtLmbJsT/+MAeD5asGwmKFzP5kHy7YaPANWqgfFGxFP4SDG87IInyNcrojncXRe+ez
 KqcMl9Qro7nQtl7wGdKgt3dE2LUgLrUUE2CR9l6pzjwn5yd4xdGOfOoxc8yxlv5rog8x
 fS1eWDhEI6JCsOncGOnx1weeT8CHaNF2hNkPGsgaNGzpBiALXC9Uh0/VPaOHv1g/CnfS
 YDLb8ttpwYhPz4T/EnV81MDeQ60f1Ytom4pesFDGdaRn8seGwmmFGKCGkI/z6kK5VDDE
 D7tcTq8nZfRHn7GsT+orhbPzx0x7f47o3WeuH7xO5Rn4OyBMRbsyWBL4zd+J0/ass4hc
 4bgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6VuLlZB9IDUjdbLYYi6kcnSIthNuasbhG/YSS7hKjH+qH7WhuP1NO5okG92GmXytQpN3pwGqSLX0=@lists.lttng.org
X-Gm-Message-State: AOJu0Yzj5d/PJd/iYZQBvV4d9pVI6HQPdO4uXdOwySVN+7NQem9hNZGV
 K+XoL6uBpsgRyxIoriHV9CTsrYMWKY46u3+5ycFLzmWf+6yhlWrkKeVpuU3hkBB7txBUGeTQNUK
 MG23J+i3h/jtbBJS7rtQGeWDSw8Ao+7qorbcJ
X-Gm-Gg: ASbGncsgXob5Jy7/QL/t3a9ZWd9xGy+s1JSpaR0RjN/csjiad+ebWLoExfPS3OXyADV
 7emcKoH5QB0BxS946Zzz68djBVjHaaB678NzNlHOCbHhLfaJrjDfwRIQpQCW/ksw4eOjp5IiLEB
 7MAjaBL5STCNO62w3EvE+PRbyNtpU+lkN1IGZQpKBz9mbjnApvTnsBN12NB/gNsG7aAJIv/wS/Z
 J2CGw==
X-Google-Smtp-Source: AGHT+IHf2BYbEw7Xup6Gex6/e6JlZNyEUUuwg/25jl8EUD5FdFfdj6/gpYk7fFM65VlCwYo+YKRqplYEmbP4M+5VhoY=
X-Received: by 2002:a17:907:86a6:b0:afe:bdcb:9e62 with SMTP id
 a640c23a62f3a-b01d973074dmr2149074566b.33.1757009355673; Thu, 04 Sep 2025
 11:09:15 -0700 (PDT)
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
In-Reply-To: <CAKGpcioZbhyTUqLmNSnpuPw=jbi6eZV6ubbFQtvFD6VKn3wKxA@mail.gmail.com>
Date: Thu, 4 Sep 2025 20:09:03 +0200
X-Gm-Features: Ac12FXztgBq-MYzceOrVXKJ_oxkxptpNGLuuUdCynkx6MCMJ4tzwtcR-OKxjdn0
Message-ID: <CAKGpcipgGfFwastwUrFxeA=BXW5z_9+C2PGuDyR1pQF8rtQe-Q@mail.gmail.com>
Subject: Re: URCU feature request?
To: Olivier Dion <odion@efficios.com>
Content-Type: multipart/alternative; boundary="000000000000831509063dfd9e41"
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

--000000000000831509063dfd9e41
Content-Type: text/plain; charset="UTF-8"

> One thing you could do is to make something like an rcu_assign_data()
> that does the assignment and checks rcu_read_ongoing().  Alternatively,
> if you are willing to put infrequent random delays in rcu_read_unlock(),
> an address sanitizer might detect the resulting use-after-free.

Sorry for being late to answer :/
I have thought of that but it's so easy to just not use rcu_assign_data()
or a equivalent read function to check if the read is done within a read
section. Maybe it's the best possible option

Thanks
Thobias

tor. 4. sep. 2025 kl. 20:06 skrev Thobias Knudsen <thobknu@gmail.com>:

> > I am confuse about the overall discussion here.  Are we talking about
> > static checking of RCU pointers usage or runtime checking?
> >
> > Is is possible to see the implementation you made so I can understand
> > better?
>
> Sorry for being late to answer :/
> The library overrides a subset of urcu and lfht functions with macros and
> replaces them with other functions which checks in runtime if the functions
> are called in the correct order.
> here is the code: https://github.com/ThobiasKnudsen/urcu_lfht_safe
>
>
> ons. 3. sep. 2025 kl. 03:35 skrev Olivier Dion <odion@efficios.com>:
>
>> On Tue, 02 Sep 2025, Thobias Knudsen via lttng-dev <
>> lttng-dev@lists.lttng.org> wrote:
>> > Yes but all read/write operations doesn't have the syntax of a function
>> as
>> > you used in the example here i.e. use(...). When it is a function you
>> can
>> > easily just change the implementation to check if it is called inside a
>> > read section. Some reads and writes are usually done by this syntax (a
>> = b)
>> > and '=' cannot be overridden.
>> >
>> > BTW just saying that what we're talking about now is not the original
>> > topic, but if someone has an elegant solution to this that would be
>> > nice!
>>
>> I am confuse about the overall discussion here.  Are we talking about
>> static checking of RCU pointers usage or runtime checking?
>>
>> Is is possible to see the implementation you made so I can understand
>> better?
>>
>> Thanks,
>> Olivier
>> --
>> Olivier Dion
>> EfficiOS Inc.
>> https://www.efficios.com
>>
>>

--000000000000831509063dfd9e41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; One thing you could do is to make something like an r=
cu_assign_data()<br>&gt; that does the assignment and checks rcu_read_ongoi=
ng().=C2=A0 Alternatively,<br>&gt; if you are willing to put infrequent ran=
dom delays in rcu_read_unlock(),<br>&gt; an address sanitizer might detect =
the resulting use-after-free.<div><br></div><div>Sorry for being late to an=
swer :/</div><div>I have thought of that but it&#39;s so easy to just not u=
se rcu_assign_data() or a equivalent=C2=A0read function to check if the rea=
d is done within a read section. Maybe it&#39;s the best possible option</d=
iv><div><br></div><div>Thanks</div><div>Thobias</div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">tor. 4. sep. 2025 kl. 20:06 skrev Thobias Knudsen &lt;<a href=3D"mailto:t=
hobknu@gmail.com">thobknu@gmail.com</a>&gt;:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div dir=3D"ltr"><div>&gt; I am confuse about =
the overall discussion here.=C2=A0 Are we talking about<br>&gt; static chec=
king of RCU pointers usage or runtime checking?<br>&gt;=C2=A0<br>&gt; Is is=
 possible to see the implementation you made so I can understand<br>&gt; be=
tter?</div><div><br></div>Sorry for being late to answer=C2=A0:/<div>The li=
brary overrides a subset of urcu and lfht functions with macros and replace=
s them with other functions which checks in runtime if the=C2=A0functions a=
re called in the correct order.</div><div>here is the code:=C2=A0<a href=3D=
"https://github.com/ThobiasKnudsen/urcu_lfht_safe" target=3D"_blank">https:=
//github.com/ThobiasKnudsen/urcu_lfht_safe</a><br><div><br></div></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">ons.=
 3. sep. 2025 kl. 03:35 skrev Olivier Dion &lt;<a href=3D"mailto:odion@effi=
cios.com" target=3D"_blank">odion@efficios.com</a>&gt;:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On Tue, 02 Sep 2025, Thobias Knudse=
n via lttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"=
_blank">lttng-dev@lists.lttng.org</a>&gt; wrote:<br>
&gt; Yes but all read/write operations doesn&#39;t have the syntax of a fun=
ction as<br>
&gt; you used in the example here i.e. use(...). When it is a function you =
can<br>
&gt; easily just change the implementation to check if it is called inside =
a<br>
&gt; read section. Some reads and writes are usually done by this syntax (a=
 =3D b)<br>
&gt; and &#39;=3D&#39; cannot be overridden.<br>
&gt;<br>
&gt; BTW just saying that what we&#39;re talking about now is not the origi=
nal<br>
&gt; topic, but if someone has an elegant solution to this that would be<br=
>
&gt; nice!<br>
<br>
I am confuse about the overall discussion here.=C2=A0 Are we talking about<=
br>
static checking of RCU pointers usage or runtime checking?<br>
<br>
Is is possible to see the implementation you made so I can understand<br>
better?<br>
<br>
Thanks,<br>
Olivier<br>
-- <br>
Olivier Dion<br>
EfficiOS Inc.<br>
<a href=3D"https://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.efficios.com</a><br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000831509063dfd9e41--
