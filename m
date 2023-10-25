Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C33C0032E
	for <lttng-dev@archiver.kernel.org>; Wed, 25 Oct 2023 08:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1698224061;
	bh=zabZ2Nc7qGSNZrxt7kxAwS0OkM0FqJhnAZcUppK6S4U=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=G3SJwcXLV6BIc4fKjGzQMq0g30zymQe1fTm8VbKtVjjNzuvKT8qMf2JZmiJcoTgfo
	 O//rasyNQz3bSJlCKrbfQm7qVZqsp2DO789pOUmbTLpCVgjXBOkj7ds1OPddn0mTJf
	 2ponSZ+w08OgaV7SSBc3spQOQ/jvefp/yU7XPpcOoQkTEA8KuIzRPllg/+w8E0k6nW
	 /frwv59Y9kF7toFxfezYEM/vw9ZgBest4UxEIS3ZsKCuWNwm5PiDGnB3s6JkD1HTcR
	 MXse9XrF17HkqdG1FYVzF97Qt9vYe+qHZSaCGTmHaw8w9mA0ZKsiyV16qOxziPgQmy
	 s/vJ+hKAhFgrA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SFjR10HLkz8L3;
	Wed, 25 Oct 2023 04:54:21 -0400 (EDT)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by lists.lttng.org (Postfix) with ESMTPS id 4SFjQz28YDz8L2
 for <lttng-dev@lists.lttng.org>; Wed, 25 Oct 2023 04:54:19 -0400 (EDT)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1dd5b98d9aeso335092fac.0
 for <lttng-dev@lists.lttng.org>; Wed, 25 Oct 2023 01:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698224058; x=1698828858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pw0+W+Gtu6wfaM8X0H5BlT57/h6KMJx0TkIkMeZzcVA=;
 b=A89MQtIuTRAObzF+hp88QCEgglnvHtGmZEpp9QUWboI7WyH9AXEpDwipJKRuxoMA0L
 NaqOGoJg3HTrUO4N+x37wgv1mY0mMF1CwVMSfXEyjNuxCFuECTyMllhvz3yJQBnKd+Ak
 TcsvBFLkpprGJMrz4R43tHOPDyqh/CkYqHOmxWQE3knAhATeBf2j0ipCY/CNDpN9YE+V
 smTKhjEDepvuCzJr9FE643JJ/BLwPBy9vVF8FfEF2T5C9Mia2rOTti6yWM9Zy/G9r8yn
 Pu0eLXTa7z1my9sx1dVyvNU91QbZf77DdGTuneL9TRA+v5lEcMPTKDUdsyn3g4CmSEvz
 PwQQ==
X-Gm-Message-State: AOJu0YwyPz4sf1tyTNVaOCS9MWvwuHgd+jw4jOscootLCLdm8iaQkxsJ
 g1lMJ6F2TlrrueKa5OyMwGPD8GHSfQ/80Bn0clA=
X-Google-Smtp-Source: AGHT+IE235jsTpK2olt3a7z47VU+ZDkAF43lXRks44L+nPY0wWvQVuC30qnh3l9wsfqAbbVxhLXZFsM6iNW3eDecXmo=
X-Received: by 2002:a05:6870:13c6:b0:1e9:b5d7:4000 with SMTP id
 6-20020a05687013c600b001e9b5d74000mr7549131oat.7.1698224058186; Wed, 25 Oct
 2023 01:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <CALBKf8Jv-QRwbZ0ATdPzj1KyzDQT6SqG9G_4-5-QfG35iJyetQ@mail.gmail.com>
 <2eaa5b1f-c3b2-4790-bf45-dadb66f45d48@efficios.com>
 <CALBKf8JtZKGe5i9S0=zcU_7Qj8b_Z_FkbLv+hqcDf1BbBnZF7w@mail.gmail.com>
 <f59560b2-550f-4423-8428-5116fb1c6ad8@efficios.com>
In-Reply-To: <f59560b2-550f-4423-8428-5116fb1c6ad8@efficios.com>
Date: Wed, 25 Oct 2023 10:54:07 +0200
Message-ID: <CALBKf8JHM1xDf9L3m+4p-2eNQ2s6yGJw0fxWpv_U3f2uDoFJEQ@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Can't receive a lot of functions that i registerd
 as trace-points
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
From: Lin ArcX via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Lin ArcX <linarcx@gmail.com>
Content-Type: multipart/mixed; boundary="===============2274719005726193942=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2274719005726193942==
Content-Type: multipart/alternative; boundary="000000000000bcd76b0608869934"

