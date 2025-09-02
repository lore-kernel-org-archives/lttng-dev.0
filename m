Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E3ACA1007
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Sep 2025 21:06:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGdZl3lhtz1BkG
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1756847183;
	b=B2EMlubsJ3J/QF1oJPF8tJe0oaN207En3Io8KPx/ELR+klgtlghGcnNHiEs4Uyo6zJz3
	 POEqn4M2sUGP9RmIjyFsoAiVgpv6PJiDEamMNq8FDG2tdfcXkepD2nki8tdePw4gImiua
	 m6phsWAgaIVWsHm5IZC1mzAuHYdXwutxFzL01ivp1OpOVpPg474QxMfGXP3TKy2f6qFDq
	 ZVB8iliO3N3X1Yw7yMCbwmNDClYXgFznW3LqRJEDYFAPKhbtff5DmKGEEslrkE3dvJ2NW
	 4cHDTPP+Z7CwicQ0B351G2F9y7Sk+g1Ifo1KeFL7RUvfnV+XT/Et8k1gN9QKuBZxAsQ==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1756847183;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=+tGgOW4+KFKCA6ZXuRxJLrAUzdf+f7YGDWV8dl4crRQ=;
	b=ajScdF/tU16g/XfcJizj4zEPf9HvO21MB6uHYdDSFF2MKdEvVmX08Kkkevu6mvBgPtTz
	 +sb/SBWdBYgVgu0lJB6DSuxLpwNHqPumG41xRQQTBycxGqd7r1RovZWPNkgXqq2HTsYPS
	 BbLnxoOAri4pSun1MFhi7XfBLAbsOJyDM7ABu4vvMi44397rfjQo0qqBDytnrNL70+8MP
	 6iUArpnL8Fhilfb8Z7v/ePkQHA5PZRvuiragZ6IUOMEgP7h5e3Sz1JbD/nDJmnHx/TbbL
	 OzzOAcP4yja9Qo8qLC31LQLmmLo+XJ2AYWHQKAvvA8bvNjNexOAC7aINq+prXd5KI3g==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGdZl3lhtz1BkG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1756847183;
	bh=+tGgOW4+KFKCA6ZXuRxJLrAUzdf+f7YGDWV8dl4crRQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cKVA6r034sb3R2BU3EuUi2nZLPfBfNqQ92BJNVHVr4vygUagvl5PnQPFwIMuoPtuu
	 emwND6x3XsC4rR+g/75rgBtg0VMYnuQogxYDn5EYG07trJzqtYQj1MkM1fhJs1qtZS
	 JGSvNh8HYrirHTmFL8SJk+Dv3NMCVqMrDsSgutYpvctsprXRx2iDU9+GPpMLtc9qpZ
	 fpCSM5togxkcfQPM2QWFF9t8Rgj55yQL4UAqL8P6T68MAJhp3w+6vF9e9vYleziPWl
	 LsFPKT3IJ7BV1+uBaRTppj7Wupn5Hs2K1+yZnzNCSglVUX0y9Wa9o3iLXICRfOKywK
	 FvcqPyojxNPqw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cGdZl3lhtz1BkG;
	Tue,  2 Sep 2025 17:06:23 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGdZk5g6Wz1Bpg
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGdZk5g6Wz1Bpg
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by lists.lttng.org (Postfix) with ESMTPS id 4cGdZk5g6Wz1Bpg
 for <lttng-dev@lists.lttng.org>; Tue,  2 Sep 2025 17:06:22 -0400 (EDT)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b0454d63802so196201966b.2
 for <lttng-dev@lists.lttng.org>; Tue, 02 Sep 2025 14:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756847180; x=1757451980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MFfsz6AyR1Jz0PoazblILusngJfroffC3LCUfYCX5aE=;
 b=Rn93gdLKKZxuAA+OyQQRYCqAgtCuDrNJybewioJTnsb6fO7gkPhkmJgGN/VCrQomxz
 CXQ95Idt2NlsaiTtmOG+IFFPu7ziYO+j5eAkmlg4yGBcH4OXZ/wQ9NYaVvy+XJwIE92l
 dbamPzEEdwocuWgZxew16XyHJ0VOboRvdQ8x1fxoxSdLoQZzOwhPL6w7HXnW3BUnSzGn
 iahnDu0OTlqiY3wqR78IJyhJVuHzq+KfrXMUO4JW4fGSsZDkM7kz4aObP+P/qGfujqNX
 JdxC/dXYUwUfZRpbgxKqChEJjVFuNSOwbtHphdju8FNq6ZlQPHX80rTiqhc8zyQ8Jruc
 n5Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0gd6/JxUN+omMHGT6Kwo6LUvS/G3cCIWHGbSX+HyXFD6oSHHJL3UHbeBNm/9ijM79KpP14myd/9Q=@lists.lttng.org
