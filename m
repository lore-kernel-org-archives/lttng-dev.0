Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798EACA1012
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Sep 2025 18:06:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cHnVZ6Sj5z1vWr
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1757009208;
	b=WpVtQngAiLMbjoimoTB++gVwcz4zbguwkj3iYRXdRGUUNczCD0H6CJEWAFV2P6QcTbyN
	 bVEPOZCTOyP62FMQugvTgQ+gi8idninTxV26lcvXnKsldTOqIMJs9MmE+bik/rmBNXHwa
	 xIONkSGyjE1lKeH0iqjPqvrE3JmRDmMlUYRFZBzya3m2PawR/UUaBNTKOC8mHdjEq2aGp
	 7syQqbZyf85dSCxa7zjYGafv35lS6YqUzDm/AvkM5amxvz4s3CPVWnE5VhjWHY1oP6aEX
	 2pF2MDxGrlGVzRer+HgHDz9v0+JXlm4dElOpNaeptrBnRMRegmSR2YP7Upr/W7tnMrA==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1757009208;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=UNlm9ytFzZP+tqUypqE9euHNV9YiPB9YZM0dmZh1aCk=;
	b=e49bFlt/2h9vglqqW8FXe6QMrNDyUHriuaTVh+xVRqErqNeAlzZ9z/POipjPZc1SB9vC
	 eJvAbOMF27prGG0jEah3HulgEjM60pJV4eyKDETBz/553975jQEED7kMsJ0QsXouuYpkE
	 aXR1JRI96OkyULN3RGGPdDZut3ioymyJRlmD9zhRtdzAwmQXrrOfFE/0tiAcEcr2jDacB
	 xepvs5BUcZ8VO/ayx0abXVPZklUNTi3KUQe1M7Qmwn5f/chMbJdyjdtpN3GwTGUh8eohG
	 RVJTDbY7fwMjKYrN2gILmEkR+Ak2p3YHJT0hiAjO1CHlWh6Lzk6VTmouEVoNoks/aCA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cHnVZ6Sj5z1vWr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1757009208;
	bh=UNlm9ytFzZP+tqUypqE9euHNV9YiPB9YZM0dmZh1aCk=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hfXD/DIoxnCx3KZGY13GLuE5qYSVdH0BvCzoI+07Cu+fQBRwUA1cKSpE8pkiUyeSw
	 327fjQ9Krs3GB9ZVOuwFCk0sUG6oBiTRyv6XzHsn0PyiPlSnimjk2w2ChOAWfucPAc
	 MPCDY5BNWZ2bG9nbMQbVrmAcKErRWiyxrt8C1lWFlDJ5MZoWDQucZJki1OobGbc+UV
	 B06Qxrcn3x4heDtUgQ9vB4NA0rdTTQ32CRotfhmPyJTcItSRirqgYsOiNwxLpn2Qzw
	 K/eCjKqn5QOiAJQodcMqaWbwn95u0DUziIi2VKcLwXzECpv/LBHkpzWz401LV3fQQD
	 SWn1d3Fv+NV0Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cHnVZ6Sj5z1vWr;
	Thu,  4 Sep 2025 14:06:46 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cHnVX4gDgz1vWf
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cHnVX4gDgz1vWf
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by lists.lttng.org (Postfix) with ESMTPS id 4cHnVX4gDgz1vWf
 for <lttng-dev@lists.lttng.org>; Thu,  4 Sep 2025 14:06:44 -0400 (EDT)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b0475ce7f41so256043666b.1
 for <lttng-dev@lists.lttng.org>; Thu, 04 Sep 2025 11:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757009198; x=1757613998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J1ojAG4Q9+qalxAZQhcWSR+03UMjkkBJUS41Qk6/oD8=;
 b=g641IJF25lDP09V7JKrYJtUvwRiobQT3IhO3cKgWJ4fCdyd5gSvHYKnA+OOj/un7G9
 5cKg7YYs/mGJ3kVvDL7/qwkdeHZMVER3pGa+pLMSfUphKJuJU0YQmX7luuNEEnrrouZn
 McdIhL+sfmMMhfcK34ZacrJbFj35yyxWWLAf268iQGllRbk22dfTXNrhZX69trAgir8d
 V1PlfRCs9CQGq5kWpHBpmuDkCvdd/BLWxXXdYDkAitCl6JGKr7XJpDAkoc3rUIO9bjdg
 AP2o/iHX2uSRb6fWM482oJwpdBWmrCmTrEed7QVsEnN4Y+FydXaSYr/S1aZxahdJFNpY
 Enmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjWcYfo3GruH/mBtNxDyzU/JNH4RGL6HTr2H+Fb5FBW6H/onzbNYwHK64wrjH4CTwKKOJF9PMfE04=@lists.lttng.org
