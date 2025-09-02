Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5896ACA1005
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Sep 2025 14:32:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGSrR6cVTz17Ts
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1756823562;
	b=Tk5HB/PcTEBOpXTD0efYppLWrv6NkyTHPDfyHv+Bss9OS/2n7BJqy/hpN1HkMDqtTp4g
	 bF8FBoF9loO2mPLaohqUqhoRLwgNDiqnu7h68HEsH8pnPT8seSYWXg+YaQ3BccTsMnaLY
	 a2a2NgYTDF6q6Uv6Ce7nwDiQMkpbEX+0oPjP/LgagSw9BJHWKTQG9a2Icy8f6a1DN1BMM
	 L+qey528FL1vumVmUbklDaDdG/VeBwQTO9gPuTAb2Cv4p+uFBNgQkFN2n8CTABtQuA6yI
	 k/xGhBguiw9yECcnlv/r8rHB+6EwOtQaDrsebs9sdnpQu9cMx7BGHwIBwv0kMyrOH2A==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1756823562;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=VFkng/TchfNrH821lCdcSf4cypCiBTtvg1PGjSOvX0I=;
	b=KqpYaWygurjSqF1x7T+bHjetGub4NSregE0po4M/iXqu4pOHnUpuALo+/aVOz6bQgfr0
	 sbbpcOUDtYs2HUx81GX0RrEWMH6njdDzRg4frX7eijrfqwg21Bv05hISwTTx7r8PnUv5V
	 rLzxqKHWt0YWTiTzX40ZQFNPVps6eb5IN8SK/MVTWNDdnns0P8uZFrAAeZbCQ5QYPTHHA
	 NiuWLCPFYe5PuL11gNQchc8ZAxSVOTyRfJkpZV2F7NaqBYZZQeSeP0PUyIQythHObxp3E
	 FrZBW/+Y17ICNOpOMt3P2IlAU0C7sfxEe3Zke/pObMqZti3X53H1OO6ayxZbZeZP1ew==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGSrR6cVTz17Ts
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1756823562;
	bh=VFkng/TchfNrH821lCdcSf4cypCiBTtvg1PGjSOvX0I=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aRvq/4mg0PmO+n3lCrgihwNGcVOSIX0UXjZPpqfvF5C75EbdQ/9+pqf4RiR1rahJf
	 /313ZKC1AnmsIZ0lUtYofvipPkBfbILDEAIVHezcBavri+JM3CjcpR1GNxj4wl30no
	 v99Pvo/6HOGEdf1q8yRtyy8O8QJWHZlf4G+OMwVpXCtlhaMfmgr4abWFctDUZzEoPD
	 u3KV37dW0eQaVA6LsNAMfE0jZX2VLWpaA31HjNKQo4U7gwPbdmeHSQWr/ydxmjrTsr
	 j6NMnFO6yQ1QpH5RQeWrpAv0AmL6ES91mlnQs8qaRW3vTNUEBSYxS7RFVJOYIscraU
	 kAbzQnQi7KVYg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cGSrR6cVTz17Ts;
	Tue,  2 Sep 2025 10:32:39 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGSB010hzz16x6
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGSB010hzz16x6
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by lists.lttng.org (Postfix) with ESMTPS id 4cGSB010hzz16x6
 for <lttng-dev@lists.lttng.org>; Tue,  2 Sep 2025 10:02:47 -0400 (EDT)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-61e8fe26614so4404171a12.1
 for <lttng-dev@lists.lttng.org>; Tue, 02 Sep 2025 07:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756821762; x=1757426562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jph+c5TgRAhXM2HFVXHjP1YBM0x+pQHIYSQ6zhVfkIg=;
 b=WFO5XFZ5XUIa6MDfoiMSaKM6tdD9y/SWE+WTYe8S7p83QzvIsdXthMjXslT3EWf37i
 Y8Z0lJDphEOe1DwgN1H0GPOtw0iGlabv1mwHQu8VYwNnGTIQUpUR9uZv9EmrE/oVqUtD
 mLswMLKxTgpoQwJ76SObQw+nJjErrWkc/h6SirfgWbXKun3HklFj9LhNHWesp9+vhIK+
 pYgg6muEx1gUQHF3UIt72EweglVa5khzDBaidm88UJJcB7omQQdGuQhnrlnMSd74SKZz
 hMjuTBgcgQSBU624DnVrmWcAcxT1XoTld2dFrn6ZW+hgifm7Ho2OPM2oKFT/AnmC4ZYP
 ho7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7tNH7kECZLe28adtt/q/rODyumABIWOHIjj0umeprhTDpvcipdrcOWkNnEeq9+XjhM4q7cY7ZRJ0=@lists.lttng.org