X-Gm-Message-State: AOJu0YxHSm9n7TEIpQZlLxTDRPDVi9Vq+BlGeixUhZbYWqtYoBvTzYFi
 +w82aPcIq3PMEeiIHUjGhgpYPOLVhLHVryJxmx7qRQosFWXEtN5bay5uFzTc48zqNYiyEE6qVNo
 3cTk5iLEa4OEobu+StNJ19ad8URHCnnA=
X-Gm-Gg: ASbGncvNpvT+Ibxeog8nDFfXPIB/nNF5cVdsnCQ/KJI8OplFVyWjfeK29YmIE3qzqhG
 qOkOF5QqgfUjH+T+L+YjNSG+pJKLULih+Es0ek8h6/iCNKzQa0uHrgBIMtzn/CeVVux9lhGoQVP
 895IOccmiOjqL2Y8b02rQGMQBEE+G9fuXZIBzCewnXqctBf4KQ6rBU99CXRc8Gyt6iF33p3cZ8+
 Mw1kXtv
X-Google-Smtp-Source: AGHT+IHWLsxbiz2V2GY8rrs1vF5qXggIrW8cUbwq4Td90uGTXJSiH7Dbz6hTsmJvPVnU2S3QAgrCVsFFhPu6sT3aYOk=
X-Received: by 2002:a17:907:1b10:b0:afe:c099:aeb3 with SMTP id
 a640c23a62f3a-b01d8c90624mr1448737166b.25.1756847179920; Tue, 02 Sep 2025
 14:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAKGpciq6Cb6+hqsfn+_zPk+MqCg+b0M_Gc3jVxVvnEGcE8rdLw@mail.gmail.com>
 <CAKGpciqHpGqGJChLa8p4P4Xv7EyUPMxULHxeknOTyie8kHH6hg@mail.gmail.com>
 <3c49eadb-f310-46b2-984d-58a0c193cde9@efficios.com>
 <CAKGpcipt=fWJi9Y497C3vq03CXmPY6rXQqs8ZP9nDoTGdRKnAA@mail.gmail.com>
 <CAKGpcipfyp3Ds4J0OH96Mu4zVhCLJg8g6tqEnfcRscZ1T8EmVA@mail.gmail.com>
 <2f0dc1b4-3fcb-453c-aa42-4a1f85623300@paulmck-laptop>
In-Reply-To: <2f0dc1b4-3fcb-453c-aa42-4a1f85623300@paulmck-laptop>
Date: Tue, 2 Sep 2025 23:06:08 +0200
X-Gm-Features: Ac12FXzI7oZcZ1_wpMYB2vVjWOw6OhnGMC6PFSfzzPRtJEtM2enE2xNQ3_CzwGM
Message-ID: <CAKGpciq+ixOVGN7TXYaF336ZEL_mOejzic5BvaKbexwwn_aqOQ@mail.gmail.com>
Subject: Re: URCU feature request?
To: paulmck@kernel.org
Content-Type: multipart/alternative; boundary="0000000000001577db063dd7dc69"
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
Cc: Olivier Dion <odion@efficios.com>, lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--0000000000001577db063dd7dc69
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> We usually rely on the debugging code in rcu_dereference() to check this
> sort of thing.  Or are you worried about the user leaking RCU-protected
> pointers out past the rcu_read_unlock()?

