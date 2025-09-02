Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F206CA1005
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Sep 2025 14:32:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGSrj0yCDz17L7
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1756823573;
	b=QQG8it07lStedA/biUquvCRaT2FUkTZyygQ//v3sFd+EBgaLypwEUC8wld60KyQjM2Uy
	 Rtf2IE9ufq7NMAmrTi62j+oZ+YTM6VC8sUMD2acn4mstrSzfO2bepHCQLUsK4abBUje3l
	 sx4H1BilG6H0MyagFe5Z8y9IQiT5LhibZWdlfV5UtdqzTgmURge2msJxNVfEMRQ62q+mb
	 PMAGjrbSgrLavRNqg9lNJt0UgO7rmySuqgTcI0g0FG+3cbRhk/2gB/1EpHGjDmt4jlXbp
	 3iv43iGQ3d5Sylu821jsKL8wUlhpbQle05iSWcyn1bgFrFRVKJwIRYgw7FsVcs8xr7w==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1756823573;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=ACVLJDtrZTfvuqbghURDtPAAMBb43AYdpu6pKRCb3M8=;
	b=oUEwqPDcfpS1GfedpUZS9ECSqgNQDs1kioju+px8OY8SpXC9BO0UYY5nGRs+6dig832G
	 8j5EzdpdPQk9WTftRxhqDbVRBvUC6JDfW9D4nPhX3BNcgCODVhZ1Tm6vKVYKk2FywLrg4
	 wPdBeu0ehyIk9RdRyARGzNN06aIUPf30pRddRcoL/nIJWCjXGqeqH5y3BzxoLBF3mWdr7
	 MuY5V2ztL3A24g3/7RJ1vRf7WMZhnMk+AEPVI5AQ+sNzx0qtGxPCoiS0y1m47XapNRq25
	 c6RjgI9bcAyOuxo2djwmhhdy+fk6cHKBMJpd0LQ8qNosfSSuMrUifRsM3F1R9H5pTFw==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGSrj0yCDz17L7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1756823573;
	bh=ACVLJDtrZTfvuqbghURDtPAAMBb43AYdpu6pKRCb3M8=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gcEOzFkEqBydB7bFUD3jBxvvln3LbtEvtNJIBT4fn2FfGyw/RcgvlpCTuU1Be2wUl
	 0v8Gj13d1tlueZBEN4YFF+AL3pj3Ua2balRX3s1RdZD5KlCdnIkJ2zHwtSCxmDQ/jk
	 EyISqXmFTZ2hvyGDpxnyyI5RcvkKvzqsJ8XH79oL+UPcyJnNXfu6hZcnNSDsNIepGu
	 tp3noN1h1AnxaLzYClq4Acc7W6JFbAl56yXWKQawtvLNlWAS16pdpgerDUESiobHEZ
	 Be+rCAiCgInElWc13BtUZiZCsOYhAeo4H5n52d+LspqPWKnrlmPmoFpCT5cq+kFtV3
	 KzrIRaLQtZZLg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cGSrj0yCDz17L7;
	Tue,  2 Sep 2025 10:32:53 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGSg15PD1z17T5
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGSg15PD1z17T5
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by lists.lttng.org (Postfix) with ESMTPS id 4cGSg15PD1z17T5
 for <lttng-dev@lists.lttng.org>; Tue,  2 Sep 2025 10:24:29 -0400 (EDT)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-afcb78ead12so890272566b.1
 for <lttng-dev@lists.lttng.org>; Tue, 02 Sep 2025 07:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756823068; x=1757427868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z+/p0Gh1FudMOfCHkMQrtIrA7irK0Sgn0L4RsHJMJ1o=;
 b=LcrWSxi4RZ/W9LRdZuJ2EZZO4A2pb1g8kRcCiEuqPolpx/Cqy0uBuIOnkvTB4p9n+Q
 MWPB7tw+uBDJUzdoOLeARUylRCcezqVjTDNAkMBOMMicWaQnirD1JQB2NkwQ1urYGEh3
 g1OepoQU/YXdO8Oku2bf+QBALTBR6Ra4wE/CV3aECfa2yUhSU3jc450e8GVoEgSMSan6
 BzhYMHgrkeUml2WNhk/tkSTHVCj0P9yTIhYaOnMbvhca8IyQiUjwTygDJNYRJ7D2RzjE
 rbbhW+XyKrQ06suUPRd2sAXmgIb3DWCi8HUZw9CnZltcwJQr1VR5pKNgd8fI6wecl6a+
 1qkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB0SUrq4A8AY+g6oYVDj5p2OnonKDnOs8+Pr2PPVdV8QzNZOkYx5fyUEZCk5zFShgL2EcKg1bKHSo=@lists.lttng.org