X-Gm-Message-State: AOJu0YxnDIJTsIT9rAGKxxy6qhYZfO6USmFsyCDh4eDK4rmO4pYFgFsv
 Ei2jeSL7BPc6sZT2qDURSv1EQHCBacaG4859w4z6crpXHnOfGr+HcaJPsuZZsLhrO0i0QS1aBDl
 dxLaMh8bek9u2u+4jTAJVqyowM2KKHz4=
X-Gm-Gg: ASbGncvW1NA6Iry46QbZjSl52SSjAg0NpvgK1T3vcdgFCs3Wyr2Fkqi6RFcdGWh3ZSU
 WFdwTorpCT1PFxzywUDxeqqpvF6Sfy4bXa6KsGni9CSmE9PYcDa5np9YY5CYgXK1dGXacqyxa8O
 ZCjKmEAbYVQtAAvjqIQtYLK6/VOJ9NP+5rxRPOUe34DpZWXyu1cAK9cww757EZkzwQLi1g6aSqk
 HpyaQVJyXuzwdrr
X-Google-Smtp-Source: AGHT+IEObLgWSXtfFwlUvJsNWA0TaPmJ3ido8Ik3UDF07fH9P71F1uOPu3ZRX0hujB7v2P4Hw651UQjIdO68byAtcsk=
X-Received: by 2002:a17:907:7ba0:b0:afe:194c:b45f with SMTP id
 a640c23a62f3a-b01d971906dmr2102384866b.37.1757009197937; Thu, 04 Sep 2025
 11:06:37 -0700 (PDT)
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
In-Reply-To: <87y0qwwc6j.fsf@laura>
Date: Thu, 4 Sep 2025 20:06:26 +0200
X-Gm-Features: Ac12FXyc-i9cQ2wmRrLnvdQlTYv0luEeC3aYy2UW50xeYz2COOmtfLB1whPNU0U
Message-ID: <CAKGpcioZbhyTUqLmNSnpuPw=jbi6eZV6ubbFQtvFD6VKn3wKxA@mail.gmail.com>
Subject: Re: URCU feature request?
To: Olivier Dion <odion@efficios.com>
Content-Type: multipart/alternative; boundary="0000000000001c3987063dfd95c9"
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

--0000000000001c3987063dfd95c9
Content-Type: text/plain; charset="UTF-8"

> I am confuse about the overall discussion here.  Are we talking about
> static checking of RCU pointers usage or runtime checking?
>
> Is is possible to see the implementation you made so I can understand
> better?

Sorry for being late to answer :/
The library overrides a subset of urcu and lfht functions with macros and
replaces them with other functions which checks in runtime if the functions
are called in the correct order.
here is the code: https://github.com/ThobiasKnudsen/urcu_lfht_safe


ons. 3. sep. 2025 kl. 03:35 skrev Olivier Dion <odion@efficios.com>:

> On Tue, 02 Sep 2025, Thobias Knudsen via lttng-dev <
> lttng-dev@lists.lttng.org> wrote:
> > Yes but all read/write operations doesn't have the syntax of a function
> as
> > you used in the example here i.e. use(...). When it is a function you can
> > easily just change the implementation to check if it is called inside a
> > read section. Some reads and writes are usually done by this syntax (a =
> b)
> > and '=' cannot be overridden.
> >
> > BTW just saying that what we're talking about now is not the original
> > topic, but if someone has an elegant solution to this that would be
> > nice!
>
> I am confuse about the overall discussion here.  Are we talking about
> static checking of RCU pointers usage or runtime checking?
>
> Is is possible to see the implementation you made so I can understand
> better?
>
> Thanks,
> Olivier
> --
> Olivier Dion
> EfficiOS Inc.
> https://www.efficios.com
>
>

--0000000000001c3987063dfd95c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt; I am confuse about the overall discussion here.=
=C2=A0 Are we talking about<br>&gt; static checking of RCU pointers usage o=
r runtime checking?<br>&gt;=C2=A0<br>&gt; Is is possible to see the impleme=
ntation you made so I can understand<br>&gt; better?</div><div><br></div>So=
rry for being late to answer=C2=A0:/<div>The library overrides a subset of =
urcu and lfht functions with macros and replaces them with other functions =
which checks in runtime if the=C2=A0functions are called in the correct ord=
er.</div><div>here is the code:=C2=A0<a href=3D"https://github.com/ThobiasK=
nudsen/urcu_lfht_safe">https://github.com/ThobiasKnudsen/urcu_lfht_safe</a>=
<br><div><br></div></div></div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">ons. 3. sep. 2025 kl. 03:35 =
skrev Olivier Dion &lt;<a href=3D"mailto:odion@efficios.com">odion@efficios=
.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Tue, 02 Sep 2025, Thobias Knudsen via lttng-dev &lt;<a href=3D"mailto:lttn=
g-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt; =
wrote:<br>
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

--0000000000001c3987063dfd95c9--
