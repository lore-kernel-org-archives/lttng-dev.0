Return-Path: <SRS0=8mMP=GN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350E8C433E0
	for <lttng-dev@archiver.kernel.org>; Sun, 10 Jan 2021 17:39:58 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2D72242A
	for <lttng-dev@archiver.kernel.org>; Sun, 10 Jan 2021 17:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2D72242A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DDPHH17qQzPWx;
	Sun, 10 Jan 2021 12:39:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610300395;
	bh=ucAfVb1Yv1i5gNG6nLi1KUQK3RFONn5GWeyTW6a/Ti8=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MwbvVugUKDwSAiVwbhEuT51GzPxS19ZXhZF0uJkdLyndI95OcP16gOgtakAwC7373
	 JmTvXhoLA/4s4pO1xFxIH+n589ZKxDaseFwcDsRG4xYS9s8ht0ZX/Sw9Eu9vLqKluE
	 rRCNPf1vvr2xPm6eWf9H1LvA58FocfzxsfiDg7tebZWe7V00wg9eJrZTM5eCG9YiFD
	 pHORLtUkQClDz5h8JMmT/XOWUOuFKn7bGYC0oTEB0flNsrn04INQNFrxrCc3TcH3qE
	 qLbBVoMAkPzFpNNRgLWaoXIou/KKZ7Zt4PoUJEHr5tumAXPCbxPCdj08AcaxcS8+T8
	 Gjp4Yy9JcQojA==
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by lists.lttng.org (Postfix) with ESMTPS id 4DChXt44WZzPHV
 for <lttng-dev@lists.lttng.org>; Sat,  9 Jan 2021 09:04:14 -0500 (EST)
Received: by mail-lf1-x129.google.com with SMTP id m12so29900787lfo.7
 for <lttng-dev@lists.lttng.org>; Sat, 09 Jan 2021 06:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=agcIj/ty18VT7xI95SA3Rhjm7SZvCs2fsguZkiJuEbc=;
 b=pRNzmEslLFiHye2WOVUjFdi7qvLUZAv4hSvIFwaWKqDjsA2qfuHfHzHLJr/4isKmC4
 ldd7qlBBneDRXjgW86WjPxsekv6R1qs/w7axOua/YeG3uUm0Q2Od0+YDR7H2U7i4Ms3f
 Ao+NL+ovXw2vk6XRk0jP4ewWS8fMQegybhRQBF8Qcx3jBBQFJ0ejf6wosKF6lu94K9Or
 V8tQ2Eui7S3RfggEsljH9A9BIqnnNsAdsZImeLYs7j95mhOW3Zti48HMntkYHXX85/pW
 OMciFPtDmy5Fbfceu4NxJs0Z0RtBBKBOJDdMKmkDGtQ4cLHAA98ny/zmrVJHvy7iZ1Zs
 Tz/g==
X-Gm-Message-State: AOAM533xqMFCIBzv+vgdZDSoIAj6fXTy8ThVwWxjhQiJGb5BMQWcX1+y
 89v7COD21xCSNZ+Pf6GB+4gRL4WXr0nUG2QTgrjhAw==
X-Google-Smtp-Source: ABdhPJy/00VUNUpoYf97yEsLcplrguOTce0GG45GtSdl25IHjpfgWJ5bKKZEvCjzBvfF7IjV2gALLNQqykdue0ETEVc=
X-Received: by 2002:a19:8983:: with SMTP id l125mr3512580lfd.274.1610201052862; 
 Sat, 09 Jan 2021 06:04:12 -0800 (PST)
MIME-Version: 1.0
References: <CAK7B4KePHyJFCwAczqcqz+05Ts8AVm0Xh9f4hwSBKaVhQLz8cw@mail.gmail.com>
 <977d5fa1-ff33-f99e-5be9-7c53ff6adfc4@efficios.com>
In-Reply-To: <977d5fa1-ff33-f99e-5be9-7c53ff6adfc4@efficios.com>
Date: Sat, 9 Jan 2021 08:03:36 -0600
Message-ID: <CAK7B4KfwwC6UbuBTzJSqTHiyuDxgjAPRryYYq7vLRJSWs=2W0g@mail.gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org, Yan Chen <ychen@northwestern.edu>, 
 Xutong Chen <XutongChen2021@u.northwestern.edu>
X-Mailman-Approved-At: Sun, 10 Jan 2021 12:39:53 -0500
Subject: Re: [lttng-dev] LTTng Support for Mount Namespace
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mohammad Kavousi via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mohammad Kavousi <kavousi@u.northwestern.edu>
Content-Type: multipart/mixed; boundary="===============2517178485380939911=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2517178485380939911==
Content-Type: multipart/alternative; boundary="000000000000c5ef8105b8782528"

--000000000000c5ef8105b8782528
Content-Type: text/plain; charset="UTF-8"

Michael,

Thank you for your swift response. However, for the first part, I'm not
sure what it means by "using" the full kernel source. How would I use it
with lttng-modules?