X-Gm-Message-State: AOJu0Yzd7VEdNi41MIDARTWCAxHgLWtlnHX7qZ60v4Mgz2kHRw1FdkNI
 UvaIrrfaVWoX0ZUrMNBv700zGUtiIXOsnyoovK65ZFVd6Zp1Nf4CHLC8moNgUOP187hctOqhWJy
 tScp14j/OY0Vclf1feLPj63zoeaaxp4E=
X-Gm-Gg: ASbGncu4KDw3HQvJ+9wwVCetpU0U/PPYvI8pHcTqepp5T7IAe/etAa25vCYkHNGi/9x
 9xQAU0BVPMHfPOnk4SK//S8QGlCQ2h3bRbMBGO91t5fjfSvqqq9uLXLZlGxK1pTLhdp8VbxgaXP
 Ggn1VrtVJ8xR7JWV4YxKiG2BPbSPsoWqW4zo1kEAhYNO+sTq9qMHUzkPoUF7kPWroo7iFQV0jjn
 pyopi9MDJlmP5pU4xQ=
X-Google-Smtp-Source: AGHT+IG6bbyyonJaxMV1V0fP2u1cRrsCzj6Po7dGO70wMkFuZcVFbc6zP0m/Af7dqcN/Kqx+8y7+U504Zf4KaLI8d/s=
X-Received: by 2002:a17:907:7b94:b0:afe:7b8c:a583 with SMTP id
 a640c23a62f3a-b01d8a2fc2emr1109859066b.13.1756823067985; Tue, 02 Sep 2025
 07:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAKGpciq6Cb6+hqsfn+_zPk+MqCg+b0M_Gc3jVxVvnEGcE8rdLw@mail.gmail.com>
 <CAKGpciqHpGqGJChLa8p4P4Xv7EyUPMxULHxeknOTyie8kHH6hg@mail.gmail.com>
 <3c49eadb-f310-46b2-984d-58a0c193cde9@efficios.com>
 <CAKGpcipt=fWJi9Y497C3vq03CXmPY6rXQqs8ZP9nDoTGdRKnAA@mail.gmail.com>
In-Reply-To: <CAKGpcipt=fWJi9Y497C3vq03CXmPY6rXQqs8ZP9nDoTGdRKnAA@mail.gmail.com>
Date: Tue, 2 Sep 2025 16:24:16 +0200
X-Gm-Features: Ac12FXzJv3_E2GGb3GxoTH12yRnjRkEn3dRO0BzNiRy9UAbSz29537f9PkRP284
Message-ID: <CAKGpcipfyp3Ds4J0OH96Mu4zVhCLJg8g6tqEnfcRscZ1T8EmVA@mail.gmail.com>
Subject: Re: URCU feature request?
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: multipart/alternative; boundary="000000000000e68e4f063dd23eda"
X-Mailman-Approved-At: Tue, 02 Sep 2025 10:32:38 -0400
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
Cc: Olivier Dion <odion@efficios.com>, lttng-dev@lists.lttng.org,
 paulmck <paulmck@kernel.org>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000e68e4f063dd23eda
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Figured out what rcu_read_ongoing does. It just returns true if it's called
within a read section and false otherwise. The problem for catching whether
reads are done outside read sections is that you can not make macros for
read and write operations. e.g. ptr->a =3D 4;.

tir. 2. sep. 2025 kl. 16:17 skrev Thobias Knudsen <thobknu@gmail.com>:

> > I suspect that what you are trying to achieve is validation that
> > calls to functions that require to be within a RCU read-side critical
> > section such as cds_lfht_lookup are indeed invoked from within a
> > critical section.
>
> Yes exactly, but not only for read sections. It could also be to validate
> that rcu_barrier isnt called within a callback function or that
> rcu_quiescent_state isnt called when thread is offline
>
> > We've added a "rcu_read_ongoing()" API for that purpose to liburcu
> > RCU flavors, but AFAIK it's not used for any kind of validation
> > within cds_lfht. This could indeed become a feature request that
> > would apply to all liburcu data structure APIs.
>
> I can't find any documentation on rcu_read_ongoing. Btw the documentation
> for urcu in general is scattered all around the repo it seems. It should
> have been all at one place imo. Should I make a feature request for it? I
> don't know how stuff works inside this repo though.
>
>
>
> man. 1. sep. 2025 kl. 17:09 skrev Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com>:
>
>> On 2025-08-31 16:48, Thobias Knudsen wrote:
>> > BTW i've made a macro library which overrides the
>> > urcu and lfht functions. It checks that you call the functions in the
>> > correct order. This has been really useful for debugging and I think i=
t
>> > would be useful to have it integrated into urcu to make the it more
>> user
>> > friendly. you could have it integrated with the macro DEBUG_RCU or mak=
e
>> > a new one, maybe DEBUG_FUNCTION_CALL_ORDER. The only thing it doesn't
>> > catch is if you continue to use data from cds_lfht_lookup() after
>> > rcu_read_unlock()
>>
>> I suspect that what you are trying to achieve is validation that
>> calls to functions that require to be within a RCU read-side critical
>> section such as cds_lfht_lookup are indeed invoked from within a
>> critical section.
>>
>> We've added a "rcu_read_ongoing()" API for that purpose to liburcu
>> RCU flavors, but AFAIK it's not used for any kind of validation
>> within cds_lfht. This could indeed become a feature request that
>> would apply to all liburcu data structure APIs.
>>
>> Thanks,
>>
>> Mathieu
>>
>> >
>> > s=C3=B8n. 31. aug. 2025 kl. 22:42 skrev Thobias Knudsen <thobknu@gmail=
.com
>> > <mailto:thobknu@gmail.com>>:
>> >
>> >     First question: why isn't Userspace RCU more popular?
>> >     Second question: Why isn't it possible to create issues in the urc=
u
>> >     repo? Im asking for a feature here:
>> >     Is it possible to make a function which checks if there are more
>> >     callbacks queued by call_rcu? I need that because there are some
>> >     callbacks which call call_rcu, and then calling rcu_barrier once
>> >     isn't enough and I therefore need a way to check if there are stil=
l
>> >     callbacks to wait on before terminating the program. No worries if
>> >     this is too much to ask for or if it isn't possible. This
>> >     functionality is only needed in termination because otherwise
>> >     isn't needed to call rcu_barrier multiple times (at least so far)
>> >
>> >     Best regards
>> >     Thobias
>> >
>> >
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>
>

--000000000000e68e4f063dd23eda
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Figured out what rcu_read_ongoing does. It just returns tr=
ue if it&#39;s called within=C2=A0a read section and false otherwise. The p=
roblem for catching whether reads are done outside read sections is that yo=
u can not make macros for read and write operations. e.g. ptr-&gt;a =3D 4;.=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">tir. 2. sep. 2025 kl. 16:17 skrev Thobias Knudsen &lt=
;<a href=3D"mailto:thobknu@gmail.com">thobknu@gmail.com</a>&gt;:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">&gt; I su=
spect that what you are trying to achieve is validation that<br>&gt; calls =
to functions that require to be within a RCU read-side critical<br>&gt; sec=
tion such as cds_lfht_lookup are indeed invoked from within a<br>&gt; criti=
cal section.<div><br></div><div>Yes exactly, but not only for read sections=
. It could also be to validate that rcu_barrier isnt=C2=A0called within a c=
allback function or that rcu_quiescent_state isnt called when thread is off=
line</div><div><br>&gt; We&#39;ve added a &quot;rcu_read_ongoing()&quot; AP=
I for that purpose to liburcu<br>&gt; RCU flavors, but AFAIK it&#39;s not u=
sed for any kind of validation<br>&gt; within cds_lfht. This could indeed b=
ecome a feature request that<br>&gt; would apply to all liburcu data struct=
ure APIs.<div><br></div><div>I can&#39;t find any documentation on rcu_read=
_ongoing. Btw the documentation for urcu in general is scattered all around=
 the repo it seems. It should have been all at one place imo. Should I make=
 a feature request for it? I don&#39;t know how stuff works inside this rep=