Yes, that is what I'm worried about. For my case when using URCU that is my
biggest concern, as the debug macro "library" I made checks everything
else, if I haven't overlooked anything.

Thanks
Thobias

tir. 2. sep. 2025 kl. 22:33 skrev Paul E. McKenney <paulmck@kernel.org>:

> On Tue, Sep 02, 2025 at 04:24:16PM +0200, Thobias Knudsen wrote:
> > Figured out what rcu_read_ongoing does. It just returns true if it's
> called
> > within a read section and false otherwise. The problem for catching
> whether
> > reads are done outside read sections is that you can not make macros fo=
r
> > read and write operations. e.g. ptr->a =3D 4;.
>
> We usually rely on the debugging code in rcu_dereference() to check this
> sort of thing.  Or are you worried about the user leaking RCU-protected
> pointers out past the rcu_read_unlock()?
>
>                                                         Thanx, Paul
>
> > tir. 2. sep. 2025 kl. 16:17 skrev Thobias Knudsen <thobknu@gmail.com>:
> >
> > > > I suspect that what you are trying to achieve is validation that
> > > > calls to functions that require to be within a RCU read-side critic=
al
> > > > section such as cds_lfht_lookup are indeed invoked from within a
> > > > critical section.
> > >
> > > Yes exactly, but not only for read sections. It could also be to
> validate
> > > that rcu_barrier isnt called within a callback function or that
> > > rcu_quiescent_state isnt called when thread is offline
> > >
> > > > We've added a "rcu_read_ongoing()" API for that purpose to liburcu
> > > > RCU flavors, but AFAIK it's not used for any kind of validation
> > > > within cds_lfht. This could indeed become a feature request that
> > > > would apply to all liburcu data structure APIs.
> > >
> > > I can't find any documentation on rcu_read_ongoing. Btw the
> documentation
> > > for urcu in general is scattered all around the repo it seems. It
> should
> > > have been all at one place imo. Should I make a feature request for
> it? I
> > > don't know how stuff works inside this repo though.
> > >
> > >
> > >
> > > man. 1. sep. 2025 kl. 17:09 skrev Mathieu Desnoyers <
> > > mathieu.desnoyers@efficios.com>:
> > >
> > >> On 2025-08-31 16:48, Thobias Knudsen wrote:
> > >> > BTW i've made a macro library which overrides the
> > >> > urcu and lfht functions. It checks that you call the functions in
> the
> > >> > correct order. This has been really useful for debugging and I
> think it
> > >> > would be useful to have it integrated into urcu to make the it mor=
e
> > >> user
> > >> > friendly. you could have it integrated with the macro DEBUG_RCU or
> make
> > >> > a new one, maybe DEBUG_FUNCTION_CALL_ORDER. The only thing it
> doesn't
> > >> > catch is if you continue to use data from cds_lfht_lookup() after
> > >> > rcu_read_unlock()
> > >>
> > >> I suspect that what you are trying to achieve is validation that
> > >> calls to functions that require to be within a RCU read-side critica=
l
> > >> section such as cds_lfht_lookup are indeed invoked from within a
> > >> critical section.
> > >>
> > >> We've added a "rcu_read_ongoing()" API for that purpose to liburcu
> > >> RCU flavors, but AFAIK it's not used for any kind of validation
> > >> within cds_lfht. This could indeed become a feature request that
> > >> would apply to all liburcu data structure APIs.
> > >>
> > >> Thanks,
> > >>
> > >> Mathieu
> > >>
> > >> >
> > >> > s=C3=B8n. 31. aug. 2025 kl. 22:42 skrev Thobias Knudsen <
> thobknu@gmail.com
> > >> > <mailto:thobknu@gmail.com>>:
> > >> >
> > >> >     First question: why isn't Userspace RCU more popular?
> > >> >     Second question: Why isn't it possible to create issues in the
> urcu
> > >> >     repo? Im asking for a feature here:
> > >> >     Is it possible to make a function which checks if there are mo=
re
> > >> >     callbacks queued by call_rcu? I need that because there are so=
me
> > >> >     callbacks which call call_rcu, and then calling rcu_barrier on=
ce
> > >> >     isn't enough and I therefore need a way to check if there are
> still
> > >> >     callbacks to wait on before terminating the program. No worrie=
s
> if
> > >> >     this is too much to ask for or if it isn't possible. This
> > >> >     functionality is only needed in termination because otherwise
> > >> >     isn't needed to call rcu_barrier multiple times (at least so
> far)
> > >> >
> > >> >     Best regards
> > >> >     Thobias
> > >> >
> > >> >
> > >>
> > >>
> > >> --
> > >> Mathieu Desnoyers
> > >> EfficiOS Inc.
> > >> https://www.efficios.com
> > >>
> > >
>

