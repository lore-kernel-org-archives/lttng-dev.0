Return-Path: <SRS0=pL6W=ID=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408E0C433DB
	for <lttng-dev@archiver.kernel.org>; Fri,  5 Mar 2021 12:12:00 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FA464FEB
	for <lttng-dev@archiver.kernel.org>; Fri,  5 Mar 2021 12:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FA464FEB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DsRRx1w1YzC9P;
	Fri,  5 Mar 2021 07:11:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1614946317;
	bh=lM++dEQ3npTdIFJvu3TyTeCbXmdgd697ZSmusFHMcWo=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LmeN3zO8qPu2WB7bY7/CJElqo+zG5bt4+2Mhf6xkIGAKd7LsjjbiyRzQuPvADTuSm
	 YtfRZOke64JBUMC8LI6+YT56Td92WT8lXEHLot24V4ryTnQXyFEpVG0AUfrxmOykwo
	 kBU5XL6kGHurus9EORm+9G31jPcya8JJ7hKvLb+4S7JK4D5YR7r82U8GlQks8U3Jyp
	 c9u7JIFrJxBZGJw0qOSGOplfjORk+VL8NV36hAaceCeDk65F5T3tYYEYBPTDj/dHBf
	 RSRSlODW6Cml2W2JzKusuMvtey6N0GUnkFTq69VVsUT1BfghAeHPdQYOkiIsbARX8n
	 sFcL9MfGH0q4w==
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 by lists.lttng.org (Postfix) with ESMTPS id 4DsRRv6ntKzByW
 for <lttng-dev@lists.lttng.org>; Fri,  5 Mar 2021 07:11:55 -0500 (EST)
Received: by mail-yb1-xb30.google.com with SMTP id f4so1664621ybk.11
 for <lttng-dev@lists.lttng.org>; Fri, 05 Mar 2021 04:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IwCNqqthPI1OdveJALabWCw5UKAsGVNjOHo3Zhm5OUc=;
 b=ZykJepntfSzv8fhMR1o3tdsmN4LBfkMqkWBS7tt86WQfirg12DPhBREb3RlXzsQ+QW
 kmkswSAHLRSFNj3Yufkj7U86l+VexS+oCT90auajLhWcaczIvwPByEKhZA7XbKP1GWhD
 uq383Ka2YerJ6AHFa1lCfnLxiOOaLpUJKmgZTCAr65qrIc6Ategbi/OEs7nZxSpcov5p
 J2oZCF+VrDW6bSUwYLA0yR1wyQX+WI4pNLRzdyRxauVIXlqnyLm4LfPgjV2WL6C8SAcZ
 9T9PHMFhn9Zyoby2aVPxx0b2G3NWhw8NnVYYNozhSOmrz3YsrTxRKaBMX6opbGygyJEa
 O+zQ==
X-Gm-Message-State: AOAM530vaIwzFapaViDITMs4OX1H0+BVhIM0N7kscmR7DfKsYhtgnYr4
 Yw8qdfMwN0g5a/vs5MBf2RXAKbX2Z+kgw5Rk578=
X-Google-Smtp-Source: ABdhPJzPWcnOKpX5qh0luDgebZwjgWdPbGOwgQ2AeB7MkfAdS8dtT6jBm7tPinS2iqHxf8NF8kCzHv/giaT+zaTZhbw=
X-Received: by 2002:a25:344f:: with SMTP id b76mr13324480yba.398.1614946315320; 
 Fri, 05 Mar 2021 04:11:55 -0800 (PST)
MIME-Version: 1.0
References: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2B92@EXDAG0-B1.intra.cea.fr>
In-Reply-To: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2B92@EXDAG0-B1.intra.cea.fr>
Date: Fri, 5 Mar 2021 07:11:44 -0500
Message-ID: <CAB4xu_38oAbOD606ZQCp71oJ8qwYOt7F1Ssmpk=idhhTM7to6w@mail.gmail.com>
To: RADERMACHER Ansgar <Ansgar.RADERMACHER@cea.fr>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [barectf] How to ensure that last events before a
 crash get recorded
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Content-Type: multipart/mixed; boundary="===============2518550462175213452=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2518550462175213452==
Content-Type: multipart/alternative; boundary="00000000000074c02b05bcc8fd8e"