X-Gm-Message-State: AOJu0YzYvkOx5DhNLqsQaAkxYUPtWZawx18arCZPQGEFWGxetGLENwQe
 QzzV0VFjpCRZ4oGaFPuRGnySVEoSV5Yq3bAuGAFbgv44XnaRzJGWXTRCTyqih7Cd6Sv3wHTzVq0
 YnTS7s52xosdR5aI2JQebejdySGj87nzQ+oFl
X-Gm-Gg: ASbGncsz3DxtBYdLMHkK8VYToozhp33JtsJTmuQ5JNYO2TafaHmC4vI6fpFg+SU0pqO
 cx/i+Gpjo+pwtFUPg87Yr7CVrmDonc/7/u9wJf0nxwRjHabB12d1AbexOtasb6gBU3B1Wr/uzXR
 2+wnN2r98namxtD/qbmCZFXR+Wi2a3+JH7EkA0xFCNa0mwlz/iueKPn/sBsAR1SW+HzpSY8KoYF
 tLvV4Avfrx1D5lkdSk=
X-Google-Smtp-Source: AGHT+IFKMhzecr0nqUTaixsn2f/8dWIMo/YlowjG7tsPDiUk4rATQ9Q4sB4MTynEzJJyFFiq0aEwMmexpMcZbGVHa/g=
X-Received: by 2002:a05:6402:3228:b0:61c:c086:e2a0 with SMTP id
 4fb4d7f45d1cf-61d26c3fbedmr13870826a12.24.1756821759834; Tue, 02 Sep 2025
 07:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAKGpciq6Cb6+hqsfn+_zPk+MqCg+b0M_Gc3jVxVvnEGcE8rdLw@mail.gmail.com>
 <db17b2cb-6ec1-49a2-b6a8-444878b63319@efficios.com>
In-Reply-To: <db17b2cb-6ec1-49a2-b6a8-444878b63319@efficios.com>
Date: Tue, 2 Sep 2025 16:02:28 +0200
X-Gm-Features: Ac12FXzJFx-nK2dEBIPYGuR-I03xMIGIQHAOEkEJqAc1SEdBPhL2OTUkojNT4TY
Message-ID: <CAKGpcioKYz3mz1yL-uK9GgFutbBvHL_V6YX9dF9LsmAbcfPV-A@mail.gmail.com>
Subject: Re: URCU feature request?
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: multipart/alternative; boundary="000000000000edbd85063dd1f0ee"
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

--000000000000edbd85063dd1f0ee
Content-Type: text/plain; charset="UTF-8"