--0000000000001577db063dd7dc69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; We usually rely on the debugging code in rcu_derefere=
nce() to check this<br>&gt; sort of thing.=C2=A0 Or are you worried about t=
he user leaking RCU-protected<br>&gt; pointers out past the rcu_read_unlock=
()?<div><br></div><div>Yes, that is what I&#39;m worried about. For my case=
 when using URCU that is my biggest concern, as the debug macro &quot;libra=
ry&quot; I made checks everything else, if I haven&#39;t overlooked anythin=
g.</div><div><br></div><div>Thanks</div><div>Thobias</div></div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">tir. 2. sep. 2025 kl. 22:33 skrev Paul E. McKenney &lt;<a href=3D"mail=
to:paulmck@kernel.org">paulmck@kernel.org</a>&gt;:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Tue, Sep 02, 2025 at 04:24:16PM +0200=
, Thobias Knudsen wrote:<br>
&gt; Figured out what rcu_read_ongoing does. It just returns true if it&#39=
;s called<br>
&gt; within a read section and false otherwise. The problem for catching wh=
ether<br>
&gt; reads are done outside read sections is that you can not make macros f=
or<br>
&gt; read and write operations. e.g. ptr-&gt;a =3D 4;.<br>
<br>
We usually rely on the debugging code in rcu_dereference() to check this<br=
>
sort of thing.=C2=A0 Or are you worried about the user leaking RCU-protecte=
d<br>
pointers out past the rcu_read_unlock()?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Thanx, Paul<br>
<br>
&gt; tir. 2. sep. 2025 kl. 16:17 skrev Thobias Knudsen &lt;<a href=3D"mailt=
o:thobknu@gmail.com" target=3D"_blank">thobknu@gmail.com</a>&gt;:<br>
&gt; <br>
&gt; &gt; &gt; I suspect that what you are trying to achieve is validation =
that<br>
&gt; &gt; &gt; calls to functions that require to be within a RCU read-side=
 critical<br>
&gt; &gt; &gt; section such as cds_lfht_lookup are indeed invoked from with=
in a<br>
&gt; &gt; &gt; critical section.<br>
&gt; &gt;<br>
&gt; &gt; Yes exactly, but not only for read sections. It could also be to =
validate<br>
&gt; &gt; that rcu_barrier isnt called within a callback function or that<b=
r>
&gt; &gt; rcu_quiescent_state isnt called when thread is offline<br>
&gt; &gt;<br>
&gt; &gt; &gt; We&#39;ve added a &quot;rcu_read_ongoing()&quot; API for tha=
t purpose to liburcu<br>
&gt; &gt; &gt; RCU flavors, but AFAIK it&#39;s not used for any kind of val=
idation<br>
&gt; &gt; &gt; within cds_lfht. This could indeed become a feature request =
that<br>
&gt; &gt; &gt; would apply to all liburcu data structure APIs.<br>
&gt; &gt;<br>
&gt; &gt; I can&#39;t find any documentation on rcu_read_ongoing. Btw the d=
ocumentation<br>
&gt; &gt; for urcu in general is scattered all around the repo it seems. It=
 should<br>