As for the quick hack part, I grabbed the kernel source and copied the
mount.h onto the folder you mentioned, and it did not help. I don't expect
lttng to automatically find that file and use it; also there are no other
header files in the package build directory. Could you kindly give us more
instructions?

Thanks,
Mohammad

On Wed, Jan 6, 2021 at 11:02 AM Michael Jeanson <mjeanson@efficios.com>
wrote:

> On 2021-01-06 10 h 50, Mohammad Kavousi via lttng-dev wrote:
> > Dear LTTng developers,
> >
> > Our group at Northwestern has been using your amazing tool for the
> > purpose of provenance tracking on Linux-based systems and we are very
> > fond of the performance and accuracy it provides.
> >
> > Our analysis shows that mnt_ns context is supported in the 2.12 version
> > of LTTng. However, though, adding the mnt_ns context using
> > the add-context command produces this error:
> >
> > Error: mnt_ns: Context unavailable on this kernel
> >
> > We have tried adding the context to the more recent version of the
> > kernel (5.8) on Ubuntu 20.04, as well as older kernel versions such as
> > the 4.4 version on Ubuntu 16.04. However, we always receive the above
> > error trying to add the mnt_ns context.
> >
> > We could not find which kernel versions are supported for adding this
> > context, or whether they need to be built with special flags. I would
> > appreciate your guidance on resolving this issue.
> >
> >
> > Thank you,
> > Mohammad
>
> Hi,
>
> Unfortunately the definition of 'struct mnt_namespace' is in a private
> kernel header (fs/mount.h) unlike other namespaces.  Private headers are
> not included in the kernel headers package of distributions like Ubuntu,
> to build support for this namespace context in lttng-modules you need to
> use the full kernel source tree.
>
> Or as a quick hack, you could copy 'fs/mount.h' from the original source
> tree to your kernel headers package build directory, which on Ubuntu is
> usually '/lib/modules/$(uname -r)/build'.
>
> Hoe this helps,
>
> Michael
>

--000000000000c5ef8105b8782528
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Michael,<div><br></div><div>Thank you for your swift respo=
nse. However, for the first part, I&#39;m not sure what it means by &quot;u=
sing&quot; the full kernel source. How would I use it with lttng-modules?</=
div><div><br></div><div>As for the quick hack part, I grabbed the kernel so=
urce and copied the mount.h onto the folder you mentioned, and it did not h=
elp. I don&#39;t expect lttng to automatically find that file and use it; a=
lso there are no other header files in the package build directory. Could y=
ou kindly give us more instructions?</div><div><br></div><div>Thanks,</div>=
<div>Mohammad</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Wed, Jan 6, 2021 at 11:02 AM Michael Jeanson &lt;<a h=
ref=3D"mailto:mjeanson@efficios.com">mjeanson@efficios.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2021-01-06 10 =
h 50, Mohammad Kavousi via lttng-dev wrote:<br>
&gt; Dear LTTng developers,<br>
&gt; <br>
&gt; Our group at Northwestern has been using your amazing tool for the <br=
>
&gt; purpose of provenance tracking on Linux-based systems and we are very =
<br>
&gt; fond of the performance and accuracy it provides.<br>
&gt; <br>
&gt; Our analysis shows that mnt_ns context is supported in the 2.12 versio=
n <br>
&gt; of LTTng. However, though, adding the mnt_ns context using <br>
&gt; the=C2=A0add-context command produces this error:<br>
&gt; <br>
&gt; Error: mnt_ns: Context unavailable on this kernel<br>
&gt; <br>
&gt; We have tried adding the context to the more recent version of the <br=
>
&gt; kernel (5.8) on Ubuntu 20.04, as well as older kernel versions such as=
 <br>
&gt; the 4.4 version on Ubuntu 16.04. However, we always receive the above =
<br>
&gt; error trying to add the mnt_ns context.<br>
&gt; <br>
&gt; We could not find which kernel versions are supported for adding this =
<br>
&gt; context, or whether they need to be built with special flags. I would =
<br>
&gt; appreciate your guidance on resolving this issue.<br>
&gt; <br>
&gt; <br>
&gt; Thank you,<br>
&gt; Mohammad<br>
<br>
Hi,<br>
<br>
Unfortunately the definition of &#39;struct mnt_namespace&#39; is in a priv=
ate <br>
kernel header (fs/mount.h) unlike other namespaces.=C2=A0 Private headers a=
re <br>
not included in the kernel headers package of distributions like Ubuntu, <b=
r>
to build support for this namespace context in lttng-modules you need to <b=
r>
use the full kernel source tree.<br>
<br>
Or as a quick hack, you could copy &#39;fs/mount.h&#39; from the original s=
ource <br>
tree to your kernel headers package build directory, which on Ubuntu is <br=
>
usually &#39;/lib/modules/$(uname -r)/build&#39;.<br>
<br>
Hoe this helps,<br>
<br>
Michael<br>
</blockquote></div>

--000000000000c5ef8105b8782528--

--===============2517178485380939911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2517178485380939911==--
