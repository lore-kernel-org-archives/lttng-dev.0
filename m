Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3905CA100D
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Sep 2025 14:32:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGSrj0P7Tz17r0
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1756823573;
	b=eHNFbgNml9h5taM0ELfW0ag4i7hnl7m3fix+gmJ4x5xF8s4BjG+oS+BnUgl5DNbtsrwe
	 zHjZtgHrMSBwdWtM/gRXSdwn7SBw6/jVZJvi3rWf6KkynJMInqduagf+pi4vLVvAV+ycf
	 KT8bm++qgMvILOiBBvfpbV+pOx1MbBJIpYsjLJz6V/XuBVd+1fUt4QWpeQxQQpkQeOosD
	 14uK0SSDkw5HUomVi1lba0al/fevEdu5iUWiZFtpx7AwtdGt5ux10eFNc0vnGe3WPKgzc
	 ujRn1ah+Uovh0P0L26lI/Hqfwg3fbRIfPVQDh0F4AUUVsxyTr3plkcUa5TERGenhpvA==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1756823573;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=D46T1oUPM4w2rkjI8Uj7lf1le/jUnQbhqPzkp/EXL8I=;
	b=Rvw57vMGpUHK7ivTjUGYhP/o4DQ8XpxzBmzPG/pqXZ/aBEdaRhZPWZjwY7TTRMiOHEdx
	 0L9GK9G7LBarGpkgO39WlAhWFviT/+59YnJvYjGaBNoXm2uoFlfCvWl1f8VZtgg5Go9l5
	 rxRn7iJrXktUFNVspZdfRmV2Br9qjiIeypx6p5MKsySxn5OxVNTIFW4QwjwcNPodW/4H7
	 mIYQM+LO3cHmyfqkeRMo4wCRwplbsv+vk+RrlOdWFoQfkHT8J+ecir2NBHwY4+WyZ8jTg
	 c9T2fOMptThCXvCbhm/LxrtXkMmMBbF0C6UX3wet18Cluokp3kzxnTVdKBJ5m80sBUA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGSrj0P7Tz17r0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1756823573;
	bh=D46T1oUPM4w2rkjI8Uj7lf1le/jUnQbhqPzkp/EXL8I=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=M8m4yT+w1zUQRgeFk03vOTN7OYh8PVPCjfnpoAVzg7DXiMnuW32fx4oLXNoIbLrxa
	 cf/ambV+ozFlUrOsqGjBv2+J81yN2LnQ5ovzbQ5C9fOW/ojlQ4VOtxhFYPwWDL4UKh
	 WtNq885YzKbC/Jw68iHV2r+NwyWLiDIJgqo8BLfqtXK+D6wQF57XjdPXxWSsvo0CGm
	 jv/q8wQAXLJ/cq3pJSspzYmxGTSdnPxWcskumKYkNl/i587MrdjRThFs0g8wI/qh6w
	 VfBVzkXecadYlM2+LX5E/NAnbICCEegxciyBBeoqsmCmvOyEWn8xljm7jQnNse3DZi
	 qPaudmUenVBLA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cGSrj0P7Tz17r0;
	Tue,  2 Sep 2025 10:32:53 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGSW12HDXz17Sj
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGSW12HDXz17Sj
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by lists.lttng.org (Postfix) with ESMTPS id 4cGSW12HDXz17Sj
 for <lttng-dev@lists.lttng.org>; Tue,  2 Sep 2025 10:17:32 -0400 (EDT)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-61cf0901a72so8019116a12.1
 for <lttng-dev@lists.lttng.org>; Tue, 02 Sep 2025 07:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756822652; x=1757427452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iqk4a8Lsh8kixJ7LldxH+VGsLG+RvRy/15d/FhsMCnU=;
 b=vzGYLv8o8knf0aUEgDcJZD33PXvVk+IwLD3aoGuBUC8JBcRsId1vKqrjD4TY6CMVgq
 dNHL8uYQqAOyBW8HHp7IQEWUSO2pymqRTsgKePoTmwTpmHdAxHEmTo/eQa6emf+AkDx9
 q7ZxL8TyJ6HDVgGcU7RCJA5Ka2pij+dqQun2RXWYqYft6VrYy9dXOdCvRkwT9VnSOPol
 SGvMmB5ZoW3LSmwy2hU7f6ww1BHra0YV2ms31kKcJt0mKwbjV9fmvEEgEFRBJ81ZqgCh
 BPkJCeAMDzAzPBzRH+2Zh+dOefUXuf9JDZ1aQlPxbCaRagz7awWzpj3RjfDDDBUkZLvZ
 ycmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1R7ghnCyKosLJOfvG7Co4apE8Snu2h9glQVpp1nTCyDRDeJ1YJsXxCFsBXwM3jQT7n4OPdvpWsfY=@lists.lttng.org
