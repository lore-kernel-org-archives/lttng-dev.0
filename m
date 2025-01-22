Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65457C02181
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Jan 2025 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1737551347;
	bh=VH6E1PzhbTNtaZlayGw/wEda9i7heQxUFs/9W6kwlDk=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ttft9Kt3hp8dm8ayjdL35CiTnBvLh5mLByN+DMF5P1hDxMKqISJ3pLukWJ4y9dM8v
	 GPCFU2kgHdWGnEs7+a1Eyf89WW4MaWeCLk76NdHJZCXpdLAFzzUyq0d7KdfVbLA6MV
	 Hw+/UobKALqLuNhcM8G/GiwEFoDk4HZebjgogyyOpvY08CpAOc5ETsZdYSAYDE2wx4
	 ONkeDwp2A8VThFMQWrOSf4SpQhFSaE6KwH5XPsOr5psBGNJrfrfiHO6FAShqDGzq0l
	 YdG+ruX/qIoyPOFqoKBtbzsRDxqnavJ43Y26gYtG1eZTURV3SzsGvl+aaPgTOOnx9s
	 5arkPbqPl7Wvg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YdPXy60h8z161B;
	Wed, 22 Jan 2025 08:09:06 -0500 (EST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 by lists.lttng.org (Postfix) with ESMTPS id 4YdPXx0klXz1614
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jan 2025 08:09:04 -0500 (EST)
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6dd1b895541so72394586d6.0
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jan 2025 05:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737551344; x=1738156144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OfLP1hEnuk1c+VgAMoV0NQfyReN47YkPXZ4n6MBYqcY=;
 b=vUHR3KNvnrRMSPOHLhwm58dqIA9+ncXz7fo5e/kLrt6lTuShh1HeuW0FOzxEfMw3fz
 ZCAx2Pcz6l4WjqHW3UnZs7NNhoDzajHXaqk9nWVI5BavlnkI4f7LkAdFPhFT7JEVQ8Nn
 eaOkRoPIZCAdrkVVGPUlCT1DffTKgvdbsNbZ0z8xbTkcqOxp7aBFhwEwgBtHK5DHZdts
 RKK4EAvCNMFrAEN4SmmciM+HpdA6a5fy83ZFiJcr9ZaHycko52ciB0wiobjB/AMEZdKC
 RQJTxE28MGv0KLEfhmSPYwHPl1/t0zbk5jtIEqBGqhwKnkq5VpopoeMsxmzOtbe6pkY8
 XR6A==
X-Gm-Message-State: AOJu0YzAxj1EH31NRMWANdSFfGjvb54eMjDqeTmya/2aTO9VCHs8qWIb
 1PsLDX9chN+bU8TW4P88chJo2B/FMBv7i0w4zLllDguFgQt0ZGejrIBP5U6au1uwbPo/IuNL78t
 IyQ4I9qbabs6aSqIG/whh+9V0G/IbiWGkmEs4LmF5WCu/drC2
X-Gm-Gg: ASbGncsR2trQWsqOZVYNF3+6JYbYDjKENPsb4mIgtqg5/vHNk0kQ8mIwgqfq06Nk0EE
 0GfNZA8+OpGGHKmq0FwfFoibIQxh2a6mgu7CgchpNyHfGhPXoUJfy
X-Google-Smtp-Source: AGHT+IHRlq8f99uODNegXBPgsQNIsdx1uoPBhVkvaWtr50gdaWHczvb3gKE3nqn+m759bdvdRebXBMS7g0R4KkKC8zY=
X-Received: by 2002:a05:6214:1c4a:b0:6dd:d513:6124 with SMTP id
 6a1803df08f44-6e1b220a540mr338668406d6.35.1737551343926; Wed, 22 Jan 2025
 05:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20250115142300.vlupsqd2lr5bipfo@martin-pc>
 <7127ac1b-7cc5-4f98-afe8-1244c3a5056b@efficios.com>
In-Reply-To: <7127ac1b-7cc5-4f98-afe8-1244c3a5056b@efficios.com>
Date: Wed, 22 Jan 2025 08:08:52 -0500
X-Gm-Features: AWEUYZmfCuNfnGzVwY2gu8pw1c_sLtLNjb_vaYKqKXKKwQes6lV0mC_pasMUviU
Message-ID: <CAMkvodY-8K-hRb-cHbjJWqmvXDM65x9xuiqJxiaWfFO2_7O9Gw@mail.gmail.com>
Subject: Re: [PATCH] lttng-modules fix for RHEL 9.5 kernels
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="000000000000a281cb062c4b322e"
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
From: Martin Hicks via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Martin Hicks <martin@sr-research.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000a281cb062c4b322e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 2:56=E2=80=AFPM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> On 2025-01-15 09:23, Martin Hicks via lttng-dev wrote:
> >
> > This fixes the asoc_snd_*, kfree_skb and udp related tracepoints for th=
e
> > RHEL 9.5 distro kernel.
> >
> > In all cases they've updated to the format of newer kernels.
>
> I notice that this patch appears to be based on stable-2.13 rather
> than the master branch.
>
> I will apply it to master and forward port it to master, as the
> cherry-pick seems trivial, but ideally please submit patches
> against the master branch of lttng-modules in the future.
>

Ah, you're right.  I'll do that in the future.  Sorry about that.
mh

--=20
Martin Hicks
SR Research Ltd.
Fast, Accurate, Reliable Eye Tracking

--000000000000a281cb062c4b322e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 21,=
 2025 at 2:56=E2=80=AFPM Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.de=
snoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On 2025-01-15 09:23, Ma=
rtin Hicks via lttng-dev wrote:<br>
&gt; <br>
&gt; This fixes the asoc_snd_*, kfree_skb and udp related tracepoints for t=
he<br>
&gt; RHEL 9.5 distro kernel.<br>
&gt; <br>
&gt; In all cases they&#39;ve updated to the format of newer kernels.<br>
<br>
I notice that this patch appears to be based on stable-2.13 rather<br>
than the master branch.<br>
<br>
I will apply it to master and forward port it to master, as the<br>
cherry-pick seems trivial, but ideally please submit patches<br>
against the master branch of lttng-modules in the future.<br>
</blockquote></div><div><br></div><div>Ah, you&#39;re right.=C2=A0 I&#39;ll=
 do that in the future.=C2=A0 Sorry about that.</div><div>mh<br clear=3D"al=
l"></div><br><span class=3D"gmail_signature_prefix">-- </span><br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Martin Hicks</div>=
<div>SR Research Ltd.</div><div>Fast, Accurate, Reliable Eye Tracking</div>=
</div></div></div>

--000000000000a281cb062c4b322e--