&gt; &gt; have been all at one place imo. Should I make a feature request f=
or it? I<br>
&gt; &gt; don&#39;t know how stuff works inside this repo though.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; man. 1. sep. 2025 kl. 17:09 skrev Mathieu Desnoyers &lt;<br>
&gt; &gt; <a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blan=
k">mathieu.desnoyers@efficios.com</a>&gt;:<br>
&gt; &gt;<br>
&gt; &gt;&gt; On 2025-08-31 16:48, Thobias Knudsen wrote:<br>
&gt; &gt;&gt; &gt; BTW i&#39;ve made a macro library which overrides the<br=
>
&gt; &gt;&gt; &gt; urcu and lfht functions. It checks that you call the fun=
ctions in the<br>
&gt; &gt;&gt; &gt; correct order. This has been really useful for debugging=
 and I think it<br>
&gt; &gt;&gt; &gt; would be useful to have it integrated into urcu to make =
the it more<br>
&gt; &gt;&gt; user<br>
&gt; &gt;&gt; &gt; friendly. you could have it integrated with the macro DE=
BUG_RCU or make<br>
&gt; &gt;&gt; &gt; a new one, maybe DEBUG_FUNCTION_CALL_ORDER. The only thi=
ng it doesn&#39;t<br>
&gt; &gt;&gt; &gt; catch is if you continue to use data from cds_lfht_looku=
p() after<br>
&gt; &gt;&gt; &gt; rcu_read_unlock()<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I suspect that what you are trying to achieve is validation t=
hat<br>
&gt; &gt;&gt; calls to functions that require to be within a RCU read-side =
critical<br>
&gt; &gt;&gt; section such as cds_lfht_lookup are indeed invoked from withi=
n a<br>
&gt; &gt;&gt; critical section.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; We&#39;ve added a &quot;rcu_read_ongoing()&quot; API for that=
 purpose to liburcu<br>
&gt; &gt;&gt; RCU flavors, but AFAIK it&#39;s not used for any kind of vali=
dation<br>
&gt; &gt;&gt; within cds_lfht. This could indeed become a feature request t=
hat<br>
&gt; &gt;&gt; would apply to all liburcu data structure APIs.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Mathieu<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; s=C3=B8n. 31. aug. 2025 kl. 22:42 skrev Thobias Knudsen =
&lt;<a href=3D"mailto:thobknu@gmail.com" target=3D"_blank">thobknu@gmail.co=
m</a><br>
&gt; &gt;&gt; &gt; &lt;mailto:<a href=3D"mailto:thobknu@gmail.com" target=
=3D"_blank">thobknu@gmail.com</a>&gt;&gt;:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0First question: why isn&#39;t Userspa=
ce RCU more popular?<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0Second question: Why isn&#39;t it pos=
sible to create issues in the urcu<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0repo? Im asking for a feature here:<b=
r>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0Is it possible to make a function whi=
ch checks if there are more<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0callbacks queued by call_rcu? I need =
that because there are some<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0callbacks which call call_rcu, and th=
en calling rcu_barrier once<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0isn&#39;t enough and I therefore need=
 a way to check if there are still<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0callbacks to wait on before terminati=
ng the program. No worries if<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0this is too much to ask for or if it =
isn&#39;t possible. This<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0functionality is only needed in termi=
nation because otherwise<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0isn&#39;t needed to call rcu_barrier =
multiple times (at least so far)<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0Best regards<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0Thobias<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt; Mathieu Desnoyers<br>
&gt; &gt;&gt; EfficiOS Inc.<br>
&gt; &gt;&gt; <a href=3D"https://www.efficios.com" rel=3D"noreferrer" targe=
t=3D"_blank">https://www.efficios.com</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
</blockquote></div>

--0000000000001577db063dd7dc69--