--00000000000074c02b05bcc8fd8e
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 4, 2021 at 10:28 RADERMACHER Ansgar via lttng-dev <
lttng-dev@lists.lttng.org> wrote:

> Hi,
>
> when doing tracing with barectf, the trace elements are written into a
> buffer first and only written when the buffer is full - or if the function
> barectf_platform_fs_fini gets called.
> In case of a crash, it's therefore possible to loose some events. What is
> the best option to prevent this issue? I've used signal handlers that call
> the function barectf_platform_fs_fini. This seems to work well with Linux,
> but is not portable. When using the provided sample platform, there is also
> the option to reduce the buffer size, but this is not ideal, as trace
> events that are too big for the buffer are not written.
>

First question: why are you using barectf on Linux vs LTTng?

LTTng supports writing the sub-buffers to NVRAM and, if the system crashes,
convert those sub-buffers to a CTF trace with the lttng-crash utility. See <
https://lttng.org/docs/v2.12/#doc-persistent-memory-file-systems>.

With NVRAM, you could do this with barectf with a corresponding platform
using it. It's always up to the platform author to decide where buffers are
and where complete packets go; it's not a feature of barectf as such.

Hope it helps,

Phil


> Best regards
>
> Ansgar
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
-- 
Philippe Proulx

--00000000000074c02b05bcc8fd8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>On Thu, Mar 4, 2021 at 10:28 RADERMACHER Ansgar via lttng-dev &lt;<a h=
ref=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>&gt; =
wrote:<br></div><div><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">




<div>
<div style=3D"direction:ltr;font-family:Tahoma;font-size:10pt;color:rgb(0,0=
,0)">
<div style=3D"font-family:Tahoma">Hi,</div>
<div style=3D"font-family:Tahoma"><br>
</div>
<div style=3D"font-family:Tahoma">when doing tracing with barectf, the trac=
e elements are written into a buffer first and only written when the buffer=
 is full - or if the function barectf_platform_fs_fini gets called.</div>
<div style=3D"font-family:Tahoma">In case of a crash, it&#39;s therefore po=
ssible to loose some events. What is the best option to prevent this issue?=
 I&#39;ve used signal handlers that call the function barectf_platform_fs_f=
ini. This seems to work well with Linux, but is not portable. When using
 the provided sample platform, there is also the option to reduce the buffe=
r size, but this is not ideal, as trace events that are too big for the buf=
fer are not written.</div></div></div></blockquote><div dir=3D"auto"><br></=
div><div dir=3D"auto">First question: why are you using barectf on Linux vs=
 LTTng?</div><div dir=3D"auto"><br></div><div dir=3D"auto">LTTng supports w=
riting the sub-buffers to NVRAM and, if the system crashes, convert those s=
ub-buffers to a CTF trace with the lttng-crash utility. See &lt;<div dir=3D=
"auto"><a href=3D"https://lttng.org/docs/v2.12/#doc-persistent-memory-file-=
systems">https://lttng.org/docs/v2.12/#doc-persistent-memory-file-systems</=
a>&gt;.</div><div dir=3D"auto"><br></div><div dir=3D"auto">With NVRAM, you =
could do this with barectf with a corresponding platform using it. It&#39;s=
 always up to the platform author to decide where buffers are and where com=
plete packets go; it&#39;s not a feature of barectf as such.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Hope it helps,</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Phil</div></div><div dir=3D"auto"><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb=
(204,204,204)"><div><div style=3D"direction:ltr;font-family:Tahoma;font-siz=
e:10pt;color:rgb(0,0,0)"><div style=3D"font-family:Tahoma" dir=3D"auto"></d=
iv>
<div style=3D"font-family:Tahoma"><br>
</div>
<div style=3D"font-family:Tahoma">Best regards</div>
<div style=3D"font-family:Tahoma"><br>
</div>
<div style=3D"font-family:Tahoma">Ansgar<br>
</div>
<div style=3D"font-family:Tahoma"><br>
</div>
<div style=3D"font-family:Tahoma"><br>
</div>
</div>
</div>

_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
</blockquote></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" =
data-smartmail=3D"gmail_signature">Philippe Proulx</div>

--00000000000074c02b05bcc8fd8e--

--===============2518550462175213452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2518550462175213452==--