o though.</div><div><br></div><div><br></div></div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">man. 1. sep. 2025 kl. 17=
:09 skrev Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficio=
s.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On 2025-08-31 16:48, Thobi=
as Knudsen wrote:<br>
&gt; BTW i&#39;ve made a macro library which overrides the <br>
&gt; urcu=C2=A0and=C2=A0lfht=C2=A0functions. It checks that you call the fu=
nctions in the <br>
&gt; correct order. This has been really useful for debugging and I think i=
t <br>
&gt; would be useful to have it integrated into urcu to make the it more us=
er <br>
&gt; friendly. you could have it integrated=C2=A0with the macro DEBUG_RCU o=
r make <br>
&gt; a new one, maybe DEBUG_FUNCTION_CALL_ORDER. The only thing it doesn&#3=
9;t <br>
&gt; catch is if you continue to use data from cds_lfht_lookup() after <br>
&gt; rcu_read_unlock()<br>
<br>
I suspect that what you are trying to achieve is validation that<br>
calls to functions that require to be within a RCU read-side critical<br>
section such as cds_lfht_lookup are indeed invoked from within a<br>
critical section.<br>
<br>
We&#39;ve added a &quot;rcu_read_ongoing()&quot; API for that purpose to li=
burcu<br>
RCU flavors, but AFAIK it&#39;s not used for any kind of validation<br>
within cds_lfht. This could indeed become a feature request that<br>
would apply to all liburcu data structure APIs.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; s=C3=B8n. 31. aug. 2025 kl. 22:42 skrev Thobias Knudsen &lt;<a href=3D=
"mailto:thobknu@gmail.com" target=3D"_blank">thobknu@gmail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:thobknu@gmail.com" target=3D"_blank">thob=
knu@gmail.com</a>&gt;&gt;:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0First question: why isn&#39;t Userspace RCU more po=
pular?<br>
&gt;=C2=A0 =C2=A0 =C2=A0Second question: Why isn&#39;t it possible to creat=
e issues in the urcu<br>
&gt;=C2=A0 =C2=A0 =C2=A0repo? Im asking for a feature here:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Is it possible to make a function which checks if t=
here are more<br>
&gt;=C2=A0 =C2=A0 =C2=A0callbacks queued by call_rcu? I need that because t=
here are some<br>
&gt;=C2=A0 =C2=A0 =C2=A0callbacks which call call_rcu, and then calling rcu=
_barrier once<br>
&gt;=C2=A0 =C2=A0 =C2=A0isn&#39;t=C2=A0enough and I therefore need a way to=
 check if there are still<br>
&gt;=C2=A0 =C2=A0 =C2=A0callbacks to wait on before terminating the program=
. No worries if<br>
&gt;=C2=A0 =C2=A0 =C2=A0this is too much to ask for or if it isn&#39;t=C2=
=A0possible. This<br>
&gt;=C2=A0 =C2=A0 =C2=A0functionality is only needed in termination because=
 otherwise<br>
&gt;=C2=A0 =C2=A0 =C2=A0isn&#39;t=C2=A0needed to call rcu_barrier multiple =
times (at least so far)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Best regards<br>
&gt;=C2=A0 =C2=A0 =C2=A0Thobias<br>
&gt; <br>
&gt; <br>
<br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"https://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.efficios.com</a><br>
</blockquote></div>
</blockquote></div>

--000000000000e68e4f063dd23eda--