X-Gm-Message-State: AOJu0Yw6miqKHkxcm+Dp6dOmwXx+KsA/GV4ZSf9iTGCNxJ1gLjOZiwPL
 ZN3fwcZYJw+ouZRqM/6ZVQvkWrZ0EUWlrF20n2glq487odlP7ZmVmX+THgmsVnzlkujcmxNuiKf
 Rmo6DIaRdizFLMuybY8UzBAjETxQOQA8d2FTP+qo=
X-Gm-Gg: ASbGncsKhugeGYRrOOYLqcmgR9jT6GouIv43ahCeUTUSWIqwqOfy4wYZtwAD+Ik9WmG
 IlWgP1FpiOkgpEHQ7T3jdEw24tD751Wd3QePm7PfwNCwEjOokPED8QzFIqnI4tVVcyO0kjLDTqM
 Q6ZtGcP//qK+BY77mV7wnJcRidj4zsM5cQBhFRI1LtdCwCpo4BmVWRiMjIM0a94Ua1xKpp48ADD
 745COMKN3/m81k6iOU=
X-Google-Smtp-Source: AGHT+IEpIlga3E0cQvy2O6wk9T+M6DePzG8GOdmCEpWJSJ37chI4p+UzPIOqg1/I7+utveVs4AWnRcYLdRKgSHB5hMA=
X-Received: by 2002:a05:6402:270e:b0:61c:29e:db04 with SMTP id
 4fb4d7f45d1cf-61d2686a7fcmr11773234a12.6.1756822651520; Tue, 02 Sep 2025
 07:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAKGpciq6Cb6+hqsfn+_zPk+MqCg+b0M_Gc3jVxVvnEGcE8rdLw@mail.gmail.com>
 <CAKGpciqHpGqGJChLa8p4P4Xv7EyUPMxULHxeknOTyie8kHH6hg@mail.gmail.com>
 <3c49eadb-f310-46b2-984d-58a0c193cde9@efficios.com>
In-Reply-To: <3c49eadb-f310-46b2-984d-58a0c193cde9@efficios.com>
Date: Tue, 2 Sep 2025 16:17:19 +0200
X-Gm-Features: Ac12FXy0Zkw6AaYScFe6RH20uXAbQVAtFZuNwycLg13MFnHgzTfxf2Q7iULvnIg
Message-ID: <CAKGpcipt=fWJi9Y497C3vq03CXmPY6rXQqs8ZP9nDoTGdRKnAA@mail.gmail.com>
Subject: Re: URCU feature request?
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: multipart/alternative; boundary="00000000000013c93f063dd226a3"
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

--00000000000013c93f063dd226a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I suspect that what you are trying to achieve is validation that
> calls to functions that require to be within a RCU read-side critical
> section such as cds_lfht_lookup are indeed invoked from within a
> critical section.

Yes exactly, but not only for read sections. It could also be to validate
that rcu_barrier isnt called within a callback function or that
rcu_quiescent_state isnt called when thread is offline