> github repo is only a mirror. From the README.md you will notice a
> link to:
>
> Bug tracker: [Userspace RCU bug tracker](
https://bugs.lttng.org/projects/urcu)
>
> which has a "Feature" category.

Yes I actually visited that page. I just forgot to mention it. But I
couldn't create a feature request. I guess I have to create an account
then? I tried to create an account now and I have to wait for it to be
verified. Why isn't the issues just on github instead as people are more
familiar with that?

> The flag approach would allow your application to eventually complete,
> which may not be the case if you endlessly wait for all callbacks to
> be completed without preventing further callbacks to be enqueued.

In my case I have made a wrapper over cds_lfht which allows for recursive
lfht inside each other. for all lfht nodes there is a callback function
which in turn calls call_rcu on all the children lfht nodes. That means the
number of rcu_barriers needed to be called at program exit is the same as
the depth of lfht nodes. In this case there will never be an infinite
callback chain so if I understood correctly then I don't think using a flag
is relevant. I could iterate over every node to check the max depth but
that seems dirty. Isn't there an internal variable to check for how many
callbacks are left or if there are any at all? Or maybe it's unsafe to
access it?

man. 1. sep. 2025 kl. 17:04 skrev Mathieu Desnoyers <
mathieu.desnoyers@efficios.com>:

> On 2025-08-31 16:42, Thobias Knudsen wrote:
> > First question: why isn't Userspace RCU more popular?
>
> One guess is that for many use-cases, locking is sufficient.
>
> RCU and lock-free data structures are relevant in performance, latency,
> and scalability sensitive use-cases.
>
> And of course we could probably do a better job at advertising its
> existence.
>
> > Second question: Why isn't it possible to create issues in the urcu
> > repo?
>
> github repo is only a mirror. From the README.md you will notice a
> link to:
>
> Bug tracker: [Userspace RCU bug tracker](
> https://bugs.lttng.org/projects/urcu)
>
> which has a "Feature" category.
>
> > Im asking for a feature here:
> > Is it possible to make a function which checks if there are more
> > callbacks queued by call_rcu? I need that because there are some
> > callbacks which call call_rcu, and then calling rcu_barrier once
> > isn't enough and I therefore need a way to check if there are still
> > callbacks to wait on before terminating the program. No worries if this
> > is too much to ask for or if it isn't possible. This functionality is
> > only needed in termination because otherwise isn't needed to call
> > rcu_barrier multiple times (at least so far)
>
> Here is a relevant comment at the top of urcu_call_rcu_exit:
>
>   * Here is how an application can ensure graceful teardown of this
>   * worker thread:
>   *
>   * - An application queuing call_rcu callbacks should invoke
>   *   rcu_barrier() before it exits.
>   * - When chaining call_rcu callbacks, the number of calls to
>   *   rcu_barrier() on application exit must match at least the maximum
>   *   number of chained callbacks.
>   * - If an application chains callbacks endlessly, it would have to be
>   *   modified to stop chaining callbacks when it detects an application
>   *   exit (e.g. with a flag), and wait for quiescence with rcu_barrier()
>   *   after setting that flag.
>   * - The statements above apply to a library which queues call_rcu
>   *   callbacks, only it needs to invoke rcu_barrier in its library
>   *   destructor.
>
> The flag approach would allow your application to eventually complete,
> which may not be the case if you endlessly wait for all callbacks to
> be completed without preventing further callbacks to be enqueued.
>
> Ideally please include the lttng-dev mailing list on those discussions
> in the future, so everyone can benefit from them.
>
> Thanks,
>
> Mathieu
>
> >
> > Best regards
> > Thobias
> >
> >
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>

--000000000000edbd85063dd1f0ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt; github repo is only a mirror. From the README.md=
 you will notice a<br>&gt; link to:<br>&gt;=C2=A0<br>&gt; Bug tracker: [Use=
rspace RCU bug tracker](<a href=3D"https://bugs.lttng.org/projects/urcu" re=
l=3D"noreferrer" target=3D"_blank">https://bugs.lttng.org/projects/urcu</a>=
)</div><div>&gt;=C2=A0</div><div>&gt; which has a &quot;Feature&quot; categ=
ory.</div><div><br></div><div>Yes I actually visited that page. I just forg=
ot to mention it. But I couldn&#39;t create a feature request. I guess I ha=
ve to create an account then? I tried to create an account now and I have t=
o wait for it to be verified. Why isn&#39;t the issues just on github inste=
ad as people are more familiar with that?</div><div><br></div>&gt; The flag=
 approach would allow your application to eventually complete,<br>&gt; whic=
h may not be the case if you endlessly wait for all callbacks to<br>&gt; be=
 completed without preventing further callbacks to be enqueued.<div><br></d=
iv><div>In my case I have made a wrapper over cds_lfht which allows=C2=A0fo=
r recursive lfht inside each other. for all lfht=C2=A0nodes there is a call=
back function which in turn calls call_rcu on all the children lfht nodes. =
That means the number of rcu_barriers needed to be called at program exit i=
s the same as the depth of lfht=C2=A0nodes. In this case there will never b=
e an infinite callback chain so if I understood correctly then I don&#39;t =
think using a flag is relevant. I could iterate over every node to check th=
e max depth but that seems dirty. Isn&#39;t there an internal variable to c=
heck for how many callbacks are left or if there are any at all? Or maybe i=
t&#39;s unsafe to access it?=C2=A0</div></div><br><div class=3D"gmail_quote=
 gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">man. 1. sep. =
2025 kl. 17:04 skrev Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">On 2025-08-31 16:42, Thobias Knud=
sen wrote:<br>
&gt; First question: why isn&#39;t Userspace RCU more popular?<br>
<br>
One guess is that for many use-cases, locking is sufficient.<br>
<br>
RCU and lock-free data structures are relevant in performance, latency,<br>
and scalability sensitive use-cases.<br>
<br>
And of course we could probably do a better job at advertising its<br>
existence.<br>
<br>
&gt; Second question: Why isn&#39;t it possible to create issues in the urc=
u <br>
&gt; repo?<br>
<br>
github repo is only a mirror. From the README.md you will notice a<br>
link to:<br>
<br>
Bug tracker: [Userspace RCU bug tracker](<a href=3D"https://bugs.lttng.org/=
projects/urcu" rel=3D"noreferrer" target=3D"_blank">https://bugs.lttng.org/=
projects/urcu</a>)<br>
<br>
which has a &quot;Feature&quot; category.<br>
<br>
&gt; Im asking for a feature here:<br>
&gt; Is it possible to make a function which checks if there are more <br>
&gt; callbacks queued by call_rcu? I need that because there are some <br>
&gt; callbacks which call call_rcu, and then calling rcu_barrier once <br>
&gt; isn&#39;t=C2=A0enough and I therefore need a way to check if there are=
 still <br>
&gt; callbacks to wait on before terminating the program. No worries if thi=
s <br>
&gt; is too much to ask for or if it isn&#39;t=C2=A0possible. This function=
ality is <br>
&gt; only needed in termination because otherwise isn&#39;t=C2=A0needed to =
call <br>
&gt; rcu_barrier multiple times (at least so far)<br>
<br>
Here is a relevant comment at the top of urcu_call_rcu_exit:<br>
<br>
=C2=A0 * Here is how an application can ensure graceful teardown of this<br=
>
=C2=A0 * worker thread:<br>
=C2=A0 *<br>
=C2=A0 * - An application queuing call_rcu callbacks should invoke<br>
=C2=A0 *=C2=A0 =C2=A0rcu_barrier() before it exits.<br>
=C2=A0 * - When chaining call_rcu callbacks, the number of calls to<br>
=C2=A0 *=C2=A0 =C2=A0rcu_barrier() on application exit must match at least =
the maximum<br>
=C2=A0 *=C2=A0 =C2=A0number of chained callbacks.<br>
=C2=A0 * - If an application chains callbacks endlessly, it would have to b=
e<br>
=C2=A0 *=C2=A0 =C2=A0modified to stop chaining callbacks when it detects an=
 application<br>
=C2=A0 *=C2=A0 =C2=A0exit (e.g. with a flag), and wait for quiescence with =
rcu_barrier()<br>
=C2=A0 *=C2=A0 =C2=A0after setting that flag.<br>
=C2=A0 * - The statements above apply to a library which queues call_rcu<br=
>
=C2=A0 *=C2=A0 =C2=A0callbacks, only it needs to invoke rcu_barrier in its =
library<br>
=C2=A0 *=C2=A0 =C2=A0destructor.<br>
<br>
The flag approach would allow your application to eventually complete,<br>
which may not be the case if you endlessly wait for all callbacks to<br>
be completed without preventing further callbacks to be enqueued.<br>
<br>
Ideally please include the lttng-dev mailing list on those discussions<br>
in the future, so everyone can benefit from them.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; Best regards<br>
&gt; Thobias<br>
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

--000000000000edbd85063dd1f0ee--