--000000000000bcd76b0608869934
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Oct 2023 at 21:56, Kienan Stewart <kstewart@efficios.com> wrote:

> Hi Lin,
>
> could you keep the lttng-dev list in CC on your replies in the future?
>
Yes, sure.

>
>
> On 2023-10-24 09:25, Lin ArcX wrote:
> > Thanks for your response. i fixed the names. here is new commands:
> > # enable event for traced functions
> > sudo lttng enable-event --kernel
> irq_handler_entry,napi_poll,net_dev_queue
> >
> > # different name with kernel
> > sudo lttng enable-event --kernel
> >
> net_if_rx_entry,net_if_rx_ni_entry,net_napi_gro_receive_entry,net_if_receive_skb_list_entry,net_if_receive_skb
> >
> > Now In new tracefile i can see a lot of new events come. but still can't
> > see any trace from these:
> >
> > net_if_rx_ni_entry
> > net_napi_gro_receive_entry
> > net_if_receive_skb_list_entry
> >
> This looks fine to me.
>
> On a linux 4.19 system, I ran a test with using lttng-modules 2.12.14. I
> saw events for "net_napi_gro_receive_entry".
>
> In parallel with the LTTng tracing session, I ran
>
>    perf stat -e
>
> net:netif_rx_ni_entry,net:netif_receive_skb_list_entry,net:napi_gro_receive_entry
>
> The above allowed me to confirm that there were
> "net:napi_gro_receive_entry_events", but no "net:netif_rx_ni_entry" or
> "net:netif_receive_skb_list_entry" occurrences in my test.
>
> Are you seeing a situation where another tool is recording occurrences
> of the events that you think aren't being seen during your tracing session?
>

No, nothing, I'm running my client/server application inside wsl and no
other tools are running.

>
> thanks,
> kienan
>

--000000000000bcd76b0608869934
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, 24 Oct 2023 at 21:56, Kienan =
Stewart &lt;<a href=3D"mailto:kstewart@efficios.com">kstewart@efficios.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i Lin,<br>
<br>
could you keep the lttng-dev list in CC on your replies in the future?<br><=
/blockquote><div>Yes, sure.=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
<br>
On 2023-10-24 09:25, Lin ArcX wrote:<br>
&gt; Thanks for your response. i fixed the names. here is new commands:<br>
&gt; # enable event for traced functions<br>
&gt; sudo lttng enable-event --kernel irq_handler_entry,napi_poll,net_dev_q=
ueue<br>
&gt; <br>
&gt; # different name with kernel<br>
&gt; sudo lttng enable-event --kernel <br>
&gt; net_if_rx_entry,net_if_rx_ni_entry,net_napi_gro_receive_entry,net_if_r=
eceive_skb_list_entry,net_if_receive_skb<br>
&gt; <br>
&gt; Now In new tracefile=C2=A0i can see a lot of new events come. but stil=
l can&#39;t <br>
&gt; see any trace from these:<br>
&gt; <br>
&gt; net_if_rx_ni_entry<br>
&gt; net_napi_gro_receive_entry<br>
&gt; net_if_receive_skb_list_entry<br>
&gt; <br>
This looks fine to me.<br>
<br>
On a linux 4.19 system, I ran a test with using lttng-modules 2.12.14. I <b=
r>
saw events for &quot;net_napi_gro_receive_entry&quot;.<br>
<br>
In parallel with the LTTng tracing session, I ran<br>
<br>
=C2=A0 =C2=A0perf stat -e <br>
net:netif_rx_ni_entry,net:netif_receive_skb_list_entry,net:napi_gro_receive=
_entry<br>
<br>
The above allowed me to confirm that there were <br>
&quot;net:napi_gro_receive_entry_events&quot;, but no &quot;net:netif_rx_ni=
_entry&quot; or <br>
&quot;net:netif_receive_skb_list_entry&quot; occurrences in my test.<br>
<br>
Are you seeing a situation where another tool is recording occurrences <br>
of the events that you think aren&#39;t being seen during your tracing sess=
ion?<br></blockquote><div><br></div><div>No, nothing, I&#39;m running my cl=
ient/server application inside wsl and no other tools are running.=C2=A0=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks,<br>
kienan<br>
</blockquote></div></div>

--000000000000bcd76b0608869934--

--===============2274719005726193942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2274719005726193942==--