> We've added a "rcu_read_ongoing()" API for that purpose to liburcu
> RCU flavors, but AFAIK it's not used for any kind of validation
> within cds_lfht. This could indeed become a feature request that
> would apply to all liburcu data structure APIs.

I can't find any documentation on rcu_read_ongoing. Btw the documentation
for urcu in general is scattered all around the repo it seems. It should
have been all at one place imo. Should I make a feature request for it? I
don't know how stuff works inside this repo though.



man. 1. sep. 2025 kl. 17:09 skrev Mathieu Desnoyers <
mathieu.desnoyers@efficios.com>:

> On 2025-08-31 16:48, Thobias Knudsen wrote:
> > BTW i've made a macro library which overrides the
> > urcu and lfht functions. It checks that you call the functions in the
> > correct order. This has been really useful for debugging and I think it
> > would be useful to have it integrated into urcu to make the it more use=
r
> > friendly. you could have it integrated with the macro DEBUG_RCU or make
> > a new one, maybe DEBUG_FUNCTION_CALL_ORDER. The only thing it doesn't
> > catch is if you continue to use data from cds_lfht_lookup() after
> > rcu_read_unlock()
>
> I suspect that what you are trying to achieve is validation that
> calls to functions that require to be within a RCU read-side critical
> section such as cds_lfht_lookup are indeed invoked from within a
> critical section.
>
> We've added a "rcu_read_ongoing()" API for that purpose to liburcu
> RCU flavors, but AFAIK it's not used for any kind of validation
> within cds_lfht. This could indeed become a feature request that
> would apply to all liburcu data structure APIs.
>
> Thanks,
>
> Mathieu
>
> >
> > s=C3=B8n. 31. aug. 2025 kl. 22:42 skrev Thobias Knudsen <thobknu@gmail.=
com
> > <mailto:thobknu@gmail.com>>:
> >
> >     First question: why isn't Userspace RCU more popular?
> >     Second question: Why isn't it possible to create issues in the urcu
> >     repo? Im asking for a feature here:
> >     Is it possible to make a function which checks if there are more
> >     callbacks queued by call_rcu? I need that because there are some
> >     callbacks which call call_rcu, and then calling rcu_barrier once
> >     isn't enough and I therefore need a way to check if there are still
> >     callbacks to wait on before terminating the program. No worries if
> >     this is too much to ask for or if it isn't possible. This
> >     functionality is only needed in termination because otherwise
> >     isn't needed to call rcu_barrier multiple times (at least so far)
> >
> >     Best regards
> >     Thobias
> >
> >
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>

--00000000000013c93f063dd226a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; I suspect that what you are trying to achieve is vali=
dation that<br>&gt; calls to functions that require to be within a RCU read=
-side critical<br>&gt; section such as cds_lfht_lookup are indeed invoked f=
rom within a<br>&gt; critical section.<div><br></div><div>Yes exactly, but =
not only for read sections. It could also be to validate that rcu_barrier i=
snt=C2=A0called within a callback function or that rcu_quiescent_state isnt=
 called when thread is offline</div><div><br>&gt; We&#39;ve added a &quot;r=
cu_read_ongoing()&quot; API for that purpose to liburcu<br>&gt; RCU flavors=
, but AFAIK it&#39;s not used for any kind of validation<br>&gt; within cds=
_lfht. This could indeed become a feature request that<br>&gt; would apply =
to all liburcu data structure APIs.<div><br></div><div>I can&#39;t find any=
 documentation on rcu_read_ongoing. Btw the documentation for urcu in gener=
al is scattered all around the repo it seems. It should have been all at on=
e place imo. Should I make a feature request for it? I don&#39;t know how s=
tuff works inside this repo though.</div><div><br></div><div><br></div></di=
v></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"lt=
r" class=3D"gmail_attr">man. 1. sep. 2025 kl. 17:09 skrev Mathieu Desnoyers=
 &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@ef=
ficios.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 2025-08-31 16:48, Thobias Knudsen wrote:<br>
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

--00000000000013c93f063dd226a3--
